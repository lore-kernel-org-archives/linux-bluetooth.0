Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57324364025
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608733; cv=none; b=i7eEWR6b85LGwL1A68NLXR/2T08b7ST5G/o1LS+6balTaQPOcSwQ8UxEP6FR9zUkAz3OdppjvhpD9+14OsG+Mko7OGZt+nEKDU0A90RNkw6WT7NAev2bgxsw84B8y2VI9kZgBO4r6m41TDgFZzSUq9Z39duLGUjz4IN7L9SxTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608733; c=relaxed/simple;
	bh=AK3ESpyMA/3hfE6lVWh9WYOUEltkTEMiW7zhLdgIAhg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmmeqxgyNS7g4bioZ/RlgUV2YQ6oyqGGZ3+jHQpaZyl+1Piz5fH72nTO9dKJDvxeCZKyu7zDktvjX6OSYj+uaSoNLljQWaKy8P+x8j4RqEmstH4t/3+ITYcMC1oJVtUfma0YTd6gO5TdwPB+5wpfi2pA9zwCs7+NNhHG2S3h9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec8gH2PW; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec8gH2PW"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-567543b8989so1095785e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608731; x=1772213531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIzk8YS6txQaybkNG3dTM3/tYy/Tz1mbYnidfaS8yl4=;
        b=ec8gH2PWFvgVmn3tLV/Tftgfj7Z2Yr3Ci8nTSet4ZaXc62UJ20R4915U8mIuy4mEWC
         LakJqN1k34NR2h5wmqOXk8Gut0X5LFhgbZ/+FHd5TP1+QaUbRhIfiMM0ym4ebm8QOmhe
         N2DcPcbIkStuUXRp9IOwO4ARTfjndRUYGrCCIVmQzYuPXSAzE1yNuuciXtA+dIymQWWw
         M3OGEItF5+7whSJTaoVEyJRmT/dqIQrEghlO84hHT9fZtrdb/z4gVC4tn3ckIANouqyZ
         VOsxg8015/G8BaqNLA5L2BXEYstgGTBNNgdCc3IVdNfBWKMKi0R6ATOlKjIzRiLndZjF
         TSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608731; x=1772213531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HIzk8YS6txQaybkNG3dTM3/tYy/Tz1mbYnidfaS8yl4=;
        b=GIIwXxxfogjP8JN71Nqh0kESslllr4RNZnvOag1iuDxkMnaozmscMVnlBk3W7m406U
         symaOJ8chnZf2iCmkikD/fkUdaUiT/CJ1LdKC9PiO4fxFIXY2mfl5D20Psge9gesRNUk
         VzfoBXz0dWqQ6T0u3DbTWSDK4W/wr4sTiPeF3MNrzfNMrMtH/jIvD56DG7GnjIHF73SZ
         Oaf8rGiH0xnhu/nFxTVF39Ft4h4Vv/fbm/0LvxoJqsG3MDqGWHs2PfVtDp/e6v5bPXiq
         2wI/bIxxgtj+6LnZeGb2MJWy8bo+x9VLsJSY8fYI8Wqp9KTGWGAZF/du6/KcEaqwTiCI
         aSuQ==
X-Gm-Message-State: AOJu0Yx1aASVYitUegRp4MN7auc1olVnOpwTE3LVgBMtNdiQHQ+voP+s
	iWLHPSeJBDHhbqRFWiyYUsOBV84pYGiZ1fm4MNzbR2oy+Y6+l4IuXzVMIx+8BIRQ
X-Gm-Gg: AZuq6aLpfxz0+KaEMF0ToT+8N3UrpF1KpkDiLuKoNCISYkIy6g1uLo0eQHRliDnQzL1
	9xrnu7hennve/PuLe5dhCCnDd3TnhY/uhRzktBSpajsKTOy89TyqTh9Iv5cOxI6rO1ds6GWJKg3
	n9OYHxLClj3ZzfRIeEJvqmTAxH8iMB9yTN65W6cZblzeJ5337L3ngi3jvM89UFE8qESEvy+Gbco
	Uu+RUhIlx8+2ZdtnaMNFyB0evjMlCvmklXiTyiewrOXFJuc+l2T9hp5A2fNI0P7okZcCL3kJpQU
	oL06Q7x4UCO18y3uThkFETHkKoVTVCev5tSBF9r2jAuH1Lek9BrjfuXM5VJ4QOUEivOOVynsxs4
	ZiSBcjSFyKnunenNi4YYP4VQm2//N7VN5h17n+TeVXeANaXesEZLZiu7bw1jPOuXz3mOpr2SUVF
	AsIYnJqoLCSRi71Tij1BvfTU4wXetibYvbY6zB2j6rsN2HUb2I+5S8k1x8ZJ9BqvHWzuIIiN4cw
	59Nt1dCUZH2dArfAw==
