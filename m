Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111130172428.GA9425@samus>
References: <1320241924-2300-1-git-send-email-luiz.dentz@gmail.com>
	<1320241924-2300-4-git-send-email-luiz.dentz@gmail.com>
	<20111130172428.GA9425@samus>
Date: Thu, 1 Dec 2011 09:23:09 +0200
Message-ID: <CABBYNZKod-HNwzuFhoLRUQc66uJkEQL-u7NCknPAjbtvOMorgw@mail.gmail.com>
Subject: Re: [PATCH 4/4] Bluetooth: use buffer priority to mark URB_ISO_ASAP flag
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Nov 30, 2011 at 7:24 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi,
>
> On 15:52 Wed 02 Nov, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> ---
>>  drivers/bluetooth/btusb.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index abfc4ee..9db2476 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -727,6 +727,9 @@ static int btusb_send_frame(struct sk_buff *skb)
>>               usb_fill_bulk_urb(urb, data->udev, pipe,
>>                               skb->data, skb->len, btusb_tx_complete, skb);
>>
>> +             if (skb->priority >= HCI_PRIO_MAX - 1)
>> +                     urb->transfer_flags  = URB_ISO_ASAP;
>> +
>
> In case someone is having problems:
>
> With CONFIG_USB_DEBUG enabled the check that the URB_ISO_ASAP flag is
> not valid for bulk endpoints is enabled, and that urb is rejected.

Hmm, you are right URB_ISO_ASAP is not meant for bulk so usb_submit_urb drop it:

 	/* fail if submitter gave bogus flags */
	if (urb->transfer_flags != orig_flags) {
		dev_err(&dev->dev, "BOGUS urb flags, %x --> %x\n",
			orig_flags, urb->transfer_flags);
		return -EINVAL;
	}

So we better remove asap.

-- 
Luiz Augusto von Dentz
