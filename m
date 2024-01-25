Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3B67C61
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149747; cv=none; b=jtqyiNxpx0IYay4AMsW5PQFx7lBBuUKF9OrK2hhAz2+0y6vsQMl1w6oGkZV8/WlivUYsxVxfkUnU7C6iqczq6A/bhN83Ma/QWNzKte2K2ecw71DubjKl6Mu3JMfYbOGgHvOfKZfKjZ6D+Y0QfveYhDcOfa5rU7Qc9miXA3+fEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149747; c=relaxed/simple;
	bh=LrP97k2WlDYwsAhHUwV/tSAyfddGHMl9+3Y+5V+DBiE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nDJgdNaOQLgiYGDxHWsCjsjN9iIDjCNtsy17KNNsQXm/5f29yaPeCExP3YIt/hncDrpQJ4d/utvVIFCZGMdpIfrv7PlHOfS1VZmlHM5EC8t+6Vt92Bzy7CR/gMhGoWwJy7nfXhG681zbZZkZ7fJMHE27l7U+hZEcjuBobrWLNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlTGtncB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlTGtncB"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6818aa08a33so2167246d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 18:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706149744; x=1706754544; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PCCvGATzt1VhH82nozRrzxkQurL3aAQ50vtCjXYMPd0=;
        b=OlTGtncBO3nrSiTqIKuOZPGCqxueDrSx5SDxrAf5RiebqjlrWVFEkZNmJIP2KtAusd
         4UwAWQyU/qighmjajvm+pOgHiXZXo4BqbEn6aTsJKEVy5icL3RCRdFj1HsRBhtIeF0Wn
         pAOo6hcOGk8j1pVGWmJ0BHKoBFisvdajarrtF1Bo6mLNb2J/FHJ2T//tktQnh0OmCSAV
         HeKp5CCYaF2ktS+KZ0qLRrPclUW7BGEi8a9QQengCzCIbe5jc/q7lO8JeENMGHFb+4/d
         f3YtdyDTL7eP5fnLp6WwHDqdNFlIJ1bGK+VJ1SmK7TsoZFGvqf9YBtQKkAIgWZTTV3bB
         asYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706149744; x=1706754544;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCCvGATzt1VhH82nozRrzxkQurL3aAQ50vtCjXYMPd0=;
        b=I+Nmzku+Yw4uzluLjYb8dnrCCmuR5b8VXRCBp3uVdJeCseoTq4D6rImoqvvjceCMbw
         MAKeTF9wVezsibAslmb84sQgDOsWqL1jKj37hXEj4l9CwFYgweULjkQiTQpp2nleIGWv
         GxahfdwFLHNICsYwT9RuKo/aypDujPu5tZYlb2Fppzhqgbhve1sxo6efjofprzF0VUEP
         pc1uxPE7Me7UIsGU7uTvNo9b0wBwL521c6t4QqwnGLVKMAtcAMlFCE6t/KgVRmdhJf3l
         xefMi39LLH3qdqxbvqUDjV9p7BOWhNju7l2fDPceAubewkFBWiCONzxTNHHSTs9TFHXQ
         gAKA==
X-Gm-Message-State: AOJu0YySOBOoz2PASYP5xjQdYK6AhfWnRm64RYtVXPEzOuyO0GOm2lBD
	+MIKDQUMHn/Y1J2pbk3MxHGG0kOFfyp1Fr62F6NIjKNtLeXIJ16nFzfQ+1eN
X-Google-Smtp-Source: AGHT+IEwBl3bvkXDjIemCNykVIZJCQNoQPz37opqWRIvrlCGDwM2ICoNDXdE1qCoLJEhsqKPbMsheQ==
X-Received: by 2002:a05:6214:f22:b0:681:35b:ff6f with SMTP id iw2-20020a0562140f2200b00681035bff6fmr482589qvb.29.1706149744469;
        Wed, 24 Jan 2024 18:29:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWAFrC2w5/NhBIKF65DF36i2EJ9g2lhn1F171QnA95o1FQtlneh8E4GSxuKnmDEpsmd3aZvw+O+GJj+/9MqD4IGT2ubAHDVBK9pvLOQ96BAGT4Bk0b3CNjaSysA
