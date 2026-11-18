Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017563;
	b=1d59h7J2TEjq2gA1dkRBg2R/loLotuaF1hGyzLq+B4I9UbjylPc4Lkn25yqZiCAb43Uj
	 ITRvPwyGRAVicLwGCdK1/cdFlANeZeH22PBDrmv4+I+/yTbOheJsrmK7bcGuj8Pcj2XKS
	 UDopw8BZ6GU7jvMR+qgLY7Ez59V95Q6J+GwPe60QdY5gUS3WOqKpbs1gHYt/GjEChPPnF
	 o33q8hco6eoCuIW4qZ36EElPGYJ4ytzyKCPECRXZUCN3vA4n3yv1OhYXz5EVbdJvKCRUn
	 ULVUy9LFq8eV2qj22B6pRhYbsA+bRSGC9hC9XLn80EFQInqdRsUwXZSDKqZMleoEDXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
	b=OXouwbQP2Wt2y10wg+1qhAh59VZlDDcb76OVdPA7FmG7M+4lXzE2TcHP+wZ2WcBzdrVW
	 dYZrZKcNCRaicmTfEwZQr7SuzWzO8egCBPFQkZFZS4YeLUskAQMQWliW8H6inKWbIb9fM
	 /Nq4J32trvUoH/7xUaN78IvZ9btj8x8BeYDN4T57nC3EB6EVnTLUCSMt2a1aFn5MCBQYa
	 BWd83pNziY4kssw8uoXfDRGOXER3IkOxsGYBsr9rlDe2RDlqQUM9EUxBctTDptQn329g5
	 +XiRIK3C4E3k/+OG/TInHptNeU4paS5JVbbRzXQ33XC9Hgpf/R0cMvPqoYh0stHT/HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teVQXIc2;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15800606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15800606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teVQXIc2
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so1794386e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017562; x=1795622362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
        b=teVQXIc2y/f567utSXkBASGpSFSkNKMylnyUKEiKT1P+HRc2O8MSE47ER3D/hFYt4+
         bWn7c43Cg8L+kksTaEelwfy/eZzbX+ubMtnU46M1X5stI6kBlsKoilYIBa1js05/9btp
         HrolgmlnJ6PkkRvjMI5V169m6As4ndYSF6tKdywhGTH7eClnYM1aNDxi5PPNIT8K5li8
         MqQu1sExtCtJD9WT2QHBQaNCLNStfoZIm4phSZCoL4BBwV16NBzcehmHdVdVNv4V5QyO
         kJ72E/CKBU5ymv/v240xtyg13X2FWQQQ+/v+MJws6uA0qYCki9f3M9s77Da/eyg3v+I+
         FqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017562; x=1795622362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ee4kAIRs3JTF8kr+7NV3oiv/WTEJGArGMNXdSUwp2RQ=;
        b=O7mfpNC6qtFzyeDvYkb5VJNottpWqZQnIBFXC9MkZtsSreXQ0dTKVD5uipiRh0hA/I
         XGdkNibiWdhO7VsMOkS6uzhZZ76Q22rMAOLJx8X683zz24XLIBYvAVgJNIP7901GgfDs
         4nMXB5wV/F6TMD0XZWOVPzfnRcONZ/AFo/GAM6m1M1p+15f/djIwgZtBP1wOqJqIhcaT
         hwHHt7kZx5K9PEQZ6/LdiuVq5D86p+r0ZhYZ+UVGOIIH+BdiG3S2b1lGOzr+kVLhBJDl
         kHFmpFW2r6IZcz+eItRkP41s/P5w0wOjAF8lrANusUZdnKa6ErBWfbXYr++xdEogcrFV
         YXsw==
X-Gm-Message-State: APuU4Z+WFD1uEkw3eIvWMycRVKKx9Z4piT3d2gBSxOuE5eSibpdS1m4L
	QkeqQCArUdxsPb4oMkXu4FHtJFUe2029t2Zw02ulps6o00FIlSdeUsx+3AHjHWSj
