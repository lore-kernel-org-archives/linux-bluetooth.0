Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6883DD521
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520310; cv=none; b=smlzl8c0B0f88XOrHsHoF7p+weTzkGrSIqtzzTbNzc33YnNPcSC+T6Zd9SKOBC61n9eyJWqZOAcvsbDG4ZUya8ZUNJwJ2sBrBpZgs2DRXfuNs5Udm5BIrH3DICJvqVGlq4Kn/6itfQ/1a+N5+kY3HXtqGI1R/0gn+OQEd8/zQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520310; c=relaxed/simple;
	bh=gxrRYLjZ8oANS+wWiNGDi2jzRcq6J3rWiNS38cKdeZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TkW1Ih/MzRBqTUuebRU9lTheVinb4dFSLgRSezwVa6YaGFIryYTlp2qbqG4c2u6MaAcdvZA4hsPMg+R7rU8MZ4mkCdZQdDdOP8/zrTGaLPCCZtd/tTIAJJpZytM+82vVn05fTl86VwnhO2o9qklNW4zszlQXTrdPhFR9BqwRjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EFxo6wy/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j+5Oz5ZQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EFxo6wy/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+5Oz5ZQ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3NIh2753549
	for <linux-bluetooth@vger.kernel.org>; Wed, 8 Jul 2026 14:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GY+Xxf5H3oG7sz8UuHAzFy5OdFrAh7PHU/s
	EulNR3y4=; b=EFxo6wy/zkD3E7Wmcc4hbbIIwHHa2rTYq5A6HHxOmX4QTIgNcrN
	FhIOvdq/QEOFo+yspRVOWVX1am+suzn5oKhgoSXmiKDAtJ+baEN+kPsftMJWB3IM
	3gNVo7aQidjSYL7RQKmGAKCyZdvRSVtsdsHk4zZK06hbCAjgQMuLgqi7L9o+b27+
	xJ3tpCGxVMC7A9tIhJDhP+yqF9y5gjPmXcmsOyD+FSUjEUwqK9hw45qYRmvs9gnx
	ABYdhRXTl+nWUGEKFr3ZN9IOidiQjauLnpG965TMCKvDJb/2DHQ/mETaVvsFLtrb
	8QgAovn+GJX62eMuANNq9j2PkLzs2RF5A6Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hj28j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 14:18:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3810e5c5871so1519995a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783520307; x=1784125107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GY+Xxf5H3oG7sz8UuHAzFy5OdFrAh7PHU/sEulNR3y4=;
        b=j+5Oz5ZQTVzSIKevYAmPjuYtlttxyT6vVv51iNsF4a3TUtXFQmjZpRmEgCYfmeJQ0W
         FUcddFM0uD1Cx9K1tZ+u6iU69Njj8B1d3DZdth5RFkTO2mAl2lOji2f6kSQfeHdYacHh
         QrV+sJtEBuGnmHY9TuFHiX5v33VZVccXY9FkylGQgDyoNOAl/i2MHzvNnSkPg6hVcyoR
         AgnfqDAXmca9Yiab/y8vsGJw2qTYnbV0utY2kvgJfN1H2XiNMa0MvBDzXwCG0eojw5y3
         2k9qP2s7CPJpk43IlAp1yUJgW5+8DywTZThWz+GOe0lgpcO1/OxzfNCcHGmRZtBL6+ZV
         zLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783520307; x=1784125107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY+Xxf5H3oG7sz8UuHAzFy5OdFrAh7PHU/sEulNR3y4=;
        b=oi6pvaQd7nyng6mF5QYag+qZ+pWFqNU+x/UyDeEdBqYC17dft8H4TloHXbk7nAH94T
         MgWArPJv/wrEfpW0EkeV5XDtR690FkzFMYTysj1uv4zTPBjyFuVJ/MMSwQ90T+Y/pjVe
         7h45EZJQm1XVKLX8f7l6+ctOfCTMEnwdDMBCa40aSh5Zyq+x/Lm9Mfg08qHA8y53smSB
         xq9oV+xT+HabCHlAhnC9CohH7+CGNPSlC0+39eoEcREOLQxP8NPHcEJoBTMrvysZti6k
         MwzaCWytog+tkrkwxYFNe1+x6sMKxj/P0PZGo7f2785tuXBr57eaqebcxVaSOw2mzGkD
         xDAg==
X-Gm-Message-State: AOJu0YxlMb7MJIi4OpJf3b6MmXiUWpKR7AvdvH9pjQzVaR5MpAErCAi0
	EA23XIeKY5W7Nk4hQRqdtdah0su1TYP1abFxKvPdjYDB45Ld1BVFtrhLcc8kCGQDmjLoGb60AyE
	UV6jXHsQXc72TsgqAM5MmITWI4DXJAZgKSkrahooOCuRrMUEjUkUIU1P9mH00dFFxAGjDf+02up
	rk6b4=
