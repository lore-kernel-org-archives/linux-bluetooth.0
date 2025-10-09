Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC1241CB7
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000172; cv=none; b=Pgek6s0dTtPtxNpuC/C2C223EcGM1TZrwVmLkde4SWm5vbHSISadMp7HNa7/nOMvQobL97nC3lOhA1JSJp6zCxb4+zcRM9KsdTCyFGen51FO7vEjLfyYqS2zOlgp6r3cmce8rj8ArvHVckFmPRD81D1LfQDO5mf/D8VWQ+hnQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000172; c=relaxed/simple;
	bh=gBjRttb9jkMw1wAIFANTDuYZJo4dZrbPiJEIBRKWUvE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uGY8jriTd88liUL0Uu5dwciwckNMnkg+9vtJ4OQ+Bg7wfkitDsq+oy22LUldyQLSjXjvxKZJRFSLeoDpFDveziicBWooXC7odMqAGB7OWTrWZd0tclBDP3J2EON4kaXtpe7KoZQ7QqyK7Iy1LuPWGWzvDWU7THjeo2hBbjshrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P630OQuy; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P630OQuy"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-912d4135379so28061739f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760000169; x=1760604969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ufNwUgfLN3leddZGV5zpmIuh/lkIRl2PYrFb55TqC+8=;
        b=P630OQuyrYY283jLTGwiICtR7J+yCHahrwpA8kAe+TZAsC/iO7Cj2QDZUK/uhRGB0e
         j7IS1yEUFFgWtYPbm8XFkl3J558EX0KQqMXFUTB+ZAsiFcb7lAZ8X1y35nKPSKtRt9cj
         NlQJKmQ10YnC01IN6l0kwu/zH59fzpZ3Je87MW2MzuL47sZ70rwrCQDFdxR0yGF1oivZ
         rBzgqWWEMdh7TgnBf/esu+8lMLe394ejb+6Royr96s2cajWVvFPbdiavcPT+uFXv38hP
         lU67PLsWHA/JyTtirNy5pXfx8KCDHu1/yQkd9OvjriDBipLroKS58OwLTc0jj//eBAoo
         KbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000169; x=1760604969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufNwUgfLN3leddZGV5zpmIuh/lkIRl2PYrFb55TqC+8=;
        b=aqMnFrs09I7s8QMEOPVyJ4wfWKhvkghadyRZtxWor4Cxy3bB/gCyH5U9TetAFcmZqj
         MonEr6c2BS5vMbxf3hGwpCeDfXh6CX8chS4uncfKpEl5bg39JbCekGd84r6un2etHJZD
         Zh1GDFvdy0RQgsFspZTYiVtfdp5IxLcqy7N1GCT+WJmmIyvL2MYOSKSIBv+MaeT2HdZQ
         8y5nRmsDHLWaZ/ZJTFflVgZPIAL7e9E5OX3oZBZu9MIA52mrNzm1fMwSNDuN/JxiJ09v
         jIBh+1axXiw3jmxvuGsCdQOntKlu4vgoNeNjGVEDoMvPCJGUX1wOkwpYAZI+niFtS757
         H97g==
X-Gm-Message-State: AOJu0Ywz3qv1GNnAs0tUU172guYqhcBt9TcE/Z0j3JHwEq5cws48cp1Y
	YtvOwDkShi9A/kjMIp0LBBvV1z7ireirD0YtuvexFvnrzWhUeWektJ6dJ5K+Bg==
X-Gm-Gg: ASbGncs/H3IcbgQnDodCOyHtJRdMxDbWJU1xNuPMFMCWNyOKPHfZ1AaqeqORmhpR7UJ
	4xUThrfeNa0xD7bKugraeOtoAiulRJETf6TGCJeokfx9rK0Sjuol3r+g+Z9mS1iHO1NHoKCNtVb
	Zi8hjIVUPptVs9KMl/3Mt8+CwEe9eBbQ0cs1g1qtaddLD5DMm6Nyf23LvHyl57lvrwwhCxV2NBR
	lmsaeoSfsRNEQmHHwWSi8Mqlt5SByxng2RvZtNfgt0QYvnqnkBQ/2N+bWO8z/4tYDGccdg8EuXG
	xzFAiBREyPEl2oankRnZFt/NOLpvU++GB1kQtcB1FPrLxpmaCJrxe5GBfHpyGmP/19pNYX1Peh3
	Y/h6ZVKfsN7XFNDn8yOB0H6M2icaWa3JNgxhQTU8zLcS5DxNsNGpTrj4=
X-Google-Smtp-Source: AGHT+IFk8hMZm/23m0WvU0pdGNb55RKFQrCj2hQd9H3I80pTIUW79BrjgOxFFbe88rcZa+6Jb7cxUg==
X-Received: by 2002:a05:6602:13c9:b0:887:54d4:a8c8 with SMTP id ca18e2360f4ac-93bd1987b63mr717256439f.12.1760000169143;
        Thu, 09 Oct 2025 01:56:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.241])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93bdb306b65sm75883939f.16.2025.10.09.01.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:56:08 -0700 (PDT)
Message-ID: <68e778a8.5d0a0220.c6285.1bd3@mx.google.com>
Date: Thu, 09 Oct 2025 01:56:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4367064401037126613=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] gobex: Fix abort for SRM operation
In-Reply-To: <20251009071159.359476-1-frederic.danis@collabora.com>
References: <20251009071159.359476-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4367064401037126613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009611

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      18.02 seconds
BluezMake                     PASS      4218.86 seconds
MakeCheck                     PASS      19.77 seconds
MakeDistcheck                 PASS      173.56 seconds
CheckValgrind                 PASS      229.21 seconds
CheckSmatch                   PASS      270.76 seconds
bluezmakeextell               PASS      123.13 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      838.78 seconds

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


--===============4367064401037126613==--
