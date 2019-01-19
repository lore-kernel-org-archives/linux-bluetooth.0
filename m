Return-Path: <SRS0=MOIW=P3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF56C5AE5E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 00:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFFF20823
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 00:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oA3VNzX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfASAbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:31:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45459 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbfASAbM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 19:31:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so6792852pgc.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jan 2019 16:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sd+gwOo5E4dkuf4Q6i8JvdMw7Stn3ZJ/xuY+z66pxp8=;
        b=oA3VNzX3bnQsIF+UkffAZ2wgMaE+zvZWqNg94TTjaV6spVo1EZmId5LhAR9U3kg3Rf
         bo87YaFm4ExZiqEeI8JNFjoH0xhhIpIiq9zqOhFk8XadY45FUxnibwkrSqtkZkNBK8Lr
         kYUaocAI89Ep6MQo0Yv1crVQFF94Mth6jL/sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sd+gwOo5E4dkuf4Q6i8JvdMw7Stn3ZJ/xuY+z66pxp8=;
        b=n2PNbNEcqd9/Cxh4OKYb001GTgmoYl/3RwVjJEeK3AlIgvCdziYdOHpSK2CdOR/4Ki
         IA/LoF2VoSzxYuTVARTNxqBxdQ2O5hFoenjLRU0P8clZCP+9o3XkDx/DG2tuh4xHwDqN
         JYppt8pcDfIt7ZxoFQpyXSOypjJ7OEBfl0rtTavOOA5q59pP2UKBzcl/mwvtNVzekWau
         XrtK4DcPfc18Ba6BGHFUJnx5HfgcUAKpC/fa5CbIFmA5VuxgppVTyahpDQ7kNqUKOJqJ
         w2JUem2rf695kcPfGFDgqj3Obzty3hb38XMvbZGvFq/OGGcqYNbLagui3sw430e3nhf+
         rIgw==
X-Gm-Message-State: AJcUukdHZ6R69vvjkfaaKmK9Skz4wnZ57ZY9zEAwfea8ne98StEub0PH
        eINrU8AKrcIqyEmUDvtsImjLbA==
X-Google-Smtp-Source: ALg8bN5oODdLlAZyklgwdzaHEQrU0y01J2dK24MCqQvbNSaRWzmMpr17C9P/2k541Da/gT6P/ZXpqw==
X-Received: by 2002:a63:c051:: with SMTP id z17mr19393530pgi.20.1547857871519;
        Fri, 18 Jan 2019 16:31:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q195sm6681095pgq.7.2019.01.18.16.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 16:31:10 -0800 (PST)
Date:   Fri, 18 Jan 2019 16:31:09 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190119003109.GD261387@google.com>
References: <20190110143928.GE3430@localhost>
 <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
 <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com>
 <20190117160944.GV3691@localhost>
 <20190117172109.GU261387@google.com>
 <20190118094416.GB3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118094416.GB3691@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 18, 2019 at 10:44:16AM +0100, Johan Hovold wrote:
> On Thu, Jan 17, 2019 at 09:21:09AM -0800, Matthias Kaehlcke wrote:
> 
> > I observed that the qcom_geni_serial driver doesn't raise RTS with
> > flow control disabled. It seems we have to investigate why that's the
> > case. I agree that the driver should be platform agnostic.
> 
> Sounds like a driver bug, unless the hardware is just "odd". The
> driver implementation of this looks very non-standard judging from a
> quick peek.
> 
> In fact, qcom_geni_serial_get_mctrl() is currently a no-op if hardware
> flow control is not enabled:
> 
> 	if (uart_console(uport) || !uart_cts_enabled(uport))
> 		return;
> 
> Perhaps dropping the !uart_cts_enabled() test is sufficient.

Thanks for taking a look Johan, that was indeed the problem (also
in set_mctrl()). I posted a fix: https://lore.kernel.org/patchwork/patch/1033611/

Balakrishna, the following (applied on top of your patch) works for me
with the UART patch above:

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9d5e41f159c78f..60bfdf01f72841 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1080,7 +1080,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
 	struct qca_serdev *qcadev;
-	int ret;
+	int ret = 0;
 
 	if (speed_type == QCA_INIT_SPEED) {
 		speed = qca_get_speed(hu, QCA_INIT_SPEED);
@@ -1097,22 +1097,27 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		 * the old speed.
 		 */
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->btsoc_type == QCA_WCN3990)
+		if (qcadev->btsoc_type == QCA_WCN3990) {
+			hci_uart_set_flow_control(hu, true);
 			serdev_device_set_rts(hu->serdev, false);
+		}
 
 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
 		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
 		if (ret)
-			return ret;
+			goto out;
 
 		host_set_baudrate(hu, speed);
 
-		if (qcadev->btsoc_type == QCA_WCN3990)
+out:
+		if (qcadev->btsoc_type == QCA_WCN3990) {
+			hci_uart_set_flow_control(hu, false);
 			serdev_device_set_rts(hu->serdev, true);
+		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int qca_wcn3990_init(struct hci_uart *hu)
