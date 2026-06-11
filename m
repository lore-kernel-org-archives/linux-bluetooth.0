Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59553EC2E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179278; cv=none; b=Kj1wi44ko65qNkvSNTeAtA3VeWOuCxm0ACqHUcDOfLVDqeuxu2IfOVQi5TgQtzxBL5N9T2WTNE4yIOV3dSzAp0KYS97UYt3eHFrHBP8mYrAo215XaXde04c6kTIIwWRGU5oYcfdRBfOJNQd1pPMbT1AO2IR9w/daUvkO/jYoDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179278; c=relaxed/simple;
	bh=Ypm67Oa3Qz1AnbUCKlTqdEkUTO80pQaJlM1PmGZ7xKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIbLuy4auqn7deBR1k8crSff3rz+PaKTcBhceK64QoD+xylpsO76e+iCzSBgWP24CqQEgdcAi3Bl57RWiQohutusCdT1VLyT8FfJvI9nUCqH9MTm/Xe5XXC4uBu+9HU6fq4avFUOBFmtNI3yobcQSZVND1I3Y90B5v3Xy2uSWQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EPZdy22Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZjjvrO2C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EPZdy22Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZjjvrO2C"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9x5HF267501
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=O1d+I0RyR+8
	PNKGAiAw7I4gmFqUndNxm+5VXKWUgkWE=; b=EPZdy22Yp0PY0PfReJ5e9hcathx
	S7rjKDRLqSeOKvwtIQA58PyJGxC1Ma97jwpu7kdZwHDuoqCcVjnYSj3mrWrvn8hn
	sCdJznboHGFoVcvDpgpXzw/BC+aZVGeRtlr5Tbvvcochg4nOoIDZD4MWb4n5pgAH
	w/leBUqZUmWe4u3C8JjniX0dssgUpAjz3LE9wJkE0+t859rqLaA9dWNv06ooKqWa
	5iu7zzU4nU1FsRfKa690qfV0XiDCfGbJYOeXHpL0UmiEWdLhLgZ0RO6jn0VBkCZA
	hJvhiGGgP8P+GM1z3U/3anYf2WbkqTtLSH92O+7CWahvVye28JnGJ4u0SmQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u38g8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36b7f696b40so4879167a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179276; x=1781784076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1d+I0RyR+8PNKGAiAw7I4gmFqUndNxm+5VXKWUgkWE=;
        b=ZjjvrO2CqWWXT/MUAYCB9ZK5t/ZfTUELIQOpI67qCA2U4DUGlQTohcHHaNMLTP//Bd
         0CpRoE5Dw56GqVbYjBPNJs3WCVYTzz+Mn3luUPZHuFLEenzJDc8koAOaTbieYZ3rWYhf
         HPmlui0yIyqhdpvCsyXZocXZA2NIO82pEUciHJW84+e+jx2mV3H7enoKPNx96p8BB5Tt
         Jsfq3bLj94jwoleo3ggtNiuEswRn8Ib3P5xZAbav4Lj+dEsxIiXNeRbtcrNnH/7Lf3Cz
         KHG+TNmmdOF4kNaZba2qFzLNk9lY/83d0kFCCOvpC5iZ772VWZI4zLDXP5pP6rejAKRk
         BdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179276; x=1781784076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1d+I0RyR+8PNKGAiAw7I4gmFqUndNxm+5VXKWUgkWE=;
        b=fuJErT1RUWa5pt0PKnFk7Hv79JZR1KzmWIxGehj4H+M8k7GUHyFxXdRWbOShbmlmjb
         iiMYKJz+MWNGggIcvdqxivZwiToemtYPn0dFAA3xQaHXDe3nxkBinQJCYwW7ZNPPBaMz
         jomBlaswoW0HAf2Zj/0+Ap9RzO25R6wQXzlraae7YANSWybmgvqdpPQ/5t1mhK4bKCEW
         bd6GcjGSFhWwbiqyTwDLtqKD+kdLhrd1Einhw47irpyBBEbE66LDHlULcDTezAE2hg0u
         o0duv7M9jHOp0JEBx7T6q8sNkHn1poiO69UVwlvntErmKLKK6+4X3pCN8odVvS9Jx4Bp
         Y4Xg==
X-Gm-Message-State: AOJu0YwXYuXy4O8AnpN3zdaFsOvo6leb/nsSN6kNGoanJoyzqgvmHv/E
	COClqePrx/4aco3Aljq59dC6hfMQFBqhucWPmQlZNKkS3sRzxTAt6xnII2eBTvuNBjua2c3Dsns
	FhXZQw7rUUachb6RkPZxfC0O4MjVGtM+gTFH+G3r+IiUxrqqSuO4Flvj86zi4Rwotc/Tqo8jVu3
	YXZJ8=
