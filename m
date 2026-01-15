Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CC320A0E
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513735; cv=none; b=C8/LpNR8LPmVV1Yrlh9sg0YcQm2B4EunYo74Y2rpHeTHrjrxfFUBrhWLntccFk7iRtRbAjSjIDl8YubBLl1eqBw9NE6kyYtdZrjpgrwgOWVDqjkbf0Vebp0Qbtwr+vpK7UMgUsMYioIIQuC8n/uxHovb0NrN+i1M4EYA5LqfmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513735; c=relaxed/simple;
	bh=xdkU58q5HOmoq6YtXA8JAnCcwcWRccEcu4Y+siMtLqU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qz6O9DJe3D1PCuw3TxRZ0qRJ3fLRfyzWTG2kJN2qakQYjnoQclh6VjygB3x52U8rTpPuTzS80y7JPnvcIyG3RWAltyyvycl7ELwM4vzB8svTZA8PVkK9o8F8agYZWutufw17cUs3xojdAIWOW15cf2zjxljQiSnkLBZ72m/0yUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A64DVJKE; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A64DVJKE"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b05fe2bf14so3074139eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768513733; x=1769118533; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3642VY92vQhF9aUsAMuBDIh1OxtmqDQI3AAKLGeH33s=;
        b=A64DVJKETiP6PU6CkzacGXcI4nT1D10eYSqfwAmBD1RZGaMc7ESdq+dRPLJj9aAcL5
         d4U3WiNZsES69CNflHTo29IQdKC99pwJ3PhqwfdtMhOwK4+pLkRYekeVCO7ezkL9+w44
         EPuhJuH8pAkAweD0xBoSQFXjqaV9ns1MyYqqmlZh54V3TBUHeckSMFhLso5/hP0KSroP
         MvpdGRahWkQ1HNxf+s2WnUGhj81nnjcjuTZRN0ZewESiovSvYNGvaXmGvUDucMBopCdO
         S94kADoWLFfkbadlMhnT3/No9rEjCWtJKudEjptmAQZKh6uzSiULFSaZFl/jWF+uBr53
         Bncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513733; x=1769118533;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3642VY92vQhF9aUsAMuBDIh1OxtmqDQI3AAKLGeH33s=;
        b=pJKT7qQFZVJuY+oHDAW4gY63t5bDGN5NWYiYnVTBOZSdXtNd0sz4A0Wydi/Ve5fH2N
         bJoOuEvCQIyfkRDJxNCugTW05UZR+GK/TvgBPpeP1/Z3GecBtx8/A7BDyCL3oYg2kOPE
         nr7IgMMQxMCxrgrLcnGtQRPCmr4uHaKVh867dWJ30dUvjDp3+RkgRIcwlI+yH34IlbfW
         dUsziVQj/8lJiDUDGq1Nc8FDkoCuLwmn2pEXJJsIU+QcmcgQaYrZ5u7i5jzGaZSlRrmk
         5zwTjniN2mHFCHTMMpxrDcdJtZOIVXJxBVatgkrekqGRJUYs/AAGT7Ci6j3HUgPziSkr
         CQvA==
X-Gm-Message-State: AOJu0YyWlr0AiDT9+q30h/ZV6GtHTbxpsSLtnXX/T8YNPmRoNgdvBwYI
	22YjMDjkskhPvLvDcCFG08tky6EX02AXhJ6KSevyLQgr45iy0MgFK2ojke+SUoi9
X-Gm-Gg: AY/fxX5FuzdUCTwxNfgm5DZygB1JvqSW0WRzCvdmee3eOT5VqjOxfuJT0HxRigTG/Wd
	ab2YxIcFjMP3xnFpCEYy3aDWvctATbBginSkliS4ntxSM3VHMQv6f8QQCp7es2yXGd/CdrHeAx4
	8WKkIcHZauRvaDGm1d/LnjjU5HRlIBT/wmQEpMck6KCDfSHPYnoS/L/Z0BCoQwGB10dufgkF7vq
	kj7FhACVRo1tDfamnAyAOwmd8QzYMYkGPjA8+unNRE+PLnqNbPBuWX7AZWx82J4rD8EktK9GFlA
	Nn0XQxUZeWWvXQTsbxeh8lnkexsYuIWOxs6ASTwd4JwttzvPnwK7RxZX99LTYcPahc5HE+V0jy9
	0h7XsZUo705T8wxnhsnyo7fQ4J9G5vt+MiNRhEw5m8tdfQ2Pk1Mjo5jAe+APW9XmL2DZ73bjgTN
	mXnRf/oJQh99I5uPPZatxYBqMBrAPQOw==
X-Received: by 2002:a05:7301:2289:b0:2ae:6f72:f3dd with SMTP id 5a478bee46e88-2b6b4116fa4mr709078eec.30.1768513732910;
        Thu, 15 Jan 2026 13:48:52 -0800 (PST)
Received: from [172.17.0.2] ([172.182.224.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b365564csm541742eec.27.2026.01.15.13.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:48:52 -0800 (PST)
Message-ID: <696960c4.050a0220.c88bb.6d9d@mx.google.com>
Date: Thu, 15 Jan 2026 13:48:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0308526947442360186=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/6] shared/crypto: Add bt_crypto_rsi
In-Reply-To: <20260115205408.1554101-1-luiz.dentz@gmail.com>
References: <20260115205408.1554101-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0308526947442360186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1043005

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.49 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      635.18 seconds
MakeCheck                     PASS      18.44 seconds
MakeDistcheck                 PASS      242.58 seconds
CheckValgrind                 PASS      297.31 seconds
CheckSmatch                   WARNING   353.44 seconds
bluezmakeextell               PASS      183.34 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1041.03 seconds

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
src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0308526947442360186==--
