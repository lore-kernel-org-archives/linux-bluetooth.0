Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324C215F53
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605809; cv=none; b=P9vNVV+k/c42HN1MwmbgSyWFioKiNFj8c0wei5Q0/BV21cTPOD6exwXsv/2B8+kky7FO3T6E9Usmy1bzZU47IrhfLFywO9fTI5axCV/pFnW1K7G5zUVWK5qjZP32VqbaYhOQwhHLeOrEtKgXJqYZ1KmIvwn2MH3EyCwRITSzgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605809; c=relaxed/simple;
	bh=Fi5PclbQVTKZxSWS8m1DkUt6mqqzhkr51FD6mK/NR58=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N+/6gCo/PP3zK0U0hDLWPU2zRv0dKjAVheH4sdeT643aSBvRpoRUsBWSbQbh9mkYtWx3rS1hKgBvFKNxqIV2rsdEbs1eLrYcuwK7uo9V7d/SGm0szsaCDbrxKK0/jjiK/GBqfFG7bC/KFXSlRfyFCzuvAOxM6Dztbj7oLoZRECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InT/O3NU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InT/O3NU"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b07d607dc83so2392457a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745605807; x=1746210607; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oN+snJgMVy3Y6VxGkAb34cAztgz8ro/kVAyeJJUtVHs=;
        b=InT/O3NUdgJr63oErtoCRzUdNCZidRYAGBzoDNAgvv3/XUbXziT0K3+lgdr3E3laS+
         Oy3+O3B6nEJeANQVK1zAViz1czo7HiMOf5cSux+658KMXqYPkYnUmCvK1PlOXgtF1EnY
         Etd3rUOFqH9DRC9iBkUOCnaCT9i3oTv2QoMKMK+JVSuQxRYGwwSGluoZFy2NO0XUvUqf
         rQsnEBcDa4ktF/qtkA9MQQo9z+Vf3dVbx90vXsMT1mXMEEZ2csVThN8GWKSv8xbIwJ8V
         fbkQCM2BywY4i4egk6POIX/ecP71I04aBD2QELlq0a7PKdKsA821Cruk0zNR6Ffb+Qa0
         dhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605807; x=1746210607;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oN+snJgMVy3Y6VxGkAb34cAztgz8ro/kVAyeJJUtVHs=;
        b=NKO7/yHmiJyiPkrVsWJMMV5v/8PX6PjHQ+5WJJnj4uwl+Gp6DXn9XenNKBrsRNT1aB
         xZoGUs4sZis0lOsGBS+COn4GoK/RNej8q9BX0x6Y7PR7OcMp1MFdp1KZfN+W66qk8Hqt
         XOGF6CASnN7CaI60bOnHfG7r1tJCo3C4wE5ppIk2rTfenDJNNJVfErwMWU16+DhhhfB/
         +pkvQ/u1c4P1vYYJCF8T59tksdo3WN9Vj96BYH2MkFnzMlJImkgTiffgoErC/Jl9h5pL
         DyZq8zFey1F6yTSzqu00vZIG4vbJOMEP5XaaXufmSDa2QhDa+lguFa+La4yZc0Npyp31
         /GVQ==
X-Gm-Message-State: AOJu0Yy06OwcIz6MDhncwqnqHlQ6DM1Thq/OoV4ZfZV84ZeHEyk+ViPT
	Fd/GOlwGGXEVEPLew8BOPZFSFFZ9nI/tX959M4qolZO7lhJMMbGi3fVFrQ==
X-Gm-Gg: ASbGncvhMv3PoLCvu4dxY+8BYAYyLbY5EA+I3rqGZ3c6LrttuKm63iEciEFMK3WeuEv
	+9znj4iPxpI2MFW1dkooy1mYERS6J7GEBJd13WbQi+fh+U/OxyhmKopJtcgcD46UeeacCGokERq
	8/Hl+7yiEwCRIsOuXgjIa8JNRsr9vlrV19GQ/Dr38p08K88yLeLO1fc+Sq16V30SFSjkmMXpSUF
	pkdGZHwB4+n1hC72sx/jcOEqUHaZZK1BY3wJbLOvEmdMDDJRQz7m2q6z0OoZn/sw16ArTNp2wCF
	PlWPis79HHr2s3To2E1as90Agp/3Bti07kDgb/SYlFnivmu8
X-Google-Smtp-Source: AGHT+IG+HZfyUcgiRx7GpWePTRnMpeMmTXyuKFks0wwqsd6FMbYI3hGyL14bdO4qLEItP6JoPIzYyw==
X-Received: by 2002:a05:6a21:9984:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-2045b71b22bmr4147388637.20.1745605807053;
        Fri, 25 Apr 2025 11:30:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.103.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fa80fb9fsm3213117a12.57.2025.04.25.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 11:30:06 -0700 (PDT)
Message-ID: <680bd4ae.630a0220.1ee2d8.cbf1@mx.google.com>
Date: Fri, 25 Apr 2025 11:30:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4649552976066173447=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] workflows: Add sync-repo action
In-Reply-To: <20250422211827.987293-1-luiz.dentz@gmail.com>
References: <20250422211827.987293-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4649552976066173447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=955880

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      2672.80 seconds
MakeCheck                     PASS      19.89 seconds
MakeDistcheck                 PASS      199.00 seconds
CheckValgrind                 PASS      277.29 seconds
CheckSmatch                   PASS      303.01 seconds
bluezmakeextell               PASS      127.54 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      916.55 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4649552976066173447==--
