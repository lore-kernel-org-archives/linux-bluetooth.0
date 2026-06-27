Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F770836
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782589201; cv=none; b=S5gPm6JWZ4rorecJ3o2FMnqrvgxfhqGGH37bdfbty/wam2vgHUG2t6Dt/82UibENiEp6WG5jwDeszryfLARgP6qhcnZeHEpvYpoY4ROQDbWU1LpTdSFLUfxRzVwUfNpW4aSS3pdcRNRHy7JAkL2rkCaB2GQZTpXlRovRoNUaqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782589201; c=relaxed/simple;
	bh=QGRA4Val8MCsX4hPrPgmggNQj5rLjhIFHZS2SGDCYc0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i0yib5V0DrsiNGEfYQjLooDXdMJ1RComKiMIAHayNSRKR5GqR/TsXxRSJl4zLPuNeRuLd1roUfZJ+IGqwtJGN6VMPJu8iUrLF36ADRBjbBu96FVZk4ZHc3QgEJsbY62+vQHS0asfjnZ/Xsj1uvrFGXJ3W1qfcctpNN67UINv6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkZcwtba; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkZcwtba"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so4415393eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782589199; x=1783193999; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VyQfx6k1ABvKifMImPLbl7u5B15qm8IuM9WrvlvcbVQ=;
        b=EkZcwtba6XT+QeBlULCADY1RgR9tT2iMCYxLWJhQQkEoIZqWKi7vcKvV0QFqi1GnNK
         4Aviy3vatz0jY0qa2ytqlbUoVTs+u/JIn/JAUPjdINgdsE0dlcyjaAlr8Kanb2eEFK38
         4/V0w6Ka22ZuY6qRI6Ivz0SbWWrwX7Ye8+a0fhgNWshMyaYZMS1epJkjxow32sTT8ACg
         gVj+6/RSHnj1ruiBCcgDe+iWnjhc0HNwZrgysul+QpJO0kQ0dzuQxHiBcoVIlS/uhmoM
         CP3a14ETj9OqwUiSjfMGFmCvRg0vt/Oz5Ui75W4nRfJsGrmPKJMsIcMosPYkKi9dNl6x
         4xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782589199; x=1783193999;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyQfx6k1ABvKifMImPLbl7u5B15qm8IuM9WrvlvcbVQ=;
        b=Dc1zLfE4TaJkYRNSUyaieb/2GKQ8vKB1DyvlGfER7myTzWB0fKVBDPVt2XxUPC8mwj
         rGORWyDykYZbfQkBavAN7xqhuLhPd09VPiWdRdEMHvLmaH24vfKcCnB/WTLpXyWzqsNW
         mUF0a9HzBlQvxXNYmkyLlguslHRSl0wFRYKHpttGMhw+YVoVyig+FCeLHkr++TtEnjkX
         cZZowWi70Dh/7xmoaiCiUGSEhcSFO86RQR2eGh9FAJnMzfObTpNOC+zE22m3bClNX3an
         HLaxB6eiUllEXxM2oK/NJeet09avxaOkxzOZU10KEc2ApjefNbGyAycqalqap6Wt3RyQ
         weuw==
X-Gm-Message-State: AOJu0Yw64H4bJU/yFp4jqyttVfMeUifsDkaFOt83TeF8+mWi3YNmt4/o
	9sI6y67qHrzx8SFjuAmjLZUHUff4cRKHQzhnYUz4GlL42JDWL9jOoZ0SszE2DA==
X-Gm-Gg: AfdE7cmW57d0FgwlL+ot3XRVJQLTVpcd+go8pcjzvVgZBuEyEyfGU7PhYUxEVouMEpl
	RNKuet0mOOBUBVSC1wUNbI2Gv9hepf+jcOxPvGIFmv6Sb1yG05Yc6AEYviNBgFH2WJnkXv+Q9/7
	TT+K6Ff18wrniNMkO9qmqR4dMgx9Em7+ljQr6wF44QosmMVQ1C5XHvhMR5xwLc8LnEBe9wiaHX8
	5tGteMjvkR+tRAnMAa0QWe1cVS6vZsVzhVMtKWqVmi06iEFYwsExtWuc+U2qZQh/RuIJ8apJCLV
	McHM2JX1Z1uBA0rbPPJgS1N+815W5cjaGfzap8DDFNNuwRWifsg3ZT1SltTLeU4/wbtbJa8NtVP
	4Pltj07kQJd98bxztj/xfPAGnz9j2sUcRT1mDCX6yxItJrH9FqN2V42aKk4cUd2tS6hvWc2d79F
	8ZuUjGNt7GYJMbo/hKIbo8dg==
X-Received: by 2002:a05:7301:2a24:b0:30b:f73f:ff6e with SMTP id 5a478bee46e88-30cab06e5a1mr5097330eec.11.1782589198739;
        Sat, 27 Jun 2026 12:39:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c199561sm36550810eec.0.2026.06.27.12.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 12:39:58 -0700 (PDT)
Message-ID: <6a40270e.510f576d.1293ea.d44b@mx.google.com>
Date: Sat, 27 Jun 2026 12:39:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0606638181227351748=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, matthew@matthew-cash.com
Subject: RE: [BlueZ] profiles/midi: Fix zero timestampHigh
In-Reply-To: <20260627175712.228564-1-matthew@matthew-cash.com>
References: <20260627175712.228564-1-matthew@matthew-cash.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0606638181227351748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117512

---Test result---

Test Summary:
CheckPatch                    FAIL      0.87 seconds
GitLint                       PASS      0.48 seconds
BuildEll                      PASS      20.81 seconds
BluezMake                     PASS      557.39 seconds
MakeCheck                     PASS      1.01 seconds
MakeDistcheck                 PASS      159.80 seconds
CheckValgrind                 PASS      159.07 seconds
CheckSmatch                   PASS      313.75 seconds
bluezmakeextell               PASS      104.20 seconds
IncrementalBuild              PASS      554.95 seconds
ScanBuild                     PASS      991.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] profiles/midi: Fix zero timestampHigh
WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#123: FILE: profiles/midi/libmidi.h:86:
+	bool timestamp_high_set;         /* timestampHigh read for current packet */

/github/workspace/src/patch/14648381.patch total: 0 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14648381.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2255

---
Regards,
Linux Bluetooth


--===============0606638181227351748==--
