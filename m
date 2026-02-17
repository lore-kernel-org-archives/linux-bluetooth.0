Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67CA937
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307264; cv=none; b=Fv70mVgu13FhnDFN9fUi6UJgn5R/ZaWWOcpmQFcf8Y9R4Nikez4T46A7bc+R/PPnB/fWB2W+k4NtE+qM1+xFwKqmdyI7jtraZAreRcdveokBIJ81fbIqVVb/wt7RWKHkZEHNyN+mynuTaDXKq/AkdhvfTUd/dp1DLB4u3JeghNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307264; c=relaxed/simple;
	bh=LxYqMhSYS/MAZWI7YVw2U141yZfeBCuS2fpIrU1nMqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eyXW5W3iEFtdnN40+98XCv4vaYxvn5CthL3J0K5URl0bQx3ynYM/fxg22fhI5cXXHiW+ccU4/bkfo4/kJhUVRD5G3vygO88Mdi/zByKmjC72kmbYyhi57jMTn6YrrtQ+i4AHxB43MZNU5uMe1rOPDXLR/+7sjl8lBKKxikEY0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jEmwO+hU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WHacB3dG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jEmwO+hU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WHacB3dG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GH4sdV985650
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LJVSnaT9aLHnBjg/uviI6W13C9foF2N7E60
	7XixbRhE=; b=jEmwO+hU1iVJJuS9+Rje3yLKjzMKWjQ5A0dDawRYvkwkYBPK8Qe
	Bii+DaE+ihhHfWKgKJ9GMXl/dJ/e/u58KxnX752iqwbt76PomfZxHxenWmInpgrU
	zdL5as/K3IuIx2SF8iN6GDvCC/boQchz84BS7x8hrF+ZEK3nxzhM0UsJx27QfY6Q
	U0NMZym6Y4XcnYG6Sq8+LDSHHw+INA4TqTWXAhequYw7S/e2Foj7DctXU8kf+5ZY
	P1wb5NyfwSq0lgtPUqJSWkx6xi7Yw7xqM1OICa5iAhuBufcyigmqR3L/Yq4Fob56
	cOPIE8trJrYi5WstxLGfx0IMvGcSyMe4TCQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap16j3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad5fec176so45541765ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 21:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771307261; x=1771912061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJVSnaT9aLHnBjg/uviI6W13C9foF2N7E607XixbRhE=;
        b=WHacB3dGC68VjfZzw0bP0f+vqipP8vPTVJ5xkZ6m9vwNwSHiI+TLIJcvHK9qJFy+cR
         Fk9y5GE0ln7O/5qoObFu7shM7tXDS60dZsjFSfaBvjXOg8LIjkUz4+DU8jrnszhVybJI
         HwuEcyxFz85ybYM9cMdHp2zIQY8GWmhoz7wwrvQFr8e2Q4tlhmtrmAnGoDA6Jzzp2NqZ
         SoqNnpNv9oP7n4644POm68KI1X9utAURlDp0IQtwbMp8DTkdOI5KmyeulbQiNdLFOPYo
         FhX4sXcikRQpdpz8idiiNrZgQx/D4yWc7tFjT7WgKDRMiaGPG1k9dtXm/0pak2vE6O66
         aYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771307261; x=1771912061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJVSnaT9aLHnBjg/uviI6W13C9foF2N7E607XixbRhE=;
        b=G6iYldJlBt67yZ64GK9vb4i/IbihLUwR5XEd2CVJA+gUz5vAiQtQGjKAsdzv+EKWpI
         znqU66uSTN5gMUJFXqGPcTW+JGUXFBzoevn2GoHQNnIG8aB48NXwHrm1qF2ubcLeCUvZ
         +dEiNCH/rpsKV2E38AMEzP1P9bhk1Ym+RflfC5cz1e/O+fMG9lK5gSA+GnvcAUCfXwds
         905ym3mrzOCFYN6OK7bfqMCqpFUsY2iOpSolmasUtgHYGAn5lGDaWclS6uyZNiq8ybUF
         KBcZAzyuaiPaUEGjH2rhhFMuk34h+Mp1rFW+ecDDwyyMOUHB68BYQIpFTWVQhuQG5WDX
         Oygg==
X-Forwarded-Encrypted: i=1; AJvYcCWiJH7j5/Ww7wJeIWhv8zYziHrF9vk7bVTaDwABIvgmvsp1jZd6Do6ChD/nCMGuIYfhXkA+tJcnSn6nFM7TNJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPFHqWmk8ynueuOyj00j5JsR+8Sedxrc8WtGZrQNVp81569YU
	lra6u7o5yKnI8Zo9UPGhe8Q6sbPD+caXM1MplRta/ovmHXOLfYaMEvEQxYcPhHwXPXRFxoTHAOn
	FJtFHwjANBjNMeWYWWTAAk0vEOppZGrOzJShocAEgkDiYrU/Qku9/n3SrmzqNd4UEi5wWOm4=
