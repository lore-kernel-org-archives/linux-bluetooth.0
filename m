Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DBE14264A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512428; cv=none; b=tw1pdlVc0UpOxwr7dEudA3beBejw7IooVJC8fijnFdNso6Sk/tspaVcd9SBXx3thxhLlL44grvKD+6vuPZ46XA84ZcZzcyo2TJI7qUNNGT3981H4qzXfns+22ypnjaDFrTeNJfCIw0nGPB6f5YdrYs3iNJfd3nPM/rThT1/AhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512428; c=relaxed/simple;
	bh=PV8fwQ/ohOSyCNt83wjwgq+YmMYGi/TSj5VCxCg1Qks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j20Zvu6s6b+ogKZ2G8LNEzSVsNuyIONHtYlCwRApIxDitlB8MXqV09XLzn6M6ypx65Ms+1i4d+DuHvu1nLRFXm7tNFhs8qYQxD8PMbWmpKbDzTMeFk0vlkXRs/0U3/+jZ+5MOM6QOoGEJti2MtFO2xATyvxkcEa8p6Cc3H5jQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMJP+Sw4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMJP+Sw4"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a99e8c32c0so508354885a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726512425; x=1727117225; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6deP1r/CqkhPXGMZZn4+gQS0MW/OZ5ho9Dl9YgLtVSA=;
        b=dMJP+Sw4yl/pM313dtVOjY7fhejtAfLWYPc5LUOW2EqWXeuoy1uycrqs+72Caf7KrE
         yskFKPkUO7oeJPXpagqWbqSy443PCVVhebhWbrlz3TU1au3LBD0Cd0VGe+McukQIxb/d
         8y0/OEKL5DALLK5U3vjGGjF1fMneUF1iAwg938eHsmporUGfwEavYVVYxtknef0de/cf
         wfLjVpdrcYD0mbGUtohmI+JEHQLIf+Ksq6W6+xhT87ubBvSzGim7FUSJfHLyrmjw2cD4
         YrfD0kmS43F4/W4iNcRZjEBjbARtdk4MbfoVVq69DsBKCtlDYyeVGQ0be5b0sUQrXlkT
         gm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726512425; x=1727117225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6deP1r/CqkhPXGMZZn4+gQS0MW/OZ5ho9Dl9YgLtVSA=;
        b=YccYmTFB41fN4I3Ka2nqs+f5alLyfVsnRiMmWyz5IYZ+6H7hGy5p0YgSOjLUluoW4/
         i2555UZJ3Hu/DYpRe1CirE40c/fOPemtdxAfmxdcMlaUNW/t73BUdTtlaKbect7XQeAZ
         2qml9gvzG0Lx7EZkQjOZoa8uffA/ug2BqL5Ks9ePMVxEsOKDuLErsEpwfJzsgTn0dvME
         cZBRugvGCsa/qV+f2nQDhovaYjb8jfoYT7oJ2VZ877lrixrMKd6jDgpVrsgzerpaXmAi
         IzsAPpQ67o4Yo4kZl6Ip+pwStv04NunizlSoowBpSPfM5wFqoZ/hDynRgGLrfY9A+d0v
         ydAg==
X-Gm-Message-State: AOJu0Yz6TVpBnzA8rx5NGR7XApGOnWntWkgvJ8iJixHd2UMTd6iGqE6q
	V8rtkBkm2xzq9M+vej5/3lGbAqauPrmUPNtuz2VCv0zr4P4Iml4m8bmfGg==
X-Google-Smtp-Source: AGHT+IGB2MIKNvPTDlTqNWbnlEk7pxmMD54JB2LvsBI/GlPwR2Dky9rY7Z3jt3Y+CwmgLD2XMa8aAw==
X-Received: by 2002:a05:620a:4005:b0:7a9:af5b:6921 with SMTP id af79cd13be357-7a9e5ef6824mr2595108185a.21.1726512425387;
        Mon, 16 Sep 2024 11:47:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.109])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3eb72d89sm277278885a.130.2024.09.16.11.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:47:04 -0700 (PDT)
Message-ID: <66e87d28.050a0220.3b676.a17d@mx.google.com>
Date: Mon, 16 Sep 2024 11:47:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4476680371475676159=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Add BIP for AVRCP covert art OBEX client
In-Reply-To: <20240916132813.165731-2-frederic.danis@collabora.com>
References: <20240916132813.165731-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4476680371475676159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=890683

---Test result---

Test Summary:
CheckPatch                    FAIL      5.53 seconds
GitLint                       FAIL      6.65 seconds
BuildEll                      PASS      24.81 seconds
BluezMake                     PASS      1677.20 seconds
MakeCheck                     PASS      13.28 seconds
MakeDistcheck                 PASS      186.25 seconds
CheckValgrind                 PASS      259.07 seconds
CheckSmatch                   PASS      365.98 seconds
bluezmakeextell               PASS      123.65 seconds
IncrementalBuild              PASS      14622.47 seconds
ScanBuild                     WARNING   1022.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,6/9] obexd: Add GetImageProperties to bip-avrcp
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#78: 
[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_final/plugins/bip_util.c

/github/workspace/src/src/13805437.patch total: 0 errors, 1 warnings, 926 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13805437.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,6/9] obexd: Add GetImageProperties to bip-avrcp

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (95>80): "[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_final/plugins/bip_util.c"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/avrcp.c:1942:2: warning: Value stored to 'operands' is never read
        operands += sizeof(*pdu);
        ^           ~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4476680371475676159==--
