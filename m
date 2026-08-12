Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F5415F06
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529052; cv=none; b=qLI7MH9kvSyzUEdetCPkFE7av11XxrknW4KpwMbEZVyuZpx1fVb5GGsXQZHgwvvTkLouWnbkZPdrpgpNW1/UN5IU28XB9/1C8bSGnqoLga3r8GmEvGXcBKHmwed6Ju02ChtbVY/8JpTz1rg3xJQRvUXh1ExzS158Mn/S+qrsPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529052; c=relaxed/simple;
	bh=SotYMnWvmxS18djRkfr2qL4Bi3xHqUJAqLIenNpjgBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upkPU+jRqwNT2+7LM6mYYHbwXM26y/1AQzqX/CqtRCi+E+5CdhAdaQMtccG4FKvGr8H2laxW5cyByVE6gHE5SgHFwY+u9pmuE/KAGLmeU6PSNnwkgiIc+UAoG+C7bR3Wr2SKmfRodYmxxMCj2+qVm/E520QEstxhbGMpFJ2uzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fa9T6AhZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kiNqZ0Or; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fa9T6AhZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kiNqZ0Or"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9fsoG3997200
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9whFL18iu2Q
	rgfkT214m9uxc0VaKgk9y9t/ZTcYknEA=; b=Fa9T6AhZDv4fDVaYxQMfnzATxvb
	0nT9KUjwTP1/YW/FY0jnsZUGhfinqPOh5xe7NqppApfb0u0pgZXxWMDv3sPVG+F0
	dPRJnthLr6s1/A2GxQkKchWjd6w6/sYjUX0dU+ZY0QQOd6zsthIW7AXNuRYlvIcM
	pvm66W3iq9H6gNEaNbVkavq8b3FcLghPN8tNopIgxWyutBCkjY1LRzLvkMNQ/5vM
	Gh1YQfqrezzhGeVwc6LQJkJBBhZaMa/oXxmaWeEKYKerBr0OrslJtAmexSp/OIFk
	ia2S4keNa1Ub07XseuqrOCNDwJ56ENYdtpM+/oQ09GDXVbVOx5+Lo6sM7yw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5k985-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso12311085ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786529046; x=1787133846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9whFL18iu2QrgfkT214m9uxc0VaKgk9y9t/ZTcYknEA=;
        b=kiNqZ0OrS1QPsduuqRnp9vjjXjbtEc1ISKOEfVJvOWTnkEzT8HAJ5i/2/DiHqPNTA+
         4v0WU+QFgntPfD7AfOUsSDQjjLCqKpytJTx699Nvm4ennwLeduBzlAmxUAYSHF2MtPV7
         4E+w3kBCc+DbCo02E+VFA9Q5z8CW9y6+df63Dl8aDOQLcpTaLoxH/Xr+JXXunIC0q4z1
         sOYynJmoRT/Oqo/NLCxMsNzgAU5ChbvLGVlC3LlrVuB1XBIRHmH/wT7ux5+j1kKFYtOz
         udGuDQpRKHTXqb7MsT+a0lq8F2SjdmaW9mGurQ5ABAbkdV0AcR1Nj6Cy4VQiki3kUKYL
         HMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529046; x=1787133846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9whFL18iu2QrgfkT214m9uxc0VaKgk9y9t/ZTcYknEA=;
        b=hCqMauuFRnBRm1Ps8hrgoj5d9QYztRvizpl6ZP/GRbv19rr3N9y6i0jaFtFxIALFPR
         gVn7ozzenvIYoSevAFSW1OJAJsIa0/rXboxbm6B5I4dojsbVHj2/y+zSncF3ady3CX6S
         Y2yJ1db0Jw4rf779tlI6QqlqgxpRi8XeyWBBWlZDnmF4MVToSPE+s4rsathh/W9TcbGF
         dgXUp9nVrBMrV0FBJnXCaCatbejhEOwjVNCuJauaf+AoU+AVDITSBMzMaeK2iO83Z9IS
         LaaH5cSOXEGAJk+BhXxksf71qH9NWb7s4uPCNAVrDdij4cUv3t2toOGZxDuwvDI0h6sh
         zt0w==
X-Gm-Message-State: AOJu0YxJLvTYpz6RUd4R/R2UXz8vw02no033sMbvtKPDFI/0B451rxIW
	8LlOu17ORa9BPyakSLJ2PRXwoevcNDGtu1il3sDkTrM7Vs3WQSrKvoRIBqKImcLOHFR7RnPXF0o
	XN4cN3iKUOtY0xuMI0cQZSBY4MMo6wdA5uIj5vgWAXoI4G3LaAPR7f5Yc6GIjKifeVh0oPSnx1e
	sCjcs=
