Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C89376BDE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411844; cv=none; b=THm5z+ISyDRXNCuzzA9OL9vqlW5WAHzir4uLpetQ0LfXoshmfxvEwFZG03raHzw+PumxlN0sxYmQQJ0t2vWuBKRpYI1HEEme9p2mOONrzENGoRlhq0uBboYqWvgRr++kSkhKY72AuvWkcZNKS9LmtcdxmgGXDGRQ5X9Ays4/fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411844; c=relaxed/simple;
	bh=wu0B/1ixKh3dktQYWG+j1YdRfSGw0EvIt1loBhyWJgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbvZbRAUiSEcc41nHmXZkLLgtt/MlXtFDKO+S6D29h9oXSgC626cuSP4rXIYEl9A4k0fXos1dO7gc8k1LEtDbT8zXqq/l+Z3HMwqWM18mM1x4qUnlCs59hsIISLfS1LviFM7khgys+LZMfdgNYQmi5uEdB0XvFDAo5karDwr+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5L4NEJ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DszdcR4h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5L4NEJ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DszdcR4h"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UBW5EF1144144
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mAERCRZm+OC
	EQCOVxuzLzQCD49/aQISxY72oscCzdbA=; b=g5L4NEJ4c0n8gRxVHKRRHuRawMC
	l3NIW1Fi+jVQ4JAKrraOsrNCBHDIdm+jtPI8swEqLUdIE1xB3IHRtzhJBb180Tg+
	z6XQqGHlbVBhBBZy5gtrGLh+sgvnZCJ2+0srBuwlDAqWkC6psHUyrecABAQpm77e
	QMVPxXHsq5bn9GYK4wKjy24at3Sz07mYsEBf2CXSOgCNxDj8Lt5HSrUD1g53HLko
	lv9HD5LeyYNrzyNQwxbvW9/DJVS3zduLSWXqu0CYLfzXhy5v8i/1ZbCuM39KwpFy
	t6USgLF7pFAi7Bo3fP5adcMg8SXWQdIciftPvZh6KX4/ZRCdeym2YeArMww==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5tvr19p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:44:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb733fc5024so2927425a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785411841; x=1786016641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAERCRZm+OCEQCOVxuzLzQCD49/aQISxY72oscCzdbA=;
        b=DszdcR4hBV4TMqhh7zWeWeJpoNViismenZ/Nqbu7k1vI0QP/Qf9E7TYlrIO6tzwBOa
         uSLg2gJ3WhQc0dsyHfBh91WMjhbJ8jnhJw75lQcIUAeuBZxzxsftomo1VigGZ/F4GcpQ
         z2Ru0Z255a6MzdDYHzPe1wDTbd6EappWTfTfarjtAbFP/L4bM+CroLUNxK5KejKg/7qZ
         maP7cGLrqA2LrapOagW6D0upNP0RX+Ub03Ve1aYb2mtFO9E4DvXnK/CzlgMmdy8W9p8x
         6P0/E7tDpl+sASYK+nkRVMV01OtAYfEAibWgbK0uZ6H4LyIUsAqoLwsVaiIbupgySAFE
         s98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411841; x=1786016641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAERCRZm+OCEQCOVxuzLzQCD49/aQISxY72oscCzdbA=;
        b=DIKxWkwCLV90U4W3OoAAWLs6kjHlf0DvQPtewFHdY4jAedPjpmGjQLLmyLUyk5carO
         sDyLqDEeeOd6ptR6wsJ0HuiNUHlvhrlJAxNPipsB13Q+VW5WPngHA+cczCpSAU2UZMjQ
         PbgsmYdrK+YNthYJpeDxqG0grqy3hH0/m+qzPITZgsUCYHkBwde6Qk9a8BsGGu0LBhgV
         R2oJzek5VgsOV3RmS/s72f58zIPJo30q5BUZKw5h3yqZDrn9oLUJ2PrqwCyz4zdqEnAK
         CrBQ2ZOiWTb+GYnu+Kmpa1gVEPtdwsva6fPrX9YodHTdDpLpw3mYixuqrVjPHl2StSTm
         tDyg==
