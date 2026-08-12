Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4241B8CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529052; cv=none; b=rWaNrfZaFw7KKCrCdAFQo8rigc6JSSLu/dXs0tbLVGFIvLnebbJxmbQvFsfhmYhh4DMvNyXUrQRO0IHnN84x+DVrx6sDL4YQN2oSkAf+12a6Me15UIIDn5pOp5G6SOs5WN6TF12VwqVIpJ+vvoDsbtDdeHGVoH0ZPYab9HcHofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529052; c=relaxed/simple;
	bh=gyTwQ0ejxxkmFHwUFKLrJjJi2H3AYoK8T416JE1a1fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwLeddI5Zyth0+BhBO+HgBA8dP7/2wkMw7EQ4poQ9UJmZjRQH+u9RMmHBffnJl5uVsbXOqwxu/uGRM9GZZVubdeKVC25kaBIPEhOb6CT+Rqu3qPRf+AWzd5rRzkBCHT7KYhH2FDIZDejTl5NFx7yU4O9/yWFzVb2f8Uceg8qNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fAwtD7Th; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/7zG3f9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fAwtD7Th";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/7zG3f9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9fxH73997301
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ucSe0D2k30+
	9WNVw7YDCgzGxZL9JUGsorHKbxUbxgck=; b=fAwtD7Thpz+8g+qrdY6PXCEAM76
	oGDw8VC3rCgEiNki1MXwkqVpriK5zcuzYdYSW/bS4MQaDTmAqbp/Dui5ZcF9KX+R
	k1D5HlhFkUnTR0nh3Ejh3wvjFdXbKOevS2rxgJRaaTUILMnkViQQmaRuJUbbAsHh
	E9SDH0fIDvWxAAREsHMP+hSnzK48YAVjcKLlgEa6xa8dRPYqqhHJvGkRt7HEjWyP
	4uPMY7T9Nj/kJynvDXbYmx0Wt4U/nLTBB5UoK5JwDdzVJPzhm6bFo1VcSbYs0UnG
	eIrS+gXkNZR01eplaSyPMlpqb7IvTcd6mnOt3oJYIMTe3CQbXnvrfEeqElw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5k983-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso748579a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786529046; x=1787133846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucSe0D2k30+9WNVw7YDCgzGxZL9JUGsorHKbxUbxgck=;
        b=Z/7zG3f9VnA813IMrr7kUctlr1PRIn4T3UQPqL6f0PPwHrvyTYCOmQDcm4we7no3sU
         dRU2aAh+FTxGO06aI21hHRScLY4ap5+KHw6Hs9/BUGAF2cLmO3ScBD/TFt1tHk7gQHhm
         y1id9NQ2wJkN9tHOB4YDKfryCcL13+2bkArsp4LmQlKsu5uTxd0fO9h/S+UwqM0wE9a/
         Wm53XTBRyEWfI2mmlpyLqp52JlJ6bR0GPKO6FApKRPf6eeJ3nfTbLASobD/kF2lJPgBm
         t7I/e6Smjd+sU0mM8OJmo3gGotz1vg+uyKBElRBsJrnST4wOp7PcHVhSAg1HtCvZFj4+
         4DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529046; x=1787133846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucSe0D2k30+9WNVw7YDCgzGxZL9JUGsorHKbxUbxgck=;
        b=nY3gFN/U61EslacdSWvpyzFQE5+3stO44HB+ac6WhfmyXrStNUjzwI0faeHnGQjiUC
         xfK/7i746fGCM2VBAS8kOrib2L+mZi8aco8Z0L6e0XMlwZS3TATOPskTe50jSwkypPc8
         2+Xeef3q7uFSH0YCOZsqdfY1eTn7g8ND3qxq5FEhmVZTK1pd4BVbDyYL3mtO+OELEkbv
         DsMZNifaa5ZjXgmXpKxcehKOaiT55aw/OwTWhxBUdg2YMcNYm1xUonhDsmAHercT32V/
         UiohaWJjoi/Mj4XOD9utS2MROx3PlEp2P6on/PD3cfnp44+kBrtXFUDj27Xm6OSdS8qz
         m4Cg==
