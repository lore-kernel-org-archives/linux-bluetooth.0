Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02705657A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536333; cv=none; b=lTnpkGPidG7ZUPDkSRIUYZSSvolIMCTn9yzwDr/2C4eVbjzhzkEBKuCaLFqoi07LyhxW8Vp7xPdKvAfL0x7zzrdxolSwxQ1HOr1jpJvkUbpiPbddmgmIn8R8RlBSRcFAveMebzwG9J82q/csmrHsduawydWUb1AlyMpIjg2ndns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536333; c=relaxed/simple;
	bh=+r+2wCAaCbYmLcroPEx+PN3LKRgRB2KPrFFzPwSUZdc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dwQBXXPnEDTX6qwQ7apBxEcZ0Mh/Onbnw1qYOSGUwCk1L3PwGJ6alg+TS+rFy2NAZkMfKdPfQzDtnwbJw0Tr5Qkq2gV4ezuqJ789g6X5xd2v6IuxemzOs+fWkVV7H1EnB+ll7n6kdPqCp/FqqKChbY1jpB6dFnd5erfZgY1RPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoHIRF3j; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoHIRF3j"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6de3141f041so271530b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706536331; x=1707141131; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vhavjwUUZeKheqtI1lGOlglLj81HzcCY0Ll9WjICXro=;
        b=aoHIRF3j5irp6T595wUFaI8RPal9FpumtoGtFqqP7ak2AYYqjcaXJnR7Ty2HiIHYY5
         fgwS9ufXuEjK1LeIlBCqcLsSlb0uz81ydvPanYMGkJjy0o9Yq0I4VSHWurdWkf85w8l5
         Q2OEriPJDn+NA+QK4eSBAcSpKULEAFtq82UJzgYbLaNoSOSc9m6S4vl0D+38evTN1btS
         xDYE3gQWznU9SPAwMGUbxCAhiNBiXVHYdcOoEHndJUR5cnjCIr9rjj3VyOqQPuWEn9a1
         Yz6yRgmD6agZ4mpYY+TqMTE+1XLZ2c+++cT6gtZDHpTZQz16GkCT/YIP9iAZShNu0LIk
         JqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536331; x=1707141131;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhavjwUUZeKheqtI1lGOlglLj81HzcCY0Ll9WjICXro=;
        b=Hp6XJc40IOmzJ7ytDB9vwnP7QGd8fy8zc3NV87SPYLWQm0F1EV2xUwMHOIbrka28KJ
         +yRdTUdlNybdK4GDF+WRT0yNzWCynXIYRHIC3ptcM40g0P75FsluwZAOepzS8fbEWW0o
         dWLWG8/kyCUQOLEwtxL5o48dzmV4h2t8AsiIPevSDCm+3trbxrtiCLtlk5yxtTc/sH9S
         gPH/V5ukTt6joenYePIZ2OQevKloE0UZMIsJKdvk8UtqnUAWHhoMIokSBqnjitTifYDc
         ZKjJUza7SqGdCVCnIcnoCuv8A3cdBKs9HOb7cmx2aXaWgnZc5Gh+bcXR5wlWi1Us0Lmu
         RVrA==
X-Gm-Message-State: AOJu0Ywhfg9pmkB3M582tnTd5ccbSV/7TUrcpPzCp7X/4TaO09YKNULH
	Upsxq8uwSkef3kfRs2YGkmnN2x9mYMz1J2+Fr5JKhBPwIdE/FZ4mm6XBBSb7
X-Google-Smtp-Source: AGHT+IGkE+uLdbBp5AzYqytMf7Ax6pS4acGoYCRt20nobjvVH9MZlATw0I4nfnO/ST9SVf8aICsuVA==
X-Received: by 2002:a05:6a20:9398:b0:19c:999e:b7a5 with SMTP id x24-20020a056a20939800b0019c999eb7a5mr2775669pzh.53.1706536330934;
        Mon, 29 Jan 2024 05:52:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwmrk+wwABAXetxNeJDUVWPmEJ1d5yX0Cuyo8ZwSlAbTN1xkcmew6fX7W4NEp0164k6KukmVHG/Ab0qP8aCw==
Received: from [172.17.0.2] ([13.91.68.150])
        by smtp.gmail.com with ESMTPSA id jg17-20020a17090326d100b001d8fae3220fsm460194plb.73.2024.01.29.05.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:52:10 -0800 (PST)
Message-ID: <65b7ad8a.170a0220.b2d1e.1879@mx.google.com>
Date: Mon, 29 Jan 2024 05:52:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8025712488578948681=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Adjust tests for sequential conn establishing
In-Reply-To: <20240129114900.92919-2-verdre@v0yd.nl>
References: <20240129114900.92919-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8025712488578948681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=820846

---Test result---

Test Summary:
CheckPatch                    FAIL      1.60 seconds
GitLint                       FAIL      1.10 seconds
BuildEll                      PASS      23.92 seconds
BluezMake                     PASS      715.16 seconds
MakeCheck                     PASS      11.73 seconds
MakeDistcheck                 PASS      163.35 seconds
CheckValgrind                 PASS      226.37 seconds
CheckSmatch                   WARNING   334.43 seconds
bluezmakeextell               PASS      109.33 seconds
IncrementalBuild              PASS      2785.53 seconds
ScanBuild                     WARNING   941.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/4] mgmt-tester: Adjust a test for recent kernel changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#58: 
sequentially", https://lore.kernel.org/linux-bluetooth/20240108224614.56900-1-verdre@v0yd.nl/),

/github/workspace/src/src/13535450.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13535450.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/4] emulator/btdev: Send page timeout after 2 secs delay
WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#102: FILE: emulator/btdev.c:1322:
+		struct page_timeout_data *pt_data = new0(struct page_timeout_data, 1);

WARNING:LINE_SPACING: Missing a blank line after declarations
#103: FILE: emulator/btdev.c:1323:
+		struct page_timeout_data *pt_data = new0(struct page_timeout_data, 1);
+		pt_data->btdev = dev;

/github/workspace/src/src/13535451.patch total: 0 errors, 2 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13535451.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/4] mgmt-tester: Add a test for connecting sequentially
WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#125: FILE: tools/mgmt-tester.c:12836:
+		if (pd_data->n_connect_failed_evts != pd_data->n_create_conn_commands - 1) {

WARNING:LONG_LINE_COMMENT: line length of 93 exceeds 80 columns
#143: FILE: tools/mgmt-tester.c:12854:
+		0x31, 0xAB, 0xCD, 0x32, 0x34, 0x73, /* random bdaddr so we fail to connect */

/github/workspace/src/src/13535452.patch total: 0 errors, 2 warnings, 117 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13535452.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/4] mgmt-tester: Adjust a test for recent kernel changes

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B1 Line exceeds max length (95>80): "sequentially", https://lore.kernel.org/linux-bluetooth/20240108224614.56900-1-verdre@v0yd.nl/),"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:420:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1084:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1363:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1485:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============8025712488578948681==--
