Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795361510;
	b=uSZLq4Rw6Jc56Yg2pQlng0+aHbuL7fO15fB2Ib7CrfXMi7VsgCYZ1x5w32Vrf40OyPNf
	 4y1r4HjaPHbeIo1uz08L64W0BO8R0CUh0FKEnO+pN0bWgTbeUrLqGPFCZcTsk7EN7jDcI
	 RWCBHzl3N8PLwvsJpIuM8dQ6mDLzPUActhfNMqewaU8Dq8YSdnUNmGUMUFJaHkWc8nJH9
	 reoYVt6a8lKQscvYHQQ5TYNb9BfFda8LDzDuIZDVvDHsY/W/CrPkTUEOnV3g3cIouoUTk
	 CoPU5nyn1osNEvDEzD4NFT0RkM9O3+6MMciZDRZ+4xQ/8rXHBIB4a8HtOwOPvkZnGpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795361510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NhqHGNWzzah+JfPRb/tDOuvM73zunX/HsLU8+cDJmOk=;
	b=yT3f46v10FOfVy7W7os2zPnP96d2KVsJzwHM8b/ouyLeR7cbk9PSY5VgbP6ga8Rg5FxY
	 H46Wwih1DsIgIkKiWp5vHg+Dwunqys+Vxpf9lQ53F81fpP4ehd/JLx+HyRAZTZ1nBOze2
	 l0AJU3SLsyc6+qTwd8eAXZDSzXn9tt0fL+VfS15qtyiLVip4+cn76ek67cqSDwsD5mvI/
	 kt5BSanxK08pZ1dU23yVUQBRfIKPgu2SzSHpNtFx9np/j9v+VBanpoqYNtA/Rlu3P3tml
	 sSgKMnPaRMwVBFDAzXOvzVxUjUvmTPXdrGOOpzP/CAMmt+rPVl5sHSiNcpvCQk2at/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cAbRFMpn;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC8606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06EC8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cAbRFMpn
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a42b34e930so2141935f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 07:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795361508; x=1795966308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NhqHGNWzzah+JfPRb/tDOuvM73zunX/HsLU8+cDJmOk=;
        b=cAbRFMpnLTzZKqrEOVKqx5Op8V1LAgQOBim8I4VbConE2zp/WsRDgt2utoPZ/jfnLs
         +XyKj645mW7FR62Gq/jbsw7l9GeRV7CMYpVIqQaXuuFQEVd50qvEH49yw4I8tTIh57Y1
         KnFF4JNHpPb5ToMFKwjMRpX44c48dZvHCAKhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795361508; x=1795966308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NhqHGNWzzah+JfPRb/tDOuvM73zunX/HsLU8+cDJmOk=;
        b=KPzzVQ9LGPUD83Mr0UTFTbKYmGuEl9yFg6WRYL/2AtND/qVMpK5mJP1NbmNiRPp5nd
         l9Q9S9/UQus48bL75Cx+ezTKEM7LxEgmIshmX546GzW0q2aVOAdVRC6dgyFqgogo281c
         dLk4X3A/bxGJepkOL3YIiQbkj2LH1rH9XWTZyrWCplpkt2r5lvNra4iafGCqW4lS/ZvJ
         M/eYpkz9f8jyaNdlOCytDOVHFUD6OgPu40JINLL4gm9i0mPLwrivz8qyFum2N38GEA7h
         X4hHCIqMDUwtdd/3/+XIKRDahmtgv3mrSM+1bZvh5vnF3V2M+YJ/SFDTlam6he7fKruF
         VT8A==
X-Gm-Message-State: APuU4Z92qAAabUvFn++cWnCfuV9s32rZ64NlmDrLeK9a25FUpvkE+Hd0
	tmtXPcwLiysMgDwOBIQjrs75uvv1AMfXyNhxUHnw1fAgIehR84QXzVijtIoOrdFE0p8/F/CyrjL
	/GlOs
