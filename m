Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE6440632
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289062; cv=none; b=lVYOF9m1jmYf2/7g2ijiAzNKN3cFeptfjbATHd+wnRXlrpF+yPuqTYdOSBOxBa+vS3C1DxM9jnv2I3xLaTp7DU7/pPG2RodOL7NGbWRNx/ULUlKsj7xyw/iZgxND+vMLhbSxbjjSEReTPtBvO87jb7rRx09t5gLbfKm9b5L9nAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289062; c=relaxed/simple;
	bh=bdAagqAs0b1MGOUcgJ2e3vFE/avgZo8hvzyvybGoe4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gS2+bst693kGVERV/sCqQD0gpCwJqQwAdUHpFGsK5+3C2R0B8i9qHvJderEKp/Q+vKez4Gx04/aMoXfO1xjgko1EVkKJfdA8kvDd/Pfq5XK5iwUAbNSS0YjDFKMNGIeQIn9GqxnXS/spnH/G0S91tvAup0YbnD3+4jIMH+upu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE08dhQH; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE08dhQH"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98e1942dfso214988e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289059; x=1790893859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LnFmf7TyEvcV1AIaMAYFTJhUcAWz8WBQusWqysASTdc=;
        b=lE08dhQHhUeH0IRLk8PYJs4HlPLKFlJs9MB/TzXI560eo4JxnaOuKrEydnTkRhmfJZ
         Qi3eLAefb/JeQPizVAqSCFypWGSaU2vxPDchfnQCx/1xUpx9MO+3T9Tg2xGJjFopGNb3
         1NXvCDIW4MxZZfGxOnUPXXZIsKJ/+u9HkGMjv2QU6oRYDh2H33A8sRdfL6IMb1Z8pPlA
         bqnNGDxdv7xXQ7K9nLmfE1DC57VbmC4mxn5vrWDwYIfUQxoEUIdlMzmZwRHgEDQopLfA
         MXET0oLy5dimQB1d7Mfd4BIhbAMNIzUky87yeim95OXLVAOyO6rsZ8MM6gu/4iDL3VOG
         IF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289059; x=1790893859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LnFmf7TyEvcV1AIaMAYFTJhUcAWz8WBQusWqysASTdc=;
        b=L+7E09ikSlsAqKD0RKNpCaz3sPB64Bag8MnCxqJ6Fc18w92CkAvln0G6MCBQ0+oQ1A
         G6HB4z66BOCwa0mfkxO5/PW8ecFZSXcAm/FF2aqQznOceXYtnKbboNPhM3sBRXURa6QS
         TRq1wCRIQuWVMxQMidTZqmkXwpxokvZ+eNi59wpcnMzpUTAs/zHFdCYKcFTBPhxMcGhx
         cErcFHCEvfq1b4cRV+8kYnvHlj/QPG7XrvcgtuY+O/Blw533UxTUPCChVCQifTP3JmaB
         5f8qXivtyJxb1TpXUe35m5pDMTZKy6JUQX4/fWjthvGQ7T7ptMdlHxT7FgiAXfTMjQkq
         psdQ==
X-Gm-Message-State: AFuF++nReCaLzldMVqc3HInAcI1zKuScM8K3cA3XVa1ZEFFavEw3FxP4
	dyybQzp14aLmxDDGTQXDov25zx39QeEchvTDxf7CiqLsLXvRHyHwb+mTgUkDqZtU421hkQ==
X-Gm-Gg: AYBFou2ogWupPFEjccbOEwFqWevT1OPijWFbTlnDecrU+gTE6j9D++KzwabHP4rvWEE
	eqZ8kUV9lH0MVj/n1jJbaInAmcLTtADCYMkdnGgIMgskzjD0Q+vfVsHPMQybPJmhVfb2lcwq9mo
	LpMNObhf+knBiU5GLvrxi/YHmeYeXW+290SdQRE4kiwE9h199Jg/vgsSZyS/KHWIRKXLYOHtS8e
	J62/1/oTduXR/MIm64eesBEHmUQbkPJ9X3CrKs3QISguJtD/pZ8cunALjCARtTZzyNhYCdUsdtb
	jX+rfFQMQYaIUgdbmlU1K+pVFMVEROXqwpHUs4JOlwAo6t9/O4BXjJ7ZUHiKsAFyy/GQ/LZ7Veu
	jVTmuyi3Ni8z9NKq+pTRYybu95DHK7mKaG0t4QkGbiwjBtdmAcveZIhr9AIE4frV1Qgp0Xcy2fU
	wmeU137RCsnC6gCXhk96qu+Ards7YfrG/K1wLROwIPNoKjgAW5PEDxAxHmwALQQ3CAAPFh2cGiT
	2qA6GDhfJzXQG8Q0UXKj7Kxwx0TaxAW4Qfhse7yc8bFinziequfd33swCpW840cEtp25Txpg5U=
X-Received: by 2002:a05:6122:198d:b0:5c9:82a1:a6a3 with SMTP id 71dfb90a1353d-5cb08753a03mr2177843e0c.6.1790289059535;
        Thu, 24 Sep 2026 15:30:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.30.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:30:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 03/20] client/mgmt: Print Connection Subrate event
Date: Thu, 24 Sep 2026 18:30:28 -0400
Message-ID: <20260924223046.605543-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print the MGMT Connection Subrate event, generated as a result of a
LE Connection Rate Request, e.g. after mgmt.conn-subrate, or a change
initiated by the remote device, so the new connection rate can be
confirmed.

Assisted-by: OpenCode:claude-opus-5.5
---
 client/mgmt.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index cd2ef80221ad..a7069e5bbb37 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -499,6 +499,35 @@ static void disconnected(uint16_t index, uint16_t len, const void *param,
 			index, addr, typestr(ev->addr.type), reason);
 }
 
+static void conn_subrate(uint16_t index, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_conn_subrate *ev = param;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Invalid connection subrate event length (%u bytes)",
+									len);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+
+	if (ev->status) {
+		print("hci%u %s type %s connection subrate failed status "
+			"0x%02x (%s)", index, addr, typestr(ev->addr.type),
+			ev->status, mgmt_errstr(ev->status));
+		return;
+	}
+
+	print("hci%u %s type %s connection subrate interval 0x%04x "
+		"subrate 0x%04x latency 0x%04x cont_num 0x%04x timeout 0x%04x",
+		index, addr, typestr(ev->addr.type),
+		le16_to_cpu(ev->interval), le16_to_cpu(ev->subrate),
+		le16_to_cpu(ev->latency), le16_to_cpu(ev->cont_num),
+		le16_to_cpu(ev->supv_timeout));
+}
+
 static void conn_failed(uint16_t index, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -6006,6 +6035,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CONNECT_FAILED, index, conn_failed,
 								NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_CONN_SUBRATE, index, conn_subrate,
+								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_AUTH_FAILED, index, auth_failed,
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED, index,
-- 
2.55.0

