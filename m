Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD161325483
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826791; cv=none; b=WTvICHb6/mjB+biEvK/CK5eH1b2oczROlGOUL9mAth5SmmvCVr/PrVxj9qymsg+AhM+8Vodb/CMzjWh+EIsfKobAGe3Qi8vaIBysG1VeOXg3HvgLqv8WrFH5p1VIztFGWJJvtMneIKkYhyKoZeTaMeR8szGwYTnRGJ80o/dSzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826791; c=relaxed/simple;
	bh=MsVhpO2zfRU9Y/Cbdi4ONzkroE3pa/lY/7HXFWDuw/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aSE9hq/wNDzF3wT9eb7Fpy/56giq5o39yv2m18ip362GtIOeSiUi60z1+m1gkrNdHW/gvoV7eJNBsiDx7qxE6tKSSQZOTPzJF4bjq0jKItnKiLY6Iinoe6fPznzJKmqLAK/lgiyCZdUubx92RJ5U3SQucmenvXi9jmW6TpLG+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sw5p3qHa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aEmCvfmD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sw5p3qHa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aEmCvfmD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mwFe1604649
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6h95ep5XD8uL+PwhyXbA5lFIU+OCaEsk7al
	MGR49YNE=; b=Sw5p3qHaNqq2yG1VuUouDx0Y7wz4zIlgOqYWK70aHpfChsqyUR5
	Gwss48Kf5CDRy4CldfP4GPX86pw8lj39PdCybnCAMKyh5qq9v78Ebu7ETugk+EAy
	DtUx7xPjbd6m/IG9y7hcKzK+K31ooa2xMZVf8SvXzGDbGrBnd3ieeVwGbPDy9bC0
	xWUb1qCUXCunTam11vNqj+Eyt67xm7T54NkigKHYr4RYL4/nYDTQsNRjAAtvbkTq
	T3x5UxdgR8D/uREcbcUUmXKdQDlJji6Na90G3+NLtgqqgloifOvXhC0vAhK6DZJc
	vtXb3E82MoEnyNEp40LB+RLJ7uLqjBy8jlA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fjfye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:39:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ed53abff8so2080165eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826789; x=1783431589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6h95ep5XD8uL+PwhyXbA5lFIU+OCaEsk7alMGR49YNE=;
        b=aEmCvfmDAsIrary+ZkAK4MiGNNFkXw1Jw0fm/er3Q14X7ai7DFhTIonMrvveyN3V/j
         XOS+yfsUOQeMiPX8+wHDC2mGPyjaY8ZKdMjHfxHcWcSaZ36nKnuH2xUtX1bGMf2Zj8iD
         u5DgnG/arIuxTUIfklu15tSIV+/i7FVxmgsMcjbFe9B02wOCwinVLoIFAW7VP9beR7GD
         i3jjdp/51Ga+h/BM9FeLYnXVKVUCytUFgPUG9GSSt/P/jwmrVOsRj3tbtMmzLC4kK3z+
         kTUIALzo9DqMsSRwqYAmz/LW1hhWpdOVz4RtHR48XxYIgvpur7YO4zkw40dKeLMZifk4
         ZnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826789; x=1783431589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h95ep5XD8uL+PwhyXbA5lFIU+OCaEsk7alMGR49YNE=;
        b=cqIm1whmj7yF1vD2dJutnib0qfoyMqSujrnfHszFHdQ7uy2/M8tzgUFstG+Q+La/fN
         ksCg92IIxWsXqCYOdEedjPEe2CDvxXNHsuIHTnbWDq6x91bAuVrP0ZQl9uUvW1+lcQHC
         BXg8Pfhdjt2MEab/tJ4km7eOz/JHnfyf5gCnw/UEePyzRG+LWL0kwYlEzMfPuAIimsoH
         25hAx+v/ePj7raBDPowRMgTo4UFI+xLRLOiDUfLjAHsOzVdiTUgiU/ylRP8BNr5yhLmf
         PfODSeT5gUjm9bPY+1AUPdC0OS3OwmsgiLp60nISiTjcA2LX7+z1yTiSGdmS2TiwnjB7
         VUVQ==
X-Gm-Message-State: AOJu0YyNDgAqhpuKSXoNsSCZi11nU1zs+z55+6bi7TswMIAFqxnWzv6z
	1hBkgXtu9CHv8Je4/o8hoG3Sd3qQUOmd114fNFFDyDbbY8zCszadk0JRFS5EWC/FSgJCyg8YOVZ
	OiiDVeOOvhkbiFrY1IQVRufhKzHJK6bO20tYCtJtKg9/5SpjVpQk5knplpVBlBD3MjQxyvhAH3U
	lWxSI=
