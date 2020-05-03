Return-Path: <SRS0=w4jJ=6R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D82BC28CBC
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 May 2020 11:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C88820721
	for <linux-bluetooth@archiver.kernel.org>; Sun,  3 May 2020 11:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588504001;
	bh=kPTH/ruNIyV8twU+AjLqiSOyb3AzejW1UQHwS7j+YRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gi+elWXtg3SwLNw8onhcyBjk4TzDSXzcd8siTykzgjzNJivq20DBqf9hLMk9jp30P
	 rAMXFmmevvNovSXs3s67cmPIXKVshHb+/DY+KiST+D+gbVAtMINelmS8EhKwHAWVIp
	 GqpuB8Yz3fo7+S6atbFO8tCjFgyY2ujZu8C/dRPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgECLGk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 May 2020 07:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgECLGk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 May 2020 07:06:40 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36BA62071C;
        Sun,  3 May 2020 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588504000;
        bh=kPTH/ruNIyV8twU+AjLqiSOyb3AzejW1UQHwS7j+YRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1eLmjj2oXKg9izATNtx6XlVtz4xywkFB50QVedVcleeCvgYJpJmhsfdqrDZzKZN9e
         XdGJ5UmVRVcliq7etu/r+qAkLjHlQOvDc62Dj/L5MaHm9TiTIxPOVl8/If9Ktgc1sF
         anJWJ9d0ywG7t6/QChdoLIUtv9F2j22Hlv1/C3NE=
Received: by pali.im (Postfix)
        id 3F33CA1E; Sun,  3 May 2020 13:06:37 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] a2dp: Check for valid SEP in a2dp_reconfigure
Date:   Sun,  3 May 2020 13:06:29 +0200
Message-Id: <20200503110629.11068-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <5ea9d716.1c69fb81.92030.0ba2@mx.google.com>
References: <5ea9d716.1c69fb81.92030.0ba2@mx.google.com>
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
index c31aaf187..a2ce3204d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1178,6 +1178,12 @@ static gboolean a2dp_reconfigure(gpointer data)
 	struct avdtp_media_codec_capability *rsep_codec;
 	struct avdtp_service_capability *cap;
 
+	if (!sep->lsep) {
+		error("no valid local SEP");
+		posix_err = -EINVAL;
+		goto failed;
+	}
+
 	if (setup->rsep) {
 		cap = avdtp_get_codec(setup->rsep->sep);
 		rsep_codec = (struct avdtp_media_codec_capability *) cap->data;
@@ -1186,6 +1192,12 @@ static gboolean a2dp_reconfigure(gpointer data)
 	if (!setup->rsep || sep->codec != rsep_codec->media_codec_type)
 		setup->rsep = find_remote_sep(setup->chan, sep);
 
+	if (!setup->rsep) {
+		error("unable to find remote SEP");
+		posix_err = -EINVAL;
+		goto failed;
+	}
+
 	posix_err = avdtp_set_configuration(setup->session, setup->rsep->sep,
 						sep->lsep,
 						setup->caps,
-- 
2.20.1

