Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB9391836
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411839; cv=none; b=furXjnTaZC4KJ9nNpAoWtCemUEKC+eXlI4L8bWuPLVoNrdhPP86MrOMXQfeS2KXKaIW+id9IgVCjNmqd49xduSM07yQOhDLp1FjuX/QOoVrDm0gqx3FVnXQ+4YkK1XvHK7XLcbbGUyFcG2ptCM6jhgcoBKPRQl6WR/Wjxwbtfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411839; c=relaxed/simple;
	bh=H6fgtRycCDcRlQ3O3ZOpbHWpX5eTNQ88yk7Ptr7nrH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUW3HnnU0uVfLkfJ2PGHNqEUV6cjzj0KyvLbNJ9QAdki8/L+RfTptlV1bb1CCnXsQHkT1eETuSYzblC5yXuYmn5IpxehkCM+CDXEvQUEH47owJmClH71irZOKU3Sx0RHPZg5QRuZoRwXBAvAR3jyMlZ1MsuhjRc8c3Cd7S9/XiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Miob3lC3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fuzSB8GR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Miob3lC3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fuzSB8GR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UBWBI11144205
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ytskW0wLfqu
	RBy9GcVg/dK9RF1fwlkd93tAo8WHhNBI=; b=Miob3lC3RWnP8vmgLVm/9yeK3/H
	e+3nUg7CTnx5chU17DW/AGYnFUH3IwGG6l+UNCxt8B90xdKeByPajeyTsN7+TXYb
	pvjjysi5CcKo9FbyOGUA3hhyW4QdtSWoH+SY5hlDH2JchoNYyfcvIkhquxkP9m+d
	DOThl0vNY88zdEAi82fD9stmx4nu3p/jj7oGDCYeCtClhj4PcbmIR/9liwAyD5PS
	adUkP75EdEXN4B5v5bh6bDGnvqslF+Xg6YeguGCFyNBPboLEsGWfdbx33ENtEmex
	+tgiFvItW4cuLUQL7e4kmc0fAF4yxcIIFC3jM6N0A4/Zp4gnsd9rRO8Bi6w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5tvr19b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:43:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c860544c077so4281744a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785411837; x=1786016637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ytskW0wLfquRBy9GcVg/dK9RF1fwlkd93tAo8WHhNBI=;
        b=fuzSB8GRlV23nBNYdqTXkJ2Yw/MK4r6sJND9DVmZ4vcj36RW331BPDGaBsJsQ3omq9
         pvtGVOWbkurt1zPAeBvUjp14DSbfIrqNkpw9ST6NxrJYdKR7jH/FFt8HA8C4K9/W+AND
         ccp9NgdetZJKXGYyZHqC4YD82ku0M+EeamY4v1cEqCkCbRF7dlU2JQNntJ3l2mMs556O
         Mvm1/WKJAbY7RIBmUDjXehK/bX/Iqmkxah68UKT97QJ2MxCVp11D+MyZjptUVFtzWZvi
         toIWckJyc0xZ97fKcp558qAwXAyoF3FO+VpHG45FKOVSEt9Qilv5ZsnCQ40LCV5+PdG1
         CtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411837; x=1786016637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ytskW0wLfquRBy9GcVg/dK9RF1fwlkd93tAo8WHhNBI=;
        b=Vp2cfkUTU7OPNIuarIIHpCdq0VVqGE+LXM4wCcKiQAtSizMTG9mEcVwIrELOFfpW4x
         ttpp9VvcliC0BXD7RDMM32dz3NMabJNG4eRJC5sd4xURvlUlWB9/RGyvYn/LPR21Dyib
         Iipxe9r1/MXfzXNbxCf6x7hfs3BmE7AXT4GHMhMHjVkugJaeIzTLugdyRgXiZOS90P1m
         DICfkecsq+SMdSCgJx8m39fAuuKGfwhodN+bK+4yVFZ53daHSuaqmFyCTdeJhi17V3y7
         qboPyYGoH72oer0vkiPxTd5ObEv21FnXqRtTQrTe8AuVTHhvOfRaY+kDQdswhPxGNCXk
         FxGg==
X-Gm-Message-State: AOJu0Yx85QKX9sTh/VFigKrlCHVr0X4LK/p6twbr0ZjEEUsKfP2YEAky
	P3fI4O05JSw7MjsAVJrkZ2yizUrZKxSukZbFgG2GmNPaDRNsKvw3HPpP1kMWWqTOR//fwWiZe7W
	kyXNFqnEz++q1FbxC7GP9XmcGtTSfyW6urwAowJXKiFjUPyFVmO/2LLJOdXC4R810a2PI3IzmyC
	ssiig=
X-Gm-Gg: AR+sD10dSNhIXOdAulL8LuPbY7o1uxPFjR/SdUszbDrHKn2iwF2oAJiq9Z25us5CcW4
	M9Oxgf8ok14GyJZMfGW4V+nxs/xg5juXW2jyAoKIIoiqDOfL3cjZlrckH4t3l9oGlX2P/mOWfO/
	TUxSuXJ414G0kEYlQrBrygLhsTBC6IfMRugzqrWHsYVhITzLda8xn7mdLfYNuHPOTeFx3byuua+
	s3EOIKmAIE5VA7cABocL32MrVAhWE0T8RuoO/Ad6wTlcoG6G8yVbVyJyKq3OJQuZdacnmfz6SqA
	smMp6aNFNA3a4r1/7WZ/Feto61S1tRzqdnKumqq6F1WeAwZTKHGtqwp+7sFUo2Nb6uD0LZPz2AN
	LFjXEHogWwKFlhruGn96PFK1MSmC+HQ==
