Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905136D9FE
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481340; cv=none; b=OysqP/SHHTw2O7LriIYuSsaUOGW7PdZon20xhXj0T488eKYiu539BIsNInqf1U+PVioCmlsmXvpxGSzPi2ZY4bH9gNFVOudfNyw7bUO80RL4mn9IUaa+DaM2MqjlDlwcUPBicKkGIwpc6sJwd4r5JcU+UNBWcTe56Q0y2wa5nrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481340; c=relaxed/simple;
	bh=gyTwQ0ejxxkmFHwUFKLrJjJi2H3AYoK8T416JE1a1fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrsI32RiMNCa+wrvaob8K9oMwK57FulWeTJZ8+h6fU8uVfeXjNQc+wMH9JtL3FPKVO9iY5GQXOLsL7oNWddmlS6RQ0syvQ0kpLTqDxvogCiFfPXOHHuhMLV001YQv/pOr+BzMskWuNcn4jlGjkONY/Oe1WEqlZZVCUXvQLIYAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7QJGHNP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HCksp9iK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7QJGHNP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HCksp9iK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V665X22636710
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ucSe0D2k30+
	9WNVw7YDCgzGxZL9JUGsorHKbxUbxgck=; b=L7QJGHNPjyD9nQMi1nQMZUsPbnb
	A0XABHqBh8ASHLgAqRJ3f0RKxeVEtNjZFZAMgCMKpNV3iSbJARIhFZecpDdI5pr0
	6qApoaGoUjKa09us1QW3u5gRe4F8ysdvzOMhZEyyoDvNy6H/0beZPLaOqGEPUEcv
	xkZuZznvGVF4S7DCo3ybpYIZ5GYsiObz3YDa0SjXEGCbhNc7+Z2hR2Wrud7v/OoU
	e61OhMuXB8J5Vr55nCtPEwpcQpV5KofLvRiURZOScGRNJ+8tjLEcB0XGua4ffXX1
	rPiuV3SKkLj+W4s/uHjnQkagrR0VEe709CglD83Lb7D0WmoA3mFu2vBsQJQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp4y06gt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:02:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38827cee19eso941383a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785481334; x=1786086134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucSe0D2k30+9WNVw7YDCgzGxZL9JUGsorHKbxUbxgck=;
        b=HCksp9iKGt5yI61xo1/iEETqiTA1dPcAZX0fIIF8elA97fu99XADIJfIa32HYFbjHe
         I8hllZfsGfjNtiQT0Lymh1g3tkvoh/x4jGQ+zPtv0CqnJBAs9+uYAxmx/1KCaUljrfr9
         j58aYWrim6pajcYrMlXYE7Eyz8x0M0H6wtfd7QE/6p0Z5+JxszG7LFrcgwW1khUr2LyF
         4Yljlkfgw4KbTvfr/+uDffLqV6EBqQba02GUY4sXt6MdGCwxKPDas3FNuA5Gkl1eJnw6
         YePvTpdH8w8NoZXkmkkYDR2wxNeMNXmb1p+pgMeITjioFbyzaJl6/aVQSQ+MtaMzynIC
         RrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481334; x=1786086134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucSe0D2k30+9WNVw7YDCgzGxZL9JUGsorHKbxUbxgck=;
        b=aNZxDssBMqy8X9rog/CtkRsA1N+en4xA+AD5vbbo1eF2aar4YNCO0wgyaZ5oMXpeJW
         l5hUUM7WXY1ZO11x+JN/aEYDSN3wy2WtgSv/Ntwx5ACo5951iywS5uSDhzZsQtQREdHl
         ymT43oNcr3AxHigujbmIatMgfXvbaZbcxBQp4fkvWhra5d87LzLGC4/BqxQpwarYGVLX
         GybkAeRi0Sb2wHugpZlubRlWgOR5flM9ycqhHkSdKoXk7iuTjpl9kF1cfyzRgviOJdKV
         /3Kq+Z3m3zOE3AhFTFHA3iLKfUBJ7UW/ZavHIiYqR/5/iB49grkxkDBLWYsFnz9qgNvX
         IPng==
X-Gm-Message-State: AOJu0YyHXPF12RuhrNfymgugAPBizMipaCzOTzX4DxNWohV+gI1oqhvW
	qyw5CWlL9wqsW1RkpRgJYOxpGcUljiPgAA6DXPUre+OQ2VHe1EVj7yUXHjuxHIr83NiGzLW9/IA
	OSoKJRvShTGdPEmBT21VSs7fBEN2WmI080dQrG7ivpi2bA07poK/+IgZoblZhmPaYj9Ono1JReC
	2XLmo=
X-Gm-Gg: AR+sD10ixts+S0o9/mk+LDmS6rwnnJGKGDR1lXZ2/WLMU/bY4HAx4r2HaM8B3uMvWcR
	vqKXxzihRiVLefq2Rnu94fCg+vLWvSfHODxH4nUmGnb0rN0oQbzPYoQC8mekfFWTMbgYGkqvBMB
	OYuGRPIVsGcwIbEWvV+lux2KOdUfcFT9CiQHfJTiGQwhHlkSmNwuV3UgwBO4/wIY1Xj1j/VQNj9
	t1/ZvX6CL8AMZDpmIcp9uiTtr0wAWainnz2elzXo9G1EbS8j8L4mfaTbBOKWp9YUncPKHLkpqfD
	ZbZvwsE++OZkh63IOYNDVIG+/LR8HUJfyB4D21tZxDjmIffuuYlH91oJ2fsXBCXApEA1tuNO2Po
	7cS4bmuVAZ6hTDmTC3kyCqbDtPFXkeg==
