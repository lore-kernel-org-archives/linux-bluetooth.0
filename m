Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1350324127.26318.0.camel@aeonflux>
References: <CACKG3XmHwTgbsWBwsckZ-tA5M9xBD0TBRme7mCJo7shd90L4=Q@mail.gmail.com>
	<CACKG3X=Jky7m=gU7b=rPYOO1ZqQR_79fgoL-EQCYgog6wNZsLQ@mail.gmail.com>
	<1350324127.26318.0.camel@aeonflux>
Date: Mon, 15 Oct 2012 15:09:59 -0300
Message-ID: <CAJdJm_MfoNrSt62tiGr9+hae8zEVucex9rCY8zk+e7mNGkzHQg@mail.gmail.com>
Subject: Re: Is it incorrect in checking of "NO_RESET" bit in hci_core.c:hci_dev_do_close()?
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: chen kris <bluefrog2012@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 15, 2012 at 3:02 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Chen,
>
>> static int hci_dev_do_close(struct hci_dev *hdev)
>> {
>>     ...
>>
>>     /* Reset device */
>>     skb_queue_purge(&hdev->cmd_q);
>>     atomic_set(&hdev->cmd_cnt, 1);
>>     if (!test_bit(HCI_RAW, &hdev->flags) &&
>>                 test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
>>         set_bit(HCI_INIT, &hdev->flags);
>>         __hci_request(hdev, hci_reset_req, 0,
>>                     msecs_to_jiffies(250));
>>         clear_bit(HCI_INIT, &hdev->flags);
>>     }
>>     ...
>> }
>>
>> I guess the condition should be as following:
>>
>>     if (!test_bit(HCI_RAW, &hdev->flags) &&
>>                 *! *test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks))
>>
>> it means the code should sent HCI_RESET, only if both of the following
>> conditions are met:
>> 1. HCI_RAW is NOT set;
>> 2. HCI_QUIRK_NO_RESET is *NOT* set.
>
> the name is confusing, when closing the device and NO_RESET is set, then
> it needs to send the HCI Reset.

I was almost sure this flag has been renamed to something like
"HCI_QUIRK_RESET_ON_CLOSE" on recent kernels?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
