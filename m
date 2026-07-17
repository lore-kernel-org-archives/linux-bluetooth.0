Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B437C910
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295333; cv=none; b=GMiSjkVNxUYqFp4FdFy2vGWRjt/GPyUe2mSaFvDmI0h28LFIafAGtxvCsBrPFl95mSoUZHEo0Ym7l2LOuL/bX9iZASEIeAPzSLEWXDPBlVJE8OnN8gO/APFS1ZnZjklcZC1lDvTg4GrMxdgqOBPqw5VTiEs9/OxUOWXkzMIq7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295333; c=relaxed/simple;
	bh=cxFFmFaxg+5YSOAqKtyh8F/pzmRf6eKOwgbndZGS7Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hXZQsA9CM4FgLvMwbhd9Jv20/s/0TbirttoT6O6C03l795mgDsi2da1bTjT5TXouWIsDFTh0uhsPLRfVK53RIciZhP443uQ7aWgp/I9yzKJaFjGPzbF6uKqZZ7FSuPkFe7E7atfSSxZY4OvG7b/5yz6tLrN5vfkxWLbN5pxqi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VeA0F+Rc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e02ViHd4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VeA0F+Rc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e02ViHd4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCT63W1619190
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9J1OFC6N1f4
	yk6laVsNdNLriOD5bDWXNIE7FJLHmlJ4=; b=VeA0F+RcMQ80B90ChmPPDATJriQ
	XNs1a0zuevvjHO6vHxs7n87vJzc4jtLy29Lt+6qvQQUEP7UjR4sSSO9VKA2Ipf+S
	HFK+7HZpeMmGafxUJVR4BHA3+UVGyXMv1PRuthj9WqE+LJcN94Jnd74fc4s/Qstd
	eKqCOVOLw2Sl4a3p2uNXgHur773qN0S4jV4KFAaVdMJ3bDflDbfYNEG43hzfJ1mt
	pb7bzpZlt7KuhrUK6FV7NLevll+NjI4p1ydLp2j4YK2ew1kn+2/c50BnR4efwHB4
	lOMYQXu9Lh7PTyCMyZDRCwsrIen+V+gXA6YLLg1fbz7+wtAoekSP4HqcD4w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffag9fkf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso3643079a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784295331; x=1784900131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9J1OFC6N1f4yk6laVsNdNLriOD5bDWXNIE7FJLHmlJ4=;
        b=e02ViHd4KBSiayqS0Xlf1NSJ+2UAGGytCOKigu0GUPFVpzxHsoiMJpJVFSGP2LccjP
         dnF5UuUufH83inOgFDEGahoPNt5UOnXNtZ2crYyGmTvD8SCofGtKesrkXsuABaCW6drZ
         yhxsChJMZT+ESLMfPL6+MowLtA6/c0fNKKJLvl5r7MrugtN6iAeJ7nvyWqbD8RJRKOyP
         op7QsE8J5/vIvQDOhN9h4z8yA274+PZC3GS2GtLd+orxgtdQljZ619BF3zbdtXi691vg
         lLYGiQDHVRoP+U6LcyMsiFD/BUlmuPqRPYbADkuw8ZcIXetzMD22ywHvsaK7vhkvL45t
         XScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295331; x=1784900131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9J1OFC6N1f4yk6laVsNdNLriOD5bDWXNIE7FJLHmlJ4=;
        b=SDQ18XfV9IWbNCKC/fpc3DclQOEVn49ie3g3wDkmtIu6gxJeE878i/oiutzG0n8fQt
         9UY1dbVGHb4e3oALuLF/0SbXpYe4wsLpxuv16HcXVAaNJjs2pLakEuW1a4L/bux6gxiW
         Ubum2TTdknM2pMP56BspL+cyKeEdGW7d0y+X32oNyzOLXqQwTj2VXFZ/Buie6zYs4NzX
         9Hc2au3v9yi0JFRh30v49xTGnNmiixJIOivE2QF1lqAkxefBKK0thv+ZKX2amlnITuzA
         7tvxAN5UHmTdNfXJLcKuOmQyDEjKYax/KzOKFy6R4WRoiHq6b5oY8416grmGzBegmiYJ
         EkdA==
X-Gm-Message-State: AOJu0Yw4OoVKoEBAEzSvyIPCTCjB7EMokSXaRm6r+kf+z15O6VitVAk5
	ZGc6eka3/3wo1cSWab8tfpoK/rs/Z38Rex31p6rXHLwnybvlVA2OIo9MsoxfX3jbWDrJ1hXIKgX
	cRP3QSk0PND2imlHEGGMCHXUXbcweAssZBS1kz72+TJYYQb/25EypJxP2tBT62wEQjcMMNFeK2U
	up/ak=
