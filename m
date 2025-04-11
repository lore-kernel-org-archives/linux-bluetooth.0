Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07F21D3FB
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390582; cv=none; b=X0BJ3IF6RZsqF2OgEUKDKQM2vvmIEFxqxz2JALHpClRa9wmr7a3BS7t+A+uTwHzHyHWIClwQ3buImZ0fyIKb4lVLFSPLw0KZV7az2AYk3QlGGVYVxt94NyaGH8zqFWCtCCLNjp0K+ikUEEYXqhC+X1hsBq0Qph5OTQ+bi8VpSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390582; c=relaxed/simple;
	bh=/zVdl8eHvTMIm7u7A0aY1bEvwh+HdSGFyjZdmd16jHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhPkanma0f1Y/TU+E8K4YXfqwZ67O4Rs3xQNV25Azwr9tBWQcvx4643U1fwLSUYaVG1boF8KUlf04aj5xntw1EFeKoHa02oOOlBs4iT5pkpxveeuXtYNicah+lqJvd/OTwxKAtw3mBPFD57re1a2cyehn07Fjl+nnQCv1wOAwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7gCGxWh; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7gCGxWh"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5240764f7c1so852847e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744390578; x=1744995378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2a/VjVT0Wf1HLzKz53ewFEkLK986HbnWbvdoa/UlR4=;
        b=L7gCGxWhQidOR/dqEMhqrILUkugS9XGSlNFs2Ky1UXrRqGbjit5K7oMClMXGZu42Vy
         kqibytC6Etfo58L5kfBEJpjSZvjKeqqYLE1GA8/Ch1l3iYDgPuw810AxJ/koQu4OebeQ
         mMhml+LwV7oqYhGo4urP6JMCD5GJzMcLD3pmxZ1brFKpVjTCKsecrsA1KOul1ZfYkZZb
         nZg5bOuTanD+LbjgnbS47dn2JF3eBelCGM13FM1mIWuCEziuU/OUUXJUJx6W+bySgDWX
         erXG034u8rK06PAFv1j+XIBkt8D8Z7PJmKqS0Jimwy1clfsVNIjiieKo/yNCZCxIcMDF
         GqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390578; x=1744995378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2a/VjVT0Wf1HLzKz53ewFEkLK986HbnWbvdoa/UlR4=;
        b=KHGDMLo4KkOILAiI45dcFCDEB7PkJgUrxyUbMIA4uwHVmo/AqwE9y0o5w4SRUB4pvk
         NMPQJXYvnxE9u91UG6lEs7lj/1YDrbWDNksrEtarpH28rR2X7ePDzZNecjnSSOekDSxj
         FcOp+ZKRn6l5S5g96o7PMw6NRcD8m1sEPMS/33spDFbKMXuhjvBcL/OCojAcY93c9uHy
         kjuEpNDo3is2FemSwEqotYzzIE5+GtToGtXPS20+iAvXMkjdMKqvmz430iZ5dRIHmkpG
         HufA8jAWWIe+WyTzYQBQC+nCrhuwbeSWYB7BLwYfIppAIbUqag7gUZ0U5U+i6RfmYCjB
         r4MQ==
X-Gm-Message-State: AOJu0Ywol9DGKxXMQTVrZ1xMbUM2AVGzVPoPacKdiBsrfCxVjFm0hvNz
	TVke+576JnlNb2J2bC9aICXcB88pMKXVtPsbH4oenp89r//CUvFqBDUdPVMD
X-Gm-Gg: ASbGncs/1HAzAC9ONfXTUG+cXJ4tbEtcsd2jrCpSajQ2nh4ci05UuizgJqC3zUsixwq
	IiB1O2HkBy/BUJz5+wWXuZegzBVLUWraZ2S39QEriqGRq06ptx8kTAY11imz/OPsWabY0kpbSn2
	XDWvMjiYUczFi8haEt+JvtCgYHUDFHF8/49GirKBPL/CHkG/wn90FnMupXgcrhAxwPKR54d3wmW
	tU3kcPd/+U/pqHeQL7cfqKcUWDK62KJc+j67QEN6/agxz1IM1gEBpdc9lDMmpKaM4JpeSv4mxyW
	RUNOD3wKU65n7VI9fCYgx3g/Umzzys46SVvOw+7c27Sv8K0waIRYHIP+o5+QBfgg88CpTEN53FY
	otYkG/Z15HQ==
X-Google-Smtp-Source: AGHT+IFM0jdZkVwsnRIKqygBbCzibvSdHwlyAoTdn49EfcloAFUoK4Oy1RgfpssrXX5IM3Gu5gMSrQ==
X-Received: by 2002:a05:6122:179c:b0:520:51a4:b84f with SMTP id 71dfb90a1353d-527c34a884cmr2544636e0c.4.1744390578523;
        Fri, 11 Apr 2025 09:56:18 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d74bsm1160923e0c.35.2025.04.11.09.56.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:56:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: ISO: Fix not using SID from adv report
