Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5656216C
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578649; cv=none; b=uRUJFsyRKbWfrjuCmgsQG9/hORpyqArY3aD/5+nj7OwoL5HzUxs3W7Rm0oT6kUIoAYQzdI67n0dbAp6nP2+EqSvqDQB5UrVyen7SW0eA8PeTtfmJQOJnLm5Jtw3fbdlNev9dryRjSRXEAM45Ji9Fn9ja/Ig5UIDDkzNG448GCR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578649; c=relaxed/simple;
	bh=UE0mAHXoGhAhVz2g0yaZZJObnSmzjPjfPQyvGm56RhI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LzOZNJM8aiMEwaNHj8+KWqkAHxRkLhZytxBDI3cM62RStRgNFqHn1/X1tRoFqgEQWQTL6fyetmr2llNIszp1LdNgC7zrWEbrb4PoihDr5cZcVBd2qnVK7fxZ0t/SQ7vaBLP5ivytjqEelKIbcXQrSDin3ck9HjOsVfMXavFYDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUhszdzT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUhszdzT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc49afb495so45771555ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 10:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578647; x=1710183447; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QuOHHxMprDh76RkDDrGqk1+BZwQO5MCYXkqEZKKaSpg=;
        b=hUhszdzTxUNbPc0eXwZJAVkYc2DAuUHS2spAFZsTdBJpa1mB7IyAuW4XslpkILnPw7
         p0d79jCIS59gOSudgqjDXDj9hdqrbebeIzaqs4fhJuhODOaUZNGn8LdSg9pm67oF7WV2
         uyL3ImRyZHfNxJlclc3zFr1Aw9OJl16uA5N2tv9RqEcJJhCBVQ5+I0tKmE2BhzLMPYZg
         cPKUIcOyvLatFeGfT+2Gvu/z+Q3cxp1mwdq+mGQA1WYJOqRIhh2Drz1A+IkdgNYjZ5PM
         iky9655UjHEdt8KBy/yuLcOpZ2h+9g1j2dhCoEz2lJ7FukKfQuZhdBuqKunqglQQ8kfX
         dajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578647; x=1710183447;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuOHHxMprDh76RkDDrGqk1+BZwQO5MCYXkqEZKKaSpg=;
        b=DsCCy1Rm7MfCtsSv4moX7hKC7RJ9Co7kBOa/J1vr7VyWUtFqTC4/I/CCLG09/ut+av
         KBcVG4Tvzdc0TG+LAW/UD5NaiTySksg8L9hytx+HU/rQnbZZnIQAPcPbtLeKqVJaQEJE
         dvvNV85rSAvVwxao5O8enwi2zxKwYdHL7Gx6ynZ1AdCyc6oD0GGf6tI+RsDtz286RLM2
         dfVkpi/OEZcApEyh5e4XubkDXwRSv6TANLohkI9xgKCbOZAh2XKwOPFm65HjDbDF3kT1
         dza+Ry0Xav7msilGJPUWnppj8emsE9+xH92+L0rJXjCss9BrLd//Spg4+akuQ5BMX2ox
         Bl6A==
X-Gm-Message-State: AOJu0YyAyFJxT7oV9FEwl2Z05b2hwynsz37RhoVsDZl/o/x6MsbeV1tw
	VeBGGbhjUoobcUTLwUqWR84KsUP2drp8RdanVqLABwyzqJobGgAqmZGPmA0d
X-Google-Smtp-Source: AGHT+IFxRh6jJRQ+aeeRMRQQICyOAMhIi9ckECW4/DxA6jj8ImjKw4I8Exxg5tfLtBf96bR0KD7hXg==
X-Received: by 2002:a17:90b:3809:b0:29b:6272:9a45 with SMTP id mq9-20020a17090b380900b0029b62729a45mr28991pjb.24.1709578646644;
        Mon, 04 Mar 2024 10:57:26 -0800 (PST)
Received: from [172.17.0.2] ([20.172.5.210])
        by smtp.gmail.com with ESMTPSA id i36-20020a17090a3da700b00299947ed2efsm8973024pjc.2.2024.03.04.10.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:57:26 -0800 (PST)
Message-ID: <65e61996.170a0220.2191e.5db5@mx.google.com>
Date: Mon, 04 Mar 2024 10:57:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3481923553909858061=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: [v2] Bluetooth: btnxpuart: Fix btnxpuart_close
In-Reply-To: <20240304181421.14777-1-francesco@dolcini.it>
References: <20240304181421.14777-1-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3481923553909858061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832198

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.58 seconds
CheckAllWarning               PASS      30.44 seconds
CheckSparse                   PASS      35.86 seconds
CheckSmatch                   PASS      97.72 seconds
BuildKernel32                 PASS      26.68 seconds
TestRunnerSetup               PASS      496.38 seconds
TestRunner_l2cap-tester       PASS      17.95 seconds
TestRunner_iso-tester         FAIL      32.68 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      110.39 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      7.76 seconds
IncrementalBuild              PASS      25.67 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btnxpuart: Fix btnxpuart_close

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (105>80): "[   10.980740] CPU: 3 PID: 80 Comm: kworker/u9:0 Not tainted 6.8.0-rc7-0.0.0-devel-00005-g61fdfceacf09 #1"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.228 seconds


---
Regards,
Linux Bluetooth


--===============3481923553909858061==--
