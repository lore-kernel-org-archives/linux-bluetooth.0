Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097C262BD
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774691585; cv=none; b=p/e6kBctYEO5WLx9jtHWn+XOwSTU7/PO9plKYqFSkReYAZ1ajn8fUsJBrfjv/jpmKL87UOLvTR8znByTuN0NIlglCU0A/WzHJp7gf90vP+bDhQs3XrJ9seygp66N90aQs6/0kVMxlp6YfDz0TlCBfZhRtkAuWhDhdBYGAhVRFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774691585; c=relaxed/simple;
	bh=vns9UZ5RQh8ILX3JxfOnaOIqSzzU3Wz7vlTVNlzDc5U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S2eA+r+CwLFr3artqeNPWJzXvQc8BPLLz/NbLnZ6dBN9/aJZ7qfTENQMOxv+ZutaEAUb7Jas1xkVNOftEJnB0SlCuYrZBO1l8xLG+QLMF8VLry+yLrqV6F1LJmkJyKZdXf6MZT0Wtq4HKNdGKMVnP8a8lvxREKclgZA6Jr0z0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnzrJ4rF; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnzrJ4rF"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50b29c4e554so36656261cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774691583; x=1775296383; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U3xlzEz72Cn3EbM7zmPv+DZ9f7vUEpnAwzgj3NHOTX8=;
        b=NnzrJ4rFbw46ONro1gkIXZ+wFcuVjXjxvD/ZxuICgwgoErUHzOsj8QwF57WAOOvPWc
         byj3BBeNleq0OmYwSWFaVdudF4f2x2bxd502Safic+sCgRH9FBoWeZ1tXQKYBmT4fJGc
         0SGgQU6UQHOpMo9o4ZpeNe4311NmlzTqS2E3xDYC604p7HQfEYQW29tgu6xl5YYztlFc
         j9pNZeZzQ8nn42oA0XZnwmUqFmHFOlMQFSZ/q3vOBVu4G1k8aJLR1M13kL/JHlezmhft
         hcoOcXrfWCeirrNNzx6tqVL6gKGoYWV9BoNh3qUcY4A/HfrjJLiPTNScgkHW9YhI7X2J
         VGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774691583; x=1775296383;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3xlzEz72Cn3EbM7zmPv+DZ9f7vUEpnAwzgj3NHOTX8=;
        b=gWg9xv/04NqkYUfeEiiAJnLD60JW+1kieP5sDQN7NvvJQn0kgSXwFaJ/WUgg0/WLbb
         pre1rwHhRd28dX5DwpVNzzP9lIzvigzyrnoGYmSqaXZ8X+AKVgvd/HUsljovBOZUaS4e
         0RNatojZPEqGGDSHfSHgTikV+d7vrE4SHP3YdCotGGApKXmLQBttzUFJJy1Fh5svPgr9
         PBvTjl1xxVq8fcxR1epQw05m2eNtCqp0Khscf5uZcUYx91g6lpplIPN9/U52gkQmv72a
         pLU0aOvLkrBLs8qFnwNPNUixGKxKMz9FOaf60uG/syhTQELgXadAe9GwCERwkfxhCzvw
         DXkA==
X-Gm-Message-State: AOJu0Yw/4MUZc4g6s21Ccs9cxRcQueiqE1pSkRNvvijyDJpU2FU7VzEH
	sEPb08TBFY6z2XmuaW3Xg+unZqDBUdN3K8kDCffjjHvFQNOtIYtcKxzX0uo+yg==
X-Gm-Gg: ATEYQzy6PnTW7MwGyVol+Q46edI7aAz8gZBy3C1fm/QT7im8Wi8hqb1vZHGFTMiOvwX
	dTpUpZ38pPXcCQNiGjaJvffBioM1boG4dmmAt+/Sv1QnQI/HxrGsQmpuds1XB7q07xyXXZJ1XyP
	PJ5OzYev2sg7ObKGfW7MDgZdP1vjAYr+pzTeXroZFLAtd3ibjxF+4mARTz5c2yipw0yrwv9CB5K
	oHPMfsNn1JDabTK9wT4s8zQYwFaMYAtLP2w6A10ZDFKZkILcidiIGr5ZdQnXjB+oSMMvWZ54qtb
	jrk31A9bY2OxBgdRk3YJs8sSGx7nG6W0wvb1IuEXmn+fBJfULRdy6gT7u7VtAy0QSxoDkU6Zuhp
	xZKjIITkEvZY/6Eem5MRCf8YkagGuJP0mIszGWYheiW9WzDwXWaVllNiepJzOvF5ni4bwwGHo7w
	ayHZy3lguY9NRlG0J+ymC1IRVLQdLl
X-Received: by 2002:ac8:5dd1:0:b0:50b:3b54:d796 with SMTP id d75a77b69052e-50ba380f13dmr75284041cf.27.1774691583426;
        Sat, 28 Mar 2026 02:53:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.95.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2dd8d8esm14943021cf.14.2026.03.28.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 02:53:03 -0700 (PDT)
Message-ID: <69c7a4ff.050a0220.1c1d3f.fc6c@mx.google.com>
Date: Sat, 28 Mar 2026 02:53:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2598908245740732924=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, keenanat2000@gmail.com
Subject: RE: Bluetooth: MGMT: require exact mesh send payload length
In-Reply-To: <20260328084648.51158-2-keenanat2000@gmail.com>
References: <20260328084648.51158-2-keenanat2000@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2598908245740732924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073915

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.49 seconds
CheckAllWarning               PASS      28.96 seconds
CheckSparse                   PASS      27.52 seconds
BuildKernel32                 PASS      25.52 seconds
TestRunnerSetup               PASS      570.78 seconds
TestRunner_l2cap-tester       FAIL      28.01 seconds
TestRunner_iso-tester         PASS      36.01 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      113.74 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         FAIL      14.21 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.45 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.117 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       2.130 seconds
Adv. non-connectable & connected (central) - Success Failed       0.123 seconds
Ext Adv. connectable & connected (central)           Failed       0.172 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.171 seconds
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.816 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2598908245740732924==--
