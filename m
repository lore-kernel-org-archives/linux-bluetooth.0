Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54C33032B
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667615; cv=none; b=qlv4fgwYwAAZvFSpER/hnHrevVwz0fJiopuXYFuRTImKPSYok5q9wVWHdTIBpUqut6gQ989goHtoVx9ebYFqxQ18rQuUmpVVQF2OzYI1RiWav7A/UPZrHIgdEpFqUELX9LADx9u1F7eAdTDcIIp0oCQged8MSokPKg9g3Ramsjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667615; c=relaxed/simple;
	bh=T5P3WcV0ALdFgQ/zDkZvjQxhCKDZ2ZPyOwS531OF+Ic=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X0HiUmWkd/M6FWs3R1ayJFH8TNjXMXDzFjXcf81/1L4gUQRJxoURHGbty6th9O7Bwq8Wg+8h05JqhWw68hpYz35yv8buDRts1Bv3EK3TOHdPjxNRE+nQSO9vBhMTxVj3hu6nsdnusRo3NYKJt6ZkSLcqsjgTa6GFNzWOZi62dm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJucq4Ih; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJucq4Ih"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78e4056623fso61358466d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761667613; x=1762272413; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I4gYW5qsNzJO72TIFndUfc9Pvhd9ri9qtMJw/7Ia0g8=;
        b=cJucq4IhahLTnIEDIxTOMGmIORipvS0+R2pZlCpjH2H+3a2HfN7Lnr2F//CFsLjE5A
         ZpMkHzLmNZMNxzL9rfIBdPK86jK1qeKHfmcsWjBRmdk76dryLisobw+Syw1GSF/sDyDJ
         GmYBoLBU4+DhoXmHTIhvmt76Dukt/442vJZRYC6WCPoVqiAMz7yxp2SMj3BwrUGhHovH
         Oafab+DlCMQLfAVQQ/u6dbPW1Lhawya+WPL9uYjsBtn85iuNd8u/vgLZ/keaNZJBe+xW
         +T/uy4OboRieetLtV8aXHPZrphz9LYnLZtsNHMVNXjmcH7pwsL9yKGXXBMDh4Y7CCkaT
         PVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667613; x=1762272413;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4gYW5qsNzJO72TIFndUfc9Pvhd9ri9qtMJw/7Ia0g8=;
        b=Pnb5d4HaRSQDu+++8dIGWTnw4hqPG1cxhoFGYba/MUVSJFQg3oewm0L7u/SkvI2J+6
         1rQmmZKHKndXFrNK9NwUxsWzFLKXFxDqrSutaQ9BgUclqK4aBwNoxDN8Z/SnSFhR5c0U
         EPZbxiwLmNIN2ymYnx7A0f/sXt4IS1j8a505VyWQWt04TUW2wKWrLYlafTe++TQNm466
         tkahKBgmcHbBrvP3dZ/6EN/V7BIDpFnVYBluwB0Dj0acanplW3UvTpCHdbC31ZHNn0G2
         BFe3HkN6Ij93r4Dy9VTFXeWpwmzzOFTcqkIPKt6DOL0X4iGj2dsIUbZv1WNwy8k80PWR
         qhSA==
X-Gm-Message-State: AOJu0YxQoLgJWyPdn8h6YmdaURGEV6Su1M2l8uV+pY8UyD29fl8Obn/9
	BACY66fn65bsIucII+sgSUpkGzUKrXc9jBXMbHF8GgSxIo8MTJKIaD7w8mdGwA==
X-Gm-Gg: ASbGncsztuh7T4Ee/a5YwlMk3p6uYDu6TFMmHMyoW7m6DCVYfujebB5i1BBnuGc3vtu
	rx4qDYBHXwQP7zAkA214EY5JitWl//Zxng39sqvPl4+DWpifBFG4q6NVZGGWo9DulAzrWXNvxjH
	WcD6NyrOetKqD1xXAPlAvakheT/EqEgQYSLMLDLhH74Y+iy8kHjfyFnjOFLcKby9aFgkhVmfRxV
	Kd8e91fznp9vsES7Wep7QBcUFfu/EiDnzwcvE4E0w59qRN3wmFOQh+YxEHw2Nt/AVLqJlt/e8Mj
	q9CXQwJTqo/U6BZOexWhO7BPpQF1gKlv8tDUR0ZQSfTSBialYroX3PmYBLtzuXkFjCDnbQuD9aL
	Eivro+/CR+Yo4e6dSRcNs+Ay61GrFVnd8/DoEjEUBFgj/HzoI2r1p2ZX3+zaVuobdY+7Y8aQT/J
	9LIDe1zLZsOc69qfFa
X-Google-Smtp-Source: AGHT+IF62QkZKlcrAyz1CJExsxM6sM2w6o0tsvCL0l/8X6YuFoqUBfNzDyY1uDk2wyOb1hJHHLnETw==
X-Received: by 2002:a05:6214:2245:b0:794:99d3:dd69 with SMTP id 6a1803df08f44-88008842422mr1906336d6.45.1761667612754;
        Tue, 28 Oct 2025 09:06:52 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49700afsm79769386d6.43.2025.10.28.09.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:06:52 -0700 (PDT)
Message-ID: <6900ea1c.0c0a0220.3cc601.f7cd@mx.google.com>
Date: Tue, 28 Oct 2025 09:06:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3065984874476385254=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v3] battery: improve the display of the charge level
In-Reply-To: <20251028144320.104871-1-r.smirnov@omp.ru>
References: <20251028144320.104871-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3065984874476385254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016771

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.97 seconds
BluezMake                     PASS      2726.05 seconds
MakeCheck                     PASS      20.53 seconds
MakeDistcheck                 PASS      191.62 seconds
CheckValgrind                 PASS      247.18 seconds
CheckSmatch                   PASS      318.21 seconds
bluezmakeextell               PASS      132.10 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      946.88 seconds

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


--===============3065984874476385254==--
