Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7123DA5C3
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019047; cv=none; b=R4Voc44p+wa4L1McCCh7Qdlcb3lku8wEG4xQPu63nYyO6NXNSRxQOE26jwJpjUdGXiC9Vas3GhhDkbuRWlLrwGuME0JP2UQ4Dq/EOjWRL9ch8hg2Cz+zgl1ZMZ+rxg3sTRyWIRYtlPYqJ+7pwrOqXQuJW9jpkW8wcxa3kAqkdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019047; c=relaxed/simple;
	bh=aWv4CsUWOUPleRsEVDAXgnSsI9COV/1b37JFZigUlH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttrZn9LVRplejVZAiXcgZgyHCOMvr2VAJ8hBS4EN0dWtD4QVd5yARPfXj7rmZVOYnSVub5mp/kczaBsNXGg1jTvYDicHfOcpmmU8mDhYoV4gFaaBHb+6DXd704jp6gbhK2q8Mnm8fMTuYW6wQaQVDmMiwWlS74WHNbKBNpYq0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=acaIgr+g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dZGwu33b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="acaIgr+g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dZGwu33b"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6Sb7Q4005305
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7L4Xith+6oSQA5D2Lo89qYUhK0yvbUYqOrP
	6Cpo1GEk=; b=acaIgr+g1PC82EoMbb/LRTRnLhKZXPw4ybPjdHrji+cse7sOICu
	ZBxGiMvfS7DqstUX02yDa4W14j9VQRgzwD3PDE/HyeGLZ1YMC1YojjGet5YJf71t
	HIud3eG70auAtMseAxQGEUjrvJM+YzXTRAw2FDWQ6h0w1+CfdhaCkiNVMa8NdKuk
	yi/rei2WVegKKEtyYsvhOqm0VpfJ6H6GQEj7SQ3jf0h5suEdsLRf3GB6C0i3Zi2R
	WQwCbQctOHbhTyvBCN3IACBwStfe3NPTznEx9Af/HmCU8fWrfxMhbYEF2Jb21VJv
	RtXAerip4zYAMV8DvKloMz6gMjofN4JJRYg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ctwmw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so6217709a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784019045; x=1784623845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7L4Xith+6oSQA5D2Lo89qYUhK0yvbUYqOrP6Cpo1GEk=;
        b=dZGwu33blm3MTZbQ/6tsXcE6YQFLuZtHoKH/CKebsoPsoMR89vyt1wxRDdgddpNlGR
         econRYAPWD9KaesYpTgbZu6uz6Zt4ZIC2nZmn66cBRyD0K98KdEZIAQ+ru+ZwhA43oMM
         oMYqL3j/ZXK7e15Ssxt4UI48pkMqoLVA1PW5BxCdHhWKiwOzq4yF4i4TmFLyZ8ZjASx8
         AhpW6ttYb+MNLGaVa82kF+NIy10v2+65RHJ8dLoRevcS3kJ2IFh2bzHfxDgjWDaKGlA/
         zY3/2wZ2wNukMbi59fAlBB8P94P6u2xKXr6Ssn+vf3HXLkbowrsmZaG6DzfnKfq9aM0K
         /cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019045; x=1784623845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7L4Xith+6oSQA5D2Lo89qYUhK0yvbUYqOrP6Cpo1GEk=;
        b=GAZwOVdcP3Ic7Xl94pdPG2+zJ19stqgEwV9tgE0tGNUxEVh55xFNqPEOZ/z+xf2tjz
         IGYhJnnpRYxQQAmWhC/YijZvVTIsfod+UsBzCscpLfhkbeVNJhF3LtDNk/7K+ZZB3KUX
         HLLZl4phQVlDIFDq2GkZzGapQjQ6ZRsXdSwVSIwF+EtqywJ6Mq1tqpuJUO35uk03R4u0
         cQvA9D8wyg04jHR5c0s3uxm38dtx625YfKZnuYo4OjaNlA1PHzJ2PZAZn+5hgdbFoRio
         D4B/g29wB6VhezU/SLVXo7zm3qPbOM4t0MjvjZj3nCPC/8/E93eJJCyNwJ7VL13F6vlP
         o0hg==
X-Gm-Message-State: AOJu0YxFtqRajo45NGKYDDIantxCBX13WwyofT/v6Cy9pCtzq0bJzp0O
	33xA2CFmV+kmNvIR0F3kDicMNSiItXhYbEjXGK/uzP/T4t3XKpPQcfw55tO8vmNCJK/QTu/UjYR
	2LNLNzvOWt8+k/Kr2d/Dh+qTAHddYYNh/rcoJxSc7N1P5U4sU0pymn/momRprEMXk9N9puLAfMh
	rkVEo=
