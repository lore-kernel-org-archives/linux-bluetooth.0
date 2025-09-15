Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85ED2C0F72
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923028; cv=none; b=fwz112wQgTftC1FrLBU62EN4TUb0aoBGSkM29vcZO2AAVmKi3rofXLN1fP9e+qr6yMy8KFw9hCDG5LW8s6WhYdw/Tg+92g6C1xE25ZLwu5FqRq2J34iBizrALWJcLhtmUk25QaThtgcFl+yy4xyBLuQNfcdvf3u2hoOIa3yB/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923028; c=relaxed/simple;
	bh=J/KvBoZ/IoA/chDeQUSop4dSo5XqDgw0zVxhEeCYC7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbOSfPFdYiaO9zsQockxryb7UeP3h5Lx7CBdX1ztqPs6mkx/a47ehw1Rkb4LSq6mnuZ5ftNu9BYsQ98bLYQbl2SCUEjtrspAU42RBoUetLG2b5CeNarGwTMyqZc+tHfC65zj8Wruk6nYpoME1p4k2cT0hQ69IWqPihgohD3auv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=c31nIE81; arc=none smtp.client-ip=173.38.203.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="c31nIE81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2850; q=dns/txt;
  s=iport01; t=1757923026; x=1759132626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yvX/FtzwgmmjmdPHxakj6YRkticu7sQgIvyBJqPBVOc=;
  b=c31nIE81P0e694yUJJT4d3ui/xZrdtnoPRBZpkrqejPgBvqDWD+IhMft
   ReMP4zfMXbgwMC//l7Uza0zhPjFrO1nDkWTdZ/EEQh6lkGENqHQwsrVYw
   6mZVymUf5pEmpRMMkxGYSo1fm3jMyFePtj0ARu6xHm7+gBs9HPVd6SXtn
   xRbp1jzhJjbH2TmQ5keBePKk+GgOnj/E21pc6InP6gAfKt7Nby57UXKii
   W8+C1hMDhhSARlDDcwoPiJKHRbfG6VyZaF5EyP0wrtSEOTaEBMlKgcrFL
   YuR0adHpKLJqNWO2RkHam7gGExehQ+CrimzSIkYdxyYkhQH6tu4Z87viF
   A==;
X-CSE-ConnectionGUID: Sp8gfbicTV21p3ixfub/ow==
X-CSE-MsgGUID: ix21xhdLSYSmjtK6LlBPGg==
X-IPAS-Result: =?us-ascii?q?A0BqAADgxcdo/9BK/pBaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkZsaEONOadygX8PAQEBD1EEAQGFB4wxAiY0CQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4Zchl02AUaEUoJzA7AsgiyBAYR82?=
 =?us-ascii?q?gGBKYFJAY1McIR3JxuCDYJQgT5vhRCFdwSDOJAwi1ZIgR4DWSwBVRMNCgsHB?=
 =?us-ascii?q?YFjAzUMCy4VbjIdgSeFDIQdK0+FAoRrJGsPBoEVg1sGhQFAAwsYDUgRLDcUG?=
 =?us-ascii?q?wY+bgeYQnsUyVmEJqFXGjOqa5kGpFiEaYFoPIFZcBWDI1EZD8tfRG4CBwsBA?=
 =?us-ascii?q?QMJgjmRLgEB?=
IronPort-Data: A9a23:F2VGQKDQfh8vQhVW/2riw5YqxClBgxIJ4kV8jS/XYbTApD0m0WMBn
 TAbXDrSb6yDYzHzc4twYY+z/UJUvpKHyIAxOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZuCCaF/H9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gU2thh
 fuo+5eCYA78h2YvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE+O0+A088PIYkxLwuGTpP5
 fIFIncKcUXW7w626OrTpuhEj8k5ac2uN4QFtzQ4knfSDO0tRtbIRKCiCd1whWtswJoTQbCBO
 4xDMWoHgBfoO3WjPn8PF5s3k+CAjXjkeDoeo1WQzUYyyzOKlVwpiui8WDbTUt2aH5xFnkq8n
 VP9+mblIU8+MPan5jXQpxpAgceKx0sXQrk6ELy+6+4vilmOy3AUDwEWfUW0rOP/iUOkXd9bb
 UsO9UITQbMa/UGxC924VBqirTvc4VgXWsFbFKsx7wTlJrfo3jt1z1MsFlZpAOHKfudvLdD2/
 jdlR+/UOAE=
IronPort-HdrOrdr: A9a23:tI9+E6wwJ4oFRFQfLXMaKrPwJb1zdoMgy1knxilNoNJuHvBw8P
 re/sjzuiWbtN98YhsdcLO7Scq9qBHnlKKdiLN5VdyftWLd11dAQrsO0WKb+V3d8+mUzJ846U
 +mGJIObeHNMQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AFATXgmvs3pzJagzDxTGYZg2l6Iseai3Swn3RKHO?=
 =?us-ascii?q?GUz9xE7yFR0Kav6R7xp8=3D?=
