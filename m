Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C380C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AE32087E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfARKxd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:53:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58085 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfARKxd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 05:53:33 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 25F2FCEE14;
        Fri, 18 Jan 2019 12:01:18 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC] Bluetooth: Add new serdev based driver for 3-Wire attached
 controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAO1O6scQR_3t28DPUQsY-yONc1JMVaFHZejgGAK2kv-vHY=Qtw@mail.gmail.com>
Date:   Fri, 18 Jan 2019 11:53:31 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C749CF9F-2A5C-4C3B-8B9B-71F372C32B1B@holtmann.org>
References: <20180316221221.130478-1-marcel@holtmann.org>
 <CAO1O6scQR_3t28DPUQsY-yONc1JMVaFHZejgGAK2kv-vHY=Qtw@mail.gmail.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

>> This is a from scratch written driver to run H:5 aka 3-Wire on serdev based
>> system with a Bluetooth controller attached via an UART. It is currently
>> tested on RPi3. It works only without Broadcom integration and that means
>> firmware loading is not supported. It is easy to add, but in that case
>> some packet errors happen that are not yet debugged.
>> 
>> It does support data integrity check, but it does not actually support
>> the sliding window. It is currently limit to 1 packet and on the
>> receiver side there is no packet loss detection.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> +static void bt3wire_tx_work(struct work_struct *work)
>> +{
>> +       struct bt3wire_dev *bdev = container_of(work, struct bt3wire_dev,
>> +                                              tx_work);
>> +       struct serdev_device *serdev = bdev->serdev;
>> +       struct hci_dev *hdev = bdev->hdev;
>> +
>> +       while (1) {
>> +               clear_bit(BT3WIRE_TX_STATE_WAKEUP, &bdev->tx_state);
>> +
>> +               while (1) {
>> +                       struct sk_buff *skb = skb_dequeue(&bdev->tx_queue);
>> +                       int len;
>> +
>> +                       if (!skb)
>> +                               break;
>> +
>> +                       len = serdev_device_write_buf(serdev, skb->data,
>> +                                                     skb->len);
>> +                       hdev->stat.byte_tx += len;
>> +
>> +                       skb_pull(skb, len);
>> +                       if (skb->len > 0) {
>> +                               skb_queue_head(&bdev->tx_queue, skb);
>> +                               break;
>> +                       }
>> +
>> +                       kfree_skb(skb);
>> +               }
>> +
>> +               if (!test_bit(BT3WIRE_TX_STATE_WAKEUP, &bdev->tx_state))
>> +                       break;
>> +       }
>> +
>> +       clear_bit(BT3WIRE_TX_STATE_ACTIVE, &bdev->tx_state);
>> +}
>> +
>> +static int bt3wire_tx_wakeup(struct bt3wire_dev *bdev)
>> +{
>> +       if (test_and_set_bit(BT3WIRE_TX_STATE_ACTIVE, &bdev->tx_state)) {
>> +               set_bit(BT3WIRE_TX_STATE_WAKEUP, &bdev->tx_state);
>> +               return 0;
>> +       }
>> +
>> +       schedule_work(&bdev->tx_work);
>> +       return 0;
>> +}
>> +
>> +static int bt3wire_open(struct hci_dev *hdev)
>> +{
>> +       struct bt3wire_dev *bdev = hci_get_drvdata(hdev);
>> +       int err;
>> +
>> +       bdev->tx_seq = 0;
>> +       bdev->tx_ack = 0;
>> +
>> +       bdev->rx_slip_state = SLIP_WAIT_DELIM;
>> +       bdev->rx_skb = NULL;
>> +
>> +       err = serdev_device_open(bdev->serdev);
>> +       if (err) {
>> +               bt_dev_err(hdev, "Unable to open UART device %s",
>> +                          dev_name(&bdev->serdev->dev));
>> +               return err;
>> +       }
>> +
>> +       serdev_device_set_baudrate(bdev->serdev, 115200);
>> +
>> +       bdev->link_state = LINK_UNINITIALIZED;
>> +       schedule_delayed_work(&bdev->link_timer, 0);
>> +
>> +       if (!wait_event_interruptible_timeout(bdev->link_wait,
>> +                                             bdev->link_state == LINK_ACTIVE,
>> +                                             LINK_ACTIVATION_TIMEOUT)) {
>> +               bt_dev_err(hdev, "Link activation timeout");
>> +               err = -ETIMEDOUT;
>> +
>> +               cancel_delayed_work_sync(&bdev->link_timer);
>> +               serdev_device_close(bdev->serdev);
>> +       } else {
>> +               bt_dev_info(hdev, "Link activation successful");
>> +               err = 0;
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +static int bt3wire_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>> +{
>> +       struct bt3wire_dev *bdev = hci_get_drvdata(hdev);
>> +
>> +       switch (hci_skb_pkt_type(skb)) {
>> +       case HCI_COMMAND_PKT:
>> +               hdev->stat.cmd_tx++;
>> +               break;
>> +       case HCI_ACLDATA_PKT:
>> +               hdev->stat.acl_tx++;
>> +               break;
>> +       case HCI_SCODATA_PKT:
>> +               hdev->stat.sco_tx++;
>> +               break;
>> +       }
>> +
>> +       bt3wire_queue_pkt(bdev, hci_skb_pkt_type(skb), skb->data, skb->len);
>> +       kfree_skb(skb);
>> +
>> +       bt3wire_tx_wakeup(bdev);
>> +       return 0;
>> +}
>> +
>> +static void bt3wire_write_wakeup(struct serdev_device *serdev)
>> +{
>> +       struct bt3wire_dev *bdev = serdev_device_get_drvdata(serdev);
>> +
>> +       bt3wire_tx_wakeup(bdev);
>> +}
>> +
> 
> Any specific reason this draft as well as
> https://patchwork.kernel.org/patch/10490651/ uses its own code above
> for tx work, send frame, set baud rate etc. when there seems to be a
> common lib for such things in hci_serdev.c?

we want to deprecate hci_serdev.c and actually not use it. The whole hci_uart driver got pretty convoluted. If we later on find that certain things can be shared, then we address it then, but bt3wire.c and btuart.c should stay clean and not depend on hci_uart.

> I'm also wondering about having the tx work in a separate
> workqueue/thread. Wouldn't it be better (fewer context switches) if
> the serdev_device_write_buf call was done from the same threads that
> 1. put the message in the queue and 2. the serdev wake-up callback
> (protected by some lock)? It seems serdev_device_write_buf is async
> and shouldn't block if I'm correct.
> In the current code (whose logic seems to be used by many drivers) I
> see a potential race condition if there is a context switch just
> before the line "clear_bit(BT3WIRE_TX_STATE_ACTIVE,
> &bdev->tx_state);", then another thread calls bt3wire_tx_wakeup, then
> the tx work will never run (unless a new packet is enqueued).

Feel free to make a proposal and send patches for it. I am happy to get btuart. and bt3wire.c merged upstream so you can improve on it.

> About the baud rate, would it be a good idea to control that via a
> device tree parameter?

Yes, either DT or ACPI.

Regards

Marcel

