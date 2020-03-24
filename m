Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0601C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C2620753
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DniwJwU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgCXTuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:50:13 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44931 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCXTuN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:50:13 -0400
Received: by mail-ua1-f65.google.com with SMTP id r47so6765558uad.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5M1ZyLW9QqcxgMLxcogxe2NfpquZodZY6YHxb/gh7TQ=;
        b=DniwJwU6gompoO5lnpbsNyz6y0vmAclmKRFv0VJa8CAyB0n+oa1UXF7U76wOaTTR6V
         hYhcGuo5gd7TWIcKYlQxjGIGH7uVqwvaUJz4NMkhfrMkHgHb/6q1gQySqdiYo6DxE1Wp
         32KlAM2QTgiy/mJ8FCW4wrcknRCsZsxxW/8ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5M1ZyLW9QqcxgMLxcogxe2NfpquZodZY6YHxb/gh7TQ=;
        b=M5mAObvA3j+Wl5wzjqD6Lxb8fWuy984IOhDWYl+qTtGINkyPEJCqD6uUzADKhkm/72
         iDbvzRMYR0p9me1OlTAGyfYx3YlT7oXy5LME2daHeX4D2fTiuQY0u0cmspJ979eftMUr
         zcv4eKwj0eCJoPezkJr+CDNT3+Lq/DoiRuUWKVL3CT0wWYDGhpt9p7pkaATq6CmpIpuZ
         r3nirB+wZhvjgTWHLxrDqSI1uC0rk05uxe57QCo+xUixZMrp9OrNV+M0+IBNccSTq5IV
         W5idYBuQXr1wP8gFr8qdiqZN77pM5H2LcBuXoCID2aBWA/F6pTuSdIChIpFp6N4h+F4/
         UfjQ==
X-Gm-Message-State: ANhLgQ3poCrF0Dtf6OMALxiIxvObzpU7v7bHnBByIr7RHZBe3EBfjVle
        ThE053YEeV1KKN9unzheFES7QdY4Q38=
X-Google-Smtp-Source: ADFU+vt0GXwvJY6cP/1BPDjpFLDSVLniJU/G98WQgtA1PBdyslPdKTlZotH645rZoYlD9wcTr9JREQ==
X-Received: by 2002:ab0:718b:: with SMTP id l11mr8870281uao.100.1585079411486;
        Tue, 24 Mar 2020 12:50:11 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id w131sm8042273vke.8.2020.03.24.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 12:50:11 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] bluetooth: don't assume key size is 16 when the command fails.
Date:   Tue, 24 Mar 2020 19:50:08 +0000
Message-Id: <20200324195008.10822-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With this change, the encryption key size is not assumed to be 16 if the
read_encryption_key_size command fails for any reason.  This ensures
that if the controller fails the command for any reason that the
encryption key size isn't implicitely set to 16 and instead take a more
concervative posture to assume it is 0.

Signed-off-by: Alain Michaud <alainm@chromium.org>

---

 net/bluetooth/hci_event.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cd3d7d90029b..8a7a94e6f956 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2963,14 +2963,10 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 	if (!conn)
 		goto unlock;
 
-	/* If we fail to read the encryption key size, assume maximum
-	 * (which is the same we do also when this HCI command isn't
-	 * supported.
-	 */
 	if (rp->status) {
 		bt_dev_err(hdev, "failed to read key size for handle %u",
 			   handle);
-		conn->enc_key_size = HCI_LINK_KEY_SIZE;
+		conn->enc_key_size = 0;
 	} else {
 		conn->enc_key_size = rp->key_size;
 	}
-- 
2.25.1.696.g5e7596f4ac-goog

