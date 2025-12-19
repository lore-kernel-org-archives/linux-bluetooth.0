Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB86529ACFC
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131601; cv=none; b=WTT9oi9+j3JSVxDd5GUGmaSiANtyF/JjnRy4pfAElcS3MfmCkTt+xHSS4qoQXOTCpgna7NmVcDT4NVUaDtmZjVvnBj2YMdVlPHmutK4EVThRefvqC5TBdeH0u/r5prTCTphZQAEfbg4d2CqRjpnGSt76pVov2/5FstKAMEeRDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131601; c=relaxed/simple;
	bh=iC5XqnKV4YdUhoQEaIWYUbLKsLB8pGHPBwX6TTJzlFg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+SDuXlBl0j+KIZM30g1JB+Vilt4dMTGSr6+l9lZGBS31H77OLf9zZxAgl8ulBTTfYj9pijlY6olxxMnAKlYEntlvZr8ewTX7XG4yE9B4rgZVZSggwiZCQ1GxTrJ6R4ZHgV1DjwrnywroOTy4KX64t+4rdm83RJ21nJs+Yiz7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Is+ae3CL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JzmLaR/g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Is+ae3CL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JzmLaR/g"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4c6Yd4101116
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3nBHAN7aIpb
	BdInvNepSlQ5APBaLIvuR1OBr8nLBoRY=; b=Is+ae3CLewlxorsiV8deoZnPy8C
	D7Y18FAz0GYe3mLAa71MNxh/lN/W3NaYg9V7A7T9qo1f5HOmVhcPvFmntmBuhPnn
	WpktEHDs1pS8+ddAls1YHfzr/xdTMxRYnq1L2Vj855mmubacZlQVxrW6nfGF6hL0
	eW3uz9jISKseEG+pGiio31vpA5yZm2orc7zu63NKTZEql1C5v+8Y50kV+MJA8lST
	AD3qomaAM8iRRS2kXYAn2KL+Q7kbTNgi8CMRmm6vRz4yds3cRvKYQ1itXQ2mfJ/7
	Mcl+TtFEeBQUqyYynWlOpOAbV9ExwL9QkB2BkDBJRYpHHYwfpVUczVYh9rA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c1u6h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:06:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed74ab4172so31488471cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 00:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766131598; x=1766736398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nBHAN7aIpbBdInvNepSlQ5APBaLIvuR1OBr8nLBoRY=;
        b=JzmLaR/gX0rBLwHWLu+5849Eb/EhdnZQYfqXo9AVQZMAinQrZWKTdT9VeOfxMV0CR1
         ajCEfL4ucQ+RtbEks9l1LiQ2LAzPZ15DhV6nju/UMMZz7INW9dSqo6EPzCMlcRoMVYcE
         Y/mzUXumaHD7cBuCI+wwsVCao0yr8F26u5HXVJrTBfwhpQmC3s6PV44h0MgME2CGu1GL
         AANKAU8lpVwJbjXVILjMYxp593f+4htT8CLS/5vdAUu8Dc6MaPV8wo55C5aE01W68waz
         KhUUZ+Wr6X+GWa3eq1V3oCI0elW6UKSyk3ufJWrBeNBwqDKBnPEtmfqkygSbukrsMC+i
         Tfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131598; x=1766736398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3nBHAN7aIpbBdInvNepSlQ5APBaLIvuR1OBr8nLBoRY=;
        b=ZIO4721Hzsq58z0DFUOWSMBopqUF75/v41Aqg1q1C9HvR+g1Sor7/ar2EFPWMegU7i
         eNidTA/C76070mu5FbPJ+J78ufo/tzwetFIgxXIsFJhdJGD7US4SA+5iOVQ/PdeKOwKc
         2Ky++m5dJxwlw41BcKSE+dPikWKUYPPHt4/Rur75Oi0Aa8L+Lnz4RWe8BxjIL7WMCKZS
         PfvYYde/m5L53AZFCweMBHgfbANFB3aK6tx1r33tK6OZL9poPuXfutUH9iEkG8djqchQ
         4wWzLs2wITMpaK4skxJSQUBwY6pmcLisRq8VxVHGxD9dRh9YwryjoEwzxppsUjYptsux
         qXsQ==
X-Gm-Message-State: AOJu0YyWbZ1R2x8qrOleaaleYpX0KUeZfviW0RlTZRvIvy0jsCh4svPI
	+HpvPOpyN8/qB8kVWz6aTLhykMaJ1Er5JE/2XJUPDFLAGw3Op1BxhIwuKSaNSwWsUF2oTVpMIx3
	3H4G3MEbYmp1BJV6OTGVJwheBlliqjvD+dBb9fZEGcjM9vXAC+5OfWiUo+eDxZEx2c8aTnJklsm
	VbMSw=
