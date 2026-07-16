Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813B3451DA
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184536; cv=none; b=DD8xTScmqSDCjZr2YUTBftsGy8GJJwqBDaOOb7GW490TLN8RgeBZSPLMPjxM6MBfTHf+B3Q+xdilSzFpseZgGo+8IC04bmn563dpnDTJjnMOqtELI5RpqJrLFaIpVey6ogKXHo52Ermlds7b+aXB8+aATHq6YZv9pBz/4Vf9UmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184536; c=relaxed/simple;
	bh=zFONZ0SRe7WkhZRuT9uWlZOptXMqh+uO8pfHpOIesgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nF/r2c0foAD1ao5heJVrkWuP/IQ1eCN+1nTV3uZAGM78C7RxBSuCa93eQAHwlhvRNGs5KV+6o6gA9BuEDy+lFRZjRm5ZIYE3JwocMGO5H/auC3aJjbl0YTobHO6OeDy0L1fBNBfHKpblNWD9sfj2EUlr2zf/wiJJK6DWfIw/LfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRtP6VY+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CAx6VCvw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KRtP6VY+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CAx6VCvw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3wI8T1451622
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 06:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JuPICCd587BKQVhXl9VstKxNozIjQjzX3YV
	loteCUKY=; b=KRtP6VY+mFEzaYM65lr47aYevQ7ZztX6JT1sNASZPIFhAt4Co+X
	vQdmh5ktkfvTdDprkfCPy4/JztunwBWX93xD8cuqfLOiSmO47jNv3DNaOOE6lfgu
	KDPGWvyPWSN7t3GkU8IBtuAieXYg2XcXqPblZb9jhWl+x+GgOiJZtQ8JZbwPmvg0
	lf5jKe/ztZnjJj//e6s5e3IpyuquXl8nwmFuiH4+0jBvccCI8vB77iK9rrJF6bBf
	k7pzvZ0hwJo+59h/rQJSAPNm0gCFHmE5b20HyLJz9Ai4DSq9OGwQ6bkSB1IsyfJf
	6rhuJcdd61iYuyE3jnH+ZaZr8zZI0u48u4Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fecnyb28g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 06:48:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c916d17dd43so10370351a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784184533; x=1784789333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JuPICCd587BKQVhXl9VstKxNozIjQjzX3YVloteCUKY=;
        b=CAx6VCvw/tuRT5glC6UDcHQiSOvgvIN0+XPrzjtglUHF8204H828kVk6VoHdGCtRSO
         oEEI3xthFqSNwKewtx9TaceA32gUIzjBVgLYJg88ZjY27Ed7R7OEmHBCm65Nygr0i1kI
         G9H/sRUVQeLcIzvvTktz6FDmcEmTMXeJ5bq8dSgRAPhEZx+KcAmK3AIk5rZPsbYRVrHk
         8qkR1+CG+iTHBakUlShsyY45JUWtF9Y/V+Pr92W4bjJnOejmhsvPo3c6qQaexK3V966q
         GA1/U3Ay5nlr/WqEkp7nPEDroQEpQGDH982PqZFF8QFBpYptBP5S/2a406NR4kWUAtOJ
         R4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784184533; x=1784789333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JuPICCd587BKQVhXl9VstKxNozIjQjzX3YVloteCUKY=;
        b=Inw1+SdI4KSdCB218p5HYERfG9/a3pBtVVsiF3/k9hcBq/cjIsH9NDo7PR+Uk8Ef5W
         99C6UdL2A40YZdom/3PqHHOdJTynzjiwcQ3+PBA73X0ktqSF6Ae8kV0xOYt0q8MYCQEU
         S0qrlMAGbVlRIGDjR/auyBWhGX+LwNllyy/REohye/SnFhVvTNUCzR/utNh90PLWqmK1
         GGY9xemmyPUfKgptSTWYMgS4S/5FTx2vbvMDu/eclpc3//95oGOff4QXJ1xm2dlL4yBc
         bQHO2tcXw9A/RkOOHvxPZdyCTbHD2xpIU6lfzwCUAlDHb5fidAbFE1annVGwZga+wjen
         XRQA==
X-Gm-Message-State: AOJu0YxvgvOMTNh01U78uVUmwPvuQLKmHZSv3xLdhbWomiR00irY5JZ4
	V17W5AgOPgc3wrx8c9Pr9VZo7v54RL2wlCRYYyx1glDdkFGM2Oe4uSPfrxXrs3XHolbDlfwbJip
	f2bH+y7/DBjusdc3h4XWGYI8lR6LXhrtEKLcZcg67IHVSc90Gcg+ImpdR1s/+0/zK9r13PYqQgO
	hBA+o=
X-Gm-Gg: AfdE7ckyydMySLOIh7IDSrIYWfZZj+E0Wg6An9nvbbKHc8E53Sx5tgdkrV8jj6VFSlZ
	aiiFkwInL1xfPw3yzn0hFTTD1d7R8jXFyi3ov+sl5mnI29y2gLPnpLUyQBbJs25u/ao9vBgNQYf
	WFfOzHPVVk+8y1LfYTSsKK97zbnhBm6chMRIpwrZ0DoNtlVHlzsqaF/BELO4Bdr5Lsl8BxM4swB
	AbCUG5qomHWIvZQtRDmwWMiZz7zjzAdxTfsRD1cMimFkkZK1tQvoZ0oEHK7I3OwFN9OITdRh0Uy
	04B3sjxV4Pg6g8YHiwkQliJE1JH8xhg5F+MO8iCNuuzRFoLztxp+mcxz0g1y/nl4NFUQ4kmaeAm
	jW0E/YiAZBBkemZ1CaPeXyk9lqU2gsA==
