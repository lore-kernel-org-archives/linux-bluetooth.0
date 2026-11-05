Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917007;
	b=ZlXxyAtkW582+uvSAzuhyK5wdL4ke8Vj7RjDEX/6wHE2f4M8BvD92O8BOdmGZhWT/fUd
	 obzcMapU+/EbSiXELuBF26/a8PwbaDeGtX6EskhPUucBUSbY9SLMiXI5ZUkNtzp5D5hEa
	 qiBNXUi7ulItqXXzGSBtvIjYRTqVIg7y7VScYk90yC5dwCw4DK6G+19jx63TtQNUrFMy5
	 aX+VpJdeOdbjdaR4fdFFgEByM3JF8blcp7hBv3P+JnYCzDmGtf5uHSMsZ6WWQHnjso+pW
	 V/BZTBuzTrcug199WPg25cZDRgoU6C19xsl23a+VpPouEK4U7UZAw1TtbdoGjGRgVaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p0XlDhv2VLB442UaEyH694WjX0V72bY9f+e6oFTZLeA=;
	b=J8pbMQ9DLuyotm5kYFQGT1asnYwb9y9a/hSllAijKHkEi7TGQ7YZIC1rmeOmnLQXUvpW
	 BaBRaDtDxOvp9rTev4P3fkF6/vcryuHgf2YrdzRSurPhk3XNRIJmUVT6dzJMU2R5dUrkV
	 H+hDHn2nYqkmZFYfQWbIHIo+UQRK75qnWkIO5LnCPQsXJHEzTOsH1TIJLqoEngbHCjg5r
	 IvAm3OvmJIuJMU5pokKgUfKtJhpoAwTKRMa6e9f7FqExvHUrEiD1DvDB0zPCjGyTgxqlZ
	 /ZiqL8zbn8cIyqsU39NJZyvj+/ObtsDNELHgPHDq7bKexNgqhaDKD/PD7CA4mxvZmGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KenWTKVO;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE05606A331
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 22:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE05606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KenWTKVO
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7ce77f98658so23881137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917006; x=1794521806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p0XlDhv2VLB442UaEyH694WjX0V72bY9f+e6oFTZLeA=;
        b=KenWTKVObkMlzAXI4sckKMBfMX18ZOZYmPddgJsnp4LAxdmqOoCQw05rss8RDDCoqF
         UGZ2NHMcwfb5MZNRladRKvmtE/AmHZ+N2Gqhw3WrBsnfcEYxhpvzQ82YHusBBPXQMZdQ
         Og3A8DbgwAPcK19IWJ1b6vZfA1Ug6cPL/zijWG/fhir8+B0Y6fuuDdrl+S4Mz1hi2Agw
         Xbb/odOPmhp8PTrpZep6sT4sY3vdxrz4wcLsU88Z409xi3dIR8iy0jZv8lkJctxmeHie
         7bPZj5iCgx0RcrNNP1+VizGyiQJ0iHs3sCXU8nscrUFRSPhi9AX2rMtKscV5RKiLoBih
         +FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917006; x=1794521806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p0XlDhv2VLB442UaEyH694WjX0V72bY9f+e6oFTZLeA=;
        b=dnWlPl9EBevRloJpPIfeJ2qkBBFhb9SZNKx0vFXyQRzlvvgn6wj0WGWO7T1Gp8x4Ii
         Wa8UEI05mHCpLSj1Yya0Wu+VjSHmh7sfdc903RFznQC2kbEBsHFcuhXCCQA2yBDUF+pw
         3OdkQsH5q1kineWATeKGJ72tJxLzPCTlbwKmcrHA7uTmsbLVWfOsqyqzsrQKKp66w1K/
         AK5imcD2/Ork+ymuGteL+5A5inp6nM/NvYG6/dIPXrfwtzmj94E/i2vA/7RFo/ehjv8P
         LNAfVEn0nUItN5lJzUM86w3xUMREgQahji8I/n5CX//wPVoiwjiqoMiYdsl7EnGNFc/Z
         a3Pg==
X-Gm-Message-State: APuU4Z/E0o9Ef7r/gr4sqQndAfqGW6uLBgZwAk5qRFrM8PLkigMLhbv6
	o4Ktg0tqtXKKTWcwLernilcKVie8Bt5WJt79+TOVzKcR7IjuRM9J2uSwDLVVlQ==
