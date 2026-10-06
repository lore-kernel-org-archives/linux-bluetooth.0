Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D414B950
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791253098; cv=none; b=CeCmOXvJuEDWDAaYLj56oU5zTdxqgIKPuY9Qj2fndPDBKmyKSiIQAB8nQy/hsBM60V9TjMXWOoU0AdIsWZ5ORrt22nmVW3rnY6NapjEcrNgoiWuyIsVTr+q18mPAnduX6use87WnU4nZnFYHjS6Dqc8qgnoU7gRKhew7cLDKU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791253098; c=relaxed/simple;
	bh=PJsu3PB6cfhFbAEG5QveHnuRnAKHjq8egvoULlpVWHQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U5KbvSn/uvyTnOiePRoulaISdZU6BSYmW+FXSEHllQOB2eE8U7mG38tu+ytbjqVh7tEXgt+bZ6m7XbKBzq93KpVAj0C4exstLfzK1m+x1ennUtH0AxV4txgkkREX1WCOuUMYgt5rNw8VgWnbA6+HGHZJoCOOVWPOxZiENgRuoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI9z0Cdn; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI9z0Cdn"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92ed3993c1eso144529685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 19:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791253096; x=1791857896; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KbNiJEwQYVoJj/mqEJEsQ2Y95vdQN0szR0tTz2Ip9JQ=;
        b=bI9z0CdnKtw0b4B5jbe/Dx5VST8FpwinpeYSLpQai+OFhhzmsxg9PntXbuWIauzW1K
         eNMKXPHquQeHsntFOiySTietFjrfSmopf5OFclHU90b1GoSfA94j0CGTG8TcQq7M623G
         qsZH+r3lNfiJJk3OTzbGkbD4Dee1nMGPMxkea5GwRSeYgReSYeGjwm7iwNYk7wBVOVC9
         1uF8C60OtAZ45W99wtJR12itKxvEAc1kSDo8JLut8JMtohpXmPKR1hiAyjWDCEF1xzoe
         hj4FLQu8aj0z6M6lX0/MO4YpkJaxAX+lfknTgncoT0yksOeO7z9Z4lCY/UWnTeeam7KY
         CHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791253096; x=1791857896;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KbNiJEwQYVoJj/mqEJEsQ2Y95vdQN0szR0tTz2Ip9JQ=;
        b=Zfv4lZ5kfv6BUA01kx8+FWuqARtZv19OHN1wlkjgsHme4W/OaRGCs3dWISm282GOTh
         O71nO3i6vZfWU8n/3TPC7d/ualzto67BC+THD9LbOYZJtfwjopn2I7cuB9g9yEeKhtHj
         JWIdz6tRlqYqWRZd2ZRF4sLhZxOQI8QNmk1ZsCUQvjgkmEpSqbLvhlq17+QrHLqEXgPn
         gcZ9RKUN3s4+GExjpD8X+5KNte4FMcWyOa0CkgbfLjOnW8UHGja0uWXiY73ro33hqHuk
         Y9N4IpbpbbkjvI1c19phlr4c1Fqu/8la5C5WNxcoMz25GxPbsWIg6EKFzBiys10654sE
         mt/Q==
X-Gm-Message-State: AFuF++n6KER/MhZvS3e9JL71DqWkE/1BnjP+G0FbwooyBOUeF27AST9V
	4tnbZY5Dd8yitjRzCf7yY+FXMNL6r5Y/DpR/Gq3YUVF1JcRmxWArLkCxDH1fIPdD
X-Gm-Gg: AYBFou0hsANf2x99MwvQV6PimuzW0BgeJDILVy3Swn+Wktkjb25iFnSiBvH/auN078j
	z9EltEkRQx/PJSBKl3guwC4yY3l652TgC+LaSbXQUiQ6gwl8lW3Y/hIX7n+4RS86/AAvPY+hdq2
	0g1Lg447ieQPGCS199VYoc4UdlPIrP03SJGut7ppr44igX9nMc5Z1Q4dE0Ln+2WipTeynn0uoTn
	wklj4wgzOx9k8jgUedKKS+gO5ypNBcRjHAxW2qLJGuC/CDdnoduaaxf5yDm+TRF/p6MbxuWtI/r
	J0rYo8DsOxI1ml+DiAaE2PCH3yjktWAhC6QopUEGNCDM7syuEFjqs38VHkKevh+LrxBxk6fxaJk
	+VjgVLgdkYIEvC75BW9zoZTguPZe4vMpSfPGLzhQtm+MpT8pzhIfE7hQptnS0uezuQR2Lj8j4cF
	QRMZIh/vR3Fk+wa4a6gKlumH2SnM93YPw3ZV1x/mj9AfsXIuqCUvY1vcIARBiGzpoH1Bl5mbbNj
	dXV
X-Received: by 2002:a05:620a:4452:b0:939:b8d6:9b1c with SMTP id af79cd13be357-93e50fd4d7cmr1641287885a.19.1791253096162;
        Mon, 05 Oct 2026 19:18:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.116.79.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c2e98bsm101144666d6.44.2026.10.05.19.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 19:18:15 -0700 (PDT)
Message-ID: <6ac45a67.e7582247.1ecb90.11a5@mx.google.com>
Date: Mon, 05 Oct 2026 19:18:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0915756507198710204=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_sync: fix mesh adv timeout units
In-Reply-To: <6f193617ad11dce997d5f97c4a0879343d1d23d9.1791223958.git.pav@iki.fi>
References: <6f193617ad11dce997d5f97c4a0879343d1d23d9.1791223958.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0915756507198710204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179822/

---Test result---

Test Summary:
CheckPatch                    PASS      2.14 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.69 seconds
SubjectPrefix                 PASS      1.87 seconds
BuildKernel                   PASS      29.74 seconds
CheckAllWarning               PASS      33.57 seconds
CheckSparse                   PASS      36.52 seconds
BuildKernel32                 PASS      29.49 seconds
CheckKernelLLVM               PASS      37.48 seconds
TestRunnerSetup               PASS      781.61 seconds
TestRunner_l2cap-tester       PASS      12.58 seconds
TestRunner_iso-tester         PASS      10.75 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      61.35 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      5.60 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
TestRunner_smp-tester         PASS      4.33 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      15.96 seconds
IncrementalBuild              PASS      60.62 seconds



https://github.com/bluez/bluetooth-next/pull/863

---
Regards,
Linux Bluetooth


--===============0915756507198710204==--
