Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3F568FDA
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094892; cv=none; b=d8YXbtrVEMb0B5IngFoDhBpGYSHuWeJquYMJMBojQ0yyVmqTmoKpEqUWmsNYQeasGhohItOfZMJt20gOPP4H3ngukM+i2J3HQEXG5VDnej+ofE4R/zQSvmWnPls3eEvF6z5vi7jUiXD5OPusK1mgW7GorrPMcmPY5gZFKI/XdCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094892; c=relaxed/simple;
	bh=sYd5tucrGvUBTJk9nzgLXhiTROOoe2MXMva1aZuKgLA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CjH1omxnA1TZu05sz8mTKxwXJKiyAppnC04pgPTKn7y0ANqYfN5lIP1BBIq31M5wbgQeXbb2oiJkUPzTJTX/JN4wEOEfQvWOSz4FcPxOEY9Qc9kRRDCR5fmpHf2ceh4FhoMMDzpA/YJWie10MDr6IcNQEC/y56k+XyXgNNfArEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joqdYltw; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joqdYltw"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so18296c88.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790094889; x=1790699689; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CCUGYBfpEo1LK7qxyUqf5W1UqHzw7Vl8iQtAr19BLpc=;
        b=joqdYltwf+Ix4hUxewfAWr9f65KAKZbj8q8pt8KVZiDZMWQuloSRoqY2pegWx8Iyue
         fZTqg0fgpZC4QZab1FFCU8+8TAM4lIrG/fq/dSAYy0T61D5lufjX/Rec9gx60Qr8rXgy
         XkDgSUDlRSin/GrPZ39r8LEA2iiS0VzWDepojB/nu+2Rs9HPGeYioYe0LrnyJBU/1Rkn
         fLGHULEbIGsOjhx9Qk/dXjB574qG+UhQg5msjGgJhdEnNzF+umXvsjkq9cl0wfhj1eDm
         kOG60r+ygbEO4hls+ytMtAI3itEeULcHcVAy6Ux+WUqX4TpppO2U8weG4aF1XwOGkQXW
         eT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094889; x=1790699689;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CCUGYBfpEo1LK7qxyUqf5W1UqHzw7Vl8iQtAr19BLpc=;
        b=qi8h0gk2DWCgTusMBkvBQ4ZcKbwhzFdZj7XY+INEGuGCBvTRxUYJ8BA6CEccdvmTvQ
         r9+ZilytHttRogyKOJ8omJ5NkxIxOZJ2N32xxAbT7YzhvjsGI6b/7a+NgC91Mk+/i+Ay
         jutM5DJpA/xDO4CsO2iz7bVLJSXMeKUixREZQhQPLR+dyJYYPM3KuegrJJBJFyk01wpS
         2dWQgGkFgYJnmQE6Pia/zL3G7+figm/1GrfDqRMdyDAYqG9XOsvt5AJ5e2v6IAKfzA99
         H0jKiR9kU0S1eSvvh/31xvWQ8Nel8oUwZGTDla2U5D0fyYtzPx0pxfRyd/9Kh2vv+8Pr
         FjpA==
X-Gm-Message-State: AFuF++lXXbJ8XsuCCkMR79tOui1TjhJZRuX+8q4y+lPSPTHBHo2TRCev
	iTJ7MTXnq4Vq4c5oHFxjC30cJeyvnLU5ps4SXMNJjzqCLKLAg6AzxTdZnnAK7F7qpEs=
X-Gm-Gg: AYBFou2fXzfXPSZlxxpkW3uT2K/vdcuOUl9jVBXMDRbY8MM054tqD7u0bJU0WDVR8tV
	IKLH8JEl8F3BLIbwAiYJcRbBzMCogdVgQuqdSmxqTrKfH2FjvWByHYLwVuf8CtkXVNjKNAbHpqp
	I4pvehulMAQXZOQNCkq+ntgV0JoqA1Ui9PSmEIR7u6c1fx5BpHRnD+k/XyvVjgQSMwCy6T6KW2V
	G80edsJUh3jjt59vM4iDJJiaAwWEy26Y/VOVMp8LHYYQ7Hki4Mj/kaeibJ+190tUQaxO7wTgIO7
	82R5/Li0E33HZ+vDRpJzXPRKaKEfRAzZ3EvqGO/izQcjkE3dfd7oJGyqEU0xfx7jnkBPXDvtOTN
	1kgZcVVnVj5ODy+Z/veLltWV5XF4ZL/1O6t1sib49qHysl65LReb5BMj7SLslF530ZkoWpU/JmH
	Ve0nz0yTC8lJ33y/8Gxyw+/XobFLekwnQOeIPv7hDvkdu15tzKHr9AUzH+WtVJ/se8uKd92fg5n
	H4=
X-Received: by 2002:a05:7022:6608:b0:144:eb46:be0 with SMTP id a92af1059eb24-144eb460e11mr78109c88.13.1790094888942;
        Tue, 22 Sep 2026 09:34:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.7.238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e612d0c6bsm7352059eec.20.2026.09.22.09.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:34:48 -0700 (PDT)
Message-ID: <6ab2ae28.b624b01c.3501df.5040@mx.google.com>
Date: Tue, 22 Sep 2026 09:34:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6888493411683407582=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pvbozhko@salutedevices.com
Subject: RE: audio/avrcp: Add AvrcpVersion config option
In-Reply-To: <20260922150030.26340-2-pvbozhko@salutedevices.com>
References: <20260922150030.26340-2-pvbozhko@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6888493411683407582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1171436/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.38 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      15.28 seconds
BluezMake                     PASS      280.61 seconds
MakeCheck                     PASS      3.21 seconds
MakeDistcheck                 PASS      113.35 seconds
CheckValgrind                 PASS      114.41 seconds
CheckSmatch                   WARNING   215.57 seconds
bluezmakeextell               PASS      71.20 seconds
TestFunctional                PASS      902.81 seconds
IncrementalBuild              PASS      286.04 seconds
ScanBuild                     PASS      790.96 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] audio/avrcp: Add AvrcpVersion config option
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#122: FILE: profiles/audio/avrcp.c:4310:
+					btd_opts.avrcp.version, target->version);

/home/runner/work/bluez/bluez/src/patch/14838844.patch total: 0 errors, 1 warnings, 90 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14838844.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2567

---
Regards,
Linux Bluetooth


--===============6888493411683407582==--