X-Received: by 2002:a05:6a21:4cc2:b0:3c4:2c02:eabf with SMTP id adf61e73a8af0-3c9006f9067mr1921848637.60.1785411836687;
        Thu, 30 Jul 2026 04:43:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc2:b0:3c4:2c02:eabf with SMTP id adf61e73a8af0-3c9006f9067mr1921828637.60.1785411836260;
        Thu, 30 Jul 2026 04:43:56 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7273cd9esm20961598c88.13.2026.07.30.04.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:43:55 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/3] doc: Add org.bluez.ChannelSoundingDistanceProvider documentation
Date: Thu, 30 Jul 2026 17:13:39 +0530
Message-Id: <20260730114340.1576049-3-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfXzKvXSfTavCHz
 czSw6h3yK00QJQbpuljgT49Hx6NYBC0vZD36YoY6EUGLW8gHO5pV3CT/8Ca+9aqO1YshmqxRXBB
 4ACOiCqbY32c4xdBBcSjX2/Ij+zzL+s=
X-Proofpoint-ORIG-GUID: w5sXOkxcrrvI6zBG20miQUtnpmlVnO68
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OCBTYWx0ZWRfX/rHboVGAFD0a
 m4dKhhKehi0zaC6bpsNxO4UNt8IO8Ere0ApDiJQKxPoP5DQ4PTxJKyzy0VVQ60bJr+n7euLtxF5
 QFXO3i5ZQxWFOImMBSO7Em37cOdPFGyTaSB7cWg4en8osdRqIb2KppcC4/KqDiP5kn9xmVgsOke
 K3dLe0Z6Wz3i/tt6vhI3oprzJTPWAb04oGJNgSiKErg8bskTDml5etvFQIoeAY71W07g8TxhAsS
 huOh2TUTyjNbaB4rLHA0RRhNXfCWiACaFa0qzF2kx8iDLRt8W9dikVQCQeTP24R7oDnyudGsir7
 n+/A77uEAQywh2aTJbxZbayGeQfa24mZxxMoOHQOpvNGumHfqCW6fSoDXBW2+9WPnFm56BUNNrc
 wUBZEGPH8s79rNFF9GLF/8+ziplOc9ELBfdn2ZhTrQl69y4kj9qlG2XPuAH03Xjdshj/dQrev+h
 gz/Q1+6xevu33mic5fA==
X-Authority-Analysis: v=2.4 cv=ULPt2ify c=1 sm=1 tr=0 ts=6a6b38fd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=Rz3GnNkrNbpm_KgeIBsA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: w5sXOkxcrrvI6zBG20miQUtnpmlVnO68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300088

Document the org.bluez.ChannelSoundingDistanceProvider1 interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.
---
 Makefile.am                                   |  7 ++--
 ....bluez.ChannelSoundingDistanceProvider.rst | 32 +++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 doc/org.bluez.ChannelSoundingDistanceProvider.rst

diff --git a/Makefile.am b/Makefile.am
index a5a3c0d30..e5ecf232f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -406,7 +406,8 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 man_MANS += doc/org.bluez.ChannelSounding1.5 \
-			doc/org.bluez.ChannelSoundingDistance1.5
+			doc/org.bluez.ChannelSoundingDistance1.5 \
+			doc/org.bluez.ChannelSoundingDistanceProvider.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -448,7 +449,8 @@ manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 manual_pages += doc/org.bluez.ChannelSounding1.5 \
-				doc/org.bluez.ChannelSoundingDistance1.5
+				doc/org.bluez.ChannelSoundingDistance1.5 \
+				doc/org.bluez.ChannelSoundingDistanceProvider.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -539,6 +541,7 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 
 EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
 		doc/org.bluez.ChannelSoundingDistance1.rst \
+		doc/org.bluez.ChannelSoundingDistanceProvider.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.ChannelSoundingDistanceProvider.rst b/doc/org.bluez.ChannelSoundingDistanceProvider.rst
new file mode 100644
index 000000000..9a7a390bf
--- /dev/null
+++ b/doc/org.bluez.ChannelSoundingDistanceProvider.rst
@@ -0,0 +1,32 @@
+=========================================
+org.bluez.ChannelSoundingDistanceProvider
+=========================================
+
+-------------------------------------------------------------
+BlueZ D-Bus ChannelSoundingDistanceProvider API documentation
+-------------------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	<client D-Bus address>
+:Interface:	org.bluez.ChannelSoundingDistanceProvider1
+:Object path:	{provider_root}/{unique distance object path}
+
+Properties
+----------
+
+Objects provided on this interface contain the same properties as
+**org.bluez.ChannelSounding1(5)** interface. Additionally, this interface
+needs to have the Device property indicating the object path of the
+device this distance estimate provides.
+
+object Device [readonly]
+````````````````````````
+
+The object path of the device that this distance estimate applies to.
-- 

