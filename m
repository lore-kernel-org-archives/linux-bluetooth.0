Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54096369D6B
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019913; cv=none; b=rPrvqk6KlnF01rXBV/ns+Vk4PdJTh8GcV9jJArAhDB4pFQeMS6ndDX7jdWSdIIqVID/sImhCkW1BiS2fHUEo3udDAX7vD6oLQ1xtVssbFVNiX68uPfh6ZidJXk+kwjXsLMeKMPeBjasBhNTZ3/DRGo3ytX4ZI6C64dre4IfiCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019913; c=relaxed/simple;
	bh=ALXcM+mZaVmiiIXY3UmsGPlkkJ8qTwNhILvaHFYPYvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EZYjoTYQ3useN2VeEMltsY7dWruAJyt2wapeBq+DRM1TY0xauFgEUxIAD2iD6ZN94cLYtVniaq4w5YvPhzZufRZ0jtMYOTs2AuuBVOfK2DbXRgxetC8Dz1DgoQwul9V9Cet6lsXV97MXVqfYjcyJpgDjq+luBbKlO9nUWZR7fMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgJjzPjW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gna0s/kv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgJjzPjW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gna0s/kv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClZKS2183117
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 15:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=D1r6W3I+xvt5T8pblkNQpOjlPTt3iIaPUTP
	TvDj9gPI=; b=cgJjzPjW3Xo/CluPxjcEu1D7WgQMi+6StIcWoBjHZ0wc7/Ezq+i
	hkwOTziMjsN73MszEWBuzWwQuHYsSiJONXevyZAHTUmuT5Is/JpcEEHZNYf+IFqc
	lM1w+SOXznq6FswtC85QUS15988QdudJ3W1ESyJmfCwWCaE9AkDBklk5lbAno5ni
	SRGgS8U7hWY1Wywm1gBXxL+8eZOg7Yd0UG+wq1pK9YOEh74qa7YG1C84Ko86npck
	YzKrGjWFo4XDfb8f5kc2W0Iuta7FvjiumIcPxJEW5i83PIkG6yvasjL6WaoQqJaR
	btZcrnYWz4f0XNUiIlAUAPXv4Ecn3z6+EHw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenra9h8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 15:45:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a2f19558so3312357a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781019910; x=1781624710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1r6W3I+xvt5T8pblkNQpOjlPTt3iIaPUTPTvDj9gPI=;
        b=gna0s/kvVKAm19RT079oJTHrmbCORI8QMi01iVwxNlBnlc4MQ7Hi2uyAHimrK7l4R5
         3BU9rBxKRjk870gwZC5XXZE7DVkXB6TNIIvA3tz9G8YcEwB9z11zoL9nCLsz2AI4u6hW
         lUK9env/0OqFfGouDokHM/xSbLOS3fn8mt/MQDWG9/rqu3vWkDgyUIFTUqLfoGo91FpK
         b7DgnNRlP2bHHFaDGY325dnzbdcQhvix0SNhgXfMA2rkpEO9ZvwARW6V7JRpKWq2gtVO
         wt59LsbokwFU5b5ZEMFZWQBgAxQmfonCkkV6KSwVDyus6GNvjeDcyyD1WDLyDWT9VyXe
         WFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019910; x=1781624710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1r6W3I+xvt5T8pblkNQpOjlPTt3iIaPUTPTvDj9gPI=;
        b=B4Kb+Ir4us4qD/KighC7bPms0vBrencCqMnqnecl1593O3TpG88YE6bBOLp1Lvo1/Z
         g9mEGYFvrSkPUKODKO2Hw9Hh9UfzqnW5JNBFHUv6LOEvkl+x5FVTz2YswchNTiiHm6B3
         yoIy+abYAGj1eiBXy1+0zuNKuv63Tk6MjbUtwy8fRoDSZsPrDDY2PsR8MySMsInwSYTp
         ve0ArOoIAhLH0kVL/TLxM6CmQKI8QrwzJxn8+yoVYkLzmrkZ5EaGsdrxgMAU3UmEK1p7
         guMynvcxsJmJKXgxHssiu66wCekMbb9m1GuqJtZufmR0P5bQolHfo/RV7l6RTpMFTTvZ
         uKSg==
X-Gm-Message-State: AOJu0YwwXF0oh/MEURWHkAqktPobjqcLOLvFWGwYBWJ1T6E6PlsjYyo0
	O85XpDs8HRh8foVi46J5iTsz7C1SOkJ4VzQQPlAsmoqXQ7RbH1QbssnC7ezVu9ECB+EnFQyES0z
	QR67+aIgeEsSeKQh85BYCR7wbh2Bafg7ppVZ7Obq+C//b7IiaMVjd/V1AzJ42uJPBpvdlFk/SID
	vPCtU=
