Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0A385D7B
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847431; cv=none; b=tprxrnlMpzwQcpFxpUG0pD0cnzilXNWgMYaTWLbKI0AZSafvm44lJfhfk/slohQm+dHBTq5modz321YIxzrpODSR5XuOf0qX8BHy3HUK7E2yy8Q4kTAVZEKFSygVW//U0RlsyLwsxfio+ox7A6venS+uL3pL6loQPJp96z2JV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847431; c=relaxed/simple;
	bh=Ghj3gdAvc8jPyGkFy8ld0htFtwzSASwn5heDeq30FEM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U1Tb32dRJsPvfnSoqg+bwzsN+WZ800WAHgEipKvkPkOOTn+cmz+71fgTRF4oLNaFDLJuai5P7AVMnXB0OP8UHK5kM2cBp6gDt1SIwcTlJNJ8119/+SmsbV0Gcq11MTX+on7tE/iNJbdkF2kIxbqdKITMmf01tMRuxi7h+vD9zuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsxWsTyy; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsxWsTyy"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93906e8a5feso1787185a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787847428; x=1788452228; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O5mIsoXYHRt8Z9mTQSWZSlt4MEMDz6ug7wnhCtk7rhk=;
        b=dsxWsTyyJ9AcN8CQT2X86Jh+iSCqdSHKZ7mL5bluJ1OVlj2czEvcZUeeFYouhOxPhu
         sO7qh2xe5OwXosFF9fk01MSg2JVnAocY2h/VBvkbqBRkxaI03oM9D3ZY3plirk0SEPUQ
         b33HoZhB3R5Z02zEWoXFkuB7rTsJEAE8VEl5hm1cXikFr9OMkyElAFyNVWh/flSfE6/w
         acgaImjRv6bGf8AbRDB+Fx7JYM1fH7a3gfI2/YBC0RD274alcgBN0NJsDkkL1cAkOm0s
         J0koRyIz+nbXIclLmkVgUnfhUsabB/D3XeEVfiWO/QDtKA8m5WxQkcduMceXPWKVngkg
         tx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847428; x=1788452228;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O5mIsoXYHRt8Z9mTQSWZSlt4MEMDz6ug7wnhCtk7rhk=;
        b=mYalthuqC/IPerrRu/mO0vOESBPe7+9OSPrSFX50o4z5hyrLz3FcuT8I0Nn/8Pyogp
         oySyQ0brKrvjhJMZ4DG7NFAlHGp45qh0AQD7W29LeRIweFlaWkTbsDzk8D/J8ZqWt97Q
         jkeq7mkuM+9VURELgUoZD55vyxC7Ba1wcmSL+helH8qaQ6IwgDD7QHs8mgxfi9Zt8b7V
         PlWooRmWVakvT4ZjR9LwOte1eFBoUWSNdRP3glRTBGGDoMl6M06kwHuM0mh4L6e1X8l4
         UCSflr/NswVOq4NDVBKzQA5O+3nC420mOAnCFIYWfbREMOrqLd30LrJ0XBhpwDsg8D7s
         tW1A==
X-Gm-Message-State: AFuF++m9sHvib7UvtAhxurkvm9QikSUa+msF4nyB3F+lEWKVN3EeNiF/
	D13JqsgeXwWrFmfE3yxM/jIATXgDOb99MTMxnjy5fQ0kZ13i4Hw6cuqI7hmFeA==
X-Gm-Gg: AR+sD10xWTdPcEB5XDywb5nJ38YkWYPQFXgPGCaMEiJgan7IMOO0iYf2V39kNuCpN8q
	nEC2VKDLnwhypLBymxyo9qYMxppzYpHpei2ZzOc8XLet019wt55BobvAqq6zPAX1ZBsg9CUJ59R
	8MXaILJNEN7B6TJyk1JRWfBZoxuFNmofJLU6j59mJk9FVmriwDwFVD6eX9BRm9eLINzKScdived
	S4Lq+aYVw736BK102aIpc0O3uJLuW4HaCmBZilvWGIJfMhMIyKCx05JejDoKcyi1BPlb5e5DDuo
	RUkHCJF0nPHInxRG/aOo5hcJ2Ah/ngtxgehTSEZ2hBC71OwbJ/v1Tb7cpIy11uW2f3wOHM3JRx5
	awZ6FlFWQ9PFjJNmkxd8FaFMtZUmkLNvwifKCyzs8RSU7tI+AAM8uM75zi0osXwOhIV7CMg+aRG
	y+nP+gCjqRhsDFv1CRFMXPE9ZrL79/WnW4BIjzKDuENIebSBzqkc2fFU9kETd2dje34Fk=
X-Received: by 2002:a05:620a:6e8c:10b0:937:1097:feb8 with SMTP id af79cd13be357-93780473613mr1282746785a.24.1787847428285;
        Thu, 27 Aug 2026 09:17:08 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.126.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e688b35sm473526885a.41.2026.08.27.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:17:07 -0700 (PDT)
Message-ID: <6a906303.28258500.8013d.3be4@mx.google.com>
Date: Thu, 27 Aug 2026 09:17:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0817400972548869884=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: bap: Fix stack buffer overflow in BlueZ LE Audio BASE parser
In-Reply-To: <20260827145807.1568199-1-hadess@hadess.net>
References: <20260827145807.1568199-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0817400972548869884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152690

---Test result---

Test Summary:
CheckPatch                    FAIL      0.49 seconds
GitLint                       FAIL      0.34 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      555.72 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 PASS      156.34 seconds
CheckValgrind                 PASS      204.05 seconds
CheckSmatch                   WARNING   299.86 seconds
bluezmakeextell               PASS      97.06 seconds
IncrementalBuild              PASS      569.54 seconds
ScanBuild                     PASS      898.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
bap: Fix stack buffer overflow in BlueZ LE Audio BASE parser
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#63: 
A second identical instance exists in bap_sink_get_allocation() at line 2558.

WARNING:BAD_SIGN_OFF: Non-standard signature: Co-Authored-by:
#70: 
Co-Authored-by: @thaidn and @bronson-calif of Calif.io in collaboration with

WARNING:BAD_SIGN_OFF: 'Co-authored-by:' is the preferred signature form
#70: 
Co-Authored-by: @thaidn and @bronson-calif of Calif.io in collaboration with

ERROR:BAD_SIGN_OFF: Unrecognized email address: '@thaidn and @bronson-calif of Calif.io in collaboration with'
#70: 
Co-Authored-by: @thaidn and @bronson-calif of Calif.io in collaboration with

ERROR:BAD_SIGN_OFF: Unrecognized email address: '@thaidn and @bronson-calif of Calif.io in collaboration with'
#72: 
Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration with

/github/workspace/src/patch/14771430.patch total: 2 errors, 3 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14771430.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
bap: Fix stack buffer overflow in BlueZ LE Audio BASE parser

13: B3 Line contains hard tab characters (\t): "	// src/shared/bap.c:7767"
14: B3 Line contains hard tab characters (\t): "	memcpy(&location32, v, l);  // l attacker-controlled, no upper bound"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2443

---
Regards,
Linux Bluetooth


--===============0817400972548869884==--
