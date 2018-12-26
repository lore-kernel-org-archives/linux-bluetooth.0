Return-Path: <SRS0=4Cvn=PD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C81C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Dec 2018 22:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678A9214AE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Dec 2018 22:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YuDdIYf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeLZWVw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:21:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43838 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLZWVv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Dec 2018 17:21:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so7995892pgk.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Dec 2018 14:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYgeWOOoGd8JvjYprKpFmkvLe+djZEt49mfZcBYzTnI=;
        b=YuDdIYf6oAwVNVMRPyuOk98K8XnQAhqPDqCn9YLYVH0trj8BcZ9za0Mbeq4pxaMxD/
         nTMWe8gGNW0bnYnZIwvpt1uER+4o8tnGXEt3v8BvPJ7+O+6RTyxT6uPNz1NkA5NSl+4Q
         5hGjm16qlYUe775FlbUAUnsm0oq2TPZbAZ8ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYgeWOOoGd8JvjYprKpFmkvLe+djZEt49mfZcBYzTnI=;
        b=QB4amLta3SsMxKKlyJSNrLSaXq4Ay/A2FhaqGDPKOuKBYH/N/mFm3r2vtk/AEdtuek
         gLg9EsM92t+H7fcQV6eTwtBN4LgG2wmUfmILAPp5IW0Zmjm72P+XlA1gngOKd2DOfRGO
         6s9Q9H+YgRaVPnqIEKTHcysP//CUUC2n60/R56ZDDSjpByf54ZLbE5xDUKWe2ta4Qibf
         hsoBow5nXAbgtVXZN2Y77tqcLjmteDJCBnzkQz0x+jwcgMVyVXOk3e4QcD7bpjk5Uvd9
         S5m31sg1yJRhWVpDvd+S45OACwmAn1kg9F3cXOX9Xx6pBbsIDIZ8Suji+HJJL7h8TQou
         RWAg==
X-Gm-Message-State: AA+aEWZFwYZF73QAQaVGUiD5I1f7LbE/cfnAcknbsCMmR1U/iOOo+OaN
        +S4k5AzRDUBjxAP0yh7gwIz/sA==
X-Google-Smtp-Source: AFSGD/W+MKYK8Vt0XrqlcrBWaa2Cl5tNMm8QnfYBFUoCPGzoohgLn7u2v7sRbkRhRTqm/oYjGHWv1Q==
X-Received: by 2002:a62:cd44:: with SMTP id o65mr21686069pfg.222.1545862910818;
        Wed, 26 Dec 2018 14:21:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id m11sm48862970pgh.51.2018.12.26.14.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 14:21:49 -0800 (PST)
Date:   Wed, 26 Dec 2018 14:21:48 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181226222148.GI261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-2-bgodavar@codeaurora.org>
 <20181222015947.GF261387@google.com>
 <379c7c10d70ad86e03122d051ce0cf6f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <379c7c10d70ad86e03122d051ce0cf6f@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Dec 26, 2018 at 12:01:51PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-12-22 07:29, Matthias Kaehlcke wrote:
> > On Thu, Dec 20, 2018 at 08:16:35PM +0530, Balakrishna Godavarthi wrote:
> > > wcn3990 requires a power pulse to turn ON/OFF along with
> > > regulators. Sometimes we are observing the power pulses are sent
> > > out with some time delay, due to queuing these commands. This is
> > > causing synchronization issues with chip, which intern delay the
> > > chip setup or may end up with communication issues.
> > > 
> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 38
> > > ++++++++++++++-----------------------
> > >  1 file changed, 14 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index f036c8f98ea3..5a07c2370289 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct
> > > hci_uart *hu, unsigned int speed)
> > >  		hci_uart_set_baudrate(hu, speed);
> > >  }
> > > 
> > > -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> > > +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
> > >  {
> > > -	struct hci_uart *hu = hci_get_drvdata(hdev);
> > > -	struct qca_data *qca = hu->priv;
> > > -	struct sk_buff *skb;
> > > +	int ret;
> > > 
> > >  	/* These power pulses are single byte command which are sent
> > >  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> > > @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct
> > > hci_dev *hdev, u8 cmd)
> > >  	 * save power. Disabling hardware flow control is mandatory while
> > >  	 * sending power pulses to SoC.
> > >  	 */
> > > -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> > > -
> > > -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> > > -	if (!skb)
> > > -		return -ENOMEM;
> > > -
> > > +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
> > >  	hci_uart_set_flow_control(hu, true);
> > > +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> > > +	if (ret < 0) {
> > > +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
> > > +			   cmd);
> > > +		return ret;
> > > +	}
> > > 
> > > -	skb_put_u8(skb, cmd);
> > > -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> > > -
> > > -	skb_queue_tail(&qca->txq, skb);
> > > -	hci_uart_tx_wakeup(hu);
> > > +	serdev_device_wait_until_sent(hu->serdev, 0);
> > 
> > serdev_device_wait_until_sent() might only guarantee that the UART
> > circular buffer is empty (see
> > https://elixir.bootlin.com/linux/v4.19/source/drivers/tty/tty_ioctl.c#L225),
> > not that the data has actually sent (e.g. it might be sitting in
> > the UART FIFO). However with this:
> > 
> > >  	/* Wait for 100 uS for SoC to settle down */
> > >  	usleep_range(100, 200);
> > 
> > we should probably be fine, unless there's tons of data in the
> > FIFO.
> > 
> > You currently call serdev_device_write_flush() in
> > qca_power_shutdown(), I wonder if it would make sense to call it in
> > qca_send_power_pulse(), regardless of whether it's an on or off
> 
> [Bala]: during sending the ON pulse we will not have any data in the
>         UART circular buffer as this is the first command to send and we are
> sending it as soon as we open the port.
>         so i taught why should be flush the circular as it is already empty.

> > pulse. In any case we don't care if the chip receives any 'pending'
> > data when we switch it on or off, right?
> > 
> 
> [Bala]: during on we freshly open port and i see that flush() called while
> port opening.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/serial_core.c#L207

I would argue that the serdev_device_write_flush() call in
qca_power_shutdown() is related with/needed for sending the power off
pulse, hence it should be part of qca_send_power_pulse(), unless it
adds a significant overhead and we really want to call it only in the
shutdown case.

Flushing the buffer should be fairly lightweight and power pulses are
only sent when the device is switched on or off, so the overhead
should be negligible. You *could* restrict the flush to the power off
pulse, assuming that the driver always re-opens the port in
qca_wcn3990_init() (tests with this patch set suggest this might not
be needed) and that serdev_device_open() flushes the buffer (which
seems a sane assumption). Yet given the minimal overhead I'd suggest
to not make assumptions about what happened previously in other code
and avoid the clutter of a condition that doesn't add much value.

Cheers

Matthias
