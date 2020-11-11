Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC557C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 14:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8A82074B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 14:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oye/pQNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKKOOi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 09:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgKKOOd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 09:14:33 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216EBC0613D1;
        Wed, 11 Nov 2020 06:14:33 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id dj6so936638qvb.3;
        Wed, 11 Nov 2020 06:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+uOO1jG6R6/kmtXI81fJp8TFDMqWgjiBfjiGKiiaI+k=;
        b=Oye/pQNbGK8s347l0OM9EuuqNiNFlxLHIVrKHS05RdEZQ9PGSaR9vw+fgkh7yUeoao
         GtQr++RHGME5XvkvNqq9hVDn2iT6IUMAFAr4g9fQYjed5Q0MhM8aQPJalYVAfye+X1oL
         n6j8zeuUUCS2K12TfEZxxIdyPYBuitCCbwYH5hHP0tARzXRcqTipxB4ZrS4dIKcLcJio
         ESXTUpQFvLK+xMlNdZ67UDGAjpJDWOrFiQYTdE8sL7QXhkYwFhBFs3msMf6tS+rQleaP
         HJJO3ITSMtOmSJVUDuVRmpGXqQqrxMng8RyfRK872XvDrSBelNAivbBhfPbLt0J5T19N
         idmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+uOO1jG6R6/kmtXI81fJp8TFDMqWgjiBfjiGKiiaI+k=;
        b=LYXZg1rgON2X+zdwlSGar9+5ln0qEAGs5RtCgm4EhsHd/QbQjvZpFB8eBnKKhnRWpp
         WXaBpR00myiDKn4EQSuplm3nB9YEUJNlIKiiOaxWU1TiwsCy/clCQNL+02SA1njCbENE
         3SYrXjGrL+isC6ZWXQBgXmd7ip6W3KKUNUenizcrk1RULGM9rBCYYy2pToqNxC+LcmeU
         hfUDGRoO95E63NxcyjYZDFJoLjwsLm7UPkypaVW2wDl3zC4lCQ3oWqD/fjD2IO19+WKy
         61F8j1C9CVneHFrHHbidfo8MOAmRjtFMupPooxhdSx87ptK8jBECqqdkuixGKQjGBJk2
         i/xg==
X-Gm-Message-State: AOAM530kZvTo6CBQ2nZlLfSwHeMRSTpjF4ev4dO5JFAIS4YM9gLWnXpU
        JQUoYcF9wrOTqiYvhbgh/SYwlPncCxa0NYHTcNs=
X-Google-Smtp-Source: ABdhPJz7bSEACiPKTiuodSTNM19EZ7bMCoGaphBKa/uqbrmvVhhkGH7C0cZF/xycSHQ6CoSCiYpKGw==
X-Received: by 2002:ad4:4142:: with SMTP id z2mr12177814qvp.48.1605104072162;
        Wed, 11 Nov 2020 06:14:32 -0800 (PST)
Received: from fedora-project (cpe-68-173-33-86.nyc.res.rr.com. [68.173.33.86])
        by smtp.gmail.com with ESMTPSA id 199sm2103332qkm.62.2020.11.11.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 06:14:31 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:14:29 -0500
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, kernel-janitors@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH][v2] Bluetooth: hci_qca: resolve various warnings
Message-ID: <20201111141429.GA3821@fedora-project>
References: <20201111045538.GA90261@fedora-project>
 <187b1016-06cf-9f6c-eeac-4bac8c970d58@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <187b1016-06cf-9f6c-eeac-4bac8c970d58@wanadoo.fr>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 11, 2020 at 11:47:48AM +0100, Christophe JAILLET wrote:
> Le 11/11/2020 à 05:55, Nigel Christian a écrit :
> > Replace symbolic permissions with octal values. Use usleep_range
> > for small msec values due to the fact that msleep() less than
> > 20ms may have unexpected behavior/sleep longer.
> > 
> > - https://lkml.org/lkml/2016/8/2/1945
> > - Documentation/timers/timers-howto.rst
> > 
> > Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
> > ---
> >   drivers/bluetooth/hci_qca.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 2d3f1f179a1e..039fb117bd8f 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -631,7 +631,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
> >   	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
> >   	/* read only */
> > -	mode = S_IRUGO;
> > +	mode = 0444;
> >   	debugfs_create_u8("tx_ibs_state", mode, ibs_dir, &qca->tx_ibs_state);
> >   	debugfs_create_u8("rx_ibs_state", mode, ibs_dir, &qca->rx_ibs_state);
> >   	debugfs_create_u64("ibs_sent_sleeps", mode, ibs_dir,
> > @@ -658,7 +658,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
> >   	debugfs_create_u32("vote_off_ms", mode, ibs_dir, &qca->vote_off_ms);
> >   	/* read/write */
> > -	mode = S_IRUGO | S_IWUSR;
> > +	mode = 0644;
> >   	debugfs_create_u32("wake_retrans", mode, ibs_dir, &qca->wake_retrans);
> >   	debugfs_create_u32("tx_idle_delay", mode, ibs_dir,
> >   			   &qca->tx_idle_delay);
> > @@ -1302,7 +1302,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
> >   	/* Give the controller time to process the request */
> >   	if (qca_is_wcn399x(qca_soc_type(hu)))
> > -		msleep(10);
> > +		usleep_range(1000, 10000);
> This...
> >   	else
> >   		msleep(300);
> > @@ -1350,7 +1350,7 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
> >   	if (on)
> >   		msleep(100);
> >   	else
> > -		msleep(10);
> > +		usleep_range(1000, 10000);
> and this change change a delay which is expected to be 10 ms, and will
> likely be ~20 ms, into a delay which can be down to 1 ms.
> Is it intended or tested?
> 
> I've not looked at the datasheet, but it looks spurious.
> 
> Just my 2c.
> 
> CJ
> 
> >   	return 0;
> >   }
> > 
> 

I see, so usleep_range(10000, 11000) so that the 10ms minimum is maintained
closer to the intended delay? Testing with info below:

Pixel 3a bluetooth tether
TOZO-T10-R bluetooth earbuds

Fedora 33
Kernel version = 5.10.0-rc3-next-20201110
System         = ASUSTeK COMPUTER INC. 1.0        UX330UAK
BIOS           = UX330UAK.302
Boot mode      = UEFI
CPU model      = Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz

dmesg -t -k > 

Bluetooth: Core ver 2.22
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Bluetooth: hci0: Firmware revision 0.0 build 10 week 41 2018
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11


