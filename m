Return-Path: <SRS0=7X4B=CL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D453EC433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 11:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E772083B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599044629;
	bh=/96qgCR3mfNvN+1iDBfVpYHsssSY4lebzEc9IAH7Dmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvGYNQIgF1LlxMZZg8TWSk+Yze0dbPZ+NllAuM8zDKGSU0Oc9XtoPM6pi/Y3680Gs
	 V86DF0f/tGu6xIdDBahJAuyZ7b9S9us16EXNeDuLpboTKrAhnJ4kWPZ2sRe2XfIzqH
	 wxl1s5PW5f1A/TD0Zpki01nAuBtvebP7s9a9ZJiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIBLDm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBLBF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Sep 2020 07:01:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF88207D3;
        Wed,  2 Sep 2020 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599044464;
        bh=/96qgCR3mfNvN+1iDBfVpYHsssSY4lebzEc9IAH7Dmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zV9jGmh7unapsEHtykkj4r3hf8tgnrWnjlC+6GUexrcUjaXk8e/7NXwupVoM8qCi0
         CJEnVybMYP49bJmuSMIQAcng64pSkWItjqJo7ohCKcKguszBFaw/Cc1o9k0yuL2fty
         9j3Led9+CWmzMvPkZADL1tGVZI+LRVPW9T2yqDik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 9/9] sound: hiface: convert to use new usb_control functions...
Date:   Wed,  2 Sep 2020 13:01:13 +0200
Message-Id: <20200902110115.1994491-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/hiface/pcm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index a148caa5f48e..feab3f4834c2 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -156,14 +156,12 @@ static int hiface_pcm_set_rate(struct pcm_runtime *rt, unsigned int rate)
 	 * This control message doesn't have any ack from the
 	 * other side
 	 */
-	ret = usb_control_msg(device, usb_sndctrlpipe(device, 0),
-			      HIFACE_SET_RATE_REQUEST,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			      rate_value, 0, NULL, 0, 100);
-	if (ret < 0) {
+	ret = usb_control_msg_send(device, 0,
+				   HIFACE_SET_RATE_REQUEST,
+				   USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				   rate_value, 0, NULL, 0, 100);
+	if (ret)
 		dev_err(&device->dev, "Error setting samplerate %d.\n", rate);
-		return ret;
-	}
 
 	return 0;
 }
-- 
2.28.0

