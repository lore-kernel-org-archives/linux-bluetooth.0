Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F730F543
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808059; cv=none; b=NJNaHvMAyx06w10WYmeoZcmoOkWWuWZquktURUWd2ibnGM7Ihm2CyvXQvyejWTEigZrPV1j+U5AkL7NgZD/evYBAJW67d1hI7Di6um/Ti0WtocHvDi73D6bZoQD/7XftYmn0AdjbezcuLqazhIkh05FM8uB7YafcKXL5iZXkdQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808059; c=relaxed/simple;
	bh=UClTuaZpBHsBxD48u8OSfRKDG5nSvNgXmBo3Zm9uUMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL/5wWXMJrNR815bXs9slAr/6r+khF3/KquJRiQv3qHjGBCVhbpUaEhok8jPkfnaPB+go+P2XBCawxrXbkum8ZDkJxskcltUeArTRBYDPoY30kAfmdALMz5bWDMYtoioNb9P5LGkBfAVSOyBrrWiCctgVSeDP/BwxipkjhHW3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AcsP62Wy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ck/6iE3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AcsP62Wy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ck/6iE3D"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3J6Cn3185687
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j0HKQ4OqRonM2/Gbs7hGXGaUgIYibhw0Epzhme/hpP0=; b=AcsP62WyAHPfP6hC
	blGLSe5aaU9C5st3tLnZxm9IEs0DenhKef4NeJSy5Czsg7mZAwDQy7WgvnE+Abfj
	II/oEBTDS/wBnVSd6UmmhOAK9Kw5LkvlSp22l+lMnEJMFxVZGu4SlNrsaIgbXXyu
	8Mv0qPELazxXXctR2uBNOuSbVuZ2YAdIYPg3oqTUp0XIYFk1cQBT8bEddt4zBEqb
	nH7f4CAPSORz5LuwXlGCruqDe4jOZWMMVHRk1C55o8qu37w5Iw6lhhYirf7NydRa
	UlhzXo50xOeSxzgoliUTAHVLPWYT4kvok71zCSJuTL0yAQuycPiYkfgp5IciMbnA
	R1AHXA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egj4g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:20:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39640eebc57so3945467a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787808055; x=1788412855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j0HKQ4OqRonM2/Gbs7hGXGaUgIYibhw0Epzhme/hpP0=;
        b=Ck/6iE3D68ZlZ1E4klTRVBT5fdpdNJjJhKbD2PvRaEyKBMUz/jbtQ1tHx3C7d1MstE
         Ij9q6z6vhumLPMjSN44NCMQ38EEbGsqzoUH/mM5UljidCP0ybJwylBYr/+mvthy3k96i
         yKhC4bS4jqj3eNK2JbS6FBATmzppmV8aPKX0/+LY1aUmttpxdeTnvyg2ej4MWaKY3wsl
         daemq/lQHdxQXH7Qw+W+1sdiJahcnasFmxvgcF/k3iANv3OYbBtaewygaRkMQfzbwW45
         sTtTYcwgJttc5CDpEThku7ALLV+YRpchlWsm8up3Udxv2NuhQLeyn2WONLPakkbXoFcw
         ewUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808055; x=1788412855;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0HKQ4OqRonM2/Gbs7hGXGaUgIYibhw0Epzhme/hpP0=;
        b=IHUfa3yG8qsbk/el4FifDgU2RwYac7n+Pq554BNMckQymSIvzV/+7uZjhv9vg+Rxqx
         F1NA0+893r9uPhIRg48JWtdYhwBnOYyHNFRGD26W/LhK6g6kF0W1awH8NN0MV5Ori5cw
         01msVf3yd0wBCitPYda9gDLGvFpeM8kI9KuClxfyHggOZeXTNgmZ6n8oRVjLt/BAYxHn
         /zkN3v1uCmzddCXiHCQwqdfutTA0e+qo+6u4v/ZWyFS8WT6KNetXyVFVVo3IuB8MMTkx
         dtm+9PgMDwZFXK9rOemNyX26SNsL4XvkCykFTJNVXaqpJia0SJk7MryXLxSWNEHVkhsg
         RDuQ==
