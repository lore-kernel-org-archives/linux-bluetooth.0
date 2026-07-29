Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B093C3F63
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321043; cv=none; b=SLeOgrkeCR/nuR7FEwUi3FhSBLxWjQB5uJI43dU6hIoFECrdIUZV5Ahc3fuCOi9rFC+G5Di2V4GM4o/zLy9iPcZEO1S9A6wEgG4y13ziu5d3YsfwlLXPqBhHq6b4DCUdN8jYoSGhit+kZ+pJH3P5dmZOe+QwujmNzn66I2RHCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321043; c=relaxed/simple;
	bh=X8SKSUkkwQ5JIU5EON89wSZxHGdy2Op1oh6s2B77WA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbUUx9c6q0CSVqouiQrk9mAqn0d9npNlpc2iG84TTpYKTTY5nbVHa8ESJTDCiEh8x1JdLt5f1nh7QY4xZzN1QbPxNgIqrNWS/Nq88OAd8FQ5yz50K78pLRCHYZDda5969/tIB1G8w+gnAcvTIbfLzt4zoYwxgDeNEaueivIKvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=leFPG7xC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gf49pQ+F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="leFPG7xC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gf49pQ+F"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7f32Y2326644
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PsARo54fQ/QsU0+X1xbyw4YeQRr9iK8OshcVZ/O6p+s=; b=leFPG7xCNqWlsdTU
	uP0QLiP/aYeRf0Z+R1HwgBhmT2XNuIxuPTGdtCEfr43/nA+LXIlgh8VWsTeJMQf1
	bTl+T3gzwLWFoqNCXfIJxISx2QuGtpoeB3RzW1g70A5LYoub7s0NqAnlSgZs6CWP
	oya02luOaqQmcuJ8V6OOHgAz842oh3a4Z7MRX18rHMNzQquiGi/Qx9jR2JOwzhoN
	GrVIgjVjQ6ARvk8YlUiJfEkDbteWKcvWydZmCGi4ih6sa9K7doN+i533Lpj6WIXR
	60VQm27Zce1stSvjdxPi0A3i6u+p6h16K2jvFRBnrfr6zuSI5milqJ1fwpqDp9Zo
	LhV9gQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbm1h6wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9c26587e67so789539a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785321040; x=1785925840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PsARo54fQ/QsU0+X1xbyw4YeQRr9iK8OshcVZ/O6p+s=;
        b=gf49pQ+FgTwrUAZ6ZMO7gt3qFtBDPPrS/dJYHWdF8/bWZp3ESUWtFXdwGBsvpuwpfS
         U8u++BHjJsb8vUbLeDwCtoR52ITcK1y1k8glcGDPaJm73v1/DY2YZ/tjxtJgO1LWs+Mi
         minAcBv9iMwvb4yFSb7NbOqKAldG+rEJMl62KXtdsCuxq6OcU9ykiWIkHt7dC6RJXQVg
         dMWtr4f1z2O4ahTiR3jVl/fggg2MFMC5VwH9OuVTMAKFgiNSdRPO2Wz17PkdpvMSrlxn
         CJYih9aNGGmeUBVREY8UrKJRNIYlA0MJ5sQq7ZYazny8aIBb7P9LwRiF1FiwlORZqnly
         XpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321040; x=1785925840;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PsARo54fQ/QsU0+X1xbyw4YeQRr9iK8OshcVZ/O6p+s=;
        b=Ub/9v2uSloNjq2EhjYnl3TFGMBZ6hIIy7nPM0g2J5CBp97qGR42J12RrgGhcofTtVm
         UZ8tgHTbgftfeyOzSX27pfRM2axIkvrkPKbC9lYtilS1N50tfIKBF7VOKZWnXMzTuATw
         8xGhoFaGKg61VWeWwxbh91+FQxBQlfku1AvH6NoAleO5I7C3PoXE4IwX9OlrubMQLrMm
         M2nFHijgeRc0RVez1XeC8m7dDYPsofZsCHEapkdRcgi4S/s40yKCHjo/5lISgvBBUJik
         MHsgpaAW7pLfdh9PoRw8cp9wxTpk5qkkZsMj2qA/cvUNBcjJiVsvD/Kd6jvXkNtqbA0s
         hKEw==
