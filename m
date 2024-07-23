Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C3A381B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738516; cv=none; b=ozw3dh+d/oIGHjNDWorSzymo3UoksWDyKJz+H6WW0E0DBlYsdgzdiPXL9DFtu2eBguK7At1pOd7Xw7VqYlN1xF3kVds6yI8lC9ZHxJdY55cPFpUQb87vbLvzXCj5/dskqik81P2MRj5FLl1QoVJoQkiaXtQJXswklG8WBW2JA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738516; c=relaxed/simple;
	bh=iuXhIt4YnWcP9swX83t7hf/feBjfgjFzikiOef9dU1A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B7iI8So/Ye0+C8fDOpgdRANyk1A6wqSDeHzQGfKLJLd6pGC2Li+gLp0DKNVMhPZ3qP6A6CWUzJfxBfuyMWVx9aePQG+acfCR4iNwsuAPxdqD1LkqSfq7V8ynMIsWRyqUszegG0NWjgkMwWYSeDplMWwa75X/qlcvEAWriiy1c/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRl03Siq; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRl03Siq"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-260f863109cso2828977fac.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721738513; x=1722343313; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JY+HQxSxpUQqNuXlumqTNh1bk3u8LanfF5Jmd+kyAOk=;
        b=ZRl03Siq01U21OlBz+b+gCQIhw0iIu8GCwy/D/XJOK/3+b1nVe5PlLwnvMZl0RD4ql
         lqDG+iFqicPnXGGyXNhuiG0V4g3NBkWkF8XONyA+ZygHbXWswrxiG5KM2zOGt9Jl7UJJ
         lfLvUCLB6yDadVcKctThdVL96cAVD0oAXTPoh+fEldhmvc/upU9oIH+kh+e+etJiI60f
         kAkhl4mmRvsqdcMsZwRCCT8aG886Vx5/Cbp6/B80bx3Z/abMblFWCctVNT5w+RY+Ny/c
         7SemwOBR125QP10xU3y/mWt/2KjCNojFrUaa46S9gtol7ED1a4FozeFVkAqe0AVuyyDo
         TY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721738513; x=1722343313;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JY+HQxSxpUQqNuXlumqTNh1bk3u8LanfF5Jmd+kyAOk=;
        b=o0W/ayJXdcWkZbEbgHrKSv9h5XTqqbjvfDxLIszcbLHgtwdCoB7MfsUoPKKg8a/Yu6
         2TRf90NYNICv/5/yCit4NRrTTfGfN+DC5DaZGgcwxMxuHmmo6jg7YC+pVaz79o6bisrT
         LZtx751WIGmUmRyTLapz/NNrznuj/o+NkWzm7VoxMgtnvdNzCuFAMDOQD3TxJc8kg0T1
         jsF5aqAQLfnxakDJ4dPsYLQHsuMJ2azGUghZsetkP+MngpQAJdZIBiU5x5jSkadGaaFC
         g55BKskdg5RgbdDwt2oct76SR1bcO5eEg0IhkM3lm6zDR1vqJ3eJzDi8eJfOrsN2C1TY
         BqWQ==
X-Gm-Message-State: AOJu0YwRjwvxtGAEvYhjEyl4Lw76N9T5L8CWRkA+IOV4pQLrH4GGKQM0
	Qy03hktoOcx9/UpWwPX9WY13/XqNDqJ97F1Urfk7I3ztUFwsw7+7hDTsXQ==
X-Google-Smtp-Source: AGHT+IHvlmdoPCtDP/j1+BaTDl3gg05HtLaHwycF61xf2OWoap9R8DFSKTIFWfcq+MEPqp9s8DgmqQ==
X-Received: by 2002:a05:6870:4714:b0:25e:b813:1b5e with SMTP id 586e51a60fabf-264690afe02mr2455697fac.5.1721738513210;
        Tue, 23 Jul 2024 05:41:53 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.181.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990136f1sm476087485a.71.2024.07.23.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 05:41:52 -0700 (PDT)
