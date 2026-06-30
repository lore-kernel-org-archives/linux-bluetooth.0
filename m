Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141AE1A3166
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826797; cv=none; b=RJmjWKVZM8LPlNGNSiHz+WCQUoypu+AtdE8us9TGvLQ5I/q4Gn8lHjPk02NUM1ueldxnKcrp/dWWi9hX7BL87mVP5hxdVt+tp2WlEDSNNBdmPzQyRXZcj9COxV5vEQToLmb9ijAAqA1FLUvgPhhxjCA4c5IJoITs1mVQeb7H8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826797; c=relaxed/simple;
	bh=qqacYPInx9b7aRj/8hmKgpFcLAPb53tehAEauODGUgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Md2x+h4Oar7uzXHtVYQdtyBbvZ/0IXdsg+FB+nCzZ0/BgL29ShD2vUms0wnIFbZjQ+RDn3snqr6swbDhN0QIIiYkUNFkgPGVAhM4C8ZpR/Lggd5V3lxoBmzgAxODf3l/j2FFpShm4hcqQ6kAD9bQotErBATj0ajwkBEXDoZW3kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IcdlxxlI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jf3FA2Ej; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IcdlxxlI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jf3FA2Ej"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n1821573371
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v/YzTiy542j
	zpUYmigP/NsGd0p6rdDPtGAw1MmyiOSk=; b=IcdlxxlI5hnQLyJOsC7Vb77HDIw
	+SFxQVgkWIBQym/3tzfSHEnBhOFkpZjaT7VcofREWckxwJYmeLn3VVqFH/T/3WQM
	ij+5F/IoNNi3i6A34r2IXXTPlM0kPiHqXHrWopSftGOA5mqqg+1WVHv/s7bpRAf+
	8QbgS2ADrVW+EhLhH6jAs4WMN6zUXWEYCQEaDFziOh1wbXEadvxlrjDA7wRBcped
	+cmBJCDYbmTxDvp5NKfevgF+Fnip8ZIxys4OGEoPS85RUSoo4WrnKfznYjdHhUK/
	tLXNO9n9euhPVm32AovYncoA00gqgvE1Cn0LAXCYvVcagCn4AdshSwKmZog==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f46862fhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c42d96713so3162698eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826794; x=1783431594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/YzTiy542jzpUYmigP/NsGd0p6rdDPtGAw1MmyiOSk=;
        b=Jf3FA2Ejz2yIknLrTOtPvZdbjF5z02dSLZC+triEpMuWoNcVe3De4v5ry4/Ue3P82n
         pgVqBAnsBrOrarSMiEyTPQehEMEYfr/ocPe+8RGNu1NXxwTockSPuOCmjdfG0z6QJpLk
         aCc4dW+aVoJHzAnsz1H+BAjjqFG3I4fIWUgc1fxejxXgmQk/oImtIzvT34ZYubGi+srq
         rErVMeZ1+z3LvHN/FZ9/5Aj9cp2/WHu222z83rdIs2rrPTx6VSPneD10AI85YAPpDhN5
         1rtzElGo+eHoyh3O8Tm/1g2tm36+xWsFoBuo/aifR9iBp82WHbIGLr8IgmDfnkQrnyty
         lOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826794; x=1783431594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/YzTiy542jzpUYmigP/NsGd0p6rdDPtGAw1MmyiOSk=;
        b=rPyEgnOsTRDT7txHJahRMmfvevzLz3MXKyzFpVdCz+UCzklNIRnCQHSUi6xQWdQ070
         URGiZBKs9HciAGEitep5eKB1MSZlhT3BcnL4di85v5p12uXxZwZMuHJKY5UmPqM1/van
         ySLK4bR/AUpfDS/JY47ejvn4Dph2Il1BuAZHcAKikiw9UnBILXDtJeWUzwYwGwPE7ZHs
         RYYGLPlcgFtnpU+3Shhougy1oDUEPqKablzHJRgWy0gHO9D2k+/QRlMHKD9a7L9cssBp
         NAkaist4MmVJV7UnD3hQUUrjb4OraT6q5RMbrrJyvwHVTbwiwNTOi0y+dKok+3BJC2JZ
         7YNg==
X-Gm-Message-State: AOJu0YzqGz+FNRXbuPKv4KKGh7ABOHpg+ZVpKwMdJNUNGwgxxm0Y6ass
	zYWT30stJ3M/B/mp8VdV9lrKNphDXRxm9O+fFsHy5fztngSM8C/4WS8710Wo/6KSv64z98BQ6qB
	w6qm2MwVQGe2tkwYFHsvlzDsHEiNriJYvzFicyjiJigdd3QrHLWKZ8c8g+OdJZKsDxPPhZv3IhS
	IAFoI=
