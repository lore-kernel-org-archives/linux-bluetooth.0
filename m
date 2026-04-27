Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21208358394
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309227; cv=none; b=n42HxYMmDG8cv5h2ScoVTxfOtLsrn4+BSoqYsR12LAAUgr4TH2/m6yKTpWdNreayNE6XKG9njSXKnfWn7QbJPJYdxgq3SUodyGNsSEOq5y68CymYXL+ds5FhkUx/75gIFng4kTy65vg/9cWTnQGrWIju3Qr0gu2ykfrGBjb91Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309227; c=relaxed/simple;
	bh=C2MupbCihLMMxdAqiULKdFQISREaqVY6L2PVda6Xn/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNT/a7l2h5ZHYJL3PysI60WkgFKfhbzqw9yWo729orxVgTy8REz92LOQNPWGK9CQ5BaxsxOHz51j4BU8SrPDGQmrBogdxe9WhozXMxDdPuAu8zd7h8UTVNfqWh0Gbwbi9AMjWzQRfHyEKIW/o1P6HOWJbh7CDj0xWebAWc8+iPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ERAoeuTH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RQmKB/LG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERAoeuTH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RQmKB/LG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RECwUa3639606
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UrPYU8jpATx
	6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=; b=ERAoeuTHw9+eFtYQZDppKZBbwQn
	LgHAmEk0CHcHXMs7WWWTpDxQM+jgRh/2oFrwJoELJCwAeHnyIhL9GRhevROxt8pH
	gjX8RY0CwRABvL1Ij7LnG+detg4pvFzJVKXubwyEHllegq4RtOruy1T3xVdORGWK
	M+fGIE+expulAhyjisemEz/X5OeZYISt5Nuo9r9qeQ8EtQXXTpwg1jn4dXp/lRJg
	Pp1hVAPXrdLRaMKrJ+I62RqaWfPxv7V2gqfVO+bftTe8DwsXEnxUnLrDtaZ1c/f/
	p4MmE36hs42wQD/8/8h4AP0tieq+q+9nmCSc1MpnuRurGyhwMm1wiOU/AlQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsya032b2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:00:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c799a65bad2so7320804a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777309224; x=1777914024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=RQmKB/LGR0j/HOdRhwDPslX9qreYkcISExXfXSoYS4LTKavR6pi37P9dJ+0IlsGIbl
         U6fb0MoqWJigwJquRFKtNeei/DY9+Q+tUEnuD3VTzcVltvGbDAoeKcnNkhPjj/Sw99vm
         IzZ6PbGmW4w7fLgRRVkERnbD6hN70wkfqeDpR/7ucld8m4R4jT4zg2NL9UW2/zCv0Cec
         +vkACMMJ26dIbJCZXD7bf3JRXAuw1E7drbLCHefPRB8rffg9uO0OYLokmXm/zGvucCfR
         2K0vCbwcte2QDYlUTWp+eaRzvEqSoQhtdMzPylK8TtIxxekFngNm9ediKxZ2k5rHc3Cr
         LwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309224; x=1777914024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=YKC4+9rFhWsi88ORII/+N8NUHFAaO2r9QIGDGM5KL1Jo4PQTAUmrxLxno4t7JItPxI
         mJYRx2P2JnuebF923kkvNBrytUGBfku0vCsTej+laJnlzTlrmiT0BE29+mSjIuyoy0eg
         IgXfBbMdG5uvU8iktAWoxXqQcFlLD+6vaNgkg/PRAbtCS0GJ3A+RNK35qeSHEqkcWwwo
         B4zicBLLQG1Vb3+mFEQfVXm/V8423fs5UsbwH3pFX01ts9NJHXFn+D24o5f5DM1uq2CS
         nLSfLu98YAXOUBpcRwQEZp+hvlIeN2grI3MXOpMFxEuOaegwDhEZIbpoFJyGo+//OExl
         QseA==
