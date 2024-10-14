Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB8130E4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923476; cv=none; b=qO5nAnE6zSOrIjY7/2byDgnoXhJxB5FFFpAe3IpYRKQ1DOVRRKnTwt08RnfMGRuo/N1GhULGBtNVXsnYaLJKWIMyjopdYX5yxhnZGwCYk967W6oLMa1byCfqpP46MKW4NbJsNdsAHws0wRMSBEOptcSJdEmxP1EHidYNAhu9c0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923476; c=relaxed/simple;
	bh=lU1JfSBV4mmemXfprGgYgMaB28Eo3OlVOGTNl7s4RWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiV5XP4UIwoNNECKuOHrZpPLHjZSviegqbL3JOcNIho05pJgQI5RwlYvHpOb1eBcvJzim9m3USloz5eEtcPaU+PtSK9dwjjrsr6R/jDxKOTntbDE9ma4LI3mDv66F05WdanR4dEASyttz7JM7HYUccBMdXeH6EiiflBGOEhignw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=gXXNEYBq; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="gXXNEYBq"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso1756091b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728923473; x=1729528273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S17NyVE9iarfIVpW26/l7DKy/HI2aRH4h+mkGmLpdiw=;
        b=gXXNEYBqdngiyNhIjwDFGhEGZQbOMPGL5mFNyC01MEA8NRphhHgiRpST4QjYcd+XBX
         ykU8x3U1+LxccIBdrMf7VOPEU9xOL8N/1qRLQqI+GrsBq8GEr1zwPYG/cT0MErciU+z9
         mTxhxSd6Bw/2O+ZF2jRJLcml+chKOjv434aY+g8P2RhGzBJqkG2Nekg2tnxpDkBRwXHu
         w3T04CdqJMrnDIY5EjpK5jPjcXAdzdUmAl4/fwzvGNoX0tytRa/D6crzaJN2pAJq8y+T
         zBdollfJygvOogdfmHSoWty7/QpXHy07jmdAjvQv0J/RoUQymjPJ+sWbHYK6DmfrhG+F
         1Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728923473; x=1729528273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S17NyVE9iarfIVpW26/l7DKy/HI2aRH4h+mkGmLpdiw=;
        b=l8EOucv6plLCrD0mDd9YcE95BMGrUt5c1V1nOg2j6wnQn5j4uORGYRub6UTTulXFAZ
         lM+nE0b2I3+oJGRa4pAbYdDDuGWrK1W4/bdRzOpvWsbLu4cuKPlvV64hwjeQup04raMF
         56X4ADGa19RJCqRBbWgQ7QFp0ce3EC9z27znIqDI0iPTqcDJxOUm8MwQRwzPiMSZir4e
         u7Erc8kumhK9cUhYSiBTRtrpEOTiNaMfmBmE/4JEUa82OvExHxanwf2KuSLWXajgH07h
         4uOI2wfS2k98+A3c4AzwJKU7RM/Gv7xeHxaJ6jGJRTzy10Yi3hTBONtQnqpD/vy8v+CR
         ZipQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhUAVJuVbV/fkR38mTo5R2p7EDElXqflSOgTxc9aFvxiHt3znkiRONFf4D5/jAnc1GzuqtneqLqIz50OYC44o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfUf6rpTZMBNJHJiOzyFMETlwdxHfVc+2lY4h6TjAzrouHhKIa
	5Tf3j7iCJAqSL7YR9Tv2xHdMeheyhvURPHMPXj+PvuWSWcNa550Cn1iSoDyTglA=
X-Google-Smtp-Source: AGHT+IFwS5hx/tE/8EBpuYASWc6rw3yXjwZYhoVhf49e9ANduebaPdv709YUK3kshOuBgHU5lvtJWg==
X-Received: by 2002:a05:6a20:b914:b0:1d8:d296:1fe6 with SMTP id adf61e73a8af0-1d8d2962007mr7729703637.8.1728923471377;
        Mon, 14 Oct 2024 09:31:11 -0700 (PDT)
Received: from localhost.localdomain ([185.205.247.248])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e719164d8sm598119b3a.210.2024.10.14.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:31:10 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] Bluetooth: btintel_pcie: Remove structually deadcode
Date: Mon, 14 Oct 2024 10:30:00 -0600
Message-ID: <20241014163001.4537-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch case statement has a default branch. Thus, the return
statement at the end of the function can never be reached.
Fixing it by removing the return statement at the end of the
function.

This issue was reported by Coverity Scan.
https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709

Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/bluetooth/btintel_pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e4ae8c898dfd..660496e55276 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 	default:
 		return "unknown";
 	}
-	return "null";
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
-- 
2.43.0

