Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF262453A59
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296116; cv=none; b=Ju6ZMj9VqV8D3hlxSG7AhBnddALu3Y3polJBRoLNSmJq/K7c64d8akKkJ6ZIZwfs5HqBpcW07oz4ZXOVdZGg8ixqL1CUBKABfVEq6Xjv26tin87NUAYAGWzNr5onyiauMLNcc1ews9LRBmXk/UfwRxMdTTjiDopeDKGxbytqsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296116; c=relaxed/simple;
	bh=A9Fs5AdqBcb26lKcBnk0LX8wPrpvfCaXJLjQDzz3M34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dx568nFdZjZS+TSkyux4QIQZMT7WX1FP+3R1iahsC0S1T3zj5kMPx8sP0t+9ohW283KlNxayLQpl7K17MrzkiotuWNba/xRuKPOOBEfqdXZybrNNMduzEfJYLBKtVI5yTqMHUjnb2vkhFE/1DNDUBLwMs4pEoKormNmm5bBnS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfWcIglc; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfWcIglc"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7c52caa3045so966919137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791296113; x=1791900913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4sJHNxjiuA+irb0F/9g8MQWDNoCtIr1gYzlZjsXOV/I=;
        b=OfWcIglc3VrIoWlId0E0J4dS1XI2WlpL1usEFb5auewXwNMg0nE0UfVQgewwcuSCyb
         ebWzhvZnmFrJfvbFtbNpl8p+cH17DHVRrxvLI8HWXSSdrR01Az4quU4FUm/zJz9Cfx0N
         6jSd0+s/pIup9ONWS0QByhti2IwNOXifVHXVdQgVM96gjpeHXE33ymsMdvjypdlk9VV9
         1THdNji/ptLXbmxc9oNTWkzRB/Cv3nm5B/JagFDpO9v46NvkV3zZt7geby7ZFG0iCGh/
         u9T0thqqhwaufZJZuzAHBRDLCsREy2smfDsJKhNs0D5bD0Zm6I2xs5Y2qhX8I8FwTtly
         Yy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296113; x=1791900913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4sJHNxjiuA+irb0F/9g8MQWDNoCtIr1gYzlZjsXOV/I=;
        b=eqjuxff4c/qfgRtQyqw55rLOZilo3R5EwCAuBX8WEtfQufenyyagZ8M7bO1oR7/5VD
         nzI/69pp9kVQy+Iv2UjzMujJ2ZszTfIWOgiHiV23s7hkMiLl0MEXRgennYobHDxcHwYg
         NN/Hz+AZYo3qh7IWzlnI+CnMdSuXB7nAkyxrZ08Po/514uviI+M2i2i3hskmErNFBzuZ
         dnnzvTSGe4enN+K3FyvsK8ktXj2NCpjXWYxnyMJtI1QYMKV+fJbH2UK5B/vYzBeLrluo
         24UayRj4Tl3ucN3WnReZ1Fo9BsNjC2TJAvWvrQ1Maa8/59XC4OOR1v7Mdlsxdl1zehoN
         Y8rw==
X-Gm-Message-State: AFq9FYIQorP2YBpRZE2GqI8Ne4wtuAYEwOIu3MAOlkSBledwNn0NDTae
	GDe0Rtn6ys+ZQaR25wMXL1N3l2y9vitKPDFnft50XCD28moahqe6v1sESMmYBkv/
X-Gm-Gg: AYBFou2YAejCgJH9VKG5TvShv0hVU3L+I7KNayQljf0hM4fsaB23rDs5zYzd3GtTblS
	8L2fUuCPgso/M7mtu4o9zt41qQ6IGSZidtSh7Amk2KtXdfvuXie7sETZdwZFHvm1G4aBx00WwMg
	8WsmlnW9/TV+N7wcTJCNIYLsWuXcGDJWk+ZJUz0JMLKOWk+gubDvcQc1xpgHTHhafNNCR4LzP25
	mo7xnBuAzgUNkJTan6PuNJSReiWgAG/Ku4CzU9blwIYv3EmycApnO7ACQvzxdCjtmO6a+wng4Ea
	TsCn1xY2NBEJ0ob7ExfusAZ8d6Gd8vD8dUWUkmwebz4/x4+hWSgLOqW1S5bxblgSYGkDqQKbI7v
	cJ8K+G1/BKv9drPeqU85/wmsZvOQN4I9izuuZcSABDPt6EbtoW2/eG0yoEw+PVFawWMc5vqOjG4
	IT37sMv3Fjyvcbfu+SOCxFPREv5LBoAODmHuhepxI0b19cop8iWEOFZ18ms7rwLqxYH/dB0xH2/
	J/o+Xvn2klQg8/hij9HMW/KsZvWCOnfg1XNSubpm8YULusfYFBYWuPxr3//zww+
X-Received: by 2002:a05:6102:4bca:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7c2462fae89mr2327630137.37.1791296113406;
        Tue, 06 Oct 2026 07:15:13 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0ff5c49a9sm13235132137.4.2026.10.06.07.15.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:15:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
Date: Tue,  6 Oct 2026 10:15:02 -0400
Message-ID: <20261006141502.3789138-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006141502.3789138-1-luiz.dentz@gmail.com>
References: <20261006141502.3789138-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If queueing the command fails the instance is never removed, despite it
having already been added or modified by hci_add_adv_instance, so remove
it as it is done by add_ext_adv_params_complete on failure, signaling
it has been removed if it was previously added.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 93872a5fc39c..ce091bf84642 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9361,14 +9361,15 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 				       data, data_len);
 		if (!cmd) {
 			err = -ENOMEM;
-			hci_remove_adv_instance(hdev, cp->instance);
-			goto unlock;
+			goto remove;
 		}
 
 		err = hci_cmd_sync_queue(hdev, add_ext_adv_params_sync, cmd,
 					 add_ext_adv_params_complete);
-		if (err < 0)
+		if (err < 0) {
 			mgmt_pending_free(cmd);
+			goto remove;
+		}
 	} else {
 		rp.instance = cp->instance;
 		rp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
@@ -9379,6 +9380,18 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 	}
 
+	goto unlock;
+
+remove:
+	/* The instance may have been modified already so remove it, like it
+	 * is done in add_ext_adv_params_complete, signaling it has been
+	 * removed if it was previously added.
+	 */
+	if (!adv->pending)
+		mgmt_advertising_removed(sk, hdev, cp->instance);
+
+	hci_remove_adv_instance(hdev, cp->instance);
+
 unlock:
 	hci_dev_unlock(hdev);
 
-- 
2.55.0