X-Received: by 2002:a17:90b:3c91:b0:38e:7cb6:5c36 with SMTP id 98e67ed59e1d1-38fb1432fe6mr841879a91.40.1785481333577;
        Fri, 31 Jul 2026 00:02:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3c91:b0:38e:7cb6:5c36 with SMTP id 98e67ed59e1d1-38fb1432fe6mr841845a91.40.1785481333026;
        Fri, 31 Jul 2026 00:02:13 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab050d8csm182879c88.0.2026.07.31.00.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:02:12 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 1/3] doc: Add org.bluez.CSDistance1 documentation
Date: Fri, 31 Jul 2026 12:31:57 +0530
Message-Id: <20260731070159.2769120-2-naga.akella@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=K44S2SWI c=1 sm=1 tr=0 ts=6a6c4876 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=DD9ecsvMZrLkcSy-0BsA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: AeqEk3bc0a2bnzj5wWu2O5bacW6C94R0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX7dpUKnWlaCXW
 HYdKCuD/VVYW9Gvv4til9kdSFVb2aE2Hw7IG18p/eOoWzBGLm4P5VD0JYi1VJtavVc8ufVvhCHN
 fQlMvWIlBifacRYAhk8/3ZMJNZw4Gwc=
X-Proofpoint-GUID: AeqEk3bc0a2bnzj5wWu2O5bacW6C94R0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfXxl++lK/5vmvj
 9QEit850TLJ8WlBczchsTVYoCt9GkiSPhEysDsSL6l2M6AKCdeac48uafTnAvZBNd4Ctynk9g4k
 X3qFtNCceMLUk8emlhZq0pHdgWUnZIDklWgmqoC9ofoF5FZikoMq1ls932H9ZlyaU1cOF5nsxFY
 uO1W39LdvhR9vxwEQQb3k/AEijJ3YD9fIC22jn7CLn4Jv2zIr1l+bjzGArO7UcR2RrB0+QXkzsr
 w9dvsXNms29dFR615inMo9Rygu2FPOO+hYdjnlV76E4I/4dmAOvhcuPz68Svkor7CYC+6US6WxY
 GzqPp5Xy+8oEtMX9MoagjPLmkTGTbSsGS3uOTHV3nMjEa1qbDVRfgDJk0FBTq/Yx4qj4JZgBqm8
 Y8XnhArdRMA6dYilwzQK7TV+pjBuI/ZXlcNwT5J1vhrgkZbCvGdtEgxUMhuMbPOl52fOrd0jDTN
 RdO5bEQUqHcEU+/GTkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310048

Document the org.bluez.CSDistance1 interface, which
exposes the DistanceMeters estimate computed by an
external ranging provider registered via
CSDistanceProviderManager.
---
 Makefile.am                   |  9 +++++++--
 doc/org.bluez.CSDistance1.rst | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 doc/org.bluez.CSDistance1.rst

diff --git a/Makefile.am b/Makefile.am
index 19c468d3a..00b4ac2b1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,7 +405,8 @@ man_MANS += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
-man_MANS += doc/org.bluez.ChannelSounding1.5
+man_MANS += doc/org.bluez.ChannelSounding1.5 \
+	    doc/org.bluez.CSDistance1.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -446,7 +447,8 @@ manual_pages += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
-manual_pages += doc/org.bluez.ChannelSounding1.5
+manual_pages += doc/org.bluez.ChannelSounding1.5 \
+	        doc/org.bluez.CSDistance1.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -535,6 +537,9 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 	      doc/org.bluez.Thermometer.rst \
 	      doc/org.bluez.ThermometerWatcher.rst
 
+EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
+	      doc/org.bluez.CSDistance1.rst
+
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
 
diff --git a/doc/org.bluez.CSDistance1.rst b/doc/org.bluez.CSDistance1.rst
new file mode 100644
index 000000000..6ee70596e
--- /dev/null
+++ b/doc/org.bluez.CSDistance1.rst
@@ -0,0 +1,36 @@
+======================
+org.bluez.CSDistance1
+======================
+
+-----------------------------------------
+BlueZ D-Bus CSDistance API documentation
+-----------------------------------------
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
+:Interface:	org.bluez.CSDistance1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties
+----------
+
+double DistanceMeters [readonly]
+`````````````````````````````````
+
+Estimated distance to the remote device, in meters, as last computed
+from Channel Sounding measurement data.
+
+Providers from **org.bluez.CSDistanceProvider(5)** compute
+this value from the raw procedure data reported via the **ProcedureData**
+signal on **org.bluez.ChannelSounding1(5)**, and report it back to
+**bluetoothd(8)** for reflection here.
+
+This property emits ``PropertiesChanged`` whenever a new estimate is
+reported.
-- 

