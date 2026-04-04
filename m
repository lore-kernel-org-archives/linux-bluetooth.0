Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54011A682A
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Apr 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775321461; cv=none; b=Lrkm2iu9BLuzEFIHKOCnLGbYMuqnyBfyJmJVCpF98vWJ4jI6t3jeFqPVjjG0tZOfE6Mkhq16t0zLM7Zp5WZ10lx06fSZ7n5nMqMoaefrQ9UK+26r5vyYwb6hbl+ZZ6PvzucBEHVjdOeGnb0a8Q49x/p/JhdIZTqJ9Loo2N9qm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775321461; c=relaxed/simple;
	bh=NpZ55JsArWCRXMzU/T1bKcifmaF8zlfHmDtA7hyYu9g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J3VUggbzYBCVs8pSl3RXIfcJY9VDUXKGuSzTNhN7zkeV1Hj4w9Y1rKGboaGe7NjZ/4fE0W6LChI3DXNuFvGLPyIwPDy7XdW61QOe1VYKj+cmAPkNBZiTTQ4OOsGq/oRJFGmz/EuN+NiYBGVQH1XofS5hIf1n/ygpYpUEtsHg0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPE8ZyqC; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPE8ZyqC"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1279eced0b9so3141734c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Apr 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775321459; x=1775926259; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pnjB4tWpwQyi8sDtMhZwehnyjBLYQhvLL18WS1adO0M=;
        b=iPE8ZyqC3GEeuXxSSXKGldgsXZNgK4jFEw53aG5zSzn8/MxTsn9PyaXzVfNBBo+kpn
         S5qzUd8MVNN3BIhlmKKeQZJwyyWO8pYm6lZS8LJZaEyb/V6NmxoIauMldJ7vv/BgRk/m
         H8VSYd3oB7Z+1BrvZAIvWVYDsuwK68dhcxUQs9v/m/s30YyoZ618cULXAzILKL108Nx/
         R4jtAayPnab2maXHTvxXm8yNfMkQ+wB/KH2BLRzceZlka/m38c5uwY9SctY05/mrVPd2
         XYntuNGumNCfkSsOkdiZnqUoyv+kph0GAGnSrhfEAeKFOXXWr5s/QzfO0tJp7oJc3VAa
         qNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775321459; x=1775926259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnjB4tWpwQyi8sDtMhZwehnyjBLYQhvLL18WS1adO0M=;
        b=SAzpjL7VNtW9mUxDveHNPKJgzTjTRJzOJqDsWj5RwLlbHeWTaCCiNEAowXrKxnU4Sr
         +IXq9ZjXZ+BC7TDUQ3PzrXlwiO4jb0V4Ucuvh11SzkaWY8x8PwkCdgyjQX+SunAzD4Es
         CSomGL3vbKZIWe8/fTJ9VlO7XfEQHoRdl9hAbIijTgpVsL8Gun+5ZHp9AIezsSAahS7v
         cE7LcvTt7fcArD0WNQ82yMflRBwddv80i3OgVoBgnBt+DR13ZPWmu7ybjrJ8mPH/3goU
         nJ0QfrtH70We78JNl3jQDSIorA3m9n/j7/SE6KUjox8QtKJjzRC0Z/8i/j25wYgB+S/z
         SsXg==
X-Gm-Message-State: AOJu0YyZXoYFIgbKp1oQYbBiihndysNs++UR0IIu9UxGSM5ZqNOakuH2
	xIPypXc+1p1K0mkR5UTP/0bsCuSv4D17qhjjhnm1qq0U0hXqo4IqMtjKlSxJGA==
X-Gm-Gg: AeBDievpXAppOrt7HllkgCpr/hUf8zzByEr0ETmFfq8L+nd0J6Yg1ccE9i0PSxre8RP
	+uPypaT+U1Ckn2WhDST/Yt4gpWK9OvTeK1ET+76TlhubXdF5v9QhOc58xL7eowbRQlKwJ9VoCYd
	cnrveYXXFKzQ9JMBrNtQ0FmK5JAqCCTLwwOJnX4fVumQ66/8HUTufS9DMHfs6Gy3H9YZZL/PoBN
	1RT1bUyrZxbnAvDjhA6Jv2yPhJ4XnrqjafUiml16tkokZN4XlFrhmqtV0GOK+/1vNTO6OizD6yj
	phWYfQlk2o2SL5+chflHki27kBGawRbguoFaXomViocR6JuwHIX3FjMjnIWNNAOysqfIqNH115v
	lx+h/8ObjhLY8Zon8guFzu+0D5FbQn2Cb04r2dpBUfQITDYNoQ/9Hp4WBfhuYzruz/CAdMUOaB+
	Ho0S5UkXoZVJER5YZt1CgyLV7imE6larTtT/uzI44O
X-Received: by 2002:a05:7022:1005:b0:128:cf5c:535a with SMTP id a92af1059eb24-12bfb6f4e06mr3484893c88.11.1775321459343;
        Sat, 04 Apr 2026 09:50:59 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede545e8sm6817900c88.11.2026.04.04.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 09:50:58 -0700 (PDT)
Message-ID: <69d14172.050a0220.fe7a.933e@mx.google.com>
Date: Sat, 04 Apr 2026 09:50:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3573749184440700483=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, n05ec@lzu.edu.cn
Subject: RE: [v3,1/1] Bluetooth: serialize accept_q access
In-Reply-To: <20260404162324.2789862-1-n05ec@lzu.edu.cn>
References: <20260404162324.2789862-1-n05ec@lzu.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3573749184440700483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077317

---Test result---

Test Summary:
CheckPatch                    PENDING   0.55 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.64 seconds
CheckAllWarning               PASS      29.15 seconds
CheckSparse                   PASS      28.21 seconds
BuildKernel32                 PASS      26.20 seconds
TestRunnerSetup               PASS      587.43 seconds
TestRunner_l2cap-tester       PASS      28.27 seconds
TestRunner_iso-tester         PASS      35.73 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      116.41 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      14.60 seconds
TestRunner_ioctl-tester       PASS      10.24 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.96 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.688 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3573749184440700483==--
