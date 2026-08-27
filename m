Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8563112BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808049; cv=none; b=m2K7+E8SCScsQX/Jh/ocKny/T5abCi0eBTQPpPIPIur78SZqnFcW0ggQw6gjYIHeHLTvPQQDSkjmnqwEcZ4M+9MnZo0EI99AJ3/whEhQwADfTO0YC+epaK2oH8r5Ai6xWSJlTPf2aKIAzUEJr7ze9FOAACp7+Tvudtzg5fJs/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808049; c=relaxed/simple;
	bh=lr3Xs+Ck0BT5psJWuTomp7NgdZ/fu2VI/TBRrdSoZL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rXLdOeBlHC8Qu0FQJjwXg017TyDZp6RBEACSh1wJUHpAK/DYBaVYWuXw/9NSXnIO+THJULh9DdtbUnySApPdqjImBLTcbeCD89GjeRZ8hL9hfb3+ZLNaOkkO5LTqN2NenCPCE4nt1td7jHTOGKll/6QRbND+dvhFgtyLwT8Xns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RVhBtY5n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cpTihJve; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVhBtY5n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cpTihJve"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3JEJS2304239
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Xnb7iJDKYRR7mY3WTjUIbyXT9eIN8RIUfWe
	dxF56S0s=; b=RVhBtY5ni7jUy1Qv9RfjT6scY2Z+u86/D0YJo2zakdI3Xy7eHUG
	s8FPUW4i7qPN2eTapf5fkKEN0n0QqUkNWY+upJA210bKQKMqfROGV2urTmDwnQRk
	GP5VYWgpcTpz3cA5gk43t+GLi4aFUgt71uZ3W3Qhw3D3c4WnMLa4hVYKHIxzN35r
	G6oodM58/u7KQpe9mOf7EtCLmZyXpm2kaV1cmOBlVt2Tbb4uC1ow0jxbioebzjOA
	m0M+aNh7FsdpY2zaAnx9tkZz8B/dtbMu1ecmsWXT/Za5L6IS0zrADWTPeRj46HbO
	G7iUNxbVx7+oJGgyjvH7uXey+Qh3bXY3XtA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwj5cw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so3559281a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787808046; x=1788412846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xnb7iJDKYRR7mY3WTjUIbyXT9eIN8RIUfWedxF56S0s=;
        b=cpTihJve1aTCeD6W4IPcSGjgZJu/fyxLErUv6jVB2qExVPFpksx3g5A81SHBq7WXtX
         5hQ0sLEVsbFWYip8uhRG8MaHIoRKVvyuA10bqlJqV0hClryp1lb2IpNPnszW2x3HxPpk
         EVGR6aLKbtei9+0YgdgCctPfMEbmVCD9CmAi7ni9Beql+237eO12rbay9e7gJ6Rc5zHt
         nFvY/tD9vJhfKkCYCAZdICfGQJN0UR//z/ywAftXx/aiBtcEQVoJNd/W2pqe1x7Lmpqy
         Ud1uvCouRsbsl/Pt64YpZoi2K1bIfAiNAWo1bcszgGSzfNkA25k43XvqtVPqer++Oe/6
         1HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808046; x=1788412846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xnb7iJDKYRR7mY3WTjUIbyXT9eIN8RIUfWedxF56S0s=;
        b=aQmaDtcZYe106qZ6FgPFY5IOgFkgQE2EqK0CZyr15APUPK3g6/5SMACbcARK1tJ+R2
         10vzub5JaOY+O8eAnJJqvKe0+Ncrxlf8/h47OQajFIXY43VJ+59hikyHTXgqTOkh/3rM
         bfofn68voRaIJwCWVEpxRfAZNrw8BL8WDtgedFyPZ1iNYMy1CzEYvpdkjo8pJtuQGGwM
         V8UMaYTtkplbP8ZfHzsmbOwuldlQNSbkvbtitzAVuPnt03sR2XdQKLS1MIAbBY4hk29j
         WsJFILzzxyF4bXVkhNLsDjXX2jcBAKy9gxpXR10txI7t1JszGhpXtEFsQpswkCTp01zn
         igdg==
X-Gm-Message-State: AFuF++lJzDtug0wWrWxa1RZDcyy/E5j6Grj7bdNsGHRktOO+q31f+xnf
	BKc9asupyX3HygeO8ydlWVoIFiQO7AsjMDQ86ivYZJvFw6sn7MFZ/CITohLMxYrmaYYRgnJA87G
	OmD2iCKA+4QG8h1vPKhhMjNB/M96+Y+Qtlwv/dPOhcmojwd46r9fWzFwEhDlqySGW8pewscQOum
	K1GNk=
X-Gm-Gg: AR+sD13rTh63hC/pkdDRZMNrrpdh596+fcCVrtn9sFZrS9aDVF6DWt+BHfoQZZT2MeB
	Y1Fj0ZadgRC2kdBAaTWJiUDfBh6YAaNUR6HJ/MB3OpBGJ5891gXKl35vad2wBs91rWyawYAtzDC
	OQlfiMOrpsQ4hKCIEd0N+3wYzW4rRORrJ5a07nJ+J+bXJCSc/4PX+HX5VuaGkwE7Kg6wCJXe94Q
	glaopMLUYCM02uc2haMrtihFO0SGnR4SKVRA+p8mypbXXZ42RaQzM1cXJb3YneHVWaIsQsA013B
	PE87FBPCKMPAcr1ZUatbfbwetUo6eSe+cfDbBujLwFTeRK0kmwcb+k+c4i9sYd3mvoRR5Z1HyZv
	72AI7oi6qJHB7Ee+UTR3aydqGwkO7RQ==