X-Gm-Gg: AZFdTZdFp6faCsLJyKEJfQsyiKh/qr86OA23VSlI1Hz88tL05cd7LN30iTgO/Q7aPqh
	NKmYwOH8bknsGg0AYFDMziD3BY5sOYT9BPOLa+Z21Olug57gf4j6aqRR2gAH6hqM9TiH1xbojeW
	/0B9tavxFHedKzGjpJcNl0RWIhForMt40EHDHoDsP1oUsLg08GAftg23ELwQC/lt0xJOr7Eq5sH
	ya7aVQXP/hpeXJqhE8KT/cxEbY0X04pFke/g6CwwzMG2AgXI/sNqq3O8nslh2ihFrjcS3dZNdZw
	3Izfs0RAH464UTH0muNGI21oLAoW3LfUsK8Y6qG9k4zvHbSG7f4Kcvbi1GbA9FMtGZHgHEaNFWj
	8IkuWwl9JCdmwdNLwPFwaOvuHT0gU1eKIbn4IOOYNAoEmkU6xvykUkM1upUAJzpGhdbOqdQ+PlD
	Y4UebbAPWXs1Lv+7o26jxZPbeeNgxrJi6cmlWl1jvINK1K46ui8HKVkQqj3e2E6nxwwEc+GuSa9
	xt3NAg1OO90ArkxsRfS5Zr9faITXvO1L+NnjUMtjXQwL4BPj3+vYj0uNW+TLcV9NBZ0o2VPk/dB
	Tt+xRw1w9mF4YU54AEg/8U5RXFjsJCWcib/EZUuetgcoxoMj2cef4gS9kIFFotakZA5rgWk=
X-Received: by 2002:a05:6000:220f:b0:4a7:c7bb:5291 with SMTP id ffacd0b85a97d-4abb1baaa4bmr18570030f8f.19.1795361508345;
        Sun, 22 Nov 2026 07:31:48 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm17063682f8f.42.2026.11.22.07.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:31:48 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: SMP: Pair without bonding when not bondable
Date: Sun, 22 Nov 2026 16:31:36 +0100
Message-ID: <20261122153136.1522998-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

With HCI_BONDABLE cleared, a Pairing Request or Security Request that
asks for bonding is rejected with Pairing Not Supported. A device in
non-bondable mode should pair without bonding instead: answer with the
bonding flag cleared and keep no keys.

PTS test CAP/CL/ADV/BV-01-C fails on the rejection.

Mask SMP_AUTH_BONDING out of the requested authentication, as SMP did
before b3c6410b8c75.

Fixes: b3c6410b8c75 ("Bluteooth: Reject SMP bonding if HCI_PAIRABLE is not set")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/smp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2538096cae06..49cc972b3338 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1746,9 +1746,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* We didn't start the pairing, so match remote */
 	auth = req->auth_req & AUTH_REQ_MASK(hdev);
 
-	if (!hci_dev_test_flag(hdev, HCI_BONDABLE) &&
-	    (auth & SMP_AUTH_BONDING))
-		return SMP_PAIRING_NOTSUPP;
+	if (!hci_dev_test_flag(hdev, HCI_BONDABLE))
+		auth &= ~SMP_AUTH_BONDING;
 
 	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) && !(auth & SMP_AUTH_SC))
 		return SMP_AUTH_REQUIREMENTS;
@@ -2357,9 +2356,8 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!smp)
 		return SMP_UNSPECIFIED;
 
-	if (!hci_dev_test_flag(hdev, HCI_BONDABLE) &&
-	    (auth & SMP_AUTH_BONDING))
-		return SMP_PAIRING_NOTSUPP;
+	if (!hci_dev_test_flag(hdev, HCI_BONDABLE))
+		auth &= ~SMP_AUTH_BONDING;
 
 	skb_pull(skb, sizeof(*rp));
 

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

