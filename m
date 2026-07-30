Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA47376BDE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411834; cv=none; b=A/QAxD3mwDP5i/ycPa9mSOgrYheA2AlCXfc+3JPLvvktJQNOfpcUEu7vbVeSU5lxqzhBlFz/v5qwHld5F+IlDUgFnS+EBOZGIHOXlJlYMfKjdXkkv90nu9E+fHLL+uYwvBwPG6bVvWzTZrPhp3e3t2V8QuJiKOuWw3vLwhcC/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411834; c=relaxed/simple;
	bh=ryuBwK0aVvPUUGVnL3mM8ylhe9/IUitTrGILumRabeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIcsv3ALz+HnlNmGsMPfDNApuKGRnEtGh2hAVbf2gyGI2mTkDwBejeySeECIQXq+sH9f1M8jxafa4fjCsk/uQkDHAR5yNLeoDgfWOeMHcnl5aE6CZ7pjuS4dvlNCpemDtFxD3IqwJH+PoGLTen2OaSkI69RCeSmleyt4iIak01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VZO+9bFw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2Xh1/2A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VZO+9bFw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2Xh1/2A"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UB5dGJ429109
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fNNAtEonlJD
	blhHipelh8gcQUyR4GJrSt7ccAOUbeGI=; b=VZO+9bFwdFQLmoj744R1OVTnkGE
	o5NWzW1CS1CqO07aWBUpH//R8xPs5ZtZDJ+/uobtHgE6E8/hCTa4DkyFZcL/GckO
	K9SdcsFjj7HXIgM73+EKiOlkpO/jS5GKtV6YkT39xRwmMMwfbv9f+f8LyGQE1e4+
	xaFutEGCG5be57QOsLfZlwtIXh5xRw+EO/5MoCf1tiI+AxEEXgiKT36lVUpKIAai
	+8C4XlM3YpfqPmQjhW3Krd8Rra9rbbGjPY6MY1q39GKXmqOUsyXZghesqU4XHKED
	UI+roovFDgcD+E+ALWk38jj26v+e4dhm4R5t3mFUoFaAXY1L7hVdQs1669Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5efg4v8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so3565790a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785411832; x=1786016632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fNNAtEonlJDblhHipelh8gcQUyR4GJrSt7ccAOUbeGI=;
        b=K2Xh1/2Aap0VGkfDBttbj7Bprk57bi1TynmCikYG4V3EK1st4HOqVDgCYBiSIEbaTz
         iw5NaMpam9y8N2IHYEOJhEvD93VEeGv7qclsdm6sSZhaUl2Y9kEWP1G/J54Srud3P3We
         Hrc5+9PUWz7Nl43o0H6TYhnX9/qJlPIdcSQxgfsP7xYLZSrUZa+nw5Tdd+uDgRxWp/os
         al/pKNNoxpDyPVPVsIzRIJYlehAqFrQxpjNHlPZS38PPBhtubQdjsfSq19Q+9YdztlZW
         HhAWNsPTY2M9XwbHC07gEj8NWi3b4oKvcO5Ky4Ky3wuZWFikuT1+RfF3dbezMC3exHnG
         zwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411832; x=1786016632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fNNAtEonlJDblhHipelh8gcQUyR4GJrSt7ccAOUbeGI=;
        b=CFob7J/AyU+dtxbv3965x4XXrZbUpOjeJw1Ax3dJY2rj4wb/ZLoICrVvKiRIhgXLFb
         OaRkyuOSOpzCypPC6qqrQAKgLb0k7NMzyQh1MUeS/nBbNGuQqg5nZieKY/K0sMVSqysF
         o0J9ufmfpsl/jNsEHRWEphOoiE8cGeSM2sQp8nSDiyXYHAQYpXS+z952jw8iIQNL/mmf
         pKE0zmKOaa+UYChl9B8ILmMa6eYJKoEg4MxAQHGrFoDTeSHcL3cKC1xJnl5erPWzTYtZ
         AEKqJmG4MLaJ4ydWYv0i6NPyHQO/Ge2tbSBWEQwFk0qfLhiP6ERIuYFM/IV5g75YgF1B
         +iYw==
X-Gm-Message-State: AOJu0YzeFIoNVclrRM/IEOsfRFfXp1ocpobTE2ZLdMZzyMu5JFzN7ayD
	TFE+qUCpDAjguyzkMF+416gs5AIkEfft60NO0y9j480Kjmyz8KbhytNsY7hY+/I+D3u2+5Oiwsw
	YNUQNSjsdXqvz17KoVUTRD10mukcynh6+PW++GD/x1h+yjrQTBkLib+FVMQm16Q55Ns1B0a60M+
	qYL4o=
X-Gm-Gg: AR+sD11TuXTlNl3DNNGhkVNNmP02YTBBhHJHaTxQEvjh2V1Km68dd9waUtUfdtQdY+o
	vqQ8EO/X44o3pie6OixWgZHvpJH7vDP98XF5PaJh1HiZGVYFca0KgilCpRE25j1YHApDE6SBpzy
	fUIBa5oWeA7plsbkyAilViyi8vPQ9Fhr2KGKu4R5QAj5yzZinRjc0dHAFPUJtXUfNU3c91a+0BU
	4epXJI3HOHuOiZhYhyhqxrXp9TFO01NII9uOCiZ4jj5RJbBYIXx7Jo1rtTC4dKq5+TXZfKUNWVq
	9CjiIk49K8/rRKXnk2gErUtJu0BwyWl793JDKAJL65t20hrevThz1tjgwuLXMJNBsU9WC1ULFr9
	b984s6Eue/NGWnHR85hu0PXS9geH92g==
