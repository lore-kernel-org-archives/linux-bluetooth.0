Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E42E1F0E
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481344; cv=none; b=WfZ/0aAkyiMCmDZ0rYy5dXKfcPu146T7Fr0BZcRtR2DV/LTdNaOffXU/o6EIYOHktPpWgngyOwdSHUPKHkOYn822IG9usmtZTWF+vtda3YbKpitHhe7+xkPJV5U42lqJUd217xMnoFboFYiA/AbVqLXUSmawcMo0kIKaeKZ9eD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481344; c=relaxed/simple;
	bh=SotYMnWvmxS18djRkfr2qL4Bi3xHqUJAqLIenNpjgBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucuwH/U0WPB0H7GRqr/QvBr7XHn42NZBqABpZYIErP6rRd+/3Co2Xsv0lHzBFTPrbryDR1AzFllmmgdwd6grZD+4xKN/qmkjvITsgUtrG7ARhWRH0QlRZHZJTq0pGrFEAzQkmg7BCcnzxRdxGq2KwAezeqv5B08ugUAq6YG9fbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YLY9K1sl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fs+nv4wM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YLY9K1sl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fs+nv4wM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V67CAd144275
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9whFL18iu2Q
	rgfkT214m9uxc0VaKgk9y9t/ZTcYknEA=; b=YLY9K1sl9r1L0ZWMkPxf6hhhrtf
	g3XxwVVFnSm8Cx1cNtBUIMiC8X1A8qKx/bf6OONngXnQr4ITjbok1iXQgoKvbsh3
	GZ9saODRFMnoiUvL+qbZAB72GRv2CzTlmZeUUMhFbalTEXMuCa76jKdJ9IAm+dpK
	+k6Rr9GmoxEidzJ1A4tpxnA/nwfgKBwma17H9LxnthkcEtY9vxXvqnt8gHQxm0r6
	RDvFoqJqsp/8rjkOIDKWURjwhIuiuCsKsGRsQAiVltCUwysKJ4ruzGSdfCKt9wqh
	AzDkQvKtdndP3QDwo4t+RWmEesY20QMCLj3YxC6VVYJfLwsjIh7sSyw+Bfw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp5k06bh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so1187983a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 00:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785481338; x=1786086138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9whFL18iu2QrgfkT214m9uxc0VaKgk9y9t/ZTcYknEA=;
        b=fs+nv4wM4dR97FvdtVsC2WRPvG0qIgMXyPRKRVr5ZvYY+XUtAPjyPwcgLChcNc1CNY
         LUyWXY+gRkWrpYDKE1+jydez7fiNgotNFu0JWsPjL9F2zj1cnhHqGr3MFvaK50OaibXE
         pnJWpz6PMUvL8NxL9sfmxredpxDzbhjcNuiA3uOBYYmOOaCzich51+Ggd+0LL1RRP92Z
         NFdA3vFEKSzaVO22KB/F28VA0Gmur5/y3a9VE4kmQDMhIfdOvAk6e8RBSOqLSBuzSljN
         9YsXUNllNuKh/XEHz2k5ia88VpBME4FfXNuf95oYrFuACMtuo2FMHuv5q+BVbquyfQle
         riTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481338; x=1786086138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9whFL18iu2QrgfkT214m9uxc0VaKgk9y9t/ZTcYknEA=;
        b=P+PLR+JS+lpFeSAxuYbPiEhES3NyTvMKw/VNPdsLBci6v1SYdAjEGbV7cyY1BduHsa
         U22/kfhs9UuBW91XESnqCJb+26iO6viYkpDHekPNPfQM9Hxogl3LuJazz/ejYkGTdXhk
         hkovZmcP7yhWJEiiKvEi0Aov2G+cj/5b4t4MOspU8FnrAcx0p+1sxozNoYGJu3+3Znbi
         JJYLg/qKyKrDyIK9cTXts6dJhINs13o9KmL+O+WZcV5j5VywkWLhMlB9hD9cWyZyh0x6
         vff6Q9d0iUbBI1cTeeSGBa2Bd13n2vURoJkqTbksH40/CiEDMP8WvGRTn14z6VYlegfC
         NiRg==
X-Gm-Message-State: AOJu0YwmejBRXWE1c4Ge1MkMn18Cw5/hzMWJHO4Qx/kLmkW1GpwrzCtS
	znqwzk6MJUhoHwd9emX14wRBE7iOdnvJlrmPGwMLgOF6Yqss9iiMpMBkXCDpPjqrYuhuWqUNPbP
	cR/Znbn5zytM9ywkSZnhGSJ/tQLNOOgqaaTV+qWyyqGVUzOkSWSRrDrMycsp/xyi1uyHXRb1oEi
	Z2BaU=
X-Gm-Gg: AR+sD10JdjrKMJEeDLmnJu4HWKymDA1m9dIAd1pa51NuUK3U1lvjER6fwaqkrvvgnp+
	CyhPm3pV9lM0VhTY3BM1fScE9yvwf2bcJlRWc5Ui7gGvKBbPebiYubwCut2ZWhoQJPs8Pj+zeXm
	POLcZw1NntbGCJQ+wp9IlwlLu1EEwoei4DteJkxAgdMXyiUZ3FUmGcY5+87mZrIgQ2qlGexchTC
	4FjZ5DKF+Zt/U0tXeoNcLNpbJ/2SHiMr+2U2RUuzdLK2mTKIYub9MxXsL2RylxKBG9wicmTTyC/
	AQhwV527YBHaDHfBgbhlNeygTr3Tu0QfJM9z9V6XQekB0UD/vKMec8vDSHwqliGE1s239Hf+biZ
	BXYh226wTaOk7SepS2OwcR+dXQLRjdg==