X-Gm-Message-State: AOJu0YwdeIFgYoCqlNWujOMDoN9W/8k6xmtcDiXxoXMDTpE3M3rTCwRs
	7LLcOa8WfrGQK0bMdlc0Bi5ymDQooXgCJCRO1pvq0mHA5lOOqax+iXIR0mu3OgG7bnj+ITvFs1b
	ZwzDBeZHZ9IWK+xO0jnisKomIszoc06rXr7qqwyoQRXF8q5Vggal5d0lBBvLFBjhWez3wNDK64C
	cUcDM=
X-Gm-Gg: AR+sD12OdzWeB//+nWrbYrtgE95PWatE5/ea+ITzWSSrp9IFQsxUhkO+A/XbRAZ8Z4W
	VAsMiTIMRWax9LIHep687m/wNtR0DXHTKk40vayKJ9p6quclcx9KLHcTWkJ45Shi/HgCQpxd5Qu
	wXFn0QVMC84PObuuz7oIdrPM97I1m1Ne/R/+w5duN70t/iPDN9tSER9m+VziV6YAjeNMYAjSltw
	ASkl3BZvjna3umvvT8NDK0uFp8WJG4DTPdjp+LQywehEUroSqeF5qCAXhOqY4jBXDXsA9sA7RrK
	wx73xMNFZKNxpRiAHg/FwiLFlBmOrsT/j6zNHktafISkBs7zxg8nt/3GdzrMkR4CPHMVxRAijmF
	RJjJM3k22Sh8c1eR14mTNryfFrZ//9w==
X-Received: by 2002:a05:6a21:7706:b0:3c4:397a:69aa with SMTP id adf61e73a8af0-3c90d464f2emr41431637.31.1785411840843;
        Thu, 30 Jul 2026 04:44:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:7706:b0:3c4:397a:69aa with SMTP id adf61e73a8af0-3c90d464f2emr41403637.31.1785411840433;
        Thu, 30 Jul 2026 04:44:00 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7273cd9esm20961598c88.13.2026.07.30.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:44:00 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 3/3] doc: Add org.bluez.ChannelSoundingDistanceProviderManager documentation
Date: Thu, 30 Jul 2026 17:13:40 +0530
Message-Id: <20260730114340.1576049-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730114340.1576049-1-naga.akella@oss.qualcomm.com>
References: <20260730114340.1576049-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfXz6IRPVzwZ7nQ
 xpOYkpndqCgJ1hzQhDZOINXCgE5hZncP/RKM3na9mjdG5ILqI8Zuq9nSgm+lh/KMiWBRHhzTM3c
 toJtiFUrrZ0AlJeh53dsGgPq3uH+69A=
X-Proofpoint-ORIG-GUID: 7VRjpgStyvGils4WCxC0osbByOnZl8FN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfXw4qemi5rDLSd
 lJgOUgKvOpsQ1hyOwu4KVH0tekOfP0J5d/YCOuJBoaWue5P/Kt5jDxPdSKizmgwvnwkztUnOhMU
 Z3S9/zSmpg+r9O8/sii33zG7pgenmBrIt7c7eXMAf3wGQQxTeUrU8Gvlje2G8Li6K5kQnrSRJB8
 gxFMz/zlAL+19Aa4NYFslDNJqCSvP9QMo7J9rYufVKIdw2yO2qHq/PdkPProVzBODqXF1sSL+So
 8g1f+QwKJUA2HmEKxA2/gjQBvBxRrCkD7M913Kr9DP9qv653kyirYvAvnTl3nplGTXtoLU41KEC
 hZ0yRnLIRhEJpnv4kfdtz8wIG/83YprE3sfI6kK9CdAUGo4+9ztudGnKj7JDk5XImOL89EYPnv0
 qpettp8im52yglC45XBlz1RLH3GoB8ScexuyPKPlc3KV3bEoX0W1nvhEXcO7z3aB3arqnLJk2Hn
 /T8J+1cnnUz9lgU8lCw==
