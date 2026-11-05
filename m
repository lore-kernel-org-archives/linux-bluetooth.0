Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917003;
	b=2oaAOuzz0tl87kcjoI+pdFOUGw1XAPXkAYeDBqQK4h63DeEuJBTfi/mVDZWXCPcB3xc7
	 Qc1RCJRlyPEm9lFuqJNRykcgVANo1UQFNrmjUqvR4Wrndelg9vyOkcgIRlp3YsJk2OU4c
	 Ogyh7c8/HryqYLq0AptlNSG3egGw6mtOSKix5bQUNW9DLATB48z6KOyrh14FAIRdUX1nQ
	 t+j2Hmw3p9IxI0J8QR+ps/D66bWAQhnPRZii1P8oyvln0CsPyVqcEfK/QeahvA0LTKMaQ
	 Cqv1w3z3Isc5lwKXhBjfp/H45eCgVMdf1o7qqB7ccqhqbwl6buWo1xI7+WNjHVDWZUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fLGqe0xIjuBs7QvGvPAxQNPs3KVLT+z5sUHLw5OLIMg=;
	b=x0Oc6M9L0CmBDwStA1RdwMakstG00IMWq6vmHtc6rnp1ip/86UW+r3dDtkjeir4cVn72
	 ZOqqsWVOdbDbsvo7VzVCtSRmK6H3dwlNWjtoBcG6xx0/oyeSJsxDyUn/kkNnIwBdxlj7W
	 199jFYJC6l1QwuTxI+4LzyxfxxMHuhikqsq3222nLo1njUhssTpFB6CHi97wgA1IKFODN
	 wUkwydwa2Iaggrcy6+UPtWcFFEkddrh9NkB3MA6BQK6f7XuXvUkdzGu6+8Ti6OxEDwZo1
	 o2grWNdK6Ceu0JIRDx9IidB5kDYD99xsl9AAwN6tCb+3JjIDGN2+XX+ea5N3KUj5gdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uTRz59hV;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3167606A32E
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3167606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uTRz59hV
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc53938a8fso50663137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917002; x=1794521802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fLGqe0xIjuBs7QvGvPAxQNPs3KVLT+z5sUHLw5OLIMg=;
        b=uTRz59hVjdiHEsaNVWtohuA90JaL7EgajjJhPYuk5ZZzMyGl70eRGvMG6PLVMkZ170
         lUyFvLCC5z/c1m6tcsUZkEA5uJJzvjeCpC9LJOLbvElgijHixq4yyQkEFoZQaHQPDTKi
         KNVm2gkINnuUzB7y1VApmTHB5qGttj39lqsGZ6+sZjc0Ew4018trHJTTIlkRYbXkeOhs
         AHPZw/rhXR2XAzJs22Wg/YtOoDBV8ce+A9ANaFBd4Hg5+wkQcTYGdmGOV9kEF7J1maK2
         RCLUG7C30IJBaTXtbV1VhPp7pMGaWSJB/cf0X7Qd/Wb+knVYNJKxr+qB9jwOm4tWY4ze
         /2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917002; x=1794521802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fLGqe0xIjuBs7QvGvPAxQNPs3KVLT+z5sUHLw5OLIMg=;
        b=LDSHwGGFTIDG1W9cUacGzxwSx6PbvtCAFM6IQlgJ9YbYzgxa5oPrkJuj2fU3tI+bq9
         c3Gmt4I2v7NcPlutWXIL9n7vs/k8MZRbJWyiU+YjZRtsqb/PWtL6mX8+mrLVIHc8eatg
         BH1Bgp16KYAd7lCj9r+newsbUREtT8MYKTrOx9odvrYu3F+Vuq2i30K3Y0UtiGait4Va
         bUu9BsNrSd8MVjVzBqAD6ha1b/3kBhIYtCgMrQKBoEkgjCSf1XVwN/eEDSBz6NIGwaEz
         U+n4CEsF3NzAwkQOoT4q5yyZhWwYI+JFno1xexAdKM29hxnYXglLTyqNVvTU6ZpD8+rr
         4klA==
X-Gm-Message-State: APuU4Z+HyzwYPo8DqArmi1rSmi/VGJU76x2Wq+WfqsAW/RYe+AS5q4R2
	AkYtuq6ugrv4Zj7KACwYQI5UsB1dtPn46ajRhJkepqoiQOA/sYWsywRfoc7dzA==