X-Gm-Gg: AYBFou3M8cqJcdrnzNCKIf0J4pogDxdWM36XFdb2Cluadr05c1klkfExEPNFCzYnWhw
	g3x2dyoKYwd38sHOn1onqyW+H/qD17g1U1klgye2UhzbKT4ozuwXyX2rbpHyLtEiIaIm/aP0eHz
	D5COz3FAo24IAhYIWW2gKMnJTYn7GyGLmwF8SzQ+bp6+llUQ0/4jg8Ph+yIhgZf2+tHl5OhTOga
	7dy47NM9csiktwThaqIsthw0mbiW6FiARN2ptqCwSxxtkNn4R+NnQjG9khh4f9eNvxo2sU9mWW9
	kx6PR5mZ1PyGXA138KNTGXLmESBIONcWcydzHfIhbhSFXVD9jzDsw0d5eMI27Ji5nJwqEfYPUeV
	7Yss1dWVQP2nkd7+nIMQGyRJvD1DwFelVLNuiPXHg/Bf4EsJ2RST2HVrt8pKWR8/4MPvUuxOHzE
	5TkM6PZ3vYEKJF9/uYx1/Oj6dYEbBI0tlUkK3bEvgEXbZcjttz9lAQywIUlrqKFNKRP6ZlLP1pY
	I93ImQM1x+CDSUz1uZareW90k8cd5iJyismdw2jrYEouQR/lMfJiDWxao18nNCWBdJfN7kxG8Rx
	zL5v0y6F2HsIwyVOpGFS7ZrNljdUaJBkZWPQagbV/438IHfAVgKgG0n9MKipgsH4mRmRdbWRori
	IsQVXKACFutsl/oCzr29HqSfDs8jV8whwaLab127CLjvzYj1bKdRYy+OIBHxy5PgVZ/n9gE14Sr
	rNzNgAwfKLF0Hrqbr8AJ0ChjhT
X-Received: by 2002:a67:e116:0:b0:7cc:9f01:1378 with SMTP id ada2fe7eead31-7d2a12d9fb5mr580926137.1.1793917005952;
        Thu, 05 Nov 2026 14:16:45 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d29d1ea0efsm1355419137.6.2026.11.05.14.16.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:16:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/8] shared/att: Add Read Multiple Variable Length opcodes
Date: Thu,  5 Nov 2026 17:16:35 -0500
Message-ID: <20261105221638.2332398-6-luiz.dentz@gmail.com>
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

READ_MULT_VL_REQ/RSP were missing from the opcode type and
request/response tables, so bt_att_send rejected the response and the
server never answered the request, leaving the peer to time out. The
client could not send the request either.

Fixes: 3c5088f040ac ("shared/gatt-server: Add support for Read Multiple Variable Length")
Fixes: 6ea204dca0b2 ("shared/gatt-client: Add support for Read Multiple Variable Length")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/att.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index e49743b5a764..3055f291f8f1 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -129,6 +129,8 @@ static const struct {
 	{ BT_ATT_OP_READ_BLOB_RSP,		ATT_OP_TYPE_RSP },
 	{ BT_ATT_OP_READ_MULT_REQ,		ATT_OP_TYPE_REQ },
 	{ BT_ATT_OP_READ_MULT_RSP,		ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_READ_MULT_VL_REQ,		ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_READ_MULT_VL_RSP,		ATT_OP_TYPE_RSP },
 	{ BT_ATT_OP_READ_BY_GRP_TYPE_REQ,	ATT_OP_TYPE_REQ },
 	{ BT_ATT_OP_READ_BY_GRP_TYPE_RSP,	ATT_OP_TYPE_RSP },
 	{ BT_ATT_OP_WRITE_REQ,			ATT_OP_TYPE_REQ },
@@ -172,6 +174,7 @@ static const struct {
 	{ BT_ATT_OP_READ_REQ,			BT_ATT_OP_READ_RSP },
 	{ BT_ATT_OP_READ_BLOB_REQ,		BT_ATT_OP_READ_BLOB_RSP },
 	{ BT_ATT_OP_READ_MULT_REQ,		BT_ATT_OP_READ_MULT_RSP },
+	{ BT_ATT_OP_READ_MULT_VL_REQ,		BT_ATT_OP_READ_MULT_VL_RSP },
 	{ BT_ATT_OP_READ_BY_GRP_TYPE_REQ,	BT_ATT_OP_READ_BY_GRP_TYPE_RSP },
 	{ BT_ATT_OP_WRITE_REQ,			BT_ATT_OP_WRITE_RSP },
 	{ BT_ATT_OP_PREP_WRITE_REQ,		BT_ATT_OP_PREP_WRITE_RSP },
-- 
2.56.0

