Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7F839EA
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706910994; cv=none; b=Z9AXX1knXnfa+4knQ89w/pZvxOAkaR2rmDblSdC2uq7WQxZPwyJzUgPbSJxFeq2LD5NoiX1k/AOpWyacTQd8i0bzZw1CCkLEAlMPViUszGE0lTPyUnJnOg9lULFfHM4zo3qW1xcTEtKMbWoE+ohM6tURxCIFpKin4SmkZJQl/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706910994; c=relaxed/simple;
	bh=1u7F6o8XIwmKEH7PRODWKnFe/x2oCDBYy+stIXHAOOM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o/1kDGKd2gUyhGs/7AcFdQGRjfvns7iUBxI5ngf8Y7xOA4Z+PdaA91h1Dh7dqOqQCMplKmrEAZPWUcHpHWq2CBqn1/+FdJ1RGXGIiqYthaiywlhwvukkczuLdYuJtm6tiSsld1cFBArTMY1KU2b0HxcrhnXJ4axorrbBQ1tsDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRpZWRCl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRpZWRCl"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso2145207a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706910992; x=1707515792; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=POF3Pef3toqe8RFvucU6jFQvU0F01B/X7lSv0znh37o=;
        b=eRpZWRClZC2ECmMhZCYq1qXLB6f96mO02bOS53v+NMyPJfM03SgMViymwnWQRWcG/1
         0ScZvAH6sgGkbtUcUpBq5yC5BGKx3ztU5pGY5H653zJXZy9pYH+t/N6pTuCtbgXh7sw7
         WszOe5o4xn2pM0RuPurjTakvBWJRt6MnZbz8egoG/doik185uV81+y5fwdjL8wPvwTJ/
         FknZyiR4DL0qyYTK1bnNwIUqLg1gpaabaHScWC8csKNYKGNG3CE7iG7WNOiS5pUeOjQa
         cb3Qm0LNlRCr6nV14cejD5UZSih7QQ6g76yOxjdQxDVWB9h7W6dxmorPT+PhhRozhXDz
         3zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706910992; x=1707515792;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POF3Pef3toqe8RFvucU6jFQvU0F01B/X7lSv0znh37o=;
        b=qOqLuw1BvtB8UdCOqeOPs/OIeabXuXVl9KfQi3hGeEkI1CSqSkLUTMQxw/EJH8r6fl
         chslgDPT+1r60FBiFRQfaKGRLkl+BsPNIvXkX/REYh0aJmV7VxTI03GOBdRD+UnLmAWq
         vlUfMdd8idasgza9HF4uX7sGHIHZNqHqCnc1zbTx2yG5vyJ8y0ge9AhRQypm8lyhzAcG
         2sMgVY6XEH0EoZV6TlZNytFDa9WGFVEicWMHAMRTmLDNSjN/LN5RyQFTCVBsNUgGocDD
         wfQWU6ZiURG8CJ5culdaFFCTfeOCtI5/DijbFYpS/HTV+52pLcn0zRJHX5orSj7SFbjc
         FYVA==
X-Gm-Message-State: AOJu0YxAQiQpSVlXS6zQ/loJMHhcDedRAjYOzSKfrGkzdT3c94VGxyfL
	2pjXP0ePuXjR3KKtlgrp80AFEU4fZ12SuZd//XHRIsK5U8bCmqLLSn9lzYue
X-Google-Smtp-Source: AGHT+IG58k6aZifLQrKVAml10yz1GkWcdbL6lE6uGDg3jvXuEFO8SYOuGU+oOJ2zyWZ5XBhkdLTIzQ==
X-Received: by 2002:a17:90a:d18f:b0:296:5abe:a862 with SMTP id fu15-20020a17090ad18f00b002965abea862mr1352064pjb.9.1706910991582;
        Fri, 02 Feb 2024 13:56:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJsR+IMqvLbPRRhEzhQwVlbU9fOjiRguG8e5vPjkP2JiOzzPzGBXkbhJPi34nl7lpzX26SO4Uf0DctQXQMBhRJvHRX3w==
Received: from [172.17.0.2] ([52.238.28.77])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a868600b00295f9a4a338sm506689pjn.36.2024.02.02.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:56:31 -0800 (PST)
Message-ID: <65bd650f.170a0220.feebb.3ac9@mx.google.com>
Date: Fri, 02 Feb 2024 13:56:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5088507930909494030=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: [v2] treewide, serdev: change receive_buf() return type to size_t
In-Reply-To: <20240122180551.34429-1-francesco@dolcini.it>
References: <20240122180551.34429-1-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5088507930909494030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818742

---Test result---

Test Summary:
CheckPatch                    FAIL      4.12 seconds
GitLint                       FAIL      0.46 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      27.70 seconds
CheckAllWarning               PASS      30.49 seconds
CheckSparse                   PASS      35.96 seconds
CheckSmatch                   PASS      99.61 seconds
BuildKernel32                 PASS      28.31 seconds
TestRunnerSetup               PASS      507.40 seconds
TestRunner_l2cap-tester       PASS      17.25 seconds
TestRunner_iso-tester         PASS      32.68 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      110.18 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      11.18 seconds
TestRunner_ioctl-tester       PASS      7.89 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      26.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] treewide, serdev: change receive_buf() return type to size_t
WARNING: function definition argument 'struct serdev_device *' should also have an identifier name
#425: FILE: include/linux/serdev.h:30:
+	size_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);

WARNING: function definition argument 'const u8 *' should also have an identifier name
#425: FILE: include/linux/serdev.h:30:
+	size_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);

WARNING: function definition argument 'size_t' should also have an identifier name
#425: FILE: include/linux/serdev.h:30:
+	size_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);

total: 0 errors, 3 warnings, 215 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13525933.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] treewide, serdev: change receive_buf() return type to size_t

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (82>80): "Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 486 (97.8%), Failed: 5, Not Run: 6

Failed Test Cases
Read Ext Controller Info 1                           Failed       0.082 seconds
Read Ext Controller Info 2                           Failed       0.094 seconds
Read Ext Controller Info 3                           Failed       0.088 seconds
Read Ext Controller Info 4                           Failed       0.085 seconds
Read Ext Controller Info 5                           Failed       0.101 seconds


---
Regards,
Linux Bluetooth


--===============5088507930909494030==--
