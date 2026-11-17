Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941872;
	b=nhXWi0GVSPD5c+5KXbR5BRzRTdDB1vYJC9gE93yd0DTBRaKro6gst0eDLkHfOFlZ64IF
	 /NSe9sYz02ITrpevH7JgjQHoaS5Epk2k3j9lRomlDQmXiLO/QnqWSRCaxnSySS5VbW7Kt
	 VGgBdrnTsaVSCff28e7KYiNLmC4FTziG+wIWX/Kqi35FtxjyyqC2sHHI7y87Ji8flMAE2
	 86yBUCQn2xuoI2ZzFefobCxnmJ4EXCh/OPJ8edpiQEQYYto162GpUPl1pERGBabs1XzoE
	 xjNFuEneLbRprXHtwfIQxNDyZXpT9DkD61tGgUcTgE1yzDKGe2jOK1AjAQ0snDU6YlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6rPM2zYiBERTNTN+x4MxTceFG5PhHtt6lZOMnNbeFBU=;
	b=pmoBWdmI+KcbThzg9J7kOpaK7CVYQCqAavxCgR6WxP2q/cuFJIlC9RC9sv7v3pqNdmmo
	 thWRk1s4jjayhFOF3FuNnDSB1iqDBhLV3Q/Yp3QupMw2qPgOz9iLZAo0ompFHCmG+KAtZ
	 mBeSWahve32MSH4DDKICqG2EWeYQ4Q8Q1OnT6FHZ4ZDvL20Wb4zmI1VPXkZlHFAHFIKQJ
	 E1k6BTWsImA3V39POpqORdOSEyNpZU4gajpM/kGlM6m4+hTRo/waL8P5Xm/XvwQS6uGSA
	 vO9aG0pByXlQg8xOuOXI/fK7nYQFEEPbuAA1V3mJyVPtuvwXEINMeYMI7dBB5qI7ktQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBElNgXj;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49839606A889
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49839606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBElNgXj
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2b25786d9so74968137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941871; x=1795546671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6rPM2zYiBERTNTN+x4MxTceFG5PhHtt6lZOMnNbeFBU=;
        b=BBElNgXjh5kB8iXuOXAic2f1Wbp4yNR2IWZqJx4chYQIJ6l2L/Mlr18BFn27PbQKWh
         V3ML1HzbCnSm4Mq0V+q03yrEEQSH2r6hGXcd1aX5Y3CouHwxAiQ815H4Q8BpjDFzhuZr
         JGcBZSDez1YlvAGE062jzxr0u8ZheMnFqnnpjUimePARceJ3cerxp4eEa28SYpz9BUGe
         YVMKYPrR9RqXf0ZrWiuheDlr1O8s+O2r545aS44IwVAY4E6TpJNI4eap0Qo6Onkehz8v
         9XerJukzKq7t6X20bjg+4Vxdd29PBALuqLj81gWqDUN7uxv5RG3VxywcTK2G9KDA4eVe
         ZKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941871; x=1795546671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6rPM2zYiBERTNTN+x4MxTceFG5PhHtt6lZOMnNbeFBU=;
        b=czOcHSSmNOt7PBmuqfjQ0KOHjMHuoHbEc4Bv/AsU5ZHbB0Km5l3o+t6VFFwUQAXosg
         U1uPkJVmvpxBA/BlJP/gqe2vEXlRBJT2O+QRoEfcfpzS4+a7ab1gWxZoOP/ploP7ooao
         nk5JM7OHrYkqkj+EE5k8cTPwTlU2xlWZswyG7H5U8iur2bDdSbM5tBokvFyRw9n5naoH
         hleLhuoRhPlQxgqB2ffyN9d1qfwQlZ0NsXAd+B7oejQqbuoVRqRorEvqjIrQNoAEmzfU
         XfsSTan1lFs8Ypdg7Rr0K9grKI9r9djEcz9o3+ZGZ9RGgA8mzwCpVDmgi/xCEp3Ut6rL
         Rd7Q==
X-Gm-Message-State: APuU4Z8HTJ4tzCs8kQTCykgJcT9wiHZ9ho5rrmiIvoe3TGErPHh70KrE
	hjpCM7hZcePTuLC8hy5rDa83ul7jWe/XdlyizB6YrPnARIC7eL0s6CGdc0e/WA==
X-Gm-Gg: AYBFou1Jb1z6Yf+L93G+GNWIczjkj8sIQ/j4q4KldJq9TC4Yk6Vr2MSC8mth/3Njtld
	kJb/diXb/BLt5Q3pHY0lI2OwZ+bz28yMZdpEQlp1/LWKBphNc6CmF9rEreF9hk0ENUGSiD6GXtI
	XweSCHmDEYnKs5hE7PVKCHrd7jA0zkJaYBHpK6Uhwk9ltoChW21/s2fLqVV1CwFTSqGN98lv16b
	dakbrLMMAEauB602lDaF2d4j6OQvmpVe5YD7MR8fQWuXS5IordEGxegw/rPBEe3vzngzi2024bT
	+1Hz0T42Vg9W77TnJ96nO011eUjuAHd9AKbr29PcV1Ob1b+w7E4Jf+2JbSOfxkGM49QkdNbgqFl
	lmuHW+eR1bP9YAmyfhp3zNLnpyCl2gAfIOt1WHxCuCFmcH6Rsz4kb6D3NyibcoyoD+H7gCax5ZY
	cDU536PoyYER1jzpPANOy8E4ZaEv5rVjLMJS5drsDObXfBPrtwjWpl2Kl2V3SONQ9SXTmejmr/F
	/EPQu7Z9kWEkKEIl7C7P+IG+PvA8wnW7tjcNpdWlu075AuhblX7KDyZF/G8amkcFGXzk+iBVxqp
	G8ioVKej3kTl+00WF60klQrvmQxUavupHUhBTvVAy2uwYCXnXVpejV9F+feHqOQTBDdy+QYOfYl
	J5lyxnW36J9swKrtPRYCmYse4iwd0RbpwGd32tDb9IUfmlBzUb/72FjGcHTHaLbNA005jJ6VlvB
	cAd1A=
X-Received: by 2002:a05:6102:4489:b0:7cc:33c9:b3cb with SMTP id ada2fe7eead31-7d64d7eda13mr6272845137.29.1794941871061;
        Tue, 17 Nov 2026 10:57:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 14/16] Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
Date: Tue, 17 Nov 2026 13:57:35 -0500
Message-ID: <20261117185737.3758255-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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
hci_req_sync_lock() and serialize smp_force_bredr() with hdev->lock.

Reported-by: sashiko.dev (linux-442108d5-76ce-44a1-a84d-16b44d6a26a6)
Fixes: 4b4148e9acc1 ("Bluetooth: Add support for setting DUT mode")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_debugfs.c | 30 ++++++++++++++++++++++++------
 net/bluetooth/smp.c         | 25 +++++++++++++++++++------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index cd5ef398f238..06bb399c86d1 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
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

