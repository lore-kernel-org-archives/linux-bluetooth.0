Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC20C5235
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740767; cv=none; b=Lc27f8w8sWuXL6FRNtWB1MsGJBENnLveys9krAnh8vyzG8+zMu2iaxCTGbV/e2/YpPgrchbDmEnWXXidKmPKQT6SZD392j2RD6R9s99ro06EP101H89KtUz9hCeqn0vSaOG7XOFKpWqt7FXRH1EzVuypYPbFrMbobrRiElrI3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740767; c=relaxed/simple;
	bh=UjjsvC3z0eX617MBclzUnpgJnVTPds3yNMvRgC0DLiw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eTVTigklwmURemYo3Z2f3/UCxfsAfmaJx4kSTpEdzzwmeP5sglVxifYIcqaYQmFb1IgDAUtpPKDeD38P+OXt5Y7yxXcKqMVDNyvKXyTXvxkhbPReu1TTEGyXpi5r2ff8BtMT9kuhilow9jve6sudptBg3qfOhRlgLrI9WMbv4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2j/MP96; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2j/MP96"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d932f6ccfaso20654145ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 04:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707740765; x=1708345565; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FubBSRVCc6gGv7mERpAlg1vfOxwSLORh2cFZLL2LaYY=;
        b=d2j/MP96ZaR0f6HNKMZYVEYUPz+RNfcfmZiwJfqPUj/BaZRF4LSYM3f3XePQcRfmqt
         fp47OgpcyJzk67vZI92qomj1GJpNaBzLUbIoDGsFaLIWru8x60gdsdUKUA7m5vu4X8sc
         2FYZ2OaYNMsl4WoJdQy1Pa/8oThOUb/Ep0vqQsBl3J2/WQ0wUzBxwWYjb084x5IdrmMN
         VVSmt6H9uDiU9JqQ/pah+2HBYzWo34iPIGvxTGq34Ziq1ZsfYwhioYk5yhiZgM9m+dW7
         oRdNF6UotGq+4Q042MZh0+0JbZJAZMH7mqCh6i8vaggmVym07ee8ICoDyGePE58rfMBG
         WmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707740765; x=1708345565;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FubBSRVCc6gGv7mERpAlg1vfOxwSLORh2cFZLL2LaYY=;
        b=HlDqLlo9CaWnqCtpQ8c9lPlRWnWcQUkctjXUIWLDNxCpaST6haO3R3E9Fg6tCUbN9e
         9dHQlug2J+Ax6qcha89DvXTPwlHUu9VpA6zGKyzb2CyDBeWqq0kX0CTNhROhYW3LGkoO
         fnuY0yfW0Cs6eDZ0d8ZAKDNJFqhvD4QUmgYO4ppmjcx4Zy96hJWZcsX9MauDZYts//AV
         vkA1EzzctNlA5uZG/7EeAWyUo6OknlIBxD5iHrUB7z0E2igFAl5u9QUhVfaanOGJTgHO
         AefQGiLPfC6b2V5WCH+bL7+KJBIKZZ54DWbR0gSg9PecNpW0ctC4XPpIqZMyzh/ZK/Co
         psiA==
X-Gm-Message-State: AOJu0YwcAMiDKj2csg27/geHnOelG9Kgs4TBUwm1m9nF4jE1G8ZVe7u6
	U1gXXu0/ooohJPbuBJxEYg1c9n0nWrLfjr4ltrUEJE+obVqLgtSb9WhheP0G
X-Google-Smtp-Source: AGHT+IHnH9tIPRJ4zoX6owtCgZSIRUpHz7gQDLN6j1EaDGBWTyG2dUY80RD5sINAxyO1WX5EYb94rA==
X-Received: by 2002:a17:902:c402:b0:1da:2a50:cc0c with SMTP id k2-20020a170902c40200b001da2a50cc0cmr3485165plk.22.1707740764547;
        Mon, 12 Feb 2024 04:26:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVE3DHJg6ls/EneYwxM0cVkS8CDt8oih2j+DinLfU+aWjv30+n7j1eR+IU6zfnal6VwEBLVey/YkAKlblWWQdgYDC8=
