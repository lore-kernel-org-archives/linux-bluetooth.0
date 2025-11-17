Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B29B2853EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349538; cv=none; b=rKFkhhzCz+ry0ZHpSaD5Ma/L+A5ZxalKX+hV+y1ehaiUBI9AO6vdgW5wuxzN/J4RoXQyYbUhldk0VwpxG7IS0ZVUYqWDBcV0UAAiDvHEgvWBJ1s+l084jp7ksA5lQERQN26yh3IzhEKyKGnIHXqNeREbKfkJg7eXukoL9LwYAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349538; c=relaxed/simple;
	bh=rfFeo4p6GSmQRWljCMFsLQUeKNyDlNWWEuKq8hF2h00=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Izrn5qp0tq6/Rn0o9SRSZhpjYVMsYTJ0V9hh2iyEHz9SO+xylJS3jyBtKIJ4jweV3dG3ZYx43kg84KiB0ZyTIcASPi4sw8x5VyoVFGGXJoSq6vdGZNQEHQ4R4c0Ekg+S+4VTRDoztQidpjEbjN94UW02iSBgjZP4VRZEgJ3kLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m49U56M2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m49U56M2"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b21fc25ae1so398145485a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Nov 2025 19:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763349536; x=1763954336; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VgHcryMU4+co4UsLmRrpjs6X74MtBrWPq8vt+QmPibk=;
        b=m49U56M2xNaFVnF4YkuHmU687gGt1s5b9WL6iPTdsEnY2ppgU2tXTnFoshT8VQ32ZB
         TjHUSJqe/UTLv7jeWobZNXcq/SZU5d/Pq+148sxz6Ga4aG9WPY0zJuyhSd5w6bXQ1iTz
         L+8gaTdUASsLnnlpLbm+3WgZb4OAAgq/cjjc7tKewoftB6BrhQXJOCinmuKr28AEErd6
         Cop4FbGLeytZGOue0QK6hP6QhlTvp8EKnp8JqmVxfjvm5ppTy141pF9rOOV2JekGINLH
         FcB+2uTCjwjHABZRCXfToEdS62U9u48g9grl3YC+Q8CpuN/blWCgdRl/rI1IyWoAJ7+P
         lb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763349536; x=1763954336;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgHcryMU4+co4UsLmRrpjs6X74MtBrWPq8vt+QmPibk=;
        b=mrComD4mCJXnLd2wfPDacYTWsMcwqQk9nvXv45QGtA2HN5CUcjJJsHBCxccJpZ/Lf5
         C3DoYRGvYSkv3wgi4hiJeUNP1w512CzcdT4OH5bE1yvd0rRZ+KpVnSZju2xpgpyiisVM
         nqVeEgwhWsi2FnIWtrVFq4L+3alehpyiFEDEir1RxPNkvE9EVTBhjHJHq+U0xLgGxkDK
         FFCpfq9ud6NX9GSmHyTMFmgW/3P0lSks0fNy1zjaDsJWKAcLSyrT6vpz4oUgbAIXU76n
         oU4F9B8JrqWJWFCmxzK8W/Zl0Mh6f5k29LIgKi22tmZelXx4Kndch5+d1z7wUzplBTQs
         tpjQ==
X-Gm-Message-State: AOJu0YxjSvw8Z7QwPnTGdFByGhcQTqL/Nk2P2EaBQ9No/dYfb3DKbTk7
	tUV3NfcRCvxsjCxOSp52lnaYCUjwVNoAwNbmFI+7y8oNlpRIAQXVk6fOhRAVdTZO
X-Gm-Gg: ASbGnctbyjgvuecGohh6dGzJZo0ZLoHmD+9HyAmcwb+RP6XgIBdNHhRvjpCoHel3bLR
	QG3UG0tOIIKyxaUo8tMv27azRPiARTL3b9MKYuLqeSD8OPbp3O0bQ56j3va+xHdq0C8WuD+VQ2t
	kHW6sM6bSzvoLTVwS7nGh9Np9+uHf0RNf4+PwVDCS7h4mRmjZCfXVGG8+kmll8V2bsvoAY7HqwS
	vX2VHIOQB6b5GUaKIG107BtoaheA/BCsOyj7A/EjFB45n4qkjic52XjXQ6COAoThcFbM+fXQObP
	0F9t5nGX/ppUg+JthK+Sfhexkj78aOUP1puycLFqnH3eIKOKEzkP2GYM+YoT9iCckZHTSF2bRp3
	puOZdFvSCVbSCFYJpLhug+qWaoqkgnykAIB3z/1+gEkq/9QeSJja5Kon/HVPnbhPSXRXhUB+ot8
	kMCqSaAKlDbbvPKuODcFzr3WkmL50=
X-Google-Smtp-Source: AGHT+IE5aU1lyrjjE3+G2Au7Ngg5xv8NB9qy4FfB3tEpnS3UaqFGXWt7PgdtkVwqIBRbDPxZqb7vQA==
X-Received: by 2002:a05:620a:4726:b0:891:a91e:98c8 with SMTP id af79cd13be357-8b2c3162600mr1305021185a.23.1763349535681;
        Sun, 16 Nov 2025 19:18:55 -0800 (PST)
Received: from [172.17.0.2] ([20.161.45.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2e7f63adfsm265524385a.11.2025.11.16.19.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:18:55 -0800 (PST)
Message-ID: <691a941f.050a0220.2faa81.4420@mx.google.com>
Date: Sun, 16 Nov 2025 19:18:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5642018504117929663=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: btqca: Add WCN6855 firmware priority selection feature
In-Reply-To: <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
References: <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5642018504117929663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1024068

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.38 seconds
CheckAllWarning               PASS      29.85 seconds
CheckSparse                   PASS      33.12 seconds
BuildKernel32                 PASS      26.27 seconds
TestRunnerSetup               PASS      519.32 seconds
TestRunner_l2cap-tester       PASS      25.00 seconds
TestRunner_iso-tester         PASS      74.58 seconds
TestRunner_bnep-tester        PASS      6.51 seconds
TestRunner_mgmt-tester        FAIL      127.02 seconds
TestRunner_rfcomm-tester      PASS      9.65 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        FAIL      11.75 seconds
TestRunner_smp-tester         PASS      8.81 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
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
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.191 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.964 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5642018504117929663==--
