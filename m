Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 03:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1A36187D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 03:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhJAEBT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 00:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhJAEBT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 00:01:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBEBC06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 20:59:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 66so7833291pgc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 20:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3I6UaDAWyC0xJ5aLbjWxOfpYvVUOVoaj3FSq09LRVgg=;
        b=b5Zojm7vKnlm5MeZ4s9/GH6lwImX7n3I8G80pHcusbffXPIaYThOMVkMToHsKkbHNs
         0aq96LEg1PDEvP361KHAOliFK612tzcbCWzwg1DWM3hHysLA6LGYKaBlwn+Rkuu7uBEo
         TipUCShjBPVWbripdlhd/X56KwdU5KYR7KiCy5XsE4w3SAqkbpH40XhIAj8xww2+RgmT
         tPX0PlfIEz3nH8hkFk+5uDcT/7TZCG2+UMsXyBlIP4XB7Maeiydgba26vyIOcNXTU4BN
         3UV5IRWkJmxK/D8WjpYlKsP2K7tFH49kJDMxZR7dGgSYZtHVRGtJZXk82NPZH4dXlMnT
         Vr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3I6UaDAWyC0xJ5aLbjWxOfpYvVUOVoaj3FSq09LRVgg=;
        b=gy9BHjFRwSORtFjonIEj2jOd36RUrVufPXwRDq8IR/ADXX23ytGiDySnH/cGGgDVtQ
         7Cf+MVqDIPd9YSUkCWWvip5i7WAzkueoFntY4hjwVNR8cEuVU1dgH8ZKF7DlKuq6VASc
         iNuTiVXpz+QwTlsf4hW8zzgEOPnmP7/cxrB4df09plbMVfPY08hTWhOnUkneAHKmcfvZ
         ZRwPK+NVfZo3hj+r2H0pztw5dzbE/upm7FhfCyKDoN60bEMyTOSGU5LiA13utNgxGs87
         h8ayZ5XGBnohDU4wofRAOyVU+PEVdzGAcKvww/VZ9rOplAa6lC/MDVZEJjotQmhzY4UC
         nhDQ==
X-Gm-Message-State: AOAM531BRif/WkDdUgggvgYSlh+iWhfhLGXL4/l1THGWXonaPlXrpBYl
        GhK5r05XLhHBHFmWqs2JCCxWqw85P+U=
X-Google-Smtp-Source: ABdhPJwTrZ3iqm7wzG+bbIBPTX9JAdJOoYMtuMzknGwBMe85D+Dp3gGqT/vJMkQt2QNFqB4siVTzJA==
X-Received: by 2002:a63:f84f:: with SMTP id v15mr7986297pgj.204.1633060774781;
        Thu, 30 Sep 2021 20:59:34 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:5f38:eae3:6b80:5a92])
        by smtp.gmail.com with ESMTPSA id e15sm4399936pfc.134.2021.09.30.20.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 20:59:34 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH] Bluetooth: hci_sock: Set flag to all sockets
Date:   Thu, 30 Sep 2021 20:59:31 -0700
Message-Id: <20211001035931.50485-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The mgmt_limited_event() send the event to the socket that matches the
flag type, but also it skips to the given socket object in the
parameter.

For Local Out of Band Data Updated Event and Experimental Feature
Changed Event, it sets flags only for the socket which the change was
triggered, the event cannot be sent to the client via any sockets
because the flag is not set for other sockets and it doens't send to the
socket which the change was triggered.

This patch adds the function that sets the flag for all available
management sockets, so the mgmt_limited_event() still can send the event
to the management sockets other than the one through which the change
was triggered.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_sock.c          |  9 +++++++++
 net/bluetooth/mgmt.c              | 16 ++++++++--------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 3271870fd85e..e7ff29842137 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -513,6 +513,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 int bt_to_errno(u16 code);
 
 void hci_sock_set_flag(struct sock *sk, int nr);
