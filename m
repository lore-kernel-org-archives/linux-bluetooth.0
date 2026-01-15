Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640925228D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491498; cv=none; b=mdbG6j/+/2TCneNy6IG+Z9bgHdDLxRPymO/Fcdww/uilCCIpSfBejRBcYxAm6lQMAbUC29kvhnhHbS4OsLa6Vf8dErm79ImtE89YeahXMPnFbS6Oit0Oc5/iIoOj7R/bgtwH5+oUnCQ0RUnY5fflg1VyWeaP0/e+81rh4FHNaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491498; c=relaxed/simple;
	bh=N8VsxJR0asx/52MQLVZnkWOCrTqHgzqRvu6uupFdxfw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gWxSvlZXDzwA2x605RmD5EqdTqM/QR7ftPtKNIjYYVup1mvV5aazifzUOjRLwQu8eL/5CA+hIswahPE4sraCtLr9f8OpETDtN8gXLpSwJjUHSOh2CYx5karp8dh6TKWIE4BZotpA1skzMwA0nSfjJQJjYYmmGqwvBXfd/x17kxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD7TQz+a; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD7TQz+a"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c6a508a595so24469285a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768491496; x=1769096296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sY0an3EsA53699gNvCqWZ7ClQhlV49NAMpO10pOfBos=;
        b=OD7TQz+a1qf21j6yXOi37YBcV3wi/j5QWIycLZYVlNJhGY15NQkJA2OHp5GB6m2y/K
         uT/12DWTJilqmtDTJx0XMZUBrMcyv2Ve1wr+lJTJ5vC5qdjYgRf02nyLETPuLu2vjRx+
         XJ2auQ5z0qMpLY2T3HMUWMCpZndzo7tSd5jluKRitlybKWds7OxcFi7/0v59H84GQG9u
         5YJlZ6hHgUNxFsgGHGxMbO+/8fr3X1XX9Lm2qRq3BJpc6uhfAjGdPzOljTdLuWrUDsSY
         LjB3IRHk95AQpvVJIfWF7o8Z3bUK5MCC4DfYyRrptQib8oy3fcZt27cZnJYxNTsHD3pu
         NJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491496; x=1769096296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY0an3EsA53699gNvCqWZ7ClQhlV49NAMpO10pOfBos=;
        b=wf5mRslO75hYqLKCyCtbXwA0n/r+dwNhZl2TIRoH8FIy4Wtp+ECpJcDqrXRQr2bC7o
         sUgPI96rvxKWVrjE/IXzMgpKZbDsYGiEI6hcMDRndS6cqS/wNvY7HI8+KOiwu8IhbJ0X
         Gsn+xtK5DfhLOHztrkTlxOA9LNddAS7lupobdyamOcK2IAo0xEVXs1Df9esXp7VTOFAM
         1Iifjh6GNcEbtaumE5CgEAtVB5/QrXIqM9hVKovIX+dEE58UGGgTNmAIEfY8fHuVB0+a
         JIwbN6EdzGYnVdWlfmqng8eHIUxted0ayDjprnRYqRnyXs0zCRTTqw0Ftq8lOps68/A6
         x9XA==
X-Gm-Message-State: AOJu0YwyGy1ww5+8FLhitAEX6NhyA4DYjZgeXpDWwoYIbprcixijVlJS
	DIkXjEa9Gka3wj3KeSk8xubZMtGxSBIWwOOQHfDS05KvTH6PFeP7XJQM5QrRimCI
X-Gm-Gg: AY/fxX63a96SqNECm99Y1v/U4hCYyu51QBBwoh+bSfZYxTDmKxsjK3bQ79a4MJFCcnJ
	x5XE1dvaKV1JdgP82NJ8QlOyUMeRna4QilCYXDLj4AQkvSsTXUKoQUS+7mqCiNnrxoHmZnVzJxv
	e6vb9s8X1VGnV76ZsenqHRM6xUMJU2mfmljp1uWTMGC5FyRyQlzhz8gUZXJlKnQVQqSmW1SsGc2
	RGcHmgWqy6p3lFqWe1SYdBhhjTGgrIztgXKcLHlku7HZi1QPn9e51GdVqRuAGsNu32lLRo9k5hd
	OsCIQ+j5DFphPUdzB7pvsVa4wsKqjQV+cGPENB8yfCrZ5xRHjhegg5+E6m/5/fPHp6IsccqTx2f
	rTTQkfXTtNHhTQMmODli+ghvaTQckKumAs5+N9Y4SFaso6OsE7s05y5++fig2vVt06g6rVICbkC
	Ro9by7KxsW4mf8KskH
X-Received: by 2002:a05:620a:45a8:b0:89f:24b:36c7 with SMTP id af79cd13be357-8c52fb236d0mr815065585a.6.1768491495940;
        Thu, 15 Jan 2026 07:38:15 -0800 (PST)
Received: from [172.17.0.2] ([20.55.126.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530baaec0sm439060285a.39.2026.01.15.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:38:14 -0800 (PST)
Message-ID: <696909e6.050a0220.347046.7a21@mx.google.com>
Date: Thu, 15 Jan 2026 07:38:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8127736232713910568=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] tools/btpclient: Fix name advertising
In-Reply-To: <20260115144058.12960-1-frederic.danis@collabora.com>
References: <20260115144058.12960-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8127736232713910568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1042858

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      19.86 seconds
BluezMake                     PASS      644.82 seconds
MakeCheck                     PASS      18.14 seconds
MakeDistcheck                 PASS      240.59 seconds
CheckValgrind                 PASS      292.04 seconds
CheckSmatch                   PASS      346.93 seconds
bluezmakeextell               PASS      181.95 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      1012.70 seconds

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


--===============8127736232713910568==--
