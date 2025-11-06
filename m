Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C212DF14D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470597; cv=none; b=rHQk3vAkDTO7h3yHaPP6Ru/6+A6XYPUqnJ1X2QjKi1lEV1palWKrSsp05Mvfb0CDs5gGgessAN7AoXq2u+9hNGXfUl54KGoC1GOAEI7b33dnqzK5nxMLG4wxV7y4R1qcu/cF2zcSTIFNxEbWZMtiMqPihBXBNaK68EQXIK/x6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470597; c=relaxed/simple;
	bh=R1qn/bTc7EK5BvDLXyigJ+iB5Tc1+bZps32FdpYmwG8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XBFXF0BF3EzFmhiTNlGpDDxM/TGkbpMIkJu4Q4bsh8V/hx+nd8prI09lY9c+VWZVqOPYPGbvCeEK6WMZiPgsIlfEXYZgtwSl25IkeF0Jl7bubfTolrBHUc1FVGAUmBYGeLRqWfWhS8hCbG9bC6xwHnQW3x1iNo51o43aBRwcgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmQpBne6; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmQpBne6"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5598c430b75so102117e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762470593; x=1763075393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GpVmvcfcmd3oYaaX8GTYcJPIAZ4XE4YCqauCE1R3dE=;
        b=fmQpBne6NvNV9LnWOT77FPMjEZidyLmyGlRbr3JfZB4x+H3+Jn4qK8e/2TTc+6gCjR
         FkvI45ENxkFePeXKfEYxb7W04cEPDfSpenb1j+2Sdoa+c4EL3z1ipqKh8NariLMyEko+
         6HExwW7ysft2fuDvs2lBDeii4m4/2Jy7/rWHVyZILZeBdj/q24UlrR+TZhNC9f3rt5oF
         FSwBbxSa+kAclvkpmOfkN5qIFek18g5NeBcjpsXaonNXtuWIZi+A7h8D4/fn+q1i1c8Z
         NTYGgfI4PFYIwmbo0IZdiUNtZY1+akz5LzdmNdJ1tvtkBmC9y2IqcI0WHWLGGBPcevtT
         EAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470593; x=1763075393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GpVmvcfcmd3oYaaX8GTYcJPIAZ4XE4YCqauCE1R3dE=;
        b=J2oKAg0eOHqLNvEJ99ZGcfq3loy2Ahr8QZmWRVZWM98tYi+iRinvvbaq5GSKF6eqEG
         Q2RDw0Bxk56DqcawmGazVqtpZAUwKmCsE7TPgiysvbDmOXSjpmrMN1gKf69zwSJCJACb
         1ogZiFddp0JGkCf4HYn9DNUusJMQQEwp4Byx6jI92TlunCrW7R7S77T0U9QA/Mlwv4Eh
         BzH2yXHEHHwyW4IAEkWExciMkDPFHuNH+NO4m/JXZ2dG/NIo+UcHACRgXB0JBUlkQY34
         bF5Nl0cFSUBBpmnlW5cMzyw+BCpMehrWyrKTOz/aO2LxugXBhaerulGt/b1KHQ+lJG/m
         3AGQ==
X-Gm-Message-State: AOJu0YyoqByL+nufs6WXkxL6miRIkYr5zHM1VNdZdn7kMF/YUYRsFDLA
	xilnPRddo4lT95nlNaBvEPE4ALHl7MivBNVq61+ndMu3QeGdM0YIxHyFcPRorQ==
X-Gm-Gg: ASbGncv+BqdRFVsPgeYbTAF+6DiWcvutXWwMZCfZe2xr37GlNrJhU+jZDSaSewJqWk5
	molZVIJtUx5mLINBykVXgdMdpsTjD9hZUrXXHPtA4dGOYOlZO/Got0abEt3c1dOO2JUcRV3we2s
	s9re9ffuKF/HzD05b3zru0AStCdQF4b+yVDUrLx4B9hv1Xexvfsii4p6vujhK8cda1Bb63Xxwmo
	Xt+kNlxp83MpwVygH5WXXIa+2H+CRtGYY+VXDpoklfr5SovCTneG2YtS3GcKnV/vUJQlvAuqBr8
	z6FzLHaUavXGZz0KqYfNlL7KN+vfkGaYLUl7M9UpYASI+sY9EMMe+yvhbAgh4QrcuxSYYAXAHkd
	qd41eudNsw4SnDorkuBdHmDyCc7MJGQLPUUdXKZ9XHgPH9KfL9Ed3EUT/P0vg4XwWpigjTiY+xA
	TxVQ0=