X-Gm-Gg: Acq92OG3KOoBVtCr/gt6x4X9HNOVepT2kQ+YgpB6llFjfPhu81ZiQQbqIkpXauAfBJr
	UGiYOz68voqD0wYOCbUe8BCAUjjUIgv+QGFfflP8naramVnzz8rE8c/h7BtH9KNSh4uzE3u9QGH
	+Ey8hC4OzZrMul0dKQT00RCQpPXCjaWnP3Q6Vmn22CFzez8p2KRUrZ1uzf0yE4vCgrVgD4IDA7Z
	rvpfC6o/tgGJurrNfRgVQ08qhhZhWC88luRpuqSfrwA9VXnN7BjZ8mvuvW9A8Zp9vnAhH8fy1xM
	7JsWu9dVbsUlDZeD1PUv+SKp4kgTgEql4SqoTSOW6B9tjvKea5Q/1imHaw66GJEV2XSZMKswPgL
	OheX7yINccwPUQWMpiYdqP99yu+f5Y+mUG8mqMIjXe7znDniLWPmUBBrso7fSZg==
X-Received: by 2002:a05:6a21:a38b:b0:3a2:c683:fa84 with SMTP id adf61e73a8af0-3b4ccf4a503mr25624674637.27.1781019909827;
        Tue, 09 Jun 2026 08:45:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:a38b:b0:3a2:c683:fa84 with SMTP id adf61e73a8af0-3b4ccf4a503mr25624624637.27.1781019909398;
        Tue, 09 Jun 2026 08:45:09 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03387asm20411085a12.4.2026.06.09.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:45:08 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 0/2]Initial Channel Sounding Support for
Date: Tue,  9 Jun 2026 21:15:00 +0530
Message-Id: <20260609154502.3430147-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U1LcP8vkvJQ_Zlg4CDPwJbACWL_s89lK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0OSBTYWx0ZWRfX8HMUm2+htHbz
 xQqNvL32zHZfXwuI7dVoGmIxtVbeysdTJ3N00jv1bPoqonBzj7RI/BoMJmpfOjIPWuo9eDX7LKb
 dNwC8Zm1FfJwqEmDI/HG/XScUQZr9+7fIVUrkw9zBtNkXyZbzh9vm1HcX1qArV7St3ck6pkoI2t
 P9ssDueOBOROYCaZsgBebtvqr6gAtKCp25i9q7jVq8R991ioHbYNUeph+l4mtFhufPxMCNovW9N
 GQE+6CsFX+G4IxdHEjUeE0b1uUJ5BmzEA6Kn2YwrFIh+iVZxMVTwOyo1zaeshTfgkHp9IJ6+mBo
 36zNFfRqZd/4P+2715YspNAagYjvm0X2ftFmBjLiCAWCjvdPs/sftCmb9LjyQ2VMQTXLFEzfvHg
 nhD1ny4TdtLTVwS5Raz3wHsXhkOQZGS8GKOaY6xJIxo5ZIGgNxZayG3WNAtCoaSaX91D6wK6Lx2
 Gc4QTuAh6SQ539GAhqg==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a283507 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=RcY0gk3H7I-PWpLMwmMA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: U1LcP8vkvJQ_Zlg4CDPwJbACWL_s89lK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090149

This series adds initial LE Channel Sounding (CS) Initiator support by
introducing the required HCI command flow and event handling for CS
procedures.

The changes include
1. Adding an is_central parameter to validate that
current local role is central before issuing
HCI_LE_CS_Security_Enable command.

2. Introduction of initial LE Channel Sounding (CS)
Initiator support by adding required HCI command flow
and event handling for CS capability discovery,
configuration management, and ranging procedures.

Changes in v2:
profiles/ranging/rap_hci.c :
 - removed unused bt_rap_set_channel_classification
 - removed __maybe_used macro usage


Naga Bhavani Akella (2):
  shared: rap: Check role before sending CS Sec Enable cmd
  profiles: ranging: Add CS Initiator cmd and evt handling

 profiles/ranging/rap.c     |   7 +-
 profiles/ranging/rap_hci.c | 763 ++++++++++++++++++++++++++++++++-----
 src/shared/rap.h           |   3 +-
 3 files changed, 674 insertions(+), 99 deletions(-)

-- 

