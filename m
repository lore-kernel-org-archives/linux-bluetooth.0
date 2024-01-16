Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1610A1A
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430226; cv=none; b=IrWKzeN7w+nULjDC6qt13Kfn1O3iLAYiauzONy6sKDnq4VgtTzMKCSJQL6Vgo7S+HOoH/0D78zOVhem2mECOs0/VIuzvI2ppPvWkxREYByOA5UHqrQzoJ03AYhXUA7ChZe7kK2idWs1WTs6o7MJwJtrVUqklIIZ3+qTloHEUwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430226; c=relaxed/simple;
	bh=Jl+GoRXRAaGsdZCPEcKW8jq40HXlBComlOtzf9rAiUQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References:Reply-To; b=pCL/bpu9vfQ7atlBqERdDddB0P7TLYt1NSeOMCiBWl03H4fdIw5Pv2JPJvm4MxhdervNiOO0q+htDXhoNXFuST9stePD8vGAP0wM8KVQMq/xKhqa6/eOawLddtPvwdFYyu7v20m4/ADMLZjhnbcty0qa8yd7JPl1zOWvTDGF+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty1LSJyS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty1LSJyS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso7399290b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 10:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705430224; x=1706035024; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wCN8k4tQGVKEBO9BxY+6b5i95M4Jb46a7xHyi/y8tis=;
        b=Ty1LSJyS9g0zq7Cbh1s9YBMqk96bshM3NNm6hXFl/xZX6EuyP10O3MVv64NHoXwT9n
         rrYg8a6QZQl8b0baSwaz3HXHQqPbArk/VQl0CPSzn5B38Uy/IHdhfENkDL+VKR/0w33r
         e8k/wL+V/6xeZrxwmpy37GK45uQe3T/o5P2GlJAvFMML4fq90rojcGaB8Uedi5OmwkiU
         tyMTpJUOt1cyR3XWV+rsRjreRSndxIB0QlgcIMNT0ffsNlrYLjGt8kEcH7NOGAUaPMfy
         4PUCjP8n+C9LhSVIGoNP8Ay728FZRHyIPL+E3QpiRLQjXg0rqTEfAAGWkQc9Gd3NZnbK
         KBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430224; x=1706035024;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCN8k4tQGVKEBO9BxY+6b5i95M4Jb46a7xHyi/y8tis=;
        b=VCd0L9BO9tdMttsfLsp2wRXjXneMNTnpgFbwWbiXrCfvssLT6dwd0NSNqMKGaqvDkP
         iYd+uF+fajBYH6vrd3BH/JLkUR3H/p1pl5wKMVl25EsPio3EujZBUKRakVugfSJYWZPj
         SpuVY5ZDy+12ZFGc32cjszdMod1Dn6YvADD421Ray5CbP0XcyMIZrW+5StB7Yc3/jmFm
         ZclMWH9ityXfMtR+56Vao4o4oFbeR1UMFPaAAPkCLQMM3iWWW+Z2pACOCaA0z3vGirD/
         k9kwcH2n6fb//tO0Nvp8V3Ah/6G/eRmFMavlzTNjAl1pFp53vo9IVDutfsUUKpeLD4Lz
         hQBA==
X-Gm-Message-State: AOJu0YyInFVL0LzgvirVygIhKDyrI0Qp2H3HQARITm3ScoZ3QxEoSU8n
	i+qm3iVc+p+YrcXwxZZvv4Uw8jnCMpQ=
X-Google-Smtp-Source: AGHT+IECOoY6qjRKhzlIchwHUBj4CWSWfuTZg8dH8bT3G4C/Fb6uxuQGMF/x7pZlntvZGa8ePXR0Tw==
X-Received: by 2002:a62:8146:0:b0:6d9:b320:94c9 with SMTP id t67-20020a628146000000b006d9b32094c9mr7610745pfd.33.1705430223930;
        Tue, 16 Jan 2024 10:37:03 -0800 (PST)
Received: from [172.17.0.2] ([52.159.142.199])
        by smtp.gmail.com with ESMTPSA id m11-20020a62f20b000000b006daa809584csm9466980pfh.182.2024.01.16.10.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:37:03 -0800 (PST)
Message-ID: <65a6cccf.620a0220.b4c64.fa5b@mx.google.com>
Date: Tue, 16 Jan 2024 10:37:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2572674714181276882=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+emil.l.velikov.gmail.com@kernel.org
Subject: RE: Constify all the things
In-Reply-To: <20240116-const-v1-1-17c87978f40b@gmail.com>
References: <20240116-const-v1-1-17c87978f40b@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2572674714181276882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817220

---Test result---

Test Summary:
CheckPatch                    FAIL      6.32 seconds
GitLint                       PASS      3.96 seconds
BuildEll                      PASS      23.78 seconds
BluezMake                     PASS      712.63 seconds
MakeCheck                     PASS      12.07 seconds
MakeDistcheck                 PASS      158.82 seconds
CheckValgrind                 PASS      219.94 seconds
CheckSmatch                   WARNING   325.30 seconds
bluezmakeextell               PASS      105.45 seconds
IncrementalBuild              PASS      13281.67 seconds
ScanBuild                     WARNING   928.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,01/20] src: const annotate the bluetooth plugin API
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#119: FILE: src/plugin.c:45:
+static gboolean add_plugin(void *handle, const struct bluetooth_plugin_desc *desc)

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#141: FILE: src/plugin.h:26:
+		const struct bluetooth_plugin_desc __bluetooth_builtin_ ## name = { \

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#150: FILE: src/plugin.h:35:
+		extern const struct bluetooth_plugin_desc bluetooth_plugin_desc \

