Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E650E54E
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Dec 2023 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERM4Y7HR"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc025dd9a9so1233005a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Dec 2023 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703777361; x=1704382161; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O8mb0bgpB6LeTciedX2cDff/TsIcn/L4z53jF746fWk=;
        b=ERM4Y7HRNSzIfFs4ea27Zvjt+6mpNTgsdAY6vPItMs3uqZ7NsPGPUB8lZk3nCTIrK+
         lU+r5YKosEVmOLAifgHuQ0ijUi5PtvyYgDRhhHmSj1gEx55JRiAFi9KfhvCc/rXjavQu
         tz9ndw9wq/jEHvBKEqVuTsPbWrEmS6gy86kG6PGKnKjsQ1dDa3k0aK4tZkEDz6quV/ac
         I6Z6B7W5j7Iu2JrMEKT1mIzO76etihXV1jK3XLtzjzbDWWJZ9QWli3pkhKgnXyZnffC2
         Xv8AMsbXgUbQ9a94jcunjuHkdCM357AttSuTVQggqNSVgbbuspmMcsK4jaEzo1QYEQsj
         1szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703777361; x=1704382161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8mb0bgpB6LeTciedX2cDff/TsIcn/L4z53jF746fWk=;
        b=KSQHGGLpooeliUPI7YjeGPW7KPdbuE/GvQNmRMEJZcseV1JsBCDgGG4krAelxeAW2X
         ZrB4U+56URr3nyOQtoGVaMlIPuSCQudeJW7QKpgva5EqAdPKHVVIJZ4H2zM0jLZh/pDW
         chzT162WSFP2HKNELF44HJFj/Ajr/s6E1Ulid8kPlIeMjC2v9yx60QXTDCpo2gOT8zV9
         dMkB95ME75ODXzE12jkvdFQaw//LoRG6W8mp+X7lZtUxDRyDmOoPggqRPD2MVBE7z7Lc
         hAkOfbYj+rZA0XVSBx09Ix7GpAkmYdLZTZ97VUvpYyrPEVuEv7P6xXXLx1IIr3WM/uZq
         oL6w==
X-Gm-Message-State: AOJu0YxawN0Ui+OpQettnIYVbyiv1DT5/OfD2UzkjgRHOdhH1CcAmWhD
	hRC3TgLrH5E/xTLQ7Tk6PCEcIBWK15M=
X-Google-Smtp-Source: AGHT+IFew9bBGqZXoDDEgL2lX+iYMYkSyqk7aW88XLCgSmM8kz/eJOFc5qCUSZqlubuh/axRd1T/Uw==
X-Received: by 2002:a9d:6acf:0:b0:6dc:a35:33b2 with SMTP id m15-20020a9d6acf000000b006dc0a3533b2mr1800086otq.36.1703777360983;
        Thu, 28 Dec 2023 07:29:20 -0800 (PST)
Received: from [172.17.0.2] ([172.183.107.250])
        by smtp.gmail.com with ESMTPSA id l8-20020ac84cc8000000b004257bf9a394sm8131191qtv.14.2023.12.28.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 07:29:20 -0800 (PST)
Message-ID: <658d9450.c80a0220.a8893.8ff4@mx.google.com>
Date: Thu, 28 Dec 2023 07:29:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0710867026313901671=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,1/1] avdtp: fix incorrect transaction label in setconf phase
In-Reply-To: <20231228135206.1949453-1-xiaokeqinhealth@126.com>
References: <20231228135206.1949453-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0710867026313901671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813236

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       FAIL      0.51 seconds
BuildEll                      PASS      23.65 seconds
BluezMake                     PASS      713.42 seconds
MakeCheck                     PASS      11.68 seconds
MakeDistcheck                 PASS      158.89 seconds
CheckValgrind                 PASS      221.11 seconds
CheckSmatch                   PASS      325.32 seconds
bluezmakeextell               PASS      105.56 seconds
IncrementalBuild              PASS      664.10 seconds
ScanBuild                     WARNING   919.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] avdtp: fix incorrect transaction label in setconf phase
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#68: 
AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 6 nosp 0

/github/workspace/src/src/13506075.patch total: 0 errors, 1 warnings, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13506075.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/1] avdtp: fix incorrect transaction label in setconf phase

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


--===============0710867026313901671==--
