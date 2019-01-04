Return-Path: <SRS0=et4D=PM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28935C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jan 2019 10:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA31220874
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jan 2019 10:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWynInKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfADKYl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:24:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADKYk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jan 2019 05:24:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so17321175pgk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jan 2019 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+ntR3Ku+rEIjTKLI8nz2mlgePoIr/xEO8bg5Zhtf70=;
        b=tWynInKvFm8shcNmW0PbqI8IoiAE0yu/E9EdjX994Pe5HI4WVikVHS6bKzS2Giw1ME
         IfKoPT8/HSFsJbsb1aD6X68HcEAsZf4JBFAxXn1n/68g5MkuuqeItV+n1sdml9brm4fX
         aWkASNRfPEb71hD1Jfj9+ljKDY0cgGHmUoBCo/uZbOUcSQp6jB2xbsviBVi4tfM80UHB
         X5BqQKi9LoO/uO2Xmknvzv/k+KtF6vCJv9kkEirgQZBmlk8duusKMMVnRb5Ot7YS/4R/
         SCDfKAuLZvqM0nmai7i3lWjgC/ViP2HB9b7CswyzqWkfecy4ChxMiezgcZqJ7l+IVHSM
         Y9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+ntR3Ku+rEIjTKLI8nz2mlgePoIr/xEO8bg5Zhtf70=;
        b=htINFrq6nAQhznUocX74npf8/oOhlIN3WpPvnM5FPcoHHhHMvm1eDGOynW6ZAyk3Kg
         fUaJX9Z6TFhG/T+jgdLH0bPlR4syihigQa9WOxJv2URKYdAjmSWSQ8B4ysyt2EkDiY2Q
         7uzZ3IRtMWvjU6Tvz8eXx4sG65jTh4XKjwNf+1AlqE/acafiK/x2MXsbuO76T6KTX6SM
         YBQ0PBye6NtjdoLH0D1srvKCr9tzGPX0hS7wW5UGf26toyWpjhBTnPZr11EW+BmJLX/D
         OT2k8y3+DBqNvQOOGWE6+zEXr6z2HWvaUuVVwEMrWIobDnU1+WzwLPNA4JFzMXv1mwhN
         vUrw==
X-Gm-Message-State: AA+aEWYnFJMZINXig1NxwcgcfNNnZQgUJN0JqRQOhCkiGWYJJ1GKdkNC
        0DZ5LwRKLCZBsYMYBQI1sjXMawvhOZEvKkhfIlwEAek1
X-Google-Smtp-Source: ALg8bN622UdIs2Vm56S5cP3Oh6J/+zC5yrEY/iq8IScZw4HK0lNw6Pk18FeIrrSOk8rGENCfjLL+CL4QdoOX43esuak=
X-Received: by 2002:a62:5444:: with SMTP id i65mr53471747pfb.193.1546597479821;
 Fri, 04 Jan 2019 02:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20180316221221.130478-1-marcel@holtmann.org>
In-Reply-To: <20180316221221.130478-1-marcel@holtmann.org>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Fri, 4 Jan 2019 11:24:29 +0100
Message-ID: <CAO1O6scQR_3t28DPUQsY-yONc1JMVaFHZejgGAK2kv-vHY=Qtw@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Add new serdev based driver for 3-Wire attached controllers
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,
a few questions below

