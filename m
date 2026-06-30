Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE53E7BA0
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814336; cv=none; b=rWLrSePODyVn1gsi1Ln45KZcGU2DjS8LC0+4I24G8Rkw9cr2NccEjcxw+H7oj5oh9zLiDLIunZQzmf3FZgz3rW6jMVTeLRMC2CJN7EaRQGRzzOtcyYpb/R/MX3baryZsjPN5V7NcCA1TfFU+ytpMvQOBMHxcUJwPjqQ+0FUYyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814336; c=relaxed/simple;
	bh=qqacYPInx9b7aRj/8hmKgpFcLAPb53tehAEauODGUgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9pre3QkstuV2f6QdiYUlo7b+KOWhXFWSX6xcunVyT0h9o2P7UOjwWq0Dd9GpR7QYhxNl6Tr/iNsCDPv5cwTtw1tHVeVr2lNdAmsp6V3Olz8BOwZ3Aeusi79DLiCc/d436Up5G1pk37Tr3Bzsn8Uyv0dd2wQvu2SypB8nuj8CeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m5uann8C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MiGHeu4L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m5uann8C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MiGHeu4L"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9moae1541521
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v/YzTiy542j
	zpUYmigP/NsGd0p6rdDPtGAw1MmyiOSk=; b=m5uann8CFwHP55WwfUBCfDjwxcn
	iBvFSvDdptVKd+rPyzxHOzQXt10kZEtTWojeZVG956y76ewf6G8iaxeaWngQ+Mrp
	Kr5Q9myurEIGtIgEV82OFhBn52somXiwQMvNU3mXcZApxWkw7knMEryWN7SbUgWr
	ZNACfFBEz4FSizIaTRRMclT95OTMeka/Z8NTM7VqhQRZuAYveVSsty0qyiHO3uH9
	K0ELA9uoLk1big950MuaaUkwFoNLqVa32n9F1iyn5BBlZKq+/fPOWh99rgESY+nr
	BDKS1s2F1Qk3UM0hdk3DaDijtTVGpZ/MMSYv3ZpyN0wF6sC+tDgpFiSPUpw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp1uay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:14 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139ca26403fso3440552c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782814334; x=1783419134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/YzTiy542jzpUYmigP/NsGd0p6rdDPtGAw1MmyiOSk=;
        b=MiGHeu4L6qGzdCqZdqFB7htWPEkW8AY/FMWkE7GwgtWwrA+10mQiOo28tSN0sZzZv/
         sUug9fD1KLLBf5SGigh4/X1aaG7BTisnkN7uMh8i5a3TgYKCbANDiEBwRAX3Be3jKBSq
         M5p1tn7p6ANzExbYOL8AJUae8OTvKfpVeusocM8FHEq5wghMzryml1OtN/XcWImr5TNi
         Yj6Dx0vjUZQjl5MWYuO16vbgejEUYlrVCcbyNiLCN4Y1cR+WlZQxIsbmHcy6Wc7neVf0
         /k0NQhEODYauQbHK+RH/Lct9JvAQJ5jMNyepX5U2HWLCaByr6KLM+5WkfbNUy6Wt7RPt
         BfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814334; x=1783419134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/YzTiy542jzpUYmigP/NsGd0p6rdDPtGAw1MmyiOSk=;
        b=bSBE/7JM2Mcw0JyE4WH84dEG/a+6t0yeoayLgmsaVvadmVyzxNovlQhKvjcHvgR5RG
         dquDe37fuR0UjC5/hfb8DYdf9pxMGPqQuKXsH+s//F0vNypeyYTmbbO8nJInH2g8xuqj
         Ya1LJZ7MwUyUQOfMI5br1VV0cKt+y8ltM3RZ4uferujq8yqvPlO1v+xewbUjC3XX6rV/
         cjxxZUE0jzBaSnMozIoEFNdia5RsShMmU4RW9uIst45nt8UTlKolhvfpAl3sEEYLdO8O
         HaWMbinwWK9FcVwkdOCsqpIVgvEogUQ8GMwGdPUg4RZCfLl34rPld5RR6Eq9YlEMCTiT
         MRyw==