X-Gm-Message-State: AOJu0YynWr6UYGnWiDoRGvBs3MRz5BvH4A3SShj7HzfJqaEVtmjHgdJc
	qKEVvRe1J+FwDUxtB2ANtk7/xny8LuQf9+XoWkaYJOiJKpAmeIFcxjfg6kiIxVAr2KTYR0A4UBp
	S9XBZ+9RoCnw4k5ihFI8DDhp9Q9/tl2C832R20BenypkO5eRNsn5CQSLKEUqzyBBdMUDbzDniWP
	7ryxQ=
X-Gm-Gg: AeBDiesQN8KrwGtbM2yBPFjZ5dNIANG/YARCL5AH0Kq2bqXdnHjh8HJHyGGR5NX+VEC
	jApEcVVCPbwiOcOwWSylgt4WbMxqRyFkRjgAEu3UNYMF93CTctyaLw8U+1BhbneCppuE12uywHI
	0R194rv//XFMQa+GCKCDGdXrW07aao8J3bDMuTYO6zkNX6RtqfZpBv+dD4gnZSuEcDPlHUB9Wws
	xtLoWp4bgGOOfNayaR+hGvRog+VCd9fImyhyc7Xty8WhhdAy59XY6dB3VoKD7eSwL1DSjUNOUQC
	YYAW7wZF+18drTbcXMrGkoaQcFLHs2UQgQ4AvQtMg+OLhRP1lJk1Y9QfkiTD2KH26vg1SuIYZUx
	ZZFCkFJbajw9Qw+7TrkTXLRLsbY1XDOrdkQoRAPfwrpyYUXVS7o3wPQ==
X-Received: by 2002:a05:6a00:1acc:b0:82f:4a4d:377e with SMTP id d2e1a72fcca58-82f8c8c2f8fmr48437087b3a.28.1777309220761;
        Mon, 27 Apr 2026 10:00:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:1acc:b0:82f:4a4d:377e with SMTP id d2e1a72fcca58-82f8c8c2f8fmr48437032b3a.28.1777309220083;
        Mon, 27 Apr 2026 10:00:20 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb33fcsm31540597b3a.33.2026.04.27.10.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:00:19 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v4 3/3] profiles/ranging: Read cs_mode_one_data members as per spec
Date: Mon, 27 Apr 2026 22:30:07 +0530
Message-Id: <20260427170007.1282289-4-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427170007.1282289-1-prathm@qti.qualcomm.com>
References: <20260427170007.1282289-1-prathm@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Uks5s98dCzLSXXpp79wE4x_IdR-O4KOK
X-Proofpoint-ORIG-GUID: Uks5s98dCzLSXXpp79wE4x_IdR-O4KOK
X-Authority-Analysis: v=2.4 cv=DZEnbPtW c=1 sm=1 tr=0 ts=69ef9628 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VE_zAK7Kjm7KZJZHiogA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE3OSBTYWx0ZWRfX/abyKlRdHzJi
 UnPKIjCKrfpUK64syrfRWb/pSBg9//ilEy8kVcRuO4Uc+dPfYH4/n+Jm/vYpC7/GXWUsLgMEKpb
 ANEhHIG57NHgFEalP0s6y1pNljO+J1gizVKKZAy/cJhwbqj7HCAgukQODgZJvSW7cMSsCrjyvcu
 XMAKVTVRZffpjs2k510xZ5J3AUhK5mA4IGIcNGSTBK3PHZpgSr3o6ZGiQhZe8Z3ig1RRl2tp4xf
 nsHPrEziOJeOEaOEKtlwMAAQpi9f+BmzKSFwGhoiAvYYfkeMRgKdWaYuYdTVAGdx84Zy7cl1lTP
 gjNNbLkpx3MFttpe0Ph62ArdZMRBCQ/FASX3g44mGb5AS9oiTpDBPTMLlsIj3Yfb6c3soXpQ9VE
 nqwaMgzDGjgBR2iuhztL/qfH+kYc8kQ48xJAXXyIdwRPoh3v9ulSC3LJzQ+PyP3DAm7EhDOeAlc
 E/OOoItd9uKBCic5LGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270179

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

