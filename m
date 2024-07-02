Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FF1DFE3
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929933; cv=none; b=qh2iixAc5MeZT2jFNiMeNdI/w+4qx8u5t88HKIHFIsz4+8+xNmb85I96OHkIybuk6DUNiKc98MEGQ9ZddRPFe2JGskLWN6MzzItDL19RK/3r2DOtfLD8XMtFU0fQzYirrD8Fj5Ze5mP4WV+lR5JDLfI/NL7VPIrFUZHgWWn+2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929933; c=relaxed/simple;
	bh=tZZ+mV970VfbNFZLfe/NvhRT4B6t+QuBOR7MIuLi/g8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S8EgiotN6L8SYSI278ytRoN9YJ5aUjJCBf3yH3GzaAm7TSzjkLqdM/oj+iHEbUYFylfoNlU7ruJxz13gN8rCyj4o3yEKwLG+a+e9Vyr5mkWrM3jnuTQw57BahqBxRRIUWxWT//v3sOr1Lm6gf5dGElFhU4Pza1X+i8gEysGT7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4dqJi5r; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4dqJi5r"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ad8243dba8so23108446d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929929; x=1720534729; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eDDrsXOd+DNxeI/YFPcvUQDTff/+4sok5MB5Pkfq03M=;
        b=a4dqJi5raVWKtWpcNFMwF7KDREm8G1SScQQfiIhYJOcbTFHiw/6BpsrUn8fh2McXXu
         paSIGQX42nCgs4aag06n08I3UwfxduXouTmbFjig2UhZ0T21G964TpKE5MTVfNVSmw4h
         P60w1qmRuawy/T0q9RC3R8KkYHNFc9LwKe8psgRCxJ5/L+BpeFOLvt5+0Zwkm2Y0v0G3
         sl6CbrnrM/bKnXAiyA//quBQ7LYIwiJ4F6MQfw+PSAVdh9ithSq4cOfNPvrDxFdZDOEX
         wfC1Afj2PN6kVfgqXjsHSpGssHGFplsmN89LR29DOtQ6nYEwsxPrAtq1Z8WuEG2saH9r
         Eaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929929; x=1720534729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDDrsXOd+DNxeI/YFPcvUQDTff/+4sok5MB5Pkfq03M=;
        b=Jg1eiDj06ZwVBU58umgp9C6LEi55Z5OxP1KGKO9cSKjbyn2E+EY35KfKDiDD+f/pPG
         /Qg1b3Q1zkVGZQ0W65VkrpZb+yevlJ1ZbK7yOdtpQcC2+9LLBrDx6UGKGdRC5Ub2Qy16
         Mgr6kdhtlJ6XRGP51+MhO+12Se9Ij3iqF2QbaZI8JDcYTtzp/ITnTNNBF90Vmh2W/Z+C
         W/k3Mwc40DiNu+JHDZzs5appcLC45SISm78rNcNMaFC2C6QjiHgIFgR1PlJRV5mqeq29
         wQ2/4bD6H/aDPi4+QQbT3clVo7KzaK09JpM8mqWNMaEEuJaUxfmapWKCBh4Cku+hEmKK
         WNNw==
X-Gm-Message-State: AOJu0YycFHyvFknVPhHx9tylXF3Eeh1b3yByyqJuW/xDf+mW6/llVrBT
	4kWOGQn/JCkUU55oA0+Bs29M6KtDwP6+qqpuNyAtcPUkAr5DwljySEf0Cw==
X-Google-Smtp-Source: AGHT+IHjV1hdf+ATauZllAsZCPekt97T55vzF1uozviDYqql2UXvvm0lWgJQq9gH4GOG5fsInk+GAQ==
X-Received: by 2002:a05:6214:5010:b0:6b5:50:4427 with SMTP id 6a1803df08f44-6b5b704ee85mr93965726d6.12.1719929929011;
        Tue, 02 Jul 2024 07:18:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.60.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e73897dsm44123056d6.139.2024.07.02.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:18:48 -0700 (PDT)
