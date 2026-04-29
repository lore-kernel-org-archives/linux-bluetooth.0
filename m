Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA537C93F
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476600; cv=none; b=M6cyRx1UZy4PkPMTl6z1ILALG3IK+/h/GJIOWsnGechqz5GpnKi5fwV+2lfAhG5f+z/x3s60S4a+RSRldJYXNlQ3BixGQAEy0qTemjD47jlIPilIDDqb0trSPgPYo22vuIbAY0ZwCim2wPAY9iFAwTEkgE+Fj4n7f/kQxGCkXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476600; c=relaxed/simple;
	bh=C2MupbCihLMMxdAqiULKdFQISREaqVY6L2PVda6Xn/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmRz2YUJblU/ye4eXBALu8oAk8QE2kng+L0Me05HCg0Tqx3yeugKUJG27lLZpjhsSMzUu1coU2QY/IWtPmaZf3xZUzxU70HQQOcTFI0DImRPcGopBebM+yuW9/E/BdaI8WZVJ8363wnII/itVA7B8Sc/bUmQ6j2p98j9v+6foow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cdbr/RUy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S3Z2+aXT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cdbr/RUy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S3Z2+aXT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFTrXv3752420
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UrPYU8jpATx
	6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=; b=Cdbr/RUysvl5KqOW7vCeXAsyKZi
	+2PhH1s0k09fAwNtSH5eOISox7k9Ej+ohhQHAxyurvNkdcJAgJlauY/rjqL7QkDJ
	O8bojIu8uhmW7WKyJXSoC0gy5lvcmXwzWpyNHWFzenixTOimcQrHY07grJODXJQ+
	imv/1ypN7NdHzXftxzTmm2BwOv9Or9wmk7Ly+9hEpaIlSyXbnH2787Is8ZvPL1wB
	4pnp0LGgeUvYo+lFa8XLtAXBw3DJWD4C55aQ9+We26O0IDyCO2UAJ7noKACY2fL2
	+V3d1aaW8sdJ+izMF57oJ3NHMo5jDltj1LGR+O9KtQwLBXjRBrCjO61irog==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1j6m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:29:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso946473a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777476596; x=1778081396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=S3Z2+aXTTi/vJ9nOYHKoW6lwkS7JYXSW01a82T7qDEvDa7tbPV455F/mtVur/72tBy
         ZqqQck5r9XKjmSRgW7Ci90jn9rw7fkMI14CHCLrt2Vqpcb8qDWXGwiczG+g7fvhxDVv2
         SM5jACsIn7UqdRT0Ii5GlFCARrFv2m2Zf4fywdlqbwB7b08OMTVw/qgX2yVXE31fjHPR
         z6wnPKiJfWHnzHPz8HdX0wdvoqxg+ObTlK2+wrXhs4DEHI4uOPaUq9ibt/kdUmPFliz9
         5efyCownVgPUh0Yr/14bD6FinIK/5H6qX+E0hOvWKfvrFD2wgbI8EaYZ3ihs51XpGedR
         /74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476596; x=1778081396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=bSTvk5IvyQwJwvY088K/d/xOPKktokgsyVFiCT4F+7cVbDvnBMpwxF67cnLxSY3wNF
         tM9KxEs5df2+0SrxG3ot4pMepv/vfwVwYVbtXZoENu8WIIPId7L2rYxJ3lC5mix8oab9
         UYieiag1TW2yU+Ea2lEG5lDIbVXQi3fhBgYcL+cHHkLIkLEdBSIqzuI6UVFgG+UAaUEc
         c6aprn2g0zCcD8xiPgMHQIJH9Knw0DSLmXZnNyZXO1b7gvhwAhrJ0FecdHmkCJWCuB86
         5zfljVFdjWIE44MjcrHMR7fmMd0hBSOgWQ/+gIP9FkGMz7BDmWrfU7BdtbhiBxH5mWaZ
         RC8g==
X-Gm-Message-State: AOJu0YyUYptYQ+aBt3VGZhZAaTWdsH3dUxlK/ce9X3jJlZAa7UH/biAJ
	QEejR315HrncrQcVUnlRLWbjadEFAH43rvDIy7sRKvJDjMfKRazl3F6Tye5496XDj6pCwNuhrqS
	9XlG1DHOw5ohxxM/836Oq2w6f2xCZqVzF0+8xoLrhV+3heZfnU4Jn8Ta6YZk2SNZQxd8gZDPjep
	cJvcE=
