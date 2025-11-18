Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC35302CD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474657; cv=none; b=S9E07QnjA7FDH9oSsbISwfbW1h8xJJoVf+hHZG+sogNHXp4onZx0Lpk9L0zP8PSdCTqkvyhxOoOEHbvJlAU6g6OyvgMWlcZRvN3bp40PTDI5u7H1DPMScEYiYhAFt84V6WGgp6zYuLfwerMzs9jRFFaR2ghRb4wc2Ejq9iQ4oiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474657; c=relaxed/simple;
	bh=eivKH+bThhHIx+nrmAYaplfsILqcdjKBqOGsG4tirSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C4f+ArDCBM23DI9lpbHDtfW8fhzTvvQTk+6GtqQQ7X/AnbV6c3ejUX3qAoGdP5pc0G2bTFpMYwBD4Qg9KclWw/9kpFExBhX2ShxgGqULhxHsfiAimiL77pdYL8n1is7f4GT8I77kWYDVvIBTewzbDg9Mzkx4kv/sW1X6O2ePuSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AolraFiu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dv3f7mji; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AolraFiu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dv3f7mji"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8E3nD2194538
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uHYxjskzaDZ3AQkqslYYhIoAw46gvy8EwCz
	PW9HpHgs=; b=AolraFiuPA7eUxSVtzIAj4acCUraUB6bbMifssolfSyqkH0oTxt
	TtDca6p3ZHoUOI2Svj1XcBaMx41Qy5Q0bpFZIxL4StPEE2VXg7xaS7GkfaAnObPB
	JAce0/UlUT+4K+i4I9zaQz61UT+AgqIRjedSbCJWr+2QuVAkxmbNbiaZQMTj0/jI
	S1jGPfl+msABvW9zt0/eAJuXFY72Gq1EHFdw5i/ua4TkBvxfsWLMT+/7ibsK3Trs
	JVSvadurBPlW0ZiISgbn1rZD8SRoQg2S1JSziF+KYgClKbO0Eo6WfH3XVHs3P27W
	3e9LThnqaLcqWcbjEnZWUuIABkoBWFjlWyg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agn3y8yjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297d46768a0so17362105ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 06:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763474654; x=1764079454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHYxjskzaDZ3AQkqslYYhIoAw46gvy8EwCzPW9HpHgs=;
        b=dv3f7mjiXVN8XtrgBNO93r15znCXik49/uSZd1/WdHS7bBo/zY70a7eQzKFeUbg28N
         r2ll3tY+fRVQj31bDMsbNLogicuYagS/D+mX0cJBbtzNUa3LG9yLRZEESj9s3U+niVUs
         iVCSpJ8DdTo+aux7eGEs6Nx1VEj7liDXt9DGgdMrXedU7W1VsdZE12Ecxq53AxdnICPV
         qCYSh4Z9gWEEW7KqkuumJNYtPAFtbFGj8rTtpKAM7eBszVnXD/o5gdR6+cjJjauXtqaL
         zkyZ7lL90WoOwV79XQNoq7aeSiMxoyv7KrgjD8iQQwqiFo0mh1gkCiwST/8R8/qqfYkx
         eLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474654; x=1764079454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHYxjskzaDZ3AQkqslYYhIoAw46gvy8EwCzPW9HpHgs=;
        b=HpAz75DcIYNBQzE62MMLQVJU+KELYf1swX5GNgsG0Byhqs3/ZO8hecnylu/RjQtyTZ
         D3bhbzZGyZHj4wggvf3IX/Ox7mOgmmPEmvZOUu2ma8Aq5i5KJw+22RQLYvyaJ4eaViH0
         3HvwpaEj9jgLvrER7pLtMuxT5v0TmAuPtV3qei9Sxfw8IzNgVI1YvVAQhuBu8b04vCns
         yBqkQ8qTI2c1K2Gp9qMHAnS1DctMAzNV+BSuWa7FsSK1mhJJSqxzOxTg4tUqt4z8vN6P
         3/KTYCY0oLx8VQUfLL282PLnxo9JgVX3RmHmQxSdggpR05ieaj2Gyaq5uTtpKANkuU/T
         Qddw==
X-Forwarded-Encrypted: i=1; AJvYcCVEBKFJ6NpiNae3S4GfL8G/Pi6HCeZl50/ySEYwdfjdWmUlc3YHCE148tL0awSMptd/5nfjZ6rGb6y+yl6RY5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBTzIpxjb6UC8Nq2xVa8CGTBaG1t1O4s0tZ3VV9qzyPOKgrx0
	lYIZGaOgIsgw22BLMb1q2tBc+1T4AScxt1HMviGqBPXkWoY4eOaPoWxojjbNsSieQ2XligarbGI
	OuZudWFaJnEoDlDgIplT9EVNnHTjqrUSwHRlDB98Pj099rF2ILNGWYWm7HBPBnXqi3K3nQDc=
