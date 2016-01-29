Return-Path: <jjmeijer88@gmail.com>
MIME-Version: 1.0
In-Reply-To: <FD3D2636-B096-45F8-A4E2-4E48B2293F42@holtmann.org>
References: <1453391122-25226-1-git-send-email-jjmeijer88@gmail.com> <FD3D2636-B096-45F8-A4E2-4E48B2293F42@holtmann.org>
From: Jaap Jan Meijer <jjmeijer88@gmail.com>
Date: Fri, 29 Jan 2016 13:03:31 +0100
Message-ID: <CAA+NYvRQtZAUVVdbo_pD7p7-qbrNywZUncbCT4gHkFuwnCMghA@mail.gmail.com>
Subject: Re: [PATCH] Add missing ACPI ID for bcm43241, used in HP Omni10
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for the feedback. I'm still learning while i go, will give it another go.

Another thing, I encountered lists like this:
driveridentifier.com/scan/broadcom-serial-bus-driver-over-uart-bus-enumerator/driver-detail/262C118A233E4B45BC8EB76D27B63F9A/1811458/md5/1583152406/ACPI%5CBCM2E54
so I guess a lot of people are still missing out on the fruits of you
and your teams hard work. I can create a patch to get the complete
list in if you want.

Kind regards,

J.J.


2016-01-22 14:42 GMT+01:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
> please provide a commit message. You need subject line and commit message body. Make it more verbose on which machine this is enabling. If you have ACPI debug output or other information, please include it as well.
>
>> On Jan 21, 2016, at 16:45, J.J. Meijer <jjmeijer88@gmail.com> wrote:
>>
>> From: meijjaa <jjmeijer88@gmail.com>
>>
>> Signed-off-by: meijjaa <jjmeijer88@gmail.com>
>
> You might want to fix your .gitconfig to have proper name and email information in your commits.
>
>> ---
>> drivers/bluetooth/hci_bcm.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 4797c5c..48dbf51 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -820,6 +820,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
>>       { "BCM2E3D", 0 },
>>       { "BCM2E3F", 0 },
>>       { "BCM2E40", 0 },
>> +     { "BCM2E54", 0 },
>>       { "BCM2E64", 0 },
>>       { "BCM2E65", 0 },
>>       { "BCM2E67", 0 },
>
> I was not able to apply the patch. Please make sure it is against bluetooth-next tree.
>
> Regards
>
> Marcel
>
