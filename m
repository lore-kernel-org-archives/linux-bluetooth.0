Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA25FEF1
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847280; cv=none; b=JwwN+rMdMCAMSASHfegLiTGxZuTLxojauP9Gwrkn5gbDhAwpmeGhcV0fag7cMCZf5np17RbvEmrcQLEc9+nWqi4gO341uXaygxqzkrw1CBTVQlCDHUrVRHclzyY27WhbDtHlBBEVGCAbQ2NSCu6z6bVv/OXnFMS1IqixAzYjwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847280; c=relaxed/simple;
	bh=gWWsi6pIR2Ppv7LaCU3nMmBFtP32T7wxeVGwD8PbcsA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hgTYiwZAGkvU7HE5ieKInhUYaihPZTw5hSPmQ3jIE8JMU8i78Vl9WyvYwlS3c6cqLh/416NXvFvPWnxp7r3yyevb2qY7Dy2wH0UP1YO9+dX+tJYntmVjPpPDIiT6Amajcp1ZACszNP+U6iq6avB9P648p+n6PpEbIvIvAj5dRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M39gnl5f; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M39gnl5f"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c4fb9e7ccso21125756d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 10:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707847277; x=1708452077; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NGQEtbSBvroxqC5TxF6GKWp/UPb3a7pIsHwSY7IKjs0=;
        b=M39gnl5fL+6KKTZSkAe7DBOqIVCFBiSZXTKNNnWLGT3+OhMxt73fy+2weRfVvFDOg6
         hroQv+LRo6Py4kL9Y5MoMDigc9794Uv9kUZnw/Hx/jvg4w7p5q7O2uGBrvFStWb0P44m
         aO67TPcUceFL9YZ0wQkG+n8PN/1YqiowTpjKoQBAM7QxNiWOHUcyAqIwRxJDEHRhg5Fy
         9GjqOj4FGCZG2Wn8/uYvFdGCVmFJ6gIxsIedv04LoY6wfoVdkG3j9f2hdMtOngXw5uU8
         jxmWB0memkRADvpsH8drVPDVWOKb3kh3RlV03P0SPjfueQQvr4d23gLpKKue3ttNF+Nn
         dbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847277; x=1708452077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGQEtbSBvroxqC5TxF6GKWp/UPb3a7pIsHwSY7IKjs0=;
        b=wh0O80UP3s63dY/9lAxBWqfgBGhYHeNWt0dTKTnqKkc7DMSkWRmW9hGdLQtt0NqLgn
         oROGu8dncUTAF4Bwz+mfxr8BJzK35V4/YJLRfdKS+MLcGTzF6PYphw14yJGvdg/01yRx
         lbEOQBYHmZ4NtkKrEgcXZusV+WZcMPfB6oJ4iVJikFgJTw6o6whiJ8UzQPlPVnp0MKSO
         cRgLBQSuDFEb1+5ryofLY5FfBRIWs8fvQjfy1RSkyhmzR8GuXaX4kvbZAnY71lvMcVWe
         KAnKo8fN5kwERZeJo8J2hOj5jKhYVz5xEsDcvm1idv29twapN/rdQBK/zCBRAk5NSgCt
         PCLA==
X-Gm-Message-State: AOJu0YyVBeDQpr6/rtwj1kS5vxGsKIUPRp8NtttbKcriU9coTyzKAROV
	JkMztUY27yCCQKMQl4HiyxS8Ca2eOjE6V2pPyfOCdd23Pw9snbdyWqpm/aLJ
X-Google-Smtp-Source: AGHT+IFqXi95c07lVHdQSI3CJeSVJFgK4cNMlflGz7w6WMst27Kqhi088nmxi21er+4870Ar5cR3+w==
X-Received: by 2002:a05:6214:224c:b0:68e:fa34:d040 with SMTP id c12-20020a056214224c00b0068efa34d040mr296070qvc.3.1707847277378;
        Tue, 13 Feb 2024 10:01:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUf5DVPpveB4+2w8k4vh0Cm7nsS+cput6Kf+daltDsPy1bMEwZmXon8lzqfkDygr14hFFSg8WJh9oIDKZJM3jHGDY0=