X-Gm-Gg: ASbGncvNwcCxgtpOw82wgM5584KU9mwfrK2BGoaQTp7e7F0bAeB8tBrtU2x5NO7Ha2Q
	WhceZSJ0WXc4l/mqhFS8tESCi5u3gaLFc/5fu1fcHEUPfwN8785onsTw604hPA6HRkF6pleFDl0
	6YWnlor3F3iIcjlymxSXRTTQ9C6fChsSV4+K8tjRQ/rXk4LyGaL5RnwdPbPkqMNyoc1UyEgaRAq
	XMoZL2RkYsCXn384nYl0JFmK3+LzjGRpz9pkizlTS+mgTTSQw9BaHs+iSQQ9wI3qteIDgnkDyhL
	GDPST1Fmwu/kPTmsJ08rkusifHpaoZafrGSLrkQKIbG4WJy9vkmGRP5EhtBJVsqZBMjUpy+3n/Y
	JLuSzs+DFdWQYUK3/IUDE+FackEyQDtRa
X-Received: by 2002:a17:902:c404:b0:298:5eb6:8998 with SMTP id d9443c01a7336-299f655aa90mr19058115ad.3.1763474653890;
        Tue, 18 Nov 2025 06:04:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMG1GyA9Vp3dG2icF2IS9EZgNfW2wZwVLWZrzxeSFWMbHaFtQD3m0nI6ncFpQuuS5iZ4Yw7Q==
X-Received: by 2002:a17:902:c404:b0:298:5eb6:8998 with SMTP id d9443c01a7336-299f655aa90mr19057645ad.3.1763474653120;
        Tue, 18 Nov 2025 06:04:13 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986a60b116sm142957695ad.79.2025.11.18.06.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:04:12 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: [PATCH V2 0/1] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
Date: Tue, 18 Nov 2025 19:34:05 +0530
Message-Id: <20251118140406.1551669-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDExMyBTYWx0ZWRfXyKaaXSsFmxZp
 yrsQNIM1bAfsMbYgd4GgglSA5j9K3QzLsoUmQJd4+NXAWBaXV8m6Fmj9YPHbxSvr55TX97GQC3S
 7wtS6JxljUgJDOVEhtKPljcZCl/EMVOaDQKuMkK0gmHxX6Ed4d0uCBoAOCdI79ku4D1grKgtGly
 EQ0IRgl57xcYTdbakXr3LWAIxT8lp4KgwY44v1O3sDre4c2nfQVSLcOqbgC0CKKP6/hBUseG3bS
 wECFJ+NqGlDM423mmhCRJMyTlfeMKwWEvHWDv28QNnpX08TEN17q5ZF07vMWVbH3aXgpz2pyNHK
 M2wfHKulLZ5pMZGbwu7Sr6/Y8Lp239TitWKetofjl0vQJz7oALWLKdxUnv889hgr4uhVWSHhiSD
 +BMVqiYLW+rGZ/bCEsLczBrTTRGG/g==
X-Proofpoint-GUID: ft-kFqpHGhFT3J0bzcRtG_Ea77A9wipw
X-Proofpoint-ORIG-GUID: ft-kFqpHGhFT3J0bzcRtG_Ea77A9wipw
X-Authority-Analysis: v=2.4 cv=FtIIPmrq c=1 sm=1 tr=0 ts=691c7cde cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=R7mCYRQwjcki8tQcZRYA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180113

Changes for v2
- Update commit message, add firmware name detail
- Reorganize patchset
- V1 link
  https://lore.kernel.org/all/20251113130942.2661069-1-wei.deng@oss.qualcomm.com/

Wei Deng (1):
  arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support

 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)


base-commit: e7c375b181600caf135cfd03eadbc45eb530f2cb
prerequisite-patch-id: babbcf9dd8722e19d91b01eb45756f58e58ba6ac
prerequisite-patch-id: e641f09d4139ac77c34757bd08af2db746de3963
prerequisite-patch-id: f5dd3ee9979e2a049badfb51cfab184da4501870
prerequisite-patch-id: 40187dae2c9518a10866104b9fcd5a481ac67d51
prerequisite-patch-id: b9a2e071f5ddcc70dbd6addcbf738afdc9283cdc
-- 
2.25.1

