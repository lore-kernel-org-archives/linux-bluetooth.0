Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707327815D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652706; cv=none; b=OW/sMH/RrL3knEvrGI7f1NE12tFguiRksVYciqNUxLKZlwz7YImz+YYZWhi3svgrQfgc8hi3f5FR7GGWO+gdAKHpTDH2MiI41YF55TWKM+ysPd3USRFX5nlPtjwp5/RU1+im8qSYten/3SRc2hHhtQYqw8iCvFFZdGE1DptVSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652706; c=relaxed/simple;
	bh=UXA0Dd8savVVcRaw5fDRYDtIXOv0BKgn36MBDjTAavg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iM1b8qt6dc1i4tFcyhJnbUY+UuzMkZP+I0uMU93kxlnXe7/6MootFb0IWTsljC+qe6WkOvgSPGgb1B2cBImRK3sUqC2FldA0qjJ1w2L/aAxs0LP4CIyRsWZQJ4Ygmag/7uPOndueU3S1CC92mn7GTB501+kSMYeRUwsr1EZCdH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmzcmg4O; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmzcmg4O"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d3862646eeso241043885a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652703; x=1750257503; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G9yuzYDB/oRksKfp67J1OmnjG1AiJKrQSsxRqmJkHqE=;
        b=Tmzcmg4ODpa9jjST/tc8or1RO37zWaGmZNSLaKuerZLPxo96KEVRMcfk7iUZ+f+aG8
         8AGKnx9nQSyxOlaiQRqgke36ZUYosY7i/SASutR/lyFwdLnqgK1Qp6P4/rLCeKDDtXB2
         FFgfAhbVA2Ago1nDL22llRcbH7dbzaqk6r9O7PzUWuNXi8jXFd617lq1+ihYeDMgGEcr
         Fv9r6hyUd4c0mcJ40v2onoEXjFEX5H4svqWAIfRUMWwY5RoO3t5w1Qz2UqyhvgS9ZwCG
         +nXchR1YfLF1TUU8pX6w8WRjMGr/2LN99TJz/AogBx/fauFUhjDNZIF8SRWSjuSzETfw
         zn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652703; x=1750257503;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9yuzYDB/oRksKfp67J1OmnjG1AiJKrQSsxRqmJkHqE=;
        b=vg3NKP/tPWdW9g/r44Q6MjV59y3ef8L7xWH/lT7lDZcz6gBYvEzOmVs1cafBZG1JXf
         8a2obmcV65ATYnViqno7fe39hwcjEW8Yzj3g8SzvGsHzezexp2iyrU38fqOEEBp2wLU+
         GvMDWfrsNa5dMHrOPWzvixdjFRBWCKxK+6ZtHf/3DQJ5QYwhJ0no55fpEGPRszff+oKR
         9o4vTuFGalaZvq2oi6WK54j3fpCikjjbpj9x8rKkYhoTzObASi40yewuhyfM4JdL1lCU
         btCcI7Nkj4DG/7Yh8bAQG+K48X2IBP2O+ENPEmQdwWfrcR3gHK+jEvow01nnxJmIKZRX
         t6pA==
X-Gm-Message-State: AOJu0Yx+DlXI1/Z+zGc7xfkbAUJndAC7JKL8JQjQ1YRNX3kIqrLO/LSA
	OgWJ+ZLCtkn9Zo30ikC0XpqsND8FSbxB6qkmHgJttpJL7Y6IwxyoW/rhjqCf6Q==
X-Gm-Gg: ASbGncvvGCkMMn4y6PmfXKpUefh8dUGO56lrqjyxRCbz46BBRnfcYtvUVekIljdTqKu
	NJNDeMIKDc9LSuyrUpPj/6jn35kgAf7wyI+s9PctSaEhu8r3D2eV21y7nMWEX52LTFHbIoRT+l/
	otLr5UEpG+7ajHItBpVzzUXQBwOkjoXn7lM6J4j/Og3teajGvkzag5eyd3fssKzP3+K2l8X6kMN
	7wi9Gb4ug/EKDcEoHV4VJoGwrj95CxrNh6gCIl7voKWG2umT8N3VlIMcpo8b041S+eOXFnkyErI
	2vSFKocfnSi0y+9CF1NAqvtWPfnFbkFxHeG0uOPuqiOcWX5Qo1Ku/BuMdIp3Sx6AK0o=
X-Google-Smtp-Source: AGHT+IF3nCXCiMx0pNpzaGtSTj0AaggR/lrH6Et6ZJctU410UqVhqJaCAqmMwvmpRpJ6ffm60Zof6A==
X-Received: by 2002:a05:620a:3186:b0:7c5:65ab:5001 with SMTP id af79cd13be357-7d3a88da10emr507723585a.39.1749652703303;
        Wed, 11 Jun 2025 07:38:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.55.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a535863sm861456885a.27.2025.06.11.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:38:22 -0700 (PDT)
Message-ID: <684994de.050a0220.1d50d2.35c6@mx.google.com>
Date: Wed, 11 Jun 2025 07:38:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9079311780498355255=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@valdikss.org.ru
Subject: RE: [BlueZ] doc: sco.rst: BT_PHY is read-only
In-Reply-To: <20250611124917.1255095-1-iam@valdikss.org.ru>
References: <20250611124917.1255095-1-iam@valdikss.org.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9079311780498355255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970839

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.89 seconds
BluezMake                     PASS      2765.10 seconds
MakeCheck                     PASS      20.16 seconds
MakeDistcheck                 PASS      203.22 seconds
CheckValgrind                 PASS      280.06 seconds
CheckSmatch                   PASS      308.48 seconds
bluezmakeextell               PASS      129.08 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      922.77 seconds

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


--===============9079311780498355255==--
