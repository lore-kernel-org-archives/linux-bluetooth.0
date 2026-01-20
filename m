Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC7436348
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934063; cv=none; b=ZqJp/u8g6c4MsMMSvnfEX0ySiLvaQsdJN4cJdAhFmz+/wsWUI+mLpjaffYSXzYMdM/kMO0TbGLHv64Ss4Xt2nqL5aX0Ad4fEwEwJLCCxcaixsVCEfVxqyQE2BQKsLev5FCv8G5Lm5uwCYf9avjFCQgwawjZ5E4K4U4iwsQDGojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934063; c=relaxed/simple;
	bh=3Km+HS6GAaxg69BCcDrnoMjICWnIa7PM/x7vihh5U84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=poITeDPH5Uj6gJGD9PNUdXYYQLMKJG+iYLFacWroh8V3YvFKRkCYw3xWhn0lbFvkZCqifz/1B+eMgy6wbuPPi/WHgmaQ1QnisFagWsOSR7lf9qEALtmFovIVDM0VISHoFx1UWH1xTv09g79iRjHRiMLKBnaNe8yO6S/4+NPSVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyt7XX1V; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyt7XX1V"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-45c86087949so2061890b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 10:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768934061; x=1769538861; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VelmPc1D5IawALA4wSWoz0oJBCVSaiOVsXYLrCZ47uQ=;
        b=Wyt7XX1VYsxDRZQ8uyvkTQJt9DOcMkQzL1tdkQn49EnyRMFOpyfluJ3l/mdiQWI7sz
         juiOgqmPPIFOJci2Nq3ScY/UF1CygBRsFN/Y6G/z4OZlPE1cZATtd79bFmnTn2J4t40Y
         jvi0kJIYqQvwAe8Z0UQ0rGxtCz9Vpkjxi44guQZiuNXIwgNIn7r+kAjtHRcSp5THzWa2
         kFgnvW0R3AJIUs9KIU/X2XU3W60mmMWD1ihplT+f/1+DIo6BAd7Jr4tHcxUBICh0jRmh
         qXks4rcqv8XeHQ+6+ywYz9JAYAhP/LJ4OpyfgFCiIACz2SzPBsxWVmb4CUafJ9BZCq5Z
         7/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934061; x=1769538861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VelmPc1D5IawALA4wSWoz0oJBCVSaiOVsXYLrCZ47uQ=;
        b=mvKCtQ1cogolAyQFrRQhU/4Tntbl+tffAAMLgbPAIqgFmVWitPuowrmfM3h9UZKtkW
         PHNKxrlEhm6hzipdFLp6A/XJ4jrjT2QJlvYqRw5ko3CloIVWxV/XJzP95RYkFdEU4r8J
         9vJjcW9Ot0Mt/967F4e4/6dmu7q8tzSV1o2lnUNCHXcEL4XGiuwCOPGfgALgAaQhtoTu
         W6YQlTR2CqkKx+8+T3wlhLNPbsprIz/JvZOZhmC64xN6eRc12DQ5qniJU8h+hpEMD3Tq
         ImeM9Jp2EYiF53mTAkVrnuV2W8kzQmZJvXeUrpzAKH7Ror7JWyxWskCfus0lzGhY2mfD
         tbTQ==
X-Gm-Message-State: AOJu0YwM9rrX2Wj+vCxR5hxdf8PUKMxMY9Y0KAvPEmhjCExEl4asgUEk
	PTwSbqCKlMGLc2un/LEKxKFmMrOefeTJgBTkbN4aSqZ+kiVrSkUCmE/+xl9W3Mzd
X-Gm-Gg: AY/fxX6CCqP06B87BJTOr1dS8H2pJshdW3fvOn8EW5y5JOBtROgs9QEEeDX4XVHomvM
	LZ8Rz45D3vYvsuTXm1q5O053xhwQSSpxquKNu9DhOgIcV3DIKYJ9fKbnJkcTEzdYU3NcIg+BzH4
	dgTUZBjOf2BqA8xXsA7QTpr+Z/jKSxXGQX4cG8JF+vy6kfNhKl/oqVjJAQZfZMU7ZTuRCqOTUl6
	2R+9yd4HH/yA/2+ZJDAESUTxpBx0it5Gbe+lPMQpQGtFAC3grOfV2L0efeghK+WBrZbaSddy6WM
	4IJgtttZS32Io8IchrkAPJyGDC7DKgo5fCwVHSCNUoEYIHfgzWxRM5WC96G8oIvqbaFNYlKmsEY
	Cncy2/efzWyTHj7mrfZu4WrwVIJCCXzLfzOjGorR/C0Ymk3YUzPhc+eS6F+n2QIGvzYFVISf/cG
	dPpDxtBXGRVCEbCZ0j
X-Received: by 2002:a05:6820:2d05:b0:65f:19:9621 with SMTP id 006d021491bc7-661188f9750mr6370333eaf.25.1768934060713;
        Tue, 20 Jan 2026 10:34:20 -0800 (PST)
Received: from [172.17.0.2] ([52.173.181.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-661186ca7aasm6646094eaf.2.2026.01.20.10.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:34:20 -0800 (PST)
Message-ID: <696fcaac.050a0220.15968a.9e72@mx.google.com>
Date: Tue, 20 Jan 2026 10:34:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1189124242711235009=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Port text docs to RST
In-Reply-To: <20260120172034.3463151-2-hadess@hadess.net>
References: <20260120172034.3463151-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1189124242711235009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044790

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      19.81 seconds
BluezMake                     PASS      624.90 seconds
MakeCheck                     PASS      18.15 seconds
MakeDistcheck                 PASS      240.52 seconds
CheckValgrind                 PASS      291.00 seconds
CheckSmatch                   PASS      348.67 seconds
bluezmakeextell               PASS      180.97 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1009.27 seconds

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


--===============1189124242711235009==--