X-Gm-Message-State: AOJu0YxUNCbGZDCXTlm5o17oytry2h2ZJzKVFOFB+5xjYcu8tIDg7sP4
	bZ3Bsdgj7S/t3PmcO5/uxNAucpQGO3S2xinlIypRosuSZ/O4VBi3WEdlz3gCiPzxfJazZtPyKIx
	HK9FFj0u+DNrrbUtWSUhENLy3daSvbhbo1OfVD3BjYGzIjZHQq4fXUnn2bQF7jBK/Jzl1EkzUJF
	qyOXI=
X-Gm-Gg: AR+sD12R2gbQcQp1R3VIj0iqEx6TcoUasJ29OVSyHwPhYytGwZ2EVnA628ua1oza2Oq
	aqJBoz86a9D39aT+2ZJeY2Ql8xd3TwS9/b2W1n6i9LzqS3sJE6SzDUHJCpkwz9gt/OLJ29AAwOA
	wuesjHYA3L3LVKyhyjycx+5RYHnYJGd96Q5V4NhiOd1X2NchYQpLcljtMuYIFTYQ48TDS2nqaSM
	CBtTfapUtuchkQUe16JhxjbRl+LoPRxG4hC01X339v2OzayS20UQzX82qPMveRcFsFq8vT2xr3T
	k0DkT7YsW5cX/8WBAR/KFhIcwN1xa5A9QUjFaM2AjgxzXMDETISYShWBPspli/KgIZGP4LuJEVc
	FUKyrKSZu+ImfgoAjGu+v5bNFv+DZuw==
X-Received: by 2002:a05:6a20:43a3:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3c8e466d822mr2020877637.15.1785321039765;
        Wed, 29 Jul 2026 03:30:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:43a3:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3c8e466d822mr2020842637.15.1785321039197;
        Wed, 29 Jul 2026 03:30:39 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7262bc27sm11028649c88.2.2026.07.29.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:30:38 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 3/3] doc: Update ProcedureData signal doc for byte-blob format
Date: Wed, 29 Jul 2026 16:00:19 +0530
Message-Id: <20260729103019.4178720-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729103019.4178720-1-naga.akella@oss.qualcomm.com>
References: <20260729103019.4178720-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfX/r/7yDkzBxjx
 TYD7B2X/O+0CNu0aSocfiaVU90QJ5IM7Cb680mN2IJWomGECadPQLwyDlkILQxG4fVA+NOgkp7w
 UmnoWB404Oe3NHCyobGnlBiWt/tXhRHBLrjxGDS+GCWb6ESy5OZyXsZ0Yop5Qkw7lEkb18XPPxA
 fWSdIrkVheEGOQiXnr5rR+IhPUZRSueXBMrHttBsjB/OVUkHKOXKFk0798fbuVOBsj5gTsedWfK
 5M3CdgJfN14hYXFdrjwPD4lVw3i5LugOQYkTxMdK2C6QGGNJWSBLANM0zuOj0OuyXrSDInPOT6q
 00TvCO+4M+wYkn6r38zpShPR6wtcM7Kf3RIaLVWbafepkd8/Du+kdfTRm/dijmqkcPy/ezziBIm
 2MGm5oSNInUHfDmiA7NlstELWgE4zBx9TMwZK9oT7ZwJ/ctG58bTiFZQKvvdYfiATX1OBoagC1a
 hr362T3LQM5k7pO3sPQ==
