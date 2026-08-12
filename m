Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B0418346
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529055; cv=none; b=gkNmaz+5jCd37GGn9LGj2lo90FFU5akn+bfZMiE/KviqZ9a1LDDaNIe/MsK3yhwWpoBZg//XM516wg4YKZSPBOuVmVTLdf9OKLiMwPmH3D+D9UZMPYujTSWbZh5+jW4WcDnABXUGR6fjhAI0nSMy4TtFreiWarAAHaRTcsGSLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529055; c=relaxed/simple;
	bh=A1G8S2VE/jfYjmjOHNiuDFRP3A6mLoU6hfw4B4FTlE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQVX4s0mI/dQOyNofp6pR354YD8FPdFFrH9JZxtdRBL+M5FAW70bKEMYVIgVxoQlYhJFcaanmOvqJEFXMbHGqByoYq0YIMqdWi4le5mWT3lgJjO3HvS5EA17juBmJ+1wmNEqVcdJF7Apzf+l+VVpOrM+uJUTdEYoU23TiasCLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ghLXr4Bb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hhG1pSli; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghLXr4Bb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hhG1pSli"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9g0fb3481580
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TgTGNnVQLJy
	l0h0URL3xV4smi2FOUVH9fQsOQboEQqY=; b=ghLXr4BbpUoUUsTCkm3/mo9WIrC
	Ih5BwNQkOtkbEwXGwq3oCzDefBJ7Vd5YZv2fwypsiVNeJAOyExdcKijZBfClGfp0
	8PQBmRRnyekRB8FAEg4GpY5gbQzvc4yJ38V3GcW5KV6mXz9dfwA8EhqDBvl7/K7U
	LIh4yNEkn0gkEdmNpblRGfGpw2HGkBI2JQ0faTsOYWF3Eng6AobIrG+A1Dg/8uvA
	WxZzoNcQ/ZcpmhL37t4qYms57x/pxy7uNf8C9TBvpUcCOVXpOxCErEOeCpLXGfh9
	3eE4caRY07CfxhUHuuz4nPh/k+hKOqoO8f9BUCnaeJWbXQ9YZUG8tE0m/pw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rgn43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1047325a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786529051; x=1787133851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgTGNnVQLJyl0h0URL3xV4smi2FOUVH9fQsOQboEQqY=;
        b=hhG1pSli3ybHvbXP7UOnvmoWFlu2LRYcRwOhcXBVEmkd3Csgd2bzPo82bJy+OXi2b9
         rDiEJeJ7haAagXMo6bUbp1B33Qa7oeYUNNIRLt8liI9kc6N4Zmnt5hWC+274siloOPwW
         3ulB2Le79HUhaCdGWErAw4QO494gURJKSLGTH7frIqLz8PYSVWIGXzI1ycms3hnJw4PY
         1yyd7e2MdsvNL0Fu/EgP3QdsUxNXXfjS/9XlIVQMxggzNXl6h3FnrjiMW1m4/2c+YKvN
         FYchf/Z76j7//hN15+de0v71qFXgOlecmvPbci3WVyxH/b9sZs24gHAaqxrwiPshmJpr
         iNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529051; x=1787133851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgTGNnVQLJyl0h0URL3xV4smi2FOUVH9fQsOQboEQqY=;
        b=cIiUY2M06gBhgvevzakSj0o8Vcg8rJvuk+TharqroTd1fGwgKXwrtKQ8knfTAGPauA
         FixPfIHHfzwEMfgo9jkz4a0KgyLfnqwmbyOmY4gIpsDtFPX88IX+02tEmGjdQAoh9JBV
         2OTfXVLwpz71r4zsr65sU8touKKtBfjq08Juo5QwYJVTaCEhUUn+YMX6TMzM8YPVDgfu
         9SL9Tlu+lIZej8pjRl5w4wPU58C9FLumBPeXBX/kzJovuyOcf/uIOzjzmu4L+LfTL0tY
         aYWXnei4LIYaXaEbGOuRO0eiS0yyAw7iLpHlq8oIY6tBnULA6TQag3AMOBYR6oRhj+Mk
         YAVQ==
