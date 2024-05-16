Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5406156C7C
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715884098; cv=none; b=YiRnx8ejBkHsF93HyBZOzkJxzcfAJiZsTZf3MdDnGYbkEOIH/n7JN5hAypsLWK2/sAxZ2/o9wAaIuaq9AdeF/1aY6Nau+wyMP1dEfWTt+HsF//hNEn0eqqxZDmuVbV6m0TUoYripp4cGYrGebANfcjFtgI03Y0U3UkavraWHOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715884098; c=relaxed/simple;
	bh=1COew3QEWWCnn2Gct0qqGtiJp06dQPf5aRvQ1KOB0ik=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Fxx1N1tiwn8J93Mu/iSVpTqcXvohZgOi0+GQWi5uRx659mNUAKhz6LN9W71PdJ7x6MPm+VF02tFHLeRH88KyL/3Gkvf9TLyi1MOwVCdJmqIv4hFTnLa/owGY936uDqCzcCby8WmCZPZPEzGZrW7uAmchw6LmtxDmsxshOoHf9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDV+QTzK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDV+QTzK"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4178aec15so512484b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715884096; x=1716488896; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FITarwh2+GOhDseQyEOmjRb6Kp2ZPJkmNtFBnmcivF8=;
        b=lDV+QTzKMsVTa3Yk+X2H/vyaEXuGI9UEd5+KikpRXSf1ox1W0hXXw9WlXPSpIxczzz
         I2bnttlYMBs5Pk6o6PsQNks+E3xl3epdmVHlyrYFd4vyuXjFJfyDfbgguNKB9zaCMI3w
         t2teb9hOwQRwvQ1Y89X+Ph34LXmdPi4d85mQK5CiWwbRma0K2jzLE4aW6O+BZXWPrldw
         v+XEx6fB6iZsk+dLwqD+sytpw2HR8q147yIQR5oy6aW9gq2Mr5Z5EUdgZqWxfi92ovz2
         oeKZUaJXY2i2c2JhPlr62yQcJse71otuFCa+8z8BTpvCKxzX8/OuSPvjZ2pnk7h78kJT
         Qlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715884096; x=1716488896;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FITarwh2+GOhDseQyEOmjRb6Kp2ZPJkmNtFBnmcivF8=;
        b=eq0BI8ZQdx9iSj0bFvOgGLq+AO6wVfxiVqnmGq/ee7+QuEXLbULU7St2YF1bAqBOky
         w0f2b78c+CRN0qxiA66kND+nGUOAngdiPCGU38IQvXAm3kb1tTclTLfKe7fxrdBv0Go9
         OpoULu4wmg6EUTHrqReS4r6092sJ2pW/sGhdPkLkQiaYJN9HOMwZ9k7H+cDSDKOPPC/B
         iBz+IyPyyEd845mjEIm5nzIq/KujvYXjUu4+ImkOqZyYF5KUuqundjCXR95llgM/pXEX
         3cy6HEWKXZxaCtMLB9285q4JV2tS4oTndyz9jUJwgM5Vwcnz6sNaR0CxSbTW/gbzpLiz
         OfrQ==
X-Gm-Message-State: AOJu0Yx5Yh5q8oroezpch73nn06lSAiZuul+h/gyIfd1B4L0x5drKPkp
	/ZSt3h3GerQKWq3f0IvYZFwtIpeH4kiljYuVEH712gxs05+l4+AQtlC2kA==
X-Google-Smtp-Source: AGHT+IEW0ksi2p2W3O9uOKnQ0zkXiRjFtCOvDfZdr9jbf+1UezPPQqWvNyjZ4bmYegn+AYdlO9bBcw==
X-Received: by 2002:a05:6a00:230a:b0:6ec:fd67:a27e with SMTP id d2e1a72fcca58-6f4e0299dfemr22510178b3a.1.1715884095769;
        Thu, 16 May 2024 11:28:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.28.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2969sm13296873b3a.152.2024.05.16.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 11:28:15 -0700 (PDT)
Message-ID: <6646503f.620a0220.e829b.2d9f@mx.google.com>
Date: Thu, 16 May 2024 11:28:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3486725373446365169=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arun@asymptotic.io
Subject: RE: ASHA plugin
In-Reply-To: <20240516145501.134118-2-arun@asymptotic.io>
References: <20240516145501.134118-2-arun@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3486725373446365169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853729

---Test result---

Test Summary:
CheckPatch                    FAIL      2.74 seconds
GitLint                       PASS      1.02 seconds
BuildEll                      PASS      24.26 seconds
BluezMake                     PASS      1678.59 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      184.66 seconds
CheckValgrind                 PASS      246.97 seconds
CheckSmatch                   PASS      358.24 seconds
bluezmakeextell               PASS      119.64 seconds
IncrementalBuild              PASS      7952.05 seconds
ScanBuild                     WARNING   1017.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,3/5] test: Add a script to test ASHA
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#103: FILE: test/simple-asha

/github/workspace/src/src/13666280.patch total: 1 errors, 0 warnings, 158 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13666280.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/media.c:1048:7: warning: Use of memory after it is freed
                if (req->cb != pac_select_cb) {
                    ^~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============3486725373446365169==--
