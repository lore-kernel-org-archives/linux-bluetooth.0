Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F286C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 05:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3F120856
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 05:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ice9-us.20150623.gappssmtp.com header.i=@ice9-us.20150623.gappssmtp.com header.b="Vl+e4+/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfKKFWy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:22:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38596 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKFWy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 00:22:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so8706653pgh.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Nov 2019 21:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ice9-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fQ8nY0iOajZyRBJjwagQBzwgBLZiQ4gO/7gFdPx+Mnk=;
        b=Vl+e4+/0GubjvvmJ1tmU3zTr+v+Djo51JK6URivNHeDlU/pPeHgFXQEpPrhHLyCb/a
         NJvhZDjEk+QkfHOAflfskkcs/YYIH91YupzoDK1mh06CO15YW5zKRsja8YMeGudTKKtB
         gzXeM7SHW947sIxdY025XcmFHLrj8jm7oLHp+D7lZbfkSZS84pGceLDUNignh+1+8XKH
         GajJplxQcfhqg2eJ6TcLd7d6gFhJgclHWfRFDgE/r/esJDkUmgEd0ahzzVfnMccsugY7
         pVe8bzeDqIvWbuE43UD6zjmz0GRIy70ePLsuWWG4cNPAJB3Ygd8SPD+s/kO1PkBVa1uZ
         DTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fQ8nY0iOajZyRBJjwagQBzwgBLZiQ4gO/7gFdPx+Mnk=;
        b=SPuFzKvuwjhLF8MSNmS/aRJ9KUzCmHF2gwqKF9ne6TlNOd9FLGDoFeAaKnIfS+HHuP
         XhRi5PY1qrocofTHzcQDnnkyV4nsnsW96i9f9OMrHCo3fPkNGv0TEO378iMJwR8K/Ujl
         7llJ3Zd4dgvi1HKRIC8Wi0fB5R/WtcSkvV6vJhBi+/NjsG4veOYeBqB+bSYzglPoFLPc
         EHWRp5/6MQbo40BBkPIvYOw/KIDlwEJCHjmKLrUEy/rPIujI8EpgnB25Q9V5ClZwNrGL
         /RmWKzMDQ2SV6U+sIYThSHFRWz6QZhUnZ55a/cSGC/JmmoKE7qZaBLbJ6byJxMHWpvqK
         jQzQ==
X-Gm-Message-State: APjAAAXfFH847+jyNeC0sXe7U9MgVPcAy7ua4GF9h5GIlTm0fcxVY6IT
        ZqWA10N2kshoCBt8ZmV3KPju2u4Wl8Q=
X-Google-Smtp-Source: APXvYqzniiDmdp41jg/6U5DXqC2ooYE7/YBsNYpExup3ipTXT/oa779Wj1FMfk9I/qHvd8/z6ODcsA==
X-Received: by 2002:a17:90a:eb0f:: with SMTP id j15mr13814503pjz.97.1573449772960;
        Sun, 10 Nov 2019 21:22:52 -0800 (PST)
Received: from localhost.localdomain (c-67-188-68-101.hsd1.ca.comcast.net. [67.188.68.101])
        by smtp.gmail.com with ESMTPSA id a3sm2834645pfo.71.2019.11.10.21.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 21:22:52 -0800 (PST)
From:   mike@ice9.us
To:     linux-bluetooth@vger.kernel.org
Cc:     mike@ice9.us
Subject: [PATCH] Bluetooth: Expose debugfs entry to force resolvable private address
Date:   Sun, 10 Nov 2019 21:22:31 -0800
Message-Id: <20191111052231.31527-1-mike@ice9.us>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Mike Ryan <mike@ice9.us>

In order to facilitate impersonation attacks against devices using
resolvable private addresses (RPAs), this debugfs entry allows the user
to set a fixed RPA that is used during undirected and directed
advertising. Writing 00:00:00:00:00:00 disables the forced address and
will resume generating valid RPAs.

Signed-off-by: Mike Ryan <mike@ice9.us>
---
 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci_core.h  |  1 +
 net/bluetooth/hci_debugfs.c       | 53 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.c       | 23 +++++++++++------
 net/bluetooth/lib.c               | 52 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fabee6db0..c6417d15c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -237,6 +237,7 @@ static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
 }
 
 void baswap(bdaddr_t *dst, const bdaddr_t *src);
