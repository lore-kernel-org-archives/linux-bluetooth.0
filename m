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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268F1C55ABD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 13:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30EE207D3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 13:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEdHbmII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgKJNZe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgKJNZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 08:25:34 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C13C0613CF;
        Tue, 10 Nov 2020 05:25:33 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id h15so11294625qkl.13;
        Tue, 10 Nov 2020 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=twl+7qtylZP6PbD0rthSYUZGtUSHKtjsRlUxlMYyhdY=;
        b=vEdHbmIIi1SBmJBOe7fRB2J/rhroLWgcYn8r1N9il3mG1ZUaV5XDil2AQ3LfiSic7f
         qNKbrdV12O3pT4Bsyjiu0LuaXYrrAULjOJ2hi8lFKV3k85wDQIVSgqIczauKiUTORbSJ
         Sn/SJ4LU+EPbcVDJHT9KLhfNFdnKmVWEPndWUzKfgz61bAw5ZUDcPErqbeqLnPkDuDjF
         /VWuYFdvFfHyBziZmxka1ty0mo1R5lChz9QPHs1InHRwes1VKtMHo3G+iKpRtwRPGx74
         D7JCSnWVX30kZp6a1hXf8BSHnYu3D0E0SYD8ssC3Qa8sGOY3N6D7l7a6S8YBfGZXIQ1X
         mhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=twl+7qtylZP6PbD0rthSYUZGtUSHKtjsRlUxlMYyhdY=;
        b=eLoKsCsB9wpDOg1sksKp6jOsBM+VnWr3nUX5CqH+3XpzU+h8ieW9w8zsN9Pf7AbkqF
         EmZsN9p3jTFmAVqHzWyZ9atNBkiEjwx/OlsiETHvEKLGHC/Ba63JbkD+f55i82I+TocJ
         AYb33DpYcoHvs68LBfmUcG8v5BgabHLc2WaN1syDGPCFDBv+3Onq0EjzdKAOV9Lg6MPl
         fBUqhoDa4O3PwzkpQYORNjUeIDCesjJxtoAIjQuQgk7ao16D6ntC6Dj0+QKdLAYSpBkG
         rcF0jzc/ckxs8GD/bKumhVLClU3+6yljVFS5wecPtMV5LiAma3VVfMCOScWssDWYVTqt
         0bpA==
X-Gm-Message-State: AOAM530dl2bUXNbSiEcVZav6m2wGo58gm5CBsIJLU/urj9oUAHoQTFRZ
        DkHOSdF6uaClrR3djNg4lEU6TQhvzeTisQ==
X-Google-Smtp-Source: ABdhPJwXh9PsQUAxaWu7X7doCVJVeUuSw8ewXdXO1SDGgMqS7a1Nj/JAucRjjosG62Pit3TOpGmLZg==
X-Received: by 2002:a37:b505:: with SMTP id e5mr12842194qkf.309.1605014733070;
        Tue, 10 Nov 2020 05:25:33 -0800 (PST)
Received: from fedora-project ([212.103.48.60])
        by smtp.gmail.com with ESMTPSA id j19sm6144727qkk.119.2020.11.10.05.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 05:25:32 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:25:28 -0500
From:   Nigel Christian <nigel.l.christian@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     johan.hedberg@gmail.com, kernel-janitors@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: resolve various warnings
Message-ID: <20201110132528.GA5112@fedora-project>
References: <20201101025215.GA4828@fedora-project>
 <BB6BEAED-CFED-4092-AB9A-A98A064676EE@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB6BEAED-CFED-4092-AB9A-A98A064676EE@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Nov 09, 2020 at 01:45:34PM +0100, Marcel Holtmann wrote:
> Hi Nigel,
> 
> > Use template string as opposed to function name. Add a blank
> > line after declaration to improve readability. Replace symbolic
> > permissions with octal values. Use usleep_range for small msec
> > values due to the fact that msleep() less than 20ms may have
> > unexpected behavior/sleep longer. This patch removes all
> > checkpatch warnings.
> > 
> > - https://lkml.org/lkml/2016/8/2/1945
> > - Documentation/timers/timers-howto.rst
> > 
> > Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
> > ---
> > drivers/bluetooth/hci_qca.c | 11 ++++++-----
> > 1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 2d3f1f179a1e..22da59d8f471 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -555,7 +555,7 @@ static int qca_open(struct hci_uart *hu)
> > 	struct qca_serdev *qcadev;
> > 	struct qca_data *qca;
> > 
> > -	BT_DBG("hu %p qca_open", hu);
> > +	BT_DBG("hu %p %s", hu, __func__);
> 
> please clean up your patch before submitting it. This change does not belong
> here.
> 
> > 	if (!hci_uart_has_flow_control(hu))
> > 		return -EOPNOTSUPP;
> > @@ -631,7 +631,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
> > 	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
> > 
> > 	/* read only */
> > -	mode = S_IRUGO;
> > +	mode = 0444;
> > 	debugfs_create_u8("tx_ibs_state", mode, ibs_dir, &qca->tx_ibs_state);
> > 	debugfs_create_u8("rx_ibs_state", mode, ibs_dir, &qca->rx_ibs_state);
> > 	debugfs_create_u64("ibs_sent_sleeps", mode, ibs_dir,
> > @@ -658,7 +658,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
> > 	debugfs_create_u32("vote_off_ms", mode, ibs_dir, &qca->vote_off_ms);
> > 
> > 	/* read/write */
> > -	mode = S_IRUGO | S_IWUSR;
> > +	mode = 0644;
> > 	debugfs_create_u32("wake_retrans", mode, ibs_dir, &qca->wake_retrans);
> > 	debugfs_create_u32("tx_idle_delay", mode, ibs_dir,
> > 			   &qca->tx_idle_delay);
> > @@ -1215,6 +1215,7 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
> > 				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
> > 	if (IS_ERR(qca->rx_skb)) {
> > 		int err = PTR_ERR(qca->rx_skb);
> > +
> 
> This omitted empty line was intentional btw.
> 
> > 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
> > 		qca->rx_skb = NULL;
> > 		return err;
> > @@ -1302,7 +1303,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
> > 
> > 	/* Give the controller time to process the request */
> > 	if (qca_is_wcn399x(qca_soc_type(hu)))
> > -		msleep(10);
> > +		usleep_range(1000, 10000);
> > 	else
> > 		msleep(300);
> > 
> > @@ -1350,7 +1351,7 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
> > 	if (on)
> > 		msleep(100);
> > 	else
> > -		msleep(10);
> > +		usleep_range(1000, 10000);
> 
> Regards
> 
> Marcel
> 

Sure, will clean up and resend. Thanks for checking on this!
