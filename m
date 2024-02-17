Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFCC646
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Feb 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129896; cv=none; b=L9HQdduTi8RxpXflQYWoMdRXm4gWVPH6gkWGLhlUSZi0lkmtOGLwq1lTYW0Lm9/yhzuCIF95045v8qLlNQFHGfj6L7HILv6jVosILoErdKscrzAKPxWgMbD2xkLVoZsQE3cb0vOT+nQmg9baueYb3jClwfI1qmmTGU9g61uDRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129896; c=relaxed/simple;
	bh=C9WytFUbyy+XjB1daG3av8dez1kFmKr3tHlAhyudxps=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VENBcPb7nRyp4XvmH5FWFI1OMqEW/iVjNfbyON4LEaOr/CxsGczVkHKrWY126U6lnP5On3ds5iGli2ZB5aNg6oPk/MuOJLkZGjm7gdHURofiOMWzb+ezU1pl3qETcqIuwNwFUth8MPDg47foODAUl2gwJngIEDAETlNFcIeKUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBeux7mV; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBeux7mV"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78717221b97so185714485a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708129894; x=1708734694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=loziqDTGk7WM8FWqxpIwcrweFxXaCHFz9eqA52UFUpI=;
        b=aBeux7mVLCEmNksR4AAgFlskd0e+3gEVCdJM07BB+zifo0YTufE9GIpyyw+H62CBHL
         +LyJXPXHHZhoULtqzMhuHDk5fuEiXG2fIhycY3AoiQMaRDtcAbKgfbtI9pitBYc6OU0W
         tkXHkdf7qKZIwIKft7ut8gaPtykfieqFi+/ex2uL4LJVXe4QKL8m4wHuWcRDznR/D5X7
         0Emjk0a1odqJ1xqbgYyTotEawC70sjcDzDa5IrJat249FsiqVyS7hiCvBPenYDcI4MAN
         Totsvgejg79HPot8Z1aR9O/KjVEglhAhz7K9CVex99qPiJLGp+x6mO6d0VgFyZe4D3WA
         swCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708129894; x=1708734694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loziqDTGk7WM8FWqxpIwcrweFxXaCHFz9eqA52UFUpI=;
        b=CRlzLx/c00tazfYFDH0c9ry9jI4k1mlYubZDeXPK8Fa8JuX02ca5oUkIPHbSfrxRRJ
         prJre1Sbh+OEpTjmcxNwCRAxUJVvAW/QgDiru8Wiviu8OiW/9R+tDsVoAr2wAkw20f/a
         0sqsunuQ8iyJsOcrKMFgXg7FBZLJjqbr5FRfEU2skLHVfRj2CC7cgIdBmIjIY9BGQcoa
         qxj/HzQP9kxb+uFzxz6BhM12yLm4m5Tt9QMox/9lQzCXV8xV+27CLUxj7lir139BgI2/
         BXlmLISHJJSvEb2RR9dc06+lYHd+0oa6SYkkXKL4F6mJaIc9xbs0z/2SK4f8Gg/SVc5r
         b1tg==
X-Gm-Message-State: AOJu0YxaUOiL4kiBOuC6q6/AXuulg6mACZQ56QvrdWE2cRHPOKhzJvue
	38/AfjU3t8dNk2Eeqz/is4OYyFA3wSW6IK1LOeY4aUfmLVaL4b3RGznASqUQ
X-Google-Smtp-Source: AGHT+IH1T+h6YWCKiNh9vHGtvCjBF+33oBja0wPkevBn5xNaHlUSgVfIYy7IQBTgEfiynXbhw4KusA==
X-Received: by 2002:a05:620a:4483:b0:787:24b1:eb7e with SMTP id x3-20020a05620a448300b0078724b1eb7emr9072544qkp.74.1708129893578;
        Fri, 16 Feb 2024 16:31:33 -0800 (PST)
