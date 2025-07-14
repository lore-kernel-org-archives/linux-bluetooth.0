Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD572600
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482593; cv=none; b=B4rstZaLGVPeNgiPEuFrV8V6ejGir6sTPNBsO0Tv0KbyT/H5jwOlP9ZynG9J3e+q6QU/6C3z20lGF745dBpyhs9VBGwUvG75ubpP+beBaAoohcLWYXrJ7M5wAYWYOH2WxoUN507oM1wHpKYUKzoTF+a4lDsG792v3xlxyFVnfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482593; c=relaxed/simple;
	bh=SX7WnWVWWU6zXQIkMp3d6UsjA7PdmI6HuHb+/ogw3KI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iHvavszJLGkA0/ML3uJIZDV553ep8o+JjTtS4NaKbnkrEXtyO7K9X+4qiVjyRXHae7VItCq6+w0aKLURrqxz3Rih1EZjHxKGGiBI1tx8nKVUZRHg8w2zTK73J/OiyaLyKqmX/TvKqOi5i5gq8lXozPyRp4tmix/XAFjHTq8kAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6j4Lu1J; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6j4Lu1J"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58d95ea53so50216131cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752482589; x=1753087389; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EKW4lpVVhL0uPFpdzw/wv9t/56vGZ3ZWJnr5dVr4Gn8=;
        b=C6j4Lu1JUGXyAA2un6GC2bvGJHvnVjoqEncHqOLgkvqpfpdF/31fgO205z89wkL9wI
         arTBK4FCj3hJe07T9hOy9wrCfs+Jye6h3WzhmqM9pbTOtterj4LtZ3zuS8qifLudml83
         DBIUdStT+VJ4bhxBhwxWS9QJ3rviMhLFmYpE1CTrOkr/P4V2qpmbAjaaQHCh4Unotf9o
         SoRBXu9v+Rwls9QGMNKFM5cuW+azx60/5svXoV8oIaKFck61l18c17pMIVkA6svitRHd
         q8S7VcOw4RGLs1Jefe49dqk1TjCLTicp2J1Wz1oKr2Y1ayv2HFtg7ymro290Kpm8g9yX
         JNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752482589; x=1753087389;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKW4lpVVhL0uPFpdzw/wv9t/56vGZ3ZWJnr5dVr4Gn8=;
        b=mHnEjnM7rjdWcw7FFhxEYfcQESgtAsL6IuX/puNDfJvEyv43cAiSxCMYlHJIdMQWxn
         E+ZK38z3WoAeecp3YiDMy/rEQpWbfRqT8+Ikc6CKj3rjAaREZA6rEbFHMF456/0p33CY
         HogFrJWkgt2Z7GgNXPv/kDExxPZYVOEWf4oCDxLP2okK5SAKo0y1dr5RYTG5ld8H4vOS
         PoO6G9QwzVPAEg2JXvq7t6TSd9QhUq2LSCZuQr1ImcagdXhvblAF+UqLqkhYCH05S0X7
         +DH21Hf7qWXh/RsNF5bcoS2+A+Si8LSfqQqb9TpnHb2sAEPfs12x1fiv9m1fHE5C+9Me
         whCQ==
X-Gm-Message-State: AOJu0Yy8WrZk7GsAu3i7mIxLk4yHn5UdPerNLRgkmWuQPjl4H1EBo9vq
	jMV0qHCWu01HIjFmAEaXYEqglh4vdRg5Yd24TogBMFiP+pkHSTOFDC47HEVmghfe
X-Gm-Gg: ASbGncs67glxU6xI0LCMGp7/wFqNDCaV9PnjbQLfW4K8Q0+XWT+yVdBhGXLCkBBKxSl
	Zt601GpkPTSqfk905DVYu6hSlMbk7tnxIkx30KGYUym0pKbXPs3STIEbz3/zozMF9jq/PFBMpyO
	X9ocBRXXp2qrWvjYyT/OWW+G1ThnZjFWd0y9T0wIS7yR8P2JFwNZTVVkao3fH0goLtl9NvctcAM
	DsKZY+y/51/liTHC99P5rwYDUbRrNw7IUTbeho5Ef3Iy1KN2Nfz/1TOOhudU2pBvDMHNbrNsdWH
	kl+S0wHIFToAghhQ2add1kmXoZUtnPtYuI/X4KcxnZ6khns7FEUHl3bWI0PHrcNkPPp22620frK
	Bj2t1zG1SotHuo9dX4mZVdBEV/Yq8Iw==
X-Google-Smtp-Source: AGHT+IErshDkYW6rafEaVNTstNac7TQpQZXpD3i42Ry61CbqJqjLhkZ2tdu70KJ8Q827nqUZphwzKA==
X-Received: by 2002:a05:622a:203:b0:494:9d34:fca5 with SMTP id d75a77b69052e-4a9fbb2cb62mr181373901cf.13.1752482589455;
        Mon, 14 Jul 2025 01:43:09 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.86.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab602cd0c9sm15622971cf.65.2025.07.14.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:43:08 -0700 (PDT)
Message-ID: <6874c31c.050a0220.39f4e.2cd2@mx.google.com>
Date: Mon, 14 Jul 2025 01:43:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6169893904563491122=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] Bluetooth: btnxpuart: Correct the Independent Reset handling after FW dump
In-Reply-To: <20250714073016.1703837-1-neeraj.sanjaykale@nxp.com>
References: <20250714073016.1703837-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6169893904563491122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981936

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      24.85 seconds
CheckAllWarning               PASS      27.26 seconds
CheckSparse                   PASS      30.76 seconds
BuildKernel32                 PASS      23.97 seconds
TestRunnerSetup               PASS      482.23 seconds
TestRunner_l2cap-tester       PASS      25.55 seconds
TestRunner_iso-tester         PASS      50.31 seconds
TestRunner_bnep-tester        PASS      6.11 seconds
TestRunner_mgmt-tester        FAIL      136.49 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      10.49 seconds
TestRunner_mesh-tester        FAIL      14.84 seconds
TestRunner_smp-tester         PASS      10.01 seconds
TestRunner_userchan-tester    PASS      6.41 seconds
IncrementalBuild              PENDING   0.57 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.221 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.208 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.096 seconds
Mesh - Send cancel - 2                               Timed out    2.004 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6169893904563491122==--
