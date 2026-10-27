Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117338;
	b=BpqPca4iOOSoPdIL5OBfp4IkMb+OfN5PDUi7oFclkPNhV1+xxJPqB+vPLf4HC8xc28gU
	 Wz8QcXfDnwrMPGBNjyXN4qLqQGeZNCRvggy2V4+Rv4e3xw2CabubZPHqv9hGdA8tGJCjp
	 qKI9zOG0/5IiZGHr2lyVs0sSHEV2Tonx78tiQdnIwVXb4VfBWw8FKGL/GqBWs85uqDmVI
	 aGe2iTASOskcqslKnq6+aesk/82CdICVRWHizQ+bjpFjx92HwoF7MfrL/XsdT3k7XlIs/
	 ECmreNG3FAQkvisiGR+S2/y01fLj2quPIif1CXqGh1hFeoSaJjDMhbnlgMhQ06n2ecg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NdusRfWTFFTwsuYVzb+hQLNhnXEpOz5woB64icH5ONI=;
	b=vAVz9z9M+7t6R0k665VYsDzyz9gvGKPQFDv2RK9pKDGhbVA1xFHiblDtZ8LKNI5UGN5l
	 3ON3+HvnDhYioohf9DLDT0FmCWS8FUnyLNIT5N5F4xSQhZEEnKc43wuA9gZ7hr4NRheIg
	 u7jOGT4cZulfPaZh0bzHhfunyqyArDKslqXKsPIrj30XSfchIpfWjZO6R+uHwQ4Gnke51
	 Ic1vtyCyKV8HWQ3PzSAMDNWD0B3lHjBqkcqMHyJU0bR8vrDaKjUYcsxMgx+G7kn2tY/l0
	 MIGQPlQmF414e7Q9PUlV6uOSv/e5XftYPezDqKhuO8QYvUXY51sHKDRjcHOfAEn9/Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=mvPFugqe;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32822606A329
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32822606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=mvPFugqe
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso36484eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793117337; x=1793722137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdusRfWTFFTwsuYVzb+hQLNhnXEpOz5woB64icH5ONI=;
        b=mvPFugqeNEcwl/8/DPzhRmoPinmHkuWfwi3oL/US8hn/92pUATeKFajUsM+oh4ON1O
         Bs+KL+luzcCfUXMGYBuY9+4MGA5k4zmwLuF1QXsMcTbQNDZHMl3hZcDM9gaKe80IHO9D
         XNIK71dBVRDHKBjmVqwRNENHE2rH6ARJT40Eenwg38PdQJ4XE3UFcUryPq4+Zm3gGe85
         gBhZjbNcNCEIKRGMTIzeDlrVOCGoej/GAtusyNfOGXOyy+68oIk1ciHhUUdOcRgphpb5
         OuC2bt2zOZZ7XSoo+pI7tHknU0pTYC/P1tMuCiA/36mTeHtkb4QAS/rJZtUZlxfKMHYC
         H2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117337; x=1793722137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdusRfWTFFTwsuYVzb+hQLNhnXEpOz5woB64icH5ONI=;
        b=mfRq8WTTL7Mg4f5uZyRt1HGpJt+g+8GdnxbfsCF9AeMzuZz6PYAMtZnAGoMO+nu1FN
         Nk6v4/ULGw22+r00pBpYrzVYIB/b7XMCDhLDuiPfCVHPl4YceRuhTWxDFpldufS/590W
         6R3+IlTy8O7o4YOizQevXUPkMGzMlQm3oVME6Px5ibSN4VZoQEWCOTjyRKrqR1+sQQcE
         6hstvfHjJj41E9LiKgfDawHanDwNBKdShsUKMls0TL09EH+vKbqFjnFUoH55aVOazI1o
         EKKzLfg0xgbmUFo+HUpEzATEyrWwPTK/gUKdwltuVfmfdJnukU0HtwyV3aCHPA1UNARr
         1TZw==
X-Gm-Message-State: AFq9FYKgy6K2JJ9Ptmq9qor99A/wAo6OK7Bd8FfhN+H8sgm7QSSi/Vcu
	8SevRf+2+yHAi7AjuAhHctsADKhuhg9sKOYMTecA1Sz+RzWN/2GydkvrZYzh5BoeMW3UVi099OM
	Kh58Q6QCL6Q==
