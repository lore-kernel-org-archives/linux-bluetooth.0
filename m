Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6133C50D
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370599; cv=none; b=RMpRVuVWjqWN4Tq63313QNfVSaBQNk3oOAQim14OD1uMVYPCHqoV7OeF/Ydh42lv94lJHbr3lBsl+LL76ava8u4whWXyG5h9hVyxKFEt5zNype0PyBKOH62UPYCghHfMm09Yr0SP24aGjqXaa3m6geiCe1D2KF/kVgge8FkOwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370599; c=relaxed/simple;
	bh=mj1EPg+h4iJV0U8d6eMSF+yBuz3B8v0QqcJwMYN1lqE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KSfxwA9IO61gAyZDzFQTlN9cRmhmGCXTM9OsL3H+zIxBAmDpFq2s3+Mlqk6H5yQ2aa+PZMOoZxkgrA+yR1mWwDIB68syl4Z6nnDg/QU8s0/uAyzPLWJ3+DFpX40P3gQ/dZ6NjyL+oXGjbHf8kumdvOGQUr80T9C0L7EpWIqsajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo5oqOgN; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo5oqOgN"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1384eb94d20so2755681c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781370596; x=1781975396; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tNSHuC5VozanKDn3DflCZP6FMf69kz5jjIHpeTt5TpQ=;
        b=Xo5oqOgNFsY6sf7pwVnufATbP5M/4RJYE6lR+31RdCqA35od+F13hOyDom0ox+hJwH
         GAe0KnfD1m7avyswmsShqwplXRzK14EjGgk2mWnE3VKEVUbm5Kv4H4CrLoRHhkGdeH63
         mpTyxRnf+hzXV84DyqnDVxTB6b8rP+UseGMvr9XjSwIRhCbBt1gOxjZ4bs2rwaLdZVaz
         KtjZgwj2X9kI9/UG+gs6yjzWrH91ouolzhA5+N8V1aP4eHCHlBbWT/xulE3gyMZFL2w1
         7OHSgLRoEWnZYFFEZFlGkvsAr3zpNN4HUUuKIAYn2EHUrKDKePAIUsBkQ/VJbpyt2xxq
         c3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781370596; x=1781975396;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNSHuC5VozanKDn3DflCZP6FMf69kz5jjIHpeTt5TpQ=;
        b=ogMUTBreHr8XKXXPu3Mf71cd4lFKfBrK7nTgfeW0K6zso4EpFP0nH9q2ZQn6vW2o2Q
         NsiT9ndDqNEq7STxLWJzWEqd4A5HQWKUxyht/WDFiWQkDo2HoXi/CUR+Y34ZTuxvgopt
         s4b05SmDLiSF4S7mYcmKOdEXnIu6pSEXMyHEeKm2A8kkHDwKPj2xv4AWTHHgvgpgOg+P
         bIQn9k9ENDIb16F9VQG59XZ5B6QYTmGvPHbgvrOrr+YR+H/iFMkWO2RMOzSLNbbFLeo3
         /ijK3pFmvSpoY8Grg79M1+n00eBqmM5NWEAab6aS/BMRpJDNKMx/UgxxIQiAgvoGomHU
         Sa8g==
X-Gm-Message-State: AOJu0YxriqiFSLKqrjgg/dKxtkjnECA0I8JxsNnUO8G6vT2oEgGAhz/2
	K5489tZTBqNi8PQEOb0GmYazD95p1c/qgE32l1WgkHHVRPs6LuTVvho2/l+Qmw==
X-Gm-Gg: Acq92OHIEeH7LOjQz2zao1IqQ63shAOr8xOCpE+JXGbTuFXipWccY8jgoDX9HLL6MfF
	acY8qP15KKYMdSxpBEOY1yIXBIWfCnzJbboQUGcdg4AVn1CPjZLD91sDk80IVYc2DYjNUxw8SmI
	RnuSTZuZzQj1qqOkKf8GNlccXXG6PNz/zdl4WbNist6kplJmwwkW9bxsaSBTGJTe47s5BoMQBA+
	ErgPig79PulLSgPty4tQbpwIT6Xqizrl/lQy3FICs8ZtanLa86BeUQ8dhOhUMlLbNRBmKpGH11D
	wHlGojQOCGtyzldPWgduCFmjd3FPKwnB4K0n0c7efERSXiXXMMFzjl7d83OXFCafweLTzAeMeTB
	5ySASgA9Rp9JN3Y53U7x18HSo8D9Ea/mUsTBZLMal2QfTAwaSX8eHcJklcyieHtW8VsuKuWFPnC
	/+BKhY4oHzF5yLnwHVaO73CA2/f6BVBz52TBAx5OgkbQ==
X-Received: by 2002:a05:7022:6b86:b0:138:e4:c601 with SMTP id a92af1059eb24-1386f37eedfmr2031352c88.24.1781370595428;
        Sat, 13 Jun 2026 10:09:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.153.130.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b916b2bsm5409095c88.6.2026.06.13.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 10:09:55 -0700 (PDT)
Message-ID: <6a2d8ee3.396644cf.3045c0.f16b@mx.google.com>
Date: Sat, 13 Jun 2026 10:09:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8169127342196132355=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Functional/integration testing
In-Reply-To: <476910717b76052dd8d3673b92b00bc9c628b349.1781365708.git.pav@iki.fi>
References: <476910717b76052dd8d3673b92b00bc9c628b349.1781365708.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8169127342196132355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111076

---Test result---

Test Summary:
CheckPatch                    FAIL      2.09 seconds
GitLint                       PASS      1.46 seconds
BuildEll                      PASS      21.37 seconds
BluezMake                     PASS      624.17 seconds
MakeCheck                     PASS      19.31 seconds
MakeDistcheck                 PASS      238.73 seconds
CheckValgrind                 PASS      276.72 seconds
CheckSmatch                   PASS      328.01 seconds
bluezmakeextell               PASS      167.45 seconds
IncrementalBuild              PASS      644.71 seconds
ScanBuild                     PASS      973.07 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v6,2/6] test: add functional/integration testing framework
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#422: FILE: test/test-functional

ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#449: FILE: test/test-functional-attach

/github/workspace/src/patch/14627534.patch total: 2 errors, 0 warnings, 279 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14627534.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2228

---
Regards,
Linux Bluetooth


--===============8169127342196132355==--
