Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB60C77B61
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 19:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbjD0TdI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245511AbjD0Tcx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 15:32:53 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC2110CB
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:51 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-32b102ca487so67290315ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682623970; x=1685215970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TxEgwLhiQ41y0of/BgNY+ugH8sfqwBu6KV8WR5vgIE=;
        b=NkxzYd7q1kYdZyHJn5dtFmiY3ClCS0/3bzD66krT9uVoqBPK09O1W3sei3gE7Vdock
         DPy6y5y7xq570Vbw6tmDvy3J4kLvueCqDOC9e6ar0ASvsJLLb8oqbqfMTPSt4IogE9rA
         1AO/OmdWVQXvVmIIoEU2ywAs0/cAnHWa9O4ADIDSGgnUhPlnWV0tHDMTaDGBQsNmSQpz
         GTJeRvu4/FAdA2Q+yplfcGvHzVY7rCYQPqqz+YATRzlf/hWuF0/i7rOniFAMJxhetlVs
         hwGaZ0+u603I8oTwkyiTSsgPj4GdP6IhulaBOf2zTeLv8NfGRQ/+BrJw++MRUURK0u1o
         4zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623970; x=1685215970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TxEgwLhiQ41y0of/BgNY+ugH8sfqwBu6KV8WR5vgIE=;
        b=Bdl0/xobQ5ggGu6iNGijU64ovFkipW1UBN0rDpdQhyYmgZmCeJYgwM+3XqaFpyesGe
         iajdrUmJF/jFuBUft1RxZ579pa2drOce77eIo5UB1bSgIKrKAF9YgUvMzpbqacwfbfSW
         bII8s3YZ0WIlfyhjHcGV7vNpTqDMEnfsY7QX5D5aH3DKl1m4aDjmYTk2eLIh4pra9zGb
         iUGj8ev14RbuMqskjMS3BhBe36j6u2+ktGl61yrTD6fGRvyL4HkT2xeGlCiIhN8/XbSr
         oTRIGAt1gNWAZW9mo19KlPuDLKkmk6l6P/N4cX6QX8nCecEHkDSkU8cS9OgqyWEVUUji
         1Fyg==
X-Gm-Message-State: AC+VfDwGRA10qrkPJyhQSujOHb9Wl1X5pyE7PbCeAAtoudVfEBDhe684
        O7YMZ4yqIuH4m5LUqxkLVVcIFl6D9Tw=
X-Google-Smtp-Source: ACHHUZ5jmZLQQM4/2PCgoQED1NI7v7UaBaBtB1MFyD/kuE91ftB2UOaJsSbiUwxiX98uuETlS7hjUg==
X-Received: by 2002:a05:6e02:78f:b0:32b:1eb1:c463 with SMTP id q15-20020a056e02078f00b0032b1eb1c463mr2051023ils.26.1682623969975;
        Thu, 27 Apr 2023 12:32:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638264c00b00411baa5ec5asm3349898jat.154.2023.04.27.12.32.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:32:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 2/9] shared/bap: Fix crash detaching streams
Date:   Thu, 27 Apr 2023 12:32:38 -0700
Message-Id: <20230427193245.323502-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427193245.323502-1-luiz.dentz@gmail.com>
References: <20230427193245.323502-1-luiz.dentz@gmail.com>
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

