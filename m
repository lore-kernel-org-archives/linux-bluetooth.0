Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C527466A
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668578; cv=none; b=jCnFbm3Nc2HOlvB5o1vUL3UGl8SUwu6umEbXmSn3mnQg3j0ifOsI+ZW0Vp/G9/dgLoJZnveeDY5VPzgMoktSbz62T0VgCmXzlSKVwL+wiJ9ufMDLU5EV2+PZbhjDH7+wOpXOrPQL8OVLUP8oc0xPrf6DcwNLtA77D7CxsI0DQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668578; c=relaxed/simple;
	bh=/7KJfU6ZvOuwE4jrfU0Ud+tTvosE+KS3+1dNLhboiE8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JHXufJXI2VI5Yivr0I+c7DRqYibVFpzAtwf1PjM8oHyO7dktrhflbSHyaEBoO3VBCWzpqZsG/gmrrDg/eRe9OKtYXo5R7MRMfSD7Rs10pXfh41rVC8vkcRd77IgtKu2YR6C8a9c1gYadB0WA3sEf92wJ3A6ZRutI90KWz1QyDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLMRLArE; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLMRLArE"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd05d97cso4709268c88.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790668576; x=1791273376; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6jqBZUDYH8y8dBHxkt5oIGj/jcEedJNpEYL+HGZwuQQ=;
        b=LLMRLArEMGaUoRHX6aElwJKFM48/a8by393jv6FUcRz6kQohCz5/DfPV8wGWgkdZT1
         6gCeMB+109QTQQDau/hUy39jQwhGaYLT1syvUBbsrjq55XIMWdDCuPfYck0zMwYUVnY4
         Ogzp9GQd8OG3h3kykiFl5KgAq8DRvyVbjnL+5R9D8m+OkMtTO/KSVCCujUdaZR5MLy0d
         JY4DEAotQyY9yDs8fOG8e8lHJjC/iMFAs9kJw3dpSCDvq74K84KcLiF5/JJz+a9oCtIg
         bhJQZyRPTKV+PfpL0nPtWwIQBskbJPHjJRYVDZnXZDU5OgnRNr0ZFoKNdo0zQ0f1ryMJ
         CHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668576; x=1791273376;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6jqBZUDYH8y8dBHxkt5oIGj/jcEedJNpEYL+HGZwuQQ=;
        b=GYslYTrKSzKI9XSWm1sGeqqy4i+EYBICtfP09Oa/2Dmv36nHTQNwAOkapqCdx3l7/H
         EkbOiLKe55ywEK/sowYS7MWr+d9casKjWWguoAauq1Z5L2a7obTcdDv5eltHHPIaXTsB
         tm7J56WqM2sf/9KQDdiVLOTQ+lSC0+RtZ9qNibQdAWw/qlavH8py52TE0ErNilITh4N4
         p3rX4EkeR1LPkFisAEhtMzifQ37Dje3mEyrS91Nyf/8PRM5plnIseVpDa4ENT+tyjeSw
         d1GoLHgowG2+2ivruFS5OGNNeZ6n6vJ8BDMvYHk4lxtNf3ydoLBGWpj/7zGnL830KCN0
         UGCw==
X-Gm-Message-State: AFuF++lagCmay8Aen5iK9ySvabscJXFCPcDrqOVgp22q1NqTj48QK5Ic
	qcEIySULDHzU1dWEbRN20O+iljVeSmVwrw++yBXEt7YhXYcuvqFTgA7AjjKXRg==
X-Gm-Gg: AYBFou1lf900TPiuQe6vD+pyFk6+TxFODrMM7c6KL4OtXskdZfyKTCJ4eI1D+ufUp+w
	qkBytAH0h+EAVDaMkqcxVRpEZP4scV0RDakUbnkc9f9RHpHoQgcO3agnjTl1yDyU6/samZ9Y0zm
	DdeXEud4kpe/NBYl6dRlSy0mpr7qgZdNh5PHJnuXc+vy5v/49cn6933wpbj/UsHRfY6o/VWHlCp
	i+Nb1RAzKMNljvDD6BKFrMzG9xnPxk2rZojL+k6gqVy9GZLtWCAKKaPqURFv2Y/q7a+8p44bJVU
	pHSjimKgiXyDaw5E4s04UlFKkQPyfmaI6iYW8vgBi2y5XjUDsVY4sbAfzmm2F1dSiN2ftjS8wmT
	NiT4pLTJXvat3KK8HEq+veGbe5T7cLW0JAXvdCIlY69c4yOZXy/P1mVkigCq1LbIUo6fCMiU8Iu
	C6L2CrcIYlCK9rw/JoCFZyP7zFF+zlFgpR2mvTV7xTJUBykQfyBVU1Tyxj6zG+Gf2Ht5qI4BUAz
	hufKOEh
X-Received: by 2002:a05:7022:b0c6:b0:145:4ef:e8de with SMTP id a92af1059eb24-146ce67f233mr12453944c88.6.1790668575596;
        Tue, 29 Sep 2026 00:56:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad8e43d2sm35756346c88.12.2026.09.29.00.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:56:14 -0700 (PDT)
Message-ID: <6abb6f1e.5bfb57e8.2dc3df.0a0c@mx.google.com>
Date: Tue, 29 Sep 2026 00:56:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5307305159706379910=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jmsmg1@me.com
Subject: RE: [BlueZ,v2] mpris-proxy: Line-buffer stdout
In-Reply-To: <20260929024530.3978095-1-jmsmg1@me.com>
References: <20260929024530.3978095-1-jmsmg1@me.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5307305159706379910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175715/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      19.21 seconds
BluezMake                     PASS      377.82 seconds
CheckSmatch                   PASS      289.05 seconds
bluezmakeextell               PASS      92.60 seconds
TestFunctional                PASS      1109.11 seconds
IncrementalBuild              PASS      399.36 seconds
ScanBuild                     PASS      1105.02 seconds



https://github.com/bluez/bluez/pull/2604

---
Regards,
Linux Bluetooth


--===============5307305159706379910==--
