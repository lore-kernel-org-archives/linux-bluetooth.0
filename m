Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB936B937
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481349; cv=none; b=EdH0ivnrkotQUltazkkhe9brUXynpwWiI/gqMQtl8A5Rz2agk+EkjSHr4vVFHCb2UIScoDhFgCX+uD8bZ0NBz1JXBP4I2G5+QF0R3UCmigD2JqO9dCF8AWIsxLY9aK2gH4TO4NqCav34+gTUOaNaWHMCkOXOVPcjioqFrMeW4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481349; c=relaxed/simple;
	bh=A1G8S2VE/jfYjmjOHNiuDFRP3A6mLoU6hfw4B4FTlE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWbkyxn6gr+vi/GPCxwOhrHPzudFNzMSptHEj6pUT9l6vyl3dmFDB3aaTmL9KjSJTp9RsmUYI7qz4S0HLeDdwqReYmmw7v9G4RxgrlNXmB+RTuxBWRQB1eOr5Inglgd2YZggXw9pgmO6gXCMAbrBEOnD4cer5EyCOAs+hRtqtnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n7uqPs8q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N3pwqsur; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7uqPs8q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N3pwqsur"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V6BHpx3310003
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TgTGNnVQLJy
	l0h0URL3xV4smi2FOUVH9fQsOQboEQqY=; b=n7uqPs8qwWVhQitAUPWxsGHRWRv
	BjyhVqUj8WcuCm3hPuoA28VQDe1ZBCkid0CFlWseM7yAYU5t0m9R7INTXxpWwSi4
	tfsB9Vk4YxNGvjALSrmIBP4Ail9LTaYzHyccV7yVzYIepkMo2WaTBLfbdzjsouIP
	MTi5i9F+fW/1/1APPLA/AWHNxuyy+o5UU+AhiZ/M3W+Mzh8UGOtuOrsCWihvzne8
	jVjQKNJImCc3GR8yI0cNPXuRj7sme5u2ehcyK37ady1APtck651kv4qOqCKqUxVk
	Q/QDs0PW8PVB4AQGGIvEI5e3blYEXO5hAT53nFol/RznS5zMLx2YsklybZg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp7g86sk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc86a9ef97so11896235ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 00:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785481343; x=1786086143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgTGNnVQLJyl0h0URL3xV4smi2FOUVH9fQsOQboEQqY=;
        b=N3pwqsur10aEt8Tt5DHu3rYuasCOOjPc1g5twfwjZejvlLFg/PjSx9yk8WTzMJ/+JK
         Imrho1PH69GAzBZF4OWcDTGngYM5hsKK8RW5HuU6KmLLFUJ02qIrYkozoF0eIHYSRh8L
         jXLvyUFNZW1ii9evTWJfxSHZsdgUiYjQAS0oQkkVjD+oC+XYgTotYCmfHmjqRPBqfvMP
         crWLnj2dK1EuOLXA4rH7yR3cv/huiI0G0xA0syHFhi5kgF8Za3lXUFXzRd2bUwRa2ffL
         de0uLlynmEoT3A0yRNDBOKTZFcbScSJWmAKLfWOr+rANiseeobL8dhy/vaR0V+PWQTX1
         5jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481343; x=1786086143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgTGNnVQLJyl0h0URL3xV4smi2FOUVH9fQsOQboEQqY=;
        b=gsUC2m7uQePoxXiS3+zQBrreBJvONWapGesL5KxvbhUFiUnOKjPjviBKJbVpthaFOO
         wIeOO3+mRWcQcwBhMyz3nUZpve/87x65nqeZWtHTFCQaN+8MOVtfEeqPDX4nzYczXZq6
         Jh/GPwb/UsG/3WLxR7OsNx9IsQC/2HNso14HK8CS9EZ43VzZPQAboodQezbHayfXZddp
         0N0Vx8PwMLPcPxXuTJijPXvj18qudz1AS6GcQGvg1JhAiNbw47uPunFyf9+ct/Q+XU85
         CrBOtuq4WW1rsXCwxdMj+rmSvHTPUZ/pyN2bXh6bQgzsb7/SIAcdBKnM7HVCQEcyeNdF
         e7Yw==
X-Gm-Message-State: AOJu0YwHcHiaTY1nStbeVg3HUqHoBMGskfa2NgcnrEQCRcfez8ul/A51
	tzS1XkxS9cwABiGFGQDB7ljeyoVKhFueXV7ukptPNYXI550JieK+HX0rf44WDblcbiKSDfbH5r0
	0lgP8yEdzikgETxg9JRqMslNpjjccrHghZqBfydguNuZKY8MqHH+X5Cx+X3wsaXnfTlNyNKMSN2
	AKeeQ=
X-Gm-Gg: AR+sD11PqyDmtn3HxXxHMNu76GEdm/fUr3/ZaB29rDWmF02jdkGzpi5gtz3tCd2O8wG
	Jd0yu0ezBrv8M9xlsxMX3xsyN1qXsKOu0JNp1ezv3F7LDTwOH5/wU7nbD3zq+AuvSWdW6W4y/mo
	ZOeOFxNyjWmuFyM5V1yv8fvGTpLsx7Jjk6q257OQ++LD4V2sr8sy7v7oUQxk6O44O3zBukRfdAc
	I0xmfTay1wtivpyeTaSbKyDRxmXk1KGqhlq/66EE1i6q1qo1KAjpZ7nQqi+EGRYkFMbLkuAhh+h
	omISCKeRst8j0B69yDqQZuULO0YEf5wUpnZ1/rWLliWVDuV3Y/kXtmHpIBmLYezBHPjKfVVHWQ6
	zBiEZLJuY0Xtv41GyfJAptj0LTT6AjA==
