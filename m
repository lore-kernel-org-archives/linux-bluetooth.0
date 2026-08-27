Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCE36165E
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808054; cv=none; b=V0H4u+NJSAPwi0Ob+Rj6RC8T/99rCdT95dZt9mrBukm9PrEBSjcLgE49KYT7mw/YfJiKazgWKAQw/6ojFsxUrtcX+dD22oFVanWwAR2X92qDjcm4pK3EviVebo96teTuI6vXzhwDSzjIU2Mrvs8hcpbftBCkAmjC450h5p335A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808054; c=relaxed/simple;
	bh=XRr1WWdBuWEHiGyUle8j2SqeS9ZUv/yVywRwY708bF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HriL2aY3yVdzCNLREaJfpG69Kc78h5x1WH8pqMboK5yCRhngawQl4pRoi/FgSCYtdDq5UA1+aBdxgDxN4+FM+7WNKqGxdZ5oAmFQWtHVf6ciMQgezByCiaImA+Y0lb1eJjtePwsdk73SbigKM69L6HyWdk3ksVQcNz+xIROGGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YI40/ToB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4xi3Xim; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YI40/ToB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4xi3Xim"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3J8EL2632713
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M+xGVVw9E2mDYC+H1Bp45zexll/H6TDjoqEKXa77QAg=; b=YI40/ToB4LF3SEV/
	NCYQNb4Y+tTxJVXakz4dcAiZdl+9ydYZJBVy1NjbfLKnigcEf3smlnfEHtyBb6ZO
	nTkOwdiDUagtGij5BiyWUL6didFO8JWDl6nWFmo8MpFzftpBWoBD4gUytTmocSas
	hn57Yyy6Ruk69S7tDTmKjxzD+NusZbG4oVt1JZ6BLj10q7ERCH9M1U0igvrvF9iF
	kuvWSDqjox2UOFUt47vLPOBzOFr+pGJMAQ4lnygET7ldue3qHxOyJv82HYpMmK9W
	zn637XaDbkBrE9GomTw6vTrOmg8pGN9fXfrnWL0L42cgkoAw9Tr/t/rKwtgeQJAX
	1NxaDA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03abaj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-396901263b6so1982364a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787808051; x=1788412851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+xGVVw9E2mDYC+H1Bp45zexll/H6TDjoqEKXa77QAg=;
        b=Q4xi3XimQGwOPb5dKrWjqBFbcfnA/Ky9/o3ZRRVKWbNeKEd0xDUik7FUlp43M2BJnE
         gf90IZcvsu8FiDs5fVy0uF4raPYOLBAX+wdrpu0MquxTDtvLbAe3FUg64JFKrGwWShbI
         bpiEIQvIENHE4NbjyRV6XAaXL8BgHaSS+ocqlMQhDGYpGrvqCrY9eJ4xhiR+dkG7nOnb
         NHxjL1i3HKU6OkFuG15O7pw1k9sE+zX3N6J45+mDEDJUN6uwhCL/VTurbmhpt2ZAI/ZZ
         /EvBozpHNGH2pdz1JyDgsRTejs8+IQicGT7ORZNkeUJ2ju944M+2RYh7cEkyUzYRbxKv
         A2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808051; x=1788412851;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+xGVVw9E2mDYC+H1Bp45zexll/H6TDjoqEKXa77QAg=;
        b=XHERp6yHMjnwSrE8j2Aio2ptsTX9RiPP9xWRK6nQ2DBm6xwfQAHrVsLgG5a5/W5dqb
         I1hjb+Lqy31SoTJOEYh5S2YlRoHI1qeOaZtE6H4AkDrNC9nVVtzmqBckpk9x3uDUT5KP
         jsYsRRPxwWp8H8ZFfg0mUb/sBe6jHWHcQslanY7rkcFy35sc+1AxQViXAUXA2joPZGlC
         vIe517cCaLOFIYMKErRZ7dszsB2ZLnS0pqYV3CCfRGFcEWvo5TyV8RpA8qD1thURP8nP
         450RyvcclHLWEHTVkaVEV1oceVdwHvkmjnNnAfr+aPc36IcNIe1pJr8v7ypFZH53NvpX
         Umag==