Received: from [172.17.0.2] ([20.171.46.99])
        by smtp.gmail.com with ESMTPSA id jy12-20020a17090342cc00b001d9a41daf85sm254855plb.256.2024.02.12.04.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 04:26:04 -0800 (PST)
Message-ID: <65ca0e5c.170a0220.93972.09e6@mx.google.com>
Date: Mon, 12 Feb 2024 04:26:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8701980970935713415=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [BlueZ,1/3] lib/uuid: Add support to compare 16bit uuids
In-Reply-To: <20240212161726.3097145-1-ajay.k.v@intel.com>
References: <20240212161726.3097145-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8701980970935713415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825164

---Test result---

Test Summary:
CheckPatch                    FAIL      1.79 seconds
GitLint                       FAIL      0.89 seconds
BuildEll                      PASS      24.03 seconds
BluezMake                     PASS      687.75 seconds
MakeCheck                     PASS      12.21 seconds
MakeDistcheck                 PASS      162.46 seconds
CheckValgrind                 PASS      225.62 seconds
CheckSmatch                   PASS      331.69 seconds
bluezmakeextell               PASS      108.23 seconds
IncrementalBuild              PASS      1945.91 seconds
ScanBuild                     PASS      939.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/3] lib/uuid: Add support to compare 16bit uuids
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#90: FILE: lib/uuid.c:126:
+  if (!uuid1 || (uuid1->type != BT_UUID16))$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 4)
#90: FILE: lib/uuid.c:126:
+  if (!uuid1 || (uuid1->type != BT_UUID16))
+    return 0;

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#91: FILE: lib/uuid.c:127:
+    return 0;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#93: FILE: lib/uuid.c:129:
+  return (uuid1->value.u16 == uuid2);$