X-Received: by 2002:a17:90b:4c81:b0:38e:7069:7125 with SMTP id 98e67ed59e1d1-38fb13f1febmr825755a91.42.1785481343010;
        Fri, 31 Jul 2026 00:02:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4c81:b0:38e:7069:7125 with SMTP id 98e67ed59e1d1-38fb13f1febmr825737a91.42.1785481342545;
        Fri, 31 Jul 2026 00:02:22 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab050d8csm182879c88.0.2026.07.31.00.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:02:22 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 3/3] doc: Add org.bluez.CSDistanceProviderManager documentation
Date: Fri, 31 Jul 2026 12:31:59 +0530
Message-Id: <20260731070159.2769120-4-naga.akella@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=BcLoFLt2 c=1 sm=1 tr=0 ts=6a6c4880 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=i9JKuvm0-SHVBVKBPVEA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: IHeLZXrOsDYAx6RbMzC-LTvPU000XmQV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfXw9u6VNpbuSoO
 GXZJRmOLtFq2p8P70lOwWxjOOQ33xLWtfS6TUYxU1d7rVaTpV0T2qhJ9qL6+2FWmTPQ9JDc9q5N
 tBMrtq0Xpb0I3hNILZZQ32xUYaQovqc=
X-Proofpoint-GUID: IHeLZXrOsDYAx6RbMzC-LTvPU000XmQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfXzJmXoRcDrxW6
 WeDWC43zMteO0QFo0ziNoA2w32jmAp0WB/e8btnMdl3alwiavbV6iqoxGAc844CuZs72t56+SPB
 1cTCm99PPkMDsdtiZ3GcA4ULaoZEera1fBfQWwB1S+olAeMEmc+K0kiQnP9dlcbLo9oZIPXZocK
 D3E2F9947r3kwSVK3U8V1OBDhEhLIt4+Hy4uUqmm3c2htrfaknb+QORjrdhq6wvtT3WvYIA6zz5
 /2DKY8TaucPN/fisHEQPLZPeV8W1hcQkPLFn3f5Et58bVQJAq5uMMak+Sq58A0spN/jfumc9gJa
 brWWY/IC6KOl+CPUADZ+DhncrK+QVlu5xDz61N59BcssZkLaWk2Rt4HANd0tzrGjq5+88p28WFe
 LIGeXWcP5tu1WAgUvInnUgBreqHPyF39HRu1jo4JV4L9LJxX/MFkpJ8X/rKRKcwX/ihvBnJ/sju
 dh+1cAJsmzP8Wp79AwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310048

Document the org.bluez.CSDistanceProviderManager
interface, used by external clients to register and unregister
themselves as Channel Sounding distance providers via
RegisterDistanceProvider/UnregisterDistanceProvider.
---
 Makefile.am                                 |  9 ++--
 doc/org.bluez.CSDistanceProviderManager.rst | 53 +++++++++++++++++++++
 2 files changed, 59 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.CSDistanceProviderManager.rst

diff --git a/Makefile.am b/Makefile.am
index 53bbfd0d2..f003b041c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,7 +407,8 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.ThermometerWatcher.5
 man_MANS += doc/org.bluez.ChannelSounding1.5 \
 	    doc/org.bluez.CSDistance1.5 \
-	    doc/org.bluez.CSDistanceProvider.5
+	    doc/org.bluez.CSDistanceProvider.5 \
+	    doc/org.bluez.CSDistanceProviderManager.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -450,7 +451,8 @@ manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.ThermometerWatcher.5
 manual_pages += doc/org.bluez.ChannelSounding1.5 \
 	        doc/org.bluez.CSDistance1.5 \
-	        doc/org.bluez.CSDistanceProvider.5
+	        doc/org.bluez.CSDistanceProvider.5 \
+	        doc/org.bluez.CSDistanceProviderManager.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -541,7 +543,8 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 
 EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
 	      doc/org.bluez.CSDistance1.rst \
-	      doc/org.bluez.CSDistanceProvider.rst
+	      doc/org.bluez.CSDistanceProvider.rst \
+	      doc/org.bluez.CSDistanceProviderManager.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.CSDistanceProviderManager.rst b/doc/org.bluez.CSDistanceProviderManager.rst
new file mode 100644
index 000000000..efc01800d
--- /dev/null
+++ b/doc/org.bluez.CSDistanceProviderManager.rst
@@ -0,0 +1,53 @@
+====================================
+org.bluez.CSDistanceProviderManager
+====================================
+
+--------------------------------------------------------
+BlueZ D-Bus CSDistanceProviderManager API documentation
+--------------------------------------------------------
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
+**org.bluez.CSDistanceProvider(5)** objects having the path
+starting with the given provider ID. It can also remove objects at any
+time.
+The objects and their properties exposed by distance providers will be
+reflected on the matching **org.bluez.CSDistance1(5)**
+interface.
+
+**bluetoothd(8)** will stop monitoring these exposed and removed objects
+after UnregisterDistanceProvider is called for that provider ID.
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.CSDistanceProviderManager1
+:Object path:	/org/bluez/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterDistanceProvider(object provider)
+``````````````````````````````````````````````
+
+Registers a distance provider. A registered distance provider can then
+expose objects with **org.bluez.CSDistanceProvider(5)**
+interface.
+
+void UnregisterDistanceProvider(object provider)
+````````````````````````````````````````````````
+
+Unregisters a distance provider previously registered with
+**RegisterDistanceProvider()**. After unregistration, the
+**org.bluez.CSDistanceProvider(5)** objects provided by this
+client are ignored by **bluetoothd(8)**.
-- 

