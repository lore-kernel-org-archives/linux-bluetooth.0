Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C761F0E56
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033761; cv=none; b=sUyb6wEiJBogNm7GfzAnlTeS2OOmi29CJ4lwlct2p3YU08x5Ml4dyKfEexcca6Cbsb9NnRm0LAlwY8fDxD6obuTR01jHIuJHgPC8I1HIusTHJo73zipwWzKIfLdEhqwA8NCPY4wsR7ijqZ61NzogYUgy8vshiCLL+z3md2p+Kdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033761; c=relaxed/simple;
	bh=aYOuSqvFn5xgtcR7ebl2D9nj7OcdtL/o0jFULuhyp6E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DBHY1THCjrV7exH/sxGBOsyHNw9LPw0l0fgzINN+6IPtbrX6+K7tONhE00X4gSn+YqeoHkXeJcUG38I/cf9wNtcuxkz+6GKHnfzpEBhx9q7fzzh0IgAoZwovhOgl6AWhWpHN5Hx0zUwF5H0qAOdzu1pToGymbR0l4XeL+aUUpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/7wX2fm; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/7wX2fm"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5067f6b30adso3109939137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755033758; x=1755638558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q5bexxrR5yKt3SXMivalv426FEBzFeTXFUuEr5lwDc=;
        b=Q/7wX2fm/IifROvReD6PXgqxHzFe8+FHmJLSBA/JMf8FdJuijoddf21yat0riaVCZ6
         60D8O8hReheUM8MH2+XjU6hSgZ+8SfOP8XhFInEurbzPpteucVSD5NoUPZpavU5MXUj4
         mRN8l9itQOz3GT27q8+8NAgh+zKWYLwzyNMnL+92g3+0PSVtGKUMTE0Ms2anxb1JW1/h
         YHm9OB0UvbCaNhhvqxRyp7wXGR8/i8TBeGgOjDcPJES5u522duIEvqxBFuaEegBwKyXq
         UuYcu+4t3TrldwYTtqndUHeEi3iNV48nMhLs+rUdxziaKllP6OJchm97UUc3kZVZYX5e
         AGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755033758; x=1755638558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q5bexxrR5yKt3SXMivalv426FEBzFeTXFUuEr5lwDc=;
        b=YrEzyyHSigvEkJCjEkxqxDH16s7B3A+RWZWMHFHy8VKtNC47jS7CvpkOMIVLAnj8l0
         DaGOe0MRg7fBIbvwQnbEwjm2AjvTBLCqhhX+dgFHK+eBaL0J/z5w8vTdb2U8/DvQ2cek
         6JSvcUYFannEqaLOtdsQDbqXqyv95QSGhzwVgN53DlUyC3LEMP2q3HdFRb+pUCcJ1dlc
         ipq7st9+Q8k/R3OphjfSsBsGbuxMw5wYF10yD1iVPEqP/dG+i2hjE6FGyiU04PVxnS85
         yjdmOrBVcZ/z7Q4lG7tvT1YvP0Ijh7Uf/t+y3W6d7xSkCy0lbkfeTE3vmjIPiTXHNear
         V5sQ==
X-Gm-Message-State: AOJu0YwBuN9ipSMqhQJV96NYH58DjOJIx6ys3aUiUfimbqvAjQg340l3
	Ayi4BXJ7691P43Cdsee7payX9muhwwDa+Am8ms1YsHkDWxAPJxm8HMBmVfr1vMC4
X-Gm-Gg: ASbGncua4vP0Ye36/IVBAvxsgxfm0DhfVKR3bMyJ89TtcSd+xQEzpBpCLQpfApiA5AW
	h+PjEOmXdXV5PUsownbX2on5D+U4X7EXpJB31jVaKdWAUNLsvWxNR6bTkl527oBf/Yg2OJPjqRo
	HkFi4T0keor64SQDJn97b/AxwR3QFgDIIVSjpEeaiaoRakQp5qj9KZWITROOqQHez74FjJoRLQS
	zYKWpgLGuFx9EXQohqnTut9K+cSKYWmrfg2qTcaJFZXegcsgosBXl9wTaJIK5tTBnK++gOx/TFS
	+GnY5nTWGTkQdXG+prGhNIVDFlXtfIN1iMm+WAT7QNfG/W4ytA80Nh1lVebzD9vqnSIc16BBFKc
	KDdmSKGLpCb3+oHILgMlwXAyIyU0a+XahcTE+sxgB/m+cN3rpl8F3AY1l590WXFkw
