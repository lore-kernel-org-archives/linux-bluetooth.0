Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ABF3EC2E3
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814359; cv=none; b=Xt/gQOIlbPiWykg/DWEd+zNqnS6I3BEiV1zwgwWJgEO6eBxhG+Soec77l1GpvLD9ynIt3nDXWbNgEVYjYjni8jQww4ewk34y6NbxbPd2J64Gu43Fuzt0kXXnLT4H4gDvH4+yPZqyXOn3ucPcFiPQuoO5dTcGNB+CSDJlaq29Fpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814359; c=relaxed/simple;
	bh=rmtEq+aZuMgJqNY1iXngb3FKznWRV7odwzmb4AF7qhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vz5Z3kHfcXXlrT9ja6b/1wLSuU1rQyt8d4j3MXjibfwmW/TGS0R/0KbFcXwS+b6fqsY+v42bDwrUqe0mE9p5swlDMtpNL4p7EONk9K2KwvNNJA5+Lq8FytzscCblPQhOigHa/6yC/Yms1Q1fUCgeVCZa25Pn2oSJiJWgVt0br0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZczrdtUF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=agKRT4yC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZczrdtUF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="agKRT4yC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9moQ61541515
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8aXqj6VEa4q
	swaOTvjS9Wy29KZ/Ur9JPuvnuqfAH9Fg=; b=ZczrdtUFVAJrjGTOCYse2i7DSFG
	0Wu40Klxl2EPICL5Y4TBEwIXVFPckx3zWmg2pr9LobtKLB/uo1gl6lAmgMT0dZyD
	KYS/sDD0+Ls6ZIE7LBEi8LTPP84PQKjb/HktzuRWzoB5MF36PZYVLHlvpTGFEYTY
	Qsj0YMpJjqm+U3vYzXRP7PMouRvTh5rjNAGO2K+hH7hiz2nHVuTgk+bqlmahlmc6
	c/xczCxxmlKCtJ8DMrNJy6KBcmnXk6wGdMuzlA2NE7BUu72XRx32L1RzLhPTh1h4
	sJiZd4wDpTggncHI1mjIhs4RS7uvL9A+wi+lD+CDYYfoxvWLdhnLFapiaaw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp1ucu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137fc6f8e9fso7805301c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782814357; x=1783419157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aXqj6VEa4qswaOTvjS9Wy29KZ/Ur9JPuvnuqfAH9Fg=;
        b=agKRT4yCWpF54i4/pZrG4dIdfBWltphNSbZWcolsa3qz7EiWxVG46OMayzD8r9Vslz
         kzQuMYdcElAmqrn5ZJBdcSkt8NS6Y3Sb+6u9lSw/5ttIDL3mDUkgL0iai58Xe95vQBwo
         kYc7fb6/EQLc+zF36ayS37YjfFZ/NgEjyAAuQB0uWc8vh+4XAdj83PNirTP25K9bUrbl
         Pg0sge2/FqpXeDfzr3Uaz5HGTEO8vAZBck50s4cl+LQvEQ+a1ymJvl+YvexDe8EkpUn3
         UQ9QhSV54l6GcbNM//rUONjywMh5p/5VxUXh7CbXo4ZPBrheYn49rG6iJR26owDa2sGp
         nHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814357; x=1783419157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8aXqj6VEa4qswaOTvjS9Wy29KZ/Ur9JPuvnuqfAH9Fg=;
        b=MJPc0JtQ1lEMA9fzAYRgodjb+xS8NmAEhUdoYjyFvm8Ehi9v3A1G8v62o9wdNiIlbA
         MSOsv9249TJ40ibOEttpYwaOSoDxjvTAAUjEp5hliKNOGuva0Rwk4qnqvgTE2QKs1hnS
         Tsaputo+Irr96zhiRWEi5PR5+Cx9xCOkPLjkuNV+vEzvsiZGpS/eo2/5ByMd6DkP4Ds2
         MkhWQ4cfhROjhTnutMJUwRiTI0A3pROmp5wa3/Ba2HEaM4tnZkDbl+WQRIQIujyfVFBI
         KN03AZeq4b3tMy4DMH7WPL4tyAczw/1q8RvjAq+SrNPY+W64l4ttj/dlzxLUTx9fuKju
         aNIw==