X-Gm-Gg: AfdE7cnZA66CIwIat/Pi/xTLkCN2HLyJXF/UpHszlnv1VpbpkwDyIXyM3U9CLFAJdBa
	eYyHRtePnVvYm9wBEiM9dh5mOa1luGwZew/IHBIAA+k4D9wTxSB/UP6eZN2KPhDdV1sfJdUc+Jy
	Kf/BdJx3F8MFl14OfoulJwMCcGeU6EmSjCR81KnujI6fuTK1Pi//Aog+nruM8kcJr63jSL/woqW
	PRsBytXWhUcVgx427F68MPeOsqWFXaafpLgQHcRogdMPUW6QA5iomk9eFzdMeRqQcTD5MbPA2WF
	lI+7zukdP9DIAqy+654RKZzTwXJhccAuiqXP6wH+9lJNjqnTqDo0XkyCr++OMk6XGgJ20wr9LAp
	Y9SxUrCtchWD1R39cIXCerwnk1Z7krIU37L7XVyqf
X-Received: by 2002:a05:7301:e8d:b0:30c:2af0:1cc with SMTP id 5a478bee46e88-30ee14c4090mr2737525eec.34.1782826789377;
        Tue, 30 Jun 2026 06:39:49 -0700 (PDT)
X-Received: by 2002:a05:7301:e8d:b0:30c:2af0:1cc with SMTP id 5a478bee46e88-30ee14c4090mr2737507eec.34.1782826788861;
        Tue, 30 Jun 2026 06:39:48 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4dcsm8704158eec.5.2026.06.30.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:39:48 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 0/6] RAP: Move CS default settings
Date: Tue, 30 Jun 2026 19:09:34 +0530
Message-Id: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX4cPu7Dacq7Xs
 xjtuzSiUzfZqcmgh44o2NLEnfG6GFLQt1T/zpNLguDaDY5RHkJq99ZNyAsjdtHab6Slu0JQXbEu
 BzBWgSWDjenbNLgcDtmxVnwqnro/XmbDy5RtJiuwzfmVizOrC9W+xyYJn/UNovBbasQkIey+Qxa
 h2nPI4eingDdoyolfCyU0imkFunrNBgcea+K9NLC7xks2gEanjVZ0jKCRoe6fvoVMBJwzLmixwk
 tqInzDt8hLZ0qeIiOr+GzxfpRhquRnloUn2RwILEakngVgYjOBzqnaX72fm4yNzixcrGuRnM/ib
 WRReHRAkK/HIefRYMbol0aRkeYvSNvc+f6runkmtVXIeumDq0kjxrPqRGyk/z3BC7onk4b37WO9
 YmOsS8f/RluYJrrlf7eK7cQeJrokR4hD84aL5LMkEMM8PqTWbSo1HKqXn/1JD+irkto1Iz7m4RP
 v4itlsK17nG4JUswNxQ==
X-Proofpoint-ORIG-GUID: q9thE4PIs1aF5RQNJMhTlYyCak7kBDNr
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43c726 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VyqxGoTrGix46t9oEBEA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: q9thE4PIs1aF5RQNJMhTlYyCak7kBDNr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX46rkc/zxx1Wc
 Gkuwf6AG8aJjSbPsIplWXFGjYOdNgHGkGp3NtlV3VtRekXrCrOs2aOMRxa7jEpekDncdQnztlc4
 08oSSYqt0qA4osAV9sPnRMgO4rPc3Bw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300127

This series removes CS default settings (role, cs_sync_ant_sel, and
max_tx_power) from RAP initialization and configuration paths where they
do not logically belong.

These parameters are measurement-session specific and are already supplied
through StartMeasurement. Keeping them in main.conf and passing them during
HCI attachment introduces unnecessary duplication and mixes per-session
configuration with device initialization.

The changes in this series:

  1. Remove CS default settings from main.conf parsing and configuration.
  2. Update bt_rap_attach_hci() callers to stop passing these parameters.
  3. Simplify bt_rap_attach_hci() by removing the corresponding arguments.
  4. Remove wrapper API

Changes in v2:
- Change title for patchset 2 to reduce length


Naga Bhavani Akella (6):
  shared: remove default settings params from bt_rap_attach_hci
  profiles: update bt_rap_attach_hci call to drop def settings
  rap: remove CS default settings from main.conf
  shared: replace the wrapper API
  profiles: replace wrapper API
  shared: remove wrapper API

 profiles/ranging/rap.c     |   5 +-
 profiles/ranging/rap_hci.c |  27 +++-----
 src/btd.h                  |   7 --
 src/main.c                 | 127 +------------------------------------
 src/main.conf              |  24 -------
 src/shared/rap.h           |   4 +-
 6 files changed, 13 insertions(+), 181 deletions(-)

-- 

