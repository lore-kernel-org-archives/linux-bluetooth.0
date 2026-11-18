Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029096;
	b=UppWJPtKPQiyDJHlhP3QmklZ6fbvPoBp0jy5gED5eFfcLIkB+7Jg06RRZk+s1idfjk6M
	 ZoqEJ8D4exWwvGA8ld/XY29Ue8Szyu38LSDwi7zXEwYdyfNlWmKQNWaM378gzLkRlmVgY
	 oYf+3g3vrcXVxOC8ts2S/tAw3JFKUSD9IVo6rv42nh7AL1b4x6y/sf2dvySDgKBPJ0Vmw
	 ltGRjiE/AhBMkxGw00qvwzDaIp3CWeuNgXlqHHgTefViU+XzjYdg3asakSO3kdrTllC/e
	 aT/JZFjYkHdoZNJXL3HPopz6TN8d8IXYU7DqcZGmKtxctGUea3Ru5fl7wSxm4Lh858A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
	b=bYJPq3yN7JkM8+/GR6bekOLNODIhqmrLnmH3R5v1+Pq1WAozNSB0kNzwvKYEqYEBIm89
	 CWC+cHS1Bpuv4t9ZMgPy1WN0AmsMzeauxHi4xr26ih7+IbnOMju8ImMQyQEQucP8u3mPg
	 IJ3P+tC8L7CpNKkcZXVe/hDOUT2r+nAYPNwsaPrOVNiBYX2fKBhRVWhVCUS5m4cyyx3oz
	 YOPtReXY8RjR979y5W/ZfXaw98Sk+7KYqGuLPeXNNKcVkc9BL+zClJ3gBrjD0ZlGYHV9/
	 udG3HyeTV87kTPV6ScGTslvJqbFyqEEjGnPo3W9p1oorCSkvO1KmbVOhWO0MXr9WcrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAzClWQw;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3D606A338
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD3D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAzClWQw
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ece3ab2e91so495780e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029095; x=1795633895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
        b=AAzClWQwvnDWGNz7c21/4Yfn8GjXQ89CG7Z+5YDjZmLvG0RIQAtEqVklBIV+4yYYDw
         21sD6ispbA+/TjmiVaYTdo217UIaZO7ckjMOKoYTvVaKO/FfCeu4D4gudf8okluLg1L3
         ccOSOxdURVNFjXmhS8LGSrAruIXmxPKa93xwq1f0ZpjAwogbNWFXM7+MO2RkCt/DYoj3
         M3Tcwdvhe058eTLAg5U7FsnVd0oyMIntfV0BGJHn2JvkwID+6rcdqq0nBxFtl7AsVEyh
         Rsuf/7EtISsPAzZzj76OUsM2rYB3dH0Qsm3eKP9knuGeo5YRYqoA9UccMA/tFSG9qsOg
         JeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029095; x=1795633895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
        b=haXZQb79YNePPedVc9l1FuCrk5Op/eZlIRVnBvmf/WN1VQH/QRP3TJMSvltTlcsv7B
         B2scPNUIyp4mAjbq86jlv0vy3C0vKsZOqAlzutaN8qyFY3ABWYXsIqCNzm+m6/AN0Saf
         9f0GAlBnk8/HP9H8aLGMrycp5gLxGsJ0ZmgiUqoKRDbJ1kCjy68zrXqzikUmfHpMBSJJ
         YUli5ibNQ1nrDIU/JaEUGpPNCRmaRRUBkhQyI/giq/taatA4Z+4GPYJ5l7el6jeo3v4n
         FLddShsoNS3JMkG9A+dD/4aQu2A+Vwan9bgCmmHuxt/hmKwu9bChfxZnWB6/BywQqWfq
         t0HQ==
X-Gm-Message-State: APuU4Z/XhUMXRSgz84D57kP9EgcdNeCIgn2RE2Zwue0uABZuzBuezn2K
	gDjAsGuXcMd/lOdLPHsOb+QECmlue9gVXiHYUtuPJv+rODPhXi4tSovLCoc1QovT
X-Gm-Gg: AYBFou3AEniqMJO9SBusC+4NzfV9isN3MyRFwkp3aM10aNG6h/a3gWnTrn+Y18VvL12
	QNS9nZPowaRDtiwEO8IS4Ged90syIq8j1HTjpJhQq5Nx/1An9m2nFK2ooHcAYgIAq9YDqYy4G9h
	z6XOJPBQLZh9o/8DO28Z4AYTS68V2UP/zZk2Pl+afsQH60tQlWzNkQBynYEvFIeoiqNjXYtjm/+
	9/h4r/LOcQfXxfhSnnsFLIvn7Prq0q6dgByn761IUXv7V9PvScNX4o5JLUEXqqYnjyZUa7FDO5Y
	uYoS3bOumVY2saLKHUNSZyIJUbY0PCU+ootoyAmtDzVMHK/zBDUPoUoZBBlGIIERWtO6kZ3liWi
	CbeyYgdCmcAVVomsyxwNMCP6gzsqYJFlNh/NsZZb6CbIATMqZ/tPmEamBEZBJ1zMI51DLCjDXD6
	/7uQAd/zf1effKyc8SsTuTg7ReURDQ6s1h8o/LNeHLpqPlhOhYWoVR09gVRSpIBPw7MabKoHkVb
	724Kqh/IVIzcjDf6WMtrbNMk7VDmlgTPYoGdPlR/vG3W+68Ih9gWHvHFSHJ17Fmvh1+vw3jJpyV
	f+8gV5ISOvkoPHjQvyoQlH4WnMTN6kAkg/+mC8ZJQQ1aRm9f9godL/zpXYboln7UMoVbV3F9BYZ
	MhOfVRllo6Aq8cHjjScRkfOEoDfmOSNX/UNLkClC4H+Kml1Hj97k+lB5zSyWQf4EO2WCePgBsbK
	rCdy8=
