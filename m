Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0D314D37
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370258; cv=none; b=WeZvvQ41zo3dAzSjl2E648KLJhNDQURY8OGp5g9R3/KENqteF63kN1YL2Vzk7Zon2ib0KH0jw2sF1bKZg91miAvy7FOKaA58Danl9bTLUmua+Ejw/Iyt2rRQptiGOwD9IRMz2KYPcg02mIyDGZAvSSIsHiWNI5FBT/KySsB1jfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370258; c=relaxed/simple;
	bh=laPW2oDuC2Wigyky4ZPdn82zj0l6eGEgz/1v5PRxkzU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DsYASGH4xvfpuYUHlED0rAWj+vKAWttKc8EtoHBBvtpkBOc2vRCCMFLQ1VDrQ71MfFvDVNZypMCtrgzeZHRCFFDamyeS407sCOkiLdxBGOLnhsayq+8prxe6qZeJ2FrMGIv7pjB7GKAQWYuZP9OEKgzcZ/WfB6YTtu17zPCxUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKzAfEbf; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKzAfEbf"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-137dd523634so2631169c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781370254; x=1781975054; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CWQiiu9Um9xCDNmPEuIzkr97t4DFBa7hb76zdrp4zGk=;
        b=pKzAfEbfVNq7zbsSygSq6CzXT60zOAm8yfr6Vt3oH1PwCd2QhrFcrGf3RsY8yA0P5O
         3KLISBnUCEzAQyHdyP81siQboIItBE0bWiAGT5HDj6279zEs9cQnE20h22VEg4rVU0z6
         S7OSOYAm5NLnuKahXYs4TQ4Y4x1KfEC13clS1YjeJWfvbxIjX4itVT2MNvlOXIkQaTYx
         R+y6/QJqo8bt8Dmc2ayy9Md9Al7BbFxbo4QJ07/7RCgCnFPmm594nrgm3yhwGWIrj7K0
         qKphqXhlSadDGMXTEUs+w1jMQrXMHNCGvbCUAK5MP5pjW1veOr+rMzYCL08QqYOl+2zG
         oTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781370254; x=1781975054;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWQiiu9Um9xCDNmPEuIzkr97t4DFBa7hb76zdrp4zGk=;
        b=ZM0gvfSXxS4/oaiQEGcIV2guTWHcMRpKspNF1DcIfNtFmb8Z3qrit2zP6lG91EuCjp
         NqofETZBkvQkHfuBW82diimDOlPIcyMo7B5kEMwcgx+8T9JHBzR5/2E6nY/k2W2aWdKR
         W7A5Hw25mktwQLEAR4u2K9kY5lbEkfQMkqqs/wgp3VgyH0ys4E1Anl5nwgegOzcKwTZM
         LmhErw0RbrTh41L6boy2CyfkBtuWgb/blvmk9rREDFVj2iO8SPqIrWNmP5AsAGH/1PmN
         Eip1hICrjK1rFO3wmbulGbNFPuwHnweQ47Sr/ZSlbdxkxWZ5RMQkYBiOS9PYbsgZ5PQd
         e5Aw==
X-Gm-Message-State: AOJu0YyBrkrC1bmXDw+bxfdNMVgl50M7H0tfotahhR32hkonhjdHhJkU
	VWQMAauqSh3YH8QufODm0xVY1lZWvcA3WYxEZUjVd8KsxUCT7oMPOmOAnOd3hw==
X-Gm-Gg: Acq92OEZg4h0B5NwhjsZvrPpIc4HDbhWF5b1RL0PO1rErq3nzplodYX+yQ9TG9fnEGx
	bfyX7uB2FZBMAmXCR37Y0hDRoVObVpRO5cmz2ZyWA6aNeA75uCywJeYFUWEj1tdze9lbGRKI+G4
	QEE6VU7aBl/MmAFmWWfmiBzF/NmKJJc+VOEoq5Lqy7Ejg0Bcmov1vbomFPaMCPaHvno5B72DN4V
	iCM6GNQe3lqSdMy1tQ7JpZNSycCgJZd5xzDW4AmQcWWGDG4PzOPeT9A+BY0yDeawJbue83wmwlE
	f61asi391QeeFV3ImU04HFMcD/o4PbdF3z5N4s0JVZbeTqdzW4x0eWPmD+9jFxSwcmpzVDAeNVd
	ECHY14kieGi0MI66lI6YqOxobAKXUjtLH4a+DZBDXxDVqbw6iQ+5N3w9HRkF6PCgGtHw3MOzwyl
	43ZMvM3xhjBuon2pBjDd+90AqZDKiAsvg=
X-Received: by 2002:a05:7300:547:b0:2fc:9aa8:83da with SMTP id 5a478bee46e88-308200ce4ccmr4580915eec.29.1781370253989;
        Sat, 13 Jun 2026 10:04:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.195.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm8181321eec.5.2026.06.13.10.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 10:04:13 -0700 (PDT)
Message-ID: <6a2d8d8d.d5797644.1eac17.f60d@mx.google.com>
Date: Sat, 13 Jun 2026 10:04:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5461627034388656094=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] emulator: btvirt: support debug for -s socket server
In-Reply-To: <11cf79f1f980e5da2202f84bf66e3847048cc34d.1781363977.git.pav@iki.fi>
References: <11cf79f1f980e5da2202f84bf66e3847048cc34d.1781363977.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5461627034388656094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111062

---Test result---

Test Summary:
CheckPatch                    FAIL      0.36 seconds
GitLint                       FAIL      0.22 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      678.74 seconds
CheckSmatch                   PASS      354.26 seconds
bluezmakeextell               PASS      184.28 seconds
IncrementalBuild              PASS      674.12 seconds
ScanBuild                     PASS      1058.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] emulator: btvirt: support debug for -s socket server
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#85: 
bredrle: host10: > 01 13 0c f8 00 00 00 00 00 00 00 00 00 00 00 00  ................

/github/workspace/src/patch/14627485.patch total: 0 errors, 1 warnings, 113 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14627485.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] emulator: btvirt: support debug for -s socket server

7: B1 Line exceeds max length (84>80): "bredrle: host10: > 01 13 0c f8 00 00 00 00 00 00 00 00 00 00 00 00  ................"
8: B1 Line exceeds max length (84>80): "bredrle: host10:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................"


https://github.com/bluez/bluez/pull/2227

---
Regards,
Linux Bluetooth


--===============5461627034388656094==--