X-Talos-MUID: 9a23:lToTmwUJ95Blvovq/D783mhyNMtM2JWVDUIRsssiv+O8GiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,265,1751241600"; 
   d="scan'208";a="31180289"
Received: from aer-l-core-07.cisco.com ([144.254.74.208])
  by aer-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Sep 2025 07:55:55 +0000
Received: from pwaago-l-systems.rd.cisco.com (unknown [10.47.92.97])
	by aer-l-core-07.cisco.com (Postfix) with ESMTP id 46E3318000224;
	Mon, 15 Sep 2025 07:55:55 +0000 (GMT)
From: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
Subject: [PATCH BlueZ] audio: Fix typos in A2DP error messages
Date: Mon, 15 Sep 2025 09:55:53 +0200
Message-ID: <20250915075553.1636970-1-pwaago@cisco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.92.97, [10.47.92.97]
X-Outbound-Node: aer-l-core-07.cisco.com

---
 doc/org.bluez.MediaEndpoint.rst | 8 ++++----
 profiles/audio/a2dp.c           | 8 ++++----
 profiles/audio/a2dp.h           | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index bbe00b637..c1ce1d562 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -69,11 +69,11 @@ Possible errors for A2DP endpoints:
 	:org.bluez.Error.A2DP.NotSupportedMinimumBitpoolValue:
 	:org.bluez.Error.A2DP.InvalidMaximumBitpoolValue:
 	:org.bluez.Error.A2DP.NotSupportedMaximumBitpoolValue:
-	:org.bluez.Error.A2DP.InvalidInvalidLayer:
+	:org.bluez.Error.A2DP.InvalidLayer:
 	:org.bluez.Error.A2DP.NotSupportedLayer:
-	:org.bluez.Error.A2DP.NotSupporterdCRC:
-	:org.bluez.Error.A2DP.NotSupporterdMPF:
-	:org.bluez.Error.A2DP.NotSupporterdVBR:
+	:org.bluez.Error.A2DP.NotSupportedCRC:
+	:org.bluez.Error.A2DP.NotSupportedMPF:
+	:org.bluez.Error.A2DP.NotSupportedVBR:
 	:org.bluez.Error.A2DP.InvalidBitRate:
 	:org.bluez.Error.A2DP.NotSupportedBitRate:
 	:org.bluez.Error.A2DP.InvalidObjectType:
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 661843a89..6661a95d2 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -183,11 +183,11 @@ static struct a2dp_error config_errors[] = {
 	{"InvalidMaximumBitpoolValue", A2DP_INVALID_MAXIMUM_BITPOOL_VALUE},
 	{"NotSupportedMaximumBitpoolValue",
 				A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VALUE},
-	{"InvalidInvalidLayer", A2DP_INVALID_INVALID_LAYER},
+	{"InvalidLayer", A2DP_INVALID_LAYER},
 	{"NotSupportedLayer", A2DP_NOT_SUPPORTED_LAYER},
-	{"NotSupporterdCRC", A2DP_NOT_SUPPORTERD_CRC},
-	{"NotSupporterdMPF", A2DP_NOT_SUPPORTERD_MPF},
-	{"NotSupporterdVBR", A2DP_NOT_SUPPORTERD_VBR},
+	{"NotSupportedCRC", A2DP_NOT_SUPPORTED_CRC},
+	{"NotSupportedMPF", A2DP_NOT_SUPPORTED_MPF},
+	{"NotSupportedVBR", A2DP_NOT_SUPPORTED_VBR},
 	{"InvalidBitRate", A2DP_INVALID_BIT_RATE},
 	{"NotSupportedBitRate", A2DP_NOT_SUPPORTED_BIT_RATE},
 	{"InvalidObjectType", A2DP_INVALID_OBJECT_TYPE},
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index bcdb4d43f..e742b5dfc 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -102,11 +102,11 @@ enum a2dp_error_codes {
 	A2DP_NOT_SUPPORTED_MINIMUM_BITPOOL_VALUE = 0xcc,
 	A2DP_INVALID_MAXIMUM_BITPOOL_VALUE = 0xcd,
 	A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VALUE = 0xce,
-	A2DP_INVALID_INVALID_LAYER = 0xcf,
+	A2DP_INVALID_LAYER = 0xcf,
 	A2DP_NOT_SUPPORTED_LAYER = 0xd0,
-	A2DP_NOT_SUPPORTERD_CRC = 0xd1,
-	A2DP_NOT_SUPPORTERD_MPF = 0xd2,
-	A2DP_NOT_SUPPORTERD_VBR = 0xd3,
+	A2DP_NOT_SUPPORTED_CRC = 0xd1,
+	A2DP_NOT_SUPPORTED_MPF = 0xd2,
+	A2DP_NOT_SUPPORTED_VBR = 0xd3,
 	A2DP_INVALID_BIT_RATE = 0xd4,
 	A2DP_NOT_SUPPORTED_BIT_RATE = 0xd5,
 	A2DP_INVALID_OBJECT_TYPE = 0xd6,
-- 
2.43.0

