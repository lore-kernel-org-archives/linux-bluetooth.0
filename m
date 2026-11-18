Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010733;
	b=CmPWRuJ9C5O0GHki1jNNRkDvupD4rbBWJxPswC4Vaal08OmREvnxp/emcMivdbGzHTSZ
	 EyO+FhyTEX3logOI+tOD7iLi1kyUaL+em6dXBNhDtqqrPO1ZCJ3Rourgwrses5mc7mg+g
	 KJiUcS5mvRyEJFVxRfr8LoVahBOkU8OwJY4U7W5yBRwaqR7VDk23k/yftztg4JYijFTwg
	 veeeG0Ir57bGUd+O5xc5IDP5z/WbHdPpgxAnThoiYf1PQPxThwK0gnWmX9AF5uOGmdVV9
	 uurArZ3TpFiBKSSYE8vChwC1J4RSm+j3w7VKAD2cos9nAgAolEjKyY8D5EiWTZ+SB7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
	b=rIbg8GkkZXjpnn0Ve3oAjHIVTygjA0UnxumrtnWZFrUJEumbMhnbcp9j1xNO0cBixzMm
	 Y8gF62hhvPicSm5es/nZ3D6tTOkL1wsoGXrOfkhzVPAccHl5MqR4so71qHlrEOxKQsy+w
	 Pa/6FJG3ROouaaDE0uN0tUgz6MadG3lFL4z3MtJLyg/Y3MZa4LUdPHl5+kRNONeRLfvkb
	 5/DQqAL7fAWLIAGjsKZEFE6/LzcgJAZ1y9D3bEjB6J4hTabqXSNVMxZ2IRAoDkJvrZef1
	 2aV8vr/I0wA0I1Rj3pe7IUdtiBQkCl+iidPnFgJNk6FcmyT3VjM56sv+hqAfdqa+QTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zpoyb25p;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B160A260E
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F3B160A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zpoyb25p
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99e1408dc59so414156241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010732; x=1795615532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
        b=Zpoyb25pJyT0jeq/YD2/e7W2assYT1npuV0r5tyoVfKa/Tj1nSsLYd5QVqBpeDmgu/
         81bNcPXjFVuw8k73d7udkCMX7XsqPCyBM2Eyh3oRhtmcIQ59zI40Q/CDXYs4pBvVJNYW
         jE5ZStCNI0uYC48aqnHrOUEqj+UULcTtIjXcObey9TmSX7k6RoY6gIJS+3QU4x8its6N
         Fp2mpzvf7zCccDFQgmZK3SydwGTVGLBjd7T5gNmzM7EvVTZkfSYZbfJtg6ivJrofaDfU
         Y9XgDN3zaU0ok2hVwio7WxKU7H+Ik+LWX/s9VrICY/35ohlGJxqi2ufCVWlTM1jEOb5q
         Qwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010732; x=1795615532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EH+greGPjXlrIRjw8gfjQBQJJwG8L3sDkJtIFbUKrPU=;
        b=OQtv/mG3kYbVV/2VkPGmFHrH4ibtY7QM4Tk16AdOW6z9e5Sb7YKxsjvoYTmSEs8r7C
         x/ierVdf9JO9ktSQN+s1HojVtGPKx0PPJgKPuQ/S0AQw6VrproUNaIgefkhyMz8pH281
         vaqgwuBlm1P+lGK3stJ3rv0+3q8l3EljWYcAKGK5KPhx5vYC2Bn/PCP3PYr/DpRCzjDz
         QEhxwC6dIWfC2XMevOZaiznByb2ZDpuky8KuEnWeLHKZ+92/kRrWlPcuolR3XNB396tt
         SCBEejeboFhosf7BeBSBHazg7t4aL3Kyvr0D52WcsLqH1pTy5qNRQiZUouIH38j7BtUe
         1N1Q==
X-Gm-Message-State: APuU4Z/gOXvDshxbCA97ZQHIcva2pb5UHwxIZwP/tsbPgM0RVEeaecKw
	a1MUr8NrjNZiPsZqHyex/K3XPdIrFWZ/70B3FITKQGqeCkhZCbEQ58BUgfmzywvu
X-Gm-Gg: AYBFou1/4uy749erHcvh9b97Nfa6IjYZP+8+cIIy1EjTRdkl7kwNg1q8hLjIjfDbw8H
	L0/11FqH291NdoG5AosH8E98dQb6p+P2xMANxgpZkTddvd70w0TmGy3f8EaanwWSqz4hbrPCszt
	solyPQLE2krGdhVwqodjZAN3uxeVRccWn9VA8+bkBoRd4+j2hmzc4sG0JU1B95lWuPLlwMJmKaI
	sKUuZzQEho5hoEn6S53vVj7I4q1O6zOXKxKlHXcGSHlDnVoOpukITbeVvPCb4sNVwh4l8PpCO1n
	sD4AQVsfUiphn1d10SHJ4BASLjMxiHG9OGq5ssAua7DsfBz0rx61SJSDVvccH0kjr0DhM0TV+BA
	ZexgBawdiD/Jc9bvnDjShLLnoHD1nDgNTv4HwHRaBiA+kVYLwN0qYF+0ySzdI8bYwWJDIt8U+qk
	XTTP1uBZjnPVa7IU/WjijeyK2Q0/XeZylzWB1LzLmoqRzWr3LTVloWRkH/kf0ftBetPaPwFSra6
	UG5Rngjy5L1wtGB+7qS9V10HPZPa/NFQpcVi3EyqZ//G+p7WCJT97bzBRYzjWTO9CnoOPba07D1
	u0gCpjs/9OBtEX1ZeRTajmhAjN+W6ITK5sBekQk6eR2rBPU9Kf/xdTX05UpKt1DGrz5lzOo0ZDU
	12WGLhVbJjhwbZiKzoqs4DIp78ZtoYGOTHFZD9ht2VZJGcXI0cEsE699LEUwFhNnSOloPlidw52
	Qga6o=
X-Received: by 2002:a05:6102:3f90:b0:7d2:8dd0:2ed with SMTP id ada2fe7eead31-7d6ba3e9253mr1034029137.10.1795010731890;
        Wed, 18 Nov 2026 06:05:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 14/17] Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
Date: Wed, 18 Nov 2026 09:05:15 -0500
Message-ID: <20261118140518.59878-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