X-Gm-Gg: AfdE7ck2G1yDtjtnH4s53Gm5P6Cr5erDasWzQms6IwDqBAShapADZ8mOdwq+IlXm3Xn
	SjWAd5if9pKGAJpcvjcbsl9Vn6zh1Ej2mDmKYwIfdE5YcmAad51ovQ8uWe81UdxwVg9d4jqJpXG
	hrSLEwP3oFOewfjgV6aZSEewFW6guCpu/SJ83eu+KiHON1GcqYENoBMGrK/JFmd53L9S5SAyC1l
	OKBtsfHhoZKTv9oSrKRb/I6Zq4GLKm2dy5cgoSqXX/HLitxxYjNFy7p26cbT50ViQoucgWwHqXT
	LNq5fZ8W1JYlWl6FtXMa++BCUsI6OfhXsFOxNgBtmsfykCOy/m9JFJdOmeG2csR2ZZ/IW7W4HsR
	+VcM+uXZZ0Z/3+EPB8b5yVtaOzP19tBrHC9pGztY3
X-Received: by 2002:a05:7301:5f16:b0:304:b93a:5107 with SMTP id 5a478bee46e88-30ee1409e45mr2831942eec.21.1782826793928;
        Tue, 30 Jun 2026 06:39:53 -0700 (PDT)
X-Received: by 2002:a05:7301:5f16:b0:304:b93a:5107 with SMTP id 5a478bee46e88-30ee1409e45mr2831918eec.21.1782826793412;
        Tue, 30 Jun 2026 06:39:53 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4dcsm8704158eec.5.2026.06.30.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:39:53 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 1/6] shared: remove default settings params from bt_rap_attach_hci
Date: Tue, 30 Jun 2026 19:09:35 +0530
Message-Id: <20260630133940.2461816-2-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: xJ0HHK835r0y0OMlLkmR7SQ_oK7Vwc9K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX3h2XK57Jrvmz
 rogz9ahS1sIUv7D1GFPD2qHfcEnr8E/b46Pn1yps7c5J3AKsnkNGXnbJXd0dqYT8HUVs9+J8bpj
 uZfvWCZVi+x0PTMhtmamJme3zh6/ys1knpRviYgUQagEGLASVcaq6DE78Z4dtvv0/pxEDx4t1Dt
 +sUZv3uYjkHYcJcSgpFfyUx9CvpDmj708U72hvf7vSaxenzow4UEss9bla2MZ9cG7o3sW0UL4iu
 2U7qb0E5lzh72Drgd0n+sKeZdHwzyzFW5H+texO2bpwgOpA+ZFqxHeylmJfBSenqxFZZbQaAmmE
 bz4uNXtChu6BpAHb6tQqNv9E2mYWjU/1LgzLb19I5FyvZb1sQR4H2zbzh51PtjGsMMoDLtBlTYP
 QfS/IjitNOawxZd6iLejFHZ40Zx9xIs3yuiAWAlE6LnX7OjK7jcb3+fxR439PJNhZkdKs0lXUWO
 fSsUEK41lVX/YoD9diQ==
X-Proofpoint-GUID: xJ0HHK835r0y0OMlLkmR7SQ_oK7Vwc9K
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a43c72a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=Vx7h6rt6XKWriHlI81gA:9
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX6Z0Cgtbye2q5
 eEvLkcxr94z/+ZayyqvGiKtpPSL4WkRJ1oRetrWD2Q9UhJeGyPJtqZ63kXGC/fJJyf09GIgUHSv
 DRR40Nzn/ETMKpquwVqsRbBegbe5fxU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300127

role, cs_sync_ant_sel and max_tx_power were passed into bt_rap_attach_hci
but these are CS default settings that belong to the measurement session,
Callers need to set them via bt_rap_set_default_settings_params() in
start_measurement where they belong, alongside the other per-session
CS parameters
---
 src/shared/rap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index 7bc49f03d..45be14dde 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -206,9 +206,11 @@ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 						  const void *param,
 						  void *user_data);
 
+/* Wrapper to be removed */
 void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 			uint8_t role, uint8_t cs_sync_ant_sel,
 			int8_t max_tx_power);
+void *bt_rap_attach_hci_v2(struct bt_rap *rap, struct bt_hci *hci);
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
 /* Connection handle mapping functions */
-- 

