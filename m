Received: from aer-iport-8.cisco.com (aer-iport-8.cisco.com [173.38.203.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F434DCEB
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604067; cv=none; b=UoITVDVlxGhcxCxooWzNzQ+8Dz5rguQIF7Gdpnxc07o/E75iqaJAAh5vzFJ92ax6myVxLn1B5ufLVUI0SxX3+EiFrnz8iAcc5a6DjhWXvGL0Tt9zcVKYdnK9kJ/zmcac3+sEmuvT/OVfvE27HShzyiY/7EqYtZFle2fcp/34fIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604067; c=relaxed/simple;
	bh=5ZNvKaPqoNSlvQwC6ZGaOKojEpklL3EyUEbhsuKnEnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jl6XXecyzWROFh5ktWQzyExgC7GTHmOiFV+X+Qybz1zbRHyfYFos4YlT6yxGG9Pgu2wilMcXjcWGMVN5cgLOJ2xVwgX1vjSUHoB5u87qC97sdXfTe8ZTb0wq8TRysIZHUzWmrFZQk4IhR9mKP0tf1Bgm0KI3hcV29My5zb5/TXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=agz5BpVj; arc=none smtp.client-ip=173.38.203.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="agz5BpVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2271; q=dns/txt;
  s=iport01; t=1757604065; x=1758813665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E+R7vAn1Yh3z0o+84pLgU5l/3Mmp29jOs4qWtebyrrs=;
  b=agz5BpVjc+grohdrOOzeNaotSTh6+GtshfXVLyGUmZEbagAXhcyamtHu
   ev/Fub0b5f/0X6TnHtm2hPjp1/IUiqqh0uwgdfK+WJZ80bT6TfIcYT09K
   J+juAs6mn7TKRORd4MFpCczvtRksI5vLC3JM2wCzKQ2W4eM8IcuHIC/gG
   I0/ZL5DC5zXKTWO82gQtXnQGaQGsPTKoT9OpWl66jfXrKAiSRSFyFPLfK
   0RpfCo+4qit68yPE066o+Bm0SfxpuHmFXTFE/zcTOY4V60mxyMgR55wP3
   BBp9qtDkH9i0yoAuuunk6DjZrvM6vtOsVt9dgJAZBvM7CxmwzkSq3drzd
   w==;
X-CSE-ConnectionGUID: dl8CWur+QRq1hZBmN2GbBg==
X-CSE-MsgGUID: qLdY2nnaSxCjYerWj8up6A==
X-IPAS-Result: =?us-ascii?q?A0CQAgB458Jo/9NK/pBaHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?gQBAQsBgkZsaEO3Kg8BAQEPUQQBAYUHAowvAiY3Bg4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchlsCAQMyAUYQUVaDG4JzA7BqgiyBA?=
 =?us-ascii?q?YR82gGBKYFJAYEVjDdwhHcnG4INhA5vhRCFVSIEgg2BFxSEDoIoiXqLVEiBH?=
 =?us-ascii?q?gNZLAFVEw0KCwcFgWMDNQwLLhVuMh2BJxaEd4QdK0+FAoRqJGsPBoEVg1sGh?=
 =?us-ascii?q?HxAAwsYDUgRLDcUGwY+bgeYP2MYE8lahCahVxozqmuZBqRYhGmBfiaBWXAVg?=
 =?us-ascii?q?yNRGQ/MSERuAgcLAQEDCYI5kS4BAQ?=
IronPort-Data: A9a23:v8Iguqr3Io2MjZFWYJqCOUdYiRReBmJbZBIvgKrLsJaIsI4StFCzt
 garIBmEOvyKY2b3et50O4W0/EhUsJKBy9ZnTQBkqy5jFn4S8ePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9z8ljPvgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQ/NNwJcaDpOtvrS8Uo35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0upzUUpx6
 OZbEQoUNxCxreeQmp2xYOY506zPLOGzVG8eknht13TdSP0hW52GGv2M7t5D1zB2jcdLdRrcT
 5NFNXw1MUiGPEEJYA5OYH49tL/Aan3XayJRoV2SjaE2+GPUigd21dABNfKOI4XSH5QNwS50o
 Erf22jIWBccPeeP4ji0/2iThL/ShX3SDdd6+LqQs6QCbEeo7mgSDgAGEFG/vPSljUmiW/pBJ
 EEOvCkjt64/8AqsVNaVYvGjiHeJpFsYHtFXCeB/sVnLwavP6AHfDW8BJtJcVOEbWAYNbWRC/
 je0cxnBXFSDbJX9paqhy4qp
IronPort-HdrOrdr: A9a23:61y2q62EWxZM8jCdxnPsAAqjBLckLtp133Aq2lEZdPWaSKClfq
 eV7ZAmPHDP5gr5NEtLpTnEAtjifZq+z+8R3WByB9aftWDd0QPCEGgh1/qB/9SKIULDH4BmuJ
 uIC5IfNDU1ZmIK6/oTJ2KDYrEd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3AyNMcKWjOm/kf/o4u5vBvLkI/WjJufnmN50jNOQy?=
 =?us-ascii?q?BM38wSI+/THnK16lOnJ87?=
X-Talos-MUID: 9a23:smtljguAzuh4xd+am82nnRVuBZ1u5a2VGGsPoJgchMvUKDQuEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,257,1751241600"; 
   d="scan'208";a="31102907"
Received: from aer-l-core-10.cisco.com ([144.254.74.211])
  by aer-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Sep 2025 15:19:53 +0000
Received: from pwaago-l-systems.rd.cisco.com (unknown [10.47.92.97])
	by aer-l-core-10.cisco.com (Postfix) with ESMTP id 960E818000332;
	Thu, 11 Sep 2025 15:19:53 +0000 (GMT)
From: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
Subject: [PATCH BlueZ v2 2/2] doc: Document error codes for A2DP MediaEndpoints
Date: Thu, 11 Sep 2025 17:19:30 +0200
Message-ID: <20250911151930.1632922-2-pwaago@cisco.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911151930.1632922-1-pwaago@cisco.com>
References: <20250911151930.1632922-1-pwaago@cisco.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.92.97, [10.47.92.97]
X-Outbound-Node: aer-l-core-10.cisco.com

---
 doc/org.bluez.MediaEndpoint.rst | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index 474cc1160..bbe00b637 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -54,6 +54,43 @@ be configured and the properties must contain the following properties:
 
 	See **org.bluez.MediaTransport(5)** QoS property.
 
+Possible errors for A2DP endpoints:
+	:org.bluez.Error.A2DP.InvalidCodecType:
+	:org.bluez.Error.A2DP.NotSupportedCodecType:
+	:org.bluez.Error.A2DP.InvalidSamplingFrequency:
+	:org.bluez.Error.A2DP.NotSupportedSamplingFrequency:
+	:org.bluez.Error.A2DP.InvalidChannelMode:
+	:org.bluez.Error.A2DP.NotSupportedChannelMode:
+	:org.bluez.Error.A2DP.InvalidSubbands:
+	:org.bluez.Error.A2DP.NotSupportedSubbands:
+	:org.bluez.Error.A2DP.InvalidAllocationMethod:
+	:org.bluez.Error.A2DP.NotSupportedAllocationMethod:
+	:org.bluez.Error.A2DP.InvalidMinimumBitpoolValue:
+	:org.bluez.Error.A2DP.NotSupportedMinimumBitpoolValue:
+	:org.bluez.Error.A2DP.InvalidMaximumBitpoolValue:
+	:org.bluez.Error.A2DP.NotSupportedMaximumBitpoolValue:
+	:org.bluez.Error.A2DP.InvalidInvalidLayer:
+	:org.bluez.Error.A2DP.NotSupportedLayer:
+	:org.bluez.Error.A2DP.NotSupporterdCRC:
+	:org.bluez.Error.A2DP.NotSupporterdMPF:
+	:org.bluez.Error.A2DP.NotSupporterdVBR:
+	:org.bluez.Error.A2DP.InvalidBitRate:
+	:org.bluez.Error.A2DP.NotSupportedBitRate:
+	:org.bluez.Error.A2DP.InvalidObjectType:
+	:org.bluez.Error.A2DP.NotSupportedObjectType:
+	:org.bluez.Error.A2DP.InvalidChannels:
+	:org.bluez.Error.A2DP.NotSupportedChannels:
+	:org.bluez.Error.A2DP.InvalidVersion:
+	:org.bluez.Error.A2DP.NotSupportedVersion:
+	:org.bluez.Error.A2DP.NotSupportedMaximumSUL:
+	:org.bluez.Error.A2DP.InvalidBlockLength:
+	:org.bluez.Error.A2DP.InvalidCPType:
+	:org.bluez.Error.A2DP.InvalidCPFormat:
+	:org.bluez.Error.A2DP.InvalidCodecParameter:
+	:org.bluez.Error.A2DP.NotSupportedCodecParameter:
+	:org.bluez.Error.A2DP.InvalidDRC:
+	:org.bluez.Error.A2DP.NotSupportedDRC:
+
 array{byte} SelectConfiguration(array{byte} capabilities)
 `````````````````````````````````````````````````````````
 
-- 
2.43.0