+void hci_sock_set_flag_all(int nr);
 void hci_sock_clear_flag(struct sock *sk, int nr);
 int hci_sock_test_flag(struct sock *sk, int nr);
 unsigned short hci_sock_get_channel(struct sock *sk);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 99de17922bda..eba86c141ced 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -162,6 +162,15 @@ static struct bt_sock_list hci_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(hci_sk_list.lock)
 };
 
+void hci_sock_set_flag_all(int nr)
+{
+	struct sock *sk;
+
+	sk_for_each(sk, &hci_sk_list.head) {
+		hci_sock_set_flag(sk, nr);
+	}
+}
+
 static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 {
 	struct hci_filter *flt;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3e5283607b97..333e2aa5b176 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3890,7 +3890,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	/* After reading the experimental features information, enable
 	 * the events to update client on any future change.
 	 */
-	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	hci_sock_set_flag_all(HCI_MGMT_EXP_FEATURE_EVENTS);
 
 	return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 				 MGMT_OP_READ_EXP_FEATURES_INFO,
@@ -3975,7 +3975,7 @@ static int set_zero_key_func(struct sock *sk, struct hci_dev *hdev,
 			exp_ll_privacy_feature_changed(false, hdev, sk);
 	}
 
-	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	hci_sock_set_flag_all(HCI_MGMT_EXP_FEATURE_EVENTS);
 
 	return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 				 MGMT_OP_SET_EXP_FEATURE, 0,
@@ -4016,7 +4016,7 @@ static int set_debug_func(struct sock *sk, struct hci_dev *hdev,
 	memcpy(rp.uuid, debug_uuid, 16);
 	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
 
-	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	hci_sock_set_flag_all(HCI_MGMT_EXP_FEATURE_EVENTS);
 
 	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
 				MGMT_OP_SET_EXP_FEATURE, 0,
@@ -4082,7 +4082,7 @@ static int set_rpa_resolution_func(struct sock *sk, struct hci_dev *hdev,
 	memcpy(rp.uuid, rpa_resolution_uuid, 16);
 	rp.flags = cpu_to_le32(flags);
 
-	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	hci_sock_set_flag_all(HCI_MGMT_EXP_FEATURE_EVENTS);
 
 	err = mgmt_cmd_complete(sk, hdev->id,
 				MGMT_OP_SET_EXP_FEATURE, 0,
@@ -4150,7 +4150,7 @@ static int set_quality_report_func(struct sock *sk, struct hci_dev *hdev,
 
 	memcpy(rp.uuid, quality_report_uuid, 16);
 	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
-	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	hci_sock_set_flag_all(HCI_MGMT_EXP_FEATURE_EVENTS);
 	err = mgmt_cmd_complete(sk, hdev->id,
 				MGMT_OP_SET_EXP_FEATURE, 0,
 				&rp, sizeof(rp));
@@ -4223,7 +4223,7 @@ static int set_offload_codec_func(struct sock *sk, struct hci_dev *hdev,
 
 	memcpy(rp.uuid, offload_codecs_uuid, 16);
 	rp.flags = cpu_to_le32(val ? BIT(0) : 0);
-	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+	hci_sock_set_flag_all(HCI_MGMT_EXP_FEATURE_EVENTS);
 	err = mgmt_cmd_complete(sk, hdev->id,
 				MGMT_OP_SET_EXP_FEATURE, 0,
 				&rp, sizeof(rp));
@@ -7460,7 +7460,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 	if (err < 0 || status)
 		goto done;
 
-	hci_sock_set_flag(cmd->sk, HCI_MGMT_OOB_DATA_EVENTS);
+	hci_sock_set_flag_all(HCI_MGMT_OOB_DATA_EVENTS);
 
 	err = mgmt_limited_event(MGMT_EV_LOCAL_OOB_DATA_UPDATED, hdev,
 				 mgmt_rp, sizeof(*mgmt_rp) + eir_len,
@@ -7636,7 +7636,7 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_unlock(hdev);
 
-	hci_sock_set_flag(sk, HCI_MGMT_OOB_DATA_EVENTS);
+	hci_sock_set_flag_all(HCI_MGMT_OOB_DATA_EVENTS);
 
 	status = MGMT_STATUS_SUCCESS;
 
-- 
2.25.1

