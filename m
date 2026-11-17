Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946848;
	b=bpq7x7xsIlpGu32WJO8x1LSUDqIf6R06ZpGvwymMtJv6K0hbzoInx/eCBg4KUsZhk48H
	 hBp6En9EYzaK6RmxyLZ/VinG+kl/uIESBubHw8XNkzME6ETQt+ACgJpGSZmSu3yPwnP10
	 q2x1RuGP5A1c+2VjPxoRzVmR2xCKuxnuo7B1wKCU33HJgyd+/LCh/VYxoXOo95HRZOm1l
	 GvWf0QQoWYTI8Qn0TSx1eY/6wa/K7rQpMfpoC3w64VP9ucpiiI3BTRk25dnFSCwYgvN3m
	 /Bn9X7wByR8Ee9J1j8gUyvEOqXWHbD6k2SYTVuRlnyU0xPt1mURCbAWmcrSvtMqQtAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
	b=RUakzl3iV1rD5MKCNwGRmUwEwgsimz8tjHgwOaAxLZiPN2HfL5AQeEFhRfnPRPpdJIgR
	 a16e6NCiNAx3GA6e9oT419rQx+H7NCXk6TBcNSH3mggn7KxGTB7dCwfWfjBkjIeMV/cnS
	 b7qO2Dqs8CEGJKyhpVm6hlbnGgie1igLkPjpxaB50UT+y9MSqeC+jB//tE/MQ3oCFKJ9e
	 H2kYz1FmFsoYCG3HJJ4JzDOTblsz6wXjRUV7e08RmESSlyp9Vr2RgouyEdKIWZlMS79Lt
	 9UYSzvJ68a3bgnJLSBbYAdJY/wl4FC+fIsvNNYzMRWSgnBIQ8jVOYokfHmG0ng8YomQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=giFdRhy2;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3584606A885
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3584606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=giFdRhy2
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9905d61449cso77245241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946846; x=1795551646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
        b=giFdRhy20dwoDNAWIZiZ7gl+MJzU7/9kUGUwoPRwVfRPBm5Bv3hhvRTXgldKfgz2Cz
         lOkZBkr9tXhvIS7ONBY2TFKsrkFJSG0mK5MdmMNFXzdN3W3RRY9qOmFMORVAgwKYimdz
         sjjyyJLTEFVKUtP6532tV10oX7RE/38VL4+5WToZx7P6h0eNTRTh2h92AKo+y68ozYCn
         pERcWzcMrlfcM/tSYcfbZkUoVQPTQ7/1qXyGJEr+OoOQwozVGWQjjhw8M+ANARrbfujf
         BViy8mu8zWYwTxJV2TAgm/b1xDVT5mFed71vuNVS5ukd5iIe73fcJN3GqKV3LdRc2cYr
         aW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946846; x=1795551646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
        b=u3NBPLHtCwglTock9TNZgF9/XwmfGFmDC1zP5QeAxeiQam2vB53LD0h/dcfYnR6/Oc
         RZdi17wGl1S8LnGMENRVlliymJVj/aTD61u9+VUeZwcxAGw01woz5GNnnuHWyKVtQXkN
         6EF0Q+51CddcIBDbfDfM5etkHePjKHYz0TNIUklWQUduGZ9PXrX5KJcoKcBXpeajyZor
         CmQ0vdnuSTcT/kUh8cuC94a2oZBYa1p4so1+1K6ysfcZReul7yXoIgkVTYpajT+urCki
         nZYuuGj7qgDNw0pJB+FtiYYEt1pohRN7AOAXnNwH/xY1g5Hy/lfC5bSq9xviOfE/WNE1
         oICg==
X-Gm-Message-State: APuU4Z95kaK+/D7Ckb0LVV/sNod/anrWbj4xJthq2gZK247UwK86WDug
	Y6aXkOVxA8h0EmO1OeYiIqBI7E929Nna7rv1tTtdeE6s2HRnyHHOAIVPpzCLuQ==
X-Gm-Gg: AYBFou1V7xk/JqJOpSAa3dnkOggX3upxkvpmXMT7Z1EL7ShQGfNuMt8B0EuoJ3Lkhbo
	EqXK7OJ+u5kAqMY3O+fYwNZvkiHdLfKDsns1XoXRnloLINsKkv7MkVwr0wnzVzKtEozNmhWe9ZT
	inTulvb1d+oc4ClgkkPCyTgQrx5DjRr8cmcxMYEZG/hT8l4UV3OAiarbwhEt7DohHWH/DuMIhoO
	hpbv6gzMRcYUgxZPdEB3B3RYQf5Uksmb5e3da9AagBLlyFC0XbqltHgniNRHzuYbwLEliN2GlIM
	eddBMZNaREJteztQrzZYrKRVAWR0c6xYy5apjgdCgmNZ8ZUYl7X/dH/bmmq7STZo0aCpMwTDIz9
	evEyHhf0BzUAshzLT8NvCs2UehjK6R8LxLyvVvdxsTA2thPgkgFU2fGGpeaRQ9VNIzdajTm0m+t
	eOd2DqAYx2C424vkFeKvg98XoOtv72AmpnLt3ZeuKLwwtpmT16c6QfjDwIhu1Durvx61RGAXbOC
	bb549QDYtWr8k+wp3GE0hTrV0ie/hw7ccEU4str3zHL1OfXDSPwMlNnoI9vc3RXpP1ig2bcwOnz
	996D/nCrA/bMsbxbPCHx6LXqeyi49yBm4+hYHLbIvtjVymmkK8cK4XBVuwHypJLVTi6n5vh6OPR
	05rHnj00KGYI8lZp8hMiq2X9tkDyHdrQeYmy9E81JgISHHaDUIUH4k48VIXOWAKVfmjp/LYMALH
	ho3j8=
X-Received: by 2002:a05:6102:6044:b0:7d6:864a:5509 with SMTP id ada2fe7eead31-7d6ba43b12fmr41248137.24.1794946846451;
        Tue, 17 Nov 2026 12:20:46 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 14/17] Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
Date: Tue, 17 Nov 2026 15:20:29 -0500
Message-ID: <20261117202032.3848411-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

