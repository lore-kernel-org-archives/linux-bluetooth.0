Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C79C1975A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5962220789
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 14:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U24h3N0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCYOsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:48:39 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41813 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYOsi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 10:48:38 -0400
Received: by mail-vk1-f196.google.com with SMTP id q8so723797vka.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sJwl4n8hWi/9tlXfIm4Kvmwsb7vRka1/fi8wdFaWYY=;
        b=U24h3N0caaRpznyG/9d//Ni0BBnHUw6GsAWKth7DhV4OhpumfYSjl8W+LVPaMtGApI
         exC9+mcbmdSFrfkLPon5DinzmfpaWcSYP9q977LfkF/sgoiolf2sQQok8p380n05lQ/D
         TPhfx+Eq4K5bt2x1b1EH6xkKMgpfCp7UH27Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sJwl4n8hWi/9tlXfIm4Kvmwsb7vRka1/fi8wdFaWYY=;
        b=Suy7/h9D8SZm1yxo5/E1+OLxIsSdR05rZUOz7X9iyg18SGHRrXdc8u9kCDxksljWiB
         ohiUBYwmtmzoU/RioEw+jwiELEs61C7K0oKNlhgdYHGJA4u86ova7lYXBoED68vOPJq2
         rT1X/VhjXAnbCurY0NxHuPQCKoE13HE7agnLYF+nMCJbuk1MdBUcNQML0+P88CdWkXtk
         g/TvGbxPr7rmoY0l/cH2BPB1qd1QA+ncO1BgCqRFzqBS9mtc0e0rkbF5AoO33dOnAb4t
         i3N+behV52JzYCIFQHzAzCfkIafCfp63dIeYGP/UZUHeya4qyRtyzPqLPn8FqIMxJzdy
         Oc0A==
X-Gm-Message-State: ANhLgQ0pnGs5SfZL9VRtU4qEEm8VWPht8IK5VoFQU6nAoOPrPHBX5e0t
        qkHF+lnyasDXXPdg4JxSG9jrw6NttWYutw==
X-Google-Smtp-Source: ADFU+vsFWRkRpag5kybj+VLuQJpsx7nvOnH4RtFCR9KHpi21zhJ5bUfnpurgymC28CPsrxQysm0DQA==
X-Received: by 2002:a1f:a617:: with SMTP id p23mr2529815vke.2.1585147717056;
        Wed, 25 Mar 2020 07:48:37 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id x139sm10394818vkd.3.2020.03.25.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:48:36 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v4] bluetooth: don't assume key size is 16 when the command fails.
Date:   Wed, 25 Mar 2020 14:48:34 +0000
Message-Id: <20200325144834.207572-1-alainm@chromium.org>
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

 net/bluetooth/hci_event.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cd3d7d90029b..0a591be8b0ae 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2963,14 +2963,14 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 	if (!conn)
 		goto unlock;
 
-	/* If we fail to read the encryption key size, assume maximum
-	 * (which is the same we do also when this HCI command isn't
-	 * supported.
+	/* While unexpected, the read_enc_key_size command may fail. The most
+	 * secure approach is to then assume the key size is 0 to force a
+	 * disconnection.
 	 */
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