X-Gm-Message-State: AOJu0YykETboaeFlGkuAk/zhK+X18O9p6we6vi0qG9Q7YwWJhhiqMvqQ
	WnQojcH6funVrMxODURB43YbdfxthUeLhSpPDgCUsR5ZpQtkGhWjdPvJarNKc3qfv7SmHQY6gZg
	6VowUYSUzqnq680eI6unwtfgl0FgQUrhliVKk4WlnGlQfywDxs95HzwjEo9ysR/aidUf8aFFqo6
	aWRHA=
X-Gm-Gg: AR+sD13PnXbC+heVS8NwnK63w7U81FLBV5cX6YoU5H/MAviXMARBvMu2mfhcQvxyt/f
	aLkiCyrMlkdO8u8nnbYQHrRkwSCTTSeE6LsJtkA8nQ7EUKA8R377sNTHniTBm3G7P2kpRf17YNP
	KpzOcnZfEFC1S3pyxL21kIpq4QPSSO4E6ycWRvp+6iwaP0hHqG+/QzUUmc0HwKIsNyeRXZwsZ61
	T6CJg+vEEaw7vBULUp7dE9PbyktQWzIefvK7BKhS89vByNDaHZ2neoumRQa16gwlRAJRGZD9OBY
	b2f9D8PVsZEM+uyFeHuCt9AD59urLCgwrJa/QjBW1C9HuL4U/goNBsXWkqs14kd5d2ZOQGxGDdP
	VQc1GIpUpc92ZgT179OGxQ+jYuqOAlA==
X-Received: by 2002:a05:6300:2290:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3cc3f884f3dmr4187259637.36.1786529051035;
        Wed, 12 Aug 2026 03:04:11 -0700 (PDT)
X-Received: by 2002:a05:6300:2290:b0:3b4:b276:a789 with SMTP id adf61e73a8af0-3cc3f884f3dmr4187173637.36.1786529050587;
        Wed, 12 Aug 2026 03:04:10 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e2aasm11069961eec.14.2026.08.12.03.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:10 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 3/5] doc: Add org.bluez.CSDistanceProviderManager documentation
Date: Wed, 12 Aug 2026 15:33:43 +0530
Message-Id: <20260812100345.2956271-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
References: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfXxbTsnjyhgGDS
 GcEW8N8lOpRNQPW1IKpjGHGJe86NqZ9B01f/OvxdAx2sM3ieCcDKk8MTZZTDWL+fry+8T+fqk2m
 6s6fSVr+glszp3SssbMbLtlVZxap2BnHU48NR/bVEcajI7ECoNJDIf9X/fbY6/dxEWSGmQNd2wQ
 HaTgBf2xiY33Il3uN7QZy8TYbtOU3bVCoQaZocUGcCpsC4rz4/fMgnoN76/BHZjDDAUW3S7lwoe
 /VwK0H5tUyCpoosR1lErDgqpg13czRv1F9bqLY6/1kTOuTyxgqLbR55DRnyP4m7AfD+vxDKqW+6
 XvwQFn4y1dNaRdJaKI9UfA/ynt4WPbc20Tqe/MxR11aTA39ZDhvLkVUAHgWK6/5NC9nPAwyuMf8
 cWecnKIAQ+xSpesiZZtaxorSIFf6jzMYDos6WWBSq7IksPKXVEqNDcJ2pvLNBKNA963pP0y7FWB
 S2NWSz/lHpcBgd6amEQ==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c451b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=i9JKuvm0-SHVBVKBPVEA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: k79TZCa4iFaBhusbkNJJvPvPZQJWjhW5
X-Proofpoint-ORIG-GUID: k79TZCa4iFaBhusbkNJJvPvPZQJWjhW5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX/BaaEtHEwgnB
 Vh7k22F/FXdrhx4Z86NoDmI/PT6X5hZ4naX6G+MY/R9ez8U3dnG5S8FJWNRRroYkPHa0nvxhzX6
 kkMqVayxkt7Ios7EEyITjuCgTbXCqRk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120080

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

