Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7643B27FA
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393631; cv=none; b=bybJfRVEZWuN+BFfZPiWUzj2qpXv/8sUKlYpXRbT8v+IRWH1YqsEForczSL+xOJZPU32FIPFJQVPGtLrPcReu8SirZAwB1kQRyfLjGpwKGbEBjSQ/eN5nj0l399HOaNhldY3G/tQJ0h+kEjEPEwa59FDUlWxmS4HBOAoNrPQ1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393631; c=relaxed/simple;
	bh=X8SKSUkkwQ5JIU5EON89wSZxHGdy2Op1oh6s2B77WA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQh9PqVN4wX7sn5VuxnYFO8Cyx2smH7GTYzDRO4j+R6AmdIGULPzpXENhafQTr8bh9fIeUMZAIRb33qtxQVUQ/L9xJlHH5tgSXyDCJcby1SkvcAaUmZXydaq8hYP6wczDevWpKAgOQkS5/+a8NfQfFF9jgTLKgyEG9qEGHSi6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lEJ7RZ6T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bgMNSqwV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lEJ7RZ6T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bgMNSqwV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6aTSh4002721
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PsARo54fQ/QsU0+X1xbyw4YeQRr9iK8OshcVZ/O6p+s=; b=lEJ7RZ6T5e1YCoeR
	54AV/6cU1D61QaNt1wjA7x7bSmZKWw5r4axNgVudX1iWaMoZ6UOyy985FdxtS5MN
	zzTOmtlWrEX6/9ZpGYd32OT+IAC48Nm31dKiPS8Z2bcpkXO3Xv5xKIMK9YQyYc8H
	6/EcFLxCKDXtfxm3ZkzqEiS8J5SwUly4H7mB6p6tRvU6QuQNdL+0VAvh1IgUclYy
	BB6Ar2I9U1YvO9viSWkRhP40agLJuBcBiHbCz1s3F7pRiV7SNdVxsEqagNteG1tL
	vUE0ssgiObObm4eKqhXqejvZOc0QlqfsFFdGqQDi7zCWfrZddgk+FUUqZStdI13I
	K087mw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr17s839x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so629412b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785393628; x=1785998428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PsARo54fQ/QsU0+X1xbyw4YeQRr9iK8OshcVZ/O6p+s=;
        b=bgMNSqwVGkKiUU2JKQd2ujA7m+Ybf37G2OkvyxgEKaffvGbGC97xSbj1b3eqgJ56PP
         NrJreAL604rWYhnaRDUJYsRPaexBMF1adnyjnqC7Eu4jias9x9n9mKmpviFFv0tyqx4a
         UfNNT/IEgz9+zcUWYU+p/9XdJ+FjuhG6V9Wd1OR1u9IsIGmfSxalXpGAMQEGmTlUnZ3B
         GWUbh6FC6Ftqw3Zm25Y3V59PSBY1QW1MbIX5cZJbkvJS85Ftu2EK7PsvNqT+bevK/urH
         03UjdIWL+ZWwjy4bF24GVw8ft7WBAPP35bikzmZi7xXoh/r1VMlFNm67aUME2iK9YIYr
         Dsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393628; x=1785998428;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PsARo54fQ/QsU0+X1xbyw4YeQRr9iK8OshcVZ/O6p+s=;
        b=EU0hOLE4MADbo8wMZyrTr55S5xdKReh+NchJca298C+mWvZ2ANPCrtge1ebEPbSnzA
         fzxcvZVxhnJFK+QgCndtGmpmJUcVjDFGRV+K5dlvw2x2aAUXcE1r2grco9LW/5hv8NIJ
         k0/Hq5d9s07y2IGmwbOwRcKaDTbmT1V4ynsJF9ov06hjGQbmZS0qHRdgjYFhBT2U1Kno
         rUmsz1vIzIsA+79N9jcoObYSwiH1KuqHy1KLBG3Gp2I/XgsBYqGrokIpcN4h9+Xunsl6
         mKeBsvW6jY8bA+bVZIsS3BtVElflFVGaRyRTU7i0VIjI6lcES/P/vVir12ZRnCYDxitF
         Mxnw==
