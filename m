Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD344C51B
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248168; cv=none; b=EYywkAHI1KEt/srrUlXCC6H/nNBhbZ6VuaPkrUnfQvMrKzW062IoQVyqcWURgUXidljmjn7dm8A+STvwSZXbGPv/6U0qM8hTx1Az0++R3SW6iZUCfVHKucqmwgem6w5z9EcudiVhgF+wLQPIhe+XkAEwoJhywlRndCUrJuavwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248168; c=relaxed/simple;
	bh=FbovGdOB+ZAMU3VwJqa7rT+51Xz1YFBYzERvez1K/zM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOyEsFSZp2dzic0c73I2JQZYVHAW4MILcOP1M0rI+lfylgOphlOvLAIupyiJM/3UBUobEOGua9jJvBF76zTaxWDHO5OST3xd/xYMF8XXze2SRzRdzkzzx6jQnH46pNlD85P2CNVAx2ENGNpH0JLpSFQ/y84uGBBRKmoAloB8xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EOCBff6u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ff1UWMXf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EOCBff6u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ff1UWMXf"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KG77m13735820
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aLBbfM1hgTt
	Cb9Xw6OUBxTAWXRjJAZNpmOG01XDDsj0=; b=EOCBff6u58nKTbyJL/LYp4N2PW0
	EF/jWu985mncmeQyxlDriTmDt68HecwYrkEKdYgvOUBq6FS7D0CbceAgFtD2Hgvs
	1BTNJPq8wjcM4vPYwOvR96Bi0eoaMwHGYB8guRv7OdQ813rkGTb2S5z09tT9C7wx
	Lrnc6yTeEBOoMxc3IBk4JgoYahngrQY5hfWkXrX8WsKQPjNEGAoD/eeISx4MNFll
	V7MLfGuqGS8wKZovinpbdF0Aw5R8xNLKZzDS2hpo4c/VZXC3eEkPpn4DAcPViUFq
	ajSZkmp0yv2rdto0VQh1uiZSm5tv4tm2MirHScjojBn+cyBwYW/umbjTOtg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0j2dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so111835a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787248165; x=1787852965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLBbfM1hgTtCb9Xw6OUBxTAWXRjJAZNpmOG01XDDsj0=;
        b=ff1UWMXfzJEoyfGExdkCRlxpZdfBXAbgQjTl/h4qpRiHQ5nIkBfsfAot5Cpv8rwO+7
         q/wc9VTZdHOZEZC+KaMsN5oLe5t33AE9sTPOKbvNUjIt2Pme4q1Ynru4eASAl8MMVwGb
         fgcBBSn+4McV5/9Y3m7wRVPDuJ3wAqvUwvd97gvQf+kNWUIn9Hvq8YFtAmchc2e8Bvqb
         /Y+eKm+UB587pKUrtPTPmwNXIDDCQGI2VNemEO7RmrhEaOmDcbAsdVwZsyVED6l+m1CA
         ArJL9nFOOwK0QsThAl4urQpLypePON3BRaG7tgHoaxA4DjN3rsixtHdabOsRz6bmyhNO
         rntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248165; x=1787852965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLBbfM1hgTtCb9Xw6OUBxTAWXRjJAZNpmOG01XDDsj0=;
        b=bZgZA108kxM00EogzMGhXHPfLU1n9jQ8nJZrbAFoj7sUXw0sBKi9KU+tjfO8yk44UK
         OAvO1T2tQDel19Q3rZaKVZNa3RlSTl62q/zqivTgvuO6NyvY2fuUOi+Vg7zYU/WwSzLx
         g7iU9JKCrMPD96Kvk+vMn2PnTabxz6XzxjsABET7W2D2Ksuwnks+8F3x9d6VDYZ8HBhl
         MnTbq9It/EIdrcoawwEUa9E2oJOd/0IJ/1hYuOpeoDMGSaLUnqN+jQ7EUUnUGy2u70dC
         ZBh0GIrJcGYTL9bcWXKOlgvZpfy/ergi+SQwb/kyyMqQp/QlqnGK4i22NRD8D5h1x3yq
         d6Dw==
X-Gm-Message-State: AOJu0YyNwi07g2KLZVLYRO3pgf1eEZqYpvOnOGOgiRRYoA3+SSsn/UA/
	d3gb7BEFPWZmbu/6ZNCVHC95+0NMwjD/91eiL5q1SJmlWXj+zVXMf5b7QbyB93aAlkLMB0YSs/E
	OVELFdfxKxWxWK2CKgiBYyXQXCmJjuclGwJXlbtGpmC5lgwCTl+vmIa4t4TjsjIhF4FisP0hlxT
	4Jn38=
