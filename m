Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF5325726
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537947; cv=none; b=VrySP0WuXBh632XuOR+1ZItHw4IhcZh+IZI7UVwThqG6Z6/le8trqPHARJY0G/4+aom5E1i8r+pP/Pl4zYpW2xstrtG4+BHjdjyKq91o48HgbqqceG4oBHRjppqGQOnSWwgX5MI7T/DdFnjtGMaKkMPCV/XbgjgbAfhOBYolQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537947; c=relaxed/simple;
	bh=C2xYCqmdZv2IaVqtGBKeoHl2aeRKb+ak+2Xr7x2S9DU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fiLQdQijFWmRrz2FcaRmTvM5GuFgvtF0s+mqz56w7wRTshh83jA6tIk4kHQQtx3qe/xFWeTzRnUc4UC2vRIRwWgmUKecxpL8/2sM2XET9+xwQ6WLleKJLLOKRw31hbu1Q9M4p/Igj9XU051i4wUVXhM5hGfjjQAkcrSHMHKf+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibV6pqBH; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibV6pqBH"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-662efd1bdd4so57316eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537945; x=1770142745; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FopZTneBTHGMj5ZJiSlpUC+/or8AMP7Z4cx4RlXFOLU=;
        b=ibV6pqBHpbqmkfO1lYFXIMGmzkFNuXgkufxy/gm6KmpDGt8B1iezhzsLrBlaRddJWB
         izVuvfP880Afa+yowTN5CEeqrgG4+iSM1PtEFyBe0MHxPve5fjEkZ/ZQdbxLjkOHB6M7
         R5R0ZAhU7FpeoLLMUa4/q6EmhVzDRiNbZWxAN7VvLMvDYu6Nxep/8bWlowhDwUKHOdjR
         5kandbDKH5FMoxgxFvo/h223ldtSej33tVbjf7vDfY3QlOX1ix2IEP711Qqpgr4axGAE
         MQpTuRPTI0hxwHF9FVbdgkwK5KepDTJ9fUboZtLgXRFoxy54xbYbh33xR85vq7XzI/ZD
         PRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537945; x=1770142745;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FopZTneBTHGMj5ZJiSlpUC+/or8AMP7Z4cx4RlXFOLU=;
        b=v4JzYuBBXy3pNToDeAJhhndxycUgg7EGIUh5oi+Xfz7KjdzIK7L5FKoQpO43vQiUld
         bj6oEeeRqejYuimqSDgicIEdi2bXbbs+WXddP5Uhb1vOXXKc3APnBal/lheFVu4jP2OY
         ApSPUI027Y6N34H3A+yXhJo2B0odfGdgIRhxcBnFhU5DI9DNFEq8iiXn+71ooSWbk8Du
         XHXmTqmCThYg43VUSg0Mw7CEbNctrTY9H618E/AgHUWByHmE7DhQ1z5ejejzYdP5W0Cv
         a68cG8IivJVCTvoTSf2c6Jpzjj59xrGaVNYUOZEOgE8IeSohrcK8MyweQUrR3p55Nan1
         nVfg==
X-Gm-Message-State: AOJu0Yztg6424y7EzhvYB/I6LVQVOdL8lMq6yakf+ZsytEUZWbATU9ml
	ELUaUNHI9IfXraySdcKLxjTK0WYzKxsktkf4KMXPsFlKglPdF8EVDk6fJPdB1Bu0
X-Gm-Gg: AZuq6aK8fviPUHYrFvv4fJBNiAfWv831qQO6L531FDlAPMz44G5+BWCnkvIU5FQlGDN
	AqCZJOugDglxs4UcaoxeLxc1uABGA7Ye+CiJgcy5XrjMrk94cziCUfId5UA9BmsuBU7bY8ImrXa
	Z0eCu/5kRJSMVZ0rlPPkphLmJE/QS0IjVHj7QaCnVoN8Rz9GGI6unQpQqI2/LQ6ijRaSHTA9WY8
	sn8EmAQAT9o0YIBwJ2OAVUv5ObnwwabrtfcmcaavhzUCvN8pS44H3mZ13tHum5GPM/EHOc8osEm
	LCdNpvFTZDx8wszY5SGFnFxkjilSWHNwnqypl+n9+zSBH5l1O5ZWL1LwSNh1LXiscEUdOnIiCbe
	8SLg/v82rxBEW4odxLNjeeWFFfNHmpYysYRASiS3Db4KSKCv1H4iASYpeYQmdx5+Y8DM6Lm3Ii6
	2wC8bKWlVe1PgLawU1Fw==
X-Received: by 2002:a05:6820:2082:b0:662:ee28:1133 with SMTP id 006d021491bc7-662f1f6b430mr1271136eaf.0.1769537944731;
        Tue, 27 Jan 2026 10:19:04 -0800 (PST)
Received: from [172.17.0.2] ([52.165.250.244])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a4e491sm117172eaf.16.2026.01.27.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:19:04 -0800 (PST)
Message-ID: <69790198.4a0a0220.257145.a622@mx.google.com>
Date: Tue, 27 Jan 2026 10:19:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3034509322122649337=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the AVRCP qualification
In-Reply-To: <20260127171054.151065-1-frederic.danis@collabora.com>
References: <20260127171054.151065-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3034509322122649337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047693

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      661.74 seconds
MakeCheck                     PASS      18.05 seconds
MakeDistcheck                 PASS      242.88 seconds
CheckValgrind                 PASS      293.97 seconds
CheckSmatch                   PASS      349.68 seconds
bluezmakeextell               PASS      182.71 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      1024.06 seconds

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


--===============3034509322122649337==--
