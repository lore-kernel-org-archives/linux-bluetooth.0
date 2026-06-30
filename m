Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B510325483
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826810; cv=none; b=Ziov1oe+SfXxk5b+BRH/IIM+N4XC0cKHJSDar2wnyh8r6k//CKDOp2Tmh7hbfQHL5EgBP/M4otwAL4N1AXAF0kTUC+054naW9y2zI2mzFjbg/kXSFkvQPkAtVIIU46WZApVxc1odh0umbYOVDruk3XGpejsIGAJw+An+GQMP3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826810; c=relaxed/simple;
	bh=dusiXwkpDFpI8rEIOTjyKOAI/kssglyu8CgbShvDG1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUvlFI7Tp496idLiUheaIzkxBNtCkX4Ua+97t2ARH+VrDrB+usgrEE/Vsp+wOuyVU6GLmSC+QI8QXb+jxYlrdnpBsC28k6Dws68rm/cFagxaRoMjkZ/wLO/18i5pnEDKPF03Ik4OiEXJxX1u+xtWwVa8AGyt5733pHcQLf9RM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EXX+D76z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JW8qG/RT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EXX+D76z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JW8qG/RT"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n4T81508630
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uLHdOI14XkM
	A43Ysz8N+0eoflaFdx8af1KMI4QbKec0=; b=EXX+D76zRGPTge2aMY05vhi7o2N
	ciNENH6HDVVihGhQJWuSATTlMmpP9NTpO9TJA259SLEDAXoC40rHPcuLcEPvk5kU
	A4SkVSyY9vk/2ZOO/1uvJMS3mwEo/c+glc9Yg6N3DY5rVyHgOL09e12gb7zvJyW3
	itSRqoNx0U8r3mZjjCAD6D0QBaV47dMdW/GuE1FyqkzhX3XOgZeJD8O5XkEXGJUq
	JI+ALs1/FuAqOkAZZbRd+wxqBBslE4joynJWm9mOXWyJ1tQ4PHtgyVPaWSsal2Zy
	2CgSAieqh1TAOcdi4f1V3X52xRHMpncdHcFC5neMwhYhH5BOShZisE2bAPw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j3sq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30eefcf4a1fso277463eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826808; x=1783431608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLHdOI14XkMA43Ysz8N+0eoflaFdx8af1KMI4QbKec0=;
        b=JW8qG/RTHz6MlU04uzOxzqBrPkz6hjinSbCuPoyI+BWilWohnl6fmT+J724XT32031
         YAc7oHw60vWzYp7uMkyE9W0N65tiFN8VB1C+nOqXd+gklgvt/KJDMpe1KUFErlYHjFXR
         17eN/CpTXRL2XuLK+bCmvOZSZt1NaMntyWZBP2YRuXvCeVvdlDDFoLInODpdMm5S5NE+
         cpGXsW0Ggq3P1jS13+lXTf8dum65LPbLCOAw56KX0gqOx9kX7MFPa0YjMPHXHy1xxjwR
         zCsEUSqTSadZqU5vTzNGq0cicC53na/8GjsxynEmW1o+AdxaY6dGlOnKSTVryOhaa878
         s1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826808; x=1783431608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLHdOI14XkMA43Ysz8N+0eoflaFdx8af1KMI4QbKec0=;
        b=hrOlrrDv09wlJBYIh0ITZ0RzQMc0CKEWd0g2RC4h+uqB6vtr9rlsI7XwQ2HdC5WhGA
         wvDff1v/2IQhCJ5FF/VTepnRQSP4wIi9GFhfT6utxevHCFyo/I+4/lrX6Xx/y1PHLIrW
         sINi2y5YUx2FTRihwPuUDGwYRqEo2cgsJaRfpmSXnkwGzQSu9tfg2V0g46Z3FMSa6Vuz
         y5OR1kK/kfX+EaTrC3yPJE3v0gQMj0pOvvn1qnwj8Gj8Hz3vOeaFG/nVEu4EbKGk6XSa
         hubIN9ocC2rO6REfipBxNdahKT8rxua5BVA7Gezg5h3mFFABJjNmyOuGnpK6RjwsnpQF
         8s1g==
X-Gm-Message-State: AOJu0YzpMVR4GaauhGdlnG+Q9ItuYU+RSHUutCL0uqz7GywvOASpmILP
	NZ9qlF+8NHMM9sRbQ5z1InKuCNH+qkvtKU12hrfPhcFhvwklkDJgsqhiYgPrfUlivfn4C3V3snh
	EBYLY7LkMenyhvFAFQ9hrgaAp6w8WBRVFoyR15hcpM84UypugS4Drvm5/Si3hIsRRvQ0YvBfKwb
	TZsTE=
