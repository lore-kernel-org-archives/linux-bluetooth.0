Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C414E2F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308927; cv=none; b=iKNXe7HctHSDohaWTvGs8cygnyVSstMjKiQwbTRyOEOH3GwLO8YUFxSb0iarYKcYrXb8gqCJZb0A6wMBU1FzqUUSDmwMv9GnKP2JhCXe1tqxC9fIy9Yy7wSvzr3FjYtSpc2zchXW6Uyl4NwpIdoIbn95iQ76/vlOldbgqHaGXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308927; c=relaxed/simple;
	bh=HbrcpMa5qSwGXVtOn0EHiV4O9lkrXQamGT6dkyb2bqw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e4go45KR+d/7pIdECQ2KLwx6qj4p8p4z19GT0YvHtfm/QdR9aOP1Kdd12QlAX/CkH5swNF65WNsS0oYRw8trDSNr75oxti0D/QlDjRqL9Zyf2LLCHr/I4EfKTmci+m7NZrI9Ai+T5RZRf/ajGL0tYmb6Es7Uhey9pBtON5XIC7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxtZd3W9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxtZd3W9"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-770593ba164so3297940b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308925; x=1756913725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/E+dCCpDfWbPZq3zT3ddCcbS71AGA26ncsefXUqXUc=;
        b=LxtZd3W9umXs0i9H/s+90EOTo97gJuLsnFUFyXbXB4jVLoZcvAAeJ3Wjy2pkYnRrAY
         4ShNlxs49A0XqKgQG0x/oDPatBPYmdl3niWggkLve2WXbLIcZgNRp8fqsfIUxMKkP7Tv
         MNUysDUWk0Gt0889rLx7sVTS9rEHpdkG+tIXkeEltd2hREeA+IyZZIMWnyqqrJkXOTof
         s361FcBtvNWYHS0LShsPv44xAyaxVCD5R86RNBsI5JNobOd7xLFNQ671HuMaU65zF42a
         bulR0K82V2jZ0WjNxdZ7abLTs8LtRLzsTRHdFM5tVtqAsR0WZstNJt0+hk3QN1jC86J8
         JINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308925; x=1756913725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/E+dCCpDfWbPZq3zT3ddCcbS71AGA26ncsefXUqXUc=;
        b=oFCSJBcd8TAx/8izecND++AqZ+jqm6GkcyXaFK78GeXIcmIkmWQWaIl1m6SrEAHbm9
         1Aj3adZ4NDlwErcl9BYTDyjopEQzn5+bx3M2clJU56zETPpYMobj1Kwhh1HmIRM5YjK7
         FcKSCrdPKMjm0knjHMZPpM9LATzJ+EEcewdGnqfROPjQbTot8gIzI0S6E4CVjQhwFily
         LIcHs7gA/yS3jQN7iTz8JlAQkGFl7LV/vKWVX/re18Su2nGTgUMTPUcUqgf+tlkTDvo3
         N4PwV2OHHizvDb7EYPccKL2AG30nYfcPl56j0MtwZIXuYcJidGePrwA8ju/Z3RLYUrQO
         aEaA==
X-Gm-Message-State: AOJu0Yza9k8UKlFnImPy3ZS7s4Bda6YQk+zoajo04yMQm58VC5Y65Mav
	SP3/AxPpD0TKAOkQLe537IVmLIj2r04CGZ4cbzQdF8uG5ibf9xoLhDrebhIMyQ==
X-Gm-Gg: ASbGncvbK1WP9r+s4TF7g97i59VMBaKxO0Gg5jQ50UMzT+ooNyHpcGigmwJSmoIFfup
	1Ij5QBIhLe+UX8szIE02dvRtTePr74xmam7Nh2qgUANDpcbozquA6/oAibqne8RTdiIU0nA5TJS
	rpJrwSkgw+xx/y7b/OAlYeOWG2MDHCwqN5GKClmE5VBC+Pk/Zygtndu/xkDqmHlLc+k1uEcaY3o
	vfkI0tszibJhDuzK2o0qbEZxgYt2HZpFFNXEMEjvJQEeLKj1L54JK6xU4U21fhx6RvjG6VWitR0
	+0q1iXjf/zkBBImqtbP64NG5k30E/QV/32W1HqeEaKUPp2aHj5tjyBloTHU/5F8mVp4JWv4gQzl
	rtZKzofYJPkQN5mzNyamknrVwuag43t8=
X-Google-Smtp-Source: AGHT+IG5pAMtb0i7aEJdab1MaFeewheEEmmLMbxolztL6HGd1sMZ08NAx2/Ra8SVDpIqkyuHQICiiQ==
X-Received: by 2002:a17:903:1112:b0:248:6d1a:42db with SMTP id d9443c01a7336-2486d1a462cmr89195225ad.24.1756308925348;
        Wed, 27 Aug 2025 08:35:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a601esm124292365ad.162.2025.08.27.08.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:35:24 -0700 (PDT)
Message-ID: <68af25bc.170a0220.37753b.f768@mx.google.com>
Date: Wed, 27 Aug 2025 08:35:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5497527022537923334=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ipravdin.official@gmail.com
Subject: RE: [v2,bluetooth-next] Bluetooth: vhci: Prevent use-after-free by removing debugfs files early
In-Reply-To: <20250827145324.27180-2-ipravdin.official@gmail.com>
References: <20250827145324.27180-2-ipravdin.official@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5497527022537923334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=996097

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.42 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.32 seconds
CheckAllWarning               PASS      26.98 seconds
CheckSparse                   PASS      30.91 seconds
BuildKernel32                 PASS      24.60 seconds
TestRunnerSetup               PASS      479.96 seconds
TestRunner_l2cap-tester       PASS      24.69 seconds
TestRunner_iso-tester         PASS      38.42 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      128.72 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.22 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.176 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.164 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.196 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5497527022537923334==--
