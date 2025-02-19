Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE00188596
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932510; cv=none; b=X+32nXDdD/r0YxY1HjLNDm6gMbcHlJqRFdBNhZZXl67xQbUINfLfKkYLZT9iYPIXJKYnwIYUdGN5VCBkbsR/ofrrTGQx37S+tONAnuCMnXE2UJEMiCH/sU6n0GuRH3WtU2Hl0a5sxgVSE6/6/kzyZ/mJYFKZmFpYPJmUhD4QmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932510; c=relaxed/simple;
	bh=YiK1zHv8aFzXf5sJLZJ3AS7VL0FU5vHmNXfofOPwHsQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ozpO4+CV8QB7GvVRp+OQSTyBKkU7dU3VME6vMap5SuzhSnanqXNswn6okDo/PfkluLCtz27BPkkNWzOdTSD3/tH5DbHc8thGvxnLShHZtBj1obeXf5kjpk92yaadjs9P5YC4H06bf7Pm3bLKXOcNAZodvGPJjGr1VXxDSeTgaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQdk37vv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQdk37vv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e989edb6so125375095ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 18:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932507; x=1740537307; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X2sw4Y54VfBwo06mY01AA8XdOOOyNc2g95m79jnpoT4=;
        b=nQdk37vvf1l8isY74lwwMdoAaZKZIF2q6EOHXQu22CwL2yHg/W4pPXUehL9bCI80FR
         ojFva6J/K8Kf+YKfPLgqLm8bOKwkKLaB8BnTg9pq+QY1lr1rFwIwH/b04OONMsCdLvfZ
         G4OeGwJHL40sMtlZptEd6z4Ad9bxakdRerKyq/ChlXef/ckBg5xabvjCmSGf0rYlk2eN
         a4b09XTL4RcYIRVHqxgUTku68T7d1TSz+JAAgtuWExKlxiaLXqP8jX2PhlVigSl1Pl9Q
         rRJXtS9JRFrXDVpNIc2mDRDDjbnx1Q25o+e+nXWLnyPIOjrbRvo4o+9fKZCClm2iZ3nv
         uQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932507; x=1740537307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2sw4Y54VfBwo06mY01AA8XdOOOyNc2g95m79jnpoT4=;
        b=csSfW8WNj6gOZW9C2BaS32BIS49MGmjQ3lqJ/ichiiSRV9lzFUi6Upd1BL+iNO7Yqn
         MOYUdO+VuBGoJq8E2ktIpT0X2DIbn4XbT+gMuTsqIkp8z9gmM30FagvA97OQB/KozGcX
         2/oScfI3087PUrsW5qOL+FER8adErRIhvakf6QzD3WDP/hp5WzdFuZedlBUHOgEMYibH
         4+PbDh3RKyuecn1DlsIKAaZ997AXoyX7CfNBHv7oCcWlAXQDKrXHXs+tZw4fur++GjZi
         HYrqom9GUrWhpHRJvYd/E7sXXX5G1Ip4sPDFCaehnOSx/lKEOU4dcYdBnOXHyLjS7afD
         poUw==
X-Gm-Message-State: AOJu0YzBgwzKJXNb1b7ouaYJpUkizkr6hJFWKnP4tiYS+0m0ht7m+DE2
	GLyWuOdKOTR8sfsautk4rzZrw8LCnNc6XadhDscagmorigTuEFmELrcklg==
X-Gm-Gg: ASbGncs+gx5FiDi/SQ4vFr/HOkU6wxV9WaQR7DFKxH9uvXJooCJsDlySx+Unpvf9/DO
	gQN87t5Dd4K94pvEq6nH/BCeyLN2w++ytrkpKbZrMXqI163dNVfNsDM0iAjAVU/20YqKVqGoPQQ
	qLVHK/fj1wLBTZul48+HQQT7TVFYxCCDWjTqxftZGK89sntFbgd3thqb6400aObX+8FyeM9iOCe
	CHD6GvXHodhlPuNTs1M1gRhayWsrltvlPYJBKBsh4uzi9NPDRhAA667Vad31kgSxfNUTSjIhNNo
	jzWFCrjrAHAH4wGUgzo=
X-Google-Smtp-Source: AGHT+IHrD8pf2CgNgM9Qio6wQ6HjXAtyXSPhAauUAMps+S3i2LE1HNAtAgxnWI8iW27hXsB5OlUcHw==
X-Received: by 2002:a05:6a00:1388:b0:732:2710:956b with SMTP id d2e1a72fcca58-732618f1520mr25206330b3a.21.1739932507244;
        Tue, 18 Feb 2025 18:35:07 -0800 (PST)
Received: from [172.17.0.2] ([4.227.2.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761538sm11155382b3a.139.2025.02.18.18.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:35:06 -0800 (PST)
Message-ID: <67b5435a.050a0220.2604bc.dbf2@mx.google.com>
Date: Tue, 18 Feb 2025 18:35:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2285000046672884497=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v6] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
In-Reply-To: <20250219095610.v6.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
References: <20250219095610.v6.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2285000046672884497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935388

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      23.89 seconds
CheckAllWarning               PASS      26.40 seconds
CheckSparse                   PASS      29.85 seconds
BuildKernel32                 PASS      23.77 seconds
TestRunnerSetup               PASS      425.14 seconds
TestRunner_l2cap-tester       PASS      20.55 seconds
TestRunner_iso-tester         PASS      33.25 seconds
TestRunner_bnep-tester        PASS      5.36 seconds
TestRunner_mgmt-tester        FAIL      117.33 seconds
TestRunner_rfcomm-tester      PASS      8.17 seconds
TestRunner_sco-tester         PASS      9.52 seconds
TestRunner_ioctl-tester       PASS      8.21 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      7.24 seconds
TestRunner_userchan-tester    PASS      5.22 seconds
IncrementalBuild              PENDING   0.52 seconds

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
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.165 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2285000046672884497==--
