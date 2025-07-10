Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F541A23B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173595; cv=none; b=ZsXWGJTgLd/8XcnWibnyoIIe2kYFetbgBNIJwJzhq9KobVE3wmK5XIpLhl+AIXKfiInO/PUA5yVpIx18xiju2Zt4X7jvIVTMhkOcT1WHpDjHlneBfAze86sbioNqydn8kpIMeETSdczQfARLzehRgX3sKUldoUgsNWHctxRirU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173595; c=relaxed/simple;
	bh=Mbdu2JMBTccyw4G7itCFwxTY1UuV957A5fa2Td6UAL8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HRz7ALE92CecK9QkXvSnaqRNkuuhzTCF1At6H2/YxSs904+xgADyBE7hswdKauZqEgSJwLNS/P7jtPYNt+GDGlybrsDzXcc9X506BuVmYYkefXeh95MjOKh8m0UCnzYWJZ4BBQ1/jnYXRlRcQTXOEX3TGEVfVDmgY1kEnU6KYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld7IsVUF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld7IsVUF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234b9dfb842so13205685ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752173593; x=1752778393; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow9PmtZwC2bFYMXBgHe67NVe3hqutNaJY+2ewNJ2Ivk=;
        b=ld7IsVUFlZmaoyKqKSfSQAlI3n1NXFnoU3f4/dTRofC65B0HUdvBXikU6OUy2jduF6
         iFCdwyDuRpLY3o++RZB6E8cczWVRaSGKn6Xz/nE3h4CXdR+krgydy6Evo0Evp33GhfgU
         O3TXVu2CP6qAftY6tzU07o0scCkuxI8xgrAZhJWadROkB75wCKjfd74wpuLuK7FSe54M
         Vxy3e0sk10ZE/hUyA5VXubBSrMJwKAd6Z0kE2ju8e/hNlf3j4KzU6/3GMgnTMCGTG2Dq
         vwCuR/5BjIpOdqaigL9kRNjcBYa1Zfu7ud5xGdIEQDysbxW7GB4A2TPWwuN7+BSqZTL2
         J+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752173593; x=1752778393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow9PmtZwC2bFYMXBgHe67NVe3hqutNaJY+2ewNJ2Ivk=;
        b=PxeBzr744KyLgyz1PwH850OKDCmWagr1p1JNkmZwqj29mPHoxGaf4yMufLJtTwCFOP
         u28REs1/fAjLdKCHE+mqciKnq3UXCwxtHxwd8UDReTSCUAcL423GF2c/9i/AgFI9uBSt
         3OuTwI7I1RjvDQ8amvIQcIsuzIWkAGY7lsgNEkkIYju5GdyBYggIEnK7le+vb9246AgF
         tdFK2oddbaHv8JzrmjQ9XH5xUC7jhLFMCrIHRmNCFkQ5HU7VE8Y20NAjvDrhS+iziDEH
         ZqWPBUfwB7WO1eQA4qxO79O/ElhEsPe44JZBJEsRA6UJZ1/Jcs0kjcFO4h4sI6TJp4N1
         1x3w==
X-Gm-Message-State: AOJu0YyEvnETdx2C4wb4VMHCrbugKKR+KTc6FVR2hrZ0AUQuC6zZF3LB
	WHeMai/bVKfFk7YbHmV9s6B5q/I6fxBZswyU/0xZ6nyg3+nUj+SO6zmNnbJc4BUL
X-Gm-Gg: ASbGncuLFJlUXL4cZss8acXpWJi9EE3K2fC+SEO+2LSAXKRmWlwG44qQ2+bu0lwW3HM
	WbWWIdfAo07IKv8gxTaa+2IAKfHnTd83wiIGShjwszV2QJYU323H1uZc7mhIXsUrDRwko1KlPJK
	ciXgI41IWaHlOLUzSooh5SMY9DwbAO8mCirvWnv61wiT31LQAOp45gvCsYJVaiY0OYRZKMRjk6g
	LigldD5bvzAUNb53JNkotlLaRG2A2ekPtE1nuhGL9jA4L9UdjOWQgyjA7VWD4tBXG75dOMl8zMa
	5q2Swr88MdYi7q0P0gZlFVxS0iC+EqEeULPSl3RP3SYXOcpc5xGjJhDoBn8f3T+3yuQ=
X-Google-Smtp-Source: AGHT+IGUNyMMVgI/sUV1alBKdziU6YwVJRLLVV0jVVduyV+s5LtKhs+rEe/0z4MvgpZGszURDT8Ahw==
X-Received: by 2002:a17:902:cccb:b0:234:ef42:5d65 with SMTP id d9443c01a7336-23dee3a6cd5mr3018335ad.52.1752173593353;
        Thu, 10 Jul 2025 11:53:13 -0700 (PDT)
Received: from [172.17.0.2] ([137.135.44.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341a99sm27594775ad.170.2025.07.10.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:53:12 -0700 (PDT)
Message-ID: <68700c18.170a0220.28be10.a83a@mx.google.com>
Date: Thu, 10 Jul 2025 11:53:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9003781217320479514=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/4] shared/hfp: Add HF SLC connection function
In-Reply-To: <20250710171838.949803-1-frederic.danis@collabora.com>
References: <20250710171838.949803-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9003781217320479514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981156

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      2665.66 seconds
MakeCheck                     PASS      20.50 seconds
MakeDistcheck                 PASS      183.99 seconds
CheckValgrind                 PASS      237.15 seconds
CheckSmatch                   PASS      306.07 seconds
bluezmakeextell               PASS      129.37 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      922.57 seconds

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


--===============9003781217320479514==--