X-Received: by 2002:a17:90b:5111:b0:38e:8050:e63a with SMTP id 98e67ed59e1d1-38fb10f11fbmr886059a91.6.1785481338337;
        Fri, 31 Jul 2026 00:02:18 -0700 (PDT)
X-Received: by 2002:a17:90b:5111:b0:38e:8050:e63a with SMTP id 98e67ed59e1d1-38fb10f11fbmr886026a91.6.1785481337798;
        Fri, 31 Jul 2026 00:02:17 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab050d8csm182879c88.0.2026.07.31.00.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:02:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 2/3] doc: Add org.bluez.CSDistanceProvider documentation
Date: Fri, 31 Jul 2026 12:31:58 +0530
Message-Id: <20260731070159.2769120-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731070159.2769120-1-naga.akella@oss.qualcomm.com>
References: <20260731070159.2769120-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=L7stheT8 c=1 sm=1 tr=0 ts=6a6c487b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=3kjGGT6clJRvNyKHSloA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ge5OFW0n09s7F26vAabj78M9sx7Ie8gh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX0A2+IfcXOLUp
 jaRdbYLt3MWc7k3h4IPSbfCZEWQ2WelrZgRmXW8ntvGLQo6/b655s6jTcbYWz91xBVzbku7vpvT
 hz1WQBDPjUTnWNIM4kioa7yl0bxKJO4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX5JLX9YEOpG1k
 SVT95M4Q77XB8gxAFC4dTTbWmwpgWyMiw1t2B66bLAqhC/R7ejvA+eyD50+brF30CWtT+BLHDbn
 GOH8eeZATML5rwe0iYr/5b94mQWuGj+tHq2if3Mj7wGsodNskbBXQrSy4DzyPLkherzHkuow8vL
 F2F6QglP6ITKZH7rSReYobbB+lxoKyxZTbTU2yHiZp1cxdh8IFoNdkGSDcJVECiLRTYhbNIJYcJ
 xOVSgg2KG4B7a9QBmTdgNe8NPt/NwtGoardr/2y4tomVFHlyTn/1AfSUcNFdrxCFRSAXIxd32Nb
 itbdEO/jKMzAWHvgwIiksE8B0PYaiAe7qdPgEpuldir8wC61SogfE2HCgxQzEuDgr4dlzlsX6OL
 SRcgqrt8Z+Pu+gyXVAf+B5/EPkVDPbGGAtThW9obJyUK1TyQrRFcCUVymJNSO5Rzcyhk9KZfH74
 LKi28Ppz11qmvLMqpEw==
X-Proofpoint-ORIG-GUID: ge5OFW0n09s7F26vAabj78M9sx7Ie8gh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310048

Document the org.bluez.CSDistanceProvider interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.
---
 Makefile.am                          |  9 +++++---
 doc/org.bluez.CSDistanceProvider.rst | 32 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.CSDistanceProvider.rst

diff --git a/Makefile.am b/Makefile.am
index 00b4ac2b1..53bbfd0d2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -406,7 +406,8 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 man_MANS += doc/org.bluez.ChannelSounding1.5 \
-	    doc/org.bluez.CSDistance1.5
+	    doc/org.bluez.CSDistance1.5 \
+	    doc/org.bluez.CSDistanceProvider.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -448,7 +449,8 @@ manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 manual_pages += doc/org.bluez.ChannelSounding1.5 \
-	        doc/org.bluez.CSDistance1.5
+	        doc/org.bluez.CSDistance1.5 \
+	        doc/org.bluez.CSDistanceProvider.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -538,7 +540,8 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 	      doc/org.bluez.ThermometerWatcher.rst
 
 EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
-	      doc/org.bluez.CSDistance1.rst
+	      doc/org.bluez.CSDistance1.rst \
+	      doc/org.bluez.CSDistanceProvider.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.CSDistanceProvider.rst b/doc/org.bluez.CSDistanceProvider.rst
new file mode 100644
index 000000000..2d57dc8bd
--- /dev/null
+++ b/doc/org.bluez.CSDistanceProvider.rst
@@ -0,0 +1,32 @@
+============================
+org.bluez.CSDistanceProvider
+============================
+
+------------------------------------------------
+BlueZ D-Bus CSDistanceProvider API documentation
+------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	<client D-Bus address>
+:Interface:	org.bluez.CSDistanceProvider1
+:Object path:	{provider_root}/{unique distance object path}
+
+Properties
+----------
+
+Objects provided on this interface contain the same properties as
+**org.bluez.ChannelSounding1(5)** interface. Additionally, this interface
+needs to have the Device property indicating the object path of the
+device this distance estimate provides.
+
+object Device [readonly]
+````````````````````````
+
+The object path of the device that this distance estimate applies to.
-- 

