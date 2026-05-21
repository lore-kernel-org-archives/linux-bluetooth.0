Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23362C11EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345882; cv=none; b=eAUveSpK7fodu0ldlV5bmg36Wti56MuClWAZlmOFoXKZmISyRmJEzEzrJ7+HU6R6EPvzyzBtccIARCf/DOmJmI5igahy7QDESBum3MNVsGQ0LeCnn17alT2zoc+wctFY04kzdcL8Nq3Tj5xjXOzkIrTJ4WC8CUXSxbyYvWWmSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345882; c=relaxed/simple;
	bh=1H5cF/VkOnHTLSMZxK1tnPmYx+ccFGC3KzIGxThLCWM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sqm9qbPjkY3/OMTRIFK/aJ6do8wVTj8bPQM6Wt4zzxj1vDXy6Ea+J9LNO1k2Mwhz4HA8gGaJVpU3yXFQJlYhPLoA0erblYevBsKjQT1I0gTZ8hS3Xz+pmQUUcZg4ZMC//FSKgdRZGWsNTL1znBlzSKcjK+dfhEHabA/SsLIwAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX90g9tr; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX90g9tr"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ee990e8597so14421973eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779345880; x=1779950680; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eVXWbUQyEaGK/WNdmvCQaMB7EfbB/j6AdaFLdbPMDyM=;
        b=LX90g9trqgbzBie/sv2S2AY77gXBQBegwxYHfECW/7STcAYFXRUtUKYjPE2bMwFOve
         sCJRPV8lC1ULOsJZ+URMT0X4n2JsElrgqu5RniO7tfXkK8AJSC6SrjdNL9o9EvsSNnx3
         QATGZ0394CFxMDCO0KhFLqpJTkWhMNY8mjphxUxJZpeC6xjffK0IV9yrgLLCScsHtC3g
         Sn32eG0CDm84r894heU/yICXDX8CRYmkeTOQmUnFUFHViwTyFMlrXOciq0a+qz/8NvF3
         4+ZUKBI1tjm2g6+I9jZ1VZKsV7lGFsb/tFe5OmWt20LiOGr8ewxKTVHN82phM1eqrTuc
         EfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779345880; x=1779950680;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVXWbUQyEaGK/WNdmvCQaMB7EfbB/j6AdaFLdbPMDyM=;
        b=IE37anOTwWo8FjKHeTX6pq8z5Dj9oMIQ2gyofI8nkTcGnxzOYUCeymoP9rhKr/qP6D
         PJkIeySf7EmCUyNhWuR5lfqn1y73cKaMXlvTqMuRTYZoKXrUc2fDAGtqEqW86XiF4CtY
         GXUvZlzuBmTeXhwn91MQc/yBQ6srSUoJxdUuenYXMmlquY080leAbxmrGF7u1arQvT8R
         Cmcm9BwtC0lGYVUoUBuB30dQ0jmru/81lEGVzdi6ufelvaJ6uSuBiN3yrjvbZQADri6m
         /oqLzYhdyX0IDugmrhnOIoDoLyJvuC9adulEI82y3M9C+A7wRBwWrgevUq01snME0IYl
         QRTg==
X-Gm-Message-State: AOJu0Yzw7NO1YMmY1IOgL0CCNIDSgLDdNqC3i7Bti3fYEsXl+i43KV6O
	4Lv4PCFylD7y2VY2dwCin/lH/C1KC4Cp/cfqGpKNx5PXrB2P4DmDTm1mSF+mg0Jl
X-Gm-Gg: Acq92OHpw5uiilr8Gbkp8p7E6MGFvUtmVyRRwayss3C6+4u5h+4zqWQd0bSoZSkqDmY
	LkAOWeU2E8tGWibvGEB2TRoTn/BjG+ZiwLKBPxT8bLT1Ogosp1U/yXfwMF5ZnfMoB3CiZ1ZufMC
	GTM7si4CD1engwTYV4D3K0KU/AIxNznr++F3kKrsidtpkn4KAqcANHze+Bx0TFLe8k1gYTDXPOo
	HRf8RbI9+aXv3WJuYP8y71TntQ77WKXHgRIM41sHgQTchsHXiQ7rQAxaQKmxOVUd7nlZcmz0cpg
	MDNKTm9qD6ANB0d6sLyKZTnvJ7sg+PC+FQOScd/CxVx5YgxO69nUvNFR7luYXUqCU2jDKwiYwy7
	Pd5G0RpumBxttrXYftw6NEEDNivpurjQK6ox/wYd4datDQC3PY2LWEwM8JnQLOtqxaEObZuh+do
	6pl7ptsfCAoSFBqzEHpplsjkei8t9OQ3UW
X-Received: by 2002:a05:7300:641a:b0:2f1:6252:f8ef with SMTP id 5a478bee46e88-3042f43470amr1025550eec.1.1779345879921;
        Wed, 20 May 2026 23:44:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.208.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdce9fasm23736069c88.4.2026.05.20.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 23:44:38 -0700 (PDT)
Message-ID: <6a0ea9d6.9731324b.151088.3f40@mx.google.com>
Date: Wed, 20 May 2026 23:44:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8753555242962841289=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kx960506@163.com
Subject: RE: [BlueZ,1/2] shared/bap: Fix unused value in qos
In-Reply-To: <20260521032815.1845-1-kx960506@163.com>
References: <20260521032815.1845-1-kx960506@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8753555242962841289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098419

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       FAIL      0.50 seconds
BuildEll                      PASS      18.04 seconds
BluezMake                     PASS      643.58 seconds
MakeCheck                     PASS      14.71 seconds
MakeDistcheck                 FAIL      213.39 seconds
CheckValgrind                 PASS      258.46 seconds
CheckSmatch                   WARNING   313.93 seconds
bluezmakeextell               PASS      169.78 seconds
IncrementalBuild              PASS      643.36 seconds
ScanBuild                     PASS      945.89 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] transport: Add support for obtaining PresentationDelay in broadcast QoS

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,2/2] transport: Add support for obtaining PresentationDelay in broadcast QoS"
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[4]: *** [Makefile:10239: test-suite.log] Error 1
make[3]: *** [Makefile:10347: check-TESTS] Error 2
make[2]: *** [Makefile:10818: check-am] Error 2
make[1]: *** [Makefile:10820: check] Error 2
make: *** [Makefile:10741: distcheck] Error 1
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:312:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2139

---
Regards,
Linux Bluetooth


--===============8753555242962841289==--
