Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C00135417
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839477; cv=none; b=B2paQXgsBgQXhXq4K/tpN2BuvBPyImLBojlp/ab59AqjS0+r/s0Et39KHt1EGCyKXOiGpUcNMir5mYCGv1IavHOr0na0Pox4C/Aqqo/+EAOeMtaqvZJNd81mTzgpBogOjxSpxAc6RmrfoSw8sdnuZu2zag/MKAISqNNq+qkdIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839477; c=relaxed/simple;
	bh=ps9tvKvFJLIBIO8CgVJbN3BXGiGVoICtbGtw5diAeKs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QzxJGqu6PxYo5DtBQ/L+y6E8eP6UXMveFh1cDIwBLvTJSktta0EOGcSX5vuaDnCFtq2XGcIuMGnTldB9WolmrwwB83+wiMEkLQhrcGjSZmuGy2YEpFXwOuIsvXXVTzf39wrkYyXA29Mw5X307hebGUnR2VRfLWZ4Zt/IM3lMQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eYQeRgAN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eYQeRgAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709839474;
	bh=ps9tvKvFJLIBIO8CgVJbN3BXGiGVoICtbGtw5diAeKs=;
	h=From:To:Subject:Date:From;
	b=eYQeRgANUMO+/hJiLjCpJUZAFpHdPUoMTs4YDtpYPXh5RyCb+vLoNDMI/0uV1a5QV
	 TBmzSHxmrSCGwMV2QVcx53UjkcCH1+yJ5yabzXWkgcf2zXg7d0EzsA5fsEv0+IMiQl
	 QR6ubrKTph3oxDX0EqhjOJmzXNZ09GCXoXoJ7UOBkfW9UIJS6pCYqi8b8GcNzrb86X
	 PGTqZFtSLqDrY2VzoA0kC1DkWho5zRKrAf2k338PnAUY+pxemyu8Ppj9NUFxnzL65+
	 WaCVvGaX00ar3nl2jEiCV2pLUVAl3Jm+JKugf2iXDdC3JLXl5//0yHP8yb3QAqYuHO
	 1B/xfy8YVni1g==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC7323780B5F
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 19:24:33 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-tester: Fix eir name length related tests
Date: Thu,  7 Mar 2024 20:24:27 +0100
Message-Id: <20240307192427.1022124-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

According to Section 1.2 of Core Specification Supplement Part A the
complete or short name strings are defined as utf8s, which should not
include the trailing NULL for variable length array as defined in Core
Specification Vol1 Part E Section 2.9.3.