X-Google-Smtp-Source: AGHT+IHE5WawJUsfcFH4JqnkoB9ckWmrdJ2nSGhzMhcasi05tN1KWYMbqgG4S2E/rpILLYSa32SnSQ==
X-Received: by 2002:a05:6102:3751:b0:4fc:12e1:c0af with SMTP id ada2fe7eead31-50e508ac1d4mr241072137.21.1755033757817;
        Tue, 12 Aug 2025 14:22:37 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e028f4849sm2565328241.16.2025.08.12.14.22.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:22:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] mgmt-tester: Fix tests failing due to missing LL Privacy
Date: Tue, 12 Aug 2025 17:22:27 -0400
Message-ID: <20250812212227.1541519-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

LL Privacy setting now depends on LE to be enabled first which was
causing the following tests to fail, so this removes LL Privacy from
the expected settings:

Add Ext Advertising - Success 22 (LE -> off, Remove)
Set Device ID - Power off and Power on
Set Device ID - SSP off and Power on
---
 tools/mgmt-tester.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index c066ad6c37b8..ac27b85dd4c8 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1509,7 +1509,6 @@ static const char set_ssp_invalid_param[] = { 0x02 };
 static const char set_ssp_garbage_param[] = { 0x01, 0x00 };
 static const char set_ssp_settings_param_1[] = { 0xc0, 0x00, 0x00, 0x00 };
 static const char set_ssp_settings_param_2[] = { 0xc1, 0x00, 0x00, 0x00 };
-static const char set_ssp_settings_param_3[] = { 0xc1, 0x00, 0x40, 0x00 };
 static const char set_ssp_on_write_ssp_mode_param[] = { 0x01 };
 
 static const struct generic_data set_ssp_on_success_test_1 = {
@@ -6078,8 +6077,8 @@ static const struct generic_data set_dev_id_power_off_on = {
 	.send_param = set_powered_on_param,
 	.send_len = sizeof(set_powered_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_ssp_settings_param_3,
-	.expect_len = sizeof(set_ssp_settings_param_3),
+	.expect_param = set_ssp_settings_param_2,
+	.expect_len = sizeof(set_ssp_settings_param_2),
 	.expect_settings_set = MGMT_SETTING_POWERED,
 	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
 	.expect_hci_param = write_eir_set_dev_id_success_1,
@@ -6095,8 +6094,8 @@ static const struct generic_data set_dev_id_ssp_off_on = {
 	.send_param = set_ssp_on_param,
 	.send_len = sizeof(set_ssp_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_ssp_settings_param_3,
-	.expect_len = sizeof(set_ssp_settings_param_3),
+	.expect_param = set_ssp_settings_param_2,
+	.expect_len = sizeof(set_ssp_settings_param_2),
 	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
 	.expect_hci_param = write_eir_set_dev_id_success_1,
 	.expect_hci_len = sizeof(write_eir_set_dev_id_success_1),
@@ -8599,15 +8598,13 @@ static const struct generic_data add_ext_advertising_success_17 = {
 	.expect_hci_len = sizeof(preset_connectable_off_ext_adv_param),
 };
 
-static const char set_le_settings_param_off_1[] = { 0x81, 0x00, 0x40, 0x00 };
-
 static const struct generic_data add_ext_advertising_le_off = {
 	.send_opcode = MGMT_OP_SET_LE,
 	.send_param = set_le_off_param,
 	.send_len = sizeof(set_le_off_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_le_settings_param_off_1,
-	.expect_len = sizeof(set_le_settings_param_off_1),
+	.expect_param = set_le_settings_param_off,
+	.expect_len = sizeof(set_le_settings_param_off),
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
 	.expect_alt_ev_param = advertising_instance1_param,
 	.expect_alt_ev_len = sizeof(advertising_instance1_param),
-- 
2.50.1

