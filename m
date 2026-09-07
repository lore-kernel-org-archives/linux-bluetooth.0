Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122E4EC67D
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789394; cv=none; b=QpXdbPruUWphFgw7dPKouLIULl7HWVU57eFfBHDiCDm1j5mgsWlk3V2NNMRM9ARHubIOV6h9ugwlgrkRNHCTUfXuAYEXF01eWJjIsvNgEvtqGQ3ja1cGdljwBsW78ijjMmNdatA4ZPEgOeh4YDmN28O1hhBQ0jTW8avKRRmAHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789394; c=relaxed/simple;
	bh=zsZrlQmHUpCelFB23WdYSX+OsI3J2ojSA9e5YhIvi0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufE1+Q8IZX+5ywGkeWVQ0QwPPUxMLYcg3u9kTWIL4CjtQWnoMxq9E52IlcZkCdVvre8jksgFA3nyK+rhXI5f6dM1s5CDjP0TnVRhjrnocSdURe8GMG8slf7TSx5+3l17Wf2jwjLqiDasolhj95yTaxepxxiuaxJUanFRNSJmsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jPZnlVp6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DSFa7RK1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jPZnlVp6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DSFa7RK1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Ddnh6590454
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Sep 2026 13:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eKy9WeqTx4x
	G/4DiiCOF+X82FoSQVbn3J099IlqrBYs=; b=jPZnlVp6nDZzJw2/mIXyGvl012+
	GFCaz/ZFERstMbVt38KEOYli0HCeKExmWmRZRQmW7I+0Ff8VXRSQ+8XpTvxNgbbS
	/cySQlwpCYbNh9lrFrwU/QA4uhs/NBqSN1aTmj/k3FvJp+iS1k2X1Jy2f/JTNxZ7
	Tod2bn4IVS1yCPVzstcHQl+s5V14foT2ggPYSrO7TKCjvNSJIl1pNE1Golat2zw0
	O+UqayIrDOw0F0sYOpXN/MEGMQhDWRt/s8fNjsFIEX7xCm7ZpnC6BQ1ajCfCdcDi
	kRRti8Rjmq7M1A+bWNLJPm6XKVgbNeSplu0D2Oyf+mG3847XiigXP39OPtA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqh2rx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 13:56:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-395543dc382so4730824a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788789388; x=1789394188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eKy9WeqTx4xG/4DiiCOF+X82FoSQVbn3J099IlqrBYs=;
        b=DSFa7RK1+6U88+8En3n/FqX6SCSbxaiDlhc0DiqzGL2tc8wSHaJFgUnpW6X1D/jwHd
         H8y4DITdr9SYAWhuNvHMuVrEPBIqry/4wlYbvPBxGZJcO/3Qx2a1yEqJVPmSq58q5OT0
         /VGt8F8LrLPDtfL6uGqo2xtZAc9J+MmaxkowoVcl2nct3Cbynxd4/QyvjjUVKaa5yFRL
         TW0ntJLpU7G0sd935OgaoBMtZP+R+cvAGmMYRBTkCF1ofiA0lS7xMoR1/NtqmPCDbVEK
         n1Tzom7F65QuBn5dx7stlMj0r/pXoxkKqjwMMgwcNOEMzuES8kMxDOr+dRI5o84SwZrk
         NDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789388; x=1789394188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eKy9WeqTx4xG/4DiiCOF+X82FoSQVbn3J099IlqrBYs=;
        b=EklSSIscgH81snzVveTDIgwnl67RPVNr8AfMc+ej8wBRkWflEt668JXOAKmon2d+wK
         8u+MXkzXZCMY7QnLTZQ4ypQmX2/lzi3f0Wnk/mY1YW5zOH2GoMoETa7uG09WLP/Adh8F
         pr4O/Kn2kUq3VLTHB1SKSa5GxaAAKuy54m2n+0gF0ueyFvui3um6fsMsOtsKvngsXRJI
         MX7OaH7A4PpyLxzuRBaRY5MZvZuGsKvosMXRJbcCR++DdFztReslJ3ipLxn8LqNt2YBp
         WZxFXKMJuwY8es960uXT26+kioQtcjU0iqIlw5zDzpZ6EHjGbK1QtIJUW/S0ZQjs3OJt
         dHdQ==
