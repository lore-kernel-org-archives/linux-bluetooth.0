Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017569;
	b=CuZep89yJ6bhToHKpXf4hXQFegPNtbnPAyFE6EmNIaRKCa0HquDa8Ypgk0uv8ywSqd35
	 tOpwxbiaMxGKIf2GOhgpaA7f8TAd6NLfFl8ObdRAU4xAUlySJTMruQQZzYcoLznswYzy4
	 3aUARpNBhWN8SeOXx6cHgNRduA5l8NpX6tCLqAfacrP66hwvri8ZfmVwwhULr4ajb6Nzj
	 FfJRuCCwjKJzdtDHEh1CT/a8J2sa54WsE9p73Nt52Vj8Ha5RLtdfoHEUgYIF3VH8yrhlC
	 kANU9oWSGRDCmtbzacffLilLSh9yFS3/vOmI92GJnS2uQlngzz2nPSVSb8br8y+ye1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
	b=aaBI7gtTULPJ0BRPmr3Kb3VftCEyAw7P8zCEEBq7MixT5Jos83Umd1sYvIYuyC1mt9sr
	 ZwMqMPw3Y4K5sHN3kBBn/3tkit1Q2us4m6phXgmJlrwzDG/MJEHAOXQ7HB6YEJ58rK/DQ
	 +aK8JmZyUQGNf6P+L1CG+bddb7HVuu/G3Y+Q8Tb2ks3Gdn0Qso54xCe+uhSLY1G4VxXs+
	 TIS8lhBG6aFxz2Tl74W1GVh5bsOzcPwjH/spp+JyBPT5Ngv5uj3wVyQWPlzDcuIsyGpW/
	 HayPuXD2k2cQr7Z2TU9do288dQNkYK5W6mqcHh3xztRLux8U08h6Y/FxGW/7MKRaDIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HsnfiTyh;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0235606A334
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0235606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HsnfiTyh
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ec20398b05so986093e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017568; x=1795622368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
        b=HsnfiTyhrpjcoy3A3xUi55ZcvfexYw4S2Xv3oKsqh8QccNI0j5xtk9rLHSi0eeSn6I
         sHIHf0IeEfkVmvK+KNYlkOUqy1MLGtcf5EbKjIMnvpAyfnypRJwKoiKdLDqiOszdiNPn
         ELpviZDNyFhhj2RY6xN9fTbHWLHDUVCz0qSd0RGIKa8YuDxV5MOirABup2n+D46N81DN
         eBFqr0PdkqKJx0CHoKPpzxqcll1xY9YCCQy6c3I8FFr3/zxDwTOceY+PWtyHJXZ6R/Ro
         BERTVxyrgwxcDMcE3UX2lNvdA04r0JO+GmZBR5h9MPALZgwQdz1+nuz0SKspDR+uEvwz
         b5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017568; x=1795622368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
        b=Rs2V1viB7XDfDKSwZMaz5KwMdWA3m9y6SuLFmIdqadjc5N2VR8tPDSIBgiGp3JvDPi
         9Yu4+UwIRtvmFZI+k/JhBlnPHhp+fdQJ/zLFwXOGKr25ywZkefd3I/7RvG96ILHT/CSF
         GGkYEZMXQK56qyJqXFiem7qwoDOyT6sg2xQ14K+lLcWDP9Ck0x7r81eRjfQEdX5D2cTE
         TSjt+WjWNX3XlpZnDo2UM3Ei+DaqI4raln9oiAEZhAYf0QifxQQ/07/bLilJJj/zz5so
         MTdvNWLh80SyzS9lUvli3HLNQptiutoWaSmPzErFk4CGtwIN3I1Ri4V16lzp2m8w2toa
         XVGw==
X-Gm-Message-State: APuU4Z9b8Yyxdudk9gfJ/errZD+i0yo9DQFJrbfdYUTLcARrJNQQFCED
	o84ArVcqm8CGjGedB/l6HHEwWDB/l2R4ZKeOGbkYkZf8F1tSKOhVr1xS7yhuQyzx
X-Gm-Gg: AYBFou0WV2AmqFzFmQkscVUX9Ak8uFGLvwIoKiMxRb0EH4P/tn3/ifCOuWpGDwtyCHr
	we+Gj+VR8d4+HY097MRbfm+QEYRBnhASjeQvXdGXErgYIwaJnm39lvtGf5ZSdjV5mpQbVsX9DKU
	ZwTcPnS0WCbZXO4tgWPxFVeJenePt0ygmHXUu4IXN4DB1cwkjCcbdlC0sCiaKb5D4PvSuAk7rHp
	klxXwxsXV3dV5Bc696SCbtVNJfnd2GMn3OiYQQc3Di+yXaRhFn+eVsSnJwun+OfuKWP4ffOr5Xf
	JxfnmKfIrcZqdNgMgbMVHWS6wiFl0Z4GGCbvX4Jzj7rk5yL5ZScamrscJIUtrAhFRT/mMiucUsa
	lo0xG6GKBTmu62WDDTBnofUIsIe/FP5qYN6IlUuOaRAsazE+SDIOd4gsDUsmIf6T9ah8N0DuGub
	Xs7+WUDiliA0SLrz4Vfrjr0yA4hh+XOUQ7gwTi64lmnHS52+GqRgikZicX/ifqNh2fef3qp01V/
	z32jgpkbf1aRfN7FuS6h7d/bDdV4VzFmDBckKccSl4Ec62O26+c6c0wF7CBB18orcJU70G90iCZ
	jFq/zYYnFkGclQ0c4TFgVdvwx0/HiAJtwdmtSh5JLNxvVCn7oKCOb+nuYQV7XYyQqeqWGq+Tmkf
	NIx69+eNOj1vZ1xF3PLjsGYOC53YHWHFAzr1FMWvd4GNFIjtj5OFiZpayUAOoARYAS1N8N8KuIt
	vPuGA=
X-Received: by 2002:a05:6122:3281:b0:5ea:f399:781d with SMTP id 71dfb90a1353d-5ee64769234mr1667763e0c.23.1795017567746;
        Wed, 18 Nov 2026 07:59:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 14/17] Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
Date: Wed, 18 Nov 2026 10:59:11 -0500
Message-ID: <20261118155914.178050-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
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