X-Received: by 2002:a05:6a21:3cca:b0:3c0:9c19:65bd with SMTP id adf61e73a8af0-3c36c4983b8mr6332200637.69.1784184533111;
        Wed, 15 Jul 2026 23:48:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:3cca:b0:3c0:9c19:65bd with SMTP id adf61e73a8af0-3c36c4983b8mr6332170637.69.1784184532594;
        Wed, 15 Jul 2026 23:48:52 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c09adsm8617357eec.20.2026.07.15.23.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:48:52 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1] client: Add scripts to start cs Initiator/reflector
Date: Thu, 16 Jul 2026 12:18:42 +0530
Message-Id: <20260716064842.4016066-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2OCBTYWx0ZWRfXygZWy2rlFedE
 3Fiju1aZKiE+b9yRCebd43b14OIbZNW9LUs9gewaOQodSvcuEo5KeY05DLOdRmSfoiGqsbu1Ek5
 /s9pjONve5Sc6byDVbEk6MCpe1qsFh4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2OCBTYWx0ZWRfX3CXlTiUZWin+
 8JyhUpKDsiGxmSzJfih4W4JhGOiYxNEqcPkfW5/7Pi6QskFU2S33v5EcdRbcVbCw0216ELxRpWc
 A9mx/n787fAHtH7DPL/2Z5OViuhqyOe2kNt00V4gJAphpS4xY7Z9gdI2zN9jA7P7OosBFem6kfK
 4oQDOjYTQ69i8YTRN6TjwtBPfWKsgqT5fupO4Fz12yjtEUjDnzi/6jCwOBOE3JtOjtDUcfGoqM6
 IQ2SxDjGQXC6eVAxI18GohrS3Pl+q8ItPeN09vexymeSNLdceN9DoXbCNe72s4gaY7/45xkNuGL
 qzsWOSuuSOfyspyr5krYgLx+nxG+j8jIdVst5DCOgjIOANCb8cbYsW7g0csBsE2xs64d1vus7At
 FIA0q/Xg68Lc1Rie99DbHdlOuFbLXQfmkld640khV+PxPzAtHRfI5z23DojwCI8QTdBGWMqutFQ
 j8VQL7OLfY62WkZnF7Q==
X-Proofpoint-ORIG-GUID: xtJI7cB_FXgw6jj0WvUu-wuu-mE2dPiV
X-Authority-Analysis: v=2.4 cv=Lt2iDHdc c=1 sm=1 tr=0 ts=6a587ed6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=qzBZ512xQEWxv7nKamIA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: xtJI7cB_FXgw6jj0WvUu-wuu-mE2dPiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160068

This adds sample bluetoothctl scripts for cs initiator/
reflector.

cs-initiator.bt sets up and runs a CS measurement as an Initiator
cs-reflector.bt sets up the device to respond as a Reflector
---
 client/scripts/cs-initiator.bt | 23 +++++++++++++++++++++++
 client/scripts/cs-reflector.bt | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 client/scripts/cs-initiator.bt
 create mode 100644 client/scripts/cs-reflector.bt

diff --git a/client/scripts/cs-initiator.bt b/client/scripts/cs-initiator.bt
new file mode 100644
index 000000000..7ba1a5644
--- /dev/null
+++ b/client/scripts/cs-initiator.bt
@@ -0,0 +1,23 @@
+power on
+#
+# Start scanning to discover the reflector
+#
+scan le
+#
+# Search for reflector device, stop scanning
+# and connect to the address.
+#
+# scan off
+# connect AA:BB:CC:DD:EE:FF
+#
+# Set CS config paramteres for Initiator (optional)
+#
+# cs.role 0x01
+# cs.main_mode_type 2
+# cs.phy 0x02
+# cs.sync_phy 0x02
+#
+# Start CS Procedure with the mandatory paramteres
+# remote device's address and timeout value in seconds
+#
+# cs.start AA:BB:CC:DD:EE:FF 30
diff --git a/client/scripts/cs-reflector.bt b/client/scripts/cs-reflector.bt
new file mode 100644
index 000000000..e43357cc7
--- /dev/null
+++ b/client/scripts/cs-reflector.bt
@@ -0,0 +1,22 @@
+power on
+#
+# Start advertising to be discovered by initiator
+#
+advertise on
+#
+# After the Initiator creates connection and
+# device is connected, stop advertising
+#
+# advertise off
+#
+# Set the CS Default settings Parameters for reflector
+#
+# cs.role 0x02
+# cs.sync_ant_sel 0xFF
+# cs.max_tx_power 20
+#
+# Start CS Procedure, note that in reflector role
+# we don't start the procedure, only the set default values
+# will be updated
+#
+# cs.start
-- 

