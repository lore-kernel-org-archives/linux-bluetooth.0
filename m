Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE81F3BB1
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052460; cv=none; b=P4FQ1Na2niG3nxZ8Qc8dqh1/EDYpo6bTxdUgdCC98nTKFEFJnwlq98gY6Rz3AWkJefKW7dOk1tUUCK8RV5EisnaeGBj9GSvm+ONjBi1CRzBOSqrF1ZeImBn0p0E1YP1+G1g5EjJiFtTf8Q2ryDPJ/H1J5XDIsNzh8ZQNDD7YHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052460; c=relaxed/simple;
	bh=vy2pQyTwIUT2ClNP/DHt1GpBQgzQ9tHDDrMLT4WynXk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ucdycu/6W0pLJCtf8KCUPf8F057ZdGzGT2ng/d+petYZ6uLcFCddeXitm0Z9n7EqooH5wp0fRGEcDqnLZFH68h8z/42V3ckDKPS6YHYF5jiIbaPXjvnnSFBoQwPgvjrsvi7N1A0DUq9ADlYU5UoRUeUbLXPcYZZoJY2XvLJ3Hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7dcuU72; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7dcuU72"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd01781b56so10024146d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 03:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740052457; x=1740657257; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u/3FZjU+DwykLksPImN7YxhoKZObDZHfxS21RGCFuhY=;
        b=M7dcuU721orjp5uOQOg1ATAgmb6wdz/RuwhIuxv+5Wim57cuWnuxhRgxE3xLJbBEfY
         wzCHfmSaoxKLdFTpcCtZytNQ9FTDPZIybM2G8XUYc7X9vH32KOhJGhj2aiI8rjjkibkH
         QxNPBdf8RzpiLR4bb/z3N/Kk7PRbDII6AS1IbweJ/ZZgg8odwVcz3+wSKMsfsaxu1lyZ
         6Jy/J4Xn8H7AOWW3KqZNs56qOklej6hqPX15uyo5DejS30bopQMDp0AjoLCCDizUAkjK
         4lBaXUoLGEbr8P/ggzoAsHXwfg4b8Vun6f7ugq9iLxAm1DSUqgTrqYnLg0Ofp4GRfUgT
         cYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740052457; x=1740657257;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/3FZjU+DwykLksPImN7YxhoKZObDZHfxS21RGCFuhY=;
        b=kjm2HGPc1LEiif6SwYMNTqt/CBtzpckC6eBv5vhoWQMnvlFZJ8+ESihbYoxgidCeP/
         BOuJ68alcc5IERrOQA0uoaXCE0yh7z5xnVJQsPU5Lh+pGDThKHKeJVWNKU7QOLMiSplg
         p1wCD1X+ngjmWLuV14kjxi0SrLrkfWxBOcIYZK4s4/WoJhqcSxXVmDbfcOEb2HZBghyz
         +bTVAveGb+2CgPWkb6izAY0O2IFOaKt7s/hzhxmXSkfehSybWQwXv4qn+VAuRavZdKR5
         Y5pueqmPcGI4lpmlLnR1bISc0fTeLiMGmxcwmL42Y0oF7hy3AWzvHkJEhbFzbE8Qm9nB
         6mRA==
X-Gm-Message-State: AOJu0YytPgjBwUomHHabM4hGpywdWhD1dBfK2Mx82bYEnZ0c1YNsZc11
	2hzm0RgmTjPMxMyBT5hbutEL8aCKFu3NyraOSq8W4w86EPgf+Mn1o+3zlQ==
X-Gm-Gg: ASbGncv3bPwNmKI+Mk8PZLcq9e4sI9AdlPi/bLeaBcNHJZfNbDKJTnJJX008BSM8IRN
	43ditcMiT3IIyp+9LYxuyAoAN1YI9Gq6XEtydxuZ8BndNP2CFeZ/0GTo8hrOKw23ir5uhCaPMZo
	uSCYrlt0qEs5YP8o/SQnSSGx4SmzWenJ0Wwr9nA2DADtizzSooSEIIxwQVgUKt+tY2NT+9whLJ5
	BMHZfJ6pA5ala+OK0uLnlQNb2e9fjtaqVmu8IodzC0BZI89QGHhhRPaVhL9+9hbBsz3JdBalWIM
	c0RVAphKq0bdtdsvkRIFz1s=
X-Google-Smtp-Source: AGHT+IGuehXk9w3gCoODN5gAdOYCTpq8VY5Slyxy9CZeQ20blEYLRF980plsMCVgGej0b1ibSjRbGg==
X-Received: by 2002:ad4:5dcc:0:b0:6d8:e5f4:b969 with SMTP id 6a1803df08f44-6e66cc983a9mr312237766d6.10.1740052456908;
        Thu, 20 Feb 2025 03:54:16 -0800 (PST)
Received: from [172.17.0.2] ([172.183.229.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c097e43fb4sm503738285a.107.2025.02.20.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:54:16 -0800 (PST)
Message-ID: <67b717e8.050a0220.18df0d.5a02@mx.google.com>
Date: Thu, 20 Feb 2025 03:54:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5886165534209716948=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Enable Bluetooth on qcs6490-rb3gen2 board
In-Reply-To: <20250220112945.3106086-2-quic_janathot@quicinc.com>
References: <20250220112945.3106086-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5886165534209716948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935980

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 FAIL      0.45 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   PASS      29.87 seconds
BuildKernel32                 PASS      23.68 seconds
TestRunnerSetup               PASS      435.65 seconds
TestRunner_l2cap-tester       PASS      20.60 seconds
TestRunner_iso-tester         PASS      33.18 seconds
TestRunner_bnep-tester        PASS      12.04 seconds
TestRunner_mgmt-tester        FAIL      119.52 seconds
TestRunner_rfcomm-tester      PASS      7.84 seconds
TestRunner_sco-tester         PASS      9.61 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      7.52 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.41 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.158 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5886165534209716948==--
