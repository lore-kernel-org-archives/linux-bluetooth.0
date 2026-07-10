Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675439D3EB
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663172; cv=none; b=P6WroGxNzxGz0n9vCRoNIHQ4BpNJNS81ljSZ2EFJPDGLMij0i53JBrHMtXWni4Gy3BTWqSH6pz10PBqtqmaDsRylH57TPkq/Y4a5RFSSPCZamMgX+NbAEWIukTyZiW1zr0UDU/rnW0gKmImJxrr1gM7WbjBJOSGEmLe4ULtSi1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663172; c=relaxed/simple;
	bh=is9HK1RhKebh8Jvjjgtrhc4+gGDqe/Olis0PToz6otg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhXniVRYJw1redGuLkbJdq9s31pqY5w2BfWL8TNH7hlm0LoT8TuJutI/M+pd83V70q3CUSSVA0LyEbeOreliRTVV5MNnDSNCTxvaRBFIwhgJ/HQewB1hea+mVxxdVE+bGwlmaPQGbfUwuNqc2iasbC443Fs5lg+wmqstPeKuC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=csrnL2MZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FXLuM+A2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="csrnL2MZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FXLuM+A2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3omOe3854539
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Yj2hscn7k7u
	Y8kx3m+5Yssu6uxzXyVZJz/lt2R7asWs=; b=csrnL2MZJh9iIU+DNB08I9H2Scm
	qJIhzkjH9HPDJX1TdMUchiDId+h74ZLgb7tlOW+QJWnbGLmkukdbknsTVfJ427BX
	t5r2x9uv1Yj3FI31RSlKMeH4RsL9DBo2DJTfZQ+gqv+UIzYVXYaXGdtS/7mnv957
	jEI5JThksN7ajVs2e+B7ztx5F9AV5CRIRQ2wkaTyqEvx1JQFuA2EcB2yX+TMM4K1
	9JPlg9wnptAu/7zaKC134pwLCmRYETL7UIFWMsjuqEnjQe6fvJuj4Z0Z44A5c4up
	hS1y57gRyjpE2WYRx6tFS1xrfdmWvsgqZ5h+BHDzAu5XhhmldjXBpsJs83w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0e6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88fc985a65so1004716a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 22:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783663167; x=1784267967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yj2hscn7k7uY8kx3m+5Yssu6uxzXyVZJz/lt2R7asWs=;
        b=FXLuM+A2+5vUVkOtVgGu/zGk/1LHKtJM93CrOzgb57VxKhELmWLGau4qPsxPeZpttX
         YmeVnQlhUou128Yi06/ctZ8eqhA/IVTgxpqj1lKkj7KRib6MpYIhPHwD1FXs4FDdA8kv
         zI1ryk1OYnGSZt/heLsddUdEwTmPYhAc4F5gF45hCIcD8iTOoZviGKFY1MS1p8rzT2WF
         8amQ145J2IYRe2NFpU7cbwY5cQecFPng7ZorVP5tzjQtWWL3B47XWoBXndbg/nTu6jcQ
         KINEg/V9T+anrUOkfxqvK9NGXQuxbRby78z9vF+KPpYq2cwezIuR1GncRqDQrScfhJ8/
         D9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783663167; x=1784267967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yj2hscn7k7uY8kx3m+5Yssu6uxzXyVZJz/lt2R7asWs=;
        b=o7JWZGnDn4h3pNofKvr41bwqJ7WSJYV7nd5Syu2kjvwjNVd2KqWc23T+eeergr9lXg
         0I8exXbNhFLS3j0wKX/AEhavPFGHaXmlt2vJX1bmrtgsc6U9679+lLGkQZ5Rq7sPyS7l
         hihz0O6WOMb0U/UC83QqRHg9eIbBgtiXwjSM8H4DDB6rU52Cqz+vSANHz+/EiL1r1QyD
         JRwVNTn/38bpoyJ04YTKC/paZK1vKRGnlHPwGLj61wtVIDZrxebPRks3Am5xQ1t+RvqB
         daP2NytRP0uXJOZCkVrgru9zw+tlddE6gD0FrYoHxEE2YDcP4LNz0RbVW5p0sAVXb3Fu
         RNCA==
