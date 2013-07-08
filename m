Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCUN8L_iVyPmXchmunoKwxt72KR7ZYhbQYtCBwUpxSWbJQ@mail.gmail.com>
References: <1373033022-11180-1-git-send-email-luiz.dentz@gmail.com>
	<CANT-zCUN8L_iVyPmXchmunoKwxt72KR7ZYhbQYtCBwUpxSWbJQ@mail.gmail.com>
Date: Mon, 8 Jul 2013 15:50:09 +0300
Message-ID: <CABBYNZ+Ab=rPfE5HaW1c3+n=wEF3=x2UQ2_+-JPwSvXgbTcYBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/service: Make sure service is disconnected
 before shutdown
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Jul 8, 2013 at 2:46 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, Jul 5, 2013 at 4:03 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This ensures that the service is disconnected before setting the state
>> to unavailable.
>> ---
>>  src/service.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/src/service.c b/src/service.c
>> index 83e1c1a..dce5c05 100644
>> --- a/src/service.c
>> +++ b/src/service.c
>> @@ -170,6 +170,7 @@ int service_probe(struct btd_service *service)
>>
>>  void service_shutdown(struct btd_service *service)
>>  {
>> +       btd_service_disconnect(service);
>>         change_state(service, BTD_SERVICE_STATE_UNAVAILABLE, 0);
>>         service->profile->device_remove(service);
>>         service->device = NULL;
>> --
>> 1.8.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> I'm not a big fan of this approach. The service should already be
> disconnected by the time it's shut down, so this additional transition
> should not be needed.

Im not following then, why do you call it shutdown then? If just to
free data this should have been service_remove or something like that.

> Having a look at the current code paths leading to service_shutdown(),
> one tricky case I can think of is the call to
> device_remove_profiles(), specially from search_cb(). I have my doubts
> whether a service shutdown makes sense if it's connected, but in case
> yes, I'd add the disconnection code to device_remove_profiles().

It depends on whether we want a clean disconnect or a link loss, IMO
if the driver gets a .disconnect callback it should disconnect
properly while .device_remove it basically frees private data but if
we are connected this most likely will cause an abrupt disconnect in
most drivers.

> Or do you have some other examples where the disconnection is not triggered?

All our shutdown related API, including g_io_channel_shutdown,
normally do disconnect as well.

> Adding one more side effect to service_shutdown() is IMO undesirable,
> where the transitional DISCONNECTED state would be artificially
> introduced. Think about an external profile being unregistered while
> connected devices exist: not only calling
> Profile.RequestDisconnection() doesn't make any sense, but a
> transition such as STATE_CONNECTED->STATE_UNAVAILABLE is probably what
> you want to observe. This can be different from a graceful
> disconnection, and a policy module could use this distinction to
> reconnect the service once the external profile gets registered.

While I agree that could be useful for tracking thinks like link loss
this would be initiated by the profile/service themselves somehow not
by device_remove code path that should never trigger any link loss
policy, it is a cleanup path btw so nothing should be pending after
that so your argument actually works against having this type of
transition from connected directly to unavailable.

--
Luiz Augusto von Dentz