X-Proofpoint-GUID: KrShjle-8bRI-CUus5PIN24ZQA368Cm1
X-Authority-Analysis: v=2.4 cv=R7Az39RX c=1 sm=1 tr=0 ts=6a69d650 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=rvjPyvzsJ2hxnAywV18A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: KrShjle-8bRI-CUus5PIN24ZQA368Cm1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfX94EMAJu3+Cw8
 5uTEJSESPgwlJ+NtGRysj1h3xD5J2TDJmXxF46r/2DYrq+6Yx7Jth5x0oj+iMz6OaZMqNvaVQsL
 i99sVtTGe34+sBKhHdoHHzzjCz2k40I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290086

Document the create_context CS configuration parameter added
alongside the CS Create Config command.

Update the ProcedureData signal signature from dict to array{byte},
matching the byte-blob serialization now used in rap.c, and drop
the per-field dict documentation (procedureCounter, subevent
results, csConfigParam, etc.) that no longer applies since the
signal now carries an opaque binary blob instead of a structured
dict.
---
 doc/org.bluez.ChannelSounding1.rst | 365 ++++++++++-------------------
 1 file changed, 123 insertions(+), 242 deletions(-)

diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
index c06e1d728..95d6bc7b2 100644
--- a/doc/org.bluez.ChannelSounding1.rst
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -82,6 +82,13 @@ Supported dictionary keys:
 	Maximum TX power in dBm, treated as a signed value. Valid
 	range is -127 to +20 dBm.
 
+:byte create_context (Default: 0x01):
+
+	Controls where the CS configuration is written. Set to 0x00 to
+	write the configuration only to the local Controller. Set to
+	0x01 to write it to both the local and remote Controllers using
+	the CS Configuration procedure.
+
 :byte config_id:
 
 	CS configuration identifier.
@@ -254,254 +261,128 @@ Examples:
 Signals
 -------
 
