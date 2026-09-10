Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9A65192
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080482; cv=none; b=FBQeRHyyVVwK7KCE/9Mmd0oSdkOxQsbiV1oA0ztLzXg767l1+s2WwKl2dh8s7wfu2pp8ouOwnVnhWCJxvRj9xkgJ9GWWBrD2J7GjRZxl1P9OnVzOsKREizElPRLMSwdFouC/1oO/ArZUGo2jtl+9cTCFUc0iSfv6wiexjmKMec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080482; c=relaxed/simple;
	bh=XEvPTIdodaD5FMUS0B/Z0PUNrQV5gZ6pt3mU4b48ho0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gi8S7c7nzIVKxJE4Mhnla4m8ZoNE91HA94/+HzMl0LhQPyk1LGdzx/47y6oMzsrFhS8WeMfXc6WpDSdugMQrzEwbhgVlcpiFZnW7f88Jw4b2PwORQB7+xT+ghwO7RRyWa6wQOKLcZw+oun9NFYgZ/MD1HywBuBM+Zva2Bt9yqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsGaVqIP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsGaVqIP"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4c1210748so295283a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 15:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789080481; x=1789685281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XEvPTIdodaD5FMUS0B/Z0PUNrQV5gZ6pt3mU4b48ho0=;
        b=BsGaVqIPkrY0z3n1xXlTbMSHTubEs+oj7vjakOQYbvraREcOrs9aOyF/T5cUhn1Ogr
         wirDHTPf01/Koy/xeqdjB7O+ILSkufZ8CpS9relhgCQ1/UrJOccsYzKaos+M2W2PsLIo
         1Sj59EFR5IBUHaJs2CF1SLN+pkNTKQL9cNQmA/el3sElqZAv25hPh459RHpq/nYE/MsT
         qdLDVEI8KJD+lU7SAkcIPrg0kBtW0XDlWuwEm2vwP+h3CPC8fluQkV+NQKQB7nxfwY5K
         t5RGTLDRpY/FIsPOUkcu+NahRi2J6nhKwCutURYlAQF2jDGpfaNPsSniZ9Sd/wN/Mqin
         Uqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789080481; x=1789685281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XEvPTIdodaD5FMUS0B/Z0PUNrQV5gZ6pt3mU4b48ho0=;
        b=XZWyZiYmRrobJ3rT88yxCAtVesU7GuMmy7Qgn30v/WyZW9HCUhMoJJ5ptm5zhqnnJR
         YHY/nbIR33uYDAWT5jkLg0Ah03WmDWX4Sqs0xnHqHQI0lV6mEfZJkCS2A6aBylEyoWfr
         rSMG1E2N8lY4qW0rWrifxzCpDM+6gyIDc+6j4RZXqoEPIiHRUux1oOwn9f+9dgTZkhJo
         ibCJi3c0zDYd7b1kRLjrB8t4w8go8kM+z13BksEXhe+l4Thk7cLwm74dQ9NHkh5L2rVv
         /ZDuVkGh4eP2txNuzbiXw4jJwHjk/kJxRMgmM3kZefskQ0A+KC/6s7bd195GL2dmdkn/
         s+6Q==
X-Gm-Message-State: AFuF++lxuVvtfCl8rNM0j4djaBUIkgp+Zv5fOdg02FksiFAXIXD0AzRe
	lYwdBtTSTdNmnA8MBeZofU4pP0xY/y7zOygwH9moJhv2Wallxd9UdxeaNNpVIA==
X-Gm-Gg: AYBFou1OCPx/mcI6IJ0+rv6MBfMpMW/lX3t8jZP3sGxviGRGnCZX8EDx5B0qcSiCi9f
	tU2LA/CLygKZIF35G2+T2V3xocTo/SU8EVaO0TMz0SW2MwEYrQNBPn3Zp8u8rBgh/kfmKrnmWAH
	ELaf1y8msADqvHOIJP7+YXPFWiqtD7p8jbhN688vaQgz1nF09/UKRvC9Zy2qX9QLQQuslX92RgN
	ryR5sqkN6KZ4VGGpDs2Er0aRocB3Ig8krjIpuuSJwRAib9pwJTgACZsYNmxaboMY6OiMH1rz6he
	whX1qgUwmxiTWnkl7ju+lrm/E6FIlVjxdRALmx3Vi8bMukBCFgURyJ5sYmWRVHBJPVge0o0drD6
	dEowItZ3QopJuD3OENtZO1ku76Vg6oSYkCuHe4SAFPml7o9VROiACSZi65TFiuFDXKnV8KGIipC
	aEPAVTVmJeKTeffYBiY6fLundQL2q1aYjYjuV/0xGAzZbbkeJ/K2YP/l9k35iGkTrRXiaW2BsUt
	aWe+g==
X-Received: by 2002:a05:6a20:7d86:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3daecffe187mr2139406637.3.1789080480911;
        Thu, 10 Sep 2026 15:48:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.236.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fb3ddasm996808eec.30.2026.09.10.15.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:48:00 -0700 (PDT)
Message-ID: <6aa333a0.fb0efb2a.1b8054.f77a@mx.google.com>
Date: Thu, 10 Sep 2026 15:48:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0961579472353444922=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, farhad.alemi@berkeley.edu
Subject: RE: 6lowpan: do not compress headers that are not fully present
In-Reply-To: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
References: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0961579472353444922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 4
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0961579472353444922==--
