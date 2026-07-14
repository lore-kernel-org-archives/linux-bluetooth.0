Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BEE35DA6A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019055; cv=none; b=hkED8Q37FELCPqHqhCHalQxGELyJ9aGaYlZvVJeGJSnkrtPwbxQofIsYu8KysIG52K9nbfXVQHGuyit4yO7egNevCDPOSRhRbpS4pHY99v+5Bq3k5RK9AOEh0oOknyrq9lAzAkKaZ+q7TWCjm1TnBM5wglhbQw2fDAnNbcngPxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019055; c=relaxed/simple;
	bh=is9HK1RhKebh8Jvjjgtrhc4+gGDqe/Olis0PToz6otg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GaTBBjsgEvguPxqkDrd+iFeuyZNV7xuDyg1h3qc67JgdhZysrL2DTwkSDgTsXfpQstJreWQNqEk4MPFP2RVdfzTJ2NujRyuO/ADu6x5OxcCtPJrIJuA/spUuALF4u19ey//Ql6nUs6qkWUS+SNhixvV0+XVjJ5KzOigzZavwCXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nVIDXbhX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jWx1CO6L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nVIDXbhX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jWx1CO6L"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SX403954638
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Yj2hscn7k7u
	Y8kx3m+5Yssu6uxzXyVZJz/lt2R7asWs=; b=nVIDXbhXNCFJ/sQfN5rHwPnca3A
	82DBqbn+ZCziR/FW+jII8+gOFoFDedDDh/svU0CqdGm5fUg07sZbNVbRBuR11TPU
	pV0ZHQH5bn8MEqOZh0sJaS0xUv+Jgxujqr7nHOj3xxtEvn10ArzxwjS1R3Eqo86u
	vAKL6NHB90zE+yESioPZ8wNUdhQowNvsC7lgJExQRB8lrv3v2ET/i7zbfUqc1FIC
	vcVC8jVp2abk2YaQ9X/CPzJzhQfZxC0iyWU5SLFmKJB/i1eoEYsBg5U9U7qTSdzn
	UIKLttRoh+VY/WQIn/7Mbt3DPBv7VZyhlIuSVwr9IBH0UAZZGYU7nKWxZAQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44jtxy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so6217859a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784019052; x=1784623852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yj2hscn7k7uY8kx3m+5Yssu6uxzXyVZJz/lt2R7asWs=;
        b=jWx1CO6L96ZZXr5TNRSJH0OX1Y7I2HL9gpVhzjVW4lhfViCdpaqzYowxpNb7z99RCI
         7PxRaIxgobS29JAptY/RXZgfJWYaBtdVaNOKI8cknjmWzQ+Nx8OAcxpGOUP2vIvVSRwY
         WKXpDW4kaLAahv0W3e1wkPTaJkTq/GJF3+ig95BbIAR2xLyf+V1/9gaffSEHgohGGg1H
         LzP3gcu+6DhaCL7ndQxmS4pLa4sJzYAhGyTDuPHTdfWOpcPYDpYaLqI6uxNoyp4Oe80T
         /FtWZtJ2FPRaI65Ckz3YvD5skhPAqXe0IfdGLsG6nM9lhnStsoAOzfAQkFpZ6uBD1Lzr
         xr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019052; x=1784623852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yj2hscn7k7uY8kx3m+5Yssu6uxzXyVZJz/lt2R7asWs=;
        b=XpPfZxZCp9wMc27X8QAX/YOgQXmM51pQ08rniikMNeb6J931XMucaT6u52lWdKrWhd
         oyGD6VbzjvoRHCyKto2ktkQdrZ77N3ZFeeJU+XGuePTqLplvzCeiGG5OSreMrPu1s1kL
         OonScasevxa/7ORbMCUX9Is1sGFXTc7JPFjzUNvxfqS1BCVGUHU1iMiuJ3jc8mAA45jo
         179vj86gHdIk2i9DZpuNP3N7TSX83LeHPvCMLuX7hXY7Y18+8VehUEhHitQXdA/7edl3
         xJrhN2TJhBX0n9PmsQa4BBx3PLXsY/zW+TQhqa9C9/NsE1zK1qc+To8kAkjgr/UBFEPE
         /wvQ==
X-Gm-Message-State: AOJu0YzcRxi/rpumk/nMBSQXrytrRjfUKJOv3Co30S07jPuaRPeA2UdH
	aDwKyTcUZEfpOOUP2qW/NYuD1IXE/mEqvBHt0G8xkGtbEcvIIJSXgJNdZsyHDHJn52MAbwDiP1U
	ldI0Q+fxrsUrvmk0s9bVEHunYQ9FYOIvPss0SzDNVfJ5nrlZKUKBct+S/KWCz1t39gTikhort8R
	krKsU=
X-Gm-Gg: AfdE7cnTU5DMPMXQSl3+u6SII59Ku+yVCTQchKTFf+yVRYfUjbKyHBtGvlg4fUM5Yuj
	8Z7gBcGBke3LM0BCh2GiY+aPunwwq7zcP5FIu3dTyzCxAgM90NlmZhZbVTILwSXGTpzlJ4cfSvt
	ibWIbkB4lbiabXx7gOiWyvF8P0LDHY0Vw0oKlM2heExlYpbkJ+9yitRt72Y77Oyi40CBgL4ts78
	/VMwXUFxJmxnvslfLIeZl4RP1Y51bun0Shynstdprgu1E0wmnefode/2MzUY3bxdgIbAmzWC/gg
	ZZVpgnZT2TqynpC4gUzddHU3StxHViOf4vA7a66+qIFZEvsiBGBVqbfyTijI3YJQ7Zn217F2nr6
	OgSG3GJMKgMB1PAwHDZQiHt7SJZUskku433U2Muij
