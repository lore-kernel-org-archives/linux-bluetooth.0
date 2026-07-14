Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB02356C6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040572; cv=none; b=ODmxTPm4EYMfXjP5vvHygK21RSqKL5mb1x/Zegec6qJ7O/BNCLV9IiyeyyWKnr32xIdFoTSessHJOFr+za7ywoM2g81wm+xvBsumvNacO0ikPxOlcidsVxgsIRHQBAxgnhws0Bip8pLF2klD4JIn3Xp99xDMd03Z0kShm30hJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040572; c=relaxed/simple;
	bh=mZ7+mhuerSf2nxGTKGfU+HqEXkCB+SygYIaWA682/Yo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VwlT4iwT7kLV/AWbDtfDvHTQdSIuosuAvQ+zQi+aqsA7/Tx9lbSQgrHniVtNkFutE4H8U6OHsPFXmmjws4Yt6qpWkMncQsyu8BqiWMMT1XnbhGht/r9cbviCANhW1g/3u+i6QEbAF23st1x2dDjUpW3F2j1PWeFRo9fJEqsomz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2YbPUmf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2YbPUmf"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so815645a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040568; x=1784645368; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iu+30o/FWZ7ekBH9bds1dP3p4z4jF0ZPZS7J96NRTMI=;
        b=h2YbPUmf2F2R2XyMGmL325U2VJwNZR0vKXf87feg+Y142OZc3HbW0kyZiiFhYCGSzB
         GLYLJfkam1BxEp9+80LjzBUd3EMyWB4mk8zK3Ky02xOl1362JBhD987diBHCucSEY2e/
         itXbB+SeVXubt6a/W4mXGW5reQO7bpXwJPGsn2zis7RAJHyomqm3+E+zqnqbySBMo0nN
         KNLRruAFFpWVjWEeUtpJ1ZsiiE8qIUvW505KZqKajpDVEJENcDlvbcrJ7TugZ02jn8to
         HlObgU2SybiX7w4pIsFsKcOBe+4TBchOUkSq7ZJqo8hcApdV/Rr3t9My5766QeuKeAUT
         HaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040568; x=1784645368;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iu+30o/FWZ7ekBH9bds1dP3p4z4jF0ZPZS7J96NRTMI=;
        b=EmzpD5kIBb8H+iT0jj2YEDQpcyQpK3Ce2ClBKGjYTQ9SGR3TDbkmKCI8xiR6YhDkiA
         gPODQd32KzGmsNKpzqTsz2UVyy1C/DL0BiEaS8RQcpgfsHOshH2ULpsydaxcJe1XWUTb
         Zy3eJeK5hFUgtIKsrNw7GUuYZCI5EsyQJCwJ3MtA0M1FEKV5h564Pk7+YGc99ft9puXs
         2/zdIFKa7rX4avurJUx0v5a7xqBmHdD+Z18JSWVHHMNYx/TE+lV7lcohw8mu3Thks5+A
         PirmC1GiSOzLnTguu60qJAZ8XnViUAnyLdw1ohyJpyx4G6w+lQk8j37GcE1YBGqjqm6H
         fNIA==
X-Gm-Message-State: AOJu0YyYG8zSV5VYoaHhFFsdSpAYq/YMOT0mkEdFarjatmL6ad1fh6qH
	KjS6HxjhoHkZaNb2VD7kdSXiTIoeedYf9Zu9n69hGYS1eS771mQJU3Tbmpk0Dw==
X-Gm-Gg: AfdE7clND8dP8YCEbkPvukLQx2IBcaZouyKJ1SUn9aN9BCMyzkQIPXXVDCF2HgByA5q
	ZQDg6f7cSjGoXlKGobOzeiFAsU/6g+07Jmg7ss+gu8sQ1EMsVmNpGDyrOu0PiQa37vKQ0fEwpPA
	Rayvpxdf/mDW2/9KamiIdbIGM8lMlr52HNbjp4407PQrgVyS+UuhGx/pWOQK7W8iASITuTMUoUs
	G2ll0T++kJwuHi3v+EyfAbStOw4O99icPTQUH+q1H/Y8LbPybVvtQg5TLATK5Dg3r5kPuMj1BCm
	524TQURoikHBFmejxDLCf4r0hpXcECLxp0AhUBN+HQZuPhXHJukfoI1F08r+/g6S13KpCmFz9QO
	6k3ky8jG5LSIuhK+dm7kRwOcONtvhe2dv65dllr0Br0lvdRPD1reZUo8M7Cxsg9h9ZREqvaelN5
	NSeMRz9kz9n1VZpbF53NY=
X-Received: by 2002:a17:90b:5910:b0:38e:5e2:6dce with SMTP id 98e67ed59e1d1-38e05e26ee6mr6399609a91.39.1784040567924;
        Tue, 14 Jul 2026 07:49:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.40.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f031ae9esm10031257eec.21.2026.07.14.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:49:27 -0700 (PDT)
Message-ID: <6a564c77.b4a331f0.271e68.7822@mx.google.com>
Date: Tue, 14 Jul 2026 07:49:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0650946409525934285=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, doruk@0sec.ai
Subject: RE: Bluetooth: L2CAP: take chan_l lock in ecred defer recvmsg path to fix list corruption
In-Reply-To: <20260714125209.39790-1-doruk@0sec.ai>
References: <20260714125209.39790-1-doruk@0sec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0650946409525934285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127425

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.65 seconds
CheckAllWarning               PASS      29.65 seconds
CheckSparse                   PASS      27.95 seconds
BuildKernel32                 PASS      26.37 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.78 seconds
TestRunner_l2cap-tester       PASS      63.67 seconds
IncrementalBuild              PASS      26.67 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: take chan_l lock in ecred defer recvmsg path to fix list corruption
WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#139: 
Assisted-by: 0sec

total: 0 errors, 1 warnings, 0 checks, 41 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14686349.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: take chan_l lock in ecred defer recvmsg path to fix list corruption

1: T1 Title exceeds max length (85>80): "Bluetooth: L2CAP: take chan_l lock in ecred defer recvmsg path to fix list corruption"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/438

---
Regards,
Linux Bluetooth


--===============0650946409525934285==--
