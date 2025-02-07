Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA247F4A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902894; cv=none; b=uXEGBe/hjQuhViAwhdAhiAcE7y6cmVo9KGcI0I0ZhZ1c/oi6rLzSeG3zUjCvJ+SBC9+XPmhylOpjRciFiQahpynwkBB0xVEE/ZQdiIbXkvebxqzpbPG4hySB3U/tBHEsHYkay0YYIPLz0HB0FkvnJQJA6xZR1Z2NTCIYCHenm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902894; c=relaxed/simple;
	bh=CfgGGULHR1ZmZBg/nPb+brk28FHEwj+L03ZJGd+FJ1E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=niBKr/GuQV+zjo0LpAXwLhT/lDWoQyis2++mXvSdQIlIH60xZFUH1SpwT0G5x1kHVoh4TLebMkKRCJ0FRK4C2yU5MD9Wh0GtG4ULoapehfYXqeSBuEh++kfy4o24wQiLTxsGjx59otz+fKijDSjMZP1yRfP9RIBB9vLPp1SIHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPFgWJix; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPFgWJix"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467a6ecaa54so14366641cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 20:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738902892; x=1739507692; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eeDZg5Sz1w1/7UfjnQO16Rc22eJthC8mJkYKKONatJQ=;
        b=fPFgWJixbhg/WHldq7hzmHLIL5ARloT/NG5JXeuQGQrVAWXlt+W0o0G/aV8rliRR4f
         /D1OoQKysw9U5pw5sitShwPeNgqtxxmOjePYjrwk/2uCc3cim/nvton1xyUEwyToR1Zb
         hR3jRdFUpACOekTKz0IU+/6YxTf/WBzJv8TgUeR1fMOUjZ7Rglb+/1tSD/dwHiEyJ8VX
         ascdU/bniRY37LcuA+gyTkrGglGzAMko3eq0Yxl79tHVW/uSp/exDdOqSoT0neGqeznA
         1Xptguytl8xVD+pXhMhB4R05J1ccZlsecbv3nSHV6qvckxzyPJ8LulOcH0Gy2El/Hsmm
         gNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738902892; x=1739507692;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeDZg5Sz1w1/7UfjnQO16Rc22eJthC8mJkYKKONatJQ=;
        b=n3rLuC2pAvUVM1c6KhtSbhMRWMzlF8cOKjaOdP432iPkhQkIEUuBlUkQCuguwn1O5G
         3kM0HmYEEfS8uDSws7atcLK5POrK6xuiovgT8fnDrE1hGozYmc6qA7T5oRlt2npUBwJ4
         NPp+XqiVqGK66xuphwEthneeAQqX6PSzNL5TNBMcY9cdYi+ezEX9HSctCB4X1C9MVO2Q
         40KlMGZae1Jz5B1sSryErPSzurjfSurFEzTVDixQflEoisrsTfl8SHo0fgjem9v3AuZ9
         wrwFkcmB0pbTKGfKn64ztv8/caeYwdmhfrDt3cPBf5XOmvNp7Dy7T1UWOvezfRiY7DiQ
         628Q==
X-Gm-Message-State: AOJu0YzrVjsspE8MQ9b3ttlxOFqpG3NMHkxd5ReeGyxWil0tVqvzCddq
	h5tnltXo4ZSiuXtij0o5JhwoThVoar8mbDXhCA7Gj4rbic1Evgv7GFhyrA==
X-Gm-Gg: ASbGncvfJqslZjfl02rTeiw5X6zYBszWjNN6SRocu7eDjr55Yt0gKXAvFSGo8YmIlrA
	gdSMSDfiJzFzY+FkBzzcRKXnBGc+S+KsvkSsLqFUWBxFdZvYk0zoyzuPwSfJda1rdUhuEaLW5aA
	kw+vV35rSvQQOazkfM1Q465nBsJlH9SNfEeR43SJ1QJbZLnKob4YM4h3vOy7a4/077MxQitORdp
	HuVuPX7lYJtUxhH0LvtLhL3sURnlCMFfqPNOle4a7YJCdcq8ydGFKyafwsv16In9nwue1Ng2nZl
	cMY8aBLMl1lylI5I2hhz
X-Google-Smtp-Source: AGHT+IF5rL7kVtqNz9IAQel6ve4oy1aa1R3vF+9TOhaQmFbEThIMbIMajHl8zvpsboQeGffS6tNgTA==
X-Received: by 2002:ac8:58cf:0:b0:46f:d693:1a99 with SMTP id d75a77b69052e-47167b18da7mr27584251cf.49.1738902892001;
        Thu, 06 Feb 2025 20:34:52 -0800 (PST)
Received: from [172.17.0.2] ([20.88.39.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bec3c6sm12386401cf.77.2025.02.06.20.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 20:34:51 -0800 (PST)
Message-ID: <67a58d6b.050a0220.2e57a0.571c@mx.google.com>
Date: Thu, 06 Feb 2025 20:34:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7796448572644000633=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lizhi.xu@windriver.com
Subject: RE: Bluetooth: hci_ldisc: Clear and shrink the ready bit
In-Reply-To: <20250207035529.2127772-1-lizhi.xu@windriver.com>
References: <20250207035529.2127772-1-lizhi.xu@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7796448572644000633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931439

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      26.52 seconds
CheckSparse                   PASS      31.38 seconds
BuildKernel32                 PASS      23.75 seconds
TestRunnerSetup               PASS      423.84 seconds
TestRunner_l2cap-tester       PASS      20.28 seconds
TestRunner_iso-tester         PASS      27.25 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      118.10 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      9.24 seconds
TestRunner_ioctl-tester       PASS      8.10 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.97 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.165 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.157 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7796448572644000633==--
