Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FF381E98
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672315; cv=none; b=goxVJhRIEtj2RN4lRQeRRmVdkNe1FSMr36LbEZPmzv5kevYQx0yd6r3IsqKKoCOuv8SjGydhUCQQxidwYNioKhTvkbTIWG9rbXRULG/9/rpqLxPOnxfuPfaVmog7RjTfcPOQEIzJgaDDco/r2yZw/JtyDOlcDNWKvHCioQCYTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672315; c=relaxed/simple;
	bh=tLB25FAVu2yQ+p0PMW5BkH8P4RSq7Ig31IvbSqa9N+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CwxEBdrkbL3fT9Ahki7+CRwvlIvoQAG/D7y7ozofUk4lZuohWZJ/zGbzzKg70fqVf3TMC6+QHWYu+8FNnvVfFh/GRM4VZLfMl/60po0v6TtYiHola+yCf5VL2N4VvgeW2rPNNkzoViLNH6JNL6knELZvMUK1uTc27eCxb+MQ/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odAxPZFQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odAxPZFQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e4c00d71aso63959085a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791672313; x=1792277113; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dl+1vBhpXEJucSU2GzSzNwg0ioVMlFLkLzUmpLJdNIE=;
        b=odAxPZFQjQDSASEIcVaj4/77od55oPtZO6FJhmO1aJGHbWFxM4Ua+b0E/78RrMOVtQ
         xfUQgrF343h3q4UcjNeRJ7sy3SrQfq+n4C1kD7pOlAq5dBvSe8Jz8ZJyiLBlOi7lOnVF
         Nrui4C6VS3VkfZuXAZAELmpCHumO3VK2+b9XirRMgJDbDQWLoaZOX852M7XA/85hGWHp
         pp0vEo78SdqHvQ0gquOK3pcaf2Zh6nfWARRs0E972G8i2QqHuNV7PgQi9RByvWY0yYzG
         ogdP42daw/tpOoGWjl585F41Y9TTaf8g6zjFBUgkSX0FoYW61YUN5OI6PgBnCQe5lExj
         3YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791672313; x=1792277113;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dl+1vBhpXEJucSU2GzSzNwg0ioVMlFLkLzUmpLJdNIE=;
        b=GhZ7jIq2iouQjpPIR9zoaM9EDUfM13SJZvbuJS5UgFTVgskfCvqVOHlU2nmOtHhtex
         zSXD1ZB23NKFHQxOF4RB5Jd42Wc6YA/Lqx550dgH54NKuAM/Z2qD3d21OQpY2wGC19cG
         UagRvCW4EW69pw51DRHDiMxGfS2+QhS9VjxN1j72FuEkxM5DxM+1hpmcg97sqqGoxN6T
         3j7y2XjbzH029QDMpoPZieaK9XKeaZI+s8PgWkt83tghIxHA7ljaE3CsREhS4c2EFbUI
         Gl8A4R1ZdBHYtfSzGe7WdMZLfIXA2158z2qZgiYjSnC+bfD+k1M/TYk/wEeiPYkm805v
         gs2Q==
X-Gm-Message-State: AFq9FYI87J9nbxdzjvbBlirDHAVXMbI6y9Pg3d5PwBISOKPSDEiwoON3
	pLJCK80yJ4d9/AySeMaNlgDLQrQmtSHjpfQILYdiex7iGHkmE0yOl+VxfmXplA==
X-Gm-Gg: AYBFou1CHq1c6GPQe1lTwr1LgH2irHFq/NzTEkPVoNOrXfa5pKem3PinMch/64e7/Sf
	6n5cwDOB8pICBYdL1x6Y8NAeTmhIuT5kHhb9NQ4iF7NS7t5OZP80th81blomzKjHWG/JIV3PsW9
	sgfOqjmsM0AYImS3vUY7v2xPUNHaVjOR8a9sjWdo51xZBMiYd0TpgC21sMBg9640gta1Ci5dBkC
	qevLNwOwF4Ii3ccL9EWv8X7thrBRC0wyZ83mcS4Ys7mHHXOBkOo20tCH8iq1Lh/TlPgiWc7ropD
	grWrTXIPb3TA8cIfdctuoV23WAi96yHrWo1Y57j7zSMFE55CACbliEOh6x7O4dxtPwY90R88tZL
	GcHuAkj7GyvIgfsDBIwP4Gb3140mOqHBLQ1IDfvP+5Y/fS2LzHxM0sCUszc2BNiHKd3cniF49ts
	3QhahpqsBCDAZjnihOc5b0ghDNlXhxO3J8iPV8jE/V+PBvtBzQrabvDfg0GZsArSIIhD+zroE7d
	V2puFY=
X-Received: by 2002:a05:620a:4404:b0:939:5cd5:e243 with SMTP id af79cd13be357-93ebd0c016amr954693285a.6.1791672312515;
        Sat, 10 Oct 2026 15:45:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c47dsm518399985a.17.2026.10.10.15.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:45:11 -0700 (PDT)
Message-ID: <6acabff7.f779b19c.c3e46.76fc@mx.google.com>
Date: Sat, 10 Oct 2026 15:45:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1909561065092195595=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, natemendes13@gmail.com
Subject: RE: [BlueZ] dbus-common: Use audio-speakers icon for speakers
In-Reply-To: <20260925213032.4011392-1-natemendes13@gmail.com>
References: <20260925213032.4011392-1-natemendes13@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1909561065092195595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] dbus-common: Use audio-speakers icon for speakers
   Pull Request: https://github.com/bluez/bluez/pull/2591
   Created:      2026-09-25 22:08:40+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1909561065092195595==--
