Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D024EC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A325121927
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VnkJlHEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCJPLK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:11:10 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46347 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJPLJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 11:11:09 -0400
Received: by mail-vs1-f66.google.com with SMTP id z125so4706809vsb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNXEQGaNpkibSZ5F8FBJ0o64fecKUpZIKYmckFLpYj4=;
        b=VnkJlHEgNofWwp/YlNuD5hkCNoL5FFtXCfw7tNSg9tJE/jIeq71ziLQkbxU4H2Mo3G
         UEi+wmQ+MpHhvU5i1UBwg0KANGH4YJKJA8U/rv9e+0Rkh+gw3pyX/DmjVXTCW7x/VSi2
         fa1Qr/3TQfWIr/bbKge7l8qfGg+H5UgfMWlt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNXEQGaNpkibSZ5F8FBJ0o64fecKUpZIKYmckFLpYj4=;
        b=lDCs9D/52Bh8/iMJHqyxF+I0cQ/BktN788pR8V2xnfRZieImV3HonSuh8ayNxGqTPv
         ScLXHPSzPf5zT9ZTuHq+p28Eyx/62B8Sst+qhNFM5MDycmmm2e8UyaYT45b9XRfosGv1
         9x3aHkSezbiqFxRqFqUoPjIBBAY3QQ1DeDs79vh580P3f9pE+wl9m4ykvnCYfwI6sUT+
         BV82MyYE0ha9JddOmk1uY8aWjGYysj8RPT/2L3hAj3OomCemx6e6o+GORHk5BAirwRuv
         iTYZWtVFleyN3leGdgLI6GblEQ0NfN7n+mSj4/u76RlMyZiSc+thMCGHQ03r63CWJxxq
         qfzA==
X-Gm-Message-State: ANhLgQ2Bf1TR5yq6ejJQcKxr5YxcoFkgzjVm5OKgWNpsPvBg1xf18O5c
        HeBso5Y+gIdoxsnWX+ra0CCM2BS7bI0=
X-Google-Smtp-Source: ADFU+vuGkUZIBo2LHwqYp6wcYharXaTZZhWLBSiB2jOHZ/ovf/7WNKRNw7xilkgzFIrCHRsqYgBEMQ==
X-Received: by 2002:a67:e99a:: with SMTP id b26mr13298055vso.27.1583853066464;
        Tue, 10 Mar 2020 08:11:06 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id q25sm7710397uam.19.2020.03.10.08.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:11:05 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth: Enforce classic key size verification.
Date:   Tue, 10 Mar 2020 15:10:59 +0000
Message-Id: <20200310151100.134881-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
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

 net/bluetooth/Kconfig     | 10 ++++++++++
 net/bluetooth/hci_core.c  | 10 ++++++++++
 net/bluetooth/hci_event.c |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 165148c7c4ce..6a155b7b6fb2 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -128,4 +128,14 @@ config BT_DEBUGFS
 	  Provide extensive information about internal Bluetooth states
 	  in debugfs.
 
+config BT_ENFORCE_CLASSIC_KEY_SIZES
+	bool "Enforces security requirements for Bluetooth classic"
+	depends on BT
+	default y
+	help
+	  Enforces Bluetooth classic security requirements by disallowing use of
+	  insecure Bluetooth chips, i.e. that doesn't support Read Encryption
+	  Key Size command to prevent BT classic connection with very short
+	  encryption key.
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
index a40ed31f6eb8..6605da7ec72e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2902,7 +2902,12 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 	if (rp->status) {
 		bt_dev_err(hdev, "failed to read key size for handle %u",
 			   handle);
+#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
+		hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
+		hci_conn_drop(conn);
+#else
 		conn->enc_key_size = HCI_LINK_KEY_SIZE;
+#endif
 	} else {
 		conn->enc_key_size = rp->key_size;
 	}
-- 
2.25.1.481.gfbce0eb801-goog

