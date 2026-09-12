Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E537E5C3
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240654; cv=none; b=iw0vmN2K3MPsPpdDdjdgOJub5niuN7j78HBj5PyR2Gac+lyZ3e6P94Gdw40XLQgylLp3hyY9uaEnZs9LxDxgfK/xeCYIYqal6Vqyw2x/KCdIu6XhTR5jtHt1OgTm6VHsb9xSNjgU3tmrsiKoWIrbMJNBZx/DRZzc44jyEJo62L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240654; c=relaxed/simple;
	bh=0aDC7pT5suEp4mQcgidk3PdK9f8p9Vs8eNyn4k9/k/E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iwfgG59y4bX4CWJzVgRL+vyguWno+Z+mttuqqHlbSwJ4WtuaG6pAwxmWoWxLbq56/QomoAiYju8VqflWaoDkNfvOGSI/ntJir74M/eYH8e39+mwkri+9ph/Pnl7pgFDeYqkoxmRIsFNKvZT6D0TXF8YX2RqsXQclToNoTn3xLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHpND4ot; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHpND4ot"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c7so52693985a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789240652; x=1789845452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=quFVw8kbAJwW0Ial0iX3swI1OAhutxeml9FZlKUkenU=;
        b=gHpND4otqv71uNaiSMAcbT1YFBuViBMG/1mB4uPfhToIAvgWZHgC7dkcYmvVD5qm7I
         Oc2ciDsrvQFWlplOCcYy7vCgaFO/B0l3aImTDBAf6AcQUeJiATJSuIlJfpNh76EaSoW6
         yyAw/MtcWEmIr1RwuUGR2kn7pIaFhqP2xyksy/ctwDJmn5jqgMxn3IzDn2eDSUi11I1t
         UksehRIFqdC/gVua2yCTtveXJ7Xqy04i+rsZMU2TzDyB1OH32YT8GE57hDn32pOLl9Q5
         o9Vp0JM4jBzMqNpZmS000Le/jg9THQhy+p8CDuW3H9IxHW69Bl++ack4l7mstr1rEv4j
         IB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789240652; x=1789845452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=quFVw8kbAJwW0Ial0iX3swI1OAhutxeml9FZlKUkenU=;
        b=mF/J9majVJpPwQ4oT7S0wVkR+pYhL++i8Ll3xKewsne+eN9AOB6wgCI+9Ok9tsjzhz
         k1HYbbyTJOrTbbC2QlsdT15By5vwlE8ZZF5lezTvqgF8/MoIhlCvvqndxBGvE2YLo1rP
         Rc+ZOCo5mVwKibso7jBGORNQeCmhOKh9C5u679z6F5w7FRV9SvMFuC5ot0867nrHaCn2
         i82aamBirLi23dcmzKtA4+MDB4J72khLysWs/0hd1uO8BoVlXtCzVQzG9G8Ys1VKt8I9
         zHglPLSYp2Bpcx2me5FFFW2rK5lhoKOW57fmEopU9iEcPz9VduXolfmP0c00BpDqfSev
         qGSw==
X-Gm-Message-State: AFuF++lMM+7G2z+GiCOGQjJHoIsNvTSxd5Q18kLKZCdL5WPyFvin32Fu
	4dW6H5P/5KmqR0u/qS1NLAAkOXVzgPCJ1ERrM9wtPblS/O+OWWg1Tm796iopWA==
X-Gm-Gg: AYBFou38oAMV3EQWzCoOUiC9ZIXj/859pNSBnv5qRFXy7gOOW24pL1joUS3ELnnv2A4
	3hBNQVu0hXmWo7iB2qAIAj/hxbGSQeznthMgScFf5lqiyeevJIUv8LQsVEfZUlGEqH97HrVtePO
	z0WL0BogSQ7vEge+WRBLFMis3wbtSVWzxdThlykpl0baxXz5LG/3/3uSQUmPhE/3GSCDNN+pLmr
	a9kxIU9JFvgycw9xOFB2jsHk6V0C/683BuCh9mZzO0/ezgT+lEjavIp6Gk30cBsLBKHdrP2moLp
	EqEBSscAUqfImCy7Te4DA2PIXyoJ0KEl6td8TDiHSNWjgzrYd6JyyVkZtUhD0NBGY/EE5AZ3+61
	CYkx0qJb+H26AiT9jBbHQ3/Thlkqp9r1n9cTzb4gqrjZqNabYM98VCAbg5KDO3xWP3CsEzG4e1X
	5pgShFbA1RXvRgsXGZ9Wq/l3PEVxPMEryeK+xYUewQaRQ7WvNZmO396OPrDsCUzR4ka+7Uie4jB
	1TZwUg=
X-Received: by 2002:a05:620a:371a:b0:936:a5c3:512f with SMTP id af79cd13be357-93a03842620mr617024485a.34.1789240651938;
        Sat, 12 Sep 2026 12:17:31 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.133.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939eeac7b87sm483904885a.0.2026.09.12.12.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 12:17:31 -0700 (PDT)
Message-ID: <6aa5a54b.4c7aacee.39226.5254@mx.google.com>
Date: Sat, 12 Sep 2026 12:17:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0611656321101955151=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: test-runner: use virtio-fs by default, functional test speedup
In-Reply-To: <4800bff58cfc252d23884e711ac3cd709fcd32db.1789237077.git.pav@iki.fi>
References: <4800bff58cfc252d23884e711ac3cd709fcd32db.1789237077.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0611656321101955151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1163573/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.15 seconds
GitLint                       FAIL      1.33 seconds
BuildEll                      PASS      19.81 seconds
BluezMake                     PASS      373.66 seconds
MakeCheck                     PASS      14.08 seconds
MakeDistcheck                 PASS      141.19 seconds
CheckValgrind                 PASS      237.21 seconds
CheckSmatch                   PASS      298.62 seconds
bluezmakeextell               PASS      97.14 seconds
IncrementalBuild              PASS      417.21 seconds
ScanBuild                     PASS      1131.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/4] tools/test-runner: replace alloca() based argv setup
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(2, 3) over __attribute__((format(printf, 2, 3)))
#129: FILE: tools/test-runner.c:81:
+static void __attribute__((format(printf, 2, 3)))

/github/workspace/src/patch/14810752.patch total: 0 errors, 1 warnings, 202 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14810752.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,3/4] tools/test-runner: use virtiofsd for filesystem passthrough
WARNING:VOLATILE: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
#199: FILE: tools/test-runner.c:571:
+static volatile sig_atomic_t terminate;

WARNING:STATIC_CONST_CHAR_ARRAY: char * array declaration might be better as static const
#284: FILE: tools/test-runner.c:656:
+		const char *cmd[] = {

/github/workspace/src/patch/14810754.patch total: 0 errors, 2 warnings, 371 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14810754.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,3/4] tools/test-runner: use virtiofsd for filesystem passthrough

14: B3 Line contains hard tab characters (\t): "real	2m9,736s"
15: B3 Line contains hard tab characters (\t): "user	1m29,570s"
16: B3 Line contains hard tab characters (\t): "sys	0m32,715s"
20: B3 Line contains hard tab characters (\t): "real	1m35,703s"
21: B3 Line contains hard tab characters (\t): "user	0m28,938s"
22: B3 Line contains hard tab characters (\t): "sys	0m7,453s"


https://github.com/bluez/bluez/pull/2522

---
Regards,
Linux Bluetooth


--===============0611656321101955151==--
