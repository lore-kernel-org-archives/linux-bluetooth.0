Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAE25A638
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737925902; cv=none; b=XOccJqQQAnRIiZbsvYFHIBGyCLKYpVGCUgHBoSyaVPdJcTllHw2pPSFT4zGKTdZ8/ymqxOuGHoZsgWdFEWkSG/D/QpY2G09l7udLO86IstfF86JYfJnzaW8mfOusgOTbiccbYxvsECY90gyE5MkIt2HfTwGoQlhsBpW4Eqq4oxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737925902; c=relaxed/simple;
	bh=gihhG5JXbzZo6ez+sKrx5wLD743ioFoDnMjAgFxTtl8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VcreQXcTpCJSzvZAWp8DB3xs3OrP2DVrDcnrd0sYlSAKH05SFklQsmXtk+p5c1WGFi9rvuVd6NIpe8z30MORiCpnXHa/eRfctdCyiJ2pgxXy6qST3KjSKtmgsHAPyExNbUgbv1PC0mihWfWrcflIEcnsWVERMasGoWlFT3ccjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSXbS1SI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSXbS1SI"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd1b895541so81189576d6.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 13:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737925899; x=1738530699; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uvy6ZhI1kVB2e35ewpz31Jja1secjqmPZPotbyaItu8=;
        b=JSXbS1SINumb1rHaY3YqJEWWkEt2mcFL71tddiotrLJYjVTbOMun3VDZytrzjReCnB
         H3IVL83LGXpNgn7u8yOifU4DLU7I2AaBan5QfKfDJLWakSCMIujBXn4yCi7xz+Dc4DNT
         YT0Dup7b+i0jxtdZiBILHe8aY1RnFlkZA2pi6J2pBUObeK4JZXo42eLbu/8FHGYp2Z3Y
         0Djlo45itNRgaScVz1WFXbItzU5c4U4KYljzf5GY8HzV2a+jXn7jhpHr152MQ/fIrk6q
         4gK2Ou83LVFHjimJ8vyvNzrIc7H5qBtyC6S2Jd5K1s+5m2gnBFhIBmH0Gf9rxAMGZ1qu
         Wbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737925899; x=1738530699;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvy6ZhI1kVB2e35ewpz31Jja1secjqmPZPotbyaItu8=;
        b=Ucz6p6FW2DZ52903kUVkk1ufB+BnC4YF9DOn0rN+GE2HepsF7GP7eWvrsZOqJ3GOkl
         pcQccWi6f9w4twdy7nDePxO20n4kLNLgaJDHzUqwQn/H1FiTT74bkBarml/8pUPoX4wz
         OAhMyTPDn8ruCU5XOZj38VnLfwHRRFCVrggFObLmq8g0JkmU80BOhgejkovt5Nalmoun
         6QGAbFAoQU6rTBl3DYq2MSiIsoQ9WjeDhktU8lGX78D60UTF7AhuAi09Zse/Dk2D2JkV
         dSopDWwyy9QaHeJk4OLIo7i1WBQPr1a1BN33ySC9ZgQkZVCxciBzOKSOg4D5maPpPLAV
         aRiQ==
X-Gm-Message-State: AOJu0YyEmYZNkDJ8l0vLuhSfGEbzTLk09j2Nka4nJ4pHg/OURjypfZUR
	FXWHO3uXtbptiJtDA+rbT1x6MUnjyPzzd0d61ydMjL4IFE/mnLUtVZCSIg==
X-Gm-Gg: ASbGncvuSPkup5262bm1a+MzJv5y/oJagaeOzGH0EtyXF4w2+UGpPrZZWzaMkUK0t00
	RqQiek9TSvl9RUbYLaKz6GqbiViS+hm9dPel0/aF1N33T5zSai48DVr3YtcwnWiFYMKb/ar/z5c
	enWd+JsuCZEZjdKD7DEYuMKcArZ2t7Bi3mprzGd3sI/hTt1eFu2SztBKEDJL0QJnuPUYWtFlHrN
	xe3uDgBMmOKpmy66o9TI2KYhH731HxridWwxRGNlh9EumcI9IGp3zwqWtgq5z+E4M3q9RTMoTnC
	sGEFsaTsE/eh
X-Google-Smtp-Source: AGHT+IF6Gr58zA8a7OFErkWhdSU0hPijavo+Zvk68u5maLnIydvptimJVStMvn+sVZ+8BRLZrcRniQ==
X-Received: by 2002:a05:620a:2906:b0:7b6:773f:4bd9 with SMTP id af79cd13be357-7be6324fbf7mr5839460785a.42.1737925899276;
        Sun, 26 Jan 2025 13:11:39 -0800 (PST)
Received: from [172.17.0.2] ([172.210.84.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7eccasm325095785a.7.2025.01.26.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 13:11:38 -0800 (PST)
Message-ID: <6796a50a.050a0220.159a2a.c87f@mx.google.com>
Date: Sun, 26 Jan 2025 13:11:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7960223083596599107=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] shared/vcp: have only one volume change in flight at a time
In-Reply-To: <06f0a1ed2fc2726b8dd46eef113e07ad742048c1.1737921917.git.pav@iki.fi>
References: <06f0a1ed2fc2726b8dd46eef113e07ad742048c1.1737921917.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7960223083596599107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928426

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.17 seconds
BuildEll                      PASS      20.45 seconds
BluezMake                     PASS      1644.03 seconds
MakeCheck                     PASS      13.58 seconds
MakeDistcheck                 PASS      159.53 seconds
CheckValgrind                 PASS      215.13 seconds
CheckSmatch                   PASS      271.33 seconds
bluezmakeextell               PASS      98.65 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      871.08 seconds

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


--===============7960223083596599107==--