Message-ID: <66840c48.050a0220.e062.1524@mx.google.com>
Date: Tue, 02 Jul 2024 07:18:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7270061440973211710=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix a number of static analysis issues #4
In-Reply-To: <20240702084900.773620-2-hadess@hadess.net>
References: <20240702084900.773620-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7270061440973211710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867448

---Test result---

Test Summary:
CheckPatch                    FAIL      4.33 seconds
GitLint                       FAIL      3.06 seconds
BuildEll                      PASS      24.63 seconds
BluezMake                     PASS      1725.31 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      186.04 seconds
CheckValgrind                 PASS      258.75 seconds
CheckSmatch                   PASS      358.55 seconds
bluezmakeextell               PASS      119.51 seconds
IncrementalBuild              PASS      14481.95 seconds
ScanBuild                     WARNING   988.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[2/9] avdtp: Fix manipulating struct as an array
WARNING:LINE_SPACING: Missing a blank line after declarations
#134: FILE: profiles/audio/avdtp.c:1684:
+		struct seid seid = start->seids[i];
+		if (seid.seid == id) {

WARNING:LINE_SPACING: Missing a blank line after declarations
#150: FILE: profiles/audio/avdtp.c:1699:
+		struct seid seid = suspend->seids[i];
+		if (seid.seid == id) {

WARNING:LINE_SPACING: Missing a blank line after declarations
#194: FILE: profiles/audio/avdtp.c:1916:
+		struct seid seid = req->seids[i];
+		failed_seid = seid.seid;

/github/workspace/src/src/13719119.patch total: 0 errors, 3 warnings, 105 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13719119.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/9] main: Simplify parse_config_string()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (108>80): "bluez-5.75/src/main.c:425:2: alloc_fn: Storage is returned from allocation function "g_key_file_get_string"."
16: B1 Line exceeds max length (132>80): "bluez-5.75/src/main.c:425:2: var_assign: Assigning: "tmp" = storage returned from "g_key_file_get_string(config, group, key, &err)"."
17: B1 Line exceeds max length (126>80): "bluez-5.75/src/main.c:433:2: noescape: Assuming resource "tmp" is not freed or pointed-to as ellipsis argument to "btd_debug"."
18: B1 Line exceeds max length (110>80): "bluez-5.75/src/main.c:440:2: leaked_storage: Variable "tmp" going out of scope leaks the storage it points to."
19: B3 Line contains hard tab characters (\t): "438|	}"
21: B3 Line contains hard tab characters (\t): "440|->	return true;"
[2/9] avdtp: Fix manipulating struct as an array

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (122>80): "bluez-5.76/profiles/audio/avdtp.c:1675:2: address_of: Taking address with "&start->first_seid" yields a singleton pointer."
8: B1 Line exceeds max length (91>80): "bluez-5.76/profiles/audio/avdtp.c:1675:2: assign: Assigning: "seid" = "&start->first_seid"."
9: B1 Line exceeds max length (142>80): "bluez-5.76/profiles/audio/avdtp.c:1679:25: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations."
17: B1 Line exceeds max length (124>80): "bluez-5.76/profiles/audio/avdtp.c:1690:2: address_of: Taking address with "&suspend->first_seid" yields a singleton pointer."
18: B1 Line exceeds max length (93>80): "bluez-5.76/profiles/audio/avdtp.c:1690:2: assign: Assigning: "seid" = "&suspend->first_seid"."
19: B1 Line exceeds max length (142>80): "bluez-5.76/profiles/audio/avdtp.c:1694:25: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations."
20: B3 Line contains hard tab characters (\t): "1692|		int i;"
22: B3 Line contains hard tab characters (\t): "1694|->		for (i = 0; i < count; i++, seid++) {"
23: B3 Line contains hard tab characters (\t): "1695|			if (seid->seid == id) {"
24: B3 Line contains hard tab characters (\t): "1696|				req->collided = TRUE;"
27: B1 Line exceeds max length (120>80): "bluez-5.76/profiles/audio/avdtp.c:1799:2: address_of: Taking address with "&req->first_seid" yields a singleton pointer."
28: B1 Line exceeds max length (89>80): "bluez-5.76/profiles/audio/avdtp.c:1799:2: assign: Assigning: "seid" = "&req->first_seid"."
29: B1 Line exceeds max length (142>80): "bluez-5.76/profiles/audio/avdtp.c:1801:30: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations."
30: B3 Line contains hard tab characters (\t): "1799|		seid = &req->first_seid;"
32: B3 Line contains hard tab characters (\t): "1801|->		for (i = 0; i < seid_count; i++, seid++) {"
33: B3 Line contains hard tab characters (\t): "1802|			failed_seid = seid->seid;"
37: B1 Line exceeds max length (120>80): "bluez-5.76/profiles/audio/avdtp.c:1912:2: address_of: Taking address with "&req->first_seid" yields a singleton pointer."
38: B1 Line exceeds max length (89>80): "bluez-5.76/profiles/audio/avdtp.c:1912:2: assign: Assigning: "seid" = "&req->first_seid"."
39: B1 Line exceeds max length (142>80): "bluez-5.76/profiles/audio/avdtp.c:1914:30: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations."
40: B3 Line contains hard tab characters (\t): "1912|		seid = &req->first_seid;"
42: B3 Line contains hard tab characters (\t): "1914|->	for (i = 0; i < seid_count; i++, seid++) {"
43: B3 Line contains hard tab characters (\t): "1915|			failed_seid = seid->seid;"
[3/9] mesh: Avoid accessing array out-of-bounds

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (133>80): "bluez-5.76/mesh/prov-initiator.c:676:2: cond_at_least: Checking "type >= 10UL" implies that "type" is at least 10 on the true branch."
9: B1 Line exceeds max length (195>80): "bluez-5.76/mesh/prov-initiator.c:678:3: overrun-local: Overrunning array "expected_pdu_size" of 10 2-byte elements at element index 10 (byte offset 21) using index "type" (which evaluates to 10)."
10: B3 Line contains hard tab characters (\t): "676|	if (type >= L_ARRAY_SIZE(expected_pdu_size) ||"
11: B3 Line contains hard tab characters (\t): "677|					len != expected_pdu_size[type]) {"
12: B3 Line contains hard tab characters (\t): "678|->		l_error("Expected PDU size %d, Got %d (type: %2.2x)","
13: B3 Line contains hard tab characters (\t): "679|			expected_pdu_size[type], len, type);"
14: B3 Line contains hard tab characters (\t): "680|		fail_code[1] = PROV_ERR_INVALID_FORMAT;"
[4/9] obexd: Fix possible memleak

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:362:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
8: B1 Line exceeds max length (141>80): "bluez-5.76/obexd/plugins/messages-dummy.c:362:4: var_assign: Assigning: "entry->handle" = storage returned from "g_strdup_inline(values[i])"."
9: B1 Line exceeds max length (189>80): "bluez-5.76/obexd/plugins/messages-dummy.c:362:4: overwrite_var: Overwriting "entry->handle" in "entry->handle = g_strdup_inline(values[i])" leaks the storage that "entry->handle" points to."
10: B3 Line contains hard tab characters (\t): "360|	for (i = 0 ; names[i]; ++i) {"
11: B3 Line contains hard tab characters (\t): "361|		if (g_strcmp0(names[i], "handle") == 0) {"
12: B3 Line contains hard tab characters (\t): "362|->			entry->handle = g_strdup(values[i]);"
13: B3 Line contains hard tab characters (\t): "363|			mld->size++;"
14: B3 Line contains hard tab characters (\t): "364|			continue;"
17: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:367:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
18: B1 Line exceeds max length (150>80): "bluez-5.76/obexd/plugins/messages-dummy.c:367:4: var_assign: Assigning: "entry->attachment_size" = storage returned from "g_strdup_inline(values[i])"."
19: B1 Line exceeds max length (216>80): "bluez-5.76/obexd/plugins/messages-dummy.c:367:4: overwrite_var: Overwriting "entry->attachment_size" in "entry->attachment_size = g_strdup_inline(values[i])" leaks the storage that "entry->attachment_size" points to."
20: B3 Line contains hard tab characters (\t): "365|		}"
21: B3 Line contains hard tab characters (\t): "366|		if (g_strcmp0(names[i], "attachment_size") == 0) {"
22: B3 Line contains hard tab characters (\t): "367|->			entry->attachment_size = g_strdup(values[i]);"
23: B3 Line contains hard tab characters (\t): "368|			continue;"
24: B3 Line contains hard tab characters (\t): "369|		}"
27: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:371:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
28: B1 Line exceeds max length (143>80): "bluez-5.76/obexd/plugins/messages-dummy.c:371:4: var_assign: Assigning: "entry->datetime" = storage returned from "g_strdup_inline(values[i])"."
29: B1 Line exceeds max length (195>80): "bluez-5.76/obexd/plugins/messages-dummy.c:371:4: overwrite_var: Overwriting "entry->datetime" in "entry->datetime = g_strdup_inline(values[i])" leaks the storage that "entry->datetime" points to."
30: B3 Line contains hard tab characters (\t): "369|		}"
31: B3 Line contains hard tab characters (\t): "370|		if (g_strcmp0(names[i], "datetime") == 0) {"
32: B3 Line contains hard tab characters (\t): "371|->			entry->datetime = g_strdup(values[i]);"
33: B3 Line contains hard tab characters (\t): "372|			continue;"
34: B3 Line contains hard tab characters (\t): "373|		}"
37: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:375:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
38: B1 Line exceeds max length (142>80): "bluez-5.76/obexd/plugins/messages-dummy.c:375:4: var_assign: Assigning: "entry->subject" = storage returned from "g_strdup_inline(values[i])"."
39: B1 Line exceeds max length (192>80): "bluez-5.76/obexd/plugins/messages-dummy.c:375:4: overwrite_var: Overwriting "entry->subject" in "entry->subject = g_strdup_inline(values[i])" leaks the storage that "entry->subject" points to."
40: B3 Line contains hard tab characters (\t): "373|		}"
41: B3 Line contains hard tab characters (\t): "374|		if (g_strcmp0(names[i], "subject") == 0) {"
42: B3 Line contains hard tab characters (\t): "375|->			entry->subject = g_strdup(values[i]);"
43: B3 Line contains hard tab characters (\t): "376|			continue;"
44: B3 Line contains hard tab characters (\t): "377|		}"
47: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:379:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
48: B1 Line exceeds max length (155>80): "bluez-5.76/obexd/plugins/messages-dummy.c:379:4: var_assign: Assigning: "entry->recipient_addressing" = storage returned from "g_strdup_inline(values[i])"."
49: B1 Line exceeds max length (231>80): "bluez-5.76/obexd/plugins/messages-dummy.c:379:4: overwrite_var: Overwriting "entry->recipient_addressing" in "entry->recipient_addressing = g_strdup_inline(values[i])" leaks the storage that "entry->recipient_addressing" points to."
50: B3 Line contains hard tab characters (\t): "377|		}"
51: B3 Line contains hard tab characters (\t): "378|		if (g_strcmp0(names[i], "recipient_addressing") == 0) {"
52: B3 Line contains hard tab characters (\t): "379|->			entry->recipient_addressing = g_strdup(values[i]);"
53: B3 Line contains hard tab characters (\t): "380|			continue;"
54: B3 Line contains hard tab characters (\t): "381|		}"
57: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:383:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
58: B1 Line exceeds max length (152>80): "bluez-5.76/obexd/plugins/messages-dummy.c:383:4: var_assign: Assigning: "entry->sender_addressing" = storage returned from "g_strdup_inline(values[i])"."
59: B1 Line exceeds max length (222>80): "bluez-5.76/obexd/plugins/messages-dummy.c:383:4: overwrite_var: Overwriting "entry->sender_addressing" in "entry->sender_addressing = g_strdup_inline(values[i])" leaks the storage that "entry->sender_addressing" points to."
60: B3 Line contains hard tab characters (\t): "381|		}"
61: B3 Line contains hard tab characters (\t): "382|		if (g_strcmp0(names[i], "sender_addressing") == 0) {"
62: B3 Line contains hard tab characters (\t): "383|->			entry->sender_addressing = g_strdup(values[i]);"
63: B3 Line contains hard tab characters (\t): "384|			continue;"
64: B3 Line contains hard tab characters (\t): "385|		}"
67: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:387:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
68: B1 Line exceeds max length (139>80): "bluez-5.76/obexd/plugins/messages-dummy.c:387:4: var_assign: Assigning: "entry->type" = storage returned from "g_strdup_inline(values[i])"."
69: B1 Line exceeds max length (183>80): "bluez-5.76/obexd/plugins/messages-dummy.c:387:4: overwrite_var: Overwriting "entry->type" in "entry->type = g_strdup_inline(values[i])" leaks the storage that "entry->type" points to."
70: B3 Line contains hard tab characters (\t): "385|		}"
71: B3 Line contains hard tab characters (\t): "386|		if (g_strcmp0(names[i], "type") == 0) {"
72: B3 Line contains hard tab characters (\t): "387|->			entry->type = g_strdup(values[i]);"
73: B3 Line contains hard tab characters (\t): "388|			continue;"
74: B3 Line contains hard tab characters (\t): "389|		}"
77: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:391:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
78: B1 Line exceeds max length (151>80): "bluez-5.76/obexd/plugins/messages-dummy.c:391:4: var_assign: Assigning: "entry->reception_status" = storage returned from "g_strdup_inline(values[i])"."
79: B1 Line exceeds max length (219>80): "bluez-5.76/obexd/plugins/messages-dummy.c:391:4: overwrite_var: Overwriting "entry->reception_status" in "entry->reception_status = g_strdup_inline(values[i])" leaks the storage that "entry->reception_status" points to."
80: B3 Line contains hard tab characters (\t): "389|		}"
81: B3 Line contains hard tab characters (\t): "390|		if (g_strcmp0(names[i], "reception_status") == 0)"
82: B3 Line contains hard tab characters (\t): "391|->			entry->reception_status = g_strdup(values[i]);"
83: B3 Line contains hard tab characters (\t): "392|	}"
[5/9] obexd: Fix memory leak in entry struct

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (122>80): "bluez-5.76/obexd/plugins/messages-dummy.c:379:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline"."
7: B1 Line exceeds max length (155>80): "bluez-5.76/obexd/plugins/messages-dummy.c:379:4: var_assign: Assigning: "entry->recipient_addressing" = storage returned from "g_strdup_inline(values[i])"."
8: B1 Line exceeds max length (194>80): "bluez-5.76/obexd/plugins/messages-dummy.c:404:2: leaked_storage: Freeing "entry" without freeing its pointer field "recipient_addressing" leaks the storage that "recipient_addressing" points to."
9: B3 Line contains hard tab characters (\t): "402|	g_free(entry->attachment_size);"
10: B3 Line contains hard tab characters (\t): "403|	g_free(entry->handle);"
11: B3 Line contains hard tab characters (\t): "404|->	g_free(entry);"
[6/9] obexd: Fix leak in backup_object struct

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (119>80): "bluez-5.76/obexd/plugins/pcsuite.c:370:2: alloc_fn: Storage is returned from allocation function "g_path_get_basename"."
5: B1 Line exceeds max length (128>80): "bluez-5.76/obexd/plugins/pcsuite.c:370:2: var_assign: Assigning: "obj->cmd" = storage returned from "g_path_get_basename(name)"."
6: B1 Line exceeds max length (151>80): "bluez-5.76/obexd/plugins/pcsuite.c:379:3: leaked_storage: Freeing "obj" without freeing its pointer field "cmd" leaks the storage that "cmd" points to."
8: B3 Line contains hard tab characters (\t): "378|	if (send_backup_dbus_message("open", obj, size) == FALSE) {"
9: B3 Line contains hard tab characters (\t): "379|->		g_free(obj);"
10: B3 Line contains hard tab characters (\t): "380|		obj = NULL;"
11: B3 Line contains hard tab characters (\t): "381|	}"
[7/9] health/mcap: Fix memory leak in mcl struct

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (117>80): "bluez-5.76/profiles/health/mcap.c:2052:3: alloc_arg: "set_default_cb" allocates memory that is stored into "mcl->cb"."
5: B1 Line exceeds max length (149>80): "bluez-5.76/profiles/health/mcap.c:2055:4: leaked_storage: Freeing "mcl" without freeing its pointer field "cb" leaks the storage that "cb" points to."
6: B3 Line contains hard tab characters (\t): "2053|			if (util_getrandom(&val, sizeof(val), 0) < 0) {"
7: B3 Line contains hard tab characters (\t): "2054|				mcap_instance_unref(mcl->mi);"
8: B3 Line contains hard tab characters (\t): "2055|->				g_free(mcl);"
9: B3 Line contains hard tab characters (\t): "2056|				goto drop;"
10: B3 Line contains hard tab characters (\t): "2057|			}"
[8/9] sdp: Fix memory leak in sdp_data_alloc*()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (100>80): "bluez-5.76/lib/sdp.c:542:4: alloc_fn: Storage is returned from allocation function "sdp_data_alloc"."
8: B1 Line exceeds max length (115>80): "bluez-5.76/lib/sdp.c:542:4: var_assign: Assigning: "data" = storage returned from "sdp_data_alloc(dtd, values[i])"."
13: B1 Line exceeds max length (109>80): "bluez-5.76/lib/sdp.c:545:4: leaked_storage: Variable "seq" going out of scope leaks the storage it points to."
15: B3 Line contains hard tab characters (\t): "544|		if (!data)"
16: B3 Line contains hard tab characters (\t): "545|->			return NULL;"
18: B3 Line contains hard tab characters (\t): "547|		if (curr)"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
lib/sdp.c:509:16: warning: Dereference of undefined pointer value
                int8_t dtd = *(uint8_t *) dtds[i];
                             ^~~~~~~~~~~~~~~~~~~~
lib/sdp.c:539:17: warning: Dereference of undefined pointer value
                uint8_t dtd = *(uint8_t *) dtds[i];
                              ^~~~~~~~~~~~~~~~~~~~
lib/sdp.c:586:12: warning: Access to field 'attrId' results in a dereference of a null pointer (loaded from variable 'd')
        d->attrId = attr;
        ~         ^
lib/sdp.c:967:10: warning: Access to field 'dtd' results in a dereference of a null pointer (loaded from variable 'd')
        switch (d->dtd) {
                ^~~~~~
lib/sdp.c:1881:26: warning: Potential leak of memory pointed to by 'ap'
        for (; pdlist; pdlist = pdlist->next) {
                                ^~~~~~
lib/sdp.c:1895:6: warning: Potential leak of memory pointed to by 'pds'
                ap = sdp_list_append(ap, pds);
                ~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
lib/sdp.c:1940:10: warning: Potential leak of memory pointed to by 'u'
                        *seqp = sdp_list_append(*seqp, u);
                        ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/sdp.c:2045:4: warning: Potential leak of memory pointed to by 'lang'
                        sdp_list_free(*langSeq, free);
                        ^~~~~~~~~~~~~
lib/sdp.c:2134:9: warning: Potential leak of memory pointed to by 'profDesc'
        return 0;
               ^
lib/sdp.c:3266:8: warning: Potential leak of memory pointed to by 'pSvcRec'
                pSeq = sdp_list_append(pSeq, pSvcRec);
                ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/sdp.c:3267:9: warning: Potential leak of memory pointed to by 'pSeq'
                pdata += sizeof(uint32_t);
                ~~~~~~^~~~~~~~~~~~~~~~~~~
lib/sdp.c:4603:13: warning: Potential leak of memory pointed to by 'rec_list'
                        } while (scanned < attr_list_len && pdata_len > 0);
                                 ^~~~~~~
lib/sdp.c:4899:40: warning: Potential leak of memory pointed to by 'tseq'
        for (d = sdpdata->val.dataseq; d; d = d->next) {
                                              ^
lib/sdp.c:4935:8: warning: Potential leak of memory pointed to by 'subseq'
                tseq = sdp_list_append(tseq, subseq);
                ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
14 warnings generated.
profiles/audio/avdtp.c:899:25: warning: Use of memory after it is freed
                session->prio_queue = g_slist_remove(session->prio_queue, req);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/avdtp.c:906:24: warning: Use of memory after it is freed
                session->req_queue = g_slist_remove(session->req_queue, req);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============7270061440973211710==--