X-Gm-Message-State: AOJu0Yw8k33ifoVvhgbHoyRcWhOBrLDsZoK0TzgqIlWKboMa/Ao1DLs2
	O6HaPgZQcxGq24rAgyFc0xYrGogt8IsTCUU2gkyLPGo6wdVkkqJ2ayAgcCTuFJfdrtNDtYhJjFz
	G8Jkzrz3JrZtwjKaDW8je8HEbVElUipTJ6kI30fKP8z5o7bJXy5vImjMFgcq6Bf7pCPvD3tS4zn
	BIQV4=
X-Gm-Gg: AR+sD12dkmDPasMPZL3FbAntBAfkeofGx0qEC4EF0yw6Y9kkk/Dm2HHsaVsqLL95lp3
	CtjeH6GX2ilezw0BtXrpqC+RqGX3c0KySaSVwavt3LyhDoI+YZUt710tVJkwjVhMUd1rYFyPIeL
	/F+ctnf8tc8Rc1Uomzn3BjOKtlJ6tHXzrJqtgh9qZnMGK+X8XA92RhyDAgLCSbjJpCeRtAdID/D
	VCJSY3z+S0l0ZFt2z2JAgGj6CbgVSMUSRE9QEIwischQINJltCpdAL9VzlJm9yjqlhmUHRwRgBb
	zosnhF9I4mJ2zRpGVbBUD7FFDyV4gBypqPTj9L0uFI47BTXLnnfNOhCBhqPpFEsbA2dTIljJr9s
	m6wYcTC1wk1+5ito9b/HzrKlorlhfPQ==
X-Received: by 2002:a05:6a20:430c:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3cc3f78eb2emr4032388637.27.1786529045970;
        Wed, 12 Aug 2026 03:04:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:430c:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3cc3f78eb2emr4031701637.27.1786529040690;
        Wed, 12 Aug 2026 03:04:00 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e2aasm11069961eec.14.2026.08.12.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:00 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 1/5] doc: Add org.bluez.CSDistance1 documentation
Date: Wed, 12 Aug 2026 15:33:41 +0530
Message-Id: <20260812100345.2956271-2-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX04mahHxqSo+o
 dqK3QbrK6xxwLMMpIX3cR/eFCFMBATa74qm4Pd58c12fre/noPIqBUhtxV4VSsGbR+syV0vvj+z
 rD54tMK2tDJ0pLGUGnwIASJQsqMe7NA=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c4516 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=DD9ecsvMZrLkcSy-0BsA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: vui6Xgh1NYMQWG9778sC4IPWXL2hoMMm
X-Proofpoint-ORIG-GUID: vui6Xgh1NYMQWG9778sC4IPWXL2hoMMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX+S2mazL5boxW
 CJ2Vh7hqjtJA/Aq0PV//jAcHIBhh51AaK4pKdvr2XbM38JIMaGxw9GarbGyqpqq0GdjiJUFSJsd
 p+1n6CMP2Iq9AOk8EA2NJyWtuBTqPChRd+Wc8DqRfDZXwW0JnVPCWma6LCYkZqevCscZGeeojHw
 McnEEnqbGs9bkMO/8M41gqsOlqgmT0y+8R3PuqI6qmYbz/iglpBpR7zr8Ed/dBKjNrC7CaQ3chC
 TdyZJ+pSm7OngsZWZQW6SJAVOv5gyj80e1LCeIZ37G+jluOalXKBO25Uej0YqJ6Gd1+Z+gFwyRl
 +eR/JQnDKzts/IOm6OHAK5dui6C+RguoYhLEHY02eK3Z5oZeEo6mQNd7YUkv2cNkE1Vj2M05o4r
 vJCB32OHin+zGX4PPuD2FVmb3pq51C5zDuDVcDGCSA1CgGsJlXQ1gZNhjyOHYhZTT8Lt6qyTpVu
 FYJufbTckpnUazcNKtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120080

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

