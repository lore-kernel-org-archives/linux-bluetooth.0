Return-Path: <pgynther@google.com>
MIME-Version: 1.0
In-Reply-To: <6843E05B-32FC-47C1-B34A-75D87C969E37@holtmann.org>
References: <1455134446-70401-1-git-send-email-pgynther@google.com>
	<D8912AC0-4457-468D-B65C-2A1D8F03ACD7@holtmann.org>
	<6843E05B-32FC-47C1-B34A-75D87C969E37@holtmann.org>
Date: Fri, 19 Feb 2016 17:40:24 -0800
Message-ID: <CAGXr9JHQpyJyHeFc9r4CG0meGu_S+qSECfwn3Lkc0AHLo_UefQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btbcm: Fix handling of firmware not found
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 19, 2016 at 5:16 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Petri,
>
>>> If the call to request_firmware() fails in btbcm_setup_patchram(),
>>> the BCM chip will be operating with its default firmware.
>>>
>>> In this case, btbcm_setup_patchram() should not return immediately
>>> but instead should skip to btbcm_check_bdaddr() and quirk setup.
>>>
>>> Signed-off-by: Petri Gynther <pgynther@google.com>
>>> ---
>>> drivers/bluetooth/btbcm.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>>> index 0b69794..7d82b1a 100644
>>> --- a/drivers/bluetooth/btbcm.c
>>> +++ b/drivers/bluetooth/btbcm.c
>>> @@ -467,7 +467,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
>>>      err = request_firmware(&fw, fw_name, &hdev->dev);
>>>      if (err < 0) {
>>>              BT_INFO("%s: BCM: Patch %s not found", hdev->name, fw_name);
>>> -            return 0;
>>> +            goto check_bdaddr;
>>>      }
>>>
>>>      btbcm_patchram(hdev, fw);
>>> @@ -501,6 +501,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
>>>      BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
>>>      kfree_skb(skb);
>>>
>>> +check_bdaddr:
>>
>> lets just call this label "done". I think using check_bdaddr might be a bit of misleading labeling here. Since we actually want it to run all success test including the duplicate filter setting.
>
> actually I just did an inline edit of the patch to change the label name and applied the patch. There is really no point in you wasting time to respin it.
>
> Regards
>
> Marcel
>

The patch applied to bluetooth-next looks good. Thanks.