X-Gm-Gg: AZuq6aIxWjd5pFD41pT/YXX816Z86s0V3x+7Tf0cQ4H1bsSaBMRdxen6BuJujgLkfiL
	P3Jj/pJfbBe8BcfL4TCwBcmsrQUpi7Hu1LX80KahyWtkpd2PWDvDZ+ySNSJShfHzD7Tj+wNORFg
	BKKKlhTqWQa5eLepuXBVauUg5ETfccU3D/cWpLdU1pUgT2VtBou5S0Sy/yn5494EOnQu2GCnD9e
	5CSH2tfyeAPF/XG5l+gDUWK2FTFt5dZ6PH2FPCbJH7NzIlj63Dj4E7pVG05kc59rzyRpvbRMwxH
	YYMHSUaz1Ic0LZjex73MUE1uG6/Ynjl2lAvdFLPSn31ZhyLJZu+jZ0t0hIqnnYahPZemW83McSY
	CHVJziwxkhBm4kBJzL7LCgBVMjKoIKtQ74fJoPX9TW0yYdLZ4pUo=
X-Received: by 2002:a17:90b:55c3:b0:356:268f:4fc with SMTP id 98e67ed59e1d1-356aaba0093mr11858772a91.11.1771307261306;
        Mon, 16 Feb 2026 21:47:41 -0800 (PST)
X-Received: by 2002:a17:90b:55c3:b0:356:268f:4fc with SMTP id 98e67ed59e1d1-356aaba0093mr11858751a91.11.1771307260843;
        Mon, 16 Feb 2026 21:47:40 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662fac3c1sm21429775a91.17.2026.02.16.21.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:47:40 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Cover letter QCC2072 enablement
Date: Tue, 17 Feb 2026 11:17:29 +0530
Message-Id: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NiBTYWx0ZWRfX1GNU6BAo+Cc9
 en6KL7n9w7ZP2WPPnCQYEHK62Z0qvEaL0W0xoSWP/mLnGpuSSBzmFbpQ4tmQ7GkwC/cZeBbFnpP
 kgMKz1smLJr2eVWnKb+Dsrk8byeEcyGJnSxZlV0KqFo7Huf1G8MYz6p+Z0J/ylLZuYaKBgK6tky
 rruTVpQnxsvoElIyopmGvsDQQ10lSPQxFsnCV2XQbtm7zp8zWwBAT//hKOaldkYrZktx0P7Vgjb
 T5YWx4Owctt1llBr+3TwLVNaow1U+ZEXNRVx5xiDewIKdA6QS5gwWM/jCRXQ/mdWSu+54NNpsem
 72cfQLDbBnYAXTojQ7wujcR9DE6xBtU6Bg/hqDkW0VtPTNYqs8o4iTAkDv7DlEbRNROZTww9ZEE
 9eGfgfJdQpkwIEtgXxZSAQ2N8uYFOPIsSI2CcBxAWA1F0rwZtbECYPvU1+GXSdXmIgp0KK/8r15
 Isgy1Icdu6aRLcvVFWA==
X-Proofpoint-ORIG-GUID: JTcMCChYPzxT0pcBXEe5l-hHa6irUZ-s
X-Proofpoint-GUID: JTcMCChYPzxT0pcBXEe5l-hHa6irUZ-s
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=699400fe cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=cq3e_Fw05WLFSlW3opoA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170046

The history of the patch set as follows.
v1: First commit to add support of QCC2072 chipset
v2: resolving review comments to sort the chipset in the switch case
    and other files whenever possible. "qca_btsoc_type" enum in 
    drivers/bluetooth/btqca.h contains all the soc type which need to be 
    enabled for BT enablement on the target device. There are few places 
    where logic of framing packets transferring between SoC  and Host 
    depends on the which generation of the chip it is, refer api 
    "qca_read_soc_version". So It is not sorted in btqca.h file.
v3: indentation fix and "qcom,wcn3950-bt" is deleted by mistake.
v4: made a separate change for sorting chip name. added new schema
    for qcc2072 dt-bindings

Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>

Vivek Sahu (2):
  dt-bindings: bluetooth: qcom,qcc2072-bt: Split to separate schema
  Bluetooth: qca: add QCC2072 support

 .../net/bluetooth/qcom,qcc2072-bt.yaml        | 48 +++++++++++++++++++
 drivers/bluetooth/btqca.c                     |  8 ++++
 drivers/bluetooth/btqca.h                     |  1 +
 drivers/bluetooth/hci_qca.c                   | 18 +++++++
 4 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml

-- 
2.34.1

