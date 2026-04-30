Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADB35C185
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534917; cv=none; b=ZVzv+SKaSM7BHX/Mg96tKrt4weFMCPhD0JYwgCj/JFw9ewaYBS07dWvJ78xg+Jc4o7olk00TXQWOCHNLN23LdkM55giNuXJE9kz28M9NJBFz2liZNlhCsvC4jzDcsO6zFFh1xP4QU611g7r4VhQuipkpnVz5wnZUo/OMtJFFJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534917; c=relaxed/simple;
	bh=C2MupbCihLMMxdAqiULKdFQISREaqVY6L2PVda6Xn/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ut8bIuotGzJauVKIm5ruj3peBL0TniVSr5DEyoSG4HiQOHH5Gfcko3ZZSoc5LoP4nKgIkU43WpZjNkYLO1IeGQd+IzGWopTf5H7QFu9p/yVg0XCbgwYZoK4L+grZ7I/aB0r8zEQioQpPTkRK2BnT5q/vPvtPuvMh9zlfr5AHVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8EGQxpI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P5u9RIvE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8EGQxpI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5u9RIvE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U44iak2099753
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 07:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UrPYU8jpATx
	6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=; b=d8EGQxpI5JxJXsPdWSZBvng2Zep
	PFSFDpIy3fXyUagFbHpXmz9GErz8Ejd/PH1gNU3R1yT27uCakQcADut47cXHPT0M
	pDhheQuLPhXNW/YFB/NXSwxJIk0LN3gAWD2BMUBFxA9RhxdX+VYG/Vjva4VR8OXZ
	RWl8vGzycCQ7Al2647LmOF1DfzJrFBDLXoePZWOJEMWTWEQOXNvJlA76uf8/LJhd
	9MBN3sbeODPbimRYis0KdprCSQhy58qJlbtMxm1XQA+yXqS78EdS92bkJ/nHJ+bx
	ZdLGYhmDO+yj02DhJuR82hrh8+SUb0Cctp5e2pXIT4xh3Hu4lvaRmEUQS7g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr40p13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 07:41:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3649e59f0ddso664003a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 00:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534914; x=1778139714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=P5u9RIvExMJey1eH/xfh1JUfwJWQ1MAVYwAsF62ya0bGRzlyPBK/6DHE5mJnsG/3IB
         yW8kes1LmYqNo+238N1ROLvXDpKT1PRCK9QLDmR8APkuhMbNbEVcAmzeiWWpVRJZOaIk
         cDI/11WrIF8LGi1OxnGVEPHkVp+3XNieZ34FTSikkE/8NpZ091SfaCQw48Pfz5+EVrEq
         Mb6b6BBII1nl0PdQQNzy9NjGYMg5U8/cYks3P6JCoSBpW3Pb8+T7oQFtpqkoUCQZDgta
         mTFeXIyGzI5P9s6jXYCbbYoadN3tjoD0apUxDGuJP/ECcUt11ZAL/OTzqUOAIGUKP9/3
         3GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534914; x=1778139714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=cdMaqZrmErOId5W6Ch1ff0sJhL5NWfRNw5X+2BdZChT7r65ziSn+n4fBtYBbBnx6lO
         YOUL9FjGDnZmVUEwIXpSRy8b816y8rPS0lBkxExO0ESehvrr/A5MJVScpsM2qzJAtAI8
         +cN8TaPN/N3qdvfJdLiVLq4R5ug9ntwodYfYGJxwVdU7TNhXS47nLBinmT5a9cdrJjUy
         RE0T/6WHh3IYNYMPv9MLRe9kzA1Cbb+IvOphceVAD+Umq1KrJLLrve53a2pn2erSGiT3
         NtmzKyFx7s5Q67cc/ITRVnfOC52IPqaKO5WJX9+GqtDbKUJb5O6W8u5Hb4d4tcFMZ99Q
         IMmQ==