X-Gm-Message-State: AFuF++kfDsYe1/Mq41yw8iryCTFwtxBmzW9OEN3v7tekUMs0wdrJtxhm
	yKvbPA3W74pfOrJ/D8E5AGWbMTPnOCQeZHlCfRcE+yG1rqvIUzOIT4JmsmoV4tCVAMy6LFpuJVe
	beOfV7DrwjfaD9z9Jdb2M3JtzywzYDn8RUmpWLpWYaMw+xsSbiEqQXju3V9CYSTRN3mLCf2FwJO
	77lww=
X-Gm-Gg: AR+sD11r7hmljwwABM1m0UA6F8tPiazo7gP0W3XWzaYckeca0FsdfNeYvKF36ov/AbX
	Vwg6as29ihv7rlVv2rrn0HHQ1z5o14DBbBmap6jMc0i/trzV56yhpVcF3w6CG3ivfOqdfU+9J5m
	i0Qukjaxu+ZUYiavtnB6+ZpEhBkCktytxhZoRwUt5VqzV3M40rtlSiwwakoQEWmoofhdfmOWbmO
	HP89lhLg4JmYAzlQmkv7RyZyIl+++7I/u/Bsx1RfQ407m8nUgPJiiu9z1jhqJdlTCsssog6n4lP
	HMgHV91VAmTUznO87hVe7INrbQA5kBZkbQpakO2kof5is9HytYWNBZ1w7oBrEQ9Ti5TNFzx5bPV
	s6Qk1/k6zJRNYBgr8OwF+kLNIYc1qww==
X-Received: by 2002:a17:90b:4a50:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-3966d3aabe3mr23284286a91.4.1787808055222;
        Wed, 26 Aug 2026 22:20:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4a50:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-3966d3aabe3mr23284230a91.4.1787808054784;
        Wed, 26 Aug 2026 22:20:54 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm11903265c88.10.2026.08.26.22.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:20:54 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 2/7] doc: Add org.bluez.RangingProvider1 documentation
Date: Thu, 27 Aug 2026 10:50:29 +0530
Message-Id: <20260827052034.1374180-3-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-GUID: KljVRbNRIQ99-rw2kkl_-vvRkX1Sq8J6
X-Proofpoint-ORIG-GUID: KljVRbNRIQ99-rw2kkl_-vvRkX1Sq8J6
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a8fc938 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QahOU6FDbnqUFrL0YzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX/cOgjIYzqK+H
 vCVkddSiW6r0YXxGg9FP44FsFtVi8iDdk++7bgM83lbTBMPBi+KKUlI9kIiR1bIHjz4lmIfRovj
 55gRaLAk9ysvINV8RSci8oJDSx+Hyyy4lPsPa4hJQS9u/Rs8BAGbleku7AaQm0kLap/7549ChFm
 OhlHPwgZH2T+oeqpaUAVxp2od4/YW5qDKCthcZMgwn9WdSNmsR7tbMr4xVNRC/e0qxc8XShIqxX
 D0MO3WyIK5eq66YzxhModGxKw/56w5KsCOUiDk8D/M3KSWX1gEi3CmxBuIYl2bTeevlLujM1KHM
 abxOFPkFVBBm4IJ44UcJECkuiucterU5jq3Ek2RCWHX+b/CO7jBeh49N1Kwn0hKt7NubfPS0ra2
 m+QExGQwUBCdVo4Sh/bsjwUrFrRw7SWb0+JF/FgO3QHYAuMRd1jAtwQmkGAwBrLpZ3NX7PhZ/pj
 9kB97LuBftSVXSooEAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX1xbnuptrpEea
 4goRKxDaEbgdxplNiPUHCG8/yaFk1Oy4qbZeQ9dI/gz87Y0tVR+glS0aJN0G6HoqrUMA0kj3fVq
 ecXZLawQkqOx2fUvfveU/pfZWCkIwhM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270040

Document org.bluez.RangingProvider1 interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.
---
 Makefile.am                        |  9 ++-
 doc/org.bluez.RangingProvider1.rst | 92 ++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.RangingProvider1.rst

