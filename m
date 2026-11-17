Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941871;
	b=r8592gPNgfZwpArQlKi32rhLnhNUio3mto3qqzicf5Z7EUKc7y0uJxaZLXyxlnEyqH2h
	 BZQXIuuzFMhe/hAvjoOFJa/GjOB4ZmJ7LAOBEB3TSWA0vphWx8t1DECn4ScydyWobIi0Y
	 bvWQSNfJnPfRL7uymLMa3Ub9hiJFicJaNRAYrdTF3EaM7SYdQ+x+mORu/mc8ztXbZEKwN
	 55wDlBsGlreHQEjfa4Ap8AaMqO2ikOdB/ML0IzU0dX0LWX/KNVWiM6RVXFGoi/dEYj+Mi
	 51hhIMuSUHN+AP9d09cMODCn8Xv7WSBdB0+bfSv7Pc76UkjOPh2hJPeznpScOPHP1ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QLpW0jxqy8GwA1eIQxOOwav1A32CoqFcfzDzZ0+qo5E=;
	b=OOCgPXBXh1mnMK+rBaVYxWtnOubNTdTmift4IvYTxTCBUnGlY8oeSHNs/vNP5qttF6h2
	 OMcauKrepRhB+qtfLpuh8vijiMymYuS7OGxc6qEoNGBjgTSC91NKS9YJQAdFBklGB1Kvj
	 BxqUQCkUqghew1oAtbNnBT10/egNzAgAjFE5xQx+4pASXOdezbBV9I2rWzxMmYsF1WCdH
	 jxliaRbuPM70AMiJ4020e27zbO0lkXXaxMvmJJXAn/HZwaYF+ae0ObYP9QY3jjmQa6bdi
	 oO7VDDbvw3yP67VTVJXpv71hZK2HddXH41Co1PoeY4xfEm+bVmuILPcWWCv6UVCoMUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="z/AflmUy";
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDFC606A883
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDFC606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z/AflmUy
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-745497ac8fcso55298137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941870; x=1795546670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QLpW0jxqy8GwA1eIQxOOwav1A32CoqFcfzDzZ0+qo5E=;
        b=z/AflmUy98svVRXu+1rDuJJ2fGolTK2CqJKr9WnktkDY8CgSa2lSxnUtY2J88BLhsS
         Ls8shaESWkauw+Eq3rJY+qOc/YqefUjpq/2DVh2FwEPRzawOESS5LH7hzIqUmL2FZajK
         /yyFiAZRvIomuj90/b8u1rJFS8tPPLWNp/vevKnGvBwctdyxLphiCJqJ5jxtv4cEkgQi
         KsUCVbcIHbgteyUysge5GnjHmE0u5zapikITbU1EhK81jJL33DV8GcZ118Q7CFcaOiiQ
         ZbqUCFb4uYgKlwPOfS4LvHH8ngqoMY6ccG8CMsHrrBsCKRuHuCDXlvOYF7QQ7b13VPXI
         IOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941870; x=1795546670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QLpW0jxqy8GwA1eIQxOOwav1A32CoqFcfzDzZ0+qo5E=;
        b=VGFc4Pz4ocSKCw+H5f26ZWbZUj4Sa7Mv/LriRkhgCQTLgowy5JSS1VMGEhJ07NuCm9
         ZEi8EItnL0JHWqaw7Atnxc/2loZ6FqEq9TT+cR6awpX2pDTDvjhVydL+P8eyUz/eoJC3
         H5qAl8q0WnPDESYWUL132iv+du3UGM8381EVxjfC972LQRKv06Ju6+Qm+1rcxQuP2Qcq
         bmta6HgtI6yLlH5RGkbYB7ajH8owhYRq2F3xRcSHk2eSi11oODZegJh1oUwjN9ctHSjM
         +Vl4dhiha71iHtL0p1Z0/ondmDSTYgIUk6IcCjfH/Fjg48no2KSS+/GMl+lWatGxq77H
         vycw==
