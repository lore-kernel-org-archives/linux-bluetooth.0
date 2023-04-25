Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B999C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 20:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjDYUrh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDYUrg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 16:47:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC9313F99
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b87d23729so5047360b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682455654; x=1685047654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeNWUrnsQjLkKml+5ZPf2RhE3u/DteHD5gSzqGFneVg=;
        b=MqQcz5ATVJc0+JzCNpNH7hzOnPhlKMpHaz3xSsoK19eEwN1AApdc9uWXyQ4DsEXvOB
         oTtnXbS8D2O13MFyd70xhQiJDNGmq7ZgsBYVymgy1LrzNxpPGKwgUaEza3Z9zakYLgam
         Cyev4T0pm9/GIMXO0ELKgXujHr8BAVMM4eCH6K1nmPFsvgET6cM1YzDKcDwrlNw+ukUU
         suqN7lIcALJ6hqy/XAU6RI71z1obEo4y5ZBiseWzxgKWvugv06pA6ZJ3kArhj/+qVVzK
         ypDSRmUsL1/MyEwLvp8o3eIfi7Zal1wi8B0G4gIhR8v/FFYf1uEC/lRmFiyGN36MBm3v
         +Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682455654; x=1685047654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeNWUrnsQjLkKml+5ZPf2RhE3u/DteHD5gSzqGFneVg=;
        b=afrfMP0tUtdV36QhJIWyPYgsVZrGOkzdHLwfMEOjFkO8I2IPP/FEBbiRi8r+BWd+7c
         ao4TaJu9iGGSAFagBNirCcW7uiWVOF2ZTRs60p/JbZTXUlCfT3GbAqDD549BG1AOukuR
         WBRaoeerTgRw3pKphwdY6DsSnjsU9L14xxulhOWnMrez01bg/5w96nXTaoND3+B7VYbB
         DdG1l06qrqGfUGavV0x1Ta4p8/Qn90Dm4nYblsMBR43JN7v0gXkz4Xo2LGtBKr7R+/13
         WF5AOp+nw53fVr41cRpbc97JFw1/nzbIkoAzKggCiwA/DDE39N3H9xGa4ZfiwOQoGyG6
         wSBA==
X-Gm-Message-State: AAQBX9f1rVIpRlMPGzYOtrQnGdcK7FVAWKDa/+v+2XpOzuC3svUuSfqH
        8Vrreeqdo+Dw3PeURs4KLVp5UwcGVVE=
X-Google-Smtp-Source: AKy350YnF8JEByW0K6n2/CJ1GKlxuTnvopXta+lyYjT+9iqnq63MC+heBg+74aucinGHvMjFo8uWVw==
X-Received: by 2002:a05:6a20:4410:b0:f3:4da0:a25d with SMTP id ce16-20020a056a20441000b000f34da0a25dmr14615859pzb.13.1682455654044;
        Tue, 25 Apr 2023 13:47:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm8247454pjq.43.2023.04.25.13.47.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:47:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] shared/bap: Fix crash detaching streams
Date:   Tue, 25 Apr 2023 13:47:24 -0700
Message-Id: <20230425204729.3943583-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425204729.3943583-1-luiz.dentz@gmail.com>
References: <20230425204729.3943583-1-luiz.dentz@gmail.com>
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
index 1fff7e0fd21f..f48cbdf5d6f9 100644
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
@@ -2716,14 +2731,6 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap)
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

