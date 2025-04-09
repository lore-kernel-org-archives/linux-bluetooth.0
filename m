Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A11E5205
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236195; cv=none; b=oU8+TgQzUkNVteN2aUm4LToT2Wt4wjGJnIOctUjUJBjygqqmRkGVY31P3feLV8cD+7slRl/+mGD1XRoNAApleTgdsw7gI2Vl+t3eeK0VLJqiqkHGhWc7PdCKNLiabnGcGWTiJUo1WPkeBb20N+ak/D/SDFzPbVbcyEYZ2GzbW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236195; c=relaxed/simple;
	bh=ikjVMnhUFXwm+oSN3Zbo96yo1gD21l03rPDUie9+LK8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qvvQp2EZdL2TPhFF6UJ0M8vWcDbqG0rOP3MZhW2b+CrsRtQa2JOLynQca68i2t6n75sLFKL9VVitpfRwEqLMYD0gBpUKfL1Jqcbz3scqCW/9HmQSn0l96tYVTT162gDuL66/I/motidYqYvbf9TRZW0O2klGaT8nq76n7Ud694U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlkY2Jjm; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlkY2Jjm"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c54b651310so28776085a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744236192; x=1744840992; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkXOHWJQr/elmejPAMnVJeErfXF3QVISmSa4ozFGCnM=;
        b=GlkY2JjmC9CEuY64m7KrQtEFil4a3zWAbhpMI54W2sKcft/a4+xl/ta0zkVTOspHnH
         JfjuoEaEcskFoUHNaJV6/ldqC6ci0gFsng3IriMxWId7GFbT3tBwmbpiDbXxYkeh9ydo
         e7ht0TYOtXhnc0mJAovvOHZcHpGmUdA/psHNP5aKuT0cFgfnVJ9DwPlGhzqqkEMkZtEn
         QvElreO4A+4a6Td+Y1IGGryW0YdhCHwEStNotSqTBDEAhgop1Vnqqb4dhumBRgaPZ+Yv
         oyU4UMhz0y7Z8qdvyJPZ55qkwwdNOk1UXJLq57Ll3D6L79r5RlC/r8D3wQ8Feoy6uDeQ
         zdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744236192; x=1744840992;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkXOHWJQr/elmejPAMnVJeErfXF3QVISmSa4ozFGCnM=;
        b=QynivR5PxHabjkdoGFmqlvcoEQKgSYY5MBapwS9ugitVWFVrBBnph5fQPCb68Cg3em
         duK6PM6DSCs5iGby3dbxq89QNAishLfwJrn0+xdKiMPF9schsy8OmAjgvbLLMzjnriNk
         qSSuqwPWIsl6S5OYCqlCu7Hd0VDoJS71CTXTBwbdw8H94W3lnOme5W/kQFIOBgFhYVt9
         SywXQyIBjz7/tEVttYssJ3vs6r3QLy8u3wamhmiIOqNwjQIcSb3yZ5sSo9OZKP/Mr3nh
         R1fa8HNsk5+msI/wG+w+Beo1lDttj1QPKsV3uUNGgf5c0j6mD/sPMHVgr/CassGVQ4nc
         d//A==
X-Gm-Message-State: AOJu0YwPGeryW8l0Buuc1jAn3PGP6BtoOo91yRYA+VXyO9RUkqtOXqdR
	AQNO/dReYZxNerkshIZjJ69gtkYFscIKKMri2kroBIuD+aZYf3xA9eULhQ==
X-Gm-Gg: ASbGncsX3mP3lhL6hxXWYBvbXuSR1ziUBSCdAoL5JecxXA1nvbBHhIVCEbSLXa78SPc
	ogsIXT3xvwYxejzKvKGJ+5ZBCCFEUuqclPGG3f5E1/jYwGFduuUEwv2AJfI4a/g4ER4RcJnyokR
	HOUfGO7640bt2IqKaKd3XQPVc2IQ2/qw4ch2ePNwfew9J14EjzwfVp2xtPP6nkv1ioEx7czNxuf
	DIR0/r1MzxmYUzh8sLUNADDwZT/G9ahCwylsQoANhnl9BrZOxyHLdDE68DjtK+eyb2Zq+1Xzl73
	hwR0nPrU9KfK+5oi34bjgWsXiqL2xb+K5SGpEmkTW6ikQg==
X-Google-Smtp-Source: AGHT+IGcSl2wjuTcrgJomNdTRGGNeEMyqR2wZdawkJ04Q1/cM0GGz/aLh0qkmwzaMiS+07VS/HqFcA==
X-Received: by 2002:a05:620a:1a19:b0:7c5:5692:ee91 with SMTP id af79cd13be357-7c7a766e2e8mr70156785a.23.1744236192312;
        Wed, 09 Apr 2025 15:03:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a10d3a1csm122481385a.61.2025.04.09.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 15:03:11 -0700 (PDT)
Message-ID: <67f6ee9f.050a0220.394581.4e07@mx.google.com>
Date: Wed, 09 Apr 2025 15:03:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1449169748405554736=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] btdev: Fix checking for BR/EDR scan enable rather than LE for PA
In-Reply-To: <20250409192148.305768-1-luiz.dentz@gmail.com>
References: <20250409192148.305768-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1449169748405554736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951703

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.18 seconds
BuildEll                      PASS      37.77 seconds
BluezMake                     PASS      2614.64 seconds
MakeCheck                     PENDING   58.97 seconds
MakeDistcheck                 PASS      200.97 seconds
CheckValgrind                 PASS      274.93 seconds
CheckSmatch                   PENDING   363.72 seconds
bluezmakeextell               PASS      128.57 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      908.94 seconds

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
Test: MakeCheck - PENDING
Desc: Run Bluez Make Check
Output:

##############################
Test: CheckSmatch - PENDING
Desc: Run smatch tool with source
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1449169748405554736==--
