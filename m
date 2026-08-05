Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377E47CA73
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946420; cv=none; b=bE/CuVUefl8OIt5i4qlpJttQmqz34ZIcG2ersqX8BvSCXR1XkvXnu/icksOjFPS8k1Uz/qWNPJoeiiFqcIWChDA6OeTKXw994ETul2VOS6DKakw9x0vFLoC1ZfhtS662bpzjlKJ1J/IbNEHfEXpasDE7X3OOXURZgOXfgzzJEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946420; c=relaxed/simple;
	bh=c9Wkczl1VmQX3XUPhZoyM5bru4XqGzsECr45dFOxtpk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cGQLn9U3MTVhXOq04cYdrb8Z9bjXgYMXFP1MhJpM8nhwOwObWKjASdQm1CJmS3jnNSPdEbcebUzugDAwwQbV23sRUw2faTnsuRPl4LnSny4DhgQfYUZDm1Afi4U/7nSIJU1vPRFERBsREOPLOB46Lt7GXy2bU5JjTeMdn1Bb8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leMp8r+6; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leMp8r+6"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90004d2f7b7so12257046d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946412; x=1786551212; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LKFYJh1+kuUkw0OP1kiDgmfxdZlNemT0HyRvYQmTX54=;
        b=leMp8r+6VRP5tdWAF6VuI8XQpQ6m1Z0teJmSk5DRKSEt9LJRDkreEng4sZPLeOJe7N
         Bcn3+8erpcwAjG6Ri2UpNvtmccigxI6aw1F3TglZAVWugWqbT2fU3NogfXAP5pW7M2kP
         tYU0NKj5EZNMZcmgyk9bpMVB0bRqFoggR2b/6At3Bzrcy22lF6B9XVBfG1qQq3rOlhxW
         tV3lbwNp/W72lc0OsaYPhY/+LPAJsFeRILHVqIApTHuMJ2EWjOmFMBbW+umPd/5MC4Nd
         s4fF6yUFcP3G1UBGhu4+BHuUpuFArCeBzDM9V99xOK/Mo63z6ThjDbkG5iDFMoQorJvT
         bxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946412; x=1786551212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LKFYJh1+kuUkw0OP1kiDgmfxdZlNemT0HyRvYQmTX54=;
        b=IX39uGa4xcQ0pGxXd6gaO82uR/tOnhtmEpiJezMjf5+RyCQI/O8f+qbPyEEGnEYbmw
         AvYgHySvNn35YhkiLwzodC8/6uqmSCSUk7UmM4D68xM767DLP4ioNsmFVer5it8RABd/
         SntsxCGyqPlU+nbaytCadRZGUKMYApUTHflsAWBmBS63QZeGCSMnX9Gwc6zY0NY+IVym
         FTnJQHcGg/vwoE4eya/CfIxr1fv23T/FYWRnLn3zb7NN/ROJrFsAaLRBJPosPvREmvLL
         h5OKVSDTHo4tLaaXa1YaYkajfJXb2zPA61jzu4XXT7lerURHRI+bX+KDUp7suMnlJ/+7
         /kYA==
X-Gm-Message-State: AOJu0YwoozAn49kvRDztppgYtl0qmZk+oOXlVYz5FmbWdBScQKv2F8O3
	XZwUfFP5KmhwZAUUDZCoZcVAfOWbuKCPK/L1WHQvc+B+8CAia3hAItfVas/thg==
X-Gm-Gg: AR+sD11eAX6rHdCfr3zGl0E2/C6duQjvyp7v0DuBXi4DuezqGfl9zmBcfhwq6HiNXR5
	0tgt8KKQnaLFa8vni0ok5cX06paGcUSuyxLYe8XSwH8CxYKKnCw/6Lky1ckvDT27rJs9yFL3j16
	FM0ymPvTvcAyejuTn658PL2QtcEXQgap3Fnuu2v3FM1ZMZj2u9Mo8nvIYpZxuIGl6U1iQ5V3v5N
	mIv24Bo9l8hgHJk5OxDsL4dKoB6OyPdwj5mjtyzpZLte2xyDwiXYrz/8arCK44/8Vkm7RTssWCn
	EYawl3vsqtIpBcTBcdloW1NwQiS++XKXf6nDwDnBsiZ9t418KvRIvAeY1LSgAhXaBpDY14bXO5L
	fGtIDxWcaLL/zCFXqWkOfqj0HjU7DoQe8oCvvvtPrMuLYZkaa81EwtnNQIOw4bzYNCVjmX5MBU9
	EPWX0EK/FUKkN6DrKw3ZskJDWXBFBlW5aL58pXVhCKoJCv6omRvKeQg4/bBVKHzH0U52Y=
X-Received: by 2002:a05:620a:a811:b0:92b:8a7c:f71e with SMTP id af79cd13be357-93649074964mr644206185a.15.1785946411784;
        Wed, 05 Aug 2026 09:13:31 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.227.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a3fc836sm184979285a.2.2026.08.05.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:13:31 -0700 (PDT)
Message-ID: <6a73612b.3f8fff0e.33696e.dea2@mx.google.com>
Date: Wed, 05 Aug 2026 09:13:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2883308396014213662=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v2] unit: Add test for sdp_xml_parse_record()
In-Reply-To: <20260805150327.2669078-1-hadess@hadess.net>
References: <20260805150327.2669078-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2883308396014213662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1140873

---Test result---

Test Summary:
CheckPatch                    FAIL      1.01 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.94 seconds
BluezMake                     PASS      565.15 seconds
MakeCheck                     PASS      18.82 seconds
MakeDistcheck                 FAIL      137.78 seconds
CheckValgrind                 PASS      224.92 seconds
CheckSmatch                   PASS      300.38 seconds
bluezmakeextell               PASS      97.26 seconds
IncrementalBuild              PASS      589.94 seconds
ScanBuild                     PASS      882.87 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] unit: Add test for sdp_xml_parse_record()
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#338: FILE: unit/test-sdp-xml.c:54:
+	path = g_build_filename(TOP_SRCDIR, "unit", "sdp-xml", t->filename, NULL);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#350: FILE: unit/test-sdp-xml.c:66:
+#define DEFINE_TEST(fname, res)							\

WARNING:TRAILING_SEMICOLON: macros should not use a trailing semicolon
#350: FILE: unit/test-sdp-xml.c:66:
+#define DEFINE_TEST(fname, res)							\
+	data.expected_result = res;						\
+	data.filename = fname;							\
+	tester_add("/" fname, &data, NULL, parse_xml_for_filename, NULL);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#351: FILE: unit/test-sdp-xml.c:67:
+	data.expected_result = res;						\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#352: FILE: unit/test-sdp-xml.c:68:
+	data.filename = fname;							\

/github/workspace/src/patch/14732555.patch total: 0 errors, 5 warnings, 277 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14732555.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../test-driver: line 107: 53128 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[4]: *** [Makefile:10329: test-suite.log] Error 1
make[3]: *** [Makefile:10437: check-TESTS] Error 2
make[2]: *** [Makefile:10915: check-am] Error 2
make[1]: *** [Makefile:10917: check] Error 2
make: *** [Makefile:10838: distcheck] Error 1


https://github.com/bluez/bluez/pull/2379

---
Regards,
Linux Bluetooth


--===============2883308396014213662==--
