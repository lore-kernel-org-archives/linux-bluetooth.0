Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8128852E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696669; cv=none; b=Re+tAch/y0gofbR/NM3v+YbZK/P9S6V5FbuQ4qMYEhlfyLrjwnHAoZLiaQ5tJixw1mcioy3kh4Bjd22voKzcojogb7+6nYfE7YuHwld8EhphyvK/DkgV+hEo5Pe9nWnya73CIw/ikBagG8CazY7Q1cvuYX1x8QCI7A7cz/vFdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696669; c=relaxed/simple;
	bh=9Q/0Q6Z5Rn8ssngovr++Gk5+WJy7gM9v582k0EZa2KQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JWPOfaZphApSsEvvOMSIfQFIzj72m43AJgWLuW6GA05P/5ukD5bDV8V7IW4yUyXGryJGt/7SjLW7DoauwVwGyFF7ydj4K9CMeCs15zwqewGR5iM++I2D9OpZfK7nKhDCs+3uOUzda8Q3p1MbDJRbP7LcDSW5Ib3MrV/koSdwets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD2dS0bZ; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD2dS0bZ"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5029901389dso7697461cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769696667; x=1770301467; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ASSpQFfWsSXa2LpRK3EIAEZ7EYcfVl7YaGEOJbtE4gk=;
        b=YD2dS0bZyHrC42Pt6jPx6J1r6CjHxhA/XZGLYy2nU2szcxd8xjMvHJZmL1gGlwqFvH
         tIZ95j/WqztT4PXwJkzYqWyV8vwSa20GMVShJ+SIvUsJrlZ11WKwgDhC+jZehjFGqWnN
         Ob1KzZEkT+lWCnIyeYHhmRRU771zjAH8LrMaCdQaLb0GT3FRorqVtl13HmHn/mmtIlzC
         qlYvlosC8vpdDLl+Tah9cBE0BQBLp19ZQQiFFdLG4vfXlYUICYhwwdrhk2BF3i+HVrea
         uIuD839vh15AajE9on2Ywzu6pNcwnaVRMem7RFz+9Zfsw8dyNb/KZ4TdiecF1GJbJM8e
         I1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769696667; x=1770301467;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASSpQFfWsSXa2LpRK3EIAEZ7EYcfVl7YaGEOJbtE4gk=;
        b=QhEA8x57dMq5qfW41DsPG8nFgfCSFNPFBAAyGVoPbYt0VUvbD1XCV7FazAwqvJQNKL
         b3uml4IVTthhSs37JQHBpQCLFEEZfTYmO3r77A+DtiaTjKJT38zFzg1p2g9DRIF1HdWy
         EEqgeRmgd2tRZZm/0tjYAVlOJWpiZeRX664783OnDvpUAjanJcaZyTOpYA1+2M1cRijg
         NexLRBqQf2m61OsJuuXqEkRNwgPno52WySlLMkpXzTY8HohEWYWdTbnRuxPwwwSxF6N0
         mYwmQ7nLyWssfujW5rvhGBljrcwTNJ3F3DnLbrafnwsWJfbY+OLJGUE6+viHCTxhWxyH
         9NqA==
X-Gm-Message-State: AOJu0Yzd9e21xipDiR5TA5+vMJ2WntdhHt6yRGWHGnIYC8UHE5su6Cy0
	3GYkYIvynGASA+1qFXm/h///HYNcQ5IOyyDFzpbb//14GTNk/y7q0L7rbSgLNilH
X-Gm-Gg: AZuq6aKLj3VkvalSo7cPtKzXxa4RDJDexgaMUL+mj2//A8JgNvPL959xskuZszBPe3m
	vAwsmlMnY7noirsO6rsBqBJwb2q/7wd2PmkPeoSYWsTjtJF2aGjFGADgrj+7fCWEj6xaQQfw9R8
	eETYyIu+zx006yuszc4Bf/lrhVZExDgtN9FnMk/abBLXt93DXzc6HnmzK2mTC3R8KFeYxgp2BsJ
	KQO8kcM+OAjefcDTp9DI8FVu6tSMnDPKLaRSu4bM1lMQSCcYremBfdbUrhZAKRECm1qaYaSE+7X
	xVueCA/gGWBl9cgKj4vkO2IG6yNoFWytMIzZf95eBIy2XbsX0e92EpVOs+NW+RjUrDsJLetWGkO
	1PtXZuyd6d44tllwlIM9RivEuKMhQV9BW0voW6JUs5Ch62bK8+uYaLQIqskKDnzy+YUY5mI1nMz
	5L0iCtTWmZGDJhyy3MTQ==
X-Received: by 2002:ac8:570d:0:b0:4ed:de14:b374 with SMTP id d75a77b69052e-5032fc13f36mr113410561cf.64.1769696665312;
        Thu, 29 Jan 2026 06:24:25 -0800 (PST)
Received: from [172.17.0.2] ([64.236.141.218])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bb9d21sm34716991cf.26.2026.01.29.06.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 06:24:24 -0800 (PST)
Message-ID: <697b6d98.050a0220.11aa80.fb42@mx.google.com>
Date: Thu, 29 Jan 2026 06:24:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5581184883760278402=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: build: Don't install btmgmt man page as tool isn't
In-Reply-To: <20260129125948.2724071-2-hadess@hadess.net>
References: <20260129125948.2724071-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5581184883760278402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1048529

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.54 seconds
BluezMake                     PASS      657.46 seconds
MakeCheck                     PASS      18.49 seconds
MakeDistcheck                 PASS      247.04 seconds
CheckValgrind                 PASS      300.76 seconds
CheckSmatch                   PASS      360.98 seconds
bluezmakeextell               PASS      189.95 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1089.17 seconds

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


--===============5581184883760278402==--
