Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC398396B8C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427694; cv=none; b=uZfx55kFALNt0i3rHD2PFuamEQdBB+EkU+M8UEkEGjMruN9s9F+R8xWiV1h1XSvtMMNaLUJlTObOMtmiY2gzZgNRER6V7OLAE16T1qvwa/uA1IEfJvMmZG9xrtv4bUjhO1/C+rk7XuLuJGmWCCNVLeC0jbB2ulqMfN/c1W9qnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427694; c=relaxed/simple;
	bh=aXz8S7RjF8A505KCa+a7+pLiBHLJz6ujgxDO/ZMQqR0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RHHAwDcofeA2wxlmiJySHK9qDVboAmnWyYyY/N070vFh7g8rNhkB9s+o+qnOIBB2kerDVuTRAw2JIDzQJO8DNvqiL0Y0ciaHtlOOWQA9tCmzcyiDz9NL6guMjhsDrLzoxQj+eYhy8z/+YLdhH/0oCW9sgiZs+bvfZW8ERRhDUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgvAtfYb; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgvAtfYb"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so51765716d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780427692; x=1781032492; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2kHrV/NlfrF9PO3koj1Gc9lKOE+z4g+5AJzLuIy6yp8=;
        b=mgvAtfYb8XzxzJKciMH+N3c2EBjR8NsU+dnmCCRLrkDkLGt3N5on7CUn/PzIWcRQiR
         jqs+Rx6B9PeNy28ga8RB0TcrsNH1wPcRCXCjlW+ftioYo01ec9Z9o1EEUuGR2KNRxsT3
         QkTFMRvJyxKAvH/CflOtFQgG1FvvwSpQuHnoev47w0SD31nME4JWLWhkYqQXERKXiKUS
         B4V3U4aWC5BY0Nd5Gaxb+jtwzUtnurzJ4wzJQ+iAbnak0/UaPdP3YhezFcYReUsOpJ3C
         tcRvSPP3lYgB5qnE2Fzojx75eQNenFuwPK5ZQmk845N7qCb1LcmWEQBlwKI+MUXuj/7o
         xxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427692; x=1781032492;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kHrV/NlfrF9PO3koj1Gc9lKOE+z4g+5AJzLuIy6yp8=;
        b=GjBJ/S5QRcOo5eya6597kEn3Wz8Z9VgpdoU04gWrJF8ECYWylrUn5CxC5SvBGUl6AQ
         bXTXjUM5Ds4JUNJpaamkOWMEm4SlYvdb3B2V/55dQ+BWiqlzwZRO6z7p6yak4u2uKJed
         IXNiXOmPLXF/z1O/hAu79887z2p3XP48MOR3wcAPHVRXlD/nN1m+Gg+T8sV0Sg+dZzSz
         xSkbHqb5diPsPM/7LjAHQyMzFrX6oBQzc1m0HQy9aGXeGknGhb8TeRbPbexGit5L46Ue
         Lmh3spi8wYXypENp4Ousn2Gqd4Rr6nMbc8QLYMAev1wkBokKlsQc3oluB36MoX7cy/4M
         cUEg==
X-Gm-Message-State: AOJu0YwDEBeDx1I0w75oq7QqyWNfEzzQ1di9nMaogBj/0AcrYnysUkxp
	HUXt0gOQuI0lnfDddP7lKYucuEV7+9jtVV5LZ1lzzmYe6pO/KEn6h8+jYorVLw==
X-Gm-Gg: Acq92OGNz9ilkbKCmD6CsBdLDmjtlnMZY5M/2fRuH97r3R97utKILKVtSNEJvyIJARS
	lf+cEBTrozqMG6u/4HHKxFlxXxHskAq8HtUrOa99TEgOlbIegF2XuI1gONaZwV3oEuq/TYkmauL
	1HpmBVWYm6STcf+tUWa49dj+3T9hXfHiLa6BwnqFtg2DNScI7ZAIbGbfmryejsjTxUjYtguiXAj
	D5WsDLlr4dWOpGCW5M0d7zeZHHsn+Ix7NnMPryZOpjeT7C62Zx9YRMRi4vJDZXhNK5oJZklTarD
	q/DLeepqswxOijXr+ZQDa2IwsvaQR0LIfCvf0VTQUBQvAZuDwFrJYq90EjLYhJYireLW5BbhPj7
	ioXzDYft32lgPhvSLgijbpN1wIXh/n9JlxytYOqCR6T3BF/mvJw0FJEZMerJew1jMYFZWBREFI3
	sGrp6y5Daf2MsO99P94PFOmQRG3Fv4Z1F7rE/SZL1bFw==
X-Received: by 2002:a05:6214:e69:b0:8ce:c26e:b75c with SMTP id 6a1803df08f44-8cecb2593a4mr15447786d6.10.1780427691795;
        Tue, 02 Jun 2026 12:14:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.95.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda2601sm458886d6.6.2026.06.02.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:14:51 -0700 (PDT)
Message-ID: <6a1f2bab.ff298dd7.3321df.a21f@mx.google.com>
Date: Tue, 02 Jun 2026 12:14:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2761713654600875759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bestswngs@gmail.com
Subject: RE: [v2] Bluetooth: eir: Fix stack OOB write when prepending the Flags AD
In-Reply-To: <20260602170621.1454711-2-bestswngs@gmail.com>
References: <20260602170621.1454711-2-bestswngs@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2761713654600875759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104768

---Test result---

Test Summary:
CheckPatch                    FAIL      0.69 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.67 seconds
CheckAllWarning               PASS      27.02 seconds
CheckSparse                   PASS      26.04 seconds
BuildKernel32                 PASS      24.01 seconds
TestRunnerSetup               PASS      529.67 seconds
TestRunner_l2cap-tester       PASS      60.82 seconds
TestRunner_iso-tester         PASS      80.07 seconds
TestRunner_bnep-tester        PASS      18.82 seconds
TestRunner_mgmt-tester        FAIL      215.41 seconds
TestRunner_rfcomm-tester      PASS      25.46 seconds
TestRunner_sco-tester         PASS      32.57 seconds
TestRunner_ioctl-tester       PASS      26.03 seconds
TestRunner_mesh-tester        FAIL      25.87 seconds
TestRunner_smp-tester         PASS      27.08 seconds
TestRunner_userchan-tester    PASS      19.66 seconds
TestRunner_6lowpan-tester     PASS      22.53 seconds
IncrementalBuild              PASS      23.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: eir: Fix stack OOB write when prepending the Flags AD
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#136: 
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8

total: 0 errors, 1 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14607518.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: eir: Fix stack OOB write when prepending the Flags AD

8: B3 Line contains hard tab characters (\t): "	memcpy(ptr, adv->adv_data, adv->adv_data_len);"
16: B1 Line exceeds max length (82>80): "  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data (net/bluetooth/eir.c:301)"
39: B1 Line exceeds max length (81>80): "v2: drop the kernel-added "Flags" AD when it does not fit with the instance data,"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.247 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.452 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/275

---
Regards,
Linux Bluetooth


--===============2761713654600875759==--