+int str2ba(const char *str, bdaddr_t *ba);
 
 /* Common socket structures and functions */
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb6..a822914d7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -428,6 +428,7 @@ struct hci_dev {
 	__u32			rpa_timeout;
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
+	bdaddr_t		force_rpa;
 
 #if IS_ENABLED(CONFIG_BT_LEDS)
 	struct led_trigger	*power_led;
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 402e2cc54..2363ae9bb 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -710,6 +710,57 @@ static const struct file_operations force_static_address_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t force_rpa_read(struct file *file,
+					 char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[19];
+	bdaddr_t *ba = &hdev->force_rpa;
+
+	sprintf(buf, "%pMR\n", ba);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t force_rpa_write(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[18];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bdaddr_t rpa;
+
+	if (test_bit(HCI_UP, &hdev->flags))
+		return -EBUSY;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (str2ba(buf, &rpa))
+		return -EINVAL;
+
+	// the two most significant bits shall be 01 unless the address is
+	// 00:00:00:00:00:00
+	if ((rpa.b[5] & 0xc0) != 0x40 && bacmp(&rpa, BDADDR_ANY))
+		return -EINVAL;
+
+	if (!bacmp(&hdev->force_rpa, &rpa))
+		return -EALREADY;
+
+	bacpy(&hdev->force_rpa, &rpa);
+
+	return count;
+}
+
+static const struct file_operations force_rpa_fops = {
+	.open		= simple_open,
+	.read		= force_rpa_read,
+	.write		= force_rpa_write,
+	.llseek		= default_llseek,
+};
+
 static int white_list_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1026,6 +1077,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 				    hdev->debugfs, hdev,
 				    &force_static_address_fops);
 
+	debugfs_create_file("force_rpa", 0644, hdev->debugfs, hdev,
+			    &force_rpa_fops);
 	debugfs_create_u8("white_list_size", 0444, hdev->debugfs,
 			  &hdev->le_white_list_size);
 	debugfs_create_file("white_list", 0444, hdev->debugfs, hdev,
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 2a1b64dbf..8fabb1bb1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1910,14 +1910,23 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
 
-		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
-		    !bacmp(&hdev->random_addr, &hdev->rpa))
-			return 0;
+		/* If force_rpa is set to 00:00:00:00:00:00, generate a valid
+		 * RPA using IRK. Otherwise use the forced value.
+		 */
+		if (!bacmp(&hdev->force_rpa, BDADDR_ANY)) {
+			if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
+			    !bacmp(&hdev->random_addr, &hdev->rpa))
+				return 0;
 
-		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
-		if (err < 0) {
-			bt_dev_err(hdev, "failed to generate new RPA");
-			return err;
+			err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+			if (err < 0) {
+				bt_dev_err(hdev, "failed to generate new RPA");
+				return err;
+			}
+		} else {
+			if (!bacmp(&hdev->rpa, &hdev->force_rpa))
+				return 0;
+			bacpy(&hdev->rpa, &hdev->force_rpa);
 		}
 
 		set_random_addr(req, &hdev->rpa);
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 63e65d9b4..933d9dd48 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -27,6 +27,7 @@
 #define pr_fmt(fmt) "Bluetooth: " fmt
 
 #include <linux/export.h>
+#include <linux/ctype.h>
 
 #include <net/bluetooth/bluetooth.h>
 
@@ -41,6 +42,57 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src)
 }
 EXPORT_SYMBOL(baswap);
 
+static int bachk(const char *str)
+{
+	if (!str)
+		return -1;
+
+	if (strlen(str) != 17)
+		return -1;
+
+	while (*str) {
+		if (!isxdigit(*str++))
+			return -1;
+
+		if (!isxdigit(*str++))
+			return -1;
+
+		if (*str == 0)
+			break;
+
+		if (*str++ != ':')
+			return -1;
+	}
+
+	return 0;
+}
+
+int str2ba(const char *str, bdaddr_t *ba)
+{
+	int i;
+	char digit_str[3];
+	long digit;
+
+	if (bachk(str) < 0) {
+		memset(ba, 0, sizeof(*ba));
+		return -1;
+	}
+
+	for (i = 5; i >= 0; i--, str += 3) {
+		digit_str[0] = str[0];
+		digit_str[1] = str[1];
+		digit_str[2] = '\0';
+		if (kstrtol(digit_str, 16, &digit))
+			return -1;
+		if (digit < 0x00 || digit > 0xff)
+			return -1;
+		ba->b[i] = digit;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(str2ba);
+
 /* Bluetooth error codes to Unix errno mapping */
 int bt_to_errno(__u16 code)
 {
-- 
2.11.0