/github/workspace/src/src/13520846.patch total: 0 errors, 3 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520846.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,02/20] monitor: const annotate util_ltv_debugger instances and API
WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#75: FILE: monitor/att.c:686:
+			const struct util_ltv_debugger *decoder, size_t decoder_len)

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#84: FILE: monitor/att.c:708:
+			const struct util_ltv_debugger *decoder, size_t decoder_len)

/github/workspace/src/src/13520847.patch total: 0 errors, 2 warnings, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520847.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,03/20] monitor: const annotate cmd/handler tables
WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#146: FILE: monitor/att.c:3160:
+static const struct bcast_audio_scan_cp_cmd *bcast_audio_scan_cp_get_cmd(uint8_t op)

/github/workspace/src/src/13520848.patch total: 0 errors, 1 warnings, 136 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520848.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,04/20] monitor: const annotate misc arrays
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#158: FILE: monitor/rfcomm.c:35:
+static const char *cr_str[] = {

/github/workspace/src/src/13520855.patch total: 0 errors, 1 warnings, 80 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520855.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,07/20] profiles: annotate immutable data as const
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#165: FILE: profiles/audio/sink.c:65:
+static const char *str_state[] = {

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#178: FILE: profiles/audio/source.c:64:
+static const char *str_state[] = {

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#191: FILE: profiles/audio/transport.c:58:
+static const char *str_state[] = {

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#218: FILE: profiles/audio/transport.c:1765:
+static const struct media_transport_ops *media_transport_find_ops(const char *uuid)

/github/workspace/src/src/13520849.patch total: 0 errors, 4 warnings, 185 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520849.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,11/20] gobex: const annotate RO arrays, use G_N_ELEMENTS
WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#102: FILE: gobex/gobex.c:1446:
+			gobex_debug = g_parse_debug_string(env, keys, G_N_ELEMENTS(keys));

/github/workspace/src/src/13520860.patch total: 0 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520860.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,13/20] lib: const annotate tupla instances and API
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#117: FILE: lib/sdp.c:190:
+static const char *string_lookup_uuid(const struct tupla *pt0, const uuid_t *uuid)

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#126: FILE: lib/sdp.c:212:
+static int uuid2str(const struct tupla *message, const uuid_t *uuid, char *str, size_t n)

/github/workspace/src/src/13520857.patch total: 0 errors, 2 warnings, 66 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520857.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,16/20] obexd: const obex_mime_type_driver instances and API
WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#301: FILE: obexd/src/mimetype.c:137:
+const struct obex_mime_type_driver *obex_mime_type_driver_find(const uint8_t *target,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#331: FILE: obexd/src/mimetype.c:186:
+void obex_mime_type_driver_unregister(const struct obex_mime_type_driver *driver)

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#347: FILE: obexd/src/mimetype.h:34:
+void obex_mime_type_driver_unregister(const struct obex_mime_type_driver *driver);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#348: FILE: obexd/src/mimetype.h:35:
+const struct obex_mime_type_driver *obex_mime_type_driver_find(const uint8_t *target,

/github/workspace/src/src/13520859.patch total: 0 errors, 4 warnings, 224 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520859.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,18/20] obexd: const obex_transport_driver instances and API
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#195: FILE: obexd/src/transport.c:70:
+void obex_transport_driver_unregister(const struct obex_transport_driver *driver)

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#211: FILE: obexd/src/transport.h:21:
+void obex_transport_driver_unregister(const struct obex_transport_driver *driver);

/github/workspace/src/src/13520863.patch total: 0 errors, 2 warnings, 108 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520863.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,19/20] obexd: const annotate misc immutable data
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#154: FILE: obexd/plugins/phonebook-ebook.c:58:
+static const char *attribute_mask[] = {

/github/workspace/src/src/13520864.patch total: 0 errors, 1 warnings, 80 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13520864.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.attrib/gatttool.c:235:23: warning: Variable length array is used.attrib/interactive.c: note: in included file (through /usr/include/readline/readline.h):attrib/interactive.c:174:27: warning: non-ANSI function declaration of function 'disconnect_io'attrib/interactive.c:299:23: warning: Variable length array is used.emulator/bthost.c:584:28: warning: Variable length array is used.emulator/bthost.c:741:28: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
obexd/src/obex.c:123:3: warning: Access to field 'close' results in a dereference of a null pointer (loaded from field 'driver')
                os->driver->close(os->object);
                ^~~~~~~~~~~~~~~~~
1 warning generated.profiles/health/hdp_util.c:1052:2: warning: Use of memory after it is freed
        conn_data->func(conn_data->data, gerr);
        ^~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2572674714181276882==--
