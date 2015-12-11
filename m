Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5661A6E3.3040801@felipetonello.com>
References: <1449229003-7193-1-git-send-email-eu@felipetonello.com>
	<1449229003-7193-3-git-send-email-eu@felipetonello.com>
	<CABBYNZLqg11LNfdWLP3eax3YjTmEzH+k+YHs+p10cEbPywD47g@mail.gmail.com>
	<5661A6E3.3040801@felipetonello.com>
Date: Fri, 11 Dec 2015 20:52:48 -0200
Message-ID: <CABBYNZJBiyovwU1u0M+gKDyv1bPdV-Auy9yXTzy5hkU+Eg00fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] core/service: fix connection and disconnection state handling
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Fri, Dec 4, 2015 at 12:44 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Luiz,
>
> On 12/04/2015 01:02 PM, Luiz Augusto von Dentz wrote:
>> Hi Felipe,
>>
>> On Fri, Dec 4, 2015 at 1:36 PM, Felipe F. Tonello <eu@felipetonello.com> wrote:
>>> Service state was not been update correctly if a profile didn't implement
>>> state changes itself. This patch makes sure that states will be always
>>> properly update, even if a profile doesn't implement itself.
>>>
>>> As a side effect, this fix a bug causing a profile's accept function not to be
>>> called on a connection after a disconnection.
>>> ---
>>>  src/service.c | 43 ++++++++++++++++++++++---------------------
>>>  1 file changed, 22 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/src/service.c b/src/service.c
>>> index f7912f5..85694a5 100644
>>> --- a/src/service.c
>>> +++ b/src/service.c
>>> @@ -219,9 +219,6 @@ int btd_service_connect(struct btd_service *service)
>>>         char addr[18];
>>>         int err;
>>>
>>> -       if (!profile->connect)
>>> -               return -ENOTSUP;
>>> -
>>>         switch (service->state) {
>>>         case BTD_SERVICE_STATE_UNAVAILABLE:
>>>                 return -EINVAL;
>>> @@ -235,15 +232,21 @@ int btd_service_connect(struct btd_service *service)
>>>                 return -EBUSY;
>>>         }
>>>
>>> +       change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
>>> +
>>> +       if (!profile->connect) {
>>> +               btd_service_connecting_complete(service, 0);
>>
>> Hmm, I wonder if the will actually work properly since
>> btd_service_connecting_complete will set the state to connected if
>> error is 0 but it is not actually connected. Actually if accept is to
>> be called connect should not be called.
>
> Well, at least on my tests it works fine. How come it is not actually
> connected? This function is called when a connection happens.
>
> Why can't we call both? A profile will not install both callbacks
> anyway. But I think the states should be updated anyway, because that is
> the root cause of all problems here.
>
> The main objective of this patch is to update the states.

Well perhaps we should set connected if accept succeed, or the plugin
has to call btd_service_connecting_complete like when
btd_service_connect is called I guess this makes more sense since the
profile may have to do a few things before it is considered connected
so it would work similarly for both incoming or outgoing connections.

>>
>>> +               return -ENOTSUP;
>>> +       }
>>> +
>>>         err = profile->connect(service);
>>> -       if (err == 0) {
>>> -               change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
>>> -               return 0;
>>> +       if (err < 0) {
>>> +               ba2str(device_get_address(service->device), addr);
>>> +               error("%s profile connect failed for %s: %s", profile->name, addr,
>>> +                     strerror(-err));
>>>         }
>>>
>>> -       ba2str(device_get_address(service->device), addr);
>>> -       error("%s profile connect failed for %s: %s", profile->name, addr,
>>> -                                                               strerror(-err));
>>> +       btd_service_connecting_complete(service, err);
>>>
>>>         return err;
>>>  }
>>> @@ -254,9 +257,6 @@ int btd_service_disconnect(struct btd_service *service)
>>>         char addr[18];
>>>         int err;
>>>
>>> -       if (!profile->disconnect)
>>> -               return -ENOTSUP;
>>> -
>>>         switch (service->state) {
>>>         case BTD_SERVICE_STATE_UNAVAILABLE:
>>>                 return -EINVAL;
>>> @@ -270,18 +270,19 @@ int btd_service_disconnect(struct btd_service *service)
>>>
>>>         change_state(service, BTD_SERVICE_STATE_DISCONNECTING, 0);
>>>
>>> -       err = profile->disconnect(service);
>>> -       if (err == 0)
>>> -               return 0;
>>> -
>>> -       if (err == -ENOTCONN) {
>>> +       if (!profile->disconnect) {
>>>                 btd_service_disconnecting_complete(service, 0);
>>> -               return 0;
>>
>> This I think was actually correct, because if the profile don't
>> implement .disconnect we still can disconnect when ACL is dropped but
>> contrary to connect I think we can return 0 since the state will
>> actually be correct.
>
> Like I mentioned before, the problem was that the state was not been
> updated. It shouldn't be the job for the profile to do it so.
>
> This makes sure that we update the service->state correctly regardless
> of profile's disconnect existence.
>
>>
>>> +               return -ENOTSUP;
>>>         }
>>>
>>> -       ba2str(device_get_address(service->device), addr);
>>> -       error("%s profile disconnect failed for %s: %s", profile->name, addr,
>>> -                                                               strerror(-err));
>>> +       err = profile->disconnect(service);
>>> +       if (err == -ENOTCONN) {
>>> +               err = 0;
>>> +       } else if (err < 0) {
>>> +               ba2str(device_get_address(service->device), addr);
>>> +               error("%s profile disconnect failed for %s: %s", profile->name, addr,
>>> +                     strerror(-err));
>>> +       }
>>>
>>>         btd_service_disconnecting_complete(service, err);
>>>
>
> Felipe



-- 
Luiz Augusto von Dentz
