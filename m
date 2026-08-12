Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E5412BF0
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529036; cv=none; b=qBgIruiqluFs9J1kxMG1htTx5XIgSHugEpeFxdhWEHdfPtC4d8au9usygR3W7PpfSyzgnGhb0pCsDqSi4qMN6wU60hrrqhrTxJHCo8CuNvBIGLZDGwC+GqqTY5oQjZSUL9JDZLeUrXfe9sEuZAv/Py/NFbnoN8jNyBcSu9Ymogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529036; c=relaxed/simple;
	bh=iUIJfW9oCQ4jw5DL0ie0bGGXdK1PEA7Dm5cT9YNM61w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kCKsllD3S0M2Cs+l7Ys4qx7gmdQkwgITPr2z62pIz866Cx4bl+8aCXj55kLkYDN7mJCE5AMs5qcsERZ3zC2HJo2N3+HnkVnNAT+xDGLFw1YHrlUbF8d7tumm78ZZK3jTyNXZSaW2ku3kkDW5A2PIiPe5ybzdLcR3d07ozIPmHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jhPZCCci; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UIGY16K6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jhPZCCci";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UIGY16K6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9fmSY3082821
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oLZpIpiLGrlUIQiroUvc3pX6b9ZcEzzO5fh
	o1nIS6Js=; b=jhPZCCciAQGO97+lUmTpQKjtwbgZPKivHpLiKrNfvMa9g07kRET
	xAlETITDV7G+KwgERPz615Brahx9hWS7q6sH2sU55F6DZjVuobKqcKNl+ek7aYg1
	NNWm2KDaU2BmAsum32XErpzW2zSA8oIsHZ1rTzMDRobYF3I331/+MxSDSju4n+2W
	M165dbzvum3+5zZfJjA9kI884b+YcJagjlVc+FtCQ+4jBIhCs+0/GrOS+RKfOvrg
	ce4CqMu2V5Jii7dNXzpXQPgNMdw2cuNR6a+JBucMloVf9UIQuU/ZKbFvhRX0MoGj
	A7gudZtTY4Bi2XllNDOA0KYLiqfBo60D8KQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrk96t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:03:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso1108263a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786529033; x=1787133833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oLZpIpiLGrlUIQiroUvc3pX6b9ZcEzzO5fho1nIS6Js=;
        b=UIGY16K6RPueaIy5ymMLMlyfPu+sHM5m//K4FNTVFpgM6/kyFJiFOtEsK51bks+A89
         rkigUh2i+l6sKGY3GPcwB2LrWclj4X+KpfE17GBKc88iemRN+GMMSEEbaNH51rkvoJsV
         b+z0TW68h6OLYLVetPd0jgPGDg5Nmi4Nc0Az1uQn8o4xdFax2z7puGNQWabdIQ+BZL+9
         U3sX0qxx7vWSPfe7UPA7JFfoPvMPnBnmgQqCZTkhId3zFxlJWwzk2ewujP4219XDe86L
         RHZOgpsQMtR3M5G/w+nTGh6yAdYocK+Nv200KkQ3TSs6NZzLYomPSVH5sLtZZgqJno5Z
         6R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529033; x=1787133833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLZpIpiLGrlUIQiroUvc3pX6b9ZcEzzO5fho1nIS6Js=;
        b=mzLqwWtxsxB6ZABLya/ukWQbn0dFxAdUIVsrcdMYISR3QDxJXZ74t2ZxvF672aM1zk
         j1qPtHkbY1i2v3bGUolbDpg5A7XcE8oWGeDIOoEfEnanAjKoUApnDmEmPph+88c2qjs2
         1XmEdsDNSZ2VoTcfDwVMyNEjxRMydbYQoDNFonAd7DpgdTkFB4/ciWKq7gG6o8dpgmYe
         fasr24UWSE5NJ1Mfhjuv2Eky+ZOpKyWALYcasnjVDtTnnu/nE8gbC6V5fWD7WShHXj2U
         86RAdIMOKkcJ2ui+wX1gU2unvgPl9aJngv8p0tXiACGF4SoF1ga9em2IIvQK1j3ptQ+S
         4CkA==
X-Gm-Message-State: AOJu0Yx5s7BViekeVBl7skkrs6fgkCiLrt5TkLiRSggup3KDYaiyJxJh
	p83kddzA9o//n5Je4ko7unCRDD53Ftktpq6z4pQ7nbooy/sIR90gpw8Fg+OKCuErl4woEYC6c5M
	QfGa+25V2gcqs6C44FPCVnWQuw9d2aDUndLTp0v737wj/bWiuNMupijHz1o69AqmqY62cOtb0BC
	kNcqI=
