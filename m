Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6851E98EF
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896435; cv=none; b=jlwUNK27ZjPQ24CAZpqFmvdoTGmWghEcxlzW9lkGX7g/1u3MlaUsn1tWjyfjEd4JWmmdZWyzIWthTYjbniJs5Mnx/VzZbGjY97lRqYa0EDgpSKYv0KDvZrs+V1Dr69wAXC1qIujABMbVu7goB1sNfs60tpUSZb0DtCUX7LEtQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896435; c=relaxed/simple;
	bh=3Z3ArwTF1IOEdfUnwp+9pCDia/SAvDZPs1bt7ZKOeTA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DVrWUftN3/bXMpBxbwNDVD0zWpmGbYeDsPXxplEnpUHnUfKdNYt+GabIQsHyYl9etGGSdMnhIPQE9UvzSY4afM8VVbJHvkQzwadNt+4W5AxOmnUY7+SIz/1OE/mNQDeulNzfPyDxuqqWd1Z2Ezn+Ucl52+OJgijjnfWDbh1IVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZiIyXoP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZiIyXoP"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e5c5033f6so36836641cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776896433; x=1777501233; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=anjByOWBb43lO81vkPZhptj88E0T9KeWiab5C8dCVIU=;
        b=BZiIyXoPRfRVjAV0w/pbV+ojlPkW5G1WtAPTXzsGwX4Wl+KGkpt3HWC/5ZCbA/zY31
         C0n/L71UMGx16TTceAkAGKmR0kXQk/vu9QZ4U1kOqqJLAQ9fnJQnEqGnP32Um3O/SdyO
         s8sFbOdSonLMPXDmNrLCUMS6ZjtsTGp3slMtstl2LSMsNvi76Qe9ge8dGZlG5uJKhyCI
         Rgf1J8fWCuDPFkLxDPEHrMaW3v9r86fY9/a/UtiXq6WR0jFr1RKaewIemSyVWP4ILdvN
         B2msmDY/qaAStMQXMrgjCTXIX3WZoNWYFnBemmDuzE4XoSaeWzKyFn2Df3OAJZvBrABw
         p1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776896433; x=1777501233;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anjByOWBb43lO81vkPZhptj88E0T9KeWiab5C8dCVIU=;
        b=oNaIPLLnVaT0eS09izmA2wKfUCMEWZ/Xb+DQB/lJsgq4fyUYfjL2zFcQJ7cPhTnoLV
         Q9rvK+Qk6kp4QkSrv32RssGSaFArIZdlLoc65pA8WvNkGOCbPgbO7iXaA94JwhTQneid
         0BA5ExywO9oUxTOvIA2MBg794C5aw3txtA+564x4DnYaOA+jDgCgo9b8jnefG48EeKSL
         cJjXNzBIPSVbvJoZmSMHes7lGT0Ysu1Di6//GbqLbylNVIU+MLRzs3KvrYXdkyZukkeF
         XZejuueSB73BRUCxLifALtwEIJtXRDhaTyVpnu2cPrDdDW7idsAklOvNzS4k92abMuLh
         Kprg==
X-Gm-Message-State: AOJu0YyjWDA+oM5DHIX392nAP8+m6suxEaJZ3M8tIaUjVvjWC3blneTd
	6K8ipF3G1fiSH4G4LTorHziuLriW3zDTQT1GFip+dXxyeNXKHRb8G6Mhm9hoAQ==
X-Gm-Gg: AeBDieskowVqSlY4caQNe1g9xWqgIBi6E3ai+PG7RCY55yP/K3s+e6Tn9JFfvA9r7zH
	k/6zy97bD4xqaO1A551jdHnrv/jU52lLLLaOK07g/q6ccqws58yNgr36oTTT1JUxiSXqioPouCy
	VuuGoFIuBbCu5oi+6ixVVy9WYF0uzpWvyMkEqclTB5eIOh/zy0nI+cf+UuAn1S9/XdHu6oXthNn
	aE5xLLjtuDtIOrU1g5I69PlVAJV7pH+NEb85rboPak2+OslsXoakUYbiOUVtSvzJQ6q1UM150vB
	DXkv2n892psTba7s6H7G8TwXdWrqmtoGrTfvUTWFx/A8nFIs4zYoNJctAl4l6cCo4InqiPzDQnl
	7MxqIAjxgJ1/HiR4o7gVm6RBIx5QZxRZvepEHvCO8uTTaNV0WZSLZMjPTQS2KVaO39rSjILY4To
	vrHf4iSqBik+Zv0WZAn6ys/P8ZUb1OiKTytCeY2Q==
X-Received: by 2002:ac8:7d42:0:b0:509:1b76:e9b2 with SMTP id d75a77b69052e-50e36f16fc7mr379969181cf.55.1776896432836;
        Wed, 22 Apr 2026 15:20:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac68e76sm139133086d6.11.2026.04.22.15.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:20:32 -0700 (PDT)
Message-ID: <69e949b0.d40a0220.217dff.c3a9@mx.google.com>
Date: Wed, 22 Apr 2026 15:20:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8951747675664007737=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ma.czerski@gmail.com
Subject: RE: [BlueZ,v2] sixaxis: Fix pairing Esperanza EGG109k controller
In-Reply-To: <20260422212045.1325603-1-ma.czerski@gmail.com>
References: <20260422212045.1325603-1-ma.czerski@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8951747675664007737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084434

---Test result---

Test Summary:
CheckPatch                    FAIL      1.76 seconds
GitLint                       FAIL      4.05 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      655.42 seconds
CheckSmatch                   PASS      347.82 seconds
bluezmakeextell               PASS      179.48 seconds
IncrementalBuild              PASS      647.34 seconds
ScanBuild                     PASS      1012.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] sixaxis: Fix pairing Esperanza EGG109k controller
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#107: 
https://esperanza.pl/esperanza-gamepad-bezprzewodowy-ps3-marine-czarny,176,1701.html

/github/workspace/src/patch/14534484.patch total: 0 errors, 1 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14534484.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] sixaxis: Fix pairing Esperanza EGG109k controller

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (84>80): "https://esperanza.pl/esperanza-gamepad-bezprzewodowy-ps3-marine-czarny,176,1701.html"


https://github.com/bluez/bluez/pull/2063

---
Regards,
Linux Bluetooth


--===============8951747675664007737==--
