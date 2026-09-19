Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13D3DA7DD
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789820429; cv=none; b=ZZOiEA3Nwn/n2W5KLksLnAsQJOL6n+oIo6+Uau3P8N5H682YIqlp52CADf+qb3AUvEl5o1uaiwUgu12pYm509+AVLEIIaxy0PEU1Hkv0g6z8g/ozQzLS23YiQUjg3HpQrzm44op5nq6rfmIGLBdeZ1sTdil/eMkSLCC/dlbQ73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789820429; c=relaxed/simple;
	bh=PdQeBqu8IuhO+lE6kFNquiOwz6vWdsQ9E4Qnx3vgpDw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nTfslCDEV5EkuVOI7RqXbBDyZTX3mQXbqX6xQEfO4WPrpng5/jonlKRh5fizUf/ZA+d8QncoIhRjiEhsG9hjPq5/VL6pAf/X/b+6cwmQ9oG8OTGUV4Msw/JZ+mNFAE0W/Ese6ciEwBuVExaEDC0hmDA202UF+iRE48zQ310mbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chO50RR+; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chO50RR+"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c3b639adbcso1283166b6e.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789820426; x=1790425226; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6VJjBBrsr60hd8B82/VsxfHycDf6l6tDJZDwPshOwf8=;
        b=chO50RR+uvd8UMjtRuUVWPbffeR4q3ARFLyKA3/sY4yqaxGmPzOecnaOXufxc0gmWn
         VepGSmRT8KmltEUCxviewekm2sx9raw2duA2PLaEL6irxU8vFBDHJKBk020qCieyZmsK
         Es+uNpOY+nv+IqTZLetueUFzA/KPZHOZOxGZr9aoB7SxQMaEiURdtwjo0WIXSzXCVapj
         zp3+w1m0+2RRymn0oEnwgN2mP8zCm8OKvX1a2dDvqMIPimkxZ53gs+VzUQvs4ikMsWw+
         SI3gE2kosYn69Zv4CowCTFSoyRaPVtqMxkdfDAA4p7Bek6FVOUO/IPUF1cYf8Ou0zJQD
         O94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789820426; x=1790425226;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6VJjBBrsr60hd8B82/VsxfHycDf6l6tDJZDwPshOwf8=;
        b=mMr05z+KmPaWREjFkXXDw0WDijP2qKQR/BMct9fJyG/tn7HaCuAmCuQlFPcw5dAYZA
         hH/flCdj0du0CwvfVq0gMbub8D7ZWILSsmPA08SDCNf4FrkdRRcwQzQSjtQ8XKxuyNMq
         Y9MAbxUbjVaQIM0sby49nDvWhmIvnPRMWXeBjS77dx+8WCywy6AXp/5rFYT8uxn4q4Cz
         hLWptcdvjSGDpI99HmOCiJhob+ROp/d9uyAycD8T4nBuPevuPFjkajcSkAKin6P0Du+3
         0IvmSLoLvc8e/vOdKlhCyhu6Mi4Zo69AviP5Q6CnB/DE55yMv+XzKjUxlSMnIStdCsYL
         Pruw==
X-Gm-Message-State: AFuF++nv9JSWStzTV857NwAYLs245CvFXXHKRR8bVkNjgcM65Phz9vIj
	OU93FxD85uq8YudfwwwtrmoOJfxKot26HNMigcX86ub0/F8ocsRp1pYl5kAqhbSenQU=
X-Gm-Gg: AYBFou1lRjrgzumJQijvbc7euq1KSsCWNjSaLJzH+i/5ZOgjyZRz9EmHNKPEnq/YEi+
	7+pAB5YaLTOEQ3pNgwwOgXsOJRKiyD/wvK+zWCi7QjdTDJi1AIBPz+hXA4OZaqvRqkD7cqMtyCj
	axnFgjvfmNx+giSP2+iBTfh+c0gWpVs+3UihvkNiT1hnoZ4dhRMkPqGhyvi7Ar/l+FC4UCWag45
	JTmLyqWHa4qHaEbo6j88VPnMUEFSCrtjNw6P+4PbIO975VS8/18igJ4FTDCjqS4Vlj+yz8pBdCd
	J1GnImD8BzqS0X01EE8YWNwMrW1wiSwqz2OT9ieLlwv0Do7/WftqWqfk+Z+uqRewEufc8iwzS8/
	dB1gmAVDRW58szHuWrY9zJRY9ZbhzUYdMsKqOD7A/Q7FnYcqkgjjf7d3H7vhSet+04nLPvsF0gz
	jVs57UuJYuBP59uz2xt2ABBSFK90TY4HG6g7kcaS/vWGM4WP7BN750CnJrOVJkfrmFDVmtlH+h2
	3NemA==
X-Received: by 2002:a05:6808:c2bf:b0:4c3:cd49:bbf7 with SMTP id 5614622812f47-4ccf9e9fba9mr5914906b6e.42.1789820426168;
        Sat, 19 Sep 2026 05:20:26 -0700 (PDT)
Received: from [172.17.0.2] ([158.23.190.66])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8107dd8bd19sm2378105a34.8.2026.09.19.05.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:20:25 -0700 (PDT)
Message-ID: <6aae7e09.90f82e37.2dfa5f.274e@mx.google.com>
Date: Sat, 19 Sep 2026 05:20:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3581142266905672862=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
In-Reply-To: <20260919091120.3273038-1-benquike@gmail.com>
References: <20260919091120.3273038-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3581142266905672862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169190/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.76 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.91 seconds
CheckAllWarning               PASS      33.09 seconds
CheckSparse                   PASS      35.63 seconds
BuildKernel32                 PASS      28.67 seconds
CheckKernelLLVM               PASS      34.55 seconds
TestRunnerSetup               PASS      773.03 seconds
TestRunner_rfcomm-tester      PASS      5.65 seconds
IncrementalBuild              PASS      26.72 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
WARNING: The commit message has 'Call Trace:', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14831156.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO

6: B3 Line contains hard tab characters (\t): "	if (sk->sk_state != BT_CONNECTED &&"
7: B3 Line contains hard tab characters (\t): "				!rfcomm_pi(sk)->dlc->defer_setup) {"
8: B3 Line contains hard tab characters (\t): "		err = -ENOTCONN;"
9: B3 Line contains hard tab characters (\t): "		break;"
10: B3 Line contains hard tab characters (\t): "	}"
11: B3 Line contains hard tab characters (\t): "	l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;"


https://github.com/bluez/bluetooth-next/pull/795

---
Regards,
Linux Bluetooth


--===============3581142266905672862==--