/github/workspace/src/src/13552944.patch total: 0 errors, 4 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13552944.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/3] shared/ccp: Add initial code for Call Control Profile for Client Role.
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#305: FILE: src/shared/ccp.c:202:
+      void *user_data, bt_ccp_destroy_func_t destroy)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#361: FILE: src/shared/ccp.c:258:
+      &uuid, BT_ATT_PERM_READ,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#362: FILE: src/shared/ccp.c:259:
+      BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#363: FILE: src/shared/ccp.c:260:
+      ccs_call_state_read, NULL, ccs);$

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#375: FILE: src/shared/ccp.c:272:
+	ccs->bearer_technology = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#385: FILE: src/shared/ccp.c:282:
+	ccs->bearer_uri_schemes_list = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#402: FILE: src/shared/ccp.c:299:
+	ccs->signal_reporting_intrvl = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#410: FILE: src/shared/ccp.c:307:
+	ccs->current_call_list = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#437: FILE: src/shared/ccp.c:334:
+	ccs->target_bearer_uri = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#454: FILE: src/shared/ccp.c:351:
+	ccs->call_ctrl_opt_opcode = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#456: FILE: src/shared/ccp.c:353:
+			BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP |

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#462: FILE: src/shared/ccp.c:359:
+	ccs->call_ctrl_opt_opcode = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#469: FILE: src/shared/ccp.c:366:
+	ccs->termination_reason = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#596: FILE: src/shared/ccp.c:493:
+static void ccp_cb_status_flag_notify(uint16_t value_handle, const uint8_t *value,

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#601: FILE: src/shared/ccp.c:498:
+  DBG(ccp, "");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#621: FILE: src/shared/ccp.c:518:
+  DBG(ccp, "");$

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#640: FILE: src/shared/ccp.c:537:
+static void ccp_cb_bearer_name_notify(uint16_t value_handle, const uint8_t *value,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#687: FILE: src/shared/ccp.c:584:
+static void ccp_cb_call_state_notify(uint16_t value_handle, const uint8_t *value,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#711: FILE: src/shared/ccp.c:608:
+static void ccp_cb_incom_call_notify(uint16_t value_handle, const uint8_t *value,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#731: FILE: src/shared/ccp.c:628:
+	if (!gatt_db_attribute_get_char_data(ccs->incoming_call, NULL, &value_handle,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#749: FILE: src/shared/ccp.c:646:
+	if (!gatt_db_attribute_get_char_data(ccs->call_state, NULL, &value_handle,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#767: FILE: src/shared/ccp.c:664:
+	if (!gatt_db_attribute_get_char_data(ccs->current_call_list, NULL, &value_handle,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#785: FILE: src/shared/ccp.c:682:
+	if (!gatt_db_attribute_get_char_data(ccs->bearer_name, NULL, &value_handle,

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#803: FILE: src/shared/ccp.c:700:
+	if (!gatt_db_attribute_get_char_data(ccs->termination_reason, NULL, &value_handle,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#821: FILE: src/shared/ccp.c:718:
+	if (!gatt_db_attribute_get_char_data(ccs->status_flag, NULL, &value_handle,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#839: FILE: src/shared/ccp.c:736:
+	if (!gatt_db_attribute_get_char_data(ccs->bearer_uci, NULL, &value_handle,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#857: FILE: src/shared/ccp.c:754:
+	if (!gatt_db_attribute_get_char_data(ccs->bearer_technology, NULL, &value_handle,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#874: FILE: src/shared/ccp.c:771:
+	if (!gatt_db_attribute_get_char_data(ccs->signal_strength, NULL, &value_handle,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#909: FILE: src/shared/ccp.c:806:
+	if (!gatt_db_attribute_get_char_data(ccs->target_bearer_uri, NULL, &value_handle,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#927: FILE: src/shared/ccp.c:824:
+	if (!gatt_db_attribute_get_char_data(ccs->call_ctrl_point, NULL, &value_handle,

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#943: FILE: src/shared/ccp.c:840:
+  DBG(ccp, "");$

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#945: FILE: src/shared/ccp.c:842:
+	if (!gatt_db_attribute_get_char_data(ccs->call_ctrl_opt_opcode, NULL, &value_handle,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#951: FILE: src/shared/ccp.c:848:
+	ccp->call_control_opt_opcode_id = bt_gatt_client_register_notify(ccp->client,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#963: FILE: src/shared/ccp.c:860:
+	if (!gatt_db_attribute_get_char_data(ccs->friendly_name, NULL, &value_handle,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#981: FILE: src/shared/ccp.c:878:
+	if (!gatt_db_attribute_get_char_data(ccs->signal_reporting_intrvl, NULL, &value_handle,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#987: FILE: src/shared/ccp.c:884:
+	ccp->signal_reporting_intrvl_id = bt_gatt_client_register_notify(ccp->client,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#999: FILE: src/shared/ccp.c:896:
+	if (!gatt_db_attribute_get_char_data(ccs->bearer_uri_schemes_list, NULL, &value_handle,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1005: FILE: src/shared/ccp.c:902:
+	ccp->bearer_uri_schemes_list_id = bt_gatt_client_register_notify(ccp->client,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1040: FILE: src/shared/ccp.c:937:
+		DBG(ccp, "Found Bearer Technology, handle 0x%04x", value_handle);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1110: FILE: src/shared/ccp.c:1007:
+		DBG(ccp, "Found Termination Reason, handle 0x%04x", value_handle);

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#1270: FILE: src/shared/ccp.h:14:
+#define __packed __attribute__((packed))

/github/workspace/src/src/13552946.patch total: 0 errors, 41 warnings, 1199 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13552946.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/3] lib/uuid: Add GTBS UUIDS for Call Control Profile.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,2/3] lib/uuid: Add GTBS UUIDS for Call Control Profile."
[BlueZ,3/3] shared/ccp: Add initial code for Call Control Profile for Client Role.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[BlueZ,3/3] shared/ccp: Add initial code for Call Control Profile for Client Role."
1: T3 Title has trailing punctuation (.): "[BlueZ,3/3] shared/ccp: Add initial code for Call Control Profile for Client Role."


---
Regards,
Linux Bluetooth


--===============8701980970935713415==--