X-Gm-Gg: AR+sD13cQUa1HXTtW8SVEtXzopDV21PvBfBJd3GQHzfGS9+Sa+AMaJph+JxX6DgqRAy
	hB3tnpCidYjnO4bXVceUy/4xAHJqnyUBcMSv9fvHPLEX7rzoc4ZJL8W9mQY+aeSbWpyr1bgAT45
	fCtKhdx3SsgGhjdfoR/U6dNv1w0LoCqC+bLmZyNENb8XSNB/bQBy1RY9oZlCUr1OoAbNke9NS5d
	3ti/hfwsr7L+Wh2qQeRKkgK2xMQtPXtNld+3flXom9yPliv6Z4Qk4QF/d6KMSh7DFsUYcR3usRj
	DJbcSqDCvuE6mc+4OOtOnZymcoBMGG8/mmBhkP5eA0H9rGddZwV8AUUcf4FbFUBCzLKjn8PTqZJ
	Bx0HkWAooBCr8wEwYtieyEwATJFqwVg==
X-Received: by 2002:a05:6a20:6f06:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3cc3f772897mr4605799637.27.1786529046425;
        Wed, 12 Aug 2026 03:04:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f06:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3cc3f772897mr4605743637.27.1786529045965;
        Wed, 12 Aug 2026 03:04:05 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e2aasm11069961eec.14.2026.08.12.03.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:05 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 2/5] doc: Add org.bluez.CSDistanceProvider documentation
Date: Wed, 12 Aug 2026 15:33:42 +0530
Message-Id: <20260812100345.2956271-3-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX2FqIG0b3eydI
 Np557tJeHMv9tN3ELrhbce3vKsS7t1xjLUlBR/9ZYHFUDT8JQBIQDj8Vw8eL+bS3yipfiioyXXp
 yTIycy3218nv8QmhpULMmEhv5rH9l+0=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c4517 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=3kjGGT6clJRvNyKHSloA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 3qenm9MKfEvt9FKOUO9hoIxBc96PpWbT
X-Proofpoint-ORIG-GUID: 3qenm9MKfEvt9FKOUO9hoIxBc96PpWbT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX32uU505Fxts5
 Dkj2LZmPqMSlhfWwneOiLPpk38vxqwV1Eti/kwWgM8DKuo6X3NzHJwP+PF9BOC9iiJ8FUe+FTAD
 1gHIjwUGtx7gS/CJH3GomA8GZu9ZUv5vcvgNJ52SovkOXCwROxv+mHwlMkK8LMyop7YTAXGLn3r
 6rj1v/OqHLzsAjcfl+9JpqSlfd8Bwh4B5jRnhm6A6MqufbSSYnPlB6Ag/hnwc4kShCpDDBZnHP2
 7hMWzlDFOASmnzHxi4/rG0KNbkjsGZh4Gr4tciUxPQzP1IT7ryE3MtcATn6l6i8FtWIV1EWXbuE
 vFrGaLhjaxVRrcFroLuwsk883g4PimD9npwM2TGSgHtbGWwdzw0k5dHF/gC5LjZKJUl+ADdXR+D
 QAV9m5gdTa1ECanln1eas6LW9bLytMAsGsw0FJuOqqaG6/Rwj0PodQjUOe8V2ymgt7kvqcBVVKq
 Apph4Tj7ejn/lQIH+0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120080

Document the org.bluez.CSDistanceProvider interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.
---
 Makefile.am                          |  9 +++++---
 doc/org.bluez.CSDistanceProvider.rst | 32 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.CSDistanceProvider.rst

diff --git a/Makefile.am b/Makefile.am
index 00b4ac2b1..53bbfd0d2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -406,7 +406,8 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 man_MANS += doc/org.bluez.ChannelSounding1.5 \
-	    doc/org.bluez.CSDistance1.5
+	    doc/org.bluez.CSDistance1.5 \
+	    doc/org.bluez.CSDistanceProvider.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -448,7 +449,8 @@ manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
 manual_pages += doc/org.bluez.ChannelSounding1.5 \
-	        doc/org.bluez.CSDistance1.5
+	        doc/org.bluez.CSDistance1.5 \
+	        doc/org.bluez.CSDistanceProvider.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -538,7 +540,8 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 	      doc/org.bluez.ThermometerWatcher.rst
 
 EXTRA_DIST += doc/org.bluez.ChannelSounding1.rst \
-	      doc/org.bluez.CSDistance1.rst
+	      doc/org.bluez.CSDistance1.rst \
+	      doc/org.bluez.CSDistanceProvider.rst
 
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
diff --git a/doc/org.bluez.CSDistanceProvider.rst b/doc/org.bluez.CSDistanceProvider.rst
new file mode 100644
index 000000000..2d57dc8bd
--- /dev/null
+++ b/doc/org.bluez.CSDistanceProvider.rst
@@ -0,0 +1,32 @@
+============================
+org.bluez.CSDistanceProvider
+============================
+
+------------------------------------------------
+BlueZ D-Bus CSDistanceProvider API documentation
+------------------------------------------------
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
+:Interface:	org.bluez.CSDistanceProvider1
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

