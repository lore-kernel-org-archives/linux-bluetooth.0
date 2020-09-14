Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DECC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4041D20756
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600097971;
	bh=/066gaXTRI/JoOta71UI68G+5ZR5XUo8+Ltf/2wY7Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Teg13rVjfq6a0zQdC9wtETZXTexiICXoqma2TuoMiczj1VxJNCiv1DNcO5fdBdY/f
	 yUXGiw/Dyb4dw8G/4paytnTLmGBOquAaIWowPvzaIRi9+l/ekKzRagOkgWbTufDTu9
	 vP1rNtp6naKs4HIGJb9GLaI2Kt9FU7kCTRBNl+S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgINPis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgINPij (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 11:38:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F421F221E7;
        Mon, 14 Sep 2020 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097901;
        bh=/066gaXTRI/JoOta71UI68G+5ZR5XUo8+Ltf/2wY7Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MycOoNW+ObWwBb5aQUDT+pAaKqtZxPcFaWtw76k/Gx3CrTRmodhyFG+S3Re5wLckQ
         aQWyJqsubww1/5832drCVnoMS6ddhoAfRuyImw5U2S7v62FpnpqYAuutczgilYKCnO
         fwMexSfJ6tqdsPbXGQwKkFy8W1dMhxrnMpmz+9JI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 06/11] sound: usx2y: move to use usb_control_msg_send()
Date:   Mon, 14 Sep 2020 17:37:51 +0200
Message-Id: <20200914153756.3412156-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
References: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The usb_control_msg_send() call can handle data on the stack, as well as
returning an error if a "short" write happens, so move the driver over
to using that call instead.  This ends up removing a helper function
that is no longer needed.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
 - minor changes requested by checkpatch.pl

v2:
 - Added reviewed-by from Takashi

 sound/usb/usx2y/us122l.c | 42 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index f86f7a61fb36..6d35303b0948 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -82,40 +82,13 @@ static int us144_create_usbmidi(struct snd_card *card)
 				  &US122L(card)->midi_list, &quirk);
 }
 
-/*
- * Wrapper for usb_control_msg().
- * Allocates a temp buffer to prevent dmaing from/to the stack.
- */
-static int us122l_ctl_msg(struct usb_device *dev, unsigned int pipe,
-			  __u8 request, __u8 requesttype,
-			  __u16 value, __u16 index, void *data,
-			  __u16 size, int timeout)
-{
-	int err;
-	void *buf = NULL;
-
-	if (size > 0) {
-		buf = kmemdup(data, size, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-	}
-	err = usb_control_msg(dev, pipe, request, requesttype,
-			      value, index, buf, size, timeout);
-	if (size > 0) {
-		memcpy(data, buf, size);
-		kfree(buf);
-	}
-	return err;
-}
-
 static void pt_info_set(struct usb_device *dev, u8 v)
 {
 	int ret;
 
-	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-			      'I',
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      v, 0, NULL, 0, 1000);
+	ret = usb_control_msg_send(dev, 0, 'I',
+				   USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				   v, 0, NULL, 0, 1000);
 	snd_printdd(KERN_DEBUG "%i\n", ret);
 }
 
@@ -305,10 +278,11 @@ static int us122l_set_sample_rate(struct usb_device *dev, int rate)
 	data[0] = rate;
 	data[1] = rate >> 8;
 	data[2] = rate >> 16;
-	err = us122l_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
-			     USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
-			     UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep, data, 3, 1000);
-	if (err < 0)
+	err = usb_control_msg_send(dev, 0, UAC_SET_CUR,
+				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep, data, 3,
+				   1000);
+	if (err)
 		snd_printk(KERN_ERR "%d: cannot set freq %d to ep 0x%x\n",
 			   dev->devnum, rate, ep);
 	return err;
-- 
2.28.0

