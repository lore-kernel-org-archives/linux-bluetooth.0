Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3627CC2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 08:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8B52075E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 08:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmBDYuCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDFI6o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:58:44 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38440 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDFI6n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 04:58:43 -0400
Received: by mail-pl1-f201.google.com with SMTP id r16so10603719pls.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lfcuc8W8/Uvf28snFxOT4FYXFWyQRAEGdgjXm/Niomc=;
        b=lmBDYuChgxxj4YzMcT6wMdjlfMoqL9o6jT19Go0n0f370zWVvAKJWRPCLd/tGA5Cxx
         2Abspe5CfcdyP9J5zB9ysPEBZNfqw1jn974izn0D0S7UO3RIcXXRpbW1JNQimnrh9Rng
         LQRlPdFTViEbjz+QT3JQGM5wBaNWD6k+0WEDRhp1V0L3NUntM+MGQ/8seZVqNjq+v2R8
         NHNJvI34HQlTPnv1MZay1HvAZGGxHtQtIOFin7iI0zYAxVDHkfokX9Ll3VaiiW2khkIx
         Vx9hDsS4ojl/BPVlEvRRIwghdty/7u7ynLPJHdu/sjjIhCEwCez06GrMd13brfZjkDAf
         KwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lfcuc8W8/Uvf28snFxOT4FYXFWyQRAEGdgjXm/Niomc=;
        b=ZUh8QGJlQxHLEA5IEX36PynPmgTWAm19s+/tDpfdb/F9sUONWk//2r5aXTfi5Wf7v2
         Nmy9Rq8G18V8P3CchwfJTfkm37a9S/ovqObqwRPTbF+Uqdzj1+LI6EyxdUqv6z8ulGFH
         n3uc1ApBC9kIyfQPg6ueo9Pz3nw5D2FsbrlTT1kOKV68PvdfdD/T/mVuWCHn18RRiQHN
         2dMnPbPRkf46wd11fAvyDK/oGXLrrnlXBLbTq+93TeO6Ardao03g33teOD+bkX7hu85S
         0iI6fn5owYM2C3ORRkEJk3PKo/eRascAXO1beKDny7v7T2HDiUnX4gFIOpnZ2bDxk+ql
         jJXQ==
X-Gm-Message-State: AGi0PuaxHFBE10mJbh89grPYbGv1kYOWDM0WsOSEjjiEF8wbbsySaMoT
        Cs8lS73xWw4nsrxoeLTrXbrK48faJTl1jXChjeP+P5oXy2z2xuZZJvcWcGILJ601QqY7K0XBISk
        D6XWSsGfTJyv98UB5QoXqRIEOYs8aYnJgI5JbBnX9TRx/Ywr5iyY9pdg9DH2Q2kZNdLz+xYuNWh
        Lk
X-Google-Smtp-Source: APiQypLP7XEJejTP0eeHM6gdsYaCjdt2N70Ny3lZoatYbbBgqdIpf1sNUTK89QQ+PYEUJPhgNYzwdUZq4xag
X-Received: by 2002:a65:6857:: with SMTP id q23mr19048657pgt.94.1586163521990;
 Mon, 06 Apr 2020 01:58:41 -0700 (PDT)
Date:   Mon,  6 Apr 2020 16:58:34 +0800
Message-Id: <20200406165542.v1.1.Ibfc500cbf0bf2dc8429b17f064e960e95bb228e9@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v1] Bluetooth: debugfs option to unset MITM flag
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The BT qualification test SM/MAS/PKE/BV-01-C needs us to turn off
the MITM flag when pairing, and at the same time also set the io
capability to something other than no input no output.

Currently the MITM flag is only unset when the io capability is set
to no input no output, therefore the test cannot be executed.

This patch introduces a debugfs option for controlling whether MITM
flag should be set based on io capability.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/smp.c         | 52 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 79de2a659dd69..5e183487c7479 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -298,6 +298,7 @@ enum {
 	HCI_FORCE_STATIC_ADDR,
 	HCI_LL_RPA_RESOLUTION,
 	HCI_CMD_PENDING,
+	HCI_ENFORCE_MITM_SMP,
 
 	__HCI_NUM_FLAGS,
 };
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d0b695ee49f63..4fa8b112fb607 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2396,7 +2396,8 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	/* Require MITM if IO Capability allows or the security level
 	 * requires it.
 	 */
-	if (hcon->io_capability != HCI_IO_NO_INPUT_OUTPUT ||
+	if ((hci_dev_test_flag(hcon->hdev, HCI_ENFORCE_MITM_SMP) &&
+	     hcon->io_capability != HCI_IO_NO_INPUT_OUTPUT) ||
 	    hcon->pending_sec_level > BT_SECURITY_MEDIUM)
 		authreq |= SMP_AUTH_MITM;
 
@@ -3402,6 +3403,50 @@ static const struct file_operations force_bredr_smp_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t enforce_mitm_smp_read(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_ENFORCE_MITM_SMP) ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t enforce_mitm_smp_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf) - 1));
+	bool enable;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable == hci_dev_test_flag(hdev, HCI_ENFORCE_MITM_SMP))
+		return -EALREADY;
+
+	hci_dev_change_flag(hdev, HCI_ENFORCE_MITM_SMP);
+
+	return count;
+}
+
+static const struct file_operations enforce_mitm_smp_fops = {
+	.open		= simple_open,
+	.read		= enforce_mitm_smp_read,
+	.write		= enforce_mitm_smp_write,
+	.llseek		= default_llseek,
+};
+
 int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
@@ -3426,6 +3471,11 @@ int smp_register(struct hci_dev *hdev)
 
 	hdev->smp_data = chan;
 
+	/* Enforce the policy of determining MITM flag by io capabilities. */
+	hci_dev_set_flag(hdev, HCI_ENFORCE_MITM_SMP);
+	debugfs_create_file("enforce_mitm_smp", 0644, hdev->debugfs, hdev,
+			    &enforce_mitm_smp_fops);
+
 	/* If the controller does not support BR/EDR Secure Connections
 	 * feature, then the BR/EDR SMP channel shall not be present.
 	 *
-- 
2.26.0.292.g33ef6b2f38-goog