X-Gm-Gg: AfdE7cm+C0QGCmPn9h58YK3FJ4d76PSr5tOOXg112VOoVlwpYQyGts8XqVJMu0ittyK
	XM9Z42k697xOfc74QJ47uKv39uL0fJB10F975O2DNfEDpuuKjAr0efmI9kDiWEw3moxTEdQGTlF
	JZ3EwPauAm1lVfH37QFlwNtS/H8T0OCjDHYUIClE3ph69UNcaGVHO64j1FHQhrmifkU3XXYTpnD
	kaz1k6K5za1OxR42EPuS2caexZGPwqsjWVjSennKeMvxUpnhVlqZl36XXAGFEQKsDjsaqYXCjix
	636g0LIUOEpsTuWVThJ8Pl6NkQwPRnHXSRxbuJLSaqs372JngjXOLXIofgZs2okU0GJbiU73o8x
	GDjYI26EmVJQR4J5Dm0uzRGF0vgiHLEiPyWcznUXr
X-Received: by 2002:a05:6a21:3384:b0:39f:3efb:e888 with SMTP id adf61e73a8af0-3c1102989admr16879829637.25.1784019044960;
        Tue, 14 Jul 2026 01:50:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:3384:b0:39f:3efb:e888 with SMTP id adf61e73a8af0-3c1102989admr16879783637.25.1784019044535;
        Tue, 14 Jul 2026 01:50:44 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9081d5c3sm27645721c88.9.2026.07.14.01.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:50:44 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 0/4] doc: Add Channel Sounding API
Date: Tue, 14 Jul 2026 14:20:33 +0530
Message-Id: <20260714085037.1285756-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YPIJG0cEod5_1hoARCEcmC51XAf4On17
X-Proofpoint-ORIG-GUID: YPIJG0cEod5_1hoARCEcmC51XAf4On17
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfXwWVankfGTR9P
 oqVondX0TJv3UIbqhLt2y2p3/XVtH/jsY6orXcVMHJSBbshEfkfimSV7kphcIN+M6rMV+sNHEp+
 plMCt8weHmGQYGGhxmBG/3COB+931/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfX8QwnwMIv82al
 8wfIZkK4TE0LE7L8fv/1thXFpJOKZjRIKExCrxvSfB3PdIBgwHNaOeEU1I4mOxmcQaobXzoG25c
 FUa+6kQvFhzPy1reA25YP8QEwe438xTzLjX+5+ne+f9cZHnq6d4Ze/rN+8hqD0ioJ6foNYxo/WY
 xGjH+q3J9LYG/qKYcDmZzdgjVMCkyGScsYN5O6GRzfn7TXmHgXI3Pdl4dDRAhaekz6qVmQ+Y19X
 p5ulOHhCV8BbubHgCn6OFdXh+LtyraSucxuNPSlre4wHf/znGptZu3+2eTOmSAWBah1Kysnll9j
 kTQ3raweQrQDejJx8+bMtOz4P03Hz8unTUB/bD2ST62jDUnG/Tp82vbGO2X6Ett1p1/FqlCbywn
 urv0HnTg52edL/KgEM7JUY38MdLya4NIhGPrfV2RBgdq0fCyKlj1F4AY81g+rCxCMliZbC/xlCf
 cka5KTPuHzHmdSP7Ttg==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a55f865 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=iSzkMiWJHOwH8bCpblYA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140091

Improve Channel Sounding documentation by adding cross-references
between the D-Bus APIs and bluetoothctl commands, along with practical
usage examples.

The D-Bus API documents gain :Used by: references to the bluetoothctl
cs submenu and examples for methods and signals, while the
bluetoothctl documentation is updated with :Uses: references,
argument descriptions, and usage examples.

Changes in v5:
- Add Example scripts for cs reflector and initiator 
- Document CS params per-command

Changes in v4:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Changes in v3:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Changes in v2:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Naga Bhavani Akella (4):
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
  doc/org.bluez.ChannelSoundingRanging1:Add references and examples
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments
  client: Add scripts to start cs Initiator/reflector

 Makefile.am                               |   4 +
 Makefile.tools                            |   5 +-
 client/scripts/cs-initiator.bt            |   6 +
 client/scripts/cs-reflector.bt            |   5 +
 doc/bluetoothctl-cs.rst                   | 546 ++++++++++++++++++++++
 doc/org.bluez.ChannelSounding1.rst        | 534 +++++++++++++++++++++
 doc/org.bluez.ChannelSoundingRanging1.rst |  66 +++
 7 files changed, 1164 insertions(+), 2 deletions(-)
 create mode 100644 client/scripts/cs-initiator.bt
 create mode 100644 client/scripts/cs-reflector.bt
 create mode 100644 doc/bluetoothctl-cs.rst
 create mode 100644 doc/org.bluez.ChannelSounding1.rst
 create mode 100644 doc/org.bluez.ChannelSoundingRanging1.rst

-- 

