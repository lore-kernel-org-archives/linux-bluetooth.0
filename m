Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A873112BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808063; cv=none; b=SnrQdQPvHvVCOxBSr9fFwJCcjzhRBYTYP70MA+sS6ilGB6O7pyRKeoiLG0Ef/RgOhYEAzhahtWRa0iBkofqrPwMnrNZHYvTFCeJbSTUxUjbPacziut2RYTRYY7h59Pt4R7kpA+yp37uMhNVXRmBHqxjsXqMkBxb3ZIxpleCr0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808063; c=relaxed/simple;
	bh=31MpQhSIVxVAn7APvv3nxNafSzULQYAAckzp2yWf3so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PfUUgtMg1M6W12nAxHIoxn6mkOU0ING544ipXDjo3GpQ2cWFE8KwBSuMTR/Firh2IT1dne0BJjMSfOr6O6HiksQucpbvBTVTCW19cCGzk30pF6BRoo+LIRqdGInO+cQ/bPc6ei4GHD7e3Pr0GRBardlFcVuolpTnSPmFQN8LRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TtKs1StR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OV+d8xD1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TtKs1StR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OV+d8xD1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3J1A92303959
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TrxTfJPYzVO
	c03dj+SPGfSaxhykJ9EFoPFprLjcTs1A=; b=TtKs1StRIG1VN6LXiQXTb2zdpcf
	zq8ByuWMDgQtah+ew+yT3P8eS7vpy+obUCMtd529Af27+6rr4zHuti9n+zR6GNP1
	qHqYdRZtkLa73gNOXKsq5H9snhteSMt5PLdM7r6CisiFJ8TUqDzz9S5DzbtpSAzk
	loAi388Dn5FraVzg9pg185Zmo2DGkSPK480anep8ZL/kkwPQVJo5OK12mIJDJYV5
	ipy/raqZhy1GI7pLACqKe3EeQLep3M7foy3d3QE8djltB5Slkd66u2D8O5QgtS1j
	gv4/2K0plBy7Bzr+XjMctpBAVdsJ8qrm2F2fvk78/9A3PVjkt0AFVtLrxSg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwj5df-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so741753a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787808060; x=1788412860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TrxTfJPYzVOc03dj+SPGfSaxhykJ9EFoPFprLjcTs1A=;
        b=OV+d8xD1Pa8BbPnPJDYcEfTaNvkYNYubPH2DxGj0j2QvNZn8k5hN+Uxq0/Ot7YBD/c
         xJBaLhaaVp09h6rb0/9rO4A87ddZnuo8DifjlGKSGe5nXd1hdtq0pyhlyHjifCKGhSC9
         UKS//D6/GgO08ho5GpZkCbE+q5KMc/OOZga2oGVTijuz+As7z6XcSxI+dTizLgETZqW2
         WcWGSlDWwSsReFs1QgD3+MS/hqdg/uUCVxVJx5UMoPbb/nm9jeSDQq1f/wCQzCnzPC1u
         k4IxaIAhsaKre1f2sH2ZeZv4o9t0nr2aKKOYp4YYhX2O0jZ3BffmUhHBSWKzxNC5OU24
         EiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808060; x=1788412860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TrxTfJPYzVOc03dj+SPGfSaxhykJ9EFoPFprLjcTs1A=;
        b=oBIT1inF+nm4vLBN8DIZqQrvjPTIJtA20cAzomjHQoinwYfHuMGH5wN/I78FKFNqP3
         /VYKoJMYjWxThHMKKG/rcp9mxSFRu2HW79lCxSquFcsWStWkwlNvyFd5fvFsFFZWUsxG
         FowEHrzmX+S1tn9pVthL4jdw/Lw4ihO0L4aun3QzwM9CYpeU+2A3kc12BDkwdTbTeHry
         uSR8jLmQoXBRY5n28ze2IbbeWhk5zirIynxYPrZrxf3BoRYt3GO8moJ8IOqiT6qnMim6
         RepEBfEXHRYaJg28EXaxc3Ln/wXtiuGPM7oOABXSypTWG+LFc5iPL0p2GkhztuUZTlvT
         aBbA==
