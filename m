Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239113;
	b=CK+Ot7p++7Rje2ROTXWuQOs83asN5B1E88ng8Z5YVSJlGTOCsTJDO989qfi65lcL0kcf
	 +UiHTIXD+13ytrHLd26/oQ8tKG9i38iKboaEXsdQCGGyyOhoTbCQoPD/K1lziIqlcp8s+
	 mCqm5zgXQdkdFWqHLkAzG/QYD2BHyaI2uof92AJCrwGohKhLMSJl98PxnfgvtY/DMepGL
	 63olqbXkW4tcu8Q2btO0qFvcENpQaK9dsolCDI9nSTxZL/wO+ftVxe/oeJ/0S7AOL7i+Y
	 sI4En6yy53ei51CK9Xi1AWsiHKBuiTD3Pte7OKUAou1/Obn+HNJJzuIdRHiMtCXzCSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iULapQXTwEel+FAAksELwpu0ANc2gswG04m3pMpAn38=;
	b=rYr/zxMAppHa+GERrwI/kZxn2FeBHkY2ModkwjFEQAgyFxM4Sk0ZfmaXa3yiau9aEn29
	 7VORRBGIOv6wtOPag4vnqGraJ0tmqiNm/9E8CJpX6MwDLetUrZjEs/9LLdEBfNMHsKShV
	 hzbpJrUnwXd8uGjiecnJGzs0RZnvf2Ns0VUc02QNQVEI6lU+QwD80Fel8d6VwNrNLDMEX
	 CnWn2DSVgQ3000Cf4t2SiA22Ja7KyfwXhd5VXiR3mWah9YAftXUH0Q5EHe72mDdIbOzD9
	 kf3fPSyMajYKc5IrMocdOs8D0ThFkQtshcOXw43GjnxXpUf9IGEH1JWaNlLdbMNYNag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oVsM/vMr";
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD4606EE87
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CDD4606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oVsM/vMr
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2c8141dc6so536063137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239112; x=1794843912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iULapQXTwEel+FAAksELwpu0ANc2gswG04m3pMpAn38=;
        b=oVsM/vMrXSwNyRgLoInNk1H7L0xPl1jeLV4pO1LQcOMYm9aJ1ZIFDrPd8DeUKpvHUC
         D3nEQfWtOuiw2XYA/kxm8nItLtLKURHfLVScqrkPgciMMcYJWb/ihIrUVgZyVVxkumOy
         wTresR0kQcjKCW2yP9uaQ2oNa+jE9O2nQ9+K5GoVZseQrqjTKCuYyCMuQ1RxkImllqHL
         bheNDuELz6zigTuxYjFXeoz39PSfhrT10gAYHVqpUp8jtElQ/Rul7TzWj92ALhi9n0wz
         1uOUsLuOMElXJde1+qllWUaUfpYErkoG6nnnsPJ+m1jcPEveqvTVl1GG60v9WA0PCI3Z
         1/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239112; x=1794843912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iULapQXTwEel+FAAksELwpu0ANc2gswG04m3pMpAn38=;
        b=gFnwd1iz5qMJ/ALg35athHXy5EMPyOGa2vCTYsyg/Ii6aIBX25979TmWHFkxkf2nst
         qhaUVaBWcBBMFNA9TSNLpQMgfko3Jld8Q8g6fxQapgEE2cQyoVJWvbEqTPT0oco8BMOj
         Nyl3SjHwhoxjNTpCHy1U7j1I6WUzUsdv0+gUOSaXYkzRGP4HhTwH+g1tph/lcEYaoOat
         k5eywI0DemMDnoFXYJKaUmDoXYY+7kvnUxcUB2tXwGS3cEaOS8YbJltryrHEgj9hUyhD
         N8c1R+hUTvwiQF/1boMbsOA7OZhIdtrXMC9kmIXLgAdrlfyUynxkXzkRTeKxwz7OoyNF
         vuEw==
X-Gm-Message-State: APuU4Z9mRg2RAmKDbLYV6zM1er2OxG1WcyKR/I8Dd2yFR5P2DYRb421F
	WdMjqsH176bNrvWHbGWB9+db1aBHCjtyeqVPhBrX9IyFV9iBz2jiE7EVFvwjnQ==
X-Gm-Gg: AYBFou0LHjMcN5myuH2eFH9KMUfKC0PDk8e5rFztw0ZgKa0UEY1oBJnHZf/APGZeQ5w
	p139JYIb8HcRP9PjdWE+pxS6xBalk3/zuEbubcNHKyFigJ1oDkH0SnsOYvURNsyW3j2H561jVN2
	2tj07HTDM70gqkz9uzTgQ3CfVjPUbLp0zDWnWSqWrPC04Z9TS2q5+T5ZuPc15QbWQusROyI9+r+
	qA0+wyCYEbW5y7ToZa5OA9P0SJS/bKpdTlbrVB+4sOk7fZ8gGDIZkau9DqCFKG+GpbkqWoGeDUz
	mqMBxgaKEiADsiXORx8G0ZPzKbu6T551KWzytYZ7AeRxxZrJzgnc93dyNqRGy4upzAuWZ902kIx
	8pDDyh5DD/PKuqs+wxjSUgoWQUQIcS/QRFgW5eay1pW9lWDJYFOPLtlFb1cWH4SmbLEzhgdtUM+
	6y7KAOz8StdSUJXFF0EBWis3Z3WeyCt2uO5NtmpXFVKsX8j9kW59I7NzvEMaanXs7zyio+8ZjCC
	OwdDPvZmRFnGf1cFoI/0FnTZuqg+QlfXT5PW6ZqZcGVYOaOiojpdgPmB0v1Ack+cAaiyfC1+Thl
	ONhaLhQmSVs2Bh+52vEL9NEpqg30yTId5Gg5oixwXV2w91UjXWYl9UxuJ9QvQMDuftSoQipjHd2
	K2K8X8ClXyVyaeLCWmokiVQPEL/9o1fhkzXvBxCSPO/9J/hmCpuRzGDCCIe94ta8dgwl7nbFVQd
	TEA2HZSNJ9o41IhVmueJ4YCv0i
X-Received: by 2002:a05:6102:2922:b0:7cc:2674:b78c with SMTP id ada2fe7eead31-7d2daf1bce7mr1271248137.7.1794239112448;
        Mon, 09 Nov 2026 07:45:12 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/10] shared/att: Fix reference leak on signature verification failure
Date: Mon,  9 Nov 2026 10:45:00 -0500
Message-ID: <20261109154501.1362649-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109154501.1362649-1-luiz.dentz@gmail.com>
References: <20261109154501.1362649-1-luiz.dentz@gmail.com>
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

handle_notify takes a reference on the bt_att but returned without
dropping it when the signature of a Signed Write Command could not be
verified, so the bt_att was never freed.

Fixes: 051a525c ("shared/att.c: Add server signing key support")
Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/att.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 4fa69e597556..d1930f6af1d1 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1044,8 +1044,10 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
 			continue;
 
 		if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
-			if (!handle_signed(att, pdu, pdu_len))
+			if (!handle_signed(att, pdu, pdu_len)) {
+				bt_att_unref(att);
 				return;
+			}
 			pdu_len -= BT_ATT_SIGNATURE_LEN;
 		}
 
-- 
2.56.0