-void ProcedureData(dict data)
-``````````````````````````````
+void ProcedureData(array{byte} data)
+`````````````````````````````````````
 
 Emitted when a Channel Sounding measurement procedure completes on this
 device, carrying the raw CS procedure results as reported by the
 controller. Consumers such as an external ranging estimation daemon
 subscribe to this signal to compute distance estimates.
 
-:dict data:
-
-	:int32 procedureCounter:
-
-		Procedure counter value from the controller.
-
-	:int32 procedureSequence:
-
-		Sequence number of this procedure.
-
-	:byte initiatorSelectedTxPower:
-
-		TX power selected by the Initiator, treated as a signed
-		value.
-
-	:byte reflectorSelectedTxPower:
-
-		TX power selected by the Reflector, treated as a signed
-		value.
-
-	:uint32 initiatorSubeventCount:
-
-		Number of subevent results reported by the Initiator.
-
-	:array{dict} initiatorSubeventResults:
-
-		Present only when ``initiatorSubeventCount`` is greater
-		than 0. One entry per Initiator subevent, each with the
-		fields described in `Subevent Result`_ below.
-
-	:byte initiatorProcedureAbortReason:
-
-		Reason the Initiator's procedure was aborted, 0 if not
-		aborted.
-
-	:uint32 reflectorSubeventCount:
-
-		Number of subevent results reported by the Reflector.
-
-	:array{dict} reflectorSubeventResults:
-
-		Present only when ``reflectorSubeventCount`` is greater
-		than 0. One entry per Reflector subevent, each with the
-		fields described in `Subevent Result`_ below.
-
-	:byte reflectorProcedureAbortReason:
-
-		Reason the Reflector's procedure was aborted, 0 if not
-		aborted.
-
-	:dict procedureEnableConfig:
-
-		:byte toneAntennaConfigSelection:
-
-			Antenna configuration used for CS tone exchanges.
-
-		:uint32 subeventLenUs:
-
-			Subevent length in microseconds.
-
-		:byte subeventsPerEvent:
-
-			Number of subevents per event.
-
-		:uint32 subeventInterval:
-
-			Interval between subevents.
-
-		:uint32 eventInterval:
-
-			Interval between events.
-
-		:uint32 procedureInterval:
-
-			Interval between procedures.
-
-		:uint32 procedureCount:
-
-			Number of procedures configured.
-
-		:uint32 maxProcedureLen:
-
-			Maximum procedure length.
-
-	:dict csConfigParam:
-
-		:byte modeType:
-
-			Main CS mode used in the procedure.
-
-		:byte subModeType:
-
-			Sub-mode within the main mode.
-
-		:byte rttType:
-
-			Round Trip Time measurement type.
-
-		:array{byte} channelMap:
-
-			10-byte channel map bitmap.
-
-		:byte minMainModeSteps:
-		:byte maxMainModeSteps:
-		:byte mainModeRepetition:
-		:byte mode0Steps:
-
-		:byte role:
-
-			CS role in effect for the procedure (Initiator,
-			Reflector, or Both).
-
-		:byte csSyncPhyType:
-
-			PHY used for CS sync packets.
-
-		:byte channelSelectionType:
-		:byte ch3cShapeType:
-		:byte ch3cJump:
-		:byte channelMapRepetition:
-		:byte tIp1TimeUs:
-		:byte tIp2TimeUs:
-		:byte tFcsTimeUs:
-		:byte tPmTimeUs:
-		:byte tSwTimeUsSupportedByLocal:
-		:byte tSwTimeUsSupportedByRemote:
-
-		:uint32 bleConnInterval:
-
-			BLE connection interval in effect during the
-			procedure.
-
-Subevent Result
-~~~~~~~~~~~~~~~~
-
-Each element of ``initiatorSubeventResults`` and
-``reflectorSubeventResults`` is a dict with the following fields:
-
-:int32 startAclConnEvtCounter:
-
-	ACL connection event counter at the start of the subevent.
-
-:int32 freqComp:
-
-	Frequency compensation value.
-
-:byte refPwrLvl:
-
-	Reference power level, treated as a signed value.
-
-:byte numAntPaths:
-
-	Number of antenna paths used.
-
-:byte subeventAbortReason:
-
-	Reason the subevent was aborted, 0 if not aborted.
-
-:uint64 timestampNanos:
-
-	Timestamp of the subevent result, in nanoseconds.
-
-:uint32 numSteps:
-
-	Number of steps reported in this subevent.
-
-:array{dict} stepData:
-
-	One entry per step. Each entry has:
-
-	:byte stepMode:
-
-		CS step mode (0-3).
-
-	:byte stepChannel:
-
-		Channel used for the step.
-
-	:dict modeZeroData:
-
-		Present when ``stepMode`` is 0.
-
-		:byte packetQuality:
-		:byte packetRssiDbm:
-		:byte packetAntenna:
-
-		:int32 initiatorMeasuredFreqOffset:
-
-			Frequency offset measured by the Initiator.
-
-	:dict modeOneData:
-
-		Present when ``stepMode`` is 1.
-
-		:byte packetQuality:
-		:byte packetNadm:
-		:byte packetRssiDbm:
-
-		:int32 toaTodInitiator:
-
-			Time of Arrival / Time of Departure at the
-			Initiator.
-
-		:int32 todToaReflector:
-
-			Time of Departure / Time of Arrival at the
-			Reflector.
-
-		:byte packetAntenna:
-
-		:array{int32} packetPct1:
-
-			In-phase/quadrature sample pair, as
-			``[i_sample, q_sample]``.
-
-		:array{int32} packetPct2:
-
-			In-phase/quadrature sample pair, as
-			``[i_sample, q_sample]``.
-
-	:dict modeTwoData:
-
-		Present when ``stepMode`` is 2.
-
-		:byte antennaPermutationIndex:
-
-		:array{int32} tonePctIQSamples:
-
-			Interleaved in-phase/quadrature tone samples, as
-			``[i_sample, q_sample, ...]`` — one pair per
-			antenna path.
-
-		:array{byte} toneQualityIndicators:
-
-			One quality indicator byte per antenna path.
-
-	:dict modeThreeData:
-
-		Present when ``stepMode`` is 3. Contains the combined
-		fields of both **modeOneData** and **modeTwoData**.
+``data`` is an opaque binary blob rather than an introspectable D-Bus
+dict: every field is raw controller measurement data with no standalone
+meaning outside of the ranging algorithm that consumes it, so there is no
+debugging value in exposing it field-by-field at the D-Bus level.
+Consumers must decode it according to the fixed layout below.
+
+All multi-byte integer fields are little-endian. Signed fields are noted
+explicitly; all others are unsigned.
+
+ProcedureData blob::
+
+	u16  procedureCounter
+	u16  procedureSequence
+	s8   initiatorSelectedTxPower
+	s8   reflectorSelectedTxPower
+	u32  initiatorSubeventCount
+	<initiatorSubeventCount> x SubeventBlob
+	u8   initiatorProcedureAbortReason
+	u32  reflectorSubeventCount
+	<reflectorSubeventCount> x SubeventBlob
+	u8   reflectorProcedureAbortReason
+	ProcEnableConfigBlob
+	CsConfigParamBlob
+
+SubeventBlob::
+
+	u16  startAclConnEvtCounter
+	u16  freqComp
+	s8   refPwrLvl
+	u8   numAntPaths
+	u8   subeventAbortReason
+	u64  timestampNanos
+	u32  numSteps
+	<numSteps> x StepBlob
+
+StepBlob::
+
+	u8   stepMode                  # 0-3, selects the payload below
+	u8   stepChannel
+	<mode payload, shape per stepMode -- see Mode*Blob below>
+
+ModeZeroBlob (5 bytes, present when stepMode is 0)::
+
+	u8   packetQuality
+	u8   packetRssiDbm
+	u8   packetAntenna
+	u16  initiatorMeasuredFreqOffset
+
+ModeOneBlob (16 bytes, present when stepMode is 1)::
+
+	u8   packetQuality
+	u8   packetNadm
+	u8   packetRssiDbm
+	s16  toaTodInitiator
+	s16  todToaReflector
+	u8   packetAntenna
+	s16  packetPct1_i
+	s16  packetPct1_q
+	s16  packetPct2_i
+	s16  packetPct2_q
+
+ModeTwoBlob (1 + 5*numPaths bytes, present when stepMode is 2)::
+
+	u8   antennaPermutationIndex
+	<numPaths> x { s16 toneI, s16 toneQ }
+	<numPaths> x u8 toneQualityIndicator
+
+	# numPaths = min(numAntPaths + 1, 5), where numAntPaths comes from
+	# the enclosing SubeventBlob.
+
+ModeThreeBlob (present when stepMode is 3)::
+
+	ModeOneBlob
+	ModeTwoBlob
+
+ProcEnableConfigBlob (16 bytes)::
+
+	u8   toneAntennaConfigSelection
+	u32  subeventLenUs
+	u8   subeventsPerEvent
+	u16  subeventInterval
+	u16  eventInterval
+	u16  procedureInterval
+	u16  procedureCount
+	u16  maxProcedureLen
+
+CsConfigParamBlob (30 bytes)::
+
+	u8   modeType
+	u8   subModeType
+	u8   rttType
+	u8[10] channelMap
+	u8   minMainModeSteps
+	u8   maxMainModeSteps
+	u8   mainModeRepetition
+	u8   mode0Steps
+	u8   role
+	u8   csSyncPhyType
+	u8   channelSelectionType
+	u8   ch3cShapeType
+	u8   ch3cJump
+	u8   channelMapRepetition
+	u8   tIp1TimeUs
+	u8   tIp2TimeUs
+	u8   tFcsTimeUs
+	u8   tPmTimeUs
+	u8   tSwTimeUsSupportedByLocal
+	u8   tSwTimeUsSupportedByRemote
+	u16  bleConnInterval
+
+The total blob length is fully determined by the counts embedded in the
+blob itself (``initiatorSubeventCount``, ``reflectorSubeventCount``, each
+subevent's ``numSteps``, and each mode-two step's ``numAntPaths``) — there
+is no separate length table to consult.
 
 Properties
 ----------
-- 

