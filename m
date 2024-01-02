Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064215AF9
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jan 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQB9O7Gd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d40eec5e12so68058055ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704223955; x=1704828755; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LbViYqgZmDtuhRpK/l1QdS42yHshjyxFX9FJUTABhEU=;
        b=gQB9O7Gd++oat8tnEZyPLCRjAqtiWy9M6KrOhjWc2bOIihnBV49/IpmIOCRWD9NnWs
         CXboQYnIOaB0XGH+La46R9fsuoLiFyKZrJLbONKw+1DTsLHljIixIfsSepcGa0Z/RGSh
         2HMI4D9eqIORl2+1OPALT+zzMakcPM669U9VkVlldRelZ0GHiXtfj7UWmSxRpoAyy9XL
         23sGfzAXPoIlZABkz7MzL538aAkvZguw9nn8oyKvUGWbdsIKV+UHz+X1UB7+cwQpdR/T
         YwZYhTwLKoX7Apq/mfWF/MSIViaFnnLYmk0RXCDV09Z/HqGeNHSCFTNhZLeRCWucT7kx
         6pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704223955; x=1704828755;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbViYqgZmDtuhRpK/l1QdS42yHshjyxFX9FJUTABhEU=;
        b=JX8AJza1LKBqp502ZUCFwSMG95blxMVk0+Yn3u0q6wCVCxUF/w9qNDWRwKcBtRXTgZ
         wk2HFy4dDlaoGWsAECZMTHpvAKw888WOERaLERlTnDzmbVrJWyLYUFjXGyueYNjdzdvy
         C+kpMOgpHZjlu/b5hloekjAZxo+5FVRpR1v6XjIVRohVRQGhW/gb5IF5fTQBPuSJ4XUB
         svOj4QR0ZoSknIXkCSglbfBKDaSg8NoHb2hjbsXDT4BbnHyo27lud1/gHFez2c5I4Vi8
         pggbNHcMGWYYgtINFkj0309kmw1tmkU6++8VKAKoJO8cxHFbRdy4DtIG4HL+yhy7I7+O
         iZBA==
X-Gm-Message-State: AOJu0Yxk9flJUzmWACp9+UUBCHexdfVvOUPG89o74s/rLSE+rxMKREtz
	lAHcZeaQve7vHOpHTiC8Xi/mlhG59KQ=
X-Google-Smtp-Source: AGHT+IGKzmnHe+x+dqxKYhc8/T0RvaTcwbeP/v0YCvMW7xlzFlN2NJNeMz+PjljBRYoqN5qWbYUPyg==
X-Received: by 2002:a17:902:b214:b0:1d4:3dfd:7e45 with SMTP id t20-20020a170902b21400b001d43dfd7e45mr16494516plr.122.1704223955192;
        Tue, 02 Jan 2024 11:32:35 -0800 (PST)
Received: from [172.17.0.2] ([52.225.76.180])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b001d1d27259cesm22949541pln.180.2024.01.02.11.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:32:34 -0800 (PST)
Message-ID: <659464d2.170a0220.410ee.2ee9@mx.google.com>
Date: Tue, 02 Jan 2024 11:32:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4432186124604478660=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Bluetooth: Improve retrying of connection attempts
In-Reply-To: <20240102185933.64179-2-verdre@v0yd.nl>
References: <20240102185933.64179-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4432186124604478660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813906

---Test result---

Test Summary:
CheckPatch                    FAIL      2.87 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      28.06 seconds
CheckAllWarning               PASS      30.64 seconds
CheckSparse                   WARNING   36.43 seconds
CheckSmatch                   WARNING   99.91 seconds
BuildKernel32                 PASS      27.22 seconds
TestRunnerSetup               PASS      435.07 seconds
TestRunner_l2cap-tester       PASS      22.98 seconds
TestRunner_iso-tester         PASS      94.14 seconds
TestRunner_bnep-tester        PASS      6.96 seconds
TestRunner_mgmt-tester        PASS      161.32 seconds
TestRunner_rfcomm-tester      PASS      10.76 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      12.02 seconds
TestRunner_mesh-tester        PASS      8.73 seconds
TestRunner_smp-tester         PASS      9.75 seconds
TestRunner_userchan-tester    PASS      7.32 seconds
IncrementalBuild              PASS      83.71 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/5] Bluetooth: Remove superfluous call to hci_conn_check_pending()
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 198fc841b667 ("Merge 33ba02027f8092a3b79e82372598867aac9f54ee into ef3a59b4541dfc255a914dc47880a3a28097dc7b")'
#70: 
Fixes: a9de9248064bfc8eb0a183a6a951a4e7b5ca10a4

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13509297.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/5] Bluetooth: hci_event: Use HCI error defines instead of magic values
WARNING: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 0 checks, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13509298.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[4/5] Bluetooth: hci_event: Do sanity checks before retrying to connect
WARNING: quoted string split across lines
#79: FILE: net/bluetooth/hci_event.c:2339:
+						   "\"Create Connection\" returned error "
+						   "(0x%2.2x) indicating to try again, but "

WARNING: quoted string split across lines
#80: FILE: net/bluetooth/hci_event.c:2340:
+						   "(0x%2.2x) indicating to try again, but "
+						   "there's no concurrent \"Create "

WARNING: quoted string split across lines
#81: FILE: net/bluetooth/hci_event.c:2341:
+						   "there's no concurrent \"Create "
+						   "Connection\" nor an ongoing inquiry",

total: 0 errors, 3 warnings, 0 checks, 28 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13509300.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[5/5] Bluetooth: hci_event: Try reconnecting on more kinds of errors
WARNING: quoted string split across lines
#109: FILE: net/bluetooth/hci_event.c:3265:
+					   "\"Connect Complete\" event with error "
+					   "(0x%2.2x) indicating to try again, but "

WARNING: quoted string split across lines
#110: FILE: net/bluetooth/hci_event.c:3266:
+					   "(0x%2.2x) indicating to try again, but "
+					   "there's no concurrent \"Create "

WARNING: quoted string split across lines
#111: FILE: net/bluetooth/hci_event.c:3267:
+					   "there's no concurrent \"Create "
+					   "Connection\" nor an ongoing inquiry",

WARNING: else is not generally useful after a break or return
#119: FILE: net/bluetooth/hci_event.c:3275:
+			return;
+		} else {

total: 0 errors, 4 warnings, 0 checks, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13509301.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============4432186124604478660==--
