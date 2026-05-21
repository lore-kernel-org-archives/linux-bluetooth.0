Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B437B02A
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356551; cv=none; b=D0fP2T2Dc/Ja98fAuz6UeNOSc+hn7cyt96E8eP9OsJxO+lpkoXtgc3hHgUlNG+JMHMYMIV93AgILP7ZedkQR0Z28xqYtfhZZimkevcE3Fc8MNOd1/UF4CuSOOvqPJWRp2z93Q//iPI+AOZyEOHHlwIe1FaC4bVupM0Hl8gXw+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356551; c=relaxed/simple;
	bh=ILFNqMT47541kO12VFq7pq0lPMiKweJ8QWGvfL2uc/g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eie37kh260qHExWUvddbkcR2QCIyLm5bsQoZXagFCWzgZ+0sffOxxsdeocKFcJ2yUkaekebsLoD83BTt6D+3tyApBXMLQSYCdUrg6TZJAM9MvTEb4Wi2meWp7nUaSExYWtYauDCMjhRRCxgkbY4/kU/MyHiWcCkBV/eq9H61keA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOybckbE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOybckbE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8c921396e37so61474786d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779356549; x=1779961349; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yUbn01S56dy9ionlD0SteSJ9/HpwgshTb5SHQ6ZB8ZQ=;
        b=JOybckbE6plJ00Z2X0ZxnaopI4hviBjTiwbg081551ya/ol6AJgubLmJTi1rBJBZ0F
         VdbPtxF0fY3/Hxpm/EK1eCuQ7DRuceno4cn7v08RCDHKBmZ41RJDd21FGZa7496sT32n
         +r8PUJ/OiuD5T9zU84O+dQWWQa1j0Q4z7oFtbUtM5TjSPmmH4FZHPJ71U4yzedsbDoLa
         iS4EBBq+YZ+JTA8OpSxdlLrFUpx8Xaydexpsnd51w4yYD4gYbxGQOs3TryXYTLPmiGdN
         nBTKovyAmZW9rx05d9EHgLROoQ59K4ys8hyBP2AQPBc8vGGsyNvPLMBq31TDnyaBjK6F
         STrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356549; x=1779961349;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUbn01S56dy9ionlD0SteSJ9/HpwgshTb5SHQ6ZB8ZQ=;
        b=c+1RdgM5++sAOpkQKSwDmyG4wpiyDLoqcPV7FlNF3hAgiVgBGn4iQqniU9vpxcWUgI
         G6g4FLf/vFqODiMM9gSz0YPebXb6JCyWq2B4LwWkP29UYrb9giR3KF5MLuDBInQaLfT9
         2cJUX8dsJyv1bY9hLUXj356jLuznJHiMeQApDU53w1Rd+N4L5ZZEQy5WAnKdme0Crh/h
         6/oTZn0k195sHayjM4DgFeDcCEny331qFFjL8sbk4mv9D6yfWllnlenm0QXknJf/bAwg
         Un0u4tq06vqnFGBVKPUYj3c0QOoDN6AiVMLmSM0rSst1eUowFdtL9JKHRukje0GYkhdb
         BlRA==
X-Gm-Message-State: AOJu0YzXT5et+dRIHNsLIu0H06CJ9fA4Dxqf/uOFIJklwspicwkZbzJb
	vmhXthxebjSj81oXjDWbEjNRTP8q+2aio6P3zLVomNh30UE/U478TwY/X3/G1A==
X-Gm-Gg: Acq92OFgA+oeHeQ88Ed0wAnuqbhPNTrUSJmS6eYGv00SNhEfRtVAfoFQtDiezn2Hxpb
	6VxIs9ReIvhu2b0lFWA/LxdaapdqMuJsozWr9ii8PIi95OAdaTjgHHg++iUjg5LmGplUm8iM2un
	PNckTJt2J3qUDG9J/VxBPM8HI+K2byaMfS8g0pm1Pi74xsea3/YfXHJ6AqHOCjK/nX8V0UoIPFq
	/IFfvFU5DAXaofsj/HOazgm7DHPwtmNS7Sa7IgZ1S/94tlQqhgohpeU/1Xci7POUd6ojnvtTrCF
	y2+FIsrvCAH9Ych1cnafCYNTmQk3a4v5hZMHAjSRQZpZRg8EvS/7iYLbIw3Y8OrV1C1m429NKIp
	B2QQqBDXKx40vWXR1ekdbFDJCraH68+BXD3NJ7Qwu9PmL9cUCIkYSO2U7AJHDkjpwFZDasrnlV+
	bSMmsPYLJxSkaKtEDEsgX98HUybmhLTTQjVOBYSRyeJ8Ia4W+dMIo=
X-Received: by 2002:ad4:5c8b:0:b0:8c6:27f7:30e1 with SMTP id 6a1803df08f44-8cc6e31c26fmr31357226d6.15.1779356549195;
        Thu, 21 May 2026 02:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768b7032sm1080046d6.4.2026.05.21.02.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:42:28 -0700 (PDT)
Message-ID: <6a0ed384.87685153.2b70a7.9766@mx.google.com>
Date: Thu, 21 May 2026 02:42:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3348463798758672978=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v2] shared/rap: Add client ranging registration and notification parsing
In-Reply-To: <20260521071821.2355923-1-prathm@qti.qualcomm.com>
References: <20260521071821.2355923-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3348463798758672978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098497

---Test result---

Test Summary:
CheckPatch                    FAIL      1.01 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      609.40 seconds
MakeCheck                     PASS      1.18 seconds
MakeDistcheck                 FAIL      215.51 seconds
CheckValgrind                 PASS      200.78 seconds
CheckSmatch                   PASS      322.84 seconds
bluezmakeextell               PASS      164.82 seconds
IncrementalBuild              PASS      606.23 seconds
ScanBuild                     PASS      942.07 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] shared/rap: Add client ranging registration and notification parsing
WARNING:TYPO_SPELLING: 'fuctions' may be misspelled - perhaps 'functions'?
#161: 
Use helper fuctions for readablitiy and code indentation.
           ^^^^^^^^

/github/workspace/src/patch/14585921.patch total: 0 errors, 1 warnings, 935 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14585921.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[4]: *** [Makefile:10239: test-suite.log] Error 1
make[3]: *** [Makefile:10347: check-TESTS] Error 2
make[2]: *** [Makefile:10818: check-am] Error 2
make[1]: *** [Makefile:10820: check] Error 2
make: *** [Makefile:10741: distcheck] Error 1


https://github.com/bluez/bluez/pull/2141

---
Regards,
Linux Bluetooth


--===============3348463798758672978==--