Den fre 16 mars 2018 kl 23:13 skrev Marcel Holtmann <marcel@holtmann.org>:
>
> This is a from scratch written driver to run H:5 aka 3-Wire on serdev based
> system with a Bluetooth controller attached via an UART. It is currently
> tested on RPi3. It works only without Broadcom integration and that means
> firmware loading is not supported. It is easy to add, but in that case
> some packet errors happen that are not yet debugged.
>
> It does support data integrity check, but it does not actually support
> the sliding window. It is currently limit to 1 packet and on the
> receiver side there is no packet loss detection.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> +static void bt3wire_tx_work(struct work_struct *work)
> +{
> +       struct bt3wire_dev *bdev = container_of(work, struct bt3wire_dev,
> +                                              tx_work);
> +       struct serdev_device *serdev = bdev->serdev;
> +       struct hci_dev *hdev = bdev->hdev;
> +
> +       while (1) {
> +               clear_bit(BT3WIRE_TX_STATE_WAKEUP, &bdev->tx_state);
> +
> +               while (1) {
> +                       struct sk_buff *skb = skb_dequeue(&bdev->tx_queue);
> +                       int len;
> +
> +                       if (!skb)
> +                               break;
> +
> +                       len = serdev_device_write_buf(serdev, skb->data,
> +                                                     skb->len);
> +                       hdev->stat.byte_tx += len;
> +
> +                       skb_pull(skb, len);
> +                       if (skb->len > 0) {
> +                               skb_queue_head(&bdev->tx_queue, skb);
> +                               break;
> +                       }
> +
> +                       kfree_skb(skb);
> +               }
> +
> +               if (!test_bit(BT3WIRE_TX_STATE_WAKEUP, &bdev->tx_state))
> +                       break;
> +       }
> +
> +       clear_bit(BT3WIRE_TX_STATE_ACTIVE, &bdev->tx_state);
> +}
> +
> +static int bt3wire_tx_wakeup(struct bt3wire_dev *bdev)
> +{
> +       if (test_and_set_bit(BT3WIRE_TX_STATE_ACTIVE, &bdev->tx_state)) {
> +               set_bit(BT3WIRE_TX_STATE_WAKEUP, &bdev->tx_state);
> +               return 0;
> +       }
> +
> +       schedule_work(&bdev->tx_work);
> +       return 0;
> +}
> +
> +static int bt3wire_open(struct hci_dev *hdev)
> +{
> +       struct bt3wire_dev *bdev = hci_get_drvdata(hdev);
> +       int err;
> +
> +       bdev->tx_seq = 0;
> +       bdev->tx_ack = 0;
> +
> +       bdev->rx_slip_state = SLIP_WAIT_DELIM;
> +       bdev->rx_skb = NULL;
> +
> +       err = serdev_device_open(bdev->serdev);
> +       if (err) {
> +               bt_dev_err(hdev, "Unable to open UART device %s",
> +                          dev_name(&bdev->serdev->dev));
> +               return err;
> +       }
> +
> +       serdev_device_set_baudrate(bdev->serdev, 115200);
> +
> +       bdev->link_state = LINK_UNINITIALIZED;
> +       schedule_delayed_work(&bdev->link_timer, 0);
> +
> +       if (!wait_event_interruptible_timeout(bdev->link_wait,
> +                                             bdev->link_state == LINK_ACTIVE,
> +                                             LINK_ACTIVATION_TIMEOUT)) {
> +               bt_dev_err(hdev, "Link activation timeout");
> +               err = -ETIMEDOUT;
> +
> +               cancel_delayed_work_sync(&bdev->link_timer);
> +               serdev_device_close(bdev->serdev);
> +       } else {
> +               bt_dev_info(hdev, "Link activation successful");
> +               err = 0;
> +       }
> +
> +       return err;
> +}
> +
> +static int bt3wire_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct bt3wire_dev *bdev = hci_get_drvdata(hdev);
> +
> +       switch (hci_skb_pkt_type(skb)) {
> +       case HCI_COMMAND_PKT:
> +               hdev->stat.cmd_tx++;
> +               break;
> +       case HCI_ACLDATA_PKT:
> +               hdev->stat.acl_tx++;
> +               break;
> +       case HCI_SCODATA_PKT:
> +               hdev->stat.sco_tx++;
> +               break;
> +       }
> +
> +       bt3wire_queue_pkt(bdev, hci_skb_pkt_type(skb), skb->data, skb->len);
> +       kfree_skb(skb);
> +
> +       bt3wire_tx_wakeup(bdev);
> +       return 0;
> +}
> +
> +static void bt3wire_write_wakeup(struct serdev_device *serdev)
> +{
> +       struct bt3wire_dev *bdev = serdev_device_get_drvdata(serdev);
> +
> +       bt3wire_tx_wakeup(bdev);
> +}
> +

Any specific reason this draft as well as
https://patchwork.kernel.org/patch/10490651/ uses its own code above
for tx work, send frame, set baud rate etc. when there seems to be a
common lib for such things in hci_serdev.c?

I'm also wondering about having the tx work in a separate
workqueue/thread. Wouldn't it be better (fewer context switches) if
the serdev_device_write_buf call was done from the same threads that
1. put the message in the queue and 2. the serdev wake-up callback
(protected by some lock)? It seems serdev_device_write_buf is async
and shouldn't block if I'm correct.
In the current code (whose logic seems to be used by many drivers) I
see a potential race condition if there is a context switch just
before the line "clear_bit(BT3WIRE_TX_STATE_ACTIVE,
&bdev->tx_state);", then another thread calls bt3wire_tx_wakeup, then
the tx work will never run (unless a new packet is enqueued).

About the baud rate, would it be a good idea to control that via a
device tree parameter?

/Emil
