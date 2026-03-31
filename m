Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931D370D65
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939487; cv=none; b=OdpXYTtmX7dHiRbGmWCmFqBWx9HrRlq6YK17u1skqw7AuFgQs/CwiTjcb9LZ/GKxCWMZrR0qrbXlXl5sCdZaAtb90Aua6xCmjcC360esVXfCTpc5Q7cU7zBOdDeuwfoPqcNpF99euCsyTFPpMsbkrrgsG8+JQSk48/kmtAATVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939487; c=relaxed/simple;
	bh=m73KrXchZWnyR0ZkkngQfmp+y20pHRvRemVy3FJT0wI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FOfykgaYXjxQ7FeT8DroX2+oeb59CQ99zAVKo31riDa4YY0BC8fsSvgIc8ESuutzSEoOeU0ahyWrjr9l5JjQUMHU3QG+jxtQ56HQsjISv4/J9wwNvX2KhKUPdxMqkAZd3nzHplXzLXik3EB3UgeJlC+x42b+Lyms6uU+IScVx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxTOXfs+; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxTOXfs+"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67e00a230adso3321402eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774939485; x=1775544285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8VCDG3dQ3AkQfbdCmrEjovfKjuv125c7PmNl7ZecpEw=;
        b=YxTOXfs+XwAL1/9B7Dfu8GLvIIsdDsF9VXxmt/hd0UsuqQW197ihOoJT/kp3wDjYm1
         iPgVJLFBl9h5JMUcZGMBsKlKqsddSuN8H8jjxdvH7q8qaEQzKA5xT54zQaHD1q4nNqlp
         SGhbgSsSHzWd6vg99KMwhOiLJD1wWxsAnKw2s+9RDsscMPx0065zF6sjUdKLfXfvynpB
         XlbDU8Rg9azhgkscC8W9TXLHRyawdBapGo0L8YaLECV20iXD4YxA6YrqZqYmG3+cwXTB
         73062Dt72pXrsFBbuudavQqE/KQERR0VpMoA3zN+318pkQQfF9YuZmEKEESzH9G27D8f
         WqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774939485; x=1775544285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VCDG3dQ3AkQfbdCmrEjovfKjuv125c7PmNl7ZecpEw=;
        b=U6/0pnXiDCMX4J2o3bIL43rmVnrkDL2t8O5nKcSZVbX4YR4LJ8g3FcDzwotdkMrANA
         WbEp8m86sU9KrJuU0hmWmvvEmSCl/Q1SA4s5kHGjeBEJ1fkxW33MmeT+y7C4yunGRLyq
         mrImrjoVk3IJjt7zdW5LBYUJCwDmpJoEJ7CVdhUoy9lEh/vnokCOWFKKYjVPTUntJMc2
         BN0Cb3IJ94OdfuC1bpvWIkaoaAkS1iLhNcjdmULzMxRjXdCPxJQ9X849UVvHU8aj4k/f
         A5qX4cScEvxOMGoRg7FGTXDuuaLd7KkHqNJgW2HZJUQT3hFIhewxOxpPnn/60KW1yNht
         gIvA==
X-Gm-Message-State: AOJu0YyhW0OIHvrUpKv62PaLcuOYgb5Kl6VxlMWrVkL1ROGhEIVH0No8
	3aSuTQ9R7Z5zkH0v4jxneYDckfyDtExTEsm0ympehfTy/SRYubRxA+NRoB4R7g==
X-Gm-Gg: ATEYQzz42TTJWFPo7sJTw31U9fO57HQSJ1BpCI19rEFCL6sftdoB7CcImCr0b0UZZzE
	Pp5uSNBPOasiunnPaq67V8ujxkuYU99DpTDZNVE3qwcURTt63+CEMpMCoXWoGoVR0FsY+FGNxDw
	jfaC5c+jcroEQ7UnMmKHjSCy1/H6Ly6IvM3DtP9l8MOs8PsSuQi8w/Bn7aoSCo97XXlXSzstBVN
	WQSdStX1pVyaS/RS1nx28xtHH5QlMkPadsrBT/D+EY/3u/joOYKNU0O6O4C7yBrLz6LXtC4K8B4
	EEe0f/fxVxRLoYtwdVxQn3OXNd7OpehjWJQxYyhV9+MuQt/NTCPC3lsFj785q8YU0IQAif5MxP2
	heGJlnrEhn8Gv8fT1sN8pk/6LIdtIQaoJaFinzhM3bB9J59EplIWvO7fTCk0jEILkTTuY4i8hXn
	9WygI4ZggeS5g39T5UR9NQhB6QYzcTCQ==
X-Received: by 2002:a05:6214:4e14:b0:8a2:97cc:af82 with SMTP id 6a1803df08f44-8a297ccafc0mr45885286d6.27.1774939056819;
        Mon, 30 Mar 2026 23:37:36 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.135.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf2852a1sm82226336d6.32.2026.03.30.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:37:34 -0700 (PDT)
Message-ID: <69cb6bae.0c0a0220.10a4a8.9496@mx.google.com>
Date: Mon, 30 Mar 2026 23:37:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5579934678768246486=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hkbinbinbin@gmail.com
Subject: RE: Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync
In-Reply-To: <20260331053916.1856760-1-hkbinbinbin@gmail.com>
References: <20260331053916.1856760-1-hkbinbinbin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5579934678768246486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074953

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.85 seconds
CheckAllWarning               PASS      29.24 seconds
CheckSparse                   PASS      27.93 seconds
BuildKernel32                 PASS      25.87 seconds
TestRunnerSetup               PASS      577.11 seconds
TestRunner_l2cap-tester       PASS      28.50 seconds
TestRunner_iso-tester         PASS      43.01 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      114.42 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         FAIL      14.70 seconds
TestRunner_ioctl-tester       PASS      10.69 seconds
TestRunner_mesh-tester        FAIL      12.45 seconds
TestRunner_smp-tester         PASS      8.84 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
IncrementalBuild              PENDING   0.65 seconds

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
Read Exp Feature - Success                           Failed       0.109 seconds
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
Mesh - Send cancel - 1                               Timed out    2.719 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5579934678768246486==--