X-Gm-Message-State: AFuF++l992kaIElmIZZcQVD4tICQqzTqkNfzGkGcVHEkXIakGYT8XkPd
	gHY6lr7KqGIl6abOGcSwQCqX95uVTYES/eXxjfJMIrlvgsTowhsxpjjiLVe0/3Z6URdRWPWFK4D
	3qmauOAe4zYVqTy98fmnq5nJ4FR2p219WhOlBMqlB3KzCyG8wGLniycpHOy66frNkyiq6PRz4AU
	/ZXqc=
X-Gm-Gg: AR+sD139SPYOl6BATVxGYVQM7SykiwLorn1UHiNumB+mMieL9FOrwTYhPV4yC/9ZJsf
	75biOdbWH3tLKjbPaI3600cNnG2y4eudOx00Vm3a0aK3yk6UeX62GykWLzJ+LGtG4aHwQe6aYqf
	xfT6c+pMuImiHBIMGPvaqdsgzoa63C6/qWtKE+Abe+VxJLnX324Lwxskre1lpNscK30nM9lXJnn
	tPN7kFpzaOWbzy2MtJYSkhEt/U5ENP01DT5DkSozjCIfPjESQCywrMDGp1LPZzSzGZjs+55ZNMp
	TZPqBcQw7o6bQcZa/8rzpJS0OepPvUA8LG8Cz9Qg43clcJxmDGOF6xHX0bZpa61ofFEflUrpAlU
	faxLP87J+XvKOJ6IX54Sg+t7Td+G1Pw==
X-Received: by 2002:a17:90b:48d2:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-3969bc885e7mr5332634a91.19.1787808059626;
        Wed, 26 Aug 2026 22:20:59 -0700 (PDT)
X-Received: by 2002:a17:90b:48d2:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-3969bc885e7mr5332567a91.19.1787808058995;
        Wed, 26 Aug 2026 22:20:58 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm11903265c88.10.2026.08.26.22.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:20:58 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 3/7] doc: Add org.bluez.RangingProviderManager1 documentation
Date: Thu, 27 Aug 2026 10:50:30 +0530
Message-Id: <20260827052034.1374180-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
References: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3a-SLUR-6yymu_fhDdEYJ1mlWhzHRtHQ
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8fc93c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=eguDgKE0dmlUuSGdJA8A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 3a-SLUR-6yymu_fhDdEYJ1mlWhzHRtHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfXwozr7UT2hkv2
 OYj96yKtsd8POSXT7488Grig0Py90FH/GNSA2SMEf33PK4Ftqr/p3iTYPfwkjXW3WhQdUZ7rcaC
 dbuHtWahEC9NOi6t0vYw8MytFt3sK+VqXneJ9stOyC8gpetLIoCy0+JKFh14Lvq48JzsuoNPEgc
 aubjoNiGGcVSJSDfgIiy+XZ9SMNvCaXUGNeAiEUb0PaQmn1WIBB4kEtCkC295ROHVLwty+b/Rzw
 VzhTCnSxLvzIjSsWEPBCfioOsVDJWefRPvp6XY7Os90oPKIaQ9MPRU3xDKjz3w8amWrqPQdCsV0
 mIXgnCwlDJXOFS7fYE2PrPyS8T45tge1E/MCGlfoRUfZvRR5A+gWni8AcXOtC2UB1YNLrsdy8Qi
 0L6V2NfojjlpPbCaLDek+dS/kJdaRuGGrAbjwEPlTUowVZs3U5/uioajF+HTO7nAg+vqAVDCjAd
 8fExfdIoxy+rGP7C0RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfXxmpG2MG7/Flp
 UaWyC3qi1ZPTDy4dNLWu9o86nzP7btDzSlTne/mag57c+C7S9QVeVcIXJub5dFd6ag/l/amaLm9
 i3kvcjwVOEESacwmrQxpeqz0AQ+qm8c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270040

Document org.bluez.RangingProviderManager1 interface,
used by external clients to register and unregister
themselves as Channel Sounding distance providers via
RegisterRangingProvider/UnregisterRangingProvider
---
 Makefile.am                               |  9 ++-
 doc/org.bluez.RangingProviderManager1.rst | 91 +++++++++++++++++++++++
 2 files changed, 97 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.RangingProviderManager1.rst

