Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2921D23EAA5
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547495; cv=none; b=d/1GQp5JpPfHPk3ITRzrfWyf8Pl6aIrQcX1/CSTLOwROga5AvOlM0RrfJfr4Y7hNGNFN7i5c4YGTyKL+Lbd1oovIZqPlN6Ed9xm69FJXhJIABia7i51CVtbopWhUy0cm2OR0p3QGIq+x3/mwQIy3N2Q1nFuWQa7XTj9WqjL5oN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547495; c=relaxed/simple;
	bh=7YVZDs27fCOXu724KqN2md9r9U5ypBwy2CofewfPv2A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ExRCPBKayikwbvu60EzIyk0uVe0HAXgEt1PZRxJrPlKKb8GZNXNQ/XQJgoag0GmZ88yBbarIHEwL0SVCrmBKfZkaf8UcHWRGr38CxTruFPGBCnSwprwS8NqaGzKl3VBMu7iocnxtZERc4LZENRyW0YF94/loHw4EDV0FQWvKDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhzUU8Pc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhzUU8Pc"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e89de04d62so33278361cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Oct 2025 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761547493; x=1762152293; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/mdbTFE2XSOhcrohS1NYO5+u6k8tHb8jmpwFBoKR8DY=;
        b=JhzUU8PcbsYztMWoTI36++E5E/DLUd94mknpmVNB2boXFaqTLR58vhj4Cnrrbo1Jvi
         6wJQGkQ9DeyT1Ut4SuwnTGfGlsv7kIdtJR5+MXs7DMaxZ3oj0BXMI8baMO37aA0vphr1
         DMtT+wT1/+GtX1IJKU7rcUzl+1Pp7MeBRjx5jJNgp7G+w6mHaZkZ/bJ32jcueHZDCXGA
         blql0p41QBwTGuCsQIbAlu7y68E/nOJYpS29GiqvbLnOOBTH6KQarIH9/oh3zvd93TZi
         JQSTFfrdaOr7A3HEQfWG14cvU3uzaZDqsSASNIt151KAPRUUxreQw9acE2MpFcrnVKWC
         R5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761547493; x=1762152293;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mdbTFE2XSOhcrohS1NYO5+u6k8tHb8jmpwFBoKR8DY=;
        b=l0j4+KM8jZDWg+D5ZrEZStQMOW84P9uMkPvhM1DEu74Cne6Emy28gA8j8v/m1sH1gS
         6pV5FsFmb2tavif1nToriYd4Ab3UW8RTHeUSBN09NkU4UhLdLSacnMbfeBBfcvZ96Smh
         wFetRMeEvUIGlSYqQp/MEGrVx3hoDzhqPFRHx5moM9heLzgm68c7fpGh8UEzY0VJaZMP
         9Y+ejt2x2i3DpW7z5Tg5+OkslEb2d7EbspaipCGxxkRPxnmTnQwmPleS1gOvf7CwkCK2
         cF/AptYCgapNph/4UH6UCKRNk8vjgTIR/QiZvVVU6WL45lAGnYXeDnTCKZchVWX6lotC
         fWlQ==
X-Gm-Message-State: AOJu0Yzh6bgjqrnC2OyFm/hJIWrLa6pW1wMMXieJQQBw4e34W4c9Du1R
	KoYZVCMUZYZ+bOTTZ/vq+LQRiuendnCgdLcph+JSYAbR1GijJ25q3iiC37dP/w==
X-Gm-Gg: ASbGncuqZ/kWNfWuZ60xL+73ZLj/CHrissEeo+0Hyz5CbdX/SoFZHhw7qKNln4vvmRB
	KazjkJd2bSqc9cdHOEAnc4Ssi8/dlAGe6hzAaNzjQd0drrNfJFOVN7jMdsa3UgNi0thOganGAfD
	g8u5cqGUKj4khuFg89Kgo2ecJrY7pZgEqPuWlqsuqy+mbZTWWnNXweWiRp02TLia+KDPFbuYpLw
	4uiNZJ4yy9mvb8p6HcKB7IJ1wP4dAckIwriEqyPEpd61rsfOtkz0KECGpm03eMLwWayb/wEFBJp
	H8Bl6INUpL0TI29z4qAmPsu35MrtZu0riivpbNbiQ+Ibx+1Nw+rF+Y9jErTkaSe1mZag0shcBsy
	Xe30C6onTRQlmkSEvVpoFQKmhfP3ORhf8ZYoMkpJDfs/6kJ8Q9ajq9LRfzD81gx1SVnCk+y/vo2
	VEzmzCJDMIDV95FT8=
X-Google-Smtp-Source: AGHT+IGucQuKb3AjxTknDusNYVCfuO4KpBqKXNTft+YQPhx3iZ0Na/pzck1zUH+esOq61aVqL+6g7g==
X-Received: by 2002:ac8:5a08:0:b0:4ec:f403:3011 with SMTP id d75a77b69052e-4ecf4036784mr39597551cf.5.1761547492528;
        Sun, 26 Oct 2025 23:44:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.30.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48aa0a9sm50047016d6.3.2025.10.26.23.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 23:44:52 -0700 (PDT)
Message-ID: <68ff14e4.d40a0220.33f82d.7c80@mx.google.com>
Date: Sun, 26 Oct 2025 23:44:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2171495878390121683=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v4] Bluetooth: iso: fix socket matching ambiguity between BIS and CIS
In-Reply-To: <20251027-bis_cis_coexist-v4-1-81c4e890fa6d@amlogic.com>
References: <20251027-bis_cis_coexist-v4-1-81c4e890fa6d@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2171495878390121683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016055

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.49 seconds
CheckAllWarning               PASS      27.75 seconds
CheckSparse                   PASS      31.46 seconds
BuildKernel32                 PASS      25.19 seconds
TestRunnerSetup               PASS      501.55 seconds
TestRunner_l2cap-tester       PASS      25.19 seconds
TestRunner_iso-tester         FAIL      33.98 seconds
TestRunner_bnep-tester        PASS      6.18 seconds
TestRunner_mgmt-tester        FAIL      112.22 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      15.37 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
IncrementalBuild              PENDING   0.70 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.098 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.920 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2171495878390121683==--