X-Google-Smtp-Source: AGHT+IHJ9ZgCpwNXVoHfkeG7D8z0q3qi1ujjMVVvcLwdjb8s06ZK3+TUYSikZxMtf65+9fMdPPcGZg==
X-Received: by 2002:a05:6122:20a7:b0:559:6b62:8a1d with SMTP id 71dfb90a1353d-559a3c35001mr546694e0c.11.1762470593403;
        Thu, 06 Nov 2025 15:09:53 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm2163644e0c.16.2025.11.06.15.09.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:09:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
Date: Thu,  6 Nov 2025 18:09:42 -0500
Message-ID: <20251106230943.877242-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Contrary to what was stated on d36349ea73d8 ("Bluetooth: hci_conn:
Fix running bis_cleanup for hci_conn->type PA_LINK") the PA_LINK does
in fact needs to run bis_cleanup in order to terminate the PA Sync,
since that is bond to the listening socket which is the entity that
controls the lifetime of PA Sync, so if it is closed/released the PA
Sync shall be terminated, terminating the PA Sync shall not result in
the BIG Sync being terminated since once the later is established it
doesn't depend on the former anymore.

If the use user wants to reconnect/rebind a number of BIS(s) it shall
keep the socket open until it no longer needs the PA Sync, which means
it retains full control of the lifetime of both PA and BIG Syncs.

Fixes: d36349ea73d8 ("Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK")
Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 33 +++++++++++++++++++--------------
 net/bluetooth/hci_event.c |  7 +------
 net/bluetooth/hci_sync.c  |  2 +-
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0b86aaddfb02..c3f7828bf9d5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -769,21 +769,23 @@ static void find_bis(struct hci_conn *conn, void *data)
 	d->count++;
 }
 
-static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *conn)
+static int hci_le_big_terminate(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	struct iso_list_data *d;
 	int ret;
 
-	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, conn->sync_handle);
+	bt_dev_dbg(hdev, "hcon %p big 0x%2.2x sync_handle 0x%4.4x", conn,
+		   conn->iso_qos.bcast.big, conn->sync_handle);
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
-	d->big = big;
+	d->big = conn->iso_qos.bcast.big;
 	d->sync_handle = conn->sync_handle;
 
-	if (test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags)) {
+	if (conn->type == PA_LINK &&
+	    test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags)) {
 		hci_conn_hash_list_flag(hdev, find_bis, PA_LINK,
 					HCI_CONN_PA_SYNC, d);
 
@@ -801,6 +803,9 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 			d->big_sync_term = true;
 	}
 
+	if (!d->pa_sync_term && !d->big_sync_term)
+		return 0;
+
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);
 	if (ret)
@@ -852,8 +857,7 @@ static void bis_cleanup(struct hci_conn *conn)
 
 		hci_le_terminate_big(hdev, conn);
 	} else {
-		hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
-				     conn);
+		hci_le_big_terminate(hdev, conn);
 	}
 }
 
@@ -1006,19 +1010,20 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 		conn->mtu = hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
 		break;
 	case CIS_LINK:
-	case BIS_LINK:
-	case PA_LINK:
 		/* conn->src should reflect the local identity address */
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
 
-		/* set proper cleanup function */
-		if (!bacmp(dst, BDADDR_ANY))
-			conn->cleanup = bis_cleanup;
-		else if (conn->role == HCI_ROLE_MASTER)
+		if (conn->role == HCI_ROLE_MASTER)
 			conn->cleanup = cis_cleanup;
 
-		conn->mtu = hdev->iso_mtu ? hdev->iso_mtu :
-			    hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
+		conn->mtu = hdev->iso_mtu;
+		break;
+	case PA_LINK:
+	case BIS_LINK:
+		/* conn->src should reflect the local identity address */
+		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
+		conn->cleanup = bis_cleanup;
+		conn->mtu = hdev->iso_mtu;
 		break;
 	case SCO_LINK:
 		if (lmp_esco_capable(hdev))
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6edeebe46d94..51c23264ee2f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7056,14 +7056,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 				continue;
 		}
 
-		if (ev->status != 0x42) {
+		if (ev->status != 0x42)
 			/* Mark PA sync as established */
 			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
-			/* Reset cleanup callback of PA Sync so it doesn't
-			 * terminate the sync when deleting the connection.
-			 */
-			conn->cleanup = NULL;
-		}
 
 		bis->sync_handle = conn->sync_handle;
 		bis->iso_qos.bcast.big = ev->handle;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1cbdd2ce03f2..a36d2414a3ca 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7006,7 +7006,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_dev_lock(hdev);
 
-	if (!hci_conn_valid(hdev, conn))
+	if (hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
 	if (!err)
-- 
2.51.0