diff --git a/Makefile.am b/Makefile.am
index 8252df65b..b3b7077fd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,7 +407,8 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.ThermometerWatcher.5
 man_MANS += doc/org.bluez.ChannelSounding1.5 \
 		doc/org.bluez.Ranging1.5 \
-		doc/org.bluez.RangingProvider1.5
+		doc/org.bluez.RangingProvider1.5 \
+		doc/org.bluez.RangingProviderManager1.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -450,7 +451,8 @@ manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.ThermometerWatcher.5
 manual_pages += doc/org.bluez.ChannelSounding1.5 \
 		doc/org.bluez.Ranging1.5 \
-		doc/org.bluez.RangingProvider1.5
+		doc/org.bluez.RangingProvider1.5 \
+		doc/org.bluez.RangingProviderManager1.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -541,7 +543,8 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 
 EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
 		doc/org.bluez.Ranging1.rst \
-		doc/org.bluez.RangingProvider1.rst
+		doc/org.bluez.RangingProvider1.rst \
+		doc/org.bluez.RangingProviderManager1.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.RangingProviderManager1.rst b/doc/org.bluez.RangingProviderManager1.rst
new file mode 100644
index 000000000..da551c981
--- /dev/null
+++ b/doc/org.bluez.RangingProviderManager1.rst
@@ -0,0 +1,91 @@
+======================================
+org.bluez.RangingProviderManager1
+======================================
+
+------------------------------------------------------
+BlueZ D-Bus RangingProviderManager API documentation
+------------------------------------------------------
+
+:Version: BlueZ
+:Date: August 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+A ranging provider starts by registering itself with the
+**RegisterRangingProvider()** method, passing an object path as the
+provider ID. Then, it can start exposing **org.bluez.RangingProvider1(5)**
+objects having a path starting with the given provider ID. It can also
+remove objects at any time.
+The objects and their properties exposed by ranging providers will be
+reflected on the matching **org.bluez.Ranging1(5)** interface.
+
+**bluetoothd(8)** will stop monitoring these exposed and removed objects
+after **UnregisterRangingProvider()** is called for that provider ID.
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.RangingProviderManager1
+:Object path:	/org/bluez/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterRangingProvider(object provider)
+`````````````````````````````````````````````````
+
+Registers a ranging provider. A registered ranging provider can then
+expose objects with **org.bluez.RangingProvider1(5)** interface.
+
+Only one ranging provider may be registered per adapter at a time: the
+object path above is per-adapter, so a provider registered on hci0 does
+not block registration on hci1. If a provider is already registered on
+that adapter, this call fails with **org.bluez.Error.AlreadyExists**,
+regardless of which client registered first.
+
+Possible errors:
+
+- org.bluez.Error.InvalidArguments
+- org.bluez.Error.AlreadyExists
+- org.bluez.Error.Failed
+
+void UnregisterRangingProvider(object provider)
+```````````````````````````````````````````````````
+
+Unregisters a ranging provider previously registered with
+**RegisterRangingProvider()**. After unregistration, the
+**org.bluez.RangingProvider1(5)** objects provided by this client are
+ignored by **bluetoothd(8)**.
+
+Fails if no provider is registered at the given path, or if the caller
+is not the D-Bus client that registered it.
+
+Possible errors:
+
+- org.bluez.Error.InvalidArguments
+- org.bluez.Error.DoesNotExist
+
+Overview
+========
+
+::
+
+    Ranging daemon                                 bluetoothd
+         |                                               |
+         | RegisterRangingProvider(provider_root)        |
+         |---------------------------------------------->|
+         |                    (ok)                       |
+         |<----------------------------------------------|
+         |                                               |
+         |   ... expose/update RangingProvider objects   |
+         |       under provider_root (see                |
+         |       org.bluez.RangingProvider1(5)) ...      |
+         |                                               |
+         | UnregisterRangingProvider(provider_root)      |
+         |---------------------------------------------->|
+         |                    (ok)                       |
+         |<----------------------------------------------|
-- 