diff --git a/Makefile.am b/Makefile.am
index 682ec26e5..8252df65b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -406,7 +406,8 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 man_MANS += doc/org.bluez.ChannelSounding1.5 \
-		doc/org.bluez.Ranging1.5
+		doc/org.bluez.Ranging1.5 \
+		doc/org.bluez.RangingProvider1.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -448,7 +449,8 @@ manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 manual_pages += doc/org.bluez.ChannelSounding1.5 \
-		doc/org.bluez.Ranging1.5
+		doc/org.bluez.Ranging1.5 \
+		doc/org.bluez.RangingProvider1.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -538,7 +540,8 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 	      doc/org.bluez.ThermometerWatcher.rst
 
 EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
-		doc/org.bluez.Ranging1.rst
+		doc/org.bluez.Ranging1.rst \
+		doc/org.bluez.RangingProvider1.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.RangingProvider1.rst b/doc/org.bluez.RangingProvider1.rst
new file mode 100644
index 000000000..4237d5a5e
--- /dev/null
+++ b/doc/org.bluez.RangingProvider1.rst
@@ -0,0 +1,92 @@
+===========================
+org.bluez.RangingProvider1
+===========================
+
+-----------------------------------------------
+BlueZ D-Bus RangingProvider API documentation
+-----------------------------------------------
+
+:Version: BlueZ
+:Date: August 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	<client D-Bus address>
+:Interface:	org.bluez.RangingProvider1
+:Object path:	{provider_root}/{unique ranging object path}
+
+Properties
+----------
+
+object Device [readonly]
+```````````````````````````
+
+The object path of the device that this distance estimate applies to.
+
+uint32 Distance [readonly, optional]
+````````````````````````````````````
+
+Estimated distance to the device identified by **Device**, in
+millimeters. May be absent when the object is first exposed and set
+once the provider has computed an initial estimate; **bluetoothd(8)**
+watches for it via ``PropertiesChanged``.
+
+Error handling
+==============
+
+This interface has no methods; it is implemented by the ranging daemon
+and consumed by **bluetoothd(8)** via **org.freedesktop.DBus.ObjectManager**
+and property-change watches, so there is no D-Bus method call to return
+an error from. Instead, **bluetoothd(8)** validates each exposed object
+and silently ignores (logging a warning) any that fail validation:
+
+- An object path outside the provider's registered root path is
+  ignored.
+- An object missing the **Device** property, or whose **Device**
+  property is not an object path, is ignored.
+- An object whose **Device** does not match an existing, non-temporary
+  device is ignored.
+- A **Distance** value (initial or updated) that is not a uint32 is
+  ignored; the previously reported value, if any, is left unchanged.
+- If the provider has already exposed a **RangingProvider** object
+  for a given device (e.g. a stale or duplicate object), any further
+  object it exposes for that same device is ignored — each device may
+  only be represented by one **RangingProvider** object at a time.
+  Note that only one provider may be registered per adapter at all
+  (see **org.bluez.RangingProviderManager1(5)**), so this situation can
+  only arise from the same provider re-exposing a device, not from a
+  second, distinct provider racing for it.
+
+Removing an ignored object, or fixing it and re-adding it, is treated
+the same as any other **InterfacesAdded**/**InterfacesRemoved** event.
+
+Overview
+========
+
+A ranging daemon exposes one **RangingProvider** object per device it
+is tracking, under the root path it registered with
+**org.bluez.RangingProviderManager1(5)**::
+
+    Ranging daemon                                     bluetoothd
+         |                                                    |
+         | export {provider_root}/dev_XX (RangingProvider)    |
+         | { Device: <device path> }                          |
+         |--------------------------------------------------->|
+         |                                                    | reflects a
+         |                                                    | Ranging object
+         |                                                    | on the device path
+         |                                                    |
+         | Distance = D                                       |
+         | PropertiesChanged("Distance", D)                   |
+         |--------------------------------------------------->|
+         |                                                    | updates
+         |                                                    | Ranging.Distance
+         |                                                    | and notifies clients
+         |                                                    | (see org.bluez.Ranging1(5))
+
+Removing the object (or disconnecting from D-Bus) causes
+**bluetoothd(8)** to remove the matching **org.bluez.Ranging1(5)**
+interface from the device.
-- 

