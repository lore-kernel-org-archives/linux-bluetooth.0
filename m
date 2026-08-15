Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC4374A1E
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775066; cv=none; b=uziiSp6WAQ2+Gi6GZclRkZweol7koQb8p38oaY6aWOwR+1akYJmzJ0pxtb4Bag6FZrj0oBZryANiWYVPG2AgfvZLAxEMY4SJYOA8eZ/e6H9XGu+1KABGDTKCDFTAMZf5ZR4MBWJdWdM67rDTmWu7KvfBx8e02YhLnPI4sVTfaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775066; c=relaxed/simple;
	bh=JEvtiCiT2SNAxC5dJCpMsln8bLpWOAJsYTD5ozGyV1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bu6C3Im98e+tS87AOqAR9ZmXztqsp6oXTxreDqvHxSVXOKl4QxypCwCvWQof5at9+mBdKglI7cBXe5GhHwRYjefJU5swBAbYK32cL/eJFmKNVwtrOefzRclSSLJZkniP2Upd9+bEQUezwecW5IZ1m1wtwYqVvqYC5n4U/wuEbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMkdlAid; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMkdlAid"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1532623a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 23:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786775064; x=1787379864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQWoK3r7vnsX7xRRasz6aMzEcL/clDDXaeOmGh8lZnw=;
        b=gMkdlAidrAROE6Mt6bJ66128vD4Ed+a3elEJmGw8aKt2UnrYnnQVkvWjjMjQZE+vXy
         +D1xC38pXUcpxva4C+WLA6X5YZEpYZURpD7/QZEupq0mgF0tG3tblSrT39Q14InpJnwG
         J4YCLpzPf8nuk60CPGoTZq361SzHT2s5jdU4HeUjllc5lLh1B1LXKYOw7Z+MgX5Ol3IO
         k72g7FvmcAK9K2AZNpI0lWESKS5Su/CoA3luOOzEiDADSDT/Fipmft/NqS/JSsyFB7wn
         AswcAbMYHSdJdwk1VPBDEDx6CUevwMnlnFyF2NWsbeh/KcZYwU7HRGITxN0lnPj/AiPM
         0eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786775064; x=1787379864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQWoK3r7vnsX7xRRasz6aMzEcL/clDDXaeOmGh8lZnw=;
        b=seIQ2/2g0FnfHNEMAP4dOIA5CW0foDdfsHN3jjYEke2DpYfz0ZB7+xxn2fFafYIHg0
         wdP8zu8MXthLwPYf3zBdWeCUNwBaOJrcaYDWtap5JJTusbhCVQON1/DI/TDpIZSr60A7
         Gb3J5w6jks0k0BZPhfHAHWDVS7cWUflZ9/ZkVH98kM95JrsDroiYNqHlSBut0DsNlgDq
         LCVeS4tUqpx7p52gyyLgB43OW7YebVRn7XYib0zF3th64bVJKERO5lMKdx6c3KX5gELG
         sUpx9G4wyNpHyfVBiqlyKlCRFsKa2y3wanozznZElGXEUvHKEFiYiv9SR73AuiKkceUp
         Vpsw==
X-Gm-Message-State: AOJu0Yz3iFYb799laGqMPmZNot7lr1XestXGb7o+BPm6GKekx0KsrWwi
	dTxJ0WwjxEUMSjAhAVQvOuawZv+sXg2cvNbODmHtAvp9wkGxkd+US756
X-Gm-Gg: AR+sD12tp4yD9dt3i2cxF2OsYPpfhv9c2qLkNGLJeNJ6Xuvs0KHRogvdGbvBy6nzCq5
	N7CoJE+kewWhjMe88fwTj8nAVBMQ++ISMDe7x1q/Ld639QP/a1NOgiosW6WHVp2Ie9kupvuK1sX
	3FTqmkef9tam6/OF21Cma77w7GRAWPGah0FuXTxgDIkNUlYylS1lN1B9Uik9Wk1PGkAt+M+geUu
	3L+h5wuU2a/Q7XsP+cncpwpFSvCfDt+R56m6XJM4+zrAqfwblik58beO25pijJk+95uVRdS4qV8
	Xs7w9noCKoIk6yBPewdJj9RaJoSb/6/lhC/kUS9GEQnFC81CyvVu3nshQvGtnw/lbepxkqYgBnA
	6UUT09bWU67ee5DJofoTQfhGEpz0JhynGhXDskzyX6AFwVYEJLYYs+Bvm+RNPNNY8GBH/WXxLiI
	I95oZonwHZ0XbhuiNjRuwtk6QePxRv5YWGZgGpK/TunUvgZyYdRssyb/LOXabXbJqwzoOJwJBiX
	19KQp63X3JRTEh0JBX7JnXlie4wvl2o9fza6SYo/F0XM32TCinaBA==
X-Received: by 2002:a17:90b:1806:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-3933b907356mr11091295a91.13.1786775064186;
        Fri, 14 Aug 2026 23:24:24 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea96c7fcsm5427946a91.3.2026.08.14.23.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:24:23 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH v3] Bluetooth: eir: Fix OOB read in eir_get_service_data()
Date: Sat, 15 Aug 2026 15:24:19 +0900
Message-ID: <20260815062419.37489-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eir_get_service_data() walks the advertising data for a Service Data
field with a matching UUID.  On a mismatch it advances:

    eir += dlen;
    eir_len -= dlen;

eir_get_data() reports dlen as the field's data length, but the field
spans dlen + 2 bytes once its length and type bytes count, and more
when non-Service-Data fields were skipped to reach it.  The pointer
lands correctly on the next field.  eir_len does not, and the shortfall
compounds across fields until eir_get_data() reads the length and type
bytes of a "field" past the end of the buffer.

For an ISO broadcast sink that buffer is hcon->le_per_adv_data[], filled
from the periodic advertising reports of a remote broadcaster.  A PA
payload packed with mismatching Service Data fields walks off the array
into the rest of struct hci_conn.  A drifted field that matches the BAA
UUID puts those bytes in iso_pi(sk)->base, where user space reads them
back with getsockopt(BT_ISO_BASE).

Recompute eir_len from the end of the buffer each iteration.

Fixes: 8f9ae5b3ae80 ("Bluetooth: eir: Add helpers for managing service data")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
Changes in v3:
- Commit message only, shortened.  No code change from v2.

v2: https://lore.kernel.org/all/20260624143222.883120-1-sammiee5311@gmail.com/

v2 drew no comments.  Its bot run was 20/22 PASS.  The mgmt-tester and
mesh-tester failures are not from this patch -- eir_get_service_data()
has no callers in mesh or mgmt code, only in hci_sync.c and iso.c, and
iso-tester, which does cover the path, passed.  The previous fix to this
function, 20a2aa01f5ae ("Bluetooth: Fix NULL pointer deference on
eir_get_service_data"), also failed mgmt-tester on its bot run and was
merged.

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