X-Gm-Message-State: AOJu0Yz2wYHyqCN90UTC+yDpKOFqCMJz0WO5/nlR8sjn1FwVQ3kXSS2W
	tZLz6aS24FxEVIarxm/jtz4WBnwmRguFee+WkFrBYcow227Ml8IBOminI9+mZ7k0+uyovYeVl+i
	JqMOONn5gXt+3aMXAjVc/vDx6AWdlDKqCiiLXjQtP93hOTOF/83YPMNq9xF6n0dfwWk1nZ3MD2C
	GDz2E=
X-Gm-Gg: AfdE7cls4ymm6Q/qcwPr/5dVSQWoQhZwbZPBg/umKyEnMbMxfXfEviO5O19Sh5bNpL2
	0/hI5vqte5SuUYjIvJOaftaKJdq7Y1u6PBkTP2kuwRHYNfDSCY9rFwNxjCcmO0Y51kN//obHUbU
	65H8HPvJoE6KfF2LmW3Zh+smQyTaceX6kX3lnUnYCT7aceAxjEmL1A3c7qM2tjkQyMFG1qVz7Sy
	q8Tp3zFJ7e036UjISp/HMoIv91Gkonxaz0Qhe5prAFKYWEWfwY0PKMTg89v3kg/E/+SI3zItsLH
	8/63gVfOyAbf3KcLs4g140yqxRcPCBTfmPt9/B10U7dAAcAYIp1ahX6R89vOcn/ctbTvb4o3t74
	yS/1WGPgjCiE03IRSQdqbTlfsMuYUtiDyH+ebP2Fu
X-Received: by 2002:a05:7022:20b:b0:138:43f1:e48b with SMTP id a92af1059eb24-13b2a1573c1mr1770804c88.17.1782814356543;
        Tue, 30 Jun 2026 03:12:36 -0700 (PDT)
X-Received: by 2002:a05:7022:20b:b0:138:43f1:e48b with SMTP id a92af1059eb24-13b2a1573c1mr1770786c88.17.1782814355946;
        Tue, 30 Jun 2026 03:12:35 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba6fe2sm5670060c88.9.2026.06.30.03.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:12:35 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 6/6] shared: remove wrapper API
Date: Tue, 30 Jun 2026 15:41:58 +0530
Message-Id: <20260630101158.2239682-7-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
References: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oWmQjltIUnJ7Nr4nBJazh_71JZvSWF4U
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a439695 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=hz3V2_9aOsqkU0mBppkA:9
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: oWmQjltIUnJ7Nr4nBJazh_71JZvSWF4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX72IooDf9GYLt
 8ccxhpDJJvxFDf0EWJd/ZSJJh8tA/bsJvK5e+UhOPnZpftiOMzHqAiuReqalfu1RqZFGUT3FFDS
 6x9SQwdv2DXr2S0jxFsd9ZsozUkurEtOwWggN7p02cfb4UfhWi1kYUSgqUvZvosjkYhT6PvBELe
 cdY6GEUhabkKR1a8pQmpmYDZI4U/3s1+jdpUnadksWSZb3nqtEM62Q9Y8DVjs76+wCvkLBL6CQQ
 /LKIytMtW2sJ0UsdfX5D7urSt5S7Y2gkY4kQ0sj0IXegs7x8c9ehn4Hgm8XH8rbu3obIjWpjAz0
 5HpaOtFdtLSvf6csbte4G0kHvDWqsUEDB0JOcNleT4zUZ99zk2irHcVsQizOT1OX1HsH+hAQ9nR
 X526gLSagTDrLw4IZT3OLVpk37xwmzsNfWsxcJKPcbjCs9KlSPT4GdI/ZH+OLZozvoKwnVOR2LN
 I1Lj1KLNalJ23S81Urw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX4TFiWRyVp6OP
 jZp21Y64AqTYNuiVXb8+vyVCkPf9aePvWu9uud7uA+HlBI2VAIe+QdBx5IqRiVY0xBcoZJ+aile
 re36aiCYqlv6tOhmtLGeAMG3VyruxcQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300091

Remove bt_rap_attach_hci_v2 wrapper API
which was added to prevent compilation error
in individual patchsets
---
 src/shared/rap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index b6fce8b54..09d392e38 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -206,7 +206,6 @@ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 						  const void *param,
 						  void *user_data);
 
-void *bt_rap_attach_hci_v2(struct bt_rap *rap, struct bt_hci *hci);
 void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci);
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
-- 