X-Gm-Message-State: AFuF++mqU39v+VRHWcN0Safod9WloY9TjgiUFMayFlXeHZ8E4mExbCIW
	BlZGu+zHNmUZr/0l44sDNg5llIJDUHcvObjYh1PZ/HXE/iI95UiZOOMLxERGIN7snLvfc8U8ZPz
	Tzld8lgM/nUZQ+x7vyLledN5Jbr0eXuDhVt1RQvzdkz1ciYuq1KBctZzxiqcvkCd8CKe/0qqdcp
	9YGSg=
X-Gm-Gg: AR+sD13bEu58SBx3km75og5Z7Rr2AhSKCvGIor47RNh+OpDppghiZjulldRXsk+NWUg
	rb1B0T7Ph26gIFwgSZqbbJ3AUz3p6gorSlzKT4ckh78+/PIrmsy2tYbESBlvEJy7Ss4Y7sQjM6S
	WsodahF2rrCusJE8PVp9eqxrSjFRLPWltGpRSehsOQNslyGM2Y0To99ip/ZVayqQudYBBbiUVgY
	2FXoWFpRhM+Mk9/kiFbgifYc5fqNUsXBZAdFwUAiHO1nUHw5bEcyRMzvY0kNue9j2/2LihC4Qfj
	+vCdWjQH1k+dZB0ehIHYWSQMPP2kSsVHy8nk4pu1OJpVidmAF6PJLo5NDqem8y+u3JtM/0c3QE2
	Ds4j3asO7E/W7qjsyScPXJus+8wf/YA==
X-Received: by 2002:a17:90b:5544:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-3966d4488ecmr25703576a91.10.1787808050715;
        Wed, 26 Aug 2026 22:20:50 -0700 (PDT)
X-Received: by 2002:a17:90b:5544:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-3966d4488ecmr25703495a91.10.1787808050199;
        Wed, 26 Aug 2026 22:20:50 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm11903265c88.10.2026.08.26.22.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:20:49 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 1/7] doc: Add org.bluez.Ranging1 documentation
Date: Thu, 27 Aug 2026 10:50:28 +0530
Message-Id: <20260827052034.1374180-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
References: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 35f50eejmj4-ehtpOJN-kwyUFQKQfGQU
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8fc933 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=CtwxR8TWV-WNJIBUySoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 35f50eejmj4-ehtpOJN-kwyUFQKQfGQU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX92LgjyPPz/B7
 h+WgDBg/RQhMdJ+/4hqSNf78ewTh+X3OcPoibkMcg3SsvnKoWcp1s92pPsq/4W2Th3jINkuGeKD
 QSdBLjsY5LhgUzo/dpKZCbsj7tAGFr7T1WLGJW9bL4Oaf+d3BVukub8OJfPD//4iFMcSESMU+zp
 1wrgeGs0ttji5aA5XJsEaYL3GpFhobiZBsNGETFUjKE2OEasybKPycXpawrnzka/hpeA1AdVIa3
 18jGZoRNSd4AoIHxDCHVL25A3vPTM2qvS0ISdHbqcgRTDRtBRTD2AcMx/ZvJFZjZmgl9hFk14tN
 axOWFmxdzsaRIxUYlfOz/cU70gb4B7N5Hz8RxNZt08geKwx9sppBKKqY3Nd4+dYWnvzhFS9Rhup
 N38HQZLvTlP/CG6LODPn0wY9hwoLiBzLk77XCSFzDrWLOAdnl0w/h9iG1vT5RR8ILAXb5nGbC5w
 g/r5UBXjwMWy8vNRxTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX6+z4uTGMoNyv
 VJj4QKtt29wK/btGE8xFZuZBH75yweTOORU1AXGNPkoTrCrKlPCurMk4/1ZGqi1z60jum2gPhBG
 2TYbO3dWEsCCkhk1ZfCyd7DPO6oh/e4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270040