X-Gm-Message-State: AOJu0YwxuVkiEpr+yPw12n78jD/ku2F9i9dD6elBSUEw1xuXfQp2nXYm
	wQRJVPZZGCAefXV8F8/BHhjq8kwCHwrsO82W5I0O+Dj4ADJ/llbzw+wtfskr5WlQOrd0mHv0Zh2
	UpWRiTifPWR3EQNIXQJlpconaWPb7s7tZPWEyVLMq1RS7CyD7rarw7wKic7g2dFLU1JXhv5DJdh
	/HuSY=
X-Gm-Gg: AfdE7cmR0C5v77iHVc7dT4UDBD3t/2zvyU5Ng1e9DtaYvVc4xZT9jbClS8ocGbWlZ+T
	+W0BL3zkPxH51GaWKjPpnSoHaImpR8y9WtgHsoeJqm0kqKjVCTRh5GerIAr63onPKZ41BG2/IGA
	96oyS+jJkxu0AnvRlvzFHx1/h368AZkOSi481w7bN1vcWq3+tXeslOT5B/HLNXjOKklxBNmlGki
	KFFxwjC3LZ3t5tnYhDTmKi75QWUZwi0o1T0JdSfaO4ZM1oRNPLPFC0Q2Oy4Lx9qcxVrpp6aNs9o
	a54svhPYlooiqfZJBVz7FQQDNezeJhtnhsZ25ct8i1yXc1IkyKZQtMA8QA3Xn3xhXL3vM/ntI6D
	1e9ZVnD9lY4cePSpBBfZZC/neT/Acbd6n/LI2VaJr
X-Received: by 2002:a05:6a20:72a3:b0:3bf:bdbc:bb0a with SMTP id adf61e73a8af0-3c0bcfea521mr12451620637.17.1783663167163;
        Thu, 09 Jul 2026 22:59:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a3:b0:3bf:bdbc:bb0a with SMTP id adf61e73a8af0-3c0bcfea521mr12451588637.17.1783663166631;
        Thu, 09 Jul 2026 22:59:26 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm39678529c88.12.2026.07.09.22.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:59:26 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 2/3] doc/org.bluez.ChannelSoundingRanging1:Add references and examples
Date: Fri, 10 Jul 2026 11:29:09 +0530
Message-Id: <20260710055910.3691701-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710055910.3691701-1-naga.akella@oss.qualcomm.com>
References: <20260710055910.3691701-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfX3ugv5rCPkgWT
 pmsuKPANl4hcqm98Ji+2tm1i70W7Epk5FsDpMLp8VRNLFDIS10hYxtfWV/yotFzZSGp1PGNxtpR
 MoLMUiw91y8XB7FEEFhWMleonK+92gQ=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a508a40 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=wa7QpaTpAAAA:8
 a=VwQbUJbxAAAA:8 a=Aely0ZK5wPBa5JhZhnsA:9 a=3WC7DwWrALyhR5TkjVHa:22
 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-ORIG-GUID: YUb2OgQIPEEBt5kd1swO01x7__VZFFFP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfX7FtOib6yiYoN
 lYz4fhAU5Vkw5qE+1KbqTeKKmPeH8zN7qnfwNsID5bvAKqPTDoOsLLTxUEtBCg9PngPiUtsltR3
 eJHCiHI7638Ore6kAm48+o4hJhpaX2s93TjW/tgTyizz9XxfCAU0YmHrXhbP8JCpujaIxLlhx2o
 djSDnfxdCpFM9CIR+2aGcGF5uPRD4MaLSiLfIVcpjoG3XXtIpzpclnCgdkoLHSVSALZ2V8mL4gb
 FfqD37HR1m9sFFm8lQ3omNTMoHfgaYZTFv37s8tVOURrEibaMxa7opw5DNLKZrR52sSCVXRQ8VN
 JRnVpb6qHk2aopowUT+un6xkPLoDq8c6xfdvkwTVkWPZtR5SRWbfCAlCk9vGzOqaqP4r8E9vM+w
 7+qk1BpdsvfipZd4Aly+377N4IFbqTrAM165X7DBKuSwrSepdDK8kLvdSZnMClvUAEcCwOQbevU
 TKRKdI7q/8dwZQ+Fzkg==
X-Proofpoint-GUID: YUb2OgQIPEEBt5kd1swO01x7__VZFFFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100054

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