X-Gm-Gg: AR+sD128Jb93V07m5lNKwOUnhuA2pjLDqcb/K9EG/t0x7jtCaiWWYKqXQpUYd0xdyNZ
	13hvcHpoVYJgFLda5qZoUwraDcRjRZtXvBuw8nEbK+F6wjqeXlonuWPTshWj6NBfgrICwQ/gosM
	oK/C6jRCkRYwCpwLWlgGGZ4VOXyqfMLPRKr9RWFwUSOqrpuUmUHUuMxq/JpdtOTIiHx0Jc2aceB
	B4iKDgu7ahMKnbPKgbfX9T2z1hLxARsymICFRFJJzFp2ypZrcNKfe/WguNoo+BX+NIOj7AbAbvE
	W+JIs5E4dvBZ0EmF6ENWE/zh2cZeaiRJgVhsg8Rjzb3dhHz73jubL9goigKo8hAcnd46RL6N9O4
	MHPPlG41PSAHcNZlq/Oo/7XT45lMnlA==
X-Received: by 2002:a05:6a21:6f0e:b0:3b4:6026:6c5d with SMTP id adf61e73a8af0-3cd2fe3c156mr325936637.5.1787248164725;
        Thu, 20 Aug 2026 10:49:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f0e:b0:3b4:6026:6c5d with SMTP id adf61e73a8af0-3cd2fe3c156mr325859637.5.1787248164295;
        Thu, 20 Aug 2026 10:49:24 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm18641072eec.25.2026.08.20.10.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:49:23 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/2] src: Modify MaxTxPower option documentation for ChannelSounding
Date: Thu, 20 Aug 2026 23:19:09 +0530
Message-Id: <20260820174910.559116-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820174910.559116-1-naga.akella@oss.qualcomm.com>
References: <20260820174910.559116-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tUCrZA4QDxmGB_Dza8EyugZmtjo2XAt8
X-Proofpoint-ORIG-GUID: tUCrZA4QDxmGB_Dza8EyugZmtjo2XAt8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzNCBTYWx0ZWRfX6zsuEkpq87qq
 jVK85bLD4neoGeaJe7ksM4vQ1ZslWRA99TM9FgmpgKmuBq+qzTxYkhs1CdUUKwi0J3hFQ9LqhL9
 cxOyG4wzo4yZhSZpqIXUxGQTpr+X4/CYNf7UJY9Uaa+z2rr8pvikNnoPp6jGId/mAvacgP3PLeb
 SPTVsJavUl7pCO8NVnCCtyy6Mlv72R54+HQXqzRsrMu/kJfYMTQC3hPjOy7Hp2ewxOyFPczps8p
 VB2d93DBZzoILMcktSIeuuBUOO6ojdY9baIr9S9PXfGJ7zKEk2eaYBD2kVwXn+mmVQZoybA7acH
 t8it69VMxSPA5P1JPm9tl/kAx2msh3EIj9soDVTlT3OUPQeQbYBzdPY5NOtelsaRLNRM4JL6g4t
 pwvO0SbhPT3VMv7s8KtzIftmelAq7a8rxhgxjGR1pMuPAnq9lf30x8DkHmlsCH18B9cW5EX1PF6
 EGHP2sGkhZsBGBw5T7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEzNCBTYWx0ZWRfX7o2sJcG1yV/p
 EeN34pUstZw6BvdqmBpH4gYFrbizhtELStQqOrWBRYlG/x2yKxTDCpQjNbIlZi3XzOXn8IU7cUc
 OTIFqpAZXlI/HeFUVUMWo+PFUYXxeWQ=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a873e25 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=k_sf-pNLc9bf9CdX6QcA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200134

Modify MaxTxPower configuration option to take decimal values
within the range of -127dBm to 20dBm
Defaults to 20 (max power).
---
 src/main.conf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/main.conf b/src/main.conf
index 5846ef92d..80f4a3a0c 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -319,9 +319,9 @@
 #CsSyncAntennaSel = 0xFF
 
 # Maximum Transmit power
-# Possible values: 0x81-0x14 (-127dBm to 20dBm)
-# Default: 0x14 (Max Power possible)
-#MaxTxPower = 0x14
+# Possible values: -127dBm to 20dBm
+# Default: 20 (Max Power possible)
+#MaxTxPower = 20
 
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
-- 

