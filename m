Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E3C1975A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 14:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B32420775
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 14:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dnJRgQfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgCYOpp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:45:45 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39956 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYOpp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 10:45:45 -0400
Received: by mail-ua1-f67.google.com with SMTP id t20so813726uao.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfhyuSXT4SCQ4COQg/Q/ZZmgacUcKu21DcrYrYtj610=;
        b=dnJRgQfjpnz8EmTcFM9Iq0Po+j8+nN60b8kMNUH20Wq0RBImLQ9JI79SqFyq+zS7J/
         mcu7YXriZ289Lx9ZuWgCHIUbVRRQJUTh0RCjQzLB4S8b359kJzDep9Ktf97CsuqZFDTt
         xgHd5lKCJI7QPIXuVrrX5s9yi1l/6lqz/hHG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfhyuSXT4SCQ4COQg/Q/ZZmgacUcKu21DcrYrYtj610=;
        b=kNZbvkjk9n2IqZwDF6eBqBymHRfednoq+jftjtN7UhY80gCoXee4dYoc6CHr9NS6X7
         jBYt7a5e4c9+BYv3gYbYGYyRDM0Jgfw9AiWnG/855KihPY4xIFZjmOd6Hm27YuVZY5jL
         ZD+z15syROGO1dB9MbH/VwpLnVxNIwNXkCub8CwM3O0WxsrW4D1r1dsHSFNortagwRjx
         tXsS8GSNVoqeabsMFTVhN8j+RlhAWju7pwkynKPOmxFKn0Zog8XmSah2sseroPiTSHAK
         GgMY/6ez001uyNmwOM5p/0Wcg3cW6tCm+pL+3b0dQ+Ye7abuCBoDX89QYZiXpZqYgqqE
         hXfA==
X-Gm-Message-State: ANhLgQ2leToojATxLmvForaCh0V1cMAn8zbQYUYCaAlbNc1nyVEK1gAV
        wjPSrPxUL1F6k6dd0xv0wWZt3Or6fFB7dA==
X-Google-Smtp-Source: ADFU+vvJg2d0zM2+NOY1QBEeYPi203skIv1A/c+gftiJGTukG55ZB3v7BA4sePV1stY5DPQpvm/Ipw==
X-Received: by 2002:ab0:604f:: with SMTP id o15mr2630375ual.120.1585147543488;
        Wed, 25 Mar 2020 07:45:43 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id d20sm10629579vsc.6.2020.03.25.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:45:42 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3] bluetooth: don't assume key size is 16 when the command fails.
Date:   Wed, 25 Mar 2020 14:45:40 +0000
Message-Id: <20200325144540.206658-1-alainm@chromium.org>
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
index cd3d7d90029b..baad7efdc508 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2963,14 +2963,14 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 	if (!conn)
 		goto unlock;
 
-	/* If we fail to read the encryption key size, assume maximum
-	 * (which is the same we do also when this HCI command isn't
-	 * supported.
+	/* While unexpected, the failure of the read_enc_key_size command may
+	 * fail. The most secure approach is to then assume the key size is 0 to
+	 * force a disconnection.
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