X-Gm-Gg: AYBFou2DjZBl4CfYeDnqEOmyZogRTEyFtsh0Xev0tZAhjeC+3WLy40LtDuhvdhdBiBT
	20v7vxbwRzWNr8UXupxAO4VpZMS1ZfZX9ZXFmi11yXv94qjmZhOIHgCSfvE6GD0Y1yk/pwxpsbv
	hT+eut2JKvIX5uePJfV2f/djrKuvyjl+IKyMRhGybWKO9LCOATT+anSGQzSXhlRRyreAvQhsqqE
	8kef7CxqqoH0ofs2nI26FGwbagUtGDda4eNYR6vC34tvU3dGHC1812MbhNDovHZixt0MHuUXQpi
	Iv4SCU/SLjwXW2m32Y1JExezXdZbiN1UNgqKivnciZtjEyNJPsGP6AUI2Q39k5r7Bo2RXrtA84Q
	Jsu4aJfl6h/dG3FtlWhL/a2ltKPnSaGhRaLZmep2JfA7Jr1RrAM2j3Js9L6e4F0i4Syf4OG6hHi
	XAHnKyy+nYkuI28ODKFFc1WSDVNgKiMSsc/FKsyXsqmeMNkti7Z1qUhtpWI4Y6+AFFaBrK2HVD1
	eY8b6UVOO0CSpVu9Z3Gn07LBziFR85MmCPpaHaodXBYGuhUM/wnvfpXavhT/sWH0AFn6rvL7jfl
	g1ocGuXWt0fPyzNTsEaB4p1jUVGtCl023hRG6amBy+XUMFY5RwRCO/bGYkdnV7dL23b9BdZeagg
	y3YcKsnYx51mJoe4xWU1nqLkYRokAQyQCTc7dPg8V0hO9GxJwRXLzVYO783ZBadKCFZ2+ubERBB
	O4AEw=
X-Received: by 2002:a05:6102:4456:b0:7a8:10eb:96ce with SMTP id ada2fe7eead31-7d2a130980emr625550137.4.1793917001752;
        Thu, 05 Nov 2026 14:16:41 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/8] shared/gatt: Validate Read By Type responses
Date: Thu,  5 Nov 2026 17:16:31 -0500
Message-ID: <20261105221638.2332398-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105221638.2332398-1-luiz.dentz@gmail.com>
References: <20261105221638.2332398-1-luiz.dentz@gmail.com>
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

read_by_type_cb used the peer-provided Attribute Data Length without
validation, causing a division by zero when it was 0 and out-of-bounds
reads when it was shorter than a handle or the PDU itself. Reject such
responses as the other discovery handlers do.

Also check the iterator result and value length before reading the
Server Features value.

Closes: https://github.com/bluez/bluez/issues/2746
Fixes: d21412b96048 ("shared/gatt: Implement "Characteristic Discovery" procedures.")
Fixes: 76d63c91b27a ("shared/gatt-client: Add support for EATT features")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c  | 6 ++++--
 src/shared/gatt-helpers.c | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 836a59a8c990..09bd9c971ee5 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1565,8 +1565,10 @@ static void db_server_feat_read(bool success, uint8_t att_ecode,
 	if (!result)
 		return;
 
-	bt_gatt_iter_init(&iter, result);
-	bt_gatt_iter_next_read_by_type(&iter, &handle, &len, &value);
+	if (!bt_gatt_iter_init(&iter, result) ||
+			!bt_gatt_iter_next_read_by_type(&iter, &handle,
+						&len, &value) || !len)
+		return;
 
 	DBG(client, "Server Features found: handle 0x%04x "
 				"length 0x%04x value 0x%02x", handle, len,
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index b3d5d8f1a483..e3281ec17758 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1299,14 +1299,15 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu) {
+	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu || length < 3) {
 		success = false;
 		att_ecode = 0;
 		goto done;
 	}
 
-	data_length = ((uint8_t *) pdu)[0];
-	if (((length - 1) % data_length)) {
+	data_length = ((const uint8_t *) pdu)[0];
+	if (data_length < 2 || data_length > length - 1U ||
+					(length - 1) % data_length) {
 		success = false;
 		att_ecode = 0;
 		goto done;
-- 
2.56.0

