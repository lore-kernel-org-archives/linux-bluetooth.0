Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWkERATl"
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B3170E
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 12:35:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28555b0c7afso1362789a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 12:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701376552; x=1701981352; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gNew9ry+Jir4lm0CXUBJd83jjEr03GCUijboBcMZJow=;
        b=iWkERATlc5tqYkcviNEzxQjXeJ6+ngbbT6m2bk8JaE0l2uM6R/cnG1Xxc62bH5hoMF
         GWq9QMxsTR0DoZjcTDM8p4tSTIIoQ9FISs0437sMkvNKm+IFzLoHtl5SYEtLtuQed3NH
         ySeROzDU+U1Uv9r3ehWF6BidkdZowf9JMR7Cn3yAyXn8q2NxlU/0HdtM08w/kABFXsGX
         /Fx0qNb/zjVha7CeeqstGnfjowWKIpBnkJdFQlOd1LCjdpGgOW6hn3aQVUWOgBR/+9fe
         4TY+0gaKkInNoh0X5PPHGw1nScKC6UWIi6Lmoe5wnRlo6TpcjwEK1AYs7pZ3VMkjmke7
         BLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376552; x=1701981352;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNew9ry+Jir4lm0CXUBJd83jjEr03GCUijboBcMZJow=;
        b=TujZHlp5uUaH3uOEkxUR1v2INMpwn8EsnPf2lXSl0minntx2IIAwJMriYGlz8Th4Q7
         eq1TKZ4ZiduEpID55RCRdRzmmSiZz7dFifahipj+GsivupL1M2ljIDswz1qq3SXLWgyA
         sxyISwDSgJTdPlJNpFWNRic+FOzfi6hftTL1LgJ+cVoozBCQewR8eQ+sQ0ztmld2JyjR
         RklmJMaHYCWJ3ZqVSP5cihqCxlHj8qFnAD2y5Rfv0VBBEzwgvWaT+HN0ZGM9+SIgkCP3
         IA/PDJ0t+LWukQA+131Dl/8thiAGYp2MXgk7xXyH0JsN8txQiWOAQkjHUIT4iFYKTkgc
         sJcw==
X-Gm-Message-State: AOJu0YwkKMTb+02xZvxbRitlzNm4nY00ryKlOAZc481n6t9mUwtA2eHm
	SL7z619FzdJZlpXeBCzf8/4lPeXIzFs=
X-Google-Smtp-Source: AGHT+IEZlgrIq8j2V2G8PERNjIRyl5Nc6rrGvfLIXZHa+7r1ZgH+MJ4/IKtnm+ltfGEuZZ7XJ6QO0w==
X-Received: by 2002:a17:90b:1e47:b0:285:b78a:dbce with SMTP id pi7-20020a17090b1e4700b00285b78adbcemr17962406pjb.37.1701376552041;
        Thu, 30 Nov 2023 12:35:52 -0800 (PST)
Received: from [172.17.0.2] ([52.190.187.37])
        by smtp.gmail.com with ESMTPSA id nu3-20020a17090b1b0300b002804c91633dsm1755051pjb.14.2023.11.30.12.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:35:51 -0800 (PST)
Message-ID: <6568f227.170a0220.6bfbe.5971@mx.google.com>
Date: Thu, 30 Nov 2023 12:35:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6752088756738912561=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/lc3: Add QoS definitions
In-Reply-To: <20231130191612.2295021-1-luiz.dentz@gmail.com>
References: <20231130191612.2295021-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6752088756738912561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805711

---Test result---

Test Summary:
CheckPatch                    FAIL      1.51 seconds
GitLint                       PASS      0.39 seconds
BuildEll                      PASS      24.94 seconds
BluezMake                     PASS      664.19 seconds
MakeCheck                     PASS      11.78 seconds
MakeDistcheck                 PASS      154.38 seconds
CheckValgrind                 PASS      216.26 seconds
CheckSmatch                   PASS      319.98 seconds
bluezmakeextell               PASS      100.07 seconds
IncrementalBuild              PASS      1131.18 seconds
ScanBuild                     PASS      907.53 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,2/2] test-bap: Introduce QoS tests for LC3
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#78: 
  Verify that a Unicast Client IUT can initiate a Config QoS operation for the

/github/workspace/src/src/13474875.patch total: 0 errors, 1 warnings, 992 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13474875.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6752088756738912561==--