X-Gm-Message-State: AOJu0YwBj/tJ1KUhmG4H6euyPMO0+ZAA+GmQE3nTb1vgbcjiE4mrdKEe
	fe85J8pCjb6vf44QjdzuH1v0zguWtFFrV793NJEhyyjLMzzXVlquBemsoXRJ0RIODxOf0t3noD2
	NYisbm9R+XPNzh3RmyQy4LEB8LeLifsBXiM/uWAx49CyzbrMRNzY7eidOKtE7XHpSnUOEGKBAkx
	BVB2Y=
X-Gm-Gg: AR+sD12KbYdzlk6DdHWxOXnvZW+z9gw9KYPoRRrTQ94+SpXqR1UJ62fRT7cbgOvzf7T
	tyx5XCFcgCCzRCzby5N1S8VHrcDavy58HgTp4Q2sAAR4mFBIQL6GTF8XUFzqP7aLKVJLWi+/xB0
	M1f6KdS97tZ2oIyfZcSPTG770jytDInDwQS8x5AjLRlxPgIRr3yr5WqbYDV9WEOWbBzneGrzOk3
	QE71RYOmgOMtMYz9rzmg6RClzEjynQZ8g/0lP9F1rl0pRBSaQx0WwSDibR4/r4SIGAJ+RRm/lNW
	jndst/PepGt8jgywhNbYipNQZVVEUeRtX5RRRrUiBeH5frgOPmNX9eTsfCCzRdmEpTflJ7/We1i
	kNvZACG3dhEhTb0GLzTMJJ/sGiFvOGQ==
X-Received: by 2002:a05:6a20:6a1e:b0:3c3:750f:3cf9 with SMTP id adf61e73a8af0-3c90141cbc6mr1267701637.11.1785393628150;
        Wed, 29 Jul 2026 23:40:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a1e:b0:3c3:750f:3cf9 with SMTP id adf61e73a8af0-3c90141cbc6mr1267665637.11.1785393627550;
        Wed, 29 Jul 2026 23:40:27 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm26304321c88.5.2026.07.29.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:40:27 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 3/3] doc: Update ProcedureData signal doc for byte-blob format
Date: Thu, 30 Jul 2026 12:10:07 +0530
Message-Id: <20260730064007.1229304-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730064007.1229304-1-naga.akella@oss.qualcomm.com>
References: <20260730064007.1229304-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0NSBTYWx0ZWRfX7FGmr3pqVY04
 nN+DsxXUWX7DjinI4f9BOZK7Y7lhT5OW7h587O5UrRG0DY8m3xtiFjOEnoS628g7O0VEj5dLcUy
 Fn62zgJHqHiY78+l69h6BAO66j/9Wc/BTNgXFywJOfnNOdXBeUTfDtIE4qDx2VtJhNFYmWCYpEU
 Qfi4XdWajqw1QaQqijgtOvvcqWSK/GXpYPxQoFqC0rkP9wmgAYJE7Fx5s3fMYutWHwLGmIODiyp
 wrbww9qIEsVU9kvsTiUknapfjVkO4++hCy9guv3YksT8a3nu079KW5A6M06tVzbTGl6v5pv2GKn
 18YOmzmFMd/O1SyVvNE+4b4Y8+G1kZgFXRZ5uNiVa3TYp+FD/uYkH3zWAfXHPhWxVEFisecHIp7
 t9Woo6k5wyZI9DUhUP3sN8VtGDhL8h3+KksSGZCpCMHPyi9bBcvvu8M+vbWS7vbLObxq5uLZKCU
 KR9bc81pgED6GXRr/fA==
X-Proofpoint-GUID: HwLVGeXNY6YzQ9zNxyzY8ipbOnahsOT8
X-Authority-Analysis: v=2.4 cv=M6x97Sws c=1 sm=1 tr=0 ts=6a6af1dd cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=rvjPyvzsJ2hxnAywV18A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0NSBTYWx0ZWRfX4qfIL5nnwQTX
 +NeTXotxCGWBQUeTYQWnb+KVdHQrQd1xtsydQkPleHCbnjgFC3Z3umRw0ncNKsQvKTwpbMgNnYz
 ju76IO25ISxtmjGXiaNKa5jXl5RZa9Q=
X-Proofpoint-ORIG-GUID: HwLVGeXNY6YzQ9zNxyzY8ipbOnahsOT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300045

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

