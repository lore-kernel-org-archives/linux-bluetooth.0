Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619923C6A41
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311553; cv=none; b=peeO+z/Y4HBf983fFPeZgUupf/c1LdGs857pYL+488mmqwAf7Z6Jv5hyVQLhomMGPUFMKNTIahqSssI+NpJUEylqNubbjnGwoYgRY8Hx+bur6tHtl0ugrS+C5qfN2mvmgC/+KW9EotVSmU+Kiw95E+RzlLon3gXebdM6+puB0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311553; c=relaxed/simple;
	bh=3jw0dPXicuYVunThsf727I5c27B62CFGeg4SsJeHGQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA3Azm4vFvWdOL20itDhx6Eh8AJqRAXIc4J8U8usvy+6hc+4JvPHiIv1r8yh4pLBCJay0k+Bl1uilMIh0G60tml+TMRQ3xTBf5roJ3wGzB76lW+tRF/A2NGP65vOvGkMdJ5cMaULOj+CAN4FFFkU5osoBiQIhmjy/1P8r5pZDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swIF575m; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swIF575m"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c891d27b10eso644732a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311552; x=1782916352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX+FzcCzMCbQ0Z1ebqZSA2AR+d8QDIytple7rfFBzzk=;
        b=swIF575mS5Ur30T/8G1gPle775O+beJTenK15aMYNhtT4sP5TyF4cxVF27Q+V/mBRT
         lYmElDpwOnY+ay1SuULYE1VMuV9Dqh4MRUCSHjf5DZNvWoXM0OEJ5UG9MRoDH93nos6t
         JMRZ5Linc3QjCFC8DVnxJreXW7DMu+Nv3gz2pf5Je90RnwwIO70fB/X7qxGBWi3Nhbgd
         bNPGGeKouofNoH8w6JrxOd/NgXD2NuTnS3VE1TcW93GKV2GeoSWA7GA6h0Ab+o2LP2KW
         Pz2QpnbOVJzm/lFmwOd5NIwPp4OMkyQdbAIKomvzc9okfcWK+9+aZZke9C+NMfaK/gWa
         3uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311552; x=1782916352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KX+FzcCzMCbQ0Z1ebqZSA2AR+d8QDIytple7rfFBzzk=;
        b=Nfb2ExuVd1YZNmUAhosDMKprmb7AK73UDKIAqHRPqR8wJ4QgkM+3Ot6P0l6o8xcWNd
         hfnRs1fZXKaTrUgdYL2w36xDxTFdiTx/zyq9eE9jVqBDxhogdO8pbnDMXpeKMuOEeI8I
         8RrfguehC9xlv1Ms06LNlUC8XPtF6ll8/H1fHyM7+yFPnWftf/ZH0CqIDSMmVb1SDGZy
         uaLvWPVHqPXHijy4EpOZONhHTEHMVO9A/Lt1w8GKRaI334sltCYWGdMDaeTIHBWhX5Fz
         eAs49l6RDc5yi9Snd2qT3iGty1jIIdyop7LMEfSTG1D3giMg9L5xp8mPC8oB7VKi0KJc
         bUNw==
X-Gm-Message-State: AOJu0YxUjfTzON+d5kzvjohtsyu2hY/i3IgadDqxDHvDdcxuFVNGeWtH
	BANkI44CfpVGYcWGtTBmW4GOjuKYOdfzz76G+2TfDLH66WzkhzFZnb6+ytJgUTMa
X-Gm-Gg: AfdE7cmvo3EFL1SqIx++zg+VF0YdKebVrMY4hfl3G1aV3O+NSo0SssNQKwaiFjx5nIS
	8P/fANqbKRBVP+locRDrBhJpCDw+c6KO0FiFRzJVHNownLSXUWh7wkU2g+dsXXbkM1mr7bDlStK
	Wof5n5QeJ6CzCQn/DFpuHrsR4eDEwcXLyhTGH2q5ZET/Wtlq1+3q7pv4bkCqIv3wEH3xj+AC2wv
	K4z+k9OBgGCvjyZ1ECbt0I//W4rUdB4kKZH5yGttm6aScEWnHPMnUDjWMtH2WntTNAkNylyiMUV
	sE0V1Cr1VjEVwuYGeKUlAwHX39/mDfyfljVyW5yYCgpj8HTbDH8y0mzcQPBAG1TogBJwbdUCKSJ
	ZV43WVG3tfobioWh4HWp91yxJTjUDrarP3VFVuNydbtN0LTMFyKVPtBp6QMLR8/t2WAe23C8h9/
	ixxtoUVcHk2G+VIwDAKabJBYdBXhlzJNIbRzFvjdQDV2OGeIn/6eWCthfl/5C76QwX6NKTdrbyH
	W8H+A==
X-Received: by 2002:a05:6a20:3d07:b0:3b4:b275:c5b1 with SMTP id adf61e73a8af0-3bd2d2341b0mr4675063637.26.1782311551485;
        Wed, 24 Jun 2026 07:32:31 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5d04858sm12884295a12.28.2026.06.24.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:32:30 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: eir: Fix OOB read in eir_get_service_data()
Date: Wed, 24 Jun 2026 23:32:22 +0900
Message-ID: <20260624143222.883120-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624115439.868817-1-sammiee5311@gmail.com>
References: <20260624115439.868817-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eir_get_service_data() walks the advertising data looking for a Service
Data field with a matching UUID.  eir_get_data() returns a pointer to the
matched field's data (field + 2) and reports dlen = field_len - 1 (the
data length only), while the field actually spans field_len + 1 = dlen + 2
bytes once its length and type bytes are counted.

On a UUID mismatch the loop advances:

    eir += dlen;
    eir_len -= dlen;

The pointer advance is correct, but eir_len is decremented by only dlen --
2 less than the bytes the field really spans (and less still when
eir_get_data() skipped preceding non-Service-Data fields).  eir_len thus
over-counts the remaining buffer, and the error compounds across fields.
As eir_get_data() bounds its walk by this inflated eir_len, it ends up
reading the length/type bytes of a "field" past the end of the buffer.

For an ISO broadcast sink the buffer is hcon->le_per_adv_data[], filled
from the periodic-advertising reports of a remote broadcaster and parsed
by eir_get_service_data() in net/bluetooth/iso.c.  A crafted PA payload
packed with mismatching Service Data fields drives the walk past the
array into adjacent struct hci_conn memory -- a remotely triggerable
out-of-bounds read; when a drifted field happens to match the BAA UUID
the out-of-bounds bytes are copied into iso_pi(sk)->base and become
readable from user space via getsockopt(BT_ISO_BASE).

Keep eir_len in sync with the pointer by recomputing it from the end of
the buffer on each iteration.

Fixes: 8f9ae5b3ae80 ("Bluetooth: eir: Add helpers for managing service data")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
Changes in v2:
- Untab the commit-message code snippet to satisfy the gitlint check; no
  code change.

 net/bluetooth/eir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 1de5f9df6eec..a55696820b22 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -369,6 +369,7 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 {
+	const u8 *eir_end = eir + eir_len;
 	size_t dlen;
 
 	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, &dlen))) {
@@ -381,7 +382,7 @@ void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 		}
 
 		eir += dlen;
-		eir_len -= dlen;
+		eir_len = eir_end - eir;
 	}
 
 	return NULL;
-- 
2.43.0