X-Gm-Gg: AYBFou2IQLVJjMgCOZrPvJiIFbHzkAO58Wxg+oasDxhB87ni8HqIspPKO37X73TEH1C
	+CYHEhhVh3tnk/9Q5RDfjfa92Pmc5aeKbHD1lRJLERQLgkYr+KXmtzJ189HF7mIziP6HhDOlwqk
	qhmp9OZ9WgfcJB2uG3KgXBdr2zElu8HT0uSzB28nLgfAqNsh7WcwuFmqlvvYprUXGWd8+kd6nz2
	83WbRyyl2Ls0gbWPCYqDXwPTxAIVa+3PYC9yf1vIwzEcXtCUR0dz9uSRfgHE77zZ2lwA8V4n2Gm
	7s08Q8FDd49KeboQYQruhoettN6B8avtnbrjXZ8lB3OStT+briBLx7tfpbAF5ehy+QSWGebI9Ln
	IM9oZ+ay1B4dWyqAaobKiAsf0lbtMXtCA/7sAwaJkjJqpfqCXvPREbtaQq2e3nRKFSgRa82sg3M
	v4xI5yzt+qY5V09UScedZpe2TEzI/vWeMHjnWQGjt9Ofl6WHUs8jNw0r3rTPvLqDWLF8i69lhcq
	YrnjHqDz7GuMm3+nKmZduUUnaO/jKwDGoZRQ/JTPN0H/htpnActhp5I6/XzMeMqlg0ZQjlPdg9x
	mgwd7c4dfVsto4EsQYhwnMHXro6TmoQDExuKjeM4Vy6qnlq5SxsAnflbr+Fvh9ikv6F2FA2Zn8V
	sXNMDCI8dSaPltrZdFZC7elCBIfm/Kz7vnKqtPprz4zkhRVhKXjLewdS6IYMWqE/h6U8eAifeYj
	qF8w0=
X-Received: by 2002:a05:6122:c83:b0:5ea:c3bc:c54b with SMTP id 71dfb90a1353d-5ee6468b309mr1055417e0c.3.1795017562054;
        Wed, 18 Nov 2026 07:59:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 07/17] Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
Date: Wed, 18 Nov 2026 10:59:04 -0500
Message-ID: <20261118155914.178050-8-luiz.dentz@gmail.com>
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

smp_force_bredr() created a BR/EDR SMP channel even when the controller
was powered off or not LE capable, leaving a stale channel that
smp_register() later warns about and leaks. Only create it when SMP is
registered and guard the removal; smp_register() creates it on power on
if the flag is set. Since smp_unregister() runs with hdev->lock take it
around smp_register() as well so they can't race with each other nor with
smp_force_bredr().

Reported-by: sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)
Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c |  2 ++
 net/bluetooth/smp.c      | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a1f272c14a1e..b1925153c2c7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3892,7 +3892,9 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	 * registration is required so that LE SMP can clearly decide if
 	 * the public address or static address is used.
 	 */
+	hci_dev_lock(hdev);
 	smp_register(hdev);
+	hci_dev_unlock(hdev);
 
 	err = hci_write_ssp_mode_sync(hdev, 0x01);
 	if (err)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7e0be869cc74..1c315c9ee7dd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3441,20 +3441,28 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 		return -EALREADY;
 
+	/* The channels are only registered while the controller is powered
+	 * and LE capable. Otherwise just record the flag, smp_register() will
+	 * create the BR/EDR channel on the next power on.
+	 */
 	if (enable) {
 		struct l2cap_chan *chan;
 
-		chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
-		if (IS_ERR(chan))
-			return PTR_ERR(chan);
+		if (hdev->smp_data && !hdev->smp_bredr_data) {
+			chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
+			if (IS_ERR(chan))
+				return PTR_ERR(chan);
 
-		hdev->smp_bredr_data = chan;
+			hdev->smp_bredr_data = chan;
+		}
 	} else {
 		struct l2cap_chan *chan;
 
 		chan = hdev->smp_bredr_data;
-		hdev->smp_bredr_data = NULL;
-		smp_del_chan(chan);
+		if (chan) {
+			hdev->smp_bredr_data = NULL;
+			smp_del_chan(chan);
+		}
 	}
 
 	hci_dev_change_flag(hdev, HCI_FORCE_BREDR_SMP);
-- 
2.56.0