X-Gm-Gg: AR+sD10MPXeYLq6+eyh7+k6KsflxtvmPcA+yO+1rYeTfj4SkUtzgPEE1iZV8Mx8Esy1
	KwOe3NBQd1Z3RQgfkM2gu7KPBTUyVPf22/sXG+XQaTYoqWmNNnsGmOZ4tnerHc9Rxwcbmicg6G8
	It+ILU0BxYYzVv0PoBqP9xVDeMjUicX08kN/Ir7NxHUOkzaTtxcP75gADJBsrbXjaZrMSDkm6oM
	BL23o6wOZvC7xBhTfFkEyNELRqw2cuSrq7iOKHniKCBuKj4qvsc82dVGraNNYIXatSg0yxIqBQw
	wt71oII6Wyzjqi8ZRCmEb8aMvLekQ7/F3w6gMED6CExN4lW/i0XJ/qDKrxPkmJz/76GVBL6ktY8
	si/MHdtluHo9g8rceFpojOd8ADf4XmQ==
X-Received: by 2002:a17:90b:17cd:b0:392:c80b:8ef7 with SMTP id 98e67ed59e1d1-3930144d6a6mr3861914a91.18.1786529033128;
        Wed, 12 Aug 2026 03:03:53 -0700 (PDT)
X-Received: by 2002:a17:90b:17cd:b0:392:c80b:8ef7 with SMTP id 98e67ed59e1d1-3930144d6a6mr3861859a91.18.1786529032683;
        Wed, 12 Aug 2026 03:03:52 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e2aasm11069961eec.14.2026.08.12.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:03:52 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <nakella@qti.qualcomm.com>
Subject: [PATCH BlueZ v2 0/5] Add CS distance provider implementation
Date: Wed, 12 Aug 2026 15:33:40 +0530
Message-Id: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E8s7nW_RWu-aK47EDZNhxgjk3M6-MVVz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfXwYoAX0jZklQe
 /1XXVrz0tGSARJwaubZeCLvef2tNXjTYxEb6P+FRrM9Z8VO0T8ffctc8myrPzKNVbOXGEZYN3r3
 V5YKrlSoZc7BwDIDKRsW0oDTBcG2Jbw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX3nH3Pi+m2vfl
 kurN14rTQmEioQ0jMcNsY1quYGwu9ZCFBBSFhflsdbo+TSwBnXS1M4tghTyuV2ySEQLkebhAVAu
 1Uh7YHduwZhEE6D6rKcYi/GRl/nbbgRHUZuxb+1u/eWeLfp59MnB1/b+I7/W8w70Z3z59MnlwqI
 8jUIbabw2TMXWbPcElvi2Re2unQeMjmWwFPDfqeXRWvZN4hdQkoALdEuiyMCvrMF2vSvUalOSSL
 /whcaN6OQUTWZOkPiP1pF9Xo6/eZl7V2oXHXVJa6In4C41ffV/LIuJ5r3V+xEfxLHQKVPQiKZ5A
 H2AobmfYWsU2S6K1Rc/9bc3gPcMARdiRNhdzafNOwJX3qOkjHwNknAR8qYGbcISyxHBqb91+J6U
 6RnB5Q8oP+BYbD0DnJZeUeWa74ncPKpj1tR5YM/2Mp7m7fDG0XFgSwq1ZqE6Uh4OnZXm4KlCGxo
 D++bDTiZ9/RvhakdsYw==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c4509 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=rmqRgaYpmlVIJLOMcLUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: E8s7nW_RWu-aK47EDZNhxgjk3M6-MVVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120080

From: Naga Bhavani Akella <nakella@qti.qualcomm.com>

This series documents and implements the D-Bus API that lets an
external ranging daemon compute Channel Sounding distance estimates
from the raw procedure data BlueZ reports, and feed them back for
reflection on the device's Channel Sounding interface

Patch 1 documents CSDistance1, the BlueZ-owned interface
that reflects the provider's DistanceMeters estimate for consumption
by desktop clients.

Patch 2 documents CSDistanceProvider, the interface the
registered provider implements to expose per-device distance
estimates.

Patch 3 documents CSDistanceProviderManager, which a
ranging daemon uses to register/unregister itself as a distance
provider.

Patch 4 and 5 implements CS Distance Provider and Provider Manager
interfaces


Naga Bhavani Akella (5):
  doc: Add org.bluez.CSDistance1 documentation
  doc: Add org.bluez.CSDistanceProvider documentation
  doc: Add org.bluez.CSDistanceProviderManager documentation
  rap: Add CS Distance provider D-Bus API
  client: Add CS distance display support to bluetoothctl

 Makefile.am                                 |  16 +-
 client/cs.c                                 |   2 +-
 client/cs.h                                 |   1 +
 client/main.c                               |  33 ++
 doc/org.bluez.CSDistance1.rst               |  36 ++
 doc/org.bluez.CSDistanceProvider.rst        |  32 ++
 doc/org.bluez.CSDistanceProviderManager.rst |  53 ++
 src/adapter.c                               |  12 +
 src/cs_distance.c                           | 578 ++++++++++++++++++++
 src/cs_distance.h                           |  23 +
 10 files changed, 783 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.CSDistance1.rst
 create mode 100644 doc/org.bluez.CSDistanceProvider.rst
 create mode 100644 doc/org.bluez.CSDistanceProviderManager.rst
 create mode 100644 src/cs_distance.c
 create mode 100644 src/cs_distance.h

-- 

