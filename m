Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A53D093C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178850; cv=none; b=Br4nVTFtouXY9vIdQzJvqHlQ4eQZBX2YqtZkvT8ubOVHzDEqi9bgYzueIqIIvH2avxvY5hlWwwgaIWv9Gbt4GddQdZJF8hpeuguuU6DrD61+VC+/9tdbJyGG+QGzLIPqYFLzhk/pAeSrQusw1PzZr89A/CXXLiuVtgr5EOH6ATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178850; c=relaxed/simple;
	bh=FG/Wc/2tK7vq79MkDHDdeYrMydAA0XozijBBFnJF4w0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=alJCxrYwe5vI1OMu/hBPbXyPq7Ot3br/zrybZLVSPH74mmrjkThSK0TunCaZmk3ufaisqFug4z0no9asMX4oyasH81Y20sietlWyMpVjhMXXUHUnaF1/jlEInCmi2mLsA+9lOYLdrClWaG8Begz/I6BSGIUpx7orsLqXksBwkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpHhKNDX; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpHhKNDX"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64c9ebd1369so12492964d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178848; x=1773783648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Cy8GNdVWNB2uiWikka88eCJ/5NNqHej58e2q5vzius=;
        b=NpHhKNDXt676qoGeahKYdWy/+qrlU2yRPoIAEAeX8+pt9kY5Rk93i83xFOsqVaDq9v
         X7TkZri1GbEL71OSJEZS3TKbFR/C7N0XUCDuWSPh6p4KQS8zHpoZ+8yOjpCVANr1FLX4
         FNieN2OPVMKyfD21Wre2Ll3IW1oUJSO9vNUjZKuNs8InVcsKd6Ms3nufzIW5RkAVM0Pz
         WiJXMaaIkkTY9gGvCES4YgXY0/sZvOHW4VtmVOv0wiaMwEgJjiF6udHd6BUmJ/6KcRkT
         8KKNHpPeNXU2/7jMstUZGoKfimcgremsubQWq0m2/iOQUwvEtMgeguHsZA9u6Of7G4ZS
         Xsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178848; x=1773783648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Cy8GNdVWNB2uiWikka88eCJ/5NNqHej58e2q5vzius=;
        b=lhwgBU2WhCGHNRaggKY67c9Dwqb6N+8Zkd7CcZVRMBQ/B2N+4zR50tI/jllppn/w8i
         EyJ3+8dRgDKiv6Z/Fs+pHTdmO7RjgcjbXwG0+TU/aQur7fGWrTHIxFCgQFlTFw0nojGi
         HJ5fwe0RUwA8xlroBaGBmnyyknsJh1QKxppUdaXQDl2XGRx5NkgCofhB8MvY/7AdYJT/
         Vrf6GzVzhFa0gWQ2rdX9PggD946BWIYgafKlnL0OpfnmH/3mf6Ol2YipinMzwJJedXZV
         heCx3DowhpFh87TTjwLamIAdSd7jlit9EKEaT6Iom3YK9jR0b3zxBAfogAdbjf8ucsBO
         xIDg==
X-Gm-Message-State: AOJu0YyzGv3ChEuW+3NmKTKQpyOfr8MHaalOJgbwbzmfGV/Bs70PePio
	SFWRSReDzfR+i8/F1pcl/DuoBU9Ck+lLlAtGFCj2CF6oN9J4SsH58Gffp9gdKJUy
X-Gm-Gg: ATEYQzweTEY0y8d8rOPBuA36mlFUHxw3q2dvmIplTch9mv5FFB2IDmQDRt6QF+2irHo
	Jb+tGwBsf/HxeUofHmHjPbnJTewSGUR1/Y6d4Ka/YFOI5Usu1VnBdGNy9HDuXJDqtG7/PJfhFQM
	lHguSvibNlADAA8O3D+5KxP04lvoj1IGcWYnkzR411Fktn8QKYnIRbiTI1Z7L+eMDfiiXWH3Vy2
	8RFt+22+WfYMBK4J4fwv6fF/8kdyhcfgzIgnYQTkIugwiC56EnBnq7TI9EmZTcNNOuLpTLAQ0WQ
	A2SghpDp+X4Ezsf4f1jOIxJIlXDkhIjTbgQPDslGuLZP30nfrcgsoKOlZKAZeOYqqDZmxYC35d+
	TiJkCz2FbwQH6Tn1L/0eLw7l+gLwzC7vpka/7o9I7vFX2gb6qlM+Q5GFqIc6bQZfV+flgVOCJ2d
	YXwqwEOE4Fhh7PEo3m0e6vFUVzmK9Pq8nAv2RZpaUx8hOFALrjJZ6sD15DWfROy1B828BRcwz4J
	Mgf+Svk6XKbRtsBug==
X-Received: by 2002:a05:690c:2605:b0:796:3f2f:a33b with SMTP id 00721157ae682-79917ec5454mr2151407b3.18.1773178847681;
        Tue, 10 Mar 2026 14:40:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917e0c421sm1254187b3.13.2026.03.10.14.40.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:40:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
Date: Tue, 10 Mar 2026 17:40:37 -0400
Message-ID: <20260310214037.732139-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6606d7f12534..3b65f8d605c9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5055,7 +5055,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	u16 mtu, mps;
 	__le16 psm;
 	u8 result, rsp_len = 0;
-	int i, num_scid;
+	int i, num_scid = 0;
 	bool defer = false;
 
 	if (!enable_ecred)
@@ -5068,6 +5068,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
+	/* Check if there are no pending channels with the same ident */
+	__l2cap_chan_list_id(conn, cmd->ident, l2cap_ecred_list_defer,
+			     &num_scid);
+	if (num_scid) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
+
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
-- 
2.53.0