X-Received: by 2002:a05:6a20:939d:b0:3c0:fab7:bee0 with SMTP id adf61e73a8af0-3c110a1dd98mr16180326637.62.1784019052464;
        Tue, 14 Jul 2026 01:50:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:939d:b0:3c0:fab7:bee0 with SMTP id adf61e73a8af0-3c110a1dd98mr16180292637.62.1784019052059;
        Tue, 14 Jul 2026 01:50:52 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9081d5c3sm27645721c88.9.2026.07.14.01.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:50:51 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 2/4] doc/org.bluez.ChannelSoundingRanging1:Add references and examples
Date: Tue, 14 Jul 2026 14:20:35 +0530
Message-Id: <20260714085037.1285756-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714085037.1285756-1-naga.akella@oss.qualcomm.com>
References: <20260714085037.1285756-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fJUPHFU-_HQXjs0FKgaNp7XcsDRMx5qB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfX6tkgBIgPW987
 pwYIY7pQOR1ItyDj0uC67SnirSyqu02yrosIbK0OnAzUu1kaj4ECUR0sb+w7JJ70f+xIJ4Vo3wd
 7kL1liRSFY2UBD7GOLtWk74YtXIgu1IJNPeYtFPtURSVB1AL+VyD/qwOkr4phOdBIQXNXlpX27L
 sVyEiYTTdY8b+aI2OscnRBwgO9denJo8/bMQz3PjkDUR3gJ4mDFpM0ky+uYpM17ePM2Psu+ed3A
 JbWGTFIAx19GgrW7j9PSWnTQLLcZZ3COVv+EQYTe/kRUnpey0DOofCvAkRxfIngmAanRIIZ/Wyc
 TsJeiiDTbCVdthmvAnjMgFImStrG+s2lRwAZ31S2rzPZZIwb4zFEAjdExCr33gwoIbrziHeUL77
 0NAmdy8bsl8w+T+9EGO6rEV9P9A3Z6P7gROCi2uIhr3FJnHN7B6FUZHE99WxajJ7OGM9PpmfjRJ
 yEoUbbgcHBgMhvIq7jQ==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a55f86d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=wa7QpaTpAAAA:8
 a=VwQbUJbxAAAA:8 a=Aely0ZK5wPBa5JhZhnsA:9 a=x9snwWr2DeNwDh03kgHS:22
 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-ORIG-GUID: fJUPHFU-_HQXjs0FKgaNp7XcsDRMx5qB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfX7+mwir/T1J/W
 jG4tlYWSKySYGQDP4Aofqr18SolWHDJKF3gIsdCAOvtkdyr4nsfm8zGSRFKMTGckOc1aLu/nT8d
 cgaze0JcQdz1qyCVQzxxcaUKqXqVPZ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140091

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing the corresponding bluetoothctl output
for the RangeEstimate signal
---
 Makefile.am                               |  4 ++
 doc/org.bluez.ChannelSoundingRanging1.rst | 66 +++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 doc/org.bluez.ChannelSoundingRanging1.rst

diff --git a/Makefile.am b/Makefile.am
index 76c4ab5d4..84d0ff1c0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,6 +405,8 @@ man_MANS += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
+man_MANS += doc/org.bluez.ChannelSounding1.5 \
+		doc/org.bluez.ChannelSoundingRanging1.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -445,6 +447,8 @@ manual_pages += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
+manual_pages += doc/org.bluez.ChannelSounding1.5 \
+		doc/org.bluez.ChannelSoundingRanging1.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
diff --git a/doc/org.bluez.ChannelSoundingRanging1.rst b/doc/org.bluez.ChannelSoundingRanging1.rst
new file mode 100644
index 000000000..0151ac503
--- /dev/null
+++ b/doc/org.bluez.ChannelSoundingRanging1.rst
@@ -0,0 +1,66 @@
+==================================
+org.bluez.ChannelSoundingRanging1
+==================================
+
+------------------------------------------------------
+BlueZ D-Bus Channel Sounding Ranging API documentation
+------------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.ChannelSoundingRanging1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Used by:	**bluetoothctl(1)**, **bluetoothctl-cs(1)**
+
+This interface reports distance estimates derived from Channel Sounding
+measurement data. It is emitted by an external ranging estimation daemon
+(**cs-range-daemon**) which subscribes to the ``ProcedureData`` signal on
+**org.bluez.ChannelSounding1** for every device object, feeds the parsed
+CS procedure data into a distance-estimation library, and re-publishes
+the resulting estimate as **RangeEstimate** on the same device object
+path. It carries no methods or properties of its own.
+
+Signals
+-------
+
+void RangeEstimate(double distance_m, byte confidence)
+````````````````````````````````````````````````````````
+
+Emitted whenever a new distance estimate has been computed for the
+device identified by the object path on which the signal is raised.
+
+:double distance_m:
+
+	Estimated distance to the remote device, in meters.
+
+:byte confidence:
+
+	Confidence level of the estimate, expressed as a percentage
+	(0-100).
+
+Clients that started a Channel Sounding measurement via
+**org.bluez.ChannelSounding1.StartMeasurement** and wish to receive
+range estimates should watch for this signal on the same device object
+path.
+
+Examples:
+
+:bluetoothctl distance output while a measurement is active:
+	| [CS] Distance: 1.234 m  Confidence: 87%
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
-- 

