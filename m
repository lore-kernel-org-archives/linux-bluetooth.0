Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181632BCF4C
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501809; cv=none; b=a/vhjIxJonsYvVItRSoAmDBZCzLe+ammsDquQRpvIbwSq173kOg0ybPppLKhxqazkParr4vapkEjdcUQVZV+nal8Q5VYeCeGDBLZx8yYaBH8t7xBkUFMP6BzX1XN7xBDNheiD/CevpJ9M1cUpg9zGoJaqfVAWGOyZhRDZ07LHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501809; c=relaxed/simple;
	bh=6NI3QwbjJNrqY1ljR2xSpQi3wYpJcnR7VxHXvPXCKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQREmKEFbeTqqxZYzagjpgDu6lh8R6SeY5FWAfVJRyofOtrePzd6vayokTMdV9Z3FKe13bCeXMdta6P4t3Ph+RmP+KlOqTadHLE/7M1IFW//vBu9B6IS53cZUwtuIZvhZFrcWejC0sF+n4rCwo5p1zvPuKDf219hYa+mRNcTuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVolmzMc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVolmzMc"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cace91f112so29132135ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787501807; x=1788106607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zluDwY8DjO8aGSzzRPO06mPMeANVP+JbMeA9IAgqyYs=;
        b=bVolmzMc5JgEPY/eatOFXXKwshBC8CreEWN0enC+qRlcNe6djieOPvRojHvT0WO1NH
         xa8+i917jkshi3EFrMyA5AUQdDL9xEudfsCYINU00OZeqWAv7LsY+AgOBkVXSC/2C3Wk
         3IeLM6D4LVpvLqCW7cN6WvCiJz1+HM8CMQUzqc82FIwX+st9d2STqmJq0yzCICVm94v2
         IyvCVhE2CByejewvokB1F9XejcUJBUSP8m0DdKlXV/CuSbGT+DanvyLRQe1+A6roVPD6
         pHrq+5VAS8OQWxaVj+n3NEEQS8H0Zwj5Swv4o8yoEG3FUIe7zVwZItpy8AQ9g9SPDAlR
         A5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501807; x=1788106607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zluDwY8DjO8aGSzzRPO06mPMeANVP+JbMeA9IAgqyYs=;
        b=VAXD1n/347n9nCwfNE//05TUEbwzcgP8Aq6GUQKWf29QiB91KjiJJSwkp+6eK9ZaHi
         Zs4ElqymoWHdF733O3Efn5cJSz0ajdZKWJg3uyd7o+amNWScueNp4EdCy5HqO8VAKMQ6
         bIsRjEvaJDuBApq7Iit8+e1Ri3JmQinhD5IwwssYMM9MeJw4EVfmBvpR8VZlRo4jpueh
         FVWlw2q3PZzbOk0Jr2eMU13YgMxUtE9gx+z6bnbedPedw3DWS973R5S7scZmRkfpNTBc
         lSrLFJ/tGg5K9wWCIxLjmAZm5TPQGr4YxoKaPFJgULNfwnIyLOK+dDHyxNZ4qqUax44t
         BF4w==
X-Gm-Message-State: AFuF++m58cUqaPBtTuPedYwv7jR1xR7ZmAYsDinDljUTZq2SEsw/8e8X
	ctm/TCfa5GVz6rZa4ihyoY9E9WhXLWuLfAKYu+fTOc13c96EYBw9uPrT0mcerQ==
X-Gm-Gg: AR+sD12FZ07pYa7sYd5Yvhg1lJtYGF0rfXD/aO8LpY1xm9gFOxAuUleems1DwgbXNNQ
	KuZ9pVap5yAQ+Tw3bU32rm/myxJVywzdrndYfskkHFaTFVs3mMntV2C1doZAv6uOdkXDYTI5tTO
	MDEGuEC+or6dbfvbnyJehzliogiRuD7H4F/+bQS7sNXtcF5c6eArJpEbU7mLzZYdk9gvkNZldAZ
	zrECz4bjJOfYGdXKyo+rz/ab86phMfgRTqoShUnueHLLBrC/F4jzqNMuFgsNFYUIsz5D3RsyS8C
	nQqaGc2cq83i3uC75K1d3A0iCRaF1L0dDC3ED/iwk03GeFkNtIrke3HHuAOonKnLM0B9nmtTV1m
	ES6XZwIhD+fv23Pqm5VQx7ZI18y1aoEbklN2a2l3TBDyKvDujO3I7iCImGM1tc1FxVlCJjIsZ16
	1OoG68b6HS5M4Myz4b5UanzkDEWay5xk7TS1qMKWzy5S3tq/eJQss9Dzv3Ck0u47l/qVrO6k/u0
	3w9Agy1ogs9A5DisyllbdGcFTPeGRFbFxVkW+2wRkImFiqmP6KK2qn1Tr7tJW/zu9TRapoE4SZm
	u+utGfhPeTZSDw+rdljSA5C+kV0g0GAmhmdGTYFc018rwUNLJ3YTmgBdOnV7VFTrL/F/yd/3zHi
	bhW8EhjLGFJmR8Nrv3uFGbzK7WteNlBQpaXPKtIMRgGyXBJk=
X-Received: by 2002:a17:903:2ec8:b0:2ca:e62c:9e96 with SMTP id d9443c01a7336-2d670b9ba58mr230601265ad.5.1787501807181;
        Sun, 23 Aug 2026 09:16:47 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d33dcsm22288251eec.18.2026.08.23.09.16.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 09:16:46 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_codec: validate vendor codec count length
Date: Sun, 23 Aug 2026 22:01:38 +0545
Message-ID: <20260823161638.32348-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Read Local Supported Codecs parsers consume the variable-sized
standard codec array before parsing the vendor codec count.  Although the
initial reply-size check includes a vendor count byte in the fixed layout,
it does not guarantee that the byte remains after the standard codec array.

If a controller reply ends immediately after that array, calculating the
vendor codec array size reads vnd_codecs->num beyond the skb data.  Require
the vendor codec header to be present before using its count in both
command variants.

Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cache details")
Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Codecs V2")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 net/bluetooth/hci_codec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 5bc5003c387c..99394a3348c7 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -165,6 +165,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 		 + sizeof(std_codecs->num));
 
 	vnd_codecs = (void *)skb->data;
+	if (skb->len < sizeof(*vnd_codecs))
+		goto error;
 
 	/* validate vendor codecs length before accessing */
 	if (skb->len <
@@ -233,6 +235,8 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 		 + sizeof(std_codecs->num));
 
 	vnd_codecs = (void *)skb->data;
+	if (skb->len < sizeof(*vnd_codecs))
+		goto error;
 
 	/* check for payload data length before accessing */
 	if (skb->len <
-- 
2.50.1
