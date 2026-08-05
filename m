Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818E42D753
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946643; cv=none; b=Lh0A2y0vQLDbP7ryR3gjsKRs+mVyF5EWIkz10dtJclfAODU3TDP05WzVrtmw8tKomvKsaJzTYrMx6t0L7PhvCvnV2H0kCiE1lbnBY/z0Z21O1hrxFOmSgVux80seBroqHnw00TkvSBe8kAa25BDG9n8ikN/BgrrOo7lD8Lu7rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946643; c=relaxed/simple;
	bh=oN5r9QO/96GkqiOIx/7HQg8YRClHpW6BX2v0BVFHHh4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cC3AUi8eVNdGHt6wa+f5cShZpkcGwSzmFvccr0B6o/Lc+Ns4b0cupG5F79ELfF6Wr6xQ9W+DZdkHTgoXtTvIbZneDh67Lz8eTb2tJDjIke/UIzfT2yuAVaIGIIiVAHk93mMV6OHUREfovAiGkYs5R4F/qF0qO2X1YyOSB0vwcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho5huzz9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho5huzz9"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8487088510aso1631048b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946641; x=1786551441; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aODsJeDnXhMe1D57aMxUa3QmyFhDni2A4Af2/jDJV7s=;
        b=ho5huzz96+yXFD+Yev4gAlldRkyrVXgCzadh6QzsN3OHA+DRrljnmihqy4QaXqzRh4
         wILG/6+MeeCy/2F/s59JKDEhjVhxXrZA8YxocuPbrEE/cVlezMVdP9LfIX1p8uNca4TK
         0ssph/ZAxoh51kXiiGiDNdltsM5HDADGqtlohYdbgubXN0awYJkxVc8d5TEsTkj72OkH
         Q6HAfb+PstV5OkBFJhP04cXI55lEP4PGR9j/EuyY9ovelMa99J/+gvp2a78jV1X5Lwll
         0YybnxDTeG2mGsATjnUlGXqYM0bjjb3Ob+y8QVKIA8YvHeo9pp7B1o6GIEvWOojqW8M0
         s1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946641; x=1786551441;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aODsJeDnXhMe1D57aMxUa3QmyFhDni2A4Af2/jDJV7s=;
        b=KnKtUsPZRI+UUQn8JaCq2C5h8Ydw5U73dKNJE8FMn2s7ax9P+XeY9WDqa4ZSZARGNp
         UCoCf88Z99Fu4FV9j5AByJT+8uJ/lJ8wCN9mablBJDoElFnPtVxajRKlyUQtiodvQRKB
         WooO/k/pqsMDkmAlHglTmfWSicorG3nGgFEyReV1uyDpJ3f/AQndKP6GKQP0htODaFqs
         z+Rnow5+rR8WDvuOxr60wCWIdNyJZTk5tLe7urwLfK1gQwGqvW6guAPMvtJq/j7CgYhN
         xD7gEUUQeumJ2xRh5CQf7NQBx/egMGHqzWmcHXCWYrye4GzJQGxUEj4OvUDAMPnr5ZK3
         Ntlg==
X-Gm-Message-State: AOJu0YykiBrG2IwRaQMrYiWlOc4+K0SEqfzoDs4jbqRKyiqGr75UQxdz
	dUPpJ4OTT43Vyh+atjN21Theq7lI+qac6bru+sIW/G8LXnoT5PDSVzuK0ie5OQ==
X-Gm-Gg: AR+sD10QfJD39maNiMwN8bNQWdDiQ9/AqDfEe35zAjUKzSeXZgw/nEPJaxjQ+COOJSJ
	WJbfG2Op9KDVF96RVb5fc2hNSpk1gBugMgYYLUVRpfNBLPECSLpq5z0EHsubbMMzfxFSSFOQ4fr
	C3VoU8MKKtqoyQsh7OEFZn9FsQ31eqCI35xdWtag0FJcErVd4cvBcn2D5BxZHvSiQ8KsuxXHFS1
	RzGDUSq59ozpkQYv2BAe00BEuPB7OJ2441ibBGnizdavlLIV3TOd377cqaVO9JRqVoe7ZX3qEJz
	c9CAYkj8RjmgRE7tgaFQMtfnFYP+ITxr0OlrUp9+fpuNzR6OoNaWUF1gvuPbGCilNJE3XbVJlUI
	XVVjHOh+hsdRVuxW00QB0Lk2tBmlSluSP2Z0hd1ll2G5hv4Wu4UCJE0q+mW9ab6UoJjSLcsedEa
	PbxhIdgLsBCnAnrHmyW2+auXZ/QabNwcVx95rPzKuf+2SMXFtGMzWXDkOi1GNkxjR4lTDi9sjPe
	7MrOw==
X-Received: by 2002:a05:6a20:6a03:b0:3cb:82de:b952 with SMTP id adf61e73a8af0-3cb85de816cmr7654960637.2.1785946641163;
        Wed, 05 Aug 2026 09:17:21 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be4dsm23362088eec.16.2026.08.05.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:17:20 -0700 (PDT)
Message-ID: <6a736210.d76d81af.2931b1.d85d@mx.google.com>
Date: Wed, 05 Aug 2026 09:17:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0742206284978535999=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v1] unit: Add test for sdp_xml_parse_record()
In-Reply-To: <20260805135228.2653665-1-hadess@hadess.net>
References: <20260805135228.2653665-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0742206284978535999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1140838

---Test result---

Test Summary:
CheckPatch                    FAIL      0.37 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      20.67 seconds
BluezMake                     PASS      604.70 seconds
MakeCheck                     PASS      19.60 seconds
MakeDistcheck                 FAIL      145.92 seconds
CheckValgrind                 PASS      232.61 seconds
CheckSmatch                   PASS      315.29 seconds
bluezmakeextell               PASS      103.05 seconds
IncrementalBuild              PASS      619.01 seconds
ScanBuild                     PASS      1000.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] unit: Add test for sdp_xml_parse_record()
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#341: FILE: unit/test-sdp-xml.c:58:
+#define DEFINE_TEST(fname)							\

WARNING:TRAILING_SEMICOLON: macros should not use a trailing semicolon
#341: FILE: unit/test-sdp-xml.c:58:
+#define DEFINE_TEST(fname)							\
+	tester_add("/" fname, fname, NULL, parse_xml_for_filename, NULL);

/github/workspace/src/patch/14732439.patch total: 0 errors, 2 warnings, 265 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14732439.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../test-driver: line 107: 53104 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[4]: *** [Makefile:10329: test-suite.log] Error 1
make[3]: *** [Makefile:10437: check-TESTS] Error 2
make[2]: *** [Makefile:10915: check-am] Error 2
make[1]: *** [Makefile:10917: check] Error 2
make: *** [Makefile:10838: distcheck] Error 1


https://github.com/bluez/bluez/pull/2378

---
Regards,
Linux Bluetooth


--===============0742206284978535999==--
