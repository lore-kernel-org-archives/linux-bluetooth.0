Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123AC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 15:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F3320EDD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600098186;
	bh=tGgg30b0UwGAiVeeMU334OIR6bWHk4P6xBpiFv81zpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=alUW7R1dyYSCvDzLgtSBbJ1l34vKsSZNs0G0AbP8TFhXSFpLk6RgdjMBlQMZwpSEG
	 cQJeXPpj9fxkklXtp/Gan8CHp0RhNKwiCijvhXgcds5eEQ4Bh/wgnUPAgUjfYqWUrr
	 fhXjtbRbIR2/9FZC9SBLYVdMSKuqSkaZDyoa/Hj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgINPm4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgINPik (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 11:38:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB91322204;
        Mon, 14 Sep 2020 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097908;
        bh=tGgg30b0UwGAiVeeMU334OIR6bWHk4P6xBpiFv81zpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnWE3OQEG5NmPV6Q3zBx67lv6nmYQZgaDVZ68K1p7Fv13rDNI9D/au2COJEFfHxty
         LV8TMYWiHkYFQEcdCLd+zGnRfQIu31e3pOmzxi0wl8zvMyB/+eQzD8tjB+IiTZjjcZ
         nYXusKOZULgAsa/Sv40W8NCHgQFBzWxdnPxu8nbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 09/11] sound: hiface: move to use usb_control_msg_send()
Date:   Mon, 14 Sep 2020 17:37:54 +0200
Message-Id: <20200914153756.3412156-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
References: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The usb_control_msg_send() call can return an error if a "short" write
happens, so move the driver over to using that call instead.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
 - no change from v2

v2:
 - Added reviewed-by from Takashi

 sound/usb/hiface/pcm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index a148caa5f48e..f9c924e3964e 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -156,16 +156,14 @@ static int hiface_pcm_set_rate(struct pcm_runtime *rt, unsigned int rate)
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
 
-	return 0;
+	return ret;
 }
 
 static struct pcm_substream *hiface_pcm_get_substream(struct snd_pcm_substream
-- 
2.28.0