Received: from [172.17.0.2] ([74.249.14.221])
        by smtp.gmail.com with ESMTPSA id l2-20020ad44242000000b0068c7942d999sm1460553qvq.126.2024.02.13.10.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:01:16 -0800 (PST)
Message-ID: <65cbae6c.d40a0220.ff90.94f4@mx.google.com>
Date: Tue, 13 Feb 2024 10:01:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6864063790124684521=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [BlueZ,1/3] lib/uuid: Add support to compare 16bit uuids
In-Reply-To: <20240213215703.21507-1-ajay.k.v@intel.com>
References: <20240213215703.21507-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6864063790124684521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825717

---Test result---

Test Summary:
CheckPatch                    FAIL      2.27 seconds
GitLint                       FAIL      1.22 seconds
BuildEll                      PASS      24.79 seconds
BluezMake                     PASS      758.67 seconds
MakeCheck                     PASS      12.29 seconds
MakeDistcheck                 PASS      166.57 seconds
CheckValgrind                 PASS      229.92 seconds
CheckSmatch                   PASS      332.05 seconds
bluezmakeextell               PASS      108.19 seconds
IncrementalBuild              PASS      2154.56 seconds
ScanBuild                     WARNING   1005.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/3] lib/uuid: Add support to compare 16bit uuids
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#89: FILE: lib/uuid.c:126:
+  if (!uuid1 || (uuid1->type != BT_UUID16))$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 4)
#89: FILE: lib/uuid.c:126:
+  if (!uuid1 || (uuid1->type != BT_UUID16))
+    return 0;

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#90: FILE: lib/uuid.c:127:
+    return 0;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#92: FILE: lib/uuid.c:129:
+  return (uuid1->value.u16 == uuid2);$