This patch remove the trailing NULL in expected packets, and update the
lengths accordingly, to be in sync with Kernel patch "Bluetooth: Fix eir
name length"
---
 tools/mgmt-tester.c | 66 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e85fbacda..884078905 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1839,14 +1839,13 @@ static const char set_adv_set_local_name_param[260] = { 'T', 'e', 's', 't', ' ',
 							'n', 'a', 'm', 'e' };
 
 static const uint8_t set_adv_scan_rsp_data_name_1[] = {
-	0x0c, /* Scan rsp data len */
-	0x0b, /* Local name data len */
+	0x0b, /* Scan rsp data len */
+	0x0a, /* Local name data len */
 	0x09, /* Complete name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
-	0x00, /* null */
 	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 static const struct generic_data set_adv_on_local_name_test_1 = {
@@ -1879,17 +1878,16 @@ static const struct setup_mgmt_cmd set_advertising_mgmt_cmd_arr[] = {
 };
 
 static const uint8_t set_adv_scan_rsp_data_name_and_appearance[] = {
-	0x10, /* scan rsp data len */
+	0x0f, /* scan rsp data len */
 	0x03, /* appearance data len */
 	0x19, /* eir_appearance */
 	0x54, 0x65, /* appearance value */
-	0x0b, /* local name data len */
+	0x0a, /* local name data len */
 	0x09, /* complete name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "test name" */
-	0x00, /* null */
 	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 
@@ -7852,8 +7850,8 @@ static const uint8_t add_advertising_param_name[] = {
 };
 
 static const uint8_t set_scan_rsp_data_name_fits_in_scrsp[] = {
-	0x0c, /* Scan rsp data len */
-	0x0b, /* Local name data len */
+	0x0b, /* Scan rsp data len */
+	0x0a, /* Local name data len */
 	0x09, /* Complete name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
 	/* padding */
@@ -7878,8 +7876,8 @@ static const struct generic_data add_advertising_name_fits_in_scrsp = {
 };
 
 static const uint8_t set_scan_rsp_data_shortened_name_fits[] = {
-	0x0d, /* Scan rsp data len */
-	0x0c, /* Local name data len */
+	0x0c, /* Scan rsp data len */
+	0x0b, /* Local name data len */
 	0x08, /* Short name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x31,
 	/* "Test name1" */
@@ -7905,8 +7903,8 @@ static const struct generic_data add_advertising_shortened_name_in_scrsp = {
 };
 
 static const uint8_t set_scan_rsp_data_short_name_fits[] = {
-	0x07, /* Scan rsp data len */
-	0x06, /* Local name data len */
+	0x06, /* Scan rsp data len */
+	0x05, /* Local name data len */
 	0x08, /* Short name */
 	0x54, 0x65, 0x73, 0x74,
 	/* "Test*/
@@ -7946,16 +7944,16 @@ static const uint8_t add_advertising_param_name_data_ok[] = {
 };
 
 static const uint8_t set_scan_rsp_data_param_name_data_ok[] = {
-	0x1e, /* Scan rsp data len */
+	0x1d, /* Scan rsp data len */
 	/* scan rsp data */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x0b, /* Local name data len */
+	0x0a, /* Local name data len */
 	0x09, /* Complete name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65,
 	/* "Test name" */
 	/* padding */
-	0x00,
+	0x00, 0x00,
 };
 
 static const struct generic_data add_advertising_name_data_ok = {
@@ -8050,19 +8048,19 @@ static const struct setup_mgmt_cmd add_advertising_mgmt_cmd_arr[] = {
 };
 
 static const uint8_t set_scan_rsp_data_name_data_appear[] = {
-	0x1e, /* Scan rsp data len */
+	0x1d, /* Scan rsp data len */
 	0x03, /* appearance len */
 	0x19, /* EIR_APPEARANCE */
 	0x54, 0x65, /* appearance value */
 	/* scan rsp data */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00,
-	0x0b, /* Local name data len */
+	0x0a, /* Local name data len */
 	0x09, /* Complete name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65,
 	/* "Test name" */
 	/* padding */
-	0x00,
+	0x00, 0x00,
 };
 
 static const struct generic_data add_advertising_name_data_appear = {
@@ -8976,11 +8974,11 @@ static const uint8_t set_ext_scan_rsp_data_name_fits_in_scrsp[] = {
 	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
-	0x0c, /* Scan rsp data len */
-	0x0b, /* Local name data len */
+	0x0b, /* Scan rsp data len */
+	0x0a, /* Local name data len */
 	0x09, /* Complete name */
 	/* "Test name" */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65,
 };
 
 static const struct generic_data add_ext_advertising_name_fits_in_scrsp = {
@@ -9003,11 +9001,11 @@ static const uint8_t set_ext_scan_rsp_data_shortened_name_fits[] = {
 	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
-	0x0d, /* Scan rsp data len */
-	0x0c, /* Local name data len */
+	0x0c, /* Scan rsp data len */
+	0x0b, /* Local name data len */
 	0x08, /* Short name */
 	/* "Test name1" */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x31, 0x00,
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x31,
 };
 
 static const struct generic_data add_ext_advertising_shortened_name_in_scrsp = {
@@ -9030,13 +9028,13 @@ static const uint8_t set_ext_scan_rsp_data_param_name_data_ok[] = {
 	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
-	0x1e, /* Scan rsp data len */
+	0x1d, /* Scan rsp data len */
 	/* scan rsp data */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x0b, /* Local name data len */
+	0x0a, /* Local name data len */
 	0x09, /* Complete name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65,
 	/* "Test name" */
 };
 
@@ -9073,16 +9071,16 @@ static const uint8_t set_ext_scan_rsp_data_name_data_appear[] = {
 	0x01,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
-	0x1e, /* Scan rsp data len */
+	0x1d, /* Scan rsp data len */
 	0x03, /* appearance len */
 	0x19, /* EIR_APPEARANCE */
 	0x54, 0x65, /* appearance value */
 	/* scan rsp data */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00,
-	0x0b, /* Local name data len */
+	0x0a, /* Local name data len */
 	0x09, /* Complete name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x00,
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65,
 	/* "Test name" */
 };
 
-- 
2.34.1

