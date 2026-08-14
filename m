Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C444470B
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705069; cv=none; b=VVg17Ti+0G7sRXak3MzSnRyBg0l5HYRwWDkmHQP0SepeFBfeqHDHtCmZ2YrVrY9hegOAWk/raHk5oaFMBbTEnQxr9jhiWx76naH8zYyJPkftMCUz3H033aaz1PeJe/6ikEOytex0SuZx/PaQ5O2JnXB2R8frYZohXw19WVkFqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705069; c=relaxed/simple;
	bh=QUw4NEZh1BSJCUBZlpZW6hnXEC7kTS9BqwRzy6ffook=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CzJ2ndADXZVhwUqyujQBnyY04ca5ri/ZbI1RJiu26X/0J5hVl4WlsFxlfTkKqsU9cwwdr9sTPQaPOmlYE51sc0hYcXH5AzGvxcchy7kDEJ9Hx4uB3BTSmfSBLOOjttOGBNKUHbO+UAWHjPtscAqc9ceZK7tQrh5+d88FZEg58Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnIch5Fv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnIch5Fv"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d02b4c3601so10491145ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786705054; x=1787309854; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XH2+pRs6cHpDeVQeRrvDi5/OMV9Om0MfpFs0r0TeicI=;
        b=pnIch5FvHSACgdEEfS1nZVsIT6vkf+2UGAh/ChuBiEqNWo91G8fj9/ov2d4fjlpWkH
         qnHTAVr3dURJXcnNwzPznM/LcgjJbbhQkwk/FAdJc74MjNvTHVqfWewp/OdNmCBpTft+
         v+mEad2T51mlhb2V4Um1xV4WV3xn59mYK9v9aZI6hSHACvr1uLou0GHwZE6eXwWnCsSq
         k++qErxJ9Kun/akAPoa+z0AycHfMcsJtU7ZcFA5ZX71CUgchLUF6to2NE0EqEwZ/iSbI
         bpQFfVxmzvjjeXDmb8auA5Gkv3Xc+jSBJKjxXnILob8dWw3i314T8r2NteH3AXKoWQOk
         bSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705054; x=1787309854;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XH2+pRs6cHpDeVQeRrvDi5/OMV9Om0MfpFs0r0TeicI=;
        b=tMEOzYLCzCF1+ZUfP8+vH3GW7h3F6zz44Mc7Dfqr2LDvM1cZoLmqMkxhjJd405K8mT
         UPRu64K5uQR5K9zrc7wjqplYfzqKrNwVTW12wVA45jycrOF0DRq1oF1u/Rx17IM3HcYV
         rwQFiH1eZP2XKogIYM5E6tWZPhaS98yYbMVSMgRm5k9aT5iTAz+ep6RSSBk+6BqdHjqW
         2BzD9GrszIi/NjT5NYrM2lSk0CrStf2cViqzw+hORYurglwYy3fG7wQUBtJlP2cXDmcL
         is6wtxfH66DbviSWp3X1Fz5OfgRcTXcD3vE7H/OlayG0Mia/qQVMmJHcHHwL0wUzpGhq
         bWvA==
X-Gm-Message-State: AOJu0Yy4GyZRPs9Tej7soHGAkq+6oxyqJuzMN7+fLYKrMg5zfYGl3Oxo
	qE8AUM07Uy90BzJuNK9cAl7OtaMELvDW49FSi/ZJj1OfYydZvuXY+rTZ9/wl+w==
X-Gm-Gg: AR+sD11ogbeXi938k0f2tj0Z9yuZXZ5F3rFo/uOBr0gdVUp7f21y8jmG1pD9qLPzqJf
	Hw+eA/fD6qafxkRegg3v485ggsSvmC+scFc/R/4ZMv5JAVxJ8cClUGDM/9hWocfbCXKoqquiFcm
	p/VhpktyCDQ3MSfWOWFSVDI5sfgN55uDsTNosIYLwVpgtJJQ6oo8rosL8Snf8Xne+vmJsa2Cv3p
	9/yLzj/EUffnCCCnCFwFR2soJCj0ZJHKnf4sNz9DawH3VFoYTjrbOI09lYnLrnOWHou2Z1iAOLU
	3FpxQh9neUhRt9LjA/bzzQf2BgSxpFtZMcPe6aLzqIYVOHsB6Fo/QAJ/e8UAwJg+/jWblBBcPF6
	7HU9SO5ohbEh671TwYr1+zYxWIfY0rTZ4mcjcmuabpJMc38qH2fR4HOYZqO9a0d/2u0rU+S9yrx
	Ycb19cJ/aIEC6mwxK5rStVJoAXWeg8tJBbtZ+k2mG7uwVtxBd+WaeTZ/yn5pCPS35S3g==
X-Received: by 2002:a05:6a21:920e:b0:398:c0ba:9ceb with SMTP id adf61e73a8af0-3cc71a40f7cmr6175160637.12.1786705054174;
        Fri, 14 Aug 2026 03:57:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.23.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bda546sm3610451eec.6.2026.08.14.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:57:33 -0700 (PDT)
Message-ID: <6a7ef49d.a1accbb4.1a363f.e663@mx.google.com>
Date: Fri, 14 Aug 2026 03:57:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7754329982848770948=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] attrib: Fix smatch "non-ANSI function declaration" warning
In-Reply-To: <20260814092747.3064311-1-hadess@hadess.net>
References: <20260814092747.3064311-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7754329982848770948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145981

---Test result---

Test Summary:
CheckPatch                    FAIL      0.36 seconds
GitLint                       FAIL      0.24 seconds
BuildEll                      PASS      17.38 seconds
BluezMake                     PASS      483.22 seconds
MakeCheck                     PASS      0.81 seconds
MakeDistcheck                 PASS      124.51 seconds
CheckValgrind                 PASS      115.91 seconds
CheckSmatch                   WARNING   230.51 seconds
bluezmakeextell               PASS      75.66 seconds
IncrementalBuild              PASS      461.57 seconds
ScanBuild                     PASS      706.53 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] attrib: Fix smatch "non-ANSI function declaration" warning
WARNING:EMAIL_SUBJECT: A patch subject line should describe the change not the tool that found it
#34: 
Subject: [BlueZ] attrib: Fix smatch "non-ANSI function declaration" warning

/github/workspace/src/patch/14750038.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14750038.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] attrib: Fix smatch "non-ANSI function declaration" warning

3: B1 Line exceeds max length (95>80): "attrib/interactive.c:175:27: warning: non-ANSI function declaration of function 'disconnect_io'"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
attrib/interactive.c: note: in included file (through /usr/include/readline/readline.h):attrib/interactive.c:300:23: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2399

---
Regards,
Linux Bluetooth


--===============7754329982848770948==--