/github/workspace/src/src/13555344.patch total: 0 errors, 4 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13555344.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/3] shared/ccp: Add initial code for Call Control Profile for Client Role.
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#304: FILE: src/shared/ccp.c:202:
+      void *user_data, bt_ccp_destroy_func_t destroy)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#360: FILE: src/shared/ccp.c:258:
+      &uuid, BT_ATT_PERM_READ,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#361: FILE: src/shared/ccp.c:259:
+      BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_NOTIFY,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#362: FILE: src/shared/ccp.c:260:
+      ccs_call_state_read, NULL, ccs);$

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#374: FILE: src/shared/ccp.c:272:
+	ccs->bearer_technology = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#384: FILE: src/shared/ccp.c:282:
+	ccs->bearer_uri_schemes_list = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#401: FILE: src/shared/ccp.c:299:
+	ccs->signal_reporting_intrvl = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#409: FILE: src/shared/ccp.c:307:
+	ccs->current_call_list = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#436: FILE: src/shared/ccp.c:334:
+	ccs->target_bearer_uri = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#453: FILE: src/shared/ccp.c:351:
+	ccs->call_ctrl_opt_opcode = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#455: FILE: src/shared/ccp.c:353:
+			BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP |

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#461: FILE: src/shared/ccp.c:359:
+	ccs->call_ctrl_opt_opcode = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#468: FILE: src/shared/ccp.c:366:
+	ccs->termination_reason = gatt_db_service_add_characteristic(ccs->service,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#595: FILE: src/shared/ccp.c:493:
+static void ccp_cb_status_flag_notify(uint16_t value_handle, const uint8_t *value,

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#600: FILE: src/shared/ccp.c:498:
+  DBG(ccp, "");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#620: FILE: src/shared/ccp.c:518:
+  DBG(ccp, "");$

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#639: FILE: src/shared/ccp.c:537:
+static void ccp_cb_bearer_name_notify(uint16_t value_handle, const uint8_t *value,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#686: FILE: src/shared/ccp.c:584:
+static void ccp_cb_call_state_notify(uint16_t value_handle, const uint8_t *value,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#710: FILE: src/shared/ccp.c:608:
+static void ccp_cb_incom_call_notify(uint16_t value_handle, const uint8_t *value,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#730: FILE: src/shared/ccp.c:628:
+	if (!gatt_db_attribute_get_char_data(ccs->incoming_call, NULL, &value_handle,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#748: FILE: src/shared/ccp.c:646:
+	if (!gatt_db_attribute_get_char_data(ccs->call_state, NULL, &value_handle,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#766: FILE: src/shared/ccp.c:664:
+	if (!gatt_db_attribute_get_char_data(ccs->current_call_list, NULL, &value_handle,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#784: FILE: src/shared/ccp.c:682:
+	if (!gatt_db_attribute_get_char_data(ccs->bearer_name, NULL, &value_handle,

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#802: FILE: src/shared/ccp.c:700:
+	if (!gatt_db_attribute_get_char_data(ccs->termination_reason, NULL, &value_handle,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#820: FILE: src/shared/ccp.c:718:
+	if (!gatt_db_attribute_get_char_data(ccs->status_flag, NULL, &value_handle,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#838: FILE: src/shared/ccp.c:736:
+	if (!gatt_db_attribute_get_char_data(ccs->bearer_uci, NULL, &value_handle,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#856: FILE: src/shared/ccp.c:754:
+	if (!gatt_db_attribute_get_char_data(ccs->bearer_technology, NULL, &value_handle,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#873: FILE: src/shared/ccp.c:771:
+	if (!gatt_db_attribute_get_char_data(ccs->signal_strength, NULL, &value_handle,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#908: FILE: src/shared/ccp.c:806:
+	if (!gatt_db_attribute_get_char_data(ccs->target_bearer_uri, NULL, &value_handle,

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#926: FILE: src/shared/ccp.c:824:
+	if (!gatt_db_attribute_get_char_data(ccs->call_ctrl_point, NULL, &value_handle,

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#942: FILE: src/shared/ccp.c:840:
+  DBG(ccp, "");$

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#944: FILE: src/shared/ccp.c:842:
+	if (!gatt_db_attribute_get_char_data(ccs->call_ctrl_opt_opcode, NULL, &value_handle,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#950: FILE: src/shared/ccp.c:848:
+	ccp->call_control_opt_opcode_id = bt_gatt_client_register_notify(ccp->client,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#962: FILE: src/shared/ccp.c:860:
+	if (!gatt_db_attribute_get_char_data(ccs->friendly_name, NULL, &value_handle,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#980: FILE: src/shared/ccp.c:878:
+	if (!gatt_db_attribute_get_char_data(ccs->signal_reporting_intrvl, NULL, &value_handle,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#986: FILE: src/shared/ccp.c:884:
+	ccp->signal_reporting_intrvl_id = bt_gatt_client_register_notify(ccp->client,

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#998: FILE: src/shared/ccp.c:896:
+	if (!gatt_db_attribute_get_char_data(ccs->bearer_uri_schemes_list, NULL, &value_handle,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#1004: FILE: src/shared/ccp.c:902:
+	ccp->bearer_uri_schemes_list_id = bt_gatt_client_register_notify(ccp->client,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1039: FILE: src/shared/ccp.c:937:
+		DBG(ccp, "Found Bearer Technology, handle 0x%04x", value_handle);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1109: FILE: src/shared/ccp.c:1007:
+		DBG(ccp, "Found Termination Reason, handle 0x%04x", value_handle);

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#1269: FILE: src/shared/ccp.h:14:
+#define __packed __attribute__((packed))

/github/workspace/src/src/13555346.patch total: 0 errors, 41 warnings, 1199 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13555346.patch has style problems, please review.

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
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
Makefile:13696: warning: overriding recipe for target 'install-data-hook'
Makefile:13691: warning: ignoring old recipe for target 'install-data-hook'
Makefile:13696: warning: overriding recipe for target 'install-data-hook'
Makefile:13691: warning: ignoring old recipe for target 'install-data-hook'
src/shared/gatt-client.c:451:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:696:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:993:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1099:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1291:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1356:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1631:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1636:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2140:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2148:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3237:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3259:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============6864063790124684521==--
