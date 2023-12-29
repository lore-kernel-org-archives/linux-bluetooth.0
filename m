Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE05C9B
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Dec 2023 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIFqDyy7"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-781161d18ecso500553885a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Dec 2023 18:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703817458; x=1704422258; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fBLOMhh7Cz8IndioWWwv9ESwJzEUL/ljdFLTwGQUzgQ=;
        b=DIFqDyy7kKe5+JM9a/wOKqrg7R8si6+KPHjN+99oArPrgFN08DoX6U7sWdsJc83l1j
         24SEdF64stISWszKp0/lEFfa3EBBxH59tacfVDKjsKwUnB+pwaerM+F83vH+ycNgdFLd
         1QnYH81pkdpNo2l2LxX4yRw1PgMJ8J10tjFCyTaWYrTt6SbnrHN1j2NNBAGivS5bJ4NZ
         jfKENInwDc0XLdXO0Pe8mpspxVWbHC8x62u9GvbmeitrSe2oKFJdLP5LjHrQrEashA8n
         91zacwTnGoJ8CbvmXW+O3uFylpETKUtkwNNueeqtrxO+cHtOOgXKRKk6yRaQHc8XaSwN
         GYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703817458; x=1704422258;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBLOMhh7Cz8IndioWWwv9ESwJzEUL/ljdFLTwGQUzgQ=;
        b=IRcErSen+YCQZWX7zX4d/eXd7y58fh9efMArI0CnCln/VIbIzXzEraOPiStG6z+QSD
         vQBN4kQ0jkc7XInPFbbDaFu7OQEt9pYJOD1XItqEF2jQOUHyCPb8/j3mfOkNJR+yqe26
         4LRlHfgPizt+8pI/bbQnw3t5iZl8GT+w72pDYjFOgSHMb32PQyRcD8uHWZ8RNK98GbhX
         YWxAImzlJH/1dZMNirPmmvgkWJglEGcft32JJSaZ6xgbL59RLwjiTrohNSQ+CyT3QvzG
         TBSYTvw07NzxAnz6y65DzPx1sVAOEEt5l1Y3IgrrTebm9MnrOCrntU9EEJkeuYzLM+Az
         p3BQ==
X-Gm-Message-State: AOJu0YwmB4SRmqGC24JBczhK7K4fdHWxEgvmMeB6HoR+Hi+oYdqqT1Qz
	WsfIKBl4GZRQj+zBQglimgmZQw69UHQ=
X-Google-Smtp-Source: AGHT+IErfe3P3PtyEiMtXynYFINw3q5q3L9YXDTcikOiT3hH8JhTU6RA71WPZsX3C8TNlMhk+4EueQ==
X-Received: by 2002:a05:620a:46a3:b0:77f:ac99:38d9 with SMTP id bq35-20020a05620a46a300b0077fac9938d9mr15335888qkb.70.1703817458157;
        Thu, 28 Dec 2023 18:37:38 -0800 (PST)
Received: from [172.17.0.2] ([172.183.122.242])
        by smtp.gmail.com with ESMTPSA id u11-20020ae9c00b000000b0078162695b73sm1492619qkk.104.2023.12.28.18.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 18:37:37 -0800 (PST)
Message-ID: <658e30f1.e90a0220.80fb8.4b72@mx.google.com>
Date: Thu, 28 Dec 2023 18:37:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7320479412205916185=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,v2,1/1] avdtp: fix incorrect transaction label in setconf phase
In-Reply-To: <20231229012953.1969874-1-xiaokeqinhealth@126.com>
References: <20231229012953.1969874-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7320479412205916185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813281

---Test result---

Test Summary:
CheckPatch                    FAIL      0.62 seconds
GitLint                       FAIL      0.48 seconds
BuildEll                      PASS      24.65 seconds
BluezMake                     PASS      761.31 seconds
MakeCheck                     PASS      12.12 seconds
MakeDistcheck                 PASS      167.85 seconds
CheckValgrind                 PASS      227.09 seconds
CheckSmatch                   PASS      329.57 seconds
bluezmakeextell               PASS      106.47 seconds
IncrementalBuild              PASS      713.01 seconds
ScanBuild                     WARNING   974.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/1] avdtp: fix incorrect transaction label in setconf phase
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#68: 
AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 6 nosp 0

/github/workspace/src/src/13506254.patch total: 0 errors, 1 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13506254.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/1] avdtp: fix incorrect transaction label in setconf phase

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (82>80): "AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 6 nosp 0"
25: B1 Line exceeds max length (82>80): "AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 7 nosp 0"
35: B3 Line contains hard tab characters (\t): "						MEDIA_ENDPOINT_INTERFACE,"
36: B3 Line contains hard tab characters (\t): "						"SetConfiguration");"
37: B3 Line contains hard tab characters (\t): "	media_endpoint_async_call()"
38: B3 Line contains hard tab characters (\t): "	//dbus send"
39: B3 Line contains hard tab characters (\t): "	g_dbus_send_message_with_reply(btd_get_dbus_connection(),"
40: B3 Line contains hard tab characters (\t): "						msg, &request->call,"
41: B3 Line contains hard tab characters (\t): "						REQUEST_TIMEOUT(3 seconds))"
42: B3 Line contains hard tab characters (\t): "	dbus_pending_call_set_notify(request->call, endpoint_reply, request,NULL);"
43: B3 Line contains hard tab characters (\t): "	..."
51: B1 Line exceeds max length (81>80): "> AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 0 nosp 0"
56: B3 Line contains hard tab characters (\t): "	    //the sender to discard the message. (The correct transaction"
57: B3 Line contains hard tab characters (\t): "	    //value is 8)"
59: B3 Line contains hard tab characters (\t): "					AVDTP_SET_CONFIGURATION, NULL, 0)"
64: B1 Line exceeds max length (82>80): "AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 2 nosp 0"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/avdtp.c:896:25: warning: Use of memory after it is freed
                session->prio_queue = g_slist_remove(session->prio_queue, req);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/avdtp.c:903:24: warning: Use of memory after it is freed
                session->req_queue = g_slist_remove(session->req_queue, req);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============7320479412205916185==--
