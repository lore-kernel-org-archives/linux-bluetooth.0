Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88367C83007
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 19:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC3E205C9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588188420;
	bh=CoXOip5OgSsY5eyeGBPZmzhCHPI40f8x53xBFOzv48E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pgujbWPvXGC3zJgAP7gCF3weSh8n+eTQ8G3/hM3Yl/h+ZUx1+R7DQmbbsEYjCoDEA
	 27ORK0uTuqgDFW72I04Nzs/5cKbCja8UwVklDOhrRcMuvHWDGnA+Gc9jePR4pqL6Rf
	 z9/ic6V4UiiBycAu/woz7fhGF3ohfD27K9qmotUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD2T07 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2T07 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 15:26:59 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EF42063A;
        Wed, 29 Apr 2020 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588188419;
        bh=CoXOip5OgSsY5eyeGBPZmzhCHPI40f8x53xBFOzv48E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2OfdyFnc3s41d3Me2QNnxhYO0CL40CH8mQN/gISEifVRGVrS6oSxGFLQizO6MARMs
         bxl/IvzAyiFF4CDyFdmbcNuxk7WA+h/5ty0wfadPET/QVIO+gHgE6Q9ZGXsnfN4CCh
         pFvac9oZtM+jVO3hlB9rObwpHlsuQBhMTVtjsQu4=
Received: by pali.im (Postfix)
        id 2504267E; Wed, 29 Apr 2020 21:26:57 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] a2dp: Check for valid SEP in a2dp_reconfigure
Date:   Wed, 29 Apr 2020 21:26:45 +0200
Message-Id: <20200429192645.31297-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426151529.dpzojinssjqagsaq@pali>
References: <20200426151529.dpzojinssjqagsaq@pali>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

a2dp_reconfigure() is called as callback when local and remote SEP does not
have to be valid anymore, sep->lsep can be NULL.

This change fixes bluetoothd daemon crash (dereferencing NULL sep->lsep)
when audio agent disconnect in the middle of the reconfigure call.
---
 profiles/audio/a2dp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a5590b24c..8e6d8b417 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1179,6 +1179,12 @@ static gboolean a2dp_reconfigure(gpointer data)
 	struct avdtp_media_codec_capability *rsep_codec;
 	struct avdtp_service_capability *cap;
 
+	if (!sep->lsep) {
+		error("a2dp_reconfigure: no valid local SEP");
+		posix_err = -EINVAL;
+		goto failed;
+	}
+
 	if (setup->rsep) {
 		cap = avdtp_get_codec(setup->rsep->sep);
 		rsep_codec = (struct avdtp_media_codec_capability *) cap->data;
@@ -1187,6 +1193,12 @@ static gboolean a2dp_reconfigure(gpointer data)
 	if (!setup->rsep || sep->codec != rsep_codec->media_codec_type)
 		setup->rsep = find_remote_sep(setup->chan, sep);
 
+	if (!setup->rsep) {
+		error("a2dp_reconfigure: unable to find remote SEP");
+		posix_err = -EINVAL;
+		goto failed;
+	}
+
 	posix_err = avdtp_set_configuration(setup->session, setup->rsep->sep,
 						sep->lsep,
 						setup->caps,
-- 
2.20.1

