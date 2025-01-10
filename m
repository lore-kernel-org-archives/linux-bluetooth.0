Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E82066E0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532468; cv=none; b=sOfARQqU/pgbOU9j2M7rYkGxLn5PoWgwAVIogoZY5SX8K+ONSpZDiMd4UyDpBZ9UzufjySs0nSj2JBuA1We7uVJKvwWNwlhGgRslSXQ2fq8E3JgP4go4kLf4ze+G5Izd5Mz95rzUz2SW8m/fT16kI6/9pOvVRC5zNFV6VE1uGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532468; c=relaxed/simple;
	bh=kTIpIQV2Kr2z5dCsLZ7KbsYbX8ktR1F3nAf2zbz/Zns=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YybFGQxP4AcoGUITTCEXyeQb26ixFTNaBFsOujhNbWb7xZ0uAA8kTAiCmGooBRY2KLPs86FutI05kGW+oS4bCwhGWnPQzjFlBzMtSNhkGwfzHaXM1lx74tEXuZhHUVajjWPHEMquGiNq58yceH8O8furfqiR7gu5Jz6rVB9+0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H22LG5Fg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H22LG5Fg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-219f8263ae0so39563375ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736532466; x=1737137266; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a1jm5TKQsQjIn+QsvREKioeYX2d5g18gexrEy8nHtKQ=;
        b=H22LG5FgFBoat8wNxENEgt0j4SA879Oi5zCjV+NtrvhYQRY/vk1ansEeOcoGkRk2do
         4qqYWzitUHCoCXX+j6BnrxpH469PGDLAePxJ7lB1pdnd9MCj/ASmkwkZNWgL1S6MELBc
         r3imuTY+nWP/Ot11Z3arlzQlW74vT1X9liq6uQvzcuptSLDZYKnbMdQG9HJgkhEL6zmT
         bNpQDQDJovL2UtCkorMJImM7x/XOFOaEi9lg54nZ55PSM2jbMylJT3WMmUlH+QhPVDag
         ylTFIzh3TEpB3N1eTzn5G/Qa2bxngB2fOQNOuIcPx4NeLmWyWpHbiWxvfjR1/Tu64WW9
         4a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736532466; x=1737137266;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1jm5TKQsQjIn+QsvREKioeYX2d5g18gexrEy8nHtKQ=;
        b=p2aGwnf4UvMRcaMwvRnGGQpjhVTTwsVRt1lXyY9E5LYBeGh6rAbVIOMowoR3mYrReq
         QX+A2J0BNdvSepdqm03gKrb3zosArioHuRTg3HZYpb1WRx3HMUsb3AEPI1hCtYYYqztT
         9TcFEBNVSW5uaaJIq1l1GCec5BolQ4hQffsOKxxFTna+mnT+GPGwpJWWmJLFcNRsU/DZ
         tD7a/yQt1E8m799eV0UfLZ3h28ib2s9+bYEd+RVOw5xxgJRm5lKGyaX7CGy6GshiwlQ+
         eMAQUGxKOLUix/6lQMvkQwFdPoQkndr7nZFqQdbAv0L1vtnNjjQ7BzEO2f1jf84Zt0Qo
         Xg3w==
X-Gm-Message-State: AOJu0YwlKC9C6tSpe0b6xjOetxUugS+HCpVeW0g5z9n/PJGXJO34HmPo
	cffCqrtrg8UkVR/YZJL7HZP2FFeLVZwVmJEIG5JsfmY2Ho6KsR83D3AgQA==
X-Gm-Gg: ASbGncskSNSQo3RaBVwbignROkGxzhMtGsYYEoQifSWQB+CC1xfyqavn7XaeBSNga4I
	3ycdR39ga7NCDuC3uWS7CDxYHMApAk70K6iUnFHpUxG86tZ9I/ohPgyfPS6MaYdcaG5LH4NTX8d
	6BnggJnGxQJj12tRa9Z0dhBrx2fC9tZTIDN2kHzU0W+6hVGHnWCvsbCI/JpfSjODwLIkbQq8Of1
	593H3jPodr7D+CX6IbpA0Z3oS6Owv+Z2oR7GIHm6yxLiPmA7Ov1MwJHiWc/Knw=
X-Google-Smtp-Source: AGHT+IG0dgq+8GlpWnFQuir/obOCdjtH7gWsYRaibNDmb87eWivrGW3ksIjfIgVzX0C34mUCKGNA1w==
X-Received: by 2002:a17:902:e88c:b0:21a:8dec:e57a with SMTP id d9443c01a7336-21a8dece77bmr128593535ad.48.1736532466311;
        Fri, 10 Jan 2025 10:07:46 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10de6dsm16544755ad.17.2025.01.10.10.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:07:45 -0800 (PST)
Message-ID: <678161f1.170a0220.1f64b2.b36e@mx.google.com>
Date: Fri, 10 Jan 2025 10:07:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0597139575897117187=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] build: Fix --disable-asha
In-Reply-To: <20250110164454.2660347-1-luiz.dentz@gmail.com>
References: <20250110164454.2660347-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0597139575897117187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=924335

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      1482.39 seconds
MakeCheck                     PASS      13.04 seconds
MakeDistcheck                 PASS      160.49 seconds
CheckValgrind                 PASS      216.15 seconds
CheckSmatch                   PASS      273.47 seconds
bluezmakeextell               PASS      98.92 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      872.35 seconds

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


--===============0597139575897117187==--