X-Received: by 2002:a17:90b:448c:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-3966d8a71b5mr24243662a91.15.1787808045765;
        Wed, 26 Aug 2026 22:20:45 -0700 (PDT)
X-Received: by 2002:a17:90b:448c:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-3966d8a71b5mr24243573a91.15.1787808045257;
        Wed, 26 Aug 2026 22:20:45 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm11903265c88.10.2026.08.26.22.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:20:44 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <nakella@qti.qualcomm.com>
Subject: [PATCH BlueZ v3 0/7]  Add ranging provider implementation
Date: Thu, 27 Aug 2026 10:50:27 +0530
Message-Id: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L7Jul-Yh5JhZw-dEUzqD3wb6R8U0hp0H
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8fc92e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=8X4obBOXJyH0-xh2yNAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: L7Jul-Yh5JhZw-dEUzqD3wb6R8U0hp0H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX51Im31QBqfNH
 SFPlkWmTOzymqDjs5SLaa/3TlFj8+j7Po6twt7Dk6iRnqSbigQLXLo1NHGILqs1hIhzzGvoT9zm
 Q50ciCM8AvAv69yniqKdmGzc+uj77EZJSVIbR6TeXkU8zdHeUW+WkE/kYwsw5xBfyLAfYwGmaYK
 XR89DHGRmBS4q2K0nu0ikIS6pKEjgrK6gdS05NNHEgT+x6RSftoEGadwkuBZnhtRMVutoOeWVoQ
 HgctFqwPfOYAF0hHc2TMdzRaHtdlCo+gQqEQb3TkuBXahgoHVtl1M0UGuBxgbEn8Nq2/3FmxQTU
 0ANMPpwUrrDWmnSdhTxtAoBA0GMpJ6HfHE5Oeujc7MN3lHHI7BC2HfEtl+eCxCBPT3LjEdYx3Iz
 tPyU7RFqbnj6lcFOwde1Jv0+iSGaJZ7bufX1yd4Aqec0mZy3eyLX5KU/0qXh1iXYHNvhIrwulPQ
 3k1q76auxdhuJjlORbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX4wEn6cHp2yoM
 pAPhnbGvprEoP9qcYeRa3SfpXBjekW1IzX+9BtOCnCxzWEtDqFIEssUI1319RZ3Gd1/04xAiGWU
 HkoDoEr8M5B8dQLYUUmdnZLrsw138y4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270040

From: Naga Bhavani Akella <nakella@qti.qualcomm.com>

This series documents and implements the D-Bus API that lets an
external ranging daemon compute Channel Sounding distance estimates
from the raw procedure data BlueZ reports, and feed them back for
reflection on the device's Channel Sounding interface

Patch 1 documents Ranging, the BlueZ-owned interface
that reflects the provider's Distance estimate for consumption
by desktop clients.

Patch 2 documents RangingProvider, the interface the
registered provider implements to expose per-device distance
estimates.

Patch 3 documents RangingProviderManager, which a
ranging daemon uses to register/unregister itself as a distance
provider.

Patch 4 documents addition of new options (register/unregister)
in bluetoothctl cs menu

Patch 5 and 6 implements Ranging Provider and Rangign Provider Manager
interfaces

Patch 7 implements test/example-ranging-provider,
a simple D-Bus client application for ranging profile

Changes in v3:
 - Change interface naming fro CS to ranging
 - Add Register/Unregister provider options as part of CS menu
 - Add example-ranging-provider to show client application for
 ranging profile

Changes in v2:
 - Add implementation of ranging provider and ranging provider manager

Naga Bhavani Akella (7):
  doc: Add org.bluez.Ranging1 documentation
  doc: Add org.bluez.RangingProvider1 documentation
  doc: Add org.bluez.RangingProviderManager1 documentation
  doc: Modify bluetoothctl-cs documentation
  src: Add Ranging provider D-Bus API
  client: Add ranging distance display support to bluetoothctl
  test: Add Python Ranging Provider example

 Makefile.am                               |  16 +-
 Makefile.tools                            |   1 +
 client/cs.c                               | 514 ++++++++++++++++-
 client/cs.h                               |   6 +
 client/main.c                             |  58 ++
 doc/bluetoothctl-cs.rst                   |  41 ++
 doc/org.bluez.Ranging1.rst                |  78 +++
 doc/org.bluez.RangingProvider1.rst        |  92 ++++
 doc/org.bluez.RangingProviderManager1.rst |  91 +++
 src/adapter.c                             |  11 +
 src/ranging.c                             | 644 ++++++++++++++++++++++
 src/ranging.h                             |  25 +
 test/example-ranging-provider             | 222 ++++++++
 13 files changed, 1796 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.Ranging1.rst
 create mode 100644 doc/org.bluez.RangingProvider1.rst
 create mode 100644 doc/org.bluez.RangingProviderManager1.rst
 create mode 100644 src/ranging.c
 create mode 100644 src/ranging.h
 create mode 100644 test/example-ranging-provider

-- 