Message-ID: <669fa510.050a0220.d3e33.e0a0@mx.google.com>
Date: Tue, 23 Jul 2024 05:41:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4618817130846416386=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_nakella@quicinc.com
Subject: RE: [BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.
In-Reply-To: <20240723105631.18422-1-quic_nakella@quicinc.com>
References: <20240723105631.18422-1-quic_nakella@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4618817130846416386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873214

---Test result---

Test Summary:
CheckPatch                    FAIL      0.85 seconds
GitLint                       FAIL      0.51 seconds
BuildEll                      PASS      25.08 seconds
BluezMake                     PASS      1745.47 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      182.30 seconds
CheckValgrind                 PASS      258.59 seconds
CheckSmatch                   PASS      358.44 seconds
bluezmakeextell               PASS      125.23 seconds
IncrementalBuild              PASS      1496.56 seconds
ScanBuild                     WARNING   1018.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.
WARNING:PREFER_LORE_ARCHIVE: Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html
#105: 
https://marc.info/?l=linux-bluetooth&m=139714173525776&w=2

WARNING:LONG_LINE: line length of 125 exceeds 80 columns
#124: FILE: lib/hci.c:1122:
+int hci_send_acl_data(int dd, uint16_t handle, uint8_t dlen, struct signal_hdr *sh, struct signal_payload_hdr *plh, void *pl)

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#127: FILE: lib/hci.c:1125:
+    hci_acl_hdr ha;$

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#140: FILE: lib/hci.c:1138:
+	printf("\nACL Packet details[handle:%x, length:%d]\n", ha.handle, ha.dlen);

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#146: FILE: lib/hci.c:1144:
+		printf("\nACL signal command details[length:%d, cid:%d]\n", sh->len, sh->cid);

ERROR:SPACING: space required before the open parenthesis '('
#147: FILE: lib/hci.c:1145:
+		if(sh->len > 0) {

ERROR:SPACING: space required before the open parenthesis '('
#151: FILE: lib/hci.c:1149:
+			if(plh->len > 0) {

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#167: FILE: lib/hci.c:1165:
+int hci_signal_le_con_param_update_req(int dd, uint16_t handle, uint16_t interval_min,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#168: FILE: lib/hci.c:1166:
+                                        uint16_t interval_max, uint16_t slave_latency,

ERROR:CODE_INDENT: code indent should use tabs where possible
#168: FILE: lib/hci.c:1166:
+                                        uint16_t interval_max, uint16_t slave_latency,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#168: FILE: lib/hci.c:1166:
+                                        uint16_t interval_max, uint16_t slave_latency,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#169: FILE: lib/hci.c:1167:
+                                        uint16_t timeout_multiplier)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#169: FILE: lib/hci.c:1167:
+                                        uint16_t timeout_multiplier)$

WARNING:LONG_LINE: line length of 126 exceeds 80 columns
#240: FILE: lib/hci_lib.h:68:
+int hci_send_acl_data(int dd, uint16_t handle, uint8_t dlen, struct signal_hdr *sh, struct signal_payload_hdr *plh, void *pl);

WARNING:LONG_LINE: line length of 163 exceeds 80 columns
#244: FILE: lib/hci_lib.h:72:
+int hci_signal_le_con_param_update_req(int dd, uint16_t handle, uint16_t interval_min, uint16_t interval_max, uint16_t slave_latency, uint16_t timeout_multiplier);

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#272: FILE: tools/hcitool.c:3388:
+    int options = 0;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#306: FILE: tools/hcitool.c:3422:
+        options = 1;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#306: FILE: tools/hcitool.c:3422:
+        options = 1;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#309: FILE: tools/hcitool.c:3425:
+    if (options == 0) {$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (4, 16)
#309: FILE: tools/hcitool.c:3425:
+    if (options == 0) {
+		helper_arg(5, 5, &argc, &argv, acl_lecup_help);

ERROR:CODE_INDENT: code indent should use tabs where possible
#334: FILE: tools/hcitool.c:3450:
+            handle, min, max, latency, timeout);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#334: FILE: tools/hcitool.c:3450:
+            handle, min, max, latency, timeout);$

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#335: FILE: tools/hcitool.c:3451:
+	if (hci_signal_le_con_param_update_req(dd, htobs(handle), htobs(min), htobs(max),

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#336: FILE: tools/hcitool.c:3452:
+                                            htobs(latency), htobs(timeout)) < 0) {

ERROR:CODE_INDENT: code indent should use tabs where possible
#336: FILE: tools/hcitool.c:3452:
+                                            htobs(latency), htobs(timeout)) < 0) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#336: FILE: tools/hcitool.c:3452:
+                                            htobs(latency), htobs(timeout)) < 0) {$

WARNING:LINE_SPACING: Missing a blank line after declarations
#338: FILE: tools/hcitool.c:3454:
+		int err = -errno;
+		fprintf(stderr, "Could not change connection params: %s(%d)\n",

/github/workspace/src/src/13739894.patch total: 7 errors, 20 warnings, 224 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13739894.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (95>80): "[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request."
1: T3 Title has trailing punctuation (.): "[BlueZ,v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request."
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/hcitool.c:3404:13: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        handle = strtoul(optarg, NULL, base);
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3407:10: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        min = strtoul(optarg, NULL, base);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3410:10: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        max = strtoul(optarg, NULL, base);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3413:14: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        latency = strtoul(optarg, NULL, base);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/hcitool.c:3416:14: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        timeout = strtoul(optarg, NULL, base);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
5 warnings generated.



---
Regards,
Linux Bluetooth


--===============4618817130846416386==--