X-Gm-Gg: Acq92OGA/k6Gfva8OqLmi4STBNGf2I/IrKyUD+RrYdsoXcuFLAoVb+4ee9zQn1Pwo50
	aWQM/5jeW0OwkJcieIYJWse9oq1UAAEhyFsc9IAlzYlNX1iL/PmQjRAWqoIgK/BDIDiAFQMS94r
	RXp0StWtF0gMMYGBeP+yN7866hxV4W3wTye4J3O/ZeARJD06OczA4n2LAzi7tDMKHhJWoxejPY4
	irsmZvprwma4hUNAbWsRmmzZ0lA7C9NoHJWaqe9eXxwE+rwLtHFX7yAUyfV5IVA04nsdUn5TYTz
	WzolJUkoLTSnvtWCJcTcuaApBsIcgIjhJ+X2NmdOjrblQIoNDr49lNU0FrPCUB1P79RnT2hFx8q
	Qoti8pgf7ezmv8w9yOdTOlDL6sPMcWTAvNQ+pyMezO5kIfLrTOebhgx6SqujwlA==
X-Received: by 2002:a17:90b:57f0:b0:36b:71e6:3e01 with SMTP id 98e67ed59e1d1-377a4d95a42mr2854375a91.16.1781179276229;
        Thu, 11 Jun 2026 05:01:16 -0700 (PDT)
X-Received: by 2002:a17:90b:57f0:b0:36b:71e6:3e01 with SMTP id 98e67ed59e1d1-377a4d95a42mr2854303a91.16.1781179275643;
        Thu, 11 Jun 2026 05:01:15 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37755e5c283sm2437402a91.15.2026.06.11.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:01:15 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 3/3] shared: rap: remove the old wrapper API
Date: Thu, 11 Jun 2026 17:30:44 +0530
Message-Id: <20260611120044.1641009-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611120044.1641009-1-naga.akella@oss.qualcomm.com>
References: <20260611120044.1641009-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: swaId6EJCFfyjVjiIgS3mKWF-KD3PwXg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMCBTYWx0ZWRfX4mYT9W7ygXOX
 /Lh8nH/eAaGTe2A6Wu6RuIq9LF5tjNUehB/aYQcGAhkdF1DGR2UG91LCqXixxe3a6C6xyv1wCOk
 288nllJmOr4e8jeoVGeUALlXi8isfCo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMCBTYWx0ZWRfX9Jx16Thw4flB
 Q+zk8Y3U3CNnPPFaHaltahw+9Nc1wAX35cbCY/0BsTn+EuJcWopAn9gFQYzTyOcOfM/Ewpj77Kz
 h6tNhEvDPi/L01Z0Cy8LVe8vGjFdV/dwFCgaDtKAxTdNELjN7idqJBeGWMr9SoxRhyB82OkKTCU
 PSfGUubRoIOLdvMJW4qLlXA8sltpX4Mgg+OMymPu+qSraW7CwMxBV2jymggxSq5gTUwgXqgW6n8
 24z0AebuG6bRC5okdpxNmfn/5j7ngfc19t+S7UXrHS5Oj0hACgqsViTe35rjhdjGXuezRaO8/yG
 HoEj1K65lkiHEcHjI4KD6doPkSICPZfzgUMKSzLxP2rdMkxR5sDmk3cVe+ZockbYlKAPtuucO8w
 bXhvt5IVvBBodVn0nXoxEwdDwwdVeqWAx1njSbitBWpgp8Ug7olzuRnuEo1TpNsfMtqBXs6zHkc
 O85p/abvdaYTzBFZ+FQ==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2aa38d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=S_ld5syL9isSlWfUGIQA:9
 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: swaId6EJCFfyjVjiIgS3mKWF-KD3PwXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110120

Replace API bt_rap_set_conn_handle with
bt_rap_set_conn_hndl which has extra parameter
to avoid compilation error for individual patches
---
 src/shared/rap.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index a5095aa35..619033d7a 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -212,10 +212,6 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
 /* Connection handle mapping functions */
-/* Old API preserved as wrapper */
-bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
-			const uint8_t *bdaddr, uint8_t bdaddr_type);
-
 bool bt_rap_set_conn_hndl(void *hci_sm,
 			struct bt_rap *rap,
 			uint16_t handle,
-- 

