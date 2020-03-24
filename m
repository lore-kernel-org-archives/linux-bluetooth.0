Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D742C54EEB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BE4206F6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pz3712hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgCXTs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:48:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45212 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCXTs4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:48:56 -0400
Received: by mail-vs1-f65.google.com with SMTP id x82so25457vsc.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zj/kubDeaOKk7jPAD2N4BH8hUZPMzmvbaNoa/07GPr8=;
        b=Pz3712hdF6puiwzUy9h7Cg7iGrjnhgat/ncuxIBJiYEwkQjmXKz8IlujSaSB6JiBnX
         WvfNcKPZKdKllr02IBQjLNryY1EcPoubeIwMzrEXu34cvkilTNiOV6Flro7BLhNkwitC
         HltyuaOWDEuPGeGpaZHJwTLVFWVjAOIdeyEPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zj/kubDeaOKk7jPAD2N4BH8hUZPMzmvbaNoa/07GPr8=;
        b=laC0YKV+/U8vAHUH78x2yVfChbWtszScpQsvl8DsJOvetyb+OgnoiM5M9rheUBg78j
         PtTs8fSfYlrocy7rJKRBamzJb34cu095ef/hzMNe7wS9RbLGknZXDEeEWqztx2AeqfKb
         orKbATrgJX+SUaMHKOrd0rtQNYSlTFCc4GhuxL0MqpvpNL1bmHItWc9kmGQot6+nkb/V
         Q2AEIxEl2kjLi6b/qZXMDf+gdDHBV1RSaypkqcbpC72RUTMPdRRAl6QjjXqwGj4Omnsb
         2PHZjGcs4YK3JHe7wE01wA3HDPTbGsRY7VL18lr9DJiFFWIJa7a4lo2sk50WxpH4bvZS
         9B8w==
X-Gm-Message-State: ANhLgQ24L7NzmljFOky3whLvJ2L7ooTZUqo+ZTOvvwpKytK+9lssGjmm
        NiEiwkQHULs0cks9BrMhPr5R5y20O6s=
X-Google-Smtp-Source: ADFU+vtZrmmdcyAB2IZZJfKa0nnE38BmEumenjq0zjrNVyo/fIT2JWOpAhA0m5Aklm51SYC55RqDaw==
X-Received: by 2002:a67:2786:: with SMTP id n128mr21790663vsn.21.1585079333439;
        Tue, 24 Mar 2020 12:48:53 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id x78sm9351572vsc.17.2020.03.24.12.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 12:48:52 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth: don't assume key size is 16 when the command fails.
Date:   Tue, 24 Mar 2020 19:48:49 +0000
Message-Id: <20200324194849.10084-1-alainm@chromium.org>
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

 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cd3d7d90029b..10703c4b7347 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2970,7 +2970,7 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
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