X-Gm-Gg: AY/fxX5Slbvzjj8P+3gTluhHjRz3rBryBmosivtlJ+8yWFe2IF5EndCSAJ20+yEEbwp
	LVyoGCrve5esd88yXbWc1md9U7oafmtIksclWWNyzlNCYnC67kmnmEgWwmspTyF8TsPJUjf/uoB
	NA8ls9lcjnf6mVef/ky0FZJsv5Q7emqrluevxq4s7UeSD/5gQe0m/o5xiDyf7rL6WNjoZHC2pmo
	d5vpV3+cp+VpfpHVGYaYIcCJcZSxjnLTUMulJjXKL4JkkZ6BqpzSciQwPn9U6wPrFUdAyw5txDw
	6pGcLVzpnve/ggjHNl5MyYihEvkNI59PuTKeTXPf9P+Zcb33wfjB/Gj1S9LJevA6YpH09YuhRjU
	u4orK+LT4pVqzVvYSVn2a3XeHbWehDtZhXp3eOg0Srr8zKnzsCfoRL1oRaHI=
X-Received: by 2002:ac8:6edd:0:b0:4ee:4a3a:bd11 with SMTP id d75a77b69052e-4f4abdb8679mr21808051cf.64.1766131597566;
        Fri, 19 Dec 2025 00:06:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECNCLZVCywKrHSfbAb4mZIdtkaZFNKI7/GPTcu5Vi07uh6aLT1h1aU+jZ11s3yZI3DuPm40A==
X-Received: by 2002:ac8:6edd:0:b0:4ee:4a3a:bd11 with SMTP id d75a77b69052e-4f4abdb8679mr21807871cf.64.1766131597138;
        Fri, 19 Dec 2025 00:06:37 -0800 (PST)
Received: from rohan.lan (82-128-196-119.bb.dnainternet.fi. [82.128.196.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224de761sm3966051fa.1.2025.12.19.00.06.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:06:36 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] shared/shell: make bt_attach_shell more obvious
Date: Fri, 19 Dec 2025 10:06:33 +0200
Message-ID: <20251219080633.394709-2-dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219080633.394709-1-dmitry.baryshkov@oss.qualcomm.com>
References: <20251219080633.394709-1-dmitry.baryshkov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA2NiBTYWx0ZWRfX1yD07aP+6Cxs
 CdJZafqw6GfKxa4YJdYnapSuO2cMhl54mXaOXmf+eO3vRraNdIVjByadrh7vUHW8t7mAtQIDhv1
 APAXRqDrqNc2BUIxhFw3UwUgj4bTkAw3GOyNSREGdiRI2BT8CfzIgCt0jrHJyeHODlQdKzQD+1h
 YqNKiBqGb1CxZ4sbsUMdfNJn5YcB83y5SroTW515r98s3o834JNB2reTOtP+Ulfi5EmJwEKJ5Ae
 M77TSgsOo/dDT2wyr+PQyF8DOpBSbwhoKMqF5asezHgMEDoRbthZrakCb5HeP0w7HSQj1FJvKZN
 BwbV/lQ3q4bnzGhHqU81khTpXMY/RFSQMkQJWUMc/RcWMi8aTEu6OMfJQ31y7o83kQBPSWTQSFg
 /prVXEv9OdZTmFZvhcTyeKxpWsFPsxX14EQRKaUtIp2t43w08nPj4tQYwBpawSZxGauaqLwauKX
 eMAI1H1iEtIPlgR4e8A==
X-Authority-Analysis: v=2.4 cv=dOmrWeZb c=1 sm=1 tr=0 ts=6945078f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=UP4AmmvVc3sGQHJQO2VA4Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zcICvhum3BeOze6ZWG4A:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: uat5SlMTw50iJsnpv9PRCB9FyxfslJoR
X-Proofpoint-GUID: uat5SlMTw50iJsnpv9PRCB9FyxfslJoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190066

There are only two cases, interactive and non-interactive. Make that
more obvious by using if-else rather than two if-checks.
---
 src/shared/shell.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index aff5652e40fc..15f21efef61a 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1654,9 +1654,15 @@ bool bt_shell_attach(int fd)
 
 		io_set_read_handler(input->io, input_read, input, NULL);
 		io_set_disconnect_handler(input->io, input_hup, input, NULL);
-	}
 
-	if (data.mode == MODE_NON_INTERACTIVE) {
+		if (data.init_fd >= 0) {
+			int fd = data.init_fd;
+
+			data.init_fd = -1;
+			if (!bt_shell_attach(fd))
+				return false;
+		}
+	} else {
 		if (shell_exec(data.argc, data.argv) < 0) {
 			bt_shell_noninteractive_quit(EXIT_FAILURE);
 			return true;
@@ -1665,12 +1671,6 @@ bool bt_shell_attach(int fd)
 		if (data.timeout)
 			timeout_add(data.timeout * 1000, shell_quit, NULL,
 								NULL);
-	} else if (data.init_fd >= 0) {
-		int fd = data.init_fd;
-
-		data.init_fd = -1;
-		if (!bt_shell_attach(fd))
-			return false;
 	}
 
 	return true;
-- 
2.51.0