X-Gm-Message-State: APuU4Z+zu77S4Q8RKR2/yc2v/hrHe5ozxVcFRwC87xBEBMuRxOpsYMcF
	Z56YOVr1l4sbwlMB9LVh1WZ94k5byaD2oE7KP4evk2aEWopB6NlmuDQYEJfIXg==
X-Gm-Gg: AYBFou27lcApnRKSdnvE9z2j0uFJwFZZkz54ITEmZvjcO8cwO9kJk/zLBGDcrT555Pc
	Tk2kCaCpaAvZ/52sUrzEscnDt4FeMdKSta0M9eI4buYMK1yy3cVMfI3BbjokR4jDGjSBMryqhOW
	vuu7gHWLGF+rQIVMZZd+BpXlKHqnYH3XLulWRwLAGf1JSDLY2O9V1T2msz1xBUeL71BVtn9GnHK
	s8/+YpjbGMxmXCQmQ4glGlqZ5QJ9HtB9Jz51F9qYmcWL1pr9UrbUs1OD09kJgwy9c5kZbncV6jg
	o3Me1uq8FbST8kvlLjwxO5hN1a/C0inLELXODVil8egn6BhDYV83oCf4kxigubmx8HOjHdCYxJf
	VCq0jUolsEBoPsJ8oXHIKbyOhVNUrHIN5esem8ViGsMNnt5MzN4TBqUOlMjCP8HXluiO4cL7Nob
	mebgZwAJ5HyKQ5Mw9QAQSgDEvTqPh+pmbmfF/O4nUuM8BxqNpgZlOx/4CksrtQVkBVdNu3iPOD4
	4/s0G+sgvb9kTXm1tQkxSMIrKGhLfabIsYhj87snoPS0LTIQzXqKSH11tj9LEq7zruxrNqabFYK
	t655ENGhj608QO6qLH6NUYXGnm9Xtdy09KSoOmcM69oZ4We/B9nYDWia69duZPvYou1bfmefiEt
	ipCiEb4f/PIN60fP7/a/VZh7alHM0pxoecsFSXaAc9GgzYSiHqPd9jdfbGbetm7mQEP4npxIoeD
	tyguE=
X-Received: by 2002:a05:6102:1484:b0:7d0:6db8:dc33 with SMTP id ada2fe7eead31-7d64d4738eemr5456335137.2.1794941869632;
        Tue, 17 Nov 2026 10:57:49 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 12/16] Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
Date: Tue, 17 Nov 2026 13:57:33 -0500
Message-ID: <20261117185737.3758255-13-luiz.dentz@gmail.com>
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

mgmt_powering_down() looked up the Set Powered command and read its
parameters after mgmt_pending_find() dropped mgmt_pending_lock, so the
command could be unlinked and freed in between. Do the lookup and read the
parameters while holding the lock.

Reported-by: sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)
Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dbaf0e0b06f5..343fad3dde1b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10325,19 +10325,27 @@ bool mgmt_powering_down(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
+	bool powering_down = false;
 
 	if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN))
 		return true;
 
-	cmd = pending_find(MGMT_OP_SET_POWERED, hdev);
-	if (!cmd)
-		return false;
+	mutex_lock(&hdev->mgmt_pending_lock);
 
-	cp = cmd->param;
-	if (!cp->val)
-		return true;
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (hci_sock_get_channel(cmd->sk) != HCI_CHANNEL_CONTROL ||
+		    cmd->opcode != MGMT_OP_SET_POWERED)
+			continue;
 
-	return false;
+		/* cmd can only be freed after it is unlinked under the lock */
+		cp = cmd->param;
+		powering_down = !cp->val;
+		break;
+	}
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return powering_down;
 }
 
 u8 hci_to_mgmt_reason(u8 err)
-- 
2.56.0