Date: Fri, 11 Apr 2025 12:56:07 -0400
Message-ID: <20250411165608.871089-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411165608.871089-1-luiz.dentz@gmail.com>
References: <20250411165608.871089-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Up until now it has been assumed that the application would be able to
enter the advertising SID in sockaddr_iso_bc.bc_sid, but userspace has
not access to SID since the likes of MGMT_EV_DEVICE_FOUND cannot carry
it, so it was left unset (0x00) which means it would be unable to
synchronize if the broadcast source is using a different SID e.g. 0x04:

> HCI Event: LE Meta Event (0x3e) plen 57
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0000
            Props: 0x0000
            Data status: Complete
          Address type: Random (0x01)
          Address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
          Primary PHY: LE 1M
          Secondary PHY: LE 2M
          SID: 0x04
          TX power: 127 dBm
          RSSI: -55 dBm (0xc9)
          Periodic advertising interval: 180.00 msec (0x0090)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1f
        06 16 52 18 5b 0b e1 05 16 56 18 04 00 11 30 4c  ..R.[....V....0L
        75 69 7a 27 73 20 53 32 33 20 55 6c 74 72 61     uiz's S23 Ultra
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 14748507 (0xe10b5b)
        Service Data: Public Broadcast Announcement (0x1856)
          Data[2]: 0400
        Unknown EIR field 0x30[16]: 4c75697a27732053323320556c747261
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00 (<- Invalid)
        Adv address type: Random (0x01)
        Adv address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000

So instead this changes now allow application to set HCI_SID_INVALID
which will make hci_le_pa_create_sync to wait for a report, update the
conn->sid using the report SID and only then issue PA create sync
command:

< HCI Command: LE Periodic Advertising Create Sync
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x04
        Adv address type: Random (0x01)
        Adv address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 64
        Advertising SID: 0x04
        Advertiser address type: Random (0x01)
        Advertiser address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 180.00 msec (0x0090)
        Advertiser clock accuracy: 0x05

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c  | 13 +++++++------
 net/bluetooth/hci_event.c | 11 +++++++++++
 net/bluetooth/hci_sync.c  | 29 +++++++++++++++++++++++++++++
 net/bluetooth/iso.c       |  2 +-
 4 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5eb0600bbd03..75da6f6e39c9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4057,10 +4057,13 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	err = hci_send_frame(hdev, skb);
-	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, -err);
-		return;
+	if (hci_skb_opcode(skb) != HCI_OP_NOP) {
+		err = hci_send_frame(hdev, skb);
+		if (err < 0) {
+			hci_cmd_sync_cancel_sync(hdev, -err);
+			return;
+		}
+		atomic_dec(&hdev->cmd_cnt);
 	}
 
 	if (hdev->req_status == HCI_REQ_PEND &&
@@ -4068,8 +4071,6 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
-
-	atomic_dec(&hdev->cmd_cnt);
 }
 
 static void hci_cmd_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea7ccafd055a..79afa32ae71c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6340,6 +6340,17 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 			info->secondary_phy &= 0x1f;
 		}
 
+		/* Check if PA Sync is pending and if the hci_conn SID has not
+		 * been set update it.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
+			struct hci_conn *conn;
+
+			conn = hci_conn_hash_lookup_create_pa_sync(hdev);
+			if (conn && conn->sid == HCI_SID_INVALID)
+				conn->sid = info->sid;
+		}
+
 		if (legacy_evt_type != LE_ADV_INVALID) {
 			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 35da71f63fb4..9048c2745548 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6908,6 +6908,8 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct hci_conn *pa_sync;
+
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (!err)
@@ -6922,6 +6924,22 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_update_passive_scan_sync(hdev);
 
+	if (!err)
+		goto unlock;
+
+	/* Add connection to indicate PA sync error */
+	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
+				     HCI_ROLE_SLAVE);
+
+	if (IS_ERR(pa_sync))
+		goto unlock;
+
+	set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
+
+	/* Notify iso layer */
+	hci_connect_cfm(pa_sync, bt_status(err));
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -6935,6 +6953,9 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	if (!hci_conn_valid(hdev, conn))
 		return -ECANCELED;
 
+	if (conn->sync_handle != HCI_SYNC_HANDLE_INVALID)
+		return -EINVAL;
+
 	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
 		return -EBUSY;
 
@@ -6946,6 +6967,14 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 	hci_update_passive_scan_sync(hdev);
 
+	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
+	 * it.
+	 */
+	if (conn->sid == HCI_SID_INVALID)
+		__hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					 HCI_EV_LE_EXT_ADV_REPORT,
+					 conn->conn_timeout, NULL);
+
 	memset(&cp, 0, sizeof(cp));
 	cp.options = qos->bcast.options;
 	cp.sid = conn->sid;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3501a991f1c6..ef93f1286f03 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -941,7 +941,7 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
 
-	if (sa->iso_bc->bc_sid > 0x0f)
+	if (sa->iso_bc->bc_sid > 0x0f && sa->iso_bc->bc_sid != HCI_SID_INVALID)
 		return -EINVAL;
 
 	iso_pi(sk)->bc_sid = sa->iso_bc->bc_sid;
-- 
2.49.0