X-Received: by 2002:a05:6a21:600b:b0:3c1:817:792e with SMTP id adf61e73a8af0-3c90068cda8mr2286508637.57.1785411832126;
        Thu, 30 Jul 2026 04:43:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:600b:b0:3c1:817:792e with SMTP id adf61e73a8af0-3c90068cda8mr2286480637.57.1785411831671;
        Thu, 30 Jul 2026 04:43:51 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7273cd9esm20961598c88.13.2026.07.30.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:43:51 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/3] doc: Add org.bluez.ChannelSoundingDistance1 documentation
Date: Thu, 30 Jul 2026 17:13:38 +0530
Message-Id: <20260730114340.1576049-2-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: vY2rcMUv8HmswMZQBhI7AHlg-lCDLpLC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfX42pOHF/QEX9/
 v0xmOO1dbT+inXnJPZm43a259xFmxscX56r9Tu/D0QxOSFuspLwPTv0HTJtnVIGmeW2mG4vXOl7
 uvHVE7WnBiCP7n0IoQYD9ziI6Y9+cA0=
X-Proofpoint-GUID: vY2rcMUv8HmswMZQBhI7AHlg-lCDLpLC
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a6b38f8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=spbTI6b81xeDpCypOt8A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfX9wa0p6my9Obg
 i3DlA2haBE90oPxUVnaUJtEmSUQ2KIeFsdS4Dt0nrVRfVn0XMUTwB74HfFM/mq1HZqmetjraHRd
 vxh0W0nz1rNIk9qXvwyB8O/gZyLjrPkp3tsmaXsPpeMi7QeDZUnCwQQVwHIs1AzWF/8Rl2GnkxE
 ou+eFeH8YDFl/aE2ZjEN25wmKj1zE+RCN9KbnFIyeDTZkLQtEdA7v60uCajIWdd8PJqd95N6IXa
 /9bdSjb8AXMW+ZtlqRyGiWonUL4YS/Kkw5TrUs/O4Gd+UulZERsklg6FvtdxSl9roGT1dzCFLeS
 TOWgCdnYaTzvSEhvq4tQYJGUU5XnjaHXBOSVkw0utGDKv8ov0Wyu4FoSaxGGnmiNfL9qRJCeZMe
 ykIMSp8NhmRyhH9OfgvXr+Kr5Y2slIczNAjHx+sD5BVolclxQhhemaUke88noEyrAMKKhvPqnEV
 kJ8bLLnLMH8WDy7bRXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300088

Document the org.bluez.ChannelSoundingDistance1 interface, which
exposes the DistanceMeters estimate computed by an external ranging
provider registered via ChannelSoundingDistanceProviderManager1.
---
 Makefile.am                                |  9 ++++--
 doc/org.bluez.ChannelSoundingDistance1.rst | 36 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 doc/org.bluez.ChannelSoundingDistance1.rst

diff --git a/Makefile.am b/Makefile.am
index 19c468d3a..a5a3c0d30 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,7 +405,8 @@ man_MANS += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
-man_MANS += doc/org.bluez.ChannelSounding1.5
+man_MANS += doc/org.bluez.ChannelSounding1.5 \
+			doc/org.bluez.ChannelSoundingDistance1.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -446,7 +447,8 @@ manual_pages += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
-manual_pages += doc/org.bluez.ChannelSounding1.5
+manual_pages += doc/org.bluez.ChannelSounding1.5 \
+				doc/org.bluez.ChannelSoundingDistance1.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -535,6 +537,9 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 	      doc/org.bluez.Thermometer.rst \
 	      doc/org.bluez.ThermometerWatcher.rst
 
+EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
+		doc/org.bluez.ChannelSoundingDistance1.rst \
+
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
 
diff --git a/doc/org.bluez.ChannelSoundingDistance1.rst b/doc/org.bluez.ChannelSoundingDistance1.rst
new file mode 100644
index 000000000..2ce7af2bf
--- /dev/null
+++ b/doc/org.bluez.ChannelSoundingDistance1.rst
@@ -0,0 +1,36 @@
+==================================
+org.bluez.ChannelSoundingDistance1
+==================================
+
+----------------------------------------------------------
+BlueZ D-Bus ChannelSoundingDistance API documentation
+----------------------------------------------------------
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
+:Interface:	org.bluez.ChannelSoundingDistance1
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
+Providers from **org.bluez.ChannelSoundingDistanceProvider(5)** compute
+this value from the raw procedure data reported via the **ProcedureData**
+signal on **org.bluez.ChannelSounding1(5)**, and report it back to
+**bluetoothd(8)** for reflection here.
+
+This property emits ``PropertiesChanged`` whenever a new estimate is
+reported.
-- 