X-Gm-Gg: AYBFou0NXvif/3xtoy0ODG2lfoaVL8mbHopkDOWEi/1M4L0K3Sh+rdj46ZXIBSSFUdr
	l9XRQLIr4MTmO4UluJfh0MwEoGEUgJTTJ/9dZovxhgfymqpz+y94sHcgWfwaQI8E/mkSICmIacF
	s3RLU/kzLLQjI+txt5oC3sIfqnjMnJCa5c+huSLPYr7vZ4fZsEBPryEClNz68LIM/nlYLnaLRjw
	mG6FY/1Z2Asz8E9d8Sje/bEobfg3D6R2hriBcm2d38Rka/ZCxfE0NWcJChKIdSwUGSGEaoQz9S2
	Om/yfRA3PyLVKNyK6Ii4jVOZDICdEkIqJvS9hMGQ9hUr3KvJX0nRv33t35I6gvepYRCIc9+h8J7
	YqygAwIsbc9F2FTrV4ASyHjnbmtl6miWt8I7boEhmRyBS0x0Ve1aWWs8se0DQj8Ilbtj/lO7IjT
	nXKsi3G0ZBlBU4Ez74IhW7aiBYvIL0wNZ+LKQ2xWV6qz62Bnfvc4LsZs6yhn8yQBqbZcP1yKp+7
	f1WG0avWkfhpJmNBrzpbRX7nbmsCtS7OSWPTo2t50tAdYOFInvXozfZwrS+KxUnCJj5J5rwM68f
	iy+aEKiOhu9Io2r8tclQJZVKOT1nnnlbr7mnEjwZfF2/FON83DhBj30BSZx7e6KVba5ywW6Dee6
	rndMWEVScFup/f3rZfsPd/CfQTRJyldxyZrMRzhVpKNdRH6LKsKurxZ5692FMjjfcZZw8Iv8=
X-Received: by 2002:a05:7300:c397:b0:36a:1089:9836 with SMTP id 5a478bee46e88-36a108999b1mr3815440eec.15.1793117336763;
        Tue, 27 Oct 2026 09:08:56 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a026e04a0sm16063356eec.1.2026.10.27.09.08.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:08:56 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH] adapter: Fix Discovering staying true after a rejected stop
Date: Tue, 27 Oct 2026 09:08:52 -0700
Message-ID: <20261027160852.54689-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

The kernel rejects Stop Discovery when no discovery is active by the
time it processes the command, because the discovery ended or another
mgmt client stopped it just before. stop_discovery_complete() then
removes the client but keeps the discovery state, so Discovering stays
true with no client left, and the next StartDiscovery with the same
filter returns without starting a discovery. The client that called
StopDiscovery also gets an InProgress error, and "No discovery started"
if it tries again.

Treat MGMT_STATUS_REJECTED as the discovery being stopped, as
stop_passive_scanning_complete() already does.

Closes: https://github.com/bluez/bluez/issues/2547
Link: https://github.com/bluez/bluez/issues/807
Fixes: c1226f79ec97 ("adapter: Fix not checking status of stop discovery command")
Assisted-by: Claude:claude-opus-5.5
---
Reproduced with a functional test that holds the emulated controller
while a second mgmt client stops the discovery, so the kernel rejects
the Stop Discovery bluetoothd sends for StopDiscovery: on master the
call fails with InProgress and Discovering stays true (3 of 3 runs);
with this patch it succeeds and Discovering goes false (5 of 5). I can
send the test as well if you want it.

 src/adapter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1561ea3bf..4d753028a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2194,6 +2194,14 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 
 	DBG("status 0x%02x", status);
 
+	/*
+	 * MGMT_STATUS_REJECTED is returned from kernel when no discovery is
+	 * active, e.g. because it ended or another mgmt client stopped it
+	 * just before this command, so treat it as stopped as well.
+	 */
+	if (status == MGMT_STATUS_REJECTED)
+		status = MGMT_STATUS_SUCCESS;
+
 	client = discovery_complete(adapter, status);
 	if (client)
 		discovery_remove(client);

base-commit: b0bf49270d445da0852851f393cd67a0a1e5f05e
-- 
2.54.0 (Apple Git-157)

