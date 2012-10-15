Return-Path: <cyrus@holtmann.org>
Message-ID: <1350324127.26318.0.camel@aeonflux>
Subject: Re: Is it incorrect in checking of "NO_RESET" bit in
 hci_core.c:hci_dev_do_close()?
From: Marcel Holtmann <marcel@holtmann.org>
To: chen kris <bluefrog2012@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 15 Oct 2012 20:02:07 +0200
In-Reply-To: <CACKG3X=Jky7m=gU7b=rPYOO1ZqQR_79fgoL-EQCYgog6wNZsLQ@mail.gmail.com>
References: <CACKG3XmHwTgbsWBwsckZ-tA5M9xBD0TBRme7mCJo7shd90L4=Q@mail.gmail.com>
	 <CACKG3X=Jky7m=gU7b=rPYOO1ZqQR_79fgoL-EQCYgog6wNZsLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

> static int hci_dev_do_close(struct hci_dev *hdev)
> {
>     ...
> 
>     /* Reset device */
>     skb_queue_purge(&hdev->cmd_q);
>     atomic_set(&hdev->cmd_cnt, 1);
>     if (!test_bit(HCI_RAW, &hdev->flags) &&
>                 test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
>         set_bit(HCI_INIT, &hdev->flags);
>         __hci_request(hdev, hci_reset_req, 0,
>                     msecs_to_jiffies(250));
>         clear_bit(HCI_INIT, &hdev->flags);
>     }
>     ...
> }
> 
> I guess the condition should be as following:
> 
>     if (!test_bit(HCI_RAW, &hdev->flags) &&
>                 *! *test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks))
> 
> it means the code should sent HCI_RESET, only if both of the following
> conditions are met:
> 1. HCI_RAW is NOT set;
> 2. HCI_QUIRK_NO_RESET is *NOT* set.

the name is confusing, when closing the device and NO_RESET is set, then
it needs to send the HCI Reset.

Regards

Marcel


