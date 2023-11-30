Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf7hjUPq"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D82112
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 13:00:39 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a16594723so8381626d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 13:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701378039; x=1701982839; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wWRLdOhsLCapYZx2DA2hn0dtm0FC+EqcbJqaUVWRYJc=;
        b=Mf7hjUPqQ87jzyX6PWTFUNiJV/UECYRR5w4ow6+c1+QoJO3uA66cwuMUHyICiF9QYz
         AA0F/+CUSa98AA/8EEATz9xPS8NhngxVWYg+tYnmi5yYECIxnYFq3RT2KmixOvpkK0mF
         SG1ZxH9S21eh1ltBA6ILDSvNQ4mpdT+rXte8M/BHmmxoC80+luigJhYcJiuLE+DhbyXl
         FbkkeDNBKimEnZUVPO8zGYYBhDVP2X4PI3YMqzPCN531YsQd6rLlSumKkOkoRe5WTqr3
         AjMifRXt+Mk1BktC8WTYLXRZL5XFNOQJMr3VG0TkSmelsyJNgQmyvbWtXi3NjbyHpLOF
         Dlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378039; x=1701982839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWRLdOhsLCapYZx2DA2hn0dtm0FC+EqcbJqaUVWRYJc=;
        b=M0tPjGMrfezdPbf3654TKUUJ9JpoPl5aAT9UBlOPn2b1VkPTZ7zcdShcs80QSmpO9V
         Ci36x46L2EcM8V4tiqReZYxaX49GZFXHpr9rxXkkgbvbRUIkLYYYAOUzkLWfjEPfWsGK
         R65ziLcRKOFvD2Q/11HbPaZJt3S812A0CWdMxdTJpHYsELRPc68liZ/gzsgygxpAo8CF
         YD+krKAUOoJOlqxhcGCdudpXM2AqupMKpuy7mWitypD5qT8wG+FOMGTxlPrHu8tRDLiL
         HuBc/OK71vORvdA/5hqYuEb7IBBW+Vr/Gt1HJNup4s3LphKRadP3v7K8agi4oCwbEFmX
         jm2Q==
X-Gm-Message-State: AOJu0Yw4q/34ZAZr4mXfX4GflICesebIx/4/kcNYc7j/Avc5doqmclA5
	KaGNSLMUMZr04zk9u71kUS4GLvNySxyrCg==
X-Google-Smtp-Source: AGHT+IGxyP7ooBKGRZJf1wb34ZJa6wSlxNlkpqrCHa/KxcmEXmWQx6eDTk4B3F0wWRoxZ0ooFwGwQg==
X-Received: by 2002:a05:6214:5603:b0:66d:1f11:8b85 with SMTP id mg3-20020a056214560300b0066d1f118b85mr23324191qvb.13.1701378038669;
        Thu, 30 Nov 2023 13:00:38 -0800 (PST)
Received: from [172.17.0.2] ([20.98.59.223])
        by smtp.gmail.com with ESMTPSA id g9-20020a0cdf09000000b0067a4a2faa0bsm799539qvl.144.2023.11.30.13.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:00:38 -0800 (PST)
Message-ID: <6568f7f6.0c0a0220.b6f23.4557@mx.google.com>
Date: Thu, 30 Nov 2023 13:00:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1819082772171125047=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sebastian.david.forslund@gmail.com
Subject: RE: [BlueZ,1/1] Pattern match on service- and manufacturer data
In-Reply-To: <20231130195750.1732-1-sebastif@axis.com>
References: <20231130195750.1732-1-sebastif@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1819082772171125047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805736

---Test result---

Test Summary:
CheckPatch                    FAIL      0.69 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      547.23 seconds
MakeCheck                     PASS      11.02 seconds
MakeDistcheck                 PASS      150.22 seconds
CheckValgrind                 PASS      208.72 seconds
CheckSmatch                   PASS      313.95 seconds
bluezmakeextell               PASS      95.20 seconds
IncrementalBuild              PASS      498.95 seconds
ScanBuild                     PASS      904.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] Pattern match on service- and manufacturer data
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#89: FILE: src/shared/ad.c

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#173: FILE: src/shared/ad.c:1434:
+		queue_foreach(info->ad->manufacturer_data, pattern_manufacturer_data_match,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#179: FILE: src/shared/ad.c:1440:
+		queue_foreach(info->ad->service_data, pattern_service_data_match, info);

/github/workspace/src/src/13474975.patch total: 1 errors, 2 warnings, 93 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13474975.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1819082772171125047==--
