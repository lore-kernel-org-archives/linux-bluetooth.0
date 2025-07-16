Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544A2E3715
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687422; cv=none; b=UAu/rgOXwCrc+hec0Oa7ML8yKpg17D7wakFEAiR6ilE/Mr24nMdPqZmRIpQ4FxY22PdWkZ9UI4lX69ZfRj7mZF/mtTLUazDJ+cX5AzkoEu2KHE21OCBdZzrF588P2ZPNTYFfgI6oqbDzCr7zsOcHcFPAe/kCMUnXlMG6mY5XWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687422; c=relaxed/simple;
	bh=WyC03OOfGDQudNUqC0Vb44QP171Km+FMYMZ5unN2yRU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iik5BH8Y7c/bVlAMM+px+3ORPxC9QjZI5qbnbi9JYbxf32UQNO+gBsh2ztoKUy5M+E/sEx90S1CMOUak1e+C62rNgLfYEilRUXGr169WBWvZQlUK411jtP28G6o0eKJ2o+qBKCAHsnF5vB3TMHGQ8SYuiTvv7LfSOoVDjoZBbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F22QcL5C; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F22QcL5C"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab6646476aso939101cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752687419; x=1753292219; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OaB2whT4oOKDDrJSfO24qVs2feOn5IolaSgkUJAkKoI=;
        b=F22QcL5CIU7pvuJGGv0XODcgrSsTXNdOUEnXnWMZLKBYhim/TumQJClgLk0eJGo9eH
         2HQsjbVqwdaIvhQ6igj6ikvr5D2XQGakwXJJZadyKXEHBgbMq1hRj+0G4YndjHUy6QEt
         DpBkpmhtftdODJbOPLWVjQ2B/7qZjQ6T3QmuevbQBZ9v6VCetla2Mon0BV9sg3XPKE8B
         c39LYEFe9wvEWJl+WsIejeGZAq0Xm5mY9f+g/hIrmocvaRk7fUmbNX2Zq1ADu8i/q+Fu
         GLFejdTkIvaYbeutZBrAdJUp+dQVHZZ7DeMuyeLjqZa8GCJWVBGUP7zSPVxKGFCs9NIT
         jm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687419; x=1753292219;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaB2whT4oOKDDrJSfO24qVs2feOn5IolaSgkUJAkKoI=;
        b=RGnFaGIVONZULZJUy/Ep8bHnNwdDbBkJTta2H9WQ1G+VobfjSuqnvLTxi2TeQiHDOa
         uZ3vZ3zU10Ikmw6lnWNSnve5ffMfFnvC1xXRBySKMFfY2gR7rAmmbfq58ageC7j31zFJ
         3ELKqWCLd4yo10J2pT3Xuhx0sxx8gpxSf5iJ9JPnzBCSnOV/9pdYcd0Zw21AR/dndbkB
         MWOuXMj1S/mecP/sOywDH1bjm7ju4XJT+3tGsXAP6rygqXyYyuDSIsMbsKzSAbG5rsDa
         j4ppX5Giem7WAwmZbX7RIBmKnARlFCIBMM3H/kChLKdqKcnhXYPu5t8IRgmsyHkXwmle
         HVmg==
X-Gm-Message-State: AOJu0YxcL6oxRaw+fxO7oLw9wjSGueLJ1lHHzQRaUr3PMimKDPp0/WuP
	R3iL1OrmUjIDHFq42FGZTE/sYkLlBER4A8El9P5SMbZSh4me5P5Sg01r4pxdJw==
X-Gm-Gg: ASbGncvwTFwLtOHD+g0ceZIi2Vb5jSnqngJT/5P5YWz6/dO03AKoifQXWkFjZrdMmIP
	9GjOlyNf6a24JzYXjWalAkaY5F4TFgUChEaCAtDkFBLiTwEFWIvgdJ35beQ6GiVze4vfeaYsTNc
	N8V63r0VuYD6TpzBAN2souJT6kpXafxwY3B/ZiXggGw6+b2rK3nfDRQvHgYhV37+CKABXFGokwv
	sphEE++O7tFzMJGKjbYDAGC4csRsPDbOaUnLw3t5bmP8eJNFCisThJBI39Hkc+B6iPwtAcUVjnx
	/zKpxSfzB9FdN5RfVIjuPu/Dsk7B3/SRm5c5ZVQUKCKToNZrsQM+F79kD5Pq06pxcODo4tFpb2c
	rHkmqvIyd9SfhO0o+HX6ykfAS2NT41os=
X-Google-Smtp-Source: AGHT+IFLG0uBRQH9ngL/rj66i37R8AB+CurQM1IxJaVl/MuGuDX16Vl6NxK7FxlDWfZZVrSeO+DG+w==
X-Received: by 2002:a05:6214:440f:b0:702:c4d8:ec02 with SMTP id 6a1803df08f44-704f4aed57amr60826436d6.40.1752687418979;
        Wed, 16 Jul 2025 10:36:58 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.132.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049799ed04sm73481216d6.6.2025.07.16.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:36:58 -0700 (PDT)
Message-ID: <6877e33a.050a0220.2c7ec1.f462@mx.google.com>
Date: Wed, 16 Jul 2025 10:36:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3383490182528354884=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris@chrisdown.name
Subject: RE: Bluetooth: hci_event: Mask data status from LE ext adv reports
In-Reply-To: <aHfd_H6c9MheDoQP@chrisdown.name>
References: <aHfd_H6c9MheDoQP@chrisdown.name>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3383490182528354884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=983051

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.17 seconds
CheckAllWarning               PASS      26.64 seconds
CheckSparse                   WARNING   30.08 seconds
BuildKernel32                 PASS      23.90 seconds
TestRunnerSetup               PASS      471.53 seconds
TestRunner_l2cap-tester       PASS      25.45 seconds
TestRunner_iso-tester         PASS      40.15 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      132.04 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      11.75 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      6.44 seconds
IncrementalBuild              PENDING   0.78 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.216 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.198 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.276 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3383490182528354884==--
