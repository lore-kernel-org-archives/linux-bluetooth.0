Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7B78F29
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752276417; cv=none; b=fiK75TdzvxKyyYGe2GxJnhtYWwFGT0oVcL8pYNi+0srzcs23MkGxNHo75AQUPjeWMyNv73qAXuyzRin/r8T+j3InpzeJzPvNotBJjQm9X6MRj+Wy7/6izBcrroN8WPpgp8E2x/dlpYZ4gE/WrrzdpoFfxKD+zZUatGL+IoEWbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752276417; c=relaxed/simple;
	bh=ap5NI9vdA6rXsXyavakM6a0/KwpA5UcQdJP8jAw3Lvs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uSJdRvEyyg9pq0HBEgBBhRUbdeIHm295dkisdt//3LOf3i+iFFxpbSrPyb8h1V8BoLIaISfF7IuJEiFZPLI2dtRYCAiZDAGlwy9AHYTJ/iF+VpsCIjUvuxnkh8CkpEuLc7hIBs4Rj2NMi3hRe/P6zqPobPElZDw8aiq0J5NY7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWWfjwCF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWWfjwCF"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-315b0050bb5so2024096a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752276415; x=1752881215; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jR6n6i4csY02MGb6du3dKuUmubA+nRAlcdIIF7O8Tf8=;
        b=WWWfjwCFEB4ojVyTz7Wf/rpuuLq1yjc6syFNjkW7Q0viZwUPxiJOMyPmLK7t5Q97RL
         JZmuohzscIJYWlBkifp7p5qzPu9TuEVFQ5SrIY3Jd52y5gUA8GltE0NIWXM7atO/LA+o
         oPtEnEv87vpL+vBopuyfCYYFYKtx3J0ZVSheDIAtDcU8TFLFJESf1nuYiBsm+490UQu5
         FvDdE4zGeilNciMmeuhW4RzzfqLrqv6WQWRnYSSRmKV/j6H20hvDABd/t5Snjedpq5B4
         tAp7qnGr5mdfsOArB2QKWQAhNXVntR/EbHwkKp6O9BhXi703XasvdQ+jjslPxYB/Irvs
         XqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752276415; x=1752881215;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR6n6i4csY02MGb6du3dKuUmubA+nRAlcdIIF7O8Tf8=;
        b=rcjZGtAHdCPKMs+9k7NDmp4xOMLlGdA0yBjY5+LQmcIZFB0UIFfEiEGaTeLjQ5Tq+l
         +pVTEV/THpN8nJnIWvosy+5+DspwpK7TFVzZmYRmBhH3EQg/Wz2f+s8R2gMn9ydbsXJc
         hI4aNi2oBqPn/e29ZRS/ghMBh0LKh9Ks8lZ5B69venxmMrD4HZsleHE2DLJTTY25i92R
         2TO8twFoHef/wH7y1pNrAtIz8JXF4m2FZKshtmaWcirj0/0XWgNX7SXnh7z26vHDmxjH
         b1CYRNZdVqO2VEa7DviWjGTKMVwsvytZWgRNNVG1a/UnQD8JwNvh3TEwWir8NTa44rdi
         Sqfw==
X-Gm-Message-State: AOJu0Yz8qZFiL2V2U/mfrDduX69X+PrM2ZXqozVnWGiUIw2yrVbF0fY1
	ESPCIsKcGEq8Qu2MSHJHGhrJp5g574VzGCI2rtvBrWYNNScse4/HICJR94Q4FX7c
X-Gm-Gg: ASbGncu96KZx6Z80zbAE6eH/4RXPt6HZgCUBo1KD6e3um1yORDKMFfrtrSPWikRAMK8
	EWVXmxVMPQwo5nSTdVb5VVybXua2s8VyIwJB1s28X2Y5PVhHikScoOMnA7/h7txGEeG8/43n6GA
	DxH1A0cqxXTsfAcknOFVPEbsRN/2dda5ddr0X9nzUJ/5DvXaLhcANqaq/kx7KoCes1aV/SFTBeE
	J1A4PwsUgPIhU7p4/Fm/h12bf90h286s2/YQzvA806/sG73EC8wYhgQFzHvmFqp2dog0y0EcQXC
	y/qWYdOuM0GkpuZWqfauroS76ekDOwrRgXDaQxz0CAR692bbgLtwitmcgPxBP8RiwtN5EEqJPmX
	q2zpJDBVbfP9Af+5TFNTA/URjATM=
X-Google-Smtp-Source: AGHT+IHEFjr+pPXN9zN8z/fFBnT23FDL3P4HSBO3UZmMhpCqt0wj13nr9EgSNKzonxbbaaJK+QU+jw==
X-Received: by 2002:a17:90b:3bc8:b0:315:aa28:9501 with SMTP id 98e67ed59e1d1-31c4cd9a2dbmr7869899a91.24.1752276415429;
        Fri, 11 Jul 2025 16:26:55 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.33.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003faa6sm9183701a91.4.2025.07.11.16.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 16:26:54 -0700 (PDT)
Message-ID: <68719dbe.170a0220.3a4a61.76dc@mx.google.com>
Date: Fri, 11 Jul 2025 16:26:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8181037945489479284=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: mesh: cleanups and a bugfix for relay packets
In-Reply-To: <20250711220035.10065-2-ceggers@arri.de>
References: <20250711220035.10065-2-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8181037945489479284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981661

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      2544.29 seconds
MakeCheck                     PASS      20.37 seconds
MakeDistcheck                 PASS      185.20 seconds
CheckValgrind                 PASS      234.67 seconds
CheckSmatch                   WARNING   305.40 seconds
bluezmakeextell               PASS      127.19 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      908.82 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/mesh-io-mgmt.c:525:67: warning: Variable length array is used.mesh/mesh-io-mgmt.c:525:67: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8181037945489479284==--