X-Gm-Gg: AfdE7ck25STmTpJXStUtV9sOCp55GmJUG8J6wV0x+qj6DnsfYfPJUml+6qa/bfEs7uJ
	y8mqi5RiBDqAbvd2LXwTKZbgmIDmgrBy15vhCxmgMru70hH2Kxucfq5g04PUXb10BhiEq0Y+jWI
	K0qqHLiJja92hdmGRUgx9KYM+bjHxXZ1t+rQoJHZTwPT5rDJPTdTttegFblPMhpdTjABkQrIoVl
	JnN1aCCgfKxo/QIupMwgXHGJd23A6fHcg8tKndzHDfKAcT4FaENnrqWawe4hoM8ZYY6cFEcoMRd
	Ff/BS24v6ZPI0Q8LrO7CLdNGlde+Gx3ITwzq+PRjjrJuYapTk916SNGyfvvdMEUuusKXnihquj6
	Gu275bYyCSjdXLn4brfggWxtosq9YkQ==
X-Received: by 2002:a17:90b:2642:b0:381:6466:7160 with SMTP id 98e67ed59e1d1-38e4b56d7b2mr2984385a91.26.1784295331333;
        Fri, 17 Jul 2026 06:35:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2642:b0:381:6466:7160 with SMTP id 98e67ed59e1d1-38e4b56d7b2mr2984340a91.26.1784295330822;
        Fri, 17 Jul 2026 06:35:30 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fe4677sm6648774eec.11.2026.07.17.06.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:35:30 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 4/4] doc: Document create_context in bluetoothctl-cs.rst
Date: Fri, 17 Jul 2026 19:05:03 +0530
Message-Id: <20260717133503.3711396-5-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
References: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfX5yLRG40pc+KH
 wV7aBiJahl9ErHUk2ioEGES8J+AyG1iW/g7YsM+VkU1KCQdsAg6HzI4Lq86yxXXTcuPs5ewx4ac
 BKTo2XrbCyGbfNKGm1Trk4BFowa3lWuxAMi7DY1Ug07wWPMsTxVcDv31RzVZ3xP0l8X2KN22SKh
 JsuuoOMtS0h38dHEKL/nNHNMLrLl3kEB0oNyt5+2cIlOIczkkmSuwzxBXgEwjEmGv15njrLD9ut
 jL+v1id73s2zBh1Rj3w7bUNGVEgGnlnU7G3lUUsyJ+2xYxy7/VbAI1pLUUgDcl5pnwlqX1riXad
 Q+R6w8+nrztnVR9gb6+cHOMwOUi92dmvurp2jF8/PxgjEcG8T6v0O+DExZSqvKKler6RORMePS+
 6z9yCpJeSAN+U1b6WoQ63pQEzHRdKTRngXN10+CtoOBVfmwYxcZQFe+v48Vg8RBM0CW6iFZZpCG
 M7nDKJ+hYGIeJcE+r3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfX8EZ6i/1qFtbZ
 0KzHRMI+3TJsxnBRqg8Epd4Ou77WnxBKf2NYdc69KEX6UzFJbd5JNaGvWW415uLpy2mIr+XDHks
 bDHEf2DuQ6l68KOuOrz5QTep1VSGWN0=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a5a2fa4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=ImA1InN6HFTQjuMtSAEA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 8I7WeAYEa-iQN-PO3y1tMO8SLK3MoG6L
X-Proofpoint-ORIG-GUID: 8I7WeAYEa-iQN-PO3y1tMO8SLK3MoG6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170138

Document the new create_context parameter introduced in client/cs.c.
---
 doc/bluetoothctl-cs.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
index bbc1d8565..e49b4ea08 100644
--- a/doc/bluetoothctl-cs.rst
+++ b/doc/bluetoothctl-cs.rst
@@ -191,6 +191,24 @@ Get/set the CS configuration identifier.
 :Example Set config id to 1:
 	| **> config_id 1**
 
+create_context
+--------------
+
+Get/set where the CS configuration is written when **cs.start** sends
+it to the Controller.
+
+:Usage: **> create_context [0|1]**
+:[0|1]: ``0x00`` write the configuration to the local Controller only;
+        ``0x01`` also write it to the remote Controller using the CS
+        Configuration procedure (optional, shows current if omitted;
+        default ``1``)
+:Example Show current value:
+	| **> create_context**
+:Example Write the configuration to the local Controller only:
+	| **> create_context 0**
+:Example Write the configuration to both local and remote Controllers:
+	| **> create_context 1**
+
 main_mode_type
 --------------
 
-- 

