Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A436EAA0
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830520; cv=none; b=ppfJXzjr/HkOvY6/zYBl4DITP/XBFNrSn/3FdhbWIoVjQje1P+ZWnSC92i1eiB474VhvPLzgiUlWELK/JWw+STFHymeB03OusvDbVw4uRsZ/Q8Ew7wvmwW1bT/2j79i1JverH7vsHorQp25twZGOsX6vA0k3aXd4sbTOjIflweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830520; c=relaxed/simple;
	bh=6l35KdMCqR9BBMwMztRBVQOGSiJOICfHwGmZO1pnlNQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MstCk4k5I7G6lUmvhecKWjx9xmGA8v/pVxj0OYRmijTT9IH0AFKFDnoIHurowRhtJs50Pg5gyZ4xJd+xILnt1GpBzswitsnm5WnG4xT6Z7BzTjuRyAxdURSV4tCyEbMnQmEZhOgGbmPpCiwurh/GaUWFIUEyyGyRFI+0w1zkOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzrW37ze; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzrW37ze"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ffe41e8e83so689687137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772830518; x=1773435318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3gV5uuH49MWfAtIhq6Hlj1rIjlubntn1KDhGRv2O9o=;
        b=AzrW37zej+eoTWTORQEgEgUpKjv1V/vr6isqF2BHLsTFGLIX4vXAx+E3/hzyWUzlZM
         +WLblCHEfD2dzoegIFfDPS1lIkVBP6zoC3tkMyyPIqwO0KEibDLfBtUolmwEqXcBNqwd
         4DihTXuYzTnYQZBLACdQoIdhWdlMECDNK/hOxdE1AgNtcHhwCi5ARnnpcOkPB5Rp2LNY
         d62Zi7iyPU54Y/HNvem1TIrrkYigGSDjd9kZQDfXkRWatzuDgTlgjXsRUj7c4iMPClBE
         QwKUENggR3yGOSzMhHE/FVv26E5j9kpxwymUgUU/tbq4Eo79p4qfRWJ5zvOLLxd3ciGf
         jmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830518; x=1773435318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3gV5uuH49MWfAtIhq6Hlj1rIjlubntn1KDhGRv2O9o=;
        b=pJvm+MKGDVCRDxB3q3OJgDStzBYa3ikLs73J7w0iwZSuwPdylP8KcMG19iuirlG77b
         h5zmqBOqGGqpV5gtEDMGHtJnWzX/UCi0idfarPFVv0Y1uRc2/gGJpgLAcvtdhusBt9/i
         3hT81M7bb+pgFhYCNpBa4j54WRJmlkYpwkHEF7c0CvggaVjiQ6I+8ND/pXJm5AIdm3Qh
         KGZF0k9dyEITBSVMxVnjEpGeC/FP8jd3iy44ZpQAsZQafyGBPhY2KSBIESPd4S8o0Yty
         s2/WUnTtuKD3m8KVs4lRX7iThnRO81hUuqErGYwtEQLQgVxD46oogKo1cKhYD1cpl1bi
         J5+g==
X-Gm-Message-State: AOJu0YzEtfB3Qm9WWP1RxZcvS/1vAZmhnAAyFMi5NZEmDCXQAxjU78TH
	cz/z2Fkr+vzC0IvAjwjBajEE4mFuMEvzvQTx9jv5NZD+8YwDlrnbMojR5NF4SA==
X-Gm-Gg: ATEYQzwF9nb5BGb+YonJ7Hq7wfNYhG9aLp0m9U+lDQvRunm2VIwdY2EfYrCtyhXftqQ
	5AX/SEcC6o4Qz4hSTdevDSAT88l6z/1zhPHcZD4scrLRGf7dW3MtFHcnpR9IdNQjnEGvaxouv0x
	DISuZfQ7q6U1EEE8Fi2kg3H41/KKWSVRgfqAqMYkbNpXUndi2Cez3Zexvjij0DmAc3rRcx68Agy
	GA41N1yMl0hfKf4L+AD2qZVFYxwIQeba4ArFob3JZCuBm3DFaZoJQ3kzo5GH+wzQ3Xk0mVbIze7
	LquSizU/ovtuOoVGyhpeuw9TIL680j86QaiBPrI0bWXx6wuRUrQmg6rR9ecM5d+YBRYjV0H4zIm
	1dN8GAOTlzk7BcKSdIgh9qTp4dewQCDBjNlU3BwF47BTGBywH6pAjV76xR5itmdj/8r1EYcLpaZ
	YS39HNluZnypR9gy8HqUbXON3eRnP6cocN8eoDn/t3p1ySNmtTwUrWJ54B7Cds/D27al/0Rn8XG
	xl+OtL+/2p+d3UkcA==
X-Received: by 2002:a05:6102:a49:b0:5f8:e41e:e5cc with SMTP id ada2fe7eead31-5ffe5df2c6dmr1574696137.9.1772830517845;
        Fri, 06 Mar 2026 12:55:17 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe898041fsm2849209137.7.2026.03.06.12.55.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:55:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
Date: Fri,  6 Mar 2026 15:55:04 -0500
Message-ID: <20260306205504.701128-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently the code attempts to accept requests regardless of the
command identifier which may cause multiple requests to be marked
as pending (FLAG_DEFER_SETUP) which can cause more than
L2CAP_ECRED_MAX_CID(5) to be allocated in l2cap_ecred_rsp_defer
causing an overflow.

The spec is quite clear that the same identifier shall not be used on
subsequent requests:

'Within each signaling channel a different Identifier shall be used
for each successive request or indication.'
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specification.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d

So this attempts to check if there are any channels pending with the
same identifier and rejects if any are found.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6606d7f12534..d6b5829250bc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5068,6 +5068,13 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
+	/* Check if there are no pending channels with the same ident */
+	__l2cap_chan_list_id(conn, cmd->ident, l2cap_ecred_list_defer, &result);
+	if (result) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
+
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
-- 
2.53.0