X-Received: by 2002:a05:6122:2191:b0:563:c3e7:6132 with SMTP id 71dfb90a1353d-568e4880bbdmr231014e0c.10.1771608700558;
        Fri, 20 Feb 2026 09:31:40 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 12/12] doc/btmon: Update documentation to reflect lastest changes
Date: Fri, 20 Feb 2026 12:31:16 -0500
Message-ID: <20260220173120.3418666-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220173120.3418666-1-luiz.dentz@gmail.com>
References: <20260220173120.3418666-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This update the diagram showing where each information is displayed to
include the connection type and peer address.
---
 doc/btmon.rst | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index c1616318a004..e1e362b7c1b6 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -255,23 +255,26 @@ completes and the result status.
 
 **ACL Data** shows data plane traffic with handle and protocol decoding::
 
-    < ACL Data TX: Handle 2048 [1.. flags 0x00 dlen 16  #493 [hci0] 12:36:18.977915
-    │              │              │            │          │    │       │
-    │              │              │            │          │    │       └─ Timestamp
-    │              │              │            │          │    └─ Controller
-    │              │              │            │          └─ Frame number
-    │              │              │            └─ Data length
-    │              │              └─ Fragment info / flags
-    │              └─ Connection handle
-    └─ Direction: TX = outgoing, RX = incoming
+    < LE-ACL: Handle 2048 [66:B0:26:F1:D3:BC] [1/6] flags 0x00 dlen 16  #493 [hci0] 12:36:18.977915
+    │   │            │     │                   │          │         │    │    │     │
+    │   │            │     │                   │          │         │    │    │     └─ Timestamp
+    │   │            │     │                   │          │         │    │    └─ Controller
+    │   │            │     │                   │          │         │    └─ Frame number
+    │   │            │     │                   │          │         └─ Data length
+    │   │            │     │                   │          └─ flags
+    │   │            │     │                   └─ Buffer tracking (optional)
+    │   │            │     └─ Peer address (optional)
+    │   │            └─ Handle number
+    │   └─ Connection-type-aware label (e.g. BR-ACL, LE-ACL, BR-SCO, LE-ISO)
+    └─ Direction marker: '<' = host->controller (TX), '>' = controller->host (RX)
 
 ACL data is automatically decoded into higher-layer protocols::
 
-    < ACL Data TX: Handle 2048 [2/6] flags 0x00 dlen 7  #494 [hci0] 12:36:18.978488
+    < LE-ACL: Handle 2048 [2/6] flags 0x00 dlen 7  #494 [hci0] 12:36:18.978488
           ATT: Exchange MTU Request (0x02) len 2
             Client RX MTU: 517
 
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 11       #497 [hci0] 12:36:19.000048
+    > LE-ACL: Handle 2048 flags 0x02 dlen 11       #497 [hci0] 12:36:19.000048
           SMP: Pairing Request (0x01) len 6
             IO capability: NoInputNoOutput (0x03)
             OOB data: Authentication data not present (0x00)
@@ -435,7 +438,7 @@ frame. The indentation level indicates the protocol layer:
 
 Example of protocol layering in ACL data::
 
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 11       #497 [hci0] 12:36:19.000048
+    > ACL: Handle 2048 flags 0x02 dlen 11       #497 [hci0] 12:36:19.000048
           SMP: Pairing Request (0x01) len 6                          ← L2CAP/SMP layer
             IO capability: NoInputNoOutput (0x03)                    ← SMP fields
             OOB data: Authentication data not present (0x00)
@@ -520,9 +523,9 @@ MGMT Command Complete event back to bluetoothd.
             Peer address: AA:BB:CC:DD:EE:FF (OUI Company)
     @ MGMT Event: Device Connec.. (0x000b) plen 13  {0x0001} [hci0] 12:36:18.974319
     = bluetoothd: src/adapter.c:connected_callback() hci0 devic..   12:36:18.975307
-    < ACL Data TX: Handle 2048 [1.. flags 0x00 dlen 16  #493 [hci0] 12:36:18.977915
+    < ACL: Handle 2048 [1.. flags 0x00 dlen 16  #493 [hci0] 12:36:18.977915
           LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
-    < ACL Data TX: Handle 2048 [2/6] flags 0x00 dlen 7  #494 [hci0] 12:36:18.978488
+    < ACL: Handle 2048 [2/6] flags 0x00 dlen 7  #494 [hci0] 12:36:18.978488
           ATT: Exchange MTU Request (0x02) len 2
             Client RX MTU: 517
 
@@ -579,7 +582,7 @@ Controller Buffer Tracking
 
 Buffer tracking may show a indicator in square brackets::
 
-    < ACL Data TX: Handle 2048 [1/6] flags 0x00 dlen 16
+    < ACL: Handle 2048 [1/6] flags 0x00 dlen 16
 
 The ``[1/6]`` means this is buffer slot 1 of 6 available controller
 ACL buffers. This reflects the host-side HCI flow control: the host
-- 
2.52.0

