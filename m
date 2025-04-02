Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8263FC7
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743563070; cv=none; b=YiezygHHDm8XRD/Cm5EJSjffyghEdY4wZdYZnvscAZMUFsBG8I6vZYlfO5f5tqtjRDvj7816LRBP7cMGk+TdnUdRdyZ/4ibqtEjp6w6bFhJFS8t1Wr/9EW8/kGmemh1LnF3itq3DZozzHdo1jyG7WGn5ftV6CQEpf6l2AhhsWW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743563070; c=relaxed/simple;
	bh=7CWjRhSrwT9+E8qZqzrncCbm2vJSRK4+BKMbaLIxbr0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bKL73h3mUzmF6wm7z3IAe2XL+6v+72xnKtdxl6Ztm4ffgWMjgjuSkyURGSAs1naYq9HQOwR6wJ0UEj99esJKKhSUNRzFIDOWR7Kw4dSZKNUMh6DNGbMIa21Sb4jcM0pK2ZIqe+1p3DqC54oAFDyHLo5BkFL+Vp0hCWVtthVBhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFbxw8J5; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFbxw8J5"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c1818c394so3668092a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 20:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743563068; x=1744167868; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CItwLXy8inGoYbXowokTa6Ty6bhYhNaD5j4OxyI4MI8=;
        b=LFbxw8J5YEsDE0hfoyxn2z2M/mTonBaoeeBk+oW3iP2uguAybI10BCM8KA1FrmCHQ8
         wXbs4N879/0GM+BPYTHdfw8wZMjwU/KrCFgfLhO8erYVX28Yw3WtKyJv8o6BjZOkNVtu
         IAjBgDcn8dI6RhqhAYhEo3QLRDcKUMKrjU9qVgPpLU7qlxqyzBh6wMr8vMV0S3G/kSXn
         GCRhfFw6+ljuswr8C2pVuP4kX5GjKIN0wo8dqRm9MEB2TsdvbqyOlotePc4aDpPBwKYh
         y7cQSSN08Hh/4wumhuiXtJY2IUTlERugdhuN7jRkmA7ZTlr221qTL29xpvOhgu/E2ZKv
         0SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743563068; x=1744167868;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CItwLXy8inGoYbXowokTa6Ty6bhYhNaD5j4OxyI4MI8=;
        b=rl4moB8MfRVrYD3iWRZr8bM/Euh6Zi/JC0g/l4z7E311Ll+6RDKTURkVOdrdjZWWey
         Hi9SpPKOir7rDuC4gd9/4t7JoYUvCr6e+0ZqDvlxnyHqgzRbjq7ojokBLfX7VO45htf1
         7aG6YzqGgvnJH9Amk6yCo1N1jx026Yb27JtM1NJQdJqYeMCEcEDibBE2AfIVEB+jwG4l
         Ursy3QUKC4moccMpzi7TSFnre/C5S3MlDi+uF/9AMFZB8f9YFxgnvVI5jE1/xsFCkLtO
         6xUOPnodRnJsCZ7QcbRWYHm5vELkfV5R/b7ypmExhVQiAmqU+nsM0ttqNuCSjxgNwBhf
         kcaQ==
X-Gm-Message-State: AOJu0YwbMUdMACq64o4xkgdl440JOGhfRouQ4O2k9yO5RlgwodddxQBm
	AVlhJQMO6BMHPqh2qYUaLudH5wl7aQnmx/cGkDEWTNHfUt6L9anvhEs5YQ==
X-Gm-Gg: ASbGncstTwKROgRviTaRiLfHdDaXjuNMZSv8iPGYgwSpqJ5Goen0axcnDj80Haiufyc
	kcnpaSHAB0aefkrXlDCheDLwOMTirdpDbkshKAOe0FS9y0rMzFc9DlclUW8I7/1VlwlBXyok6Je
	ZtsNXDMXJPpSumg6ugxtGtZRlszJomFElvgJEhjaA71z4uTbUqZQPxz/1COHP1O6P9e2c+OBNPP
	L1RU89Z1nuJiX/+qvtnzfFdhW/VBYY8MJ+VzsK8XOoPdedC5iZlORfqifYx2+qw04o+mSCR8fi+
	l0hrBCyik+aDioMQGxnngksJtgbGlGSG7czju8IY5sG2aP52zDc=
X-Google-Smtp-Source: AGHT+IFqQr5XuFXYxLJ0rGxwkXHCnptYiAC/EYh46AVptrZwVWjLHdhRQgW5LItPetR2XoQibS5tPg==
X-Received: by 2002:a05:6830:2a0a:b0:72b:94d8:9466 with SMTP id 46e09a7af769-72e258f7ec2mr672583a34.28.1743563067651;
        Tue, 01 Apr 2025 20:04:27 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.188.225])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c58267f49sm2089824a34.54.2025.04.01.20.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 20:04:26 -0700 (PDT)
Message-ID: <67eca93a.9d0a0220.1202e8.3779@mx.google.com>
Date: Tue, 01 Apr 2025 20:04:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6148240963575462489=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Do not generate coredump for diagnostic events
In-Reply-To: <20250402021148.63748-1-kiran.k@intel.com>
References: <20250402021148.63748-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6148240963575462489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949141

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.17 seconds
CheckAllWarning               PASS      26.69 seconds
CheckSparse                   PASS      30.12 seconds
BuildKernel32                 PASS      24.67 seconds
TestRunnerSetup               PASS      429.33 seconds
TestRunner_l2cap-tester       PASS      21.09 seconds
TestRunner_iso-tester         PASS      28.56 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      120.25 seconds
TestRunner_rfcomm-tester      PASS      7.87 seconds
TestRunner_sco-tester         PASS      12.76 seconds
TestRunner_ioctl-tester       PASS      8.14 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.86 seconds

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
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.137 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6148240963575462489==--
