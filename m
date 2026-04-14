Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A43242BA
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199268; cv=none; b=jmO+68aPlQZpdAIj0g7XkngP/kLZE+PsUgeocrMxbcPutXNK7FLx66Khz6/wTy22KSFkyRFbgt4Yza17OxYkyae3wCeoQqfBVoC94lqy27509MxsBXrxb9lkOwhIl1fbKQY5qTNsBsUHe9BfnVcowmefRnjQuhagCmVr+z4RqbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199268; c=relaxed/simple;
	bh=lQdAuDMDXFYe0AUx4GjuRYERDCBjrb6JJSgqJe8LzAk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HhF2zHEPdNvaWDxyH0BKp6D7hJX2X57QxVYwZO65eilFbUJ3W9pmSK8349GgJHKSdV6Wr9fKP21Hc45KEDF0g3dcwkN4Y27yNSmFYYbMcMp2krb2sNpVr6sszfgitnYtq/mhq+y5XIc3YLcmq0pTTnMepXQIwUS68KifiFRwrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agB9kwsD; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agB9kwsD"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d68bcf50fdso687988785a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776199266; x=1776804066; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2q5JWZMx1pFVGgssiDXUIXqZ/UKWR9ZUMGOum+RfwKA=;
        b=agB9kwsDrDuE5kIRk2k6m5JTmlcLR+jX+lgND6riCJ7uvusMRVenvhYNhAbWQ1o9B/
         s3XCD6DgeFfvrEuTTkwYzItJNHO5+n1hNsXQyan1oN8p8OL6vm+MIAo9EDiQxrcBJwve
         IhKFe+HR5HmhcQe8wnYUdIub56ElhAeJ61AMxXIB66/2LB/GhwkwOXI+xbr6PYnH/YOJ
         5k0sysKM/ZLEWRZsbDNH8Cnz8trex57FgfvT1GoLkiDBWykEfyNF4IiTF87EBA2vneuY
         JWAedSSGtsMAyYsJpPQE7vl+w/jaFOWb6Dj8u6H8ifN5AEbWNk+KIF5nMJIhrmViUtrW
         5jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776199266; x=1776804066;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q5JWZMx1pFVGgssiDXUIXqZ/UKWR9ZUMGOum+RfwKA=;
        b=F1RGLj063YLom6e71wXnVDC+Eotm8Z4vbyvJflE0bEtsVQsgpKogNEbsv/2/KP4M73
         kNUjy7XShjcTvSkqLeJcaLII5m6anoVOOUb4BZYnYuccxg99zmYj9ii7GbSVFbpeHsdd
         mGzmmAflFu8rtOEE3aWe7Ee8mq2DlF3uC9Cx+jO6ffnjzRhL8POpvmKqx/B9jM+rrDuW
         1EwYhgyrtoYVesQKluV2OfL3ot8wbGfXBRA3UYSpFUxlLVKt2yczfczVcL7OJfy0DyN9
         p2UFRve9g0CS4wvFg0TJWN5nLRXkBD/r0LNXaUKiz4eXK/eRW2LGZfJhk6ug9AUgj8TN
         br7g==
X-Gm-Message-State: AOJu0Yy2jeDvLTouj/vwjIOzatJNsmgHM+Pg6uJsORB5ipEoQMdCnO2t
	2aQZ7xzXH4hZaKwohMorLei8K2oJrEmpCCjug3u16G4BBN/7hfHeqdE/4rR49A==
X-Gm-Gg: AeBDiev4CclH2yYiOfnNG6zY6eGcDQGp00HXk8hEdbP4a47G3ymzwcoKDD9S5itr2jN
	aj2ZWK2XcOUroV0oLY59UnJAtOeTGsCPRwwh7s1ZaC6jQCLtgXO4jwIAVz4I0SbJYe7NPXHxSwH
	7VqG0BHLhwZr2scMRR1/s7xKF3AqP4YUGH3tRt4xdUnNoBaiw6VGgJMR2WQARtyPspJrvaF87sV
	s7auMFA5QaTM0KR0VtGqzNx2HaDXJbQ99vNSNC+TaAmjXG30Jd583/svvFGnIyYAqnPZN/wO8B9
	VSimy/bhVWgXArCIVsBWqsqoZkvuXH7MYiT6uQPx+omHl07Z7R8n0EsXO/QRubawOJoPIk17PxG
	B5v6cQciwPvgqqj4PJNCk/JusV6zcKeb2PeZRzJfAqEABC8f+8RedmH9Yg0tel0HHu+smbEeQgR
	MxoS8D1S0tftZFR9Km1jVWSW+TRTRQTR3hknHFb9WE0A==
X-Received: by 2002:a05:620a:4626:b0:8cf:bb33:b46 with SMTP id af79cd13be357-8ddcd219355mr2756725585a.7.1776199265621;
        Tue, 14 Apr 2026 13:41:05 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9351afasm1162114885a.36.2026.04.14.13.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:41:05 -0700 (PDT)
Message-ID: <69dea661.050a0220.209e1a.cc44@mx.google.com>
Date: Tue, 14 Apr 2026 13:41:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2984722079943623489=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] bass: Fix crashing on BT_BASS_MOD_SRC
In-Reply-To: <20260414190459.161947-1-luiz.dentz@gmail.com>
References: <20260414190459.161947-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2984722079943623489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081265

---Test result---

Test Summary:
CheckPatch                    FAIL      0.79 seconds
GitLint                       FAIL      0.63 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      647.42 seconds
MakeCheck                     PASS      18.85 seconds
MakeDistcheck                 PASS      243.52 seconds
CheckValgrind                 PASS      296.43 seconds
CheckSmatch                   PASS      346.73 seconds
bluezmakeextell               PASS      181.18 seconds
IncrementalBuild              FAIL      0.00 seconds
ScanBuild                     PASS      1008.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] bass: Fix crashing on BT_BASS_MOD_SRC
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#101: 
 #0  queue_find (queue=<optimized out>, function=function@entry=0x58b8761109c0 <setup_match_bis>, match_data=match_data@entry=0x3) at src/shared/queue.c:230

/github/workspace/src/patch/14524659.patch total: 0 errors, 1 warnings, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14524659.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] bass: Fix crashing on BT_BASS_MOD_SRC

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (156>80): " #0  queue_find (queue=<optimized out>, function=function@entry=0x58b8761109c0 <setup_match_bis>, match_data=match_data@entry=0x3) at src/shared/queue.c:230"
10: B1 Line exceeds max length (125>80): " #1  0x000058b8761127fb in bass_update_bis_sync (bcast_src=<optimized out>, dg=<optimized out>) at profiles/audio/bass.c:1824"
11: B1 Line exceeds max length (126>80): " #2  handle_mod_src_req (data=<optimized out>, params=<optimized out>, bcast_src=0x58b894661be0) at profiles/audio/bass.c:1862"
12: B1 Line exceeds max length (143>80): " #3  cp_handler (bcast_src=0x58b894661be0, op=<optimized out>, params=<optimized out>, user_data=<optimized out>) at profiles/audio/bass.c:1910"
13: B1 Line exceeds max length (182>80): " #4  0x000058b8761bc978 in bass_handle_mod_src_op (bass=<optimized out>, attrib=<optimized out>, opcode=<optimized out>, id=<optimized out>, iov=<optimized out>, att=<optimized out>)"
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:
Failed to reset to base commit


https://github.com/bluez/bluez/pull/2036

---
Regards,
Linux Bluetooth


--===============2984722079943623489==--