Received: from [172.17.0.2] ([172.183.88.181])
        by smtp.gmail.com with ESMTPSA id kr10-20020a0562142b8a00b006862b537412sm4568758qvb.123.2024.01.24.18.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 18:29:04 -0800 (PST)
Message-ID: <65b1c770.050a0220.5db35.6b77@mx.google.com>
Date: Wed, 24 Jan 2024 18:29:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8986247116691463970=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+emil.l.velikov.gmail.com@kernel.org
Subject: RE: Distribution inspired fixes
In-Reply-To: <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com>
References: <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8986247116691463970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819667

---Test result---

Test Summary:
CheckPatch                    FAIL      4.59 seconds
GitLint                       PASS      2.64 seconds
BuildEll                      PASS      24.25 seconds
BluezMake                     FAIL      4.89 seconds
MakeCheck                     FAIL      0.12 seconds
MakeDistcheck                 FAIL      4.40 seconds
CheckValgrind                 FAIL      4.38 seconds
CheckSmatch                   FAIL      4.52 seconds
bluezmakeextell               FAIL      4.42 seconds
IncrementalBuild              FAIL      4731.57 seconds
ScanBuild                     FAIL      480.27 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/9] Enable alternate Bluetooth connection modes
WARNING:BAD_SIGN_OFF: Non-standard signature: Co-Authored-By:
#87: 
Co-Authored-By: Rachel Blackman <rachel.blackman@synapse.com>

WARNING:BAD_SIGN_OFF: 'Co-authored-by:' is the preferred signature form
#87: 
Co-Authored-By: Rachel Blackman <rachel.blackman@synapse.com>

WARNING:LONG_LINE: line length of 102 exceeds 80 columns
#133: FILE: src/adapter.c:869:
+								adapter->dev_id, mgmt_errstr(status));

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#146: FILE: src/adapter.c:882:
+				set_phy_support_complete, (void*)adapter, NULL) > 0)

ERROR:POINTER_LOCATION: "(foo*)" should be "(foo *)"
#146: FILE: src/adapter.c:882:
+				set_phy_support_complete, (void*)adapter, NULL) > 0)

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#163: FILE: src/adapter.c:10503:
+	// Some adapters do not want to accept this before being started/powered.

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#199: FILE: src/main.c:186:
+static const char *conf_phys_str[] = {

/github/workspace/src/src/13529758.patch total: 1 errors, 6 warnings, 182 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13529758.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,5/9] profiles: remove unused suspend-dummy.c
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'fb55b7a6a', maybe rebased or not pulled?
#77: 
The file has been used for about 8 years now - see commit fb55b7a6a

/github/workspace/src/src/13529762.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13529762.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: BluezMake - FAIL
Desc: Build BlueZ
Output:

configure.ac:21: installing './compile'
configure.ac:36: installing './config.guess'
configure.ac:36: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
./configure: line 15145: syntax error: unexpected end of file
##############################
Test: MakeCheck - FAIL
Desc: Run Bluez Make Check
Output:

make: *** No rule to make target 'check'.  Stop.
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

configure.ac:21: installing './compile'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
./configure: line 15145: syntax error: unexpected end of file
##############################
Test: CheckValgrind - FAIL
Desc: Run Bluez Make Check with Valgrind
Output:

configure.ac:21: installing './compile'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
./configure: line 15145: syntax error: unexpected end of file
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

configure.ac:21: installing './compile'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
./configure: line 15145: syntax error: unexpected end of file
##############################
Test: bluezmakeextell - FAIL
Desc: Build Bluez with External ELL
Output:

configure.ac:21: installing './compile'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
./configure: line 15145: syntax error: unexpected end of file
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:
[BlueZ,8/9] obex: remove phonebook tracker backend

./configure: line 15145: syntax error: unexpected end of file
make: *** [Makefile:4713: config.status] Error 2
configure.ac:21: installing './compile'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
./configure: line 15145: syntax error: unexpected end of file
##############################
Test: ScanBuild - FAIL
Desc: Run Scan Build
Output:

configure.ac:21: installing './compile'
configure.ac:36: installing './config.guess'
configure.ac:36: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
./configure: line 15145: syntax error: unexpected end of file


---
Regards,
Linux Bluetooth


--===============8986247116691463970==--
