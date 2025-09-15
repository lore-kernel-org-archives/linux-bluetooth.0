Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA42F3604
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927932; cv=none; b=liAEVK9GRsZPC6OsZNipo50EhFSi2y1HaXr1TJ6m/tLrVcWZJ0nYbKWRMb9cu+63/LJkASaCqoqiYztphfhbe+Hk2vKSaBrwuQnWIreYsfamDy0kRhe/1bMgAD7gUKA5SMdLQhQGp1TeVUz0tiUTmMVilzVvXWv3D3SBf1xneOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927932; c=relaxed/simple;
	bh=wJQva2gLwf0HPamHEeIApm12++AxYtwc7mAdlXWm06o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SHW5m9qusiXH9N+EuIJREGVqeLRR/n4PzEmt2RoNVoj6/2pWMhPYhsB/YOvfwp3chwHTJw4/hNn8BhQ0bxlAn1WYbNk3iFAex4pjCHHnXauJHYE51IgFON8rCnfowApeSIDtAUNRZYDWnVUUU4n6ffEv0AxqlgBjwZr9Di/JF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PklRZRqd; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PklRZRqd"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42403c64164so13133885ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757927930; x=1758532730; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ESOXvTSGpzeMGYh69yPwxOcopAjF84YYLC+5mD3dGRs=;
        b=PklRZRqdLrJw313/HcYQJcXb+tzMIvRKKzZrmcor57si6+5cQm08O4Xi81bD6XKnTL
         kXPcp44JcDF6sKsAA57UAZdSU8dK1aCOucKpxrxY8tQtbW2I3yHgqHTvo7nAnH+AxA3V
         RimcSpZq0n0+F3VoyJ6+o+/RybFGBFSgrD+s7gqYXZYebSrkvfpipSTGHaNDhVdHvjZD
         hqAxLXzgVcEr04X5xnp40JrYMCcBSshpwyTYRIinwp1S6bY5ihdARhwEH0HQVVoMqOZK
         MVhjnGdavzjPTngcER1viVqG2VWOX4IgzqYA39Lw2ILTW6gB0Nw3sC2PpwrEmjO5Zvj1
         NGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927930; x=1758532730;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESOXvTSGpzeMGYh69yPwxOcopAjF84YYLC+5mD3dGRs=;
        b=Fia9G2Slh1QF0p5vEVyysq/HJPrphLzIl/jLCgUZMdRdfPf9v2Yrq+e0FSDn7eqPGP
         rNYAHYnkylRXL5+fQPE1Y4+G1vWQt65qNrPIYnmZ3765jPnd829Wwc689j/v650djz2Z
         1OY11CAEQfXgZ3x91jzbtBLT1fAtg1nBuhc1bWVsuPyLZipoR514TCWjBy0CRET9x9I7
         4phNrYtkRxy//qTcYvOsmiVWCG4NfT4unSYMCAvvDDrj4Pa8+GQhZ+ixe21WLBkFlOBL
         DcB/4OtpPEc2FDYucBaJ9HfQReGvM/O6T8VZTCbvdmAKT+RVkq3QD9lO7tSr9/OikjJG
         Z13Q==
X-Gm-Message-State: AOJu0Yx6eiA/i0AeIfzj6dr/eLRbW69vs4elzzwWQ0Peb90gU7lTCmZH
	Q6zfsO9VJp1Zd2thFD94O6RGAO41kIuAKvLKtfs9I3hSNe6tADySXEPCxgV2CA==
X-Gm-Gg: ASbGncsEu2qgBVns0ZlX5IQOTC3waLCV5Vk5RL8HBhelfAIJyrx0CB8MzfgZ50bcmtz
	ZNkrUWTTRXPD0W9KESamm4TtPf1D+1eGp7QAL0faW7+mMit11+UlT4ndYpFi+aGB9ZxvYjHKt5+
	1ozeL8tYjXDM9s/kNn3x1LE+0dP6/mLLTrJDIoXj7GbRnZF+/DfQrRhSm6GplzuTjRNVQRWMD1k
	56GRg1qsV41pQ0Uu/K7kH00gRkiGK9z7EEX3mhRxm235X4YORDvyP3jfR5F4Yw9AQEz3LKADz7i
	ediD/uXgGdODolEMsCWyOcVKg6ekmCO0zBgoO/+wDu2/vn4OAuR3TPXdfBjrBXQjtTIO/yXdJjq
	7SjpylMC6ZxLU4LeGV/352N4EFlTK
X-Google-Smtp-Source: AGHT+IH7Lww3L6wMo/vraVw6WFZGRrJetoIXwbdAy+nu+I4L/t4JVU6GmUY36lJLmphAr1levnxTbg==
X-Received: by 2002:a05:6e02:1528:b0:3f6:6c03:18bc with SMTP id e9e14a558f8ab-4209f2bca6emr132082645ab.9.1757927929719;
        Mon, 15 Sep 2025 02:18:49 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.83.42])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f30ccd99sm4597379173.78.2025.09.15.02.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:18:49 -0700 (PDT)
Message-ID: <68c7d9f9.050a0220.17fa77.57f6@mx.google.com>
Date: Mon, 15 Sep 2025 02:18:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1027155916952074223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pwaago@cisco.com
Subject: RE: [BlueZ] audio: Fix typos in A2DP error messages
In-Reply-To: <20250915075553.1636970-1-pwaago@cisco.com>
References: <20250915075553.1636970-1-pwaago@cisco.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1027155916952074223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1002338

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      2787.86 seconds
MakeCheck                     PASS      20.18 seconds
MakeDistcheck                 PASS      187.41 seconds
CheckValgrind                 PASS      237.21 seconds
CheckSmatch                   PASS      308.44 seconds
bluezmakeextell               PASS      129.96 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      927.62 seconds

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


--===============1027155916952074223==--
