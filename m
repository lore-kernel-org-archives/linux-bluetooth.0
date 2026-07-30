Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F7376BDE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411831; cv=none; b=qeXHUtr47RS8XUM1Lq3NPtwv+fxgR5Q9VkIq2Q3F5UeqRYfUXdkkrRUl1F7SSu7eBw9F75aB/6zKDCHc36RP94pQm/BBCboFEnWWEFihrvkHr0LeDQXAeRBMj4zBtsJ1g7x2QnpcByA8Ykx5m6DimJeTzieYr2/9P1IaQAKKIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411831; c=relaxed/simple;
	bh=sZ3am9Ofn4nHW9e0GWCuxMFccKiZPwYdUaumqUNVoHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fR9fnyxHkO8bnMlbjaUCMQyECz1EmlBG3C8yYdQjn+Xg2ZYRMYF8lrg+XwnGiNVOENgcfXBF/luAJz4V0DlNZcIZrsSznphKXn38A7tQNr/sm3g6Gi9xfkShyxT739WHMftdBHdaK0DDavuos36H4p+ZUzLFFK0xcexLInYNwOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GaFS/CLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RUzdof2x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GaFS/CLh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RUzdof2x"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UB7xvi562988
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BLvYM9OZY65bh7EBr+z9KvGhb5lWlCXWUZT
	mRudLP6M=; b=GaFS/CLhgv0QcyguXJl39IrWgbVbP9cVV2vASKjEoNi99aRd1on
	XzpkQT/pDwaOhRzONc2al5nDf6RKg0Bamu9ODwRK2cCLwXhQ5z2orVhHk9NituWq
	jaezbKWNYJilfGTszYk7cUONfetEVIN0BSuoCGX5cLhjYvWbFbGcNyZfWpPYs3QW
	PBvHZHX7eu6CL7hgp/JRqQ3ZbGq7nPizrjL/YMDK78oNwmPjdvIescWvD6JOzzYE
	fL3Olj8mCsH2cM6a0vekxI5ljZb3hQcPhyxS1d8uj7+ay5j3ITe1vxeynGXt8TCf
	qShfJri+LDXj565ApuSHkRaAaLlyhxf5JFA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5fjg41n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so1120832a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785411828; x=1786016628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLvYM9OZY65bh7EBr+z9KvGhb5lWlCXWUZTmRudLP6M=;
        b=RUzdof2xA+DiyTuIJU1d4ZFKPpfZZnxvLZ+AvejAO0I7A8aDj02BJxojIMUQa3XG02
         7u0ZbQ8TOC1QTXyIb7JuKzGGDwY+MNO/QE7uWZqaG6MWCQcwAgP4PhenWm09iUmH5NNN
         HmqveW2vd95TmSFo3mQSB6ppCj2G1/JLl2pCkqh4Oeq7Gcb4l/15QkDHZTYZlTbwVIuS
         7a19mjeSaJRR8JKHnkb5qBKyt4iRkH/Dhb3ctd3mZOd/tw1PmwL72FkeqZbvoAiNOxJT
         j7Yhswd+GsHMqglrLQkck/UHltRoa8TJY6OMkse/0w2czpSKEaNY7bEmkxGhFZBK+euZ
         /t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411828; x=1786016628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLvYM9OZY65bh7EBr+z9KvGhb5lWlCXWUZTmRudLP6M=;
        b=NDc4ubZiG07n8WRmya+qf0bWw0q2iCoLAYhhMQ9fT8efV+YdQ7+1772Cb4zrw7qPWt
         154+csU3mUIts8ujLDU+5lbd6YLOd/HwhjFIckRPcED6jFMdwFG43U7M9XDkhCbPnD20
         q98cR3Fedzlqidqx5reTWSoTKpqO/o4k1J6pUhJrmySDz8sZ4YMRSLAAvHnghcYJnr6b
         TurxDaXmuUZTNovoouhnyikhk6dpUjmb7uGXW7syGJ+L3RWc0J28kXIJ0n+DuB8D8Sye
         fLBiPTp+kfzRMoqRXElvGPwb/yItwMEaUWBMn/5ZY0ayOCtB7SVgR5swMhxbB+PCQ8c0
         4naw==
X-Gm-Message-State: AOJu0YzNQnHH9B0vlmHOPen1Z93Apg9Pt7P5DeFHMiqd7fxRIDwW7uIN
	ntxOUKXB+P7tYWA/wSGEr3xJWJp9dI8vyvqdjMLzZUCwVr1cHUPK7DBH24FrhDbioKoRB46+cjT
	s0usQoJenfsCanJHTmtbOKyQqhdg+7H18YvK1cb6owXo7HHAW6KDxzvaD2tVcLMC/WfQWBVdkDw
	LMBSs=
