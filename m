Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dua5Q1Sl"
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04D693
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 01:56:59 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-425c9cd7dd2so22366021cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702547819; x=1703152619; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7gzd+lcxcRTvfDLfYkvRjoNxlBplkGwAKIv38fpnUoI=;
        b=Dua5Q1Sl8JIwssZDCubNbd38DWaL24BEHGULAAT3PO2n6n9ybZWCrlEQLfWRZTPTL8
         cxh4A+PGRxDr5JIwQR5f14VD1bb+k3wMFBNDXggUP8bNSEjL93jGOXNB3JNumNsVGuej
         SO3VW2Sjexq/JWrF2yf9/9rxxdLFo7CDnfBvToZNXntfYhkJDzjErFGvIIoArhX2rwgX
         wjEe3Jp8VULYe0IeK5OuVOIw/L1RN7Vf9ZZbrF7XxL6a0CRPxDwFEOVgUX1FUH73s+sN
         FLkYQtrkoKpb3Z5t5+KmTyr5Dsk/CWWZVmHjUW3Jd3pShDzA0kTIBJkPXpAKhLmqmONB
         qJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547819; x=1703152619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gzd+lcxcRTvfDLfYkvRjoNxlBplkGwAKIv38fpnUoI=;
        b=tZrRydSOfegPrVuUKEKY/NW3mHzbS2gRd9IZyHACie22VRfFJ82a8tIe8lfLsZBhtc
         OspF5Ay2QwLAdisjYxx/tBPz4/Z8KIzh8fa3cVD7Lf4c/YB3jyDnvGsBt0853ewXUe9J
         IremMYxpX9aUI5HncC6OGiIx3+uvfDEu3w5HL745wOXhzXjoKRknXZaOGWZOlZceporJ
         8urJ+r9+WzF3BO8nsPGleDsFrf+GVJOh7LgoEAdBmrPQ9MxLWB4F7kP8EdQCPOq8jl4s
         4pO/Ei5VWuYK8dOYstVd+z0WXG9Z55SOMNA9PpQatHym1lF3K2XDnu41fWyVxLz3jU5X
         anpQ==
X-Gm-Message-State: AOJu0YxPj2b/s5sFV5memMbLz9PpZR9keflvwSHGHUv+UTS5vwxsiIau
	gYQtm8vgXE6zX2lTZrm01ZCDGTvpQLkR3g==
X-Google-Smtp-Source: AGHT+IFA1QeYk8qlHj36IbyCAS+YV0T/P/g6ZGTCXY86R8sVAmyrQUtbbn4RUQCwzEC22Cd2UPaeUA==
X-Received: by 2002:a05:622a:13:b0:421:c3a9:1e43 with SMTP id x19-20020a05622a001300b00421c3a91e43mr8653794qtw.56.1702547818709;
        Thu, 14 Dec 2023 01:56:58 -0800 (PST)
Received: from [172.17.0.2] ([40.76.119.139])
        by smtp.gmail.com with ESMTPSA id o8-20020ac85548000000b004257bf9a394sm5614166qtr.14.2023.12.14.01.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:56:58 -0800 (PST)
Message-ID: <657ad16a.c80a0220.e4657.e618@mx.google.com>
Date: Thu, 14 Dec 2023 01:56:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1556073284595084125=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 15013537245@163.com
Subject: RE: Bluetooth: hci_sync: fix BR/EDR wakeup bug
In-Reply-To: <20231214092255.1018859-1-15013537245@163.com>
References: <20231214092255.1018859-1-15013537245@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1556073284595084125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=809975

---Test result---

Test Summary:
CheckPatch                    FAIL      0.96 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.56 seconds
CheckAllWarning               PASS      29.75 seconds
CheckSparse                   PASS      34.91 seconds
CheckSmatch                   PASS      98.52 seconds
BuildKernel32                 PASS      26.37 seconds
TestRunnerSetup               PASS      413.84 seconds
TestRunner_l2cap-tester       PASS      22.71 seconds
TestRunner_iso-tester         PASS      48.05 seconds
TestRunner_bnep-tester        PASS      6.95 seconds
TestRunner_mgmt-tester        PASS      160.64 seconds
TestRunner_rfcomm-tester      PASS      10.93 seconds
TestRunner_sco-tester         PASS      14.39 seconds
TestRunner_ioctl-tester       PASS      11.79 seconds
TestRunner_mesh-tester        PASS      9.62 seconds
TestRunner_smp-tester         PASS      9.78 seconds
TestRunner_userchan-tester    PASS      7.24 seconds
IncrementalBuild              PASS      25.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: fix BR/EDR wakeup bug
WARNING: 'comming' may be misspelled - perhaps 'coming'?
#51: 
has hci mode change event comming,it cause controller can not enter
                          ^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13492648.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1556073284595084125==--