Document org.bluez.Ranging1 interface, which
exposes the Distance estimate computed by an
external ranging provider registered via
RangingProviderManager.

Add org.bluez.ChannelSounding1.rst to EXTRA_DIST
---
 Makefile.am                |  9 ++++-
 doc/org.bluez.Ranging1.rst | 78 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 doc/org.bluez.Ranging1.rst

diff --git a/Makefile.am b/Makefile.am
index ab7457252..682ec26e5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,7 +405,8 @@ man_MANS += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
-man_MANS += doc/org.bluez.ChannelSounding1.5
+man_MANS += doc/org.bluez.ChannelSounding1.5 \
+		doc/org.bluez.Ranging1.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -446,7 +447,8 @@ manual_pages += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
-manual_pages += doc/org.bluez.ChannelSounding1.5
+manual_pages += doc/org.bluez.ChannelSounding1.5 \
+		doc/org.bluez.Ranging1.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -535,6 +537,9 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 	      doc/org.bluez.Thermometer.rst \
 	      doc/org.bluez.ThermometerWatcher.rst
 
+EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
+		doc/org.bluez.Ranging1.rst
+
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
 
diff --git a/doc/org.bluez.Ranging1.rst b/doc/org.bluez.Ranging1.rst
new file mode 100644
index 000000000..8dce07e04
--- /dev/null
+++ b/doc/org.bluez.Ranging1.rst
@@ -0,0 +1,78 @@
+==================
+org.bluez.Ranging1
+==================
+
+--------------------------------------
+BlueZ D-Bus Ranging API documentation
+--------------------------------------
+
+:Version: BlueZ
+:Date: August 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.Ranging1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties
+----------
+
+uint32 Distance [readonly]
+``````````````````````````
+
+Estimated distance to the remote device, in millimeters, as last
+reported by a ranging provider.
+
+Providers implementing **org.bluez.RangingProvider1(5)**, registered via
+**org.bluez.RangingProviderManager1(5)**, compute this value and report
+it back to **bluetoothd(8)** for reflection here. For Channel Sounding
+based ranging, a provider derives the distance from the raw procedure
+data reported via the **ProcedureData** signal on
+**org.bluez.ChannelSounding1(5)**, but this interface itself carries no
+assumption about the underlying ranging technology.
+
+This property emits ``PropertiesChanged`` whenever a new estimate is
+reported.
+
+This property does not exist until a ranging provider has reported at
+least one estimate for this device; reading it before then (e.g. via
+**org.freedesktop.DBus.Properties.Get**) fails with
+**org.freedesktop.DBus.Error.UnknownProperty**, and it is omitted from
+**GetAll**/**GetManagedObjects** results. Once a provider unregisters
+or stops providing ranging for this device, this whole
+**Ranging** interface — and therefore the **Distance** property — is
+removed (**InterfacesRemoved**); it does not linger with a stale value.
+
+Overview
+========
+
+**Ranging** is the read side of a three-party pattern ::
+
+    Ranging daemon -- RangingProvider --> BlueZ -- Ranging --> Desktop clients
+                       (registered via RangingProviderManager)
+
+Sequence for a single distance update, once a provider is registered
+(see **org.bluez.RangingProviderManager1(5)**) and has exposed a
+**org.bluez.RangingProvider1(5)** object for the device (see
+**org.bluez.RangingProvider1(5)**)::
+
+    Ranging daemon                    bluetoothd                  Desktop client
+         |                                 |                             |
+         | Distance = D on its             |                             |
+         | RangingProvider object          |                             |
+         |                                 |                             |
+         | PropertiesChanged(              |                             |
+         |   RangingProvider,              |                             |
+         |   "Distance", D)                |                             |
+         |-------------------------------->|                             |
+         |                                 | updates Ranging on the      |
+         |                                 | device path with D          |
+         |                                 |                             |
+         |                                 | PropertiesChanged(          |
+         |                                 |   Ranging,                  |
+         |                                 |   "Distance", D)            |
+         |                                 |---------------------------->|
-- 