X-Gm-Message-State: AOJu0YyH22eXySH75V4cfzYT8nyu/tETlM42zrIZcejRJWROkXdYK6wc
	tfErA9FvjXySiIiXHR4/M8IF/kaGnZFILOtFsk11bhQOk8P7d5bIvN3nlD6b/50X0jdOpyZo9j+
	uRCy8BXJ6m9sk6Cc2Z1WkhYZDCJcXB3XwAad+d8II9xbKsy+6zRUGtIGLnAbfci35MH9GBSelIG
	Bviks=
X-Gm-Gg: AfdE7ckxdbAX6EwBAtRmVvxG3nDOaTp1IFY5eWeamrU3p8gyMfKLppjCOPWWJrQFSIQ
	1g3M7WaCHLwzvzE/r5Er13LrpxRMUsnFhMkGTbfmRa7tZPq4C9HByoHgY5ImuhGlAeBIbEdBSl8
	bj49cK3ZEpGRx04UsoGYPBe9m08HVkQpzy5rqpWFmcP+t03GQxjv5L3uzdinXu6gb1ExwOkQzEK
	pWRrrspyoV1vVc9DBvrISvWSErJh62Q+0MTT66IFPgKTikFniFlvwaOsck8HDC10mzK0corzUhJ
	FuBD358pX7tl70Vvs6Su571nbDPsuWfzALhPwn4DnYKdnvL1olX2TQVlVyJMdar2FyFuhJELgk9
	I0SlxZFPesV6OeESm8tbBEhlxuiBBcpzXlbjsAhWn
X-Received: by 2002:a05:7022:211:b0:135:5d4b:2096 with SMTP id a92af1059eb24-13b2a1ccf4bmr1636661c88.36.1782814334282;
        Tue, 30 Jun 2026 03:12:14 -0700 (PDT)
X-Received: by 2002:a05:7022:211:b0:135:5d4b:2096 with SMTP id a92af1059eb24-13b2a1ccf4bmr1636648c88.36.1782814333651;
        Tue, 30 Jun 2026 03:12:13 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba6fe2sm5670060c88.9.2026.06.30.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:12:13 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/6] shared: remove default settings params from bt_rap_attach_hci
Date: Tue, 30 Jun 2026 15:41:53 +0530
Message-Id: <20260630101158.2239682-2-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-GUID: fwpZLFHXtjTCWIcoc2NLE4P-VnUzT0XO
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a43967f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=Vx7h6rt6XKWriHlI81gA:9
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: fwpZLFHXtjTCWIcoc2NLE4P-VnUzT0XO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfXy4RXpsuJmRBv
 uEtRPpwPcdOv+7SA+kLEe6OaoGWHo1UF+0Tx1gBZl5BGN3LQszSomQhfK2xSqExf2RuvHNK7+Ca
 FmMkkR1t18HIzFLeono6SnGdoCVJ+KWnqrtwAZf5ILBlEwIL95AmIwwd0KcdXLvYf6xaRaSF2om
 bDgyyVhquEgj4GbY1qnndIlSUYWmkgyV4C1SjOC9FYZDfePSbjSRkQA2vRQXPR/2ORfCd4ozVET
 DXMXsUZ5nCuWxaQPLUpAKqP3ExAyBcvgZKT6rkjVR1GzrGupfXCHdVjnO6iKABfMaOqi7N+lT+W
 HOZgTIWf1IhyMBsvQLuGjHkjII13cNfkVODRNiKYEmZaq3RM0liutEL1LnV0L//dFeRdPke73dL
 +82bUvEW6iVGpGjdE5zvyW+LqWdURTbDlx4JJAneT6A52XtYg5mRduGwkU7lx9UQ2ko++TKQfSC
 c5WlwTNddf7eWF+xmxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX3LHhdPfqZ7he
 mEj4HkS8Ihg5EUGrfKf0NO4n8QtJeUs1g3CNNmtJCmq7V1YzoH8KEKr9X7B3B02htBePKEtwzGB
 REKb0uiYz2MnO63KhumgIqBHtpYxf7g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300091

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

