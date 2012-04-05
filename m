Return-Path: <cyrus@holtmann.org>
Message-ID: <1333654479.16897.17.camel@aeonflux>
Subject: Re: question on timestamps generated with "hcidump -t"
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Apr 2012 12:34:39 -0700
In-Reply-To: <201204052100.17893.oliver@neukum.org>
References: <201204052100.17893.oliver@neukum.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> could somebody enlighten me, when exactly those timestamps are generated?

they are normally stamped when they enter our internal queues. So the
Bluetooth core stamps them when they come from the driver.

/* Receive frame from HCI drivers */
int hci_recv_frame(struct sk_buff *skb)
{
        struct hci_dev *hdev = (struct hci_dev *) skb->dev;
        if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
                                && !test_bit(HCI_INIT, &hdev->flags))) {
                kfree_skb(skb);
                return -ENXIO;
        }

        /* Incomming skb */
        bt_cb(skb)->incoming = 1;

        /* Time stamp */
        __net_timestamp(skb);

        skb_queue_tail(&hdev->rx_q, skb);
        queue_work(hdev->workqueue, &hdev->rx_work);

        return 0;
}

Regards

Marcel