X-Gm-Gg: AeBDieuvDilNRDJoO1CrP6CEu6AfxqWM9cpMagSQhwDlSLT38iXFEcj2UBUm578pmYy
	PLL4LHs801RwdJruujAGQeyA/RzTXL4ZHYR+M3p1e+u3N9sVyIyXfZRzf9GQ440TScox5x2VAYf
	l8RLw3vp+LsQemvdcPLO1f7HLH6/x1ILcXYEkHfvk6qE9wlJ7EonugXZYUF6Qeyx72jciWUcJPz
	NOqdjdY1FaLCSh2TCMeTbpPcsBFiseglNzkkKNOTjyQ+82gN4+mebLYjpQHI1dWBV2rxyFOIqwS
	QFw59gc9ECsHytgzBQHqAO208J/9W4SCu7QDgWaRAAx94kWN1Z8gvTu7FKejC53okCAqSf4JD6T
	QOXHP87Yty3n91/XyVt6EnzaQzW3gnf5imD/NQPXN3ZUwkJWRP0XPGQ==
X-Received: by 2002:a05:6a21:e098:b0:3a0:9052:c005 with SMTP id adf61e73a8af0-3a3b2317b38mr2910245637.3.1777476595525;
        Wed, 29 Apr 2026 08:29:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:e098:b0:3a0:9052:c005 with SMTP id adf61e73a8af0-3a3b2317b38mr2910207637.3.1777476594785;
        Wed, 29 Apr 2026 08:29:54 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed6debacsm2386128b3a.33.2026.04.29.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:29:54 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v6 3/3] profiles/ranging: Read cs_mode_one_data members
Date: Wed, 29 Apr 2026 20:59:42 +0530
Message-Id: <20260429152942.2940978-4-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429152942.2940978-1-prathm@qti.qualcomm.com>
References: <20260429152942.2940978-1-prathm@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f223f4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VE_zAK7Kjm7KZJZHiogA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE1NiBTYWx0ZWRfX8o+6aHxYMo76
 3g3he4UbSkPQ080c6nJ0L6zJ9DWWBgf2fM+oLa+CMbErcTovWrhYQJTNFAQmnyxAzBe2xvze3at
 P1PydiY4Bq6sy8TFRigNPb/aWQ7KBACrBzWGxatbKm1PqVmi42iuWD0YIkzJwBqy82OfA62XbBz
 00la5lRtZGLB0/UaM/ETCpQ0rTR4sHb1Cp6ya+4vNNDdI2l3M2pMq4PC/0WJttWnizGFsi+Go2u
 hkopV9jBzxp2q/VHKkgSjLJPgd78chgxB7brsUInJvMWb3AZwBe71NU99puMWe4pECNFuwIi772
 qeH69zQ8NyFjU7ORIVMedV5AK0l7q5vdxU5aI8SgEfdClfimBDud13si6dpRttvKcW5idE84nLL
 XOO76pSIbDXZ11ZaDMYeujQex9n3FDnJqpYo4i3KBuUJekzcgU0vhRxdJBtoPFuU0K+LeUQNPFA
 JBDDsNn31Xpotdcf8wQ==
X-Proofpoint-GUID: sMDIgLcHaSQVGWOuYXPsppFw4xMoRCa1
X-Proofpoint-ORIG-GUID: sMDIgLcHaSQVGWOuYXPsppFw4xMoRCa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290156

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Rearrage reading of cs_mode_one_data struct members as per spec.
---
 profiles/ranging/rap_hci.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index a3d2df608..08ddc077c 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -632,19 +632,22 @@ static void parse_mode_one_data(struct iovec *iov,
 	}
 
 	DBG("CS Step mode 1");
-	util_iov_pull_u8(iov, &mode_data->packet_quality);
-	util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
-	util_iov_pull_u8(iov, &mode_data->packet_ant);
-	util_iov_pull_u8(iov, &mode_data->packet_nadm);
-
-	if (iov->iov_len >= 2) {
-		util_iov_pull_le16(iov, &time_val);
-		if (cs_role == CS_REFLECTOR)
-			mode_data->tod_toa_refl = time_val;
-		else
-			mode_data->toa_tod_init = time_val;
+	/* Parse fixed fields in specification order */
+	if (!util_iov_pull_u8(iov, &mode_data->packet_quality) ||
+		!util_iov_pull_u8(iov, &mode_data->packet_nadm) ||
+		!util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm) ||
+		!util_iov_pull_le16(iov, &time_val) ||
+		!util_iov_pull_u8(iov, &mode_data->packet_ant)) {
+		DBG("Mode 1: failed to parse basic fields");
+		memset(mode_data, 0, sizeof(*mode_data));
+		return;
 	}
 
+	if (cs_role == CS_REFLECTOR)
+		mode_data->tod_toa_refl = time_val;
+	else
+		mode_data->toa_tod_init = time_val;
+
 	if ((cs_rtt_type == 0x01 || cs_rtt_type == 0x02) &&
 		iov->iov_len >= 6) {
 		int16_t i_val, q_val;
-- 
2.34.1