X-Gm-Message-State: AOJu0YzuZ2eoYwZ39tkGL1hi+hO97gATlEPfSSv3kq6RaY8z+52pbF8i
	yiCuuJIVKXOXKyrBc0AS0lhyzpiVL/OXMd2UZh3aYKcLjyMHEWjUsnwvlh6dR6S5W6Eb2RPn55W
	Eo/Sh0tGD3xUQKiFH36/XCrYwv/wJSLMgT2ktfJVf0+YsViH0mE9imckuERBKWfyy3m+spS8nFh
	SVKFk=
X-Gm-Gg: AeBDievJHXilcEkn2ONIVKq5S/T+4/cnsWljHqxWthWikCVduXu0n2KpgopgpnSRBig
	Nxw4LZPeBhse1I1YXwGASdDRvqzRO8qImvKkXYnAINsHaUse7E311C+ECwBeEky06Cdhsny9Abw
	BVaS0nxaCLo8DOfuiVJYHJgjeaxVYsuN4vMq7pkA+a/smplnFUhOLgH2H0gXcu/3qI2pewkP8XE
	8vN3oTSwIA0LainFjuQWymhmQx2HOcHRATvXyImeVduKvcevr/EumUhGT0LnGcdNGMDapzSkN18
	vpMkbcJz9ooCSEeQLryzmjlPWEN9rk7M6P/ftz7VWN2GP0a17r8VprNsrgqiGw+8nE6KdOBkQOA
	aqStxkvGwpFVBVJOjQEHsYAdHVkD1T5eNvgQzww19ODkaAeLeV1Jk1w==
X-Received: by 2002:a17:90b:6cd:b0:35f:b313:84ca with SMTP id 98e67ed59e1d1-364c31a1cffmr1881230a91.27.1777534913983;
        Thu, 30 Apr 2026 00:41:53 -0700 (PDT)
X-Received: by 2002:a17:90b:6cd:b0:35f:b313:84ca with SMTP id 98e67ed59e1d1-364c31a1cffmr1881201a91.27.1777534913558;
        Thu, 30 Apr 2026 00:41:53 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf54419sm1881432a91.8.2026.04.30.00.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:41:53 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v7 3/3] profiles/ranging: Read cs_mode_one_data members
Date: Thu, 30 Apr 2026 13:11:42 +0530
Message-Id: <20260430074142.3599484-4-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430074142.3599484-1-prathm@qti.qualcomm.com>
References: <20260430074142.3599484-1-prathm@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f307c3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VE_zAK7Kjm7KZJZHiogA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3NCBTYWx0ZWRfX70OfST/2NH55
 PxbhVJq2R2ag7ulhAiYnNdJe4VTDAZCukmyVoAFdu+JqmTpvmq/R6b4AEmVD5heEwZQC7xaRBod
 KjH6sHOrciLyle7JK0uyzCuET6SlaK+WNK195k8nQHnoj6snYhDRiPRK5KlHcSS1w+NKH3n5aXP
 AVHw6zlpSfJ9Nzx/YEyQVmnp3JFOT38I7m4Ji33DO+qQHGsPd055Jmgo/4FHViN1CDBgDejLdkj
 k+pmw3ueGm3Aen8PKJkfk8P1QY26jUKD8pBJv4hEE5nGarn3AgpGGr4hnjsKw44YigD2sjnkIF8
 n08Zug5Ml6yHXXc/jaClGiDjrIrHYTXuZba1XTRSRp1VU9Fe7F2pM9gvGBIS0jkfVpQUJL9K7XN
 vLb5RjB2NsL6ugZVBR+3995nWoZBsDtLW8lL6Vhxcc10EatX0O5O6tZknlKJsafFlgYX+bNc2kQ
 FDgva0Tvws9YAcINurg==
X-Proofpoint-GUID: Dni08LlgnduvvWaQuGHvS9S_j7OQK4yG
X-Proofpoint-ORIG-GUID: Dni08LlgnduvvWaQuGHvS9S_j7OQK4yG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300074

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

