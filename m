Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0031A062
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487023; cv=none; b=mY6kTafMGRw61+i+G8zy7AYGwhpG945g83wuL7LvLqCY3eJbRFz6yycc/mwaqylYA0cRGSV7tNh0YZO7Ayj7jUs9sdcf0d5wJXtdKjttrWo6C9HiSUp+noJjT7BuWr7jzuYZMHgaoiTbYNGmKxODziLBBFUExLN+ljEqZqhfFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487023; c=relaxed/simple;
	bh=ybvfuMNel5a4QS/ZaJ2a9RKi4ZmOMdJXmAYvj14v2cM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S/3H6Nbn3XUKwA6TVLn/DRO5nRscccsRk/asSFB3zZKAQXyRVM50hCFCnIUMkkaFwUOGQRu7Iibnlpi/p4iDphQ3l1eWt5KU/yqvKZrqTFHNiVacd5QLDM3AxzHOdyimnMRaoVdcPNRRFW2LzMrcJoBMUWvWX4oNSFyhHdKRwqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bk1zWa2Z; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk1zWa2Z"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50baafd6c4aso50570201cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2026 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775487021; x=1776091821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H1A5EO0khxV5w8AeU8jBci5uVC2ju5DUhWKLS5wKRvQ=;
        b=Bk1zWa2Z8jtGAW570VFD0bidlYrKagkqPaT+YymwHOdd9hKCwGKDYB93WwTYvUTE6e
         kQ1lXtE27oJ/NNGSOne/ajyHbOJ1uvv8xwrNftTiIghIt4l0sx3ECwAXag3jHWixD4bN
         NdfELg+7wId2m60GAUsi6Z1qMXmkLZ3mVDxa3LMaWmgbuCN/z35UnKPBbprWKi/9sqT+
         9vMWZTduwYJ6jWgVVoFUzPu3oMxnzIEMmxfCu79h7mW/lQGHZH2ngddly5y1NoT0/mHZ
         gqC372D9RWHvQF3toGVUprwY4m6avHCP6zblrMPF74jZSQnk5bL9rf539qMgqNnmh+hw
         VRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487021; x=1776091821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1A5EO0khxV5w8AeU8jBci5uVC2ju5DUhWKLS5wKRvQ=;
        b=qx7LslCohAVF0efVFbH95O9LQqv01HlBR858JPzh0+ftHrhfhxM5kYDi6xlL/OTJrN
         L2b4MFIB5/m1glZdza8WjZr8csi9jsKcMjdKB1iGJxW/ClguUBs9vA2/WkUWAN0QKXb2
         R9I/p7k8cDF0yf5nq5aBwZnJ70po7ILqdQljhZTkXJ2QNZsTkuV18ESK6FFK9TSSoF2h
         +MBD6Any+rdwXlJgzD8bYFK+vYLJt+Q7InuQa9XfACtji6nuFqey2L4xttHkmOxEUuRj
         87ivoS4K7hnV1LTJD1bgySEJTPzG5uQCdftso96Xq43U6EH4YdYN3teTwAUoGS6mu33/
         d6SQ==
X-Gm-Message-State: AOJu0YyIk2VXZ7c3zzj4BfXj910vGmCzDgVmzOpJBbXnWILC5bNalvVU
	s+hIYUIzNvIpj08R3o2mAGN094T8LkWtVIndLYJ4pehigCjtZ+wALupwGPoqug==
X-Gm-Gg: AeBDiesGlti0OTNtHvTNUma71S9Y8y/NTmNDn95x5dV7R+T8KfZXEvF9r23FGN7s/e4
	LCNGFk3EUuX/p9/1d4CspQKen828LCIn99PYBmD7rgKe0Mu6pS/f77adTSKYVwnRYowue9V4bqR
	T6GcIb5tPpD7D3T76ACk7MN96qMA8ySfv0DT/GERZbNFFGzYncaRQcaBk6BiRMvZihCNIgpCpjE
	BxRg9HF6L5HuuTlAJmT1EV3/3743f+O8tMI4QKB/zmE4n7CktKROEUnkH0C1lrnLun00ctCRTOG
	oe/gb4sZdSHlAD6ZvNgDWPSc0q/Okty4ZBmEoBNFHaz2oUFrWrC1Kl3idlQgTpJcyD+4FMfLUYd
	V/6EggOoFAy5ixmlku+Uk/93shFxaRHhtRbSH7EAQFvKKsnD/9z5G7YkPK9xTNgQDy1a9CpMqLe
	ffrrXMm1dxR7OvBNxwlN+tE5A7DRMm0w==
X-Received: by 2002:a05:622a:4cc8:b0:509:37d5:7a41 with SMTP id d75a77b69052e-50d62cc8a6emr197386021cf.63.1775487020751;
        Mon, 06 Apr 2026 07:50:20 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596a0a522sm120996276d6.32.2026.04.06.07.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 07:50:20 -0700 (PDT)
Message-ID: <69d3c82c.0c0a0220.295c30.ee7c@mx.google.com>
Date: Mon, 06 Apr 2026 07:50:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2184837219457481584=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] shared/mcp: fix crash on destroy after ATT gone
In-Reply-To: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775481285.git.pav@iki.fi>
References: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775481285.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2184837219457481584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077654

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.79 seconds
BluezMake                     PASS      669.54 seconds
MakeCheck                     PASS      18.52 seconds
MakeDistcheck                 PASS      254.02 seconds
CheckValgrind                 PASS      300.71 seconds
CheckSmatch                   PASS      356.43 seconds
bluezmakeextell               PASS      186.67 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1062.59 seconds

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



https://github.com/bluez/bluez/pull/2021/checks

---
Regards,
Linux Bluetooth


--===============2184837219457481584==--
