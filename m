Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A03AC4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2998A20754
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 13:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AJwaXk1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgCTNhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:37:55 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44762 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgCTNhz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 09:37:55 -0400
Received: by mail-ua1-f68.google.com with SMTP id r47so2147479uad.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CLvgyomUpZlEO8BYtl3NgAehP7kguvsxyM5/iRNobE=;
        b=AJwaXk1MPGBy//iozCfMiqD/OUCmgrWvWdx6/PmGfzsENDKVnBQ7Rufvs5PwriwVIr
         htOcRzPlLNzTgY6DuDOXewm3Nq9f23UM8ACXb9gz6c7ZGtH1bpWlTtw9DBOoDDwHopEJ
         UEOhPbU444EyzA1wHcA0p6rfT87VSz5sowXdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CLvgyomUpZlEO8BYtl3NgAehP7kguvsxyM5/iRNobE=;
        b=ah6aFdjAtkeeNdn0TOCF/wa2T1ajqGS9n/+3CmZ41SAIG4fKYJsK/yk761g9Odwd6H
         xfJLEgUvCi4Q+SGHg22JzFBIhofH0EuU1mw6kKQWX3heXNOBbCYodb059rRbhCyq622m
         9XHBTHmmz6z7Ynm1I96PoU0xjVVTR7IMcKCu5l03bvn6OF9+ynM4D+3CLQnU5JalaIHO
         yBV+U2erlGxeWXQ27B8MeiTLE5kIg5c20TR7SoxchZaSiYdGRniOzsZpcV9Il0SBCImJ
         auZ17J1pj6JYA2Co5B969rvCijf4rq28dg1xQgtxun5NKs9MSW1Q6fyOD0MsrIq9SCA2
         2DPQ==
X-Gm-Message-State: ANhLgQ31t4E9sfV29z6RgW9Ac+0MQQ1BY5mC3ZRmIVA4+m8d3mK8Brr1
        Acp5d74QAqbFI95InMFQZoLzQJ0i1vo=
X-Google-Smtp-Source: ADFU+vsRS+j3a87aMNBMQoDeudweCOymPdOQM3ESMUDyUEzGiovSgeZ64W5TRrSbycPs4T0gjK6jGw==
X-Received: by 2002:ab0:65d3:: with SMTP id n19mr5668910uaq.48.1584711474020;
        Fri, 20 Mar 2020 06:37:54 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id i26sm3422491uak.17.2020.03.20.06.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:37:53 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] bluetooth: Enforce classic key size verification.
Date:   Fri, 20 Mar 2020 13:37:48 +0000
Message-Id: <20200320133748.154926-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change introduces a new configuration to strictly enforce key size
checks.  This ensures that systems are in a secured configuration by
default while allowing for a compatible posture via a Kconfig option to
support controllers who may not support the read encryption key size
command.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/Kconfig     | 20 ++++++++++++++++++++
 net/bluetooth/hci_core.c  | 10 ++++++++++
 net/bluetooth/hci_event.c |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 165148c7c4ce..8e177d4f3f02 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -128,4 +128,24 @@ config BT_DEBUGFS
 	  Provide extensive information about internal Bluetooth states
 	  in debugfs.
 
+config BT_EXPERT
+	bool "Expert Bluetooth options"
+	depends on BT
+	default n
+	help
+	  Provides a set of expert options and configurations that should
+	  only be used deliberately by BT experts.  This is considered a
+	  global switch to ensure these advanced features or options that
+	  depends on BT_EXPERT are only used in expert mode.
+
+config BT_ENFORCE_CLASSIC_KEY_SIZES
+	bool "Enforces security requirements for Bluetooth classic"
+	depends on BT && BT_EXPERT
+	default y
+	help
+	  Enforces Bluetooth classic security requirements by disallowing
+	  use of insecure Bluetooth controllers, i.e. that doesn't support
+	  Read Encryption Key Size command to prevent BT classic connection
+	  with very short encryption key.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4e6d61a95b20..142130d4b66b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1540,6 +1540,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 
 	clear_bit(HCI_INIT, &hdev->flags);
 
+#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
+	/* Don't allow usage of Bluetooth if the chip doesn't support */
+	/* Read Encryption Key Size command */
+	if (!ret && !(hdev->commands[20] & 0x10)) {
+		bt_dev_err(hdev,
+			   "Disabling BT, Read Encryption Key Size !supported");
+		ret = -EIO;
+	}
+#endif
+
 	if (!ret) {
 		hci_dev_hold(hdev);
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a40ed31f6eb8..54f90799a088 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2902,7 +2902,11 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 	if (rp->status) {
 		bt_dev_err(hdev, "failed to read key size for handle %u",
 			   handle);
+#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
+		conn->enc_key_size = 0;
+#else
 		conn->enc_key_size = HCI_LINK_KEY_SIZE;
+#endif
 	} else {
 		conn->enc_key_size = rp->key_size;
 	}
-- 
2.25.1.696.g5e7596f4ac-goog

