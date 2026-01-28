Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1C2DECBA
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596701; cv=none; b=UXngHfD0rhLnRr5DpplCkkMjf9+fhR2qhOxPWyGdHqlM5g7e3J2V7tcOmH5OyQ4FnaKZmiqZs2m3hd2c3lgzXmIOW4J5kqiaSk1FRzjblI1o5E24S1H+n/qtNJjuSBcqxTIe7y+vx6akSawdHIs6urcHWOXZ0N1enxVAY2idYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596701; c=relaxed/simple;
	bh=1uuh3YLBTw16MN3MuB2lAfrcxooZAl5mh9+w+JvzR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvlDp8OVf7tSW7+MFV5+11z7bdGSQsKsZBGsj9ek7eMBUIxA7R1gOw27s/7UCQHGX5n97iKQvtbEQdtv/3mnmx8HIlL7cDZqHNVYM51z27qhkd8JaxS+okxO0rRC5w8YxPab17e9vzOcIu0/hmffsvNIJkfIMA0wLaS3UqWBlPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESdpHXxC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESdpHXxC"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885e8c6727so152260166b.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 02:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769596697; x=1770201497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/1aROksdDKYs8GLSUboDO+UoMWj5sjwohDIBrKIOSU=;
        b=ESdpHXxCLTktcNUpOyKtblixsIJnnsRbVnkmsG8AADwNZXkJ0JksOPQw0eayG1E2Eb
         XRR6dU9rbzNNv76bXi2N6k7B3n+sPpFwk38Fju2KXc8WjjFWfJm1OMWn1t2/Gw/Gb2Ve
         wF7qxMHeqQGutUAsRK1ZMcdFP7P0e+dWTp1hd1ED/2TXRLKVBh9qd+zNiVWYgYQ4e/MJ
         /w51UdToa95ME6xuBDm9GTdQid6njxZ/7v7uZQGL9eGnQDB9ZYlQ1zgSVT+bRWvig3Hj
         dhgJ1oJkryLaoeU8vJ43+pzNnWtEefIsQVwiSQz6MjsBJ+aVKqE09dpucu9Kx0KqR9Gl
         QzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596697; x=1770201497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/1aROksdDKYs8GLSUboDO+UoMWj5sjwohDIBrKIOSU=;
        b=XWyQslWgbUXFVM7hYs4rHA3Ra2kf23PWRgsS1V6dymdnVwqOjPCNXS1Xl/00+YKjvl
         Lm/55V9RbU23yel1HXUkuHYt61dwOwj8wFUUdp9FAa3P0r/dbkWRK77yppHy6wSavmIU
         KWBzkbbUpy+hPrbqH/IJMcN9N7dhRkmY6Kj0HeyFK4xAXVJA5lrKhh1bAn9vQo/HcWo0
         eATPpreXCuUR1rHxzigTWun80n20SH93IdqCqV0r4sEoMRKN/63bMrHE1Nb+UkTiAjFv
         PxEf29PKVu4s5z+sKe1y5rrXTEZfTR9MGCAyyoDbYEX+CPfpnaP0h0Aa2QKp+hzlylQq
         pPgA==
X-Gm-Message-State: AOJu0YykRCjEJe9xrK0lsCZoExwi/iH+nrqpqTUalgSWa7NHMJVlNfU0
	OiX1EXe5JMvQ1XgcvJN2JnHKDT+MUKvCfA2uQUhIur4+cLGuDecIxLmezOg4QAaG
X-Gm-Gg: AZuq6aIcSrxzB1OLz3DieMpLJeiSTkrCA5GNEWcR43I1DDZcuAxTb5Jfi1DE6Qce2v2
	tsz5DI9OAnkv0P+B/qfe3Ng6HVEhnc3/XOXqfizqdtxDesPgZTu/8yQgF4Pa9PXyaEzHnOiaZC8
	hKqPs4rXPEX3OZ/UMlgXpsE2NgGYRlxTV1tFgXMCaobHoVrrhaQRoE7HO5gEzMikHOznBt++uuG
	DcRYzMZ/u/2+g18A+fGK9jJC7qyyuyMaJAjHGab6sKAWMb7359Y5tYtEXJ8HIghO+l5b0Ks3KyT
	J7KWS1lfvY90eSw0D1PzFzipNMPQZd9oMm25cS5qc2iloxTMr3rDOt9B5FB5Yc9c4r6x8Wltaka
	BdmvvBTbp3n7EpNWuxLf/QjphMynk9hIRUAgl1t2BF+Ma4Tx9xaICPMTKqUIpQ1IF6kXfKitKxe
	VkFMsGO2HpsjJQRMRt9ocUd4a2jujBntZRJYngwQXG1J+I0imWO5cAAcV1Kkz06b/YNLIpETeUQ
	4JNsCw=
X-Received: by 2002:a17:907:3fa2:b0:b88:4224:815b with SMTP id a640c23a62f3a-b8dac9308a6mr407282266b.3.1769596696362;
        Wed, 28 Jan 2026 02:38:16 -0800 (PST)
Received: from localhost.localdomain (46.205.203.39.nat.ftth.dynamic.t-mobile.pl. [46.205.203.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf183decsm110442066b.40.2026.01.28.02.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:38:15 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] media: Fix G.722 @ 16 kHz codec ID value reported by transport
Date: Wed, 28 Jan 2026 11:38:09 +0100
Message-ID: <20260128103809.2679085-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The G.722 @ 16 kHz codec ID is 0x01, not 0x02. The 0x02 value comes from
the ASHA ReadOnlyProperties GATT characteristic which is a bitmask with
bits corresponding to codec IDs - setting bit 1 gives bitmask value 0x02.
---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index b68290aed..772af1014 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -3752,7 +3752,7 @@ const struct media_endpoint *media_endpoint_get_asha(void)
 	 */
 	static struct media_endpoint asha_endpoint =  {
 		.uuid = ASHA_PROFILE_UUID,
-		.codec = 0x2, /* Currently on G.722 is defined by the spec */
+		.codec = 0x1, /* Currently on G.722 is defined by the spec */
 	};
 
 	return &asha_endpoint;
-- 
2.51.0