X-Received: by 2002:a05:6122:2802:b0:5d4:1193:73d3 with SMTP id 71dfb90a1353d-5ee646f866amr1823799e0c.14.1795029094595;
        Wed, 18 Nov 2026 11:11:34 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 14/17] Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
Date: Wed, 18 Nov 2026 14:11:15 -0500
Message-ID: <20261118191118.318779-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The debugfs writers checked the current state of the flag, then blindly
inverted it with hci_dev_change_flag(). Two concurrent writers both pass
the check and the second inversion undoes the first one, leaving the flag
out of sync with the actual controller/SMP channel state (e.g. DUT mode
flag vs controller, or the BR/EDR SMP channel being leaked or removed
twice).

Set or clear the flag explicitly instead, redo the dut_mode check under
hci_req_sync_lock() and serialize smp_force_bredr() with hdev->lock. The
same applies to the quirk attributes.

Reported-by: sashiko.dev (linux-442108d5-76ce-44a1-a84d-16b44d6a26a6)
Fixes: 4b4148e9acc1 ("Bluetooth: Add support for setting DUT mode")
Fixes: b55d1abf568c ("Bluetooth: Expose quirks through debugfs")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_debugfs.c | 32 +++++++++++++++++++++++++-------
 net/bluetooth/smp.c         | 25 +++++++++++++++++++------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index cd5ef398f238..1af68bfc2257 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -59,7 +59,7 @@ static ssize_t __name ## _write(struct file *file,			      \
 	if (enable == test_bit(__quirk, hdev->quirk_flags))		      \
 		return -EALREADY;					      \
 									      \
-	change_bit(__quirk, hdev->quirk_flags);				      \
+	assign_bit(__quirk, hdev->quirk_flags, enable);			      \
 									      \
 	return count;							      \
 }									      \
@@ -777,7 +777,10 @@ static ssize_t force_static_address_write(struct file *file,
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR))
 		return -EALREADY;
 
-	hci_dev_change_flag(hdev, HCI_FORCE_STATIC_ADDR);
+	if (enable)
+		hci_dev_set_flag(hdev, HCI_FORCE_STATIC_ADDR);
+	else
+		hci_dev_clear_flag(hdev, HCI_FORCE_STATIC_ADDR);
 
 	return count;
 }
@@ -1177,7 +1180,10 @@ static ssize_t force_no_mitm_write(struct file *file,
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_NO_MITM))
 		return -EALREADY;
 
-	hci_dev_change_flag(hdev, HCI_FORCE_NO_MITM);
+	if (enable)
+		hci_dev_set_flag(hdev, HCI_FORCE_NO_MITM);
+	else
+		hci_dev_clear_flag(hdev, HCI_FORCE_NO_MITM);
 
 	return count;
 }
@@ -1303,20 +1309,32 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 		return -EALREADY;
 
 	hci_req_sync_lock(hdev);
+
+	/* Check again now that concurrent writers are excluded */
+	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE)) {
+		hci_req_sync_unlock(hdev);
+		return -EALREADY;
+	}
+
 	if (enable)
 		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
 				     HCI_CMD_TIMEOUT);
 	else
 		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
 				     HCI_CMD_TIMEOUT);
-	hci_req_sync_unlock(hdev);
-
-	if (IS_ERR(skb))
+	if (IS_ERR(skb)) {
+		hci_req_sync_unlock(hdev);
 		return PTR_ERR(skb);
+	}
 
 	kfree_skb(skb);
 
-	hci_dev_change_flag(hdev, HCI_DUT_MODE);
+	if (enable)
+		hci_dev_set_flag(hdev, HCI_DUT_MODE);
+	else
+		hci_dev_clear_flag(hdev, HCI_DUT_MODE);
+
+	hci_req_sync_unlock(hdev);
 
 	return count;
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1c315c9ee7dd..ba3573964803 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3438,8 +3438,14 @@ static void smp_del_chan(struct l2cap_chan *chan)
 
 int smp_force_bredr(struct hci_dev *hdev, bool enable)
 {
-	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
-		return -EALREADY;
+	int err = 0;
+
+	hci_dev_lock(hdev);
+
+	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP)) {
+		err = -EALREADY;
+		goto unlock;
+	}
 
 	/* The channels are only registered while the controller is powered
 	 * and LE capable. Otherwise just record the flag, smp_register() will
@@ -3450,8 +3456,10 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 
 		if (hdev->smp_data && !hdev->smp_bredr_data) {
 			chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
-			if (IS_ERR(chan))
-				return PTR_ERR(chan);
+			if (IS_ERR(chan)) {
+				err = PTR_ERR(chan);
+				goto unlock;
+			}
 
 			hdev->smp_bredr_data = chan;
 		}
@@ -3465,9 +3473,14 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 		}
 	}
 
-	hci_dev_change_flag(hdev, HCI_FORCE_BREDR_SMP);
+	if (enable)
+		hci_dev_set_flag(hdev, HCI_FORCE_BREDR_SMP);
+	else
+		hci_dev_clear_flag(hdev, HCI_FORCE_BREDR_SMP);
 
-	return 0;
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
 }
 
 int smp_register(struct hci_dev *hdev)
-- 
2.56.0