X-Authority-Analysis: v=2.4 cv=ULPt2ify c=1 sm=1 tr=0 ts=6a6b3901 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=znn-LfXQw_q2FcJjUlEA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 7VRjpgStyvGils4WCxC0osbByOnZl8FN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300088

Document the org.bluez.ChannelSoundingDistanceProviderManager1
interface, used by external clients to register and unregister
themselves as Channel Sounding distance providers via
RegisterDistanceProvider/UnregisterDistanceProvider.
---
 Makefile.am                                   |  9 ++--
 ...ChannelSoundingDistanceProviderManager.rst | 53 +++++++++++++++++++
 2 files changed, 59 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.ChannelSoundingDistanceProviderManager.rst

diff --git a/Makefile.am b/Makefile.am
index e5ecf232f..fe2bb6f2c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,7 +407,8 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.ThermometerWatcher.5
 man_MANS += doc/org.bluez.ChannelSounding1.5 \
 			doc/org.bluez.ChannelSoundingDistance1.5 \
-			doc/org.bluez.ChannelSoundingDistanceProvider.5
+			doc/org.bluez.ChannelSoundingDistanceProvider.5 \
+			doc/org.bluez.ChannelSoundingDistanceProviderManager.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -450,7 +451,8 @@ manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.ThermometerWatcher.5
 manual_pages += doc/org.bluez.ChannelSounding1.5 \
 				doc/org.bluez.ChannelSoundingDistance1.5 \
-				doc/org.bluez.ChannelSoundingDistanceProvider.5
+				doc/org.bluez.ChannelSoundingDistanceProvider.5 \
+				doc/org.bluez.ChannelSoundingDistanceProviderManager.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -541,7 +543,8 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 
 EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
 		doc/org.bluez.ChannelSoundingDistance1.rst \
-		doc/org.bluez.ChannelSoundingDistanceProvider.rst
+		doc/org.bluez.ChannelSoundingDistanceProvider.rst \
+		doc/org.bluez.ChannelSoundingDistanceProviderManager.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.ChannelSoundingDistanceProviderManager.rst b/doc/org.bluez.ChannelSoundingDistanceProviderManager.rst
new file mode 100644
index 000000000..09298fe4a
--- /dev/null
+++ b/doc/org.bluez.ChannelSoundingDistanceProviderManager.rst
@@ -0,0 +1,53 @@
+================================================
+org.bluez.ChannelSoundingDistanceProviderManager
+================================================
+
+--------------------------------------------------------------------
+BlueZ D-Bus ChannelSoundingDistanceProviderManager API documentation
+--------------------------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+A Channel Sounding distance provider starts by registering itself as a
+distance provider with the **RegisterDistanceProvider()** method passing
+an object path as the provider ID. Then, it can start exposing
+**org.bluez.ChannelSoundingDistanceProvider(5)** objects having the path
+starting with the given provider ID. It can also remove objects at any
+time.
+The objects and their properties exposed by distance providers will be
+reflected on the matching **org.bluez.ChannelSoundingDistance1(5)**
+interface.
+
+**bluetoothd(8)** will stop monitoring these exposed and removed objects
+after UnregisterDistanceProvider is called for that provider ID.
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.ChannelSoundingDistanceProviderManager1
+:Object path:	/org/bluez/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterDistanceProvider(object provider)
+``````````````````````````````````````````````
+
+Registers a distance provider. A registered distance provider can then
+expose objects with **org.bluez.ChannelSoundingDistanceProvider(5)**
+interface.
+
+void UnregisterDistanceProvider(object provider)
+````````````````````````````````````````````````
+
+Unregisters a distance provider previously registered with
+**RegisterDistanceProvider()**. After unregistration, the
+**org.bluez.ChannelSoundingDistanceProvider(5)** objects provided by this
+client are ignored by **bluetoothd(8)**.
-- 

