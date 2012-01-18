Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACJA=fX_TTf+1ecuY_31xRRHsBQFOMhX=zaDi1=4cQcYYmJCpQ@mail.gmail.com>
References: <1326890884-16678-1-git-send-email-ulisses@profusion.mobi>
	<1326890884-16678-2-git-send-email-ulisses@profusion.mobi>
	<CACJA=fX_TTf+1ecuY_31xRRHsBQFOMhX=zaDi1=4cQcYYmJCpQ@mail.gmail.com>
Date: Wed, 18 Jan 2012 17:40:15 -0200
Message-ID: <CAA37ikZRPfucbQZSMB+rdgDnBz4MnkrD1k=Kb4Dk+1RAvJ=DmQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Remove wait for delayed work to finish
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Jan 18, 2012 at 5:34 PM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> Hi Ulisses,
>
> On Wed, Jan 18, 2012 at 9:48 AM, Ulisses Furquim <ulisses@profusion.mobi> wrote:
>> Do not wait for delayed work to finish where it's not needed. In the
>> case of adv_work the handler is already protected by the hdev lock
>> and removing the wait we also avoid introducing deadlocks involving
>> the delayed work lock.
>>
>> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
>> ---
>>  net/bluetooth/hci_core.c  |    2 +-
>>  net/bluetooth/hci_event.c |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index a7b7200..b4041be 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1731,7 +1731,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>>
>>        hci_del_sysfs(hdev);
>>
>> -       cancel_delayed_work_sync(&hdev->adv_work);
>> +       cancel_delayed_work(&hdev->adv_work);
>
> I'm afraid we'll introduce a race condition if we don't use the
> _sync variant at hci_unregister_dev.
>
> If we don't wait adv_work finish it may be running after hdev
> object is freed.

Indeed, you're right. And I was going through the uses of _sync() and
skipped those in paths where we free the object but didn't see this
one.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
