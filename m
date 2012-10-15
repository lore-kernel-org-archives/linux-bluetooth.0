Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACKG3XmHwTgbsWBwsckZ-tA5M9xBD0TBRme7mCJo7shd90L4=Q@mail.gmail.com>
References: <CACKG3XmHwTgbsWBwsckZ-tA5M9xBD0TBRme7mCJo7shd90L4=Q@mail.gmail.com>
Date: Mon, 15 Oct 2012 23:01:48 +0800
Message-ID: <CACKG3X=Jky7m=gU7b=rPYOO1ZqQR_79fgoL-EQCYgog6wNZsLQ@mail.gmail.com>
Subject: Is it incorrect in checking of "NO_RESET" bit in hci_core.c:hci_dev_do_close()?
From: chen kris <bluefrog2012@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

static int hci_dev_do_close(struct hci_dev *hdev)
{
    ...

    /* Reset device */
    skb_queue_purge(&hdev->cmd_q);
    atomic_set(&hdev->cmd_cnt, 1);
    if (!test_bit(HCI_RAW, &hdev->flags) &&
                test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
        set_bit(HCI_INIT, &hdev->flags);
        __hci_request(hdev, hci_reset_req, 0,
                    msecs_to_jiffies(250));
        clear_bit(HCI_INIT, &hdev->flags);
    }
    ...
}

I guess the condition should be as following:

    if (!test_bit(HCI_RAW, &hdev->flags) &&
                *! *test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks))

it means the code should sent HCI_RESET, only if both of the following
conditions are met:
1. HCI_RAW is NOT set;
2. HCI_QUIRK_NO_RESET is *NOT* set.

thanks!

Bluefrog2012
