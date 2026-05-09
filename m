Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B638F25A
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353123; cv=none; b=RxNT+z3xHG8JfXhu77IXGvqPap3NI/UeZn8Zr8fE/RE3xRHUeUJJa9hxvjoQ3BEvWuqEM1v6rv+V+Gl2xrfxLPBp+QeLSq05pzFvIFFy/ZvyAnhsEW1pv25fAYvwZamd7JtiSQgUK4Zk56VPvtRXHYC2Fc/bVb/Irowe/LSKvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353123; c=relaxed/simple;
	bh=BKOvonyfA8504OxJ985OP+ijlAU/6fjwUif1FvTeiik=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dADoS6BqVxbuPkI7uic7nhIHTwgopCzV+AbDUxXFTqtp3IHdUlVnTGOeZiHVrXRQSIkwcX3gXhdutV+oUerQrYZkbrb+FT4pbS2Xr7xHvs8fzPDLM7Gkq4fmOgSHneQ5YD37xBZY3cFEgOGotJ2sJKYEeximsCcHmcWQf1qwOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GroqLvRp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GroqLvRp"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d68f702851so358521285a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778353121; x=1778957921; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hVBxIfgax64umZ0NTEwwqDqbyZ9ojGjci2EOgTkn+qw=;
        b=GroqLvRps1iiMVDAViu6zWadK9Wfnnupp1XlgGdg5+GUvIN96/b2pD9NtY8jALIgtv
         Oe2UI55V8XZmW0Gw534zN7ajjCIhZuUjla5pD1Cy/z3xCD4I/0Aho5j6FKBpNpX0v55F
         N1NFNv0mYLGSKOqK8E2Dpsu3lPYpS9Lqwd9idiaq1sTDTNh2QXGIln7zjEQJpb7Xdpd8
         yZcbx8vvmn4onPjuXZTjc/z+EXAcRRZFI/lu9ehvUvB/chzw8Eq467M0qGU6mKbbHXRz
         5duaqduZ1cp9WNFNQyn6nXzNsd1JcmU4B+UmthqNgVxmCLbSCT3u3AcdjMOBf+aOr/4l
         ftEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778353121; x=1778957921;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVBxIfgax64umZ0NTEwwqDqbyZ9ojGjci2EOgTkn+qw=;
        b=d426GikBrPAglZP0UkijD38hWcgV2Ee+asvOeBS1o5JesG0jhakJRjz01Z33Y0atpF
         RkeNNAsPpP6+yFUlFmlfanpG4pD0g3EfUc5c/sPmw+Pwv/eA3m7uZAhq4MWV8yfO21fm
         gAPyX+bMYtNyt78xFOC+wYO5tOo9hPnUQCxvvR4F3sxy2KeFrcuxFSRECp5OGefOj04Y
         yyN/pf0VbCoG3VVbR6/91cDPXOm1lplTheS4dURB9YEA0qJPknmE3VQppHEzS2WVwvwv
         cSz72gJpAO280lFNthlizXTkVsQokaJyiN8a3AyZq+vRd+g6eXwIU24cpzrDuQgVocEh
         7/HQ==
X-Gm-Message-State: AOJu0YzOejRlu/SWtciXmUu9bX7aG4rAdRukp3utfrofHrsUSOzjW1Xr
	yZixH/WceLGNdpyiLRJJQGmiUW+H9GCJY/dMPtiMay5TZCYAGKDMm5QQpEKWSA==
X-Gm-Gg: Acq92OEqQ+JS9IiF9wQIc0zxxy0xJd3sfQA9s3SnjmFR/lgwm8lOafOedsZdcBrBD8s
	Pm0uqDTg0SF/WUoGbLUXVpE3F+kwvLrz9FcAELizuxgoYvfqzy5ct+LSCIxR9/vtgsn2Bjr3vQH
	yvP7EHrrimgP9Apywhid2BhWs4cLXCU5B/RuUvG213Kr5SUvNKGHwqPoaKoQBTDnJoP2wIyXF3U
	4WvDFEE8k27e8EZuJ7GnBRxvKRJ9gsghcbFxBQRfETOvsC9+i/HP7aJvbKJZN8/Lf46uHTMFbS+
	Pur5fTjLodUX7QyZ9YLvkrUiCakSxHhPW/1O63wNroniX8HcGs4NafLQg/yv4T7fkRc4zMvSzkR
	Ez082zn0cG475XRSWetkEeT22Rcv9H+jHVHxMteUM4Twi4T3rlAsvfUNabyv/sg+8r0p5lpG92d
	zZhsSvD6QUy6VoKVQLx2znESmoZ8tdt36VSpUQp+/aFw==
X-Received: by 2002:a05:620a:2950:b0:8cd:d91f:b61 with SMTP id af79cd13be357-90910c151a3mr484381185a.51.1778353121073;
        Sat, 09 May 2026 11:58:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.149.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm2658526285a.39.2026.05.09.11.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 11:58:40 -0700 (PDT)
Message-ID: <69ff83e0.050a0220.1404ee.6c00@mx.google.com>
Date: Sat, 09 May 2026 11:58:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5900526852457161779=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: Bluetooth: mgmt: validate advertising TLV envelopes before parsing
In-Reply-To: <20260509173708.411850-1-rollkingzzc@gmail.com>
References: <20260509173708.411850-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5900526852457161779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092077

---Test result---

Test Summary:
CheckPatch                    FAIL      0.60 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      19.18 seconds
CheckAllWarning               PASS      21.24 seconds
CheckSparse                   PASS      20.64 seconds
BuildKernel32                 PASS      19.26 seconds
TestRunnerSetup               PASS      404.83 seconds
TestRunner_mgmt-tester        PASS      2008.13 seconds
TestRunner_mesh-tester        PASS      55.00 seconds
IncrementalBuild              PASS      19.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: mgmt: validate advertising TLV envelopes before parsing
WARNING: The commit message has 'BUG: KASAN: ', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14563149.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/159

---
Regards,
Linux Bluetooth


--===============5900526852457161779==--
