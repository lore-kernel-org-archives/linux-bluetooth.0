Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CE2E3398
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743479726; cv=none; b=Ay1MUmPRyA9++LR9SHDhVqB2LwS428pLSJNWfOLwUE2RRTPB9+CGCh3Rd92s1nDOoRxRCa/wCTPz62XbCaN8oCGzHUz50zc8+er5NTXmTl5CdBWve9jsTHWJL3qN36gSMrYYOEruhxGSHrn+8QOtPCkvAN/991UCkVtJIOYqud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743479726; c=relaxed/simple;
	bh=AHe3rlGrNt9nVRLTYA57QyxjzkdjsVfF8RnIn1V/QpE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HYNRTh10BAZCDFN7DuQvrgjoX7C4Cb9tFZepNnigZoF61ws5YX1qgCQEAo8mc91WBZKHSi4t03PGyYfBjzGyRxPewAoK3engPhfR058scgdCnSZw8EogGivqtnPh74GfIFhCX0QiqtUqvF9Jaq5Tijd+OhO1urL6sIJrQkgCUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8BjOqYV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8BjOqYV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227cf12df27so72201345ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 20:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743479724; x=1744084524; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4BErke1Lfm3NFYDVjwANn0jZoyJ7DNPzIKCaOR1HbnE=;
        b=Z8BjOqYVXWyKi0oGU4pUIWNrPkECbCXsmgnE1ki54E81JsTZPAvjcjoV4bSPimB/iM
         9kEeT5BG7SbNJyKYShi2Z6tbNNqziK9Ly1X/JY2e2qGU1PYpDbQ2Wv3Ngl6MV5fMEo40
         gM8b50qYp2sxxuBps8ySVA8FawhVKz1MxdjywAlV5FGmOB+9oZmYT2xepc9QXn28SYdI
         rjTEThS1DpRlwPuK0yijr1CAqbT1nefLS7e0c+PswftzW6VRGkCVIb1ShKrXtwRFcF4l
         Y073ZSMNTCwjtxYejT+1FWiPv6uRNIoioo83wGRxORWQUNxtC1M9OvN4fRH2OgXjBdfd
         l7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743479724; x=1744084524;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BErke1Lfm3NFYDVjwANn0jZoyJ7DNPzIKCaOR1HbnE=;
        b=GJ3+JUwFH0pTtYAV7EeE3U5wT8WqIIlgnuNUCNcT9r7uYhi3A9Jb0p9ONg8eLP5YPn
         BvVOyRZkDn0uGQTarPkslAAtFQzC27WqqJmijp2JUQbrpEJMhZ1BmpbFZKBv5uP6R+SD
         rGhX328lr1iN2cFC08BGkrsmaf+vEpS7ezgDhvjRREMFSJ8aIsqsMeRmBzW/ef/sOKxI
         cdm0tg8iZtaUchEK0n0rxjmhE77L5u+smE/u94NdIWuH3GZZEjoQzNrVdVTDakl93ZOJ
         KGwR7PO4PB4IPHvolX1kLBdY943+8xznH83v9PcRWTONGB7J3UGVdRicY5Qq9IxMnbEv
         8KBQ==
X-Gm-Message-State: AOJu0YxDxiwNk8oMdVMTQW7L05Ym6DmIPXneSOi77UD/NQysp9RLndD2
	HRO/HvVqDOrGeAcjzGAqem8Z1Z5E7wTxwCA5sIqOUi1llIizUfwpZ/PnOQ==
X-Gm-Gg: ASbGncvU+guFSp9N/E7HRB3R5K+ecOImCrpT9bVEWAwKVyVVy5+Ojq9kTqpXUy1aBng
	2Llxpj3USyuCbygSbsVgM6kn0sIOjBlCRWpKMNUggT+fSmrxIoZuHLc5CFdJEpe0Uz8MNgjh+wH
	nRd1OCB/pL5Fyw5jJt+CZWARGNE5eD5AVvQUDBeKXE0MU8v5qhzyw0LPUf0cyOb4HjCFfWfi29g
	TA/XDI3YNoCG/XhSb73W5gijFGsOrsDPo1Vrs5j8kGX8NVtF6I72Np94d1nHaw8jw8K8taMH89U
	ACrO85u9IHBaxho37zDTDppD+AAknX3HEUUw2WNPzCVVACtcISs=
X-Google-Smtp-Source: AGHT+IGUlqALfA3Nh+sVDcJ363WgR2pq8gHL/T/rWrDMDy4mDreuTFnXI2a5uscyjaJ/EEII9C5Mfw==
X-Received: by 2002:a17:902:e84a:b0:21f:53a5:19e0 with SMTP id d9443c01a7336-22921ccc4e3mr253812955ad.12.1743479724098;
        Mon, 31 Mar 2025 20:55:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.247.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1df027sm78147385ad.181.2025.03.31.20.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 20:55:23 -0700 (PDT)
Message-ID: <67eb63ab.170a0220.259bee.d2a3@mx.google.com>
Date: Mon, 31 Mar 2025 20:55:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8716510324242082570=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yao.wei@canonical.com
Subject: RE: policy: fix HSP/HFP reconnection
In-Reply-To: <20250401020221.119615-2-yao.wei@canonical.com>
References: <20250401020221.119615-2-yao.wei@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8716510324242082570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948733

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.84 seconds
BluezMake                     PASS      1562.68 seconds
MakeCheck                     PASS      12.91 seconds
MakeDistcheck                 PASS      161.21 seconds
CheckValgrind                 PASS      217.39 seconds
CheckSmatch                   PASS      289.96 seconds
bluezmakeextell               PASS      100.81 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      893.38 seconds

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


--===============8716510324242082570==--
