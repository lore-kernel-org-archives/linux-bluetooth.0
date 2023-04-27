Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE517C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 23:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbjD0XN7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjD0XN6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 19:13:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B442272E
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:13:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso68627305ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682637236; x=1685229236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TxEgwLhiQ41y0of/BgNY+ugH8sfqwBu6KV8WR5vgIE=;
        b=AUsdcvOUV2SYGTtqt85wN9HDnKzS1ZZjKAW3gyYUK2WoRPGdoRpFJ5HmY+dZwYw6pV
         +Nk02P/zZy4F/aZIlwlOEWy8EyJ9ZyrZnN4AuPlKmx5H1vuDeAZc+xU1PGgLjMG/zlO5
         7wOyI3LwWa0fc3gP5KJ0NAtuvPshW1smTzzHRxfudeNHIML83t35FUuSCOI5xWoPxeAm
         ZaH3a7y017k1f4XS0MQxk+R8NcmgCVYj1oekNe2lZx9nx2M17NL59i0PlmUYiWkf22Lp
         juLNndzj9BSz/tGjdA/GfsO0nLrV07G31TQS9dSR91jqEz8TwU4yXmc0+OY7nn1KTIpG
         sr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682637236; x=1685229236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TxEgwLhiQ41y0of/BgNY+ugH8sfqwBu6KV8WR5vgIE=;
        b=GnQAoZavMef6eGs2jvX3g4Qae7/ynGBVx/iq32hbkX4h4Ddyu95V837LLaBJ7BSlAb
         I/1uO571oRRN89GRpkJEh6wz9sJoxMsy/U6mBJQaS96QkaahbrMXQlKyA0xxDCLV+TFq
         dCaFvcoPLrPMohNqz1KvPo+9XEoIVSS79iUH2ZyB0rFcecQv0V1yXXms9FXkYFrF9b3f
         D2K7iRRwP6O6DsMFYREiXpQdUNcE9b+TDxeUsxwuE7CDS7vpikGMuJskq4+Y1NsQ8/Xp
         N2w0yOLJXPYq8x7Kh94aPxGeyCTQTUx6bDv+ttembcQ4blg/imbbzhD3uHGVYRk9emlV
         sXWg==
X-Gm-Message-State: AC+VfDzztT26gTw2Mmua8SGhvL63nx2OSlrNrAyCuNIo++Pavyj+vVYl
        8Z8oY3YQm1d5SCibBdKL4fSfo77IWms=
X-Google-Smtp-Source: ACHHUZ7s6hCcX/obmYzC4AwT+FB71nm0BKbRpqkxnpH1ytzzmc1l2ldd4A3l5pmF/GU2+KqQyDtPww==
X-Received: by 2002:a17:902:8c91:b0:1a9:2b7f:a594 with SMTP id t17-20020a1709028c9100b001a92b7fa594mr3100044plo.29.1682637236184;
        Thu, 27 Apr 2023 16:13:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902aa4500b001a24cded097sm12112369plr.236.2023.04.27.16.13.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 16:13:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 2/9] shared/bap: Fix crash detaching streams
Date:   Thu, 27 Apr 2023 16:13:45 -0700
Message-Id: <20230427231352.576337-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427231352.576337-1-luiz.dentz@gmail.com>
References: <20230427231352.576337-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a stream is being detached but bt_bap reference is already 0 don't
attempt to detach the stream as they would be freed anyway:

Invalid read of size 8
   at 0x19A360: bap_free (bap.c:2576)
   by 0x19A360: bt_bap_unref (bap.c:2735)
   by 0x19A360: bt_bap_unref (bap.c:2727)
   by 0x160E9A: test_teardown (test-bap.c:412)
   by 0x1A8BCA: teardown_callback (tester.c:434)
 Address 0x55e05e0 is 16 bytes inside a block of size 160 free'd
   at 0x48480E4: free (vg_replace_malloc.c:872)
   by 0x1AD5F6: queue_foreach (queue.c:207)
   by 0x19A1C5: bt_bap_detach (bap.c:3879)
   by 0x19A1C5: bt_bap_detach (bap.c:3855)
   by 0x19A33F: bap_free (bap.c:2574)
---
 src/shared/bap.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 5a12a64d292b..bc6177a5ba90 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1168,6 +1168,14 @@ static void bap_stream_set_io(void *data, void *user_data)
 	}
 }
 
+static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
+{
+	if (!bap || !bap->ref_count)
+		return NULL;
+
+	return bt_bap_ref(bap);
+}
+
 static void bap_stream_state_changed(struct bt_bap_stream *stream)
 {
 	struct bt_bap *bap = stream->bap;
@@ -1178,7 +1186,14 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bt_bap_stream_statestr(stream->ep->old_state),
 			bt_bap_stream_statestr(stream->ep->state));
 
-	bt_bap_ref(bap);
+	/* Check if ref_count is already 0 which means detaching is in
+	 * progress.
+	 */
+	bap = bt_bap_ref_safe(bap);
+	if (!bap) {
+		bap_stream_detach(stream);
+		return;
+	}
 
 	/* Pre notification updates */
 	switch (stream->ep->state) {
@@ -2730,14 +2745,6 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap)
 	return bap;
 }
 
-static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
-{
-	if (!bap || !bap->ref_count)
-		return NULL;
-
-	return bt_bap_ref(bap);
-}
-
 void bt_bap_unref(struct bt_bap *bap)
 {
 	if (!bap)
-- 
2.40.0