X-Gm-Gg: AfdE7cl31Upf4D60x7fTm07FVvyjGfxN3vptgHnr73z1PoueMfy/bQjS2mKNCq7jeMX
	rV4/O6mGWWuR4ou54rK6+YJ34Dui8rjAlWpaN9aM+4d/LkHUdSUQWJpAJEnMwVhSTMvuJUCIs1s
	y6tptjt412UzcNqei8LTyuq9UdFDGpygIbagZOygoW2m03E7sn/tUELojiTdk1y5e6+wEGHBIoP
	vMMKiwJauXJo8NFPUqy/NEMoTEAu4rX3SrIcyhFvdycl6UBZORoA1xQy2z6iUtYyjSWTgw/X5qX
	pmaw+Nrgsrr9KhbS7rKAUCgrMfbdB447/twxoa7YGJ0Y3aoxLqqdPVdCCUz+IuG69eBxBjrdt2L
	UjnzAXFZ5Lge+3qrGV4WJZWsKCfss2jTD72W0cZCt
X-Received: by 2002:a05:7300:5b89:b0:30c:ab4d:da44 with SMTP id 5a478bee46e88-30ee13bd124mr2955951eec.40.1782826807589;
        Tue, 30 Jun 2026 06:40:07 -0700 (PDT)
X-Received: by 2002:a05:7300:5b89:b0:30c:ab4d:da44 with SMTP id 5a478bee46e88-30ee13bd124mr2955929eec.40.1782826807006;
        Tue, 30 Jun 2026 06:40:07 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4dcsm8704158eec.5.2026.06.30.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:40:06 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 4/6] shared: replace the wrapper API
Date: Tue, 30 Jun 2026 19:09:38 +0530
Message-Id: <20260630133940.2461816-5-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
References: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8weg6_I5LnX4N43Flbph7bDI_oX_eTMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfXwWY5QF4WNV5l
 jl7IN2+fyilQWkRtA8Ea2HEJ+J2hoWIRrsQ64HBRmb2Gmrlz0efC+31wS4k+0FRBrhSSTIV1eoW
 hMhb60gxeuxMjkTQF3m1Qt1hOykipctCCLusONUGcnRxalCls4jLbsNQXRnbg6R49izudXtcAw/
 dswBzGNhxkv7lyJ5ct3SD+7KOKNDscyYnRy/LDKoc9zxOrDX3lVDFVrC3QO3W8Sh2vlaAPnZS5/
 qkKNSx2wxcgyL9MLInzfQsiYLrDzv9xYbYVSK0IJbTP4POve6FleuntYeV6QluUH/rWAgxU0xlh
 9ZompxW0MSwCGeJSrbkuh5sD6SDUw1FIYHLFDtAT6YKU7rVEf6XwBqGNOuIj4y4uJX4cW2zbhKW
 oIucrXJ3ke6uOvUXKksJNAYuJ6opWEt6S9IiQbYVsYe9AOvakaNoJUc57DCM3evAe/4qOsRRp/m
 tCRIkYqgCqjmtpyIN8Q==
X-Proofpoint-GUID: 8weg6_I5LnX4N43Flbph7bDI_oX_eTMq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX3lSV4dHVd31y
 ruXdZ65d+ez4kloOzXgZYXtU9AFfxa/fXex6I1QNfTudpYXXAwA5NEbExPYpQ6qg+fnZA71JkMs
 bKefiwKxMLveO5CF0kAMHgyz6rxTpVw=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a43c738 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=9GD1gmV-RyNpu4_TKacA:9
 a=zZCYzV9kfG8A:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300127

Replace API bt_rap_attach_hci_v2 with
bt_rap_attach_hci which has less parameters
to avoid compilation error for individual patches
---
 src/shared/rap.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index 45be14dde..b6fce8b54 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -206,11 +206,8 @@ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 						  const void *param,
 						  void *user_data);
 
-/* Wrapper to be removed */
-void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
-			uint8_t role, uint8_t cs_sync_ant_sel,
-			int8_t max_tx_power);
 void *bt_rap_attach_hci_v2(struct bt_rap *rap, struct bt_hci *hci);
+void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci);
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
 /* Connection handle mapping functions */
-- 