X-Gm-Gg: AfdE7cnwqdwWcYrp7yhs04FFv83OnL+kVoGyOX8fnoLyLxoqkh0dMapWcLjSQ2hHIWq
	CPe0QDtR2Yo+TksqaEH/+2mAW6Hk6vfF9s0vc8k/Xe3FCFGKJ4r+QumIe5VkmgQFjsQg0iOGYs7
	Yh9OmCtaVZ4dolShLu1RJnxPmu2YHZ+gkgpLMd4JSvczok2jB8zn+Ta7G1KeOds5hEtaWgVl0A0
	8qtpOVepjdieFqyCmiM232Uf2r4HOG6DsZlvqkOsKmLyWlZApb9He5KMHPLHabBNX9gTeBdoPeV
	qMDLTMn46oepY/UaoNPmxBhSYf3sNos9vZ/uL2hyBmCUwEcp6reLP/+MIJOMfklkK3AO20FbYRV
	ukqsYr83LcEtWLUQyvKDLhQUtBO+FwXp9j++Sm/DV
X-Received: by 2002:a17:90b:2f06:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-38941101dfemr2844050a91.7.1783520307462;
        Wed, 08 Jul 2026 07:18:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2f06:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-38941101dfemr2844007a91.7.1783520306952;
        Wed, 08 Jul 2026 07:18:26 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5982sm22665427eec.5.2026.07.08.07.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:18:26 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 0/3]  doc: Add Channel Sounding API and bluetoothctl documentation
Date: Wed,  8 Jul 2026 19:48:16 +0530
Message-Id: <20260708141819.1284821-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX4M+2OxEBwJjZ
 UlxFrLseD1QVJm73R0/Fa0q1C76o+YNSX4GyC0GUh1iVn8xGTkbb67Z/hdO7I8+WroD9tf08sVC
 CKPeitZ5LbsqoOlQq1daB2/2KNsk7aNsvT+RkmZouU9TVpzrZubmJ+KQlVgScAwHJAY+/NrLYKr
 uwybVGANh3HX1vMmAsIgiiegjLULy/IjYp4xuFg1kY9TUPhtk8HIrWoMaYuWbIhHRx+pqe4AnY4
 R5GeXq0Lese48WXLHa1lIBUd6x9/c7sxZ6W3xJhtVWeVDKvgcgNQQlP5lzepvavac8MO7RWqm4Q
 pykYi+6VbV2sHzMwrr3LBqek5L0M6sHZvBADXNWTJPQZJDuCaSxBKY+CGjPIavPiA6t7W+NLEQV
 VvsrU3hVomesPEov1GauuY+FA9q76fSMe4hyGIJnXMOhKY/NWQ4tLdF4DJF1/O1agQwJzUhW7Pd
 z13NKFrUYQ53ujh51lw==
X-Proofpoint-GUID: e-3mRRPxhm-UO6xuqrRj2sol_JndKo1b
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e5c34 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=iSzkMiWJHOwH8bCpblYA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX3SSUEkzKZwwG
 +UY/yfKBFtjfcb85NIc1cmQtRgVVFwm7l5GQUQ5oyY+p0uz1+FeU0DUkZ14kjiVYgUwuBfFt0u6
 U12YuvXkxnMMI2BEnSXDD+BvLINF9KY=
X-Proofpoint-ORIG-GUID: e-3mRRPxhm-UO6xuqrRj2sol_JndKo1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080140

Improve Channel Sounding documentation by adding cross-references
between the D-Bus APIs and bluetoothctl commands, along with practical
usage examples.

The D-Bus API documents gain :Used by: references to the bluetoothctl
cs submenu and examples for methods and signals, while the
bluetoothctl documentation is updated with :Uses: references,
argument descriptions, and usage examples.

Changes in v2:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Naga Bhavani Akella (3):
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
  doc/org.bluez.ChannelSoundingRanging1:Add references and examples
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments

 doc/bluetoothctl-cs.rst                   | 277 ++++++++++++++++++++
 doc/org.bluez.ChannelSounding1.rst        | 301 ++++++++++++++++++++++
 doc/org.bluez.ChannelSoundingRanging1.rst |  66 +++++
 3 files changed, 644 insertions(+)
 create mode 100644 doc/bluetoothctl-cs.rst
 create mode 100644 doc/org.bluez.ChannelSounding1.rst
 create mode 100644 doc/org.bluez.ChannelSoundingRanging1.rst

-- 

