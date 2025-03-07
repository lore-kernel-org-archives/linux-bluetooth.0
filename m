Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC220B7FD
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343614; cv=none; b=Lw4pvWj1sK4WbnDVVZDHlebc2VAwwDmyMzD07aaJ4o2FJMjV0asSikskQUJ2H1Ur8W2q+2MLEW2z4zQx1SHb1WQbPldfesV9MDxeUBf2jWAFDGCa+Nea6W/pZwMcupBhBOSWoaipQewwuXEhnqqRwKpT6bK0GkK5XlWzLB9Mvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343614; c=relaxed/simple;
	bh=x1JhnaXr7SCVd8WxMr74kqalhv9f6+dKyrUB5MukiRs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Mp3HsLGpbEiAUHN57/6crWRzDYyAiM2cOIic5spZyJUDJmdvGW8xE51iNUyZ/rCm5LWovYgqh5B5GiJqVqs8orJMVHgtjDsgQ7aSBN7X63tYzytodFeoaKCa5SFjnaKZ+gQrL0HGZdVy5r9pjRyDza8O8oLMJTE6Cvi3ornNsu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoZ/iV1W; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoZ/iV1W"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0a159ded2so184279185a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Mar 2025 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741343611; x=1741948411; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mciE4Y8R3wMXo/V3IB4gDUW9Pq1abllGbKoODDKjjeI=;
        b=GoZ/iV1WO+EV8ZP3bZjp4Bn8HbMQ7mxmifu3Vb5a+qVyBziu320ZciXd/eButdEa53
         pdKs2HEcRM+UMs5cTxHA7+Yzps+1unigmrX63e/M37NN+ADv/BCr14eV9RKM3ygkchzT
         nRCkQABXrwedKwwcXn5ELJr7WBd8yzgNHp7C7E3ImNuRlddtwFSihZh3phCGhHRl++t0
         E8f2qmsvVZHbqHQdg/KafKOsd2sYGQCwkSmL/DWIPQp7qluHYA0TqmBpdqZ+xHvBJVaT
         MEk3lWqnLFy92JZ/RPI2+E7019Ma8WeCSy4D3YCwVM8uV+Lu3x3BOT0xbY+bjUf9lEuc
         ATig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343611; x=1741948411;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mciE4Y8R3wMXo/V3IB4gDUW9Pq1abllGbKoODDKjjeI=;
        b=PeRDHJ5dyDt72rMSf4QAxMwO0ViMLM07WUadr9IIHl+3J/T+bJieTe+SyzHn1vJ3fu
         x4DV9eLLZpDiK3pDc4aEN2wP3O6yRxLc/PzcHnjmB9UauS0u2t8rFGJUIBwVsFYooMIh
         RpPiUJ3SMOr8x7tlyW2uliF6YDPY6usuZWX8nVcro0EBZpBc5yXIXNwDDX/Hu+v46fQV
         85fs179QRw0uaONcgnkJo0e8+Zjs1LXSGhCsm0RK6Bj6olUBO6njVy2zbYC+CS+MNnKR
         DWJ0VdQOom/AUDPPCuNEqRW+Dk256sGd6YBKPKeNCvh1sjd9wD+kK7/6mB6WdInFY1TR
         Ji8g==
X-Gm-Message-State: AOJu0YwtQqoTe75IDBYPmQFfJaCRpGadxDsNpbgMBVa2EPVnwyyFCsTK
	j0AhM/5IgRZgdIt8jTDqrNvb8svVWl9Iq5WOyRjDKFaWibh1h0YiNuyeyA==
X-Gm-Gg: ASbGncviTX2eaZWBrNQ4JXYMHaj7a7UrGqENC4L08Uipyay2XT92DnJMKLk1Ulq2FqL
	ft3iOtanojX09+atXfwnRlcg6qxzOhc9O1ZaeKhLho3+UTJVxIADRrJRXUidvQuND9sj9OFASM8
	BaQu3hDd/LTrARw64aWUw95G7mYqHicX3VBUHlxPffAbLc3mLc3/K5dTlynIq2v6sU3n3pWRnu4
	I3ETH7wLVgoWj0mBuc/NE+omI8OYynaVnBL7vgMEY0vJMggQKzZnsgnAkHsX87vENIWWQrMNo0k
	4L1NIu2iCEAxHi+JWA1p1pPYA4Rl4j2RqEEnUTkoFx6ouQobQA==
X-Google-Smtp-Source: AGHT+IFpz64dpLs6BwPTPPvqWI+V4qNWeCHD0J5yhyVDRKY79VOPNwcQ9ZRq/CRJVzaoVZckCQFLhA==
X-Received: by 2002:a05:620a:2722:b0:7c3:ded7:6330 with SMTP id af79cd13be357-7c4e167d6ecmr429881485a.13.1741343611526;
        Fri, 07 Mar 2025 02:33:31 -0800 (PST)
Received: from [172.17.0.2] ([20.75.92.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5500973sm227127085a.75.2025.03.07.02.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:33:31 -0800 (PST)
Message-ID: <67cacb7b.050a0220.1446ea.7386@mx.google.com>
Date: Fri, 07 Mar 2025 02:33:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8499465013113361976=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Fix compile errors due to BTNXPUART
In-Reply-To: <20250307080907.218398-1-neeraj.sanjaykale@nxp.com>
References: <20250307080907.218398-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8499465013113361976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941409

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.44 seconds
CheckAllWarning               PASS      28.28 seconds
CheckSparse                   PASS      35.22 seconds
BuildKernel32                 PASS      25.27 seconds
TestRunnerSetup               PASS      447.41 seconds
TestRunner_l2cap-tester       PASS      21.57 seconds
TestRunner_iso-tester         PASS      38.39 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        FAIL      121.13 seconds
TestRunner_rfcomm-tester      PASS      8.11 seconds
TestRunner_sco-tester         PASS      12.09 seconds
TestRunner_ioctl-tester       PASS      8.74 seconds
TestRunner_mesh-tester        PASS      6.21 seconds
TestRunner_smp-tester         PASS      7.47 seconds
TestRunner_userchan-tester    PASS      5.17 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.214 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8499465013113361976==--