X-Gm-Gg: AR+sD13XLxHMSigMWF3JUhB7yu4+hVZlXsVD0pf++78TMfGvdXXtDkLMk01I8AnWhle
	KI2/0OQ+74fH5iqIFBdHgSZ4FEkF4uw48MLopm+RThbuJ0kUlAw0W5yp9rZiUi3ZkMRgck5LXsr
	qrhvuPZLEgp2aopcUSMX5C/pkGezDK81sZh1lzriSlC18CjghZH3Mre694pZKaZw0SfeJGfuTxu
	eLdDgqst55eln3LBTq7keJwlzwf0RxnMG85mHcGmc3Iivhe5iDTa+bYWeTikZx6cuHitVso57Q0
	KP/yeutWovBhtfqq1v5sQxMDKRJ2LJIzS4MOVOpWpZkWz/tsG+T5XtnDRPlmPV+3BcY1IKJmov8
	jBDHYfhr8aKeLwPStJwpT3EMr2AzrFw==
X-Received: by 2002:a17:90b:28c3:b0:37f:9ce1:cdb1 with SMTP id 98e67ed59e1d1-38f9c032f3cmr1944497a91.31.1785411828488;
        Thu, 30 Jul 2026 04:43:48 -0700 (PDT)
X-Received: by 2002:a17:90b:28c3:b0:37f:9ce1:cdb1 with SMTP id 98e67ed59e1d1-38f9c032f3cmr1944471a91.31.1785411828022;
        Thu, 30 Jul 2026 04:43:48 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7273cd9esm20961598c88.13.2026.07.30.04.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:43:47 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/3] doc: Add Channel Sounding distance provider documentation
Date: Thu, 30 Jul 2026 17:13:37 +0530
Message-Id: <20260730114340.1576049-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FZbnAR8jA40ULDX9_LH7ct0BZ2k14BLI
X-Authority-Analysis: v=2.4 cv=TKF1jVla c=1 sm=1 tr=0 ts=6a6b38f5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=zs9yw3kJ1FGbCIwi0pIA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfX4F4UbHfXpKaX
 31AFeb1xJ3OCGofmAAWjpNDm7duPH8KoTXvidssmIl4Lp69fCPPYr/znIdpItW1URcFBPk+ivia
 2DWIMSYfEbJt6wIlfocekycXRpmo49MfqjvPNLgQLoVANnXEAoIMF+c38gSbuv7cz8IoFUG4Glh
 5w+wWb+uPCT6MBiXhpfRAH+08KiHbd4WyyL650Ug7KjfLFM1rfbtpM7Cpfs9WMiXalnEzuGW5YG
 FxE7uEwt0tMunKIc6F67XhB9z2+SHBMkIkyUW3XXObbVZRnpsWjLfrU2S+QMhNTNoEl2coS+yv0
 M25bnnGn5aq5MTuE4TyImN2T3pInXf8NjKxBGc9IJB4jHQ/6+EVRix+aG8Kfpm11kv14+pk4U7I
 gmaiMsFBDYopQCqIqhRJ+jMmG6OYX/F9Mmq8hhD9xKEuBy0FGruadpasRyoVaPwlImy/LHCmFIx
 hTNGeDgIhdX4La+YWuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfX53cEvuD8YzDR
 Mr3M5AsAAOAuXK07yhCMQy+ZnCG5uL4ADd6EE2k/PNMNqO9a3EKULEYnhiBTRbsSMtKeexJTwVd
 CxK9WPbeVOWSmaFXgbfLntJjTlSBS90=
X-Proofpoint-ORIG-GUID: FZbnAR8jA40ULDX9_LH7ct0BZ2k14BLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300088

This series documents the D-Bus API that lets an external ranging
daemon compute Channel Sounding distance estimates from the raw
procedure data BlueZ reports, and feed them back for reflection on
the device's Channel Sounding interface

Patch 3 documents ChannelSoundingDistanceProviderManager1, which a
ranging daemon uses to register/unregister itself as a distance
provider.

Patch 2 documents ChannelSoundingDistanceProvider1, the interface the
registered provider implements to expose per-device distance
estimates.

Patch 1 documents ChannelSoundingDistance1, the BlueZ-owned interface
that reflects the provider's DistanceMeters estimate for consumption
by desktop clients.


Naga Bhavani Akella (3):
  doc: Add org.bluez.ChannelSoundingDistance1 documentation
  doc: Add org.bluez.ChannelSoundingDistanceProvider documentation
  doc: Add org.bluez.ChannelSoundingDistanceProviderManager
    documentation

 Makefile.am                                   | 15 +++++-
 doc/org.bluez.ChannelSoundingDistance1.rst    | 36 +++++++++++++
 ....bluez.ChannelSoundingDistanceProvider.rst | 32 +++++++++++
 ...ChannelSoundingDistanceProviderManager.rst | 53 +++++++++++++++++++
 4 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 doc/org.bluez.ChannelSoundingDistance1.rst
 create mode 100644 doc/org.bluez.ChannelSoundingDistanceProvider.rst
 create mode 100644 doc/org.bluez.ChannelSoundingDistanceProviderManager.rst

-- 