X-Gm-Message-State: AFuF++mU6wSjtqHARDeExE/3hel2RCFqETI+R1rM8KpZ9DmTvD4qLxC9
	y4r3ZzRGxFUNalPIkx+isUJCYJLpI0TCOfg+vGfw9DwAQvwsb4fiQUdy7FS8lRscwmpeUG56Ods
	tIqZqkOX/Kg7cGNZVqiwc6vaPuQjyeD9pO7eBSVxb6iMGH08f5y2fkpbWKnlc+PjafohMTonqeP
	fIKZo=
X-Gm-Gg: AYBFou0DZsZdeVHlse6I44rPc6IC1PxEa1lB/b8+mY0aGcc9nPorfYeakfS2s3Nvs5k
	CDhAME4bGduyNZvqx5CX6FU/tp424EosV7WbAjcJ2tRSfFOzxC67wcneuqWyOnhSOpCeS3wgAuq
	iL+mNEZpccc6V31vs5TVgeHI60ycEU2pTAnErfHfp2nlXKpezFls3vec3VHFj2L3UN4GXY3Kgd1
	UCTMymlPnwaVuYWw7QJfmva3gsm82B5Z/bzi8B+Gpvg1nUadCKPEUshXn1+C5bRAbaHnjqFDex+
	Sw0zBtDpB+7sT+Tlq+yoC79ztNwP2FqWF3zrvPbRII5Df6Z6zAbMpnN/BU6G3C8XLT9tHbu7g0J
	bpN3oiV3O23mAnIxirO/l3lwu92/XTA==
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39b262e28c2mr37875530a91.25.1788789387620;
        Mon, 07 Sep 2026 06:56:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39b262e28c2mr37875429a91.25.1788789387115;
        Mon, 07 Sep 2026 06:56:27 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm31561116eec.2.2026.09.07.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:56:26 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 3/3] profiles: honor OndemandRanging config for RAS Initiator
Date: Mon,  7 Sep 2026 19:26:06 +0530
Message-Id: <20260907135606.824752-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260907135606.824752-1-naga.akella@oss.qualcomm.com>
References: <20260907135606.824752-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE1NSBTYWx0ZWRfXzOIoMeNkZ/I3
 9pG16LwgYW8z+AYc1fGv2LUc5Rx4mdMc4En5VmqBmqBrE5UOV1UEZ0ysSF9iUpUdruLCBCAX2Rs
 Z3JzAcLKGUDH2kSVHtah1o/Wx5RN9une+IvzAn6GVkQgzdcYxlib5VM3X8UO7Xwp1qSjA2uhhA3
 P7dJiDs1xhUjJMEpknp8ObUCvA7zLgZUySx/G7dUkfH63Dv/zzYhweckZT8Rw0AUX/MepCS1nPR
 PTDoKoTKMnPbeMEohfU4TGgiQgd0D2b01MLO+dTJq4sbhyELJCk4SGiHdFlzV8hDZqMZopyTNtj
 l+J5StN4l92Bx6a94zs8uO5O/o3tBQU1uOqi+LgUaJOJhxXSbMFyR1roZM49nPmSbvxgvCnULA9
 /yA9yeaaFuRno71+zNoVMnrZWB+fhsH82rzPLqcXVb0BNkmlI3zE6/8Vfjnt7XzZfrsybcBK/Rs
 hv8ml1Tt30t6OeNlD8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE1NSBTYWx0ZWRfXw4C1dM5BC7NK
 8AFazbtPta8kz24pE0q/GpXBzwhYgBwUYf3ohWtamUxRNXmtOGNV/58FVqO/k4z8PrsAY8b088e
 oiNfQaFq7Y5hRFfwEkEX9KnLwrYwwV8=
X-Proofpoint-ORIG-GUID: Htmtwie5BzU1JYSJoUpssjEqTeOGHwMT
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9ec28c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=jk3f06rm_vXkH0prXC8A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Htmtwie5BzU1JYSJoUpssjEqTeOGHwMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070155

In rap_accept(), call bt_rap_set_ondemand_ranging(data->rap, true)
before bt_rap_attach() when btd_opts.defaults.bcs.ondemand_ranging is
set, so the initiator uses on-demand ranging data delivery instead of
the default real-time stream.
---
 profiles/ranging/rap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index cabf8a5de..b494d188c 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -1105,6 +1105,9 @@ static int rap_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	if (btd_opts.defaults.bcs.ondemand_ranging)
+		bt_rap_set_ondemand_ranging(data->rap, true);
+
 	if (!bt_rap_attach(data->rap, client)) {
 		error("RAP unable to attach");
 		return -EINVAL;
-- 