Received: from [172.17.0.2] ([172.183.50.147])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a022700b007871a4b423fsm399097qkm.110.2024.02.16.16.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:31:33 -0800 (PST)
Message-ID: <65cffe65.050a0220.d874e.3492@mx.google.com>
Date: Fri, 16 Feb 2024 16:31:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1191494469206391333=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+emil.l.velikov.gmail.com@kernel.org
Subject: RE: Handful of build fixes and cleanups
In-Reply-To: <20240216-hook-fixup-v2-1-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-1-a6b192d1a6ad@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1191494469206391333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826966

---Test result---

Test Summary:
CheckPatch                    PASS      4.37 seconds
GitLint                       PASS      4.58 seconds
BuildEll                      PASS      24.34 seconds
BluezMake                     FAIL      12.09 seconds
MakeCheck                     FAIL      6.42 seconds
MakeDistcheck                 FAIL      34.23 seconds
CheckValgrind                 FAIL      11.26 seconds
CheckSmatch                   FAIL      12.22 seconds
bluezmakeextell               FAIL      11.08 seconds
IncrementalBuild              FAIL      2081.36 seconds
ScanBuild                     PASS      999.98 seconds

Details
##############################
Test: BluezMake - FAIL
Desc: Build BlueZ
Output:

In file included from ./src/eir.h:14,
                 from src/shared/ad.c:24:
./lib/bluetooth/sdp.h:22:10: fatal error: bluetooth/bluetooth.h: No such file or directory
   22 | #include <bluetooth/bluetooth.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:8511: src/shared/libshared_mainloop_la-ad.lo] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:4647: all] Error 2
##############################
Test: MakeCheck - FAIL
Desc: Run Bluez Make Check
Output:

In file included from client/mgmt.c:34:
./lib/bluetooth/sdp.h:22:10: fatal error: bluetooth/bluetooth.h: No such file or directory
   22 | #include <bluetooth/bluetooth.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:7801: client/mgmt.o] Error 1
make: *** [Makefile:12164: check] Error 2
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

In file included from ../../src/eir.h:14,
                 from ../../src/shared/ad.c:24:
../../lib/bluetooth/sdp.h:22:10: fatal error: bluetooth/bluetooth.h: No such file or directory
   22 | #include <bluetooth/bluetooth.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:8511: src/shared/libshared_mainloop_la-ad.lo] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4647: all] Error 2
make: *** [Makefile:12085: distcheck] Error 1
##############################
Test: CheckValgrind - FAIL
Desc: Run Bluez Make Check with Valgrind
Output:

In file included from ./src/eir.h:14,
                 from src/shared/ad.c:24:
./lib/bluetooth/sdp.h:22:10: fatal error: bluetooth/bluetooth.h: No such file or directory
   22 | #include <bluetooth/bluetooth.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:8511: src/shared/libshared_mainloop_la-ad.lo] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:12164: check] Error 2
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

src/shared/crypto.c:271:21: warning: Variable length array is used.
src/shared/crypto.c:272:23: warning: Variable length array is used.
src/shared/ad.c: note: in included file (through src/eir.h):
./lib/bluetooth/sdp.h:22:11: error: unable to open 'bluetooth/bluetooth.h'
./lib/bluetooth/sdp.h:22:11: error: using '/github/workspace/src/src/lib/bluetooth/bluetooth.h'
In file included from ./src/eir.h:14,
                 from src/shared/ad.c:24:
./lib/bluetooth/sdp.h:22:10: fatal error: bluetooth/bluetooth.h: No such file or directory
   22 | #include <bluetooth/bluetooth.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:8511: src/shared/libshared_mainloop_la-ad.lo] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:4647: all] Error 2
##############################
Test: bluezmakeextell - FAIL
Desc: Build Bluez with External ELL
Output:

In file included from ./src/eir.h:14,
                 from src/shared/ad.c:24:
./lib/bluetooth/sdp.h:22:10: fatal error: bluetooth/bluetooth.h: No such file or directory
   22 | #include <bluetooth/bluetooth.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:8511: src/shared/libshared_mainloop_la-ad.lo] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:4647: all] Error 2
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

error: tools/97-hid2hci.rules: already exists in working directory
hint: Use 'git am --show-current-patch' to see the failed patch


---
Regards,
Linux Bluetooth


--===============1191494469206391333==--
