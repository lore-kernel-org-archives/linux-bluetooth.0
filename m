Return-Path: <chethantn@gmail.com>
MIME-Version: 1.0
In-Reply-To: <45FE6D00-AF3A-4110-A0A6-B021590A8AAF@holtmann.org>
References: <1534844080-31240-1-git-send-email-raghuram.hegde@intel.com>
 <1534844080-31240-2-git-send-email-raghuram.hegde@intel.com> <45FE6D00-AF3A-4110-A0A6-B021590A8AAF@holtmann.org>
From: chethan tn <chethantn@gmail.com>
Date: Tue, 21 Aug 2018 20:12:05 +0530
Message-ID: <CAMH2TCq4SaDyRwrXBJsrX5fBMJgeNBrHhmmT0t1DzAC=NxvY3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluletooth: Add hardware reset callback to reset
 intel bluetooth chip
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Raghuram Hegde <raghuram.hegde@intel.com>, linux-bluetooth@vger.kernel.org,
	chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com,
	amit.k.bag@intel.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Aug 21, 2018 at 7:44 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Raghuram,
>
> having no commit message is not acceptable. You need to explain what the patch is doing.
Looks like commit message is broken, will resend the patch with proper
commit message.
>
>> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>> Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
>> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
>> ---
>> drivers/bluetooth/btusb.c        | 2 ++
>> include/net/bluetooth/hci_core.h | 1 +
>> 2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index cd2e5cf14ea5..908f8105b3af 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -3083,6 +3083,7 @@ static int btusb_probe(struct usb_interface *intf,
>>               hdev->shutdown = btusb_shutdown_intel;
>>               hdev->set_diag = btintel_set_diag_mfg;
>>               hdev->set_bdaddr = btintel_set_bdaddr;
>> +             hdev->hw_reset = btintel_reset_bt;
>>               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>>               set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>>               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
>> @@ -3095,6 +3096,7 @@ static int btusb_probe(struct usb_interface *intf,
>>               hdev->hw_error = btintel_hw_error;
>>               hdev->set_diag = btintel_set_diag;
>>               hdev->set_bdaddr = btintel_set_bdaddr;
>> +             hdev->hw_reset = btintel_reset_bt;
>>               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>>               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
>>       }
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 0db1b9b428b7..9765ba78be2c 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -427,6 +427,7 @@ struct hci_dev {
>>       int (*post_init)(struct hci_dev *hdev);
>>       int (*set_diag)(struct hci_dev *hdev, bool enable);
>>       int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>> +     void (*hw_reset)(struct hci_dev *hdev, unsigned char code);
>> };
>
> So where is this callback used?
Ideally the callback would be invoked in case any unrecoverable state
of the controller like continuous command timeout, hardware failure on
the controller, exceptions.
>
> Regards
>
> Marcel
>

Thanks and Regards
Chethan
