Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F218A6D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516102; cv=none; b=iSKmaJaLDVv3RI2k7ubzgX4EgpXMobeZnHndxLjWWT9MwU5bSm+l50VPH6VFpnGmw7SzkHaPBl+W0zFeTvTkT02V8YckY3xqwMCZlTpU7o0NGXsGUx6yqCdTySa9DY2k/7/mSjGFgKAwSI0T5FWRHSDMtG22CyDIHM1MxaNKJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516102; c=relaxed/simple;
	bh=nXLIrM7Dk9Tm0ICVKKiBJP/5hWmb6+BuJ3iXtWIripE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHubtXs6ObEgpZWXzWkXHsCzmV9AU5jcUi7qbIqvmpwvQzySx48v/siSQiC0pwK5i9x+46uQ6pSk/074mvMxhyKxE44BU366GXWiRvIiGuQVfgccua9mvJNyJsOwsPqAfIkoRDzADMKnWZRhTgM9dEP5Dc1u/04M0yO1/WfbKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpqqFvbs; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpqqFvbs"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e549be93d5eso1930905276.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 22:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739516100; x=1740120900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nXLIrM7Dk9Tm0ICVKKiBJP/5hWmb6+BuJ3iXtWIripE=;
        b=lpqqFvbs+MeXGRj8QgZcuy6HsqGphemDepUM9S4bybGSxrQ8DGYOQ9Gu/IJAdue/7D
         u4gi6pJmZdZksIlpUvUmoJtv5EivUV12RASLNbjk4Jhl1HRUbjd9zT6ppqTMHABpbe2R
         vG6PHBc0kZlJL75nBjtlDnu1UhGxSSH36t0Q5Zp3bmGe5uINxk7d2dSmvmufksAQb6kj
         K9Qznty6ts4i4Lie1A2k4vizFy15yVpHM9Gq/EV9WwiczsWfqXui5Zn6aWd5WEvEs6QQ
         lv6MNDxenJQXPQMQ0Ci9fSHl4M8xSgzx5xc0CQeOZbUhGS5g1IdG5EA2rq4gZywhG3qZ
         rKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739516100; x=1740120900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXLIrM7Dk9Tm0ICVKKiBJP/5hWmb6+BuJ3iXtWIripE=;
        b=uRaWDo4Rj1eiXsdshmGbKwAB9p6ECEnFTNXovHYQkbQGKT9kJbWwbD+qcofkPG+WNP
         EDbrJJZVonDKUgO5nW37IIUn2YN1Nor/K3n/BI2F+Htuqwdof+d+bnA216kZQakoMsI1
         IUEiYIvSmHsoYJ8hs016tPnGS+iaLyzEXOZEZH+NKWqtbdT0MxLnfwl90nxfGrYAPsLN
         wIWp7rRHFnojKcz9Tk+tG1nY7Mht4E86cDAyZuJQGSMdySytHwhu3fy94Z0138K1/qgh
         3qKM14awp/hQRtPfzlaFm0JZFpH4y6/Ocw8HoDSbFSxuBaZWKmWzGww0QObWbBoQBMUV
         xI4A==
X-Gm-Message-State: AOJu0Yx/EU1KP1ySdXtaCpaqMKIKlkfZu3AGoh8EccdcfZZoE4tm4VBY
	gUJXF+p6Eho60nZF+6FAx66WpKfo6VWfjIECebf4ZdUyIOhadlcp5Qf6+n/R2Q4KM/bM9uLJlyW
	KPlV8ZAUFp36OSwuAWbS48ODG8Rw=
X-Gm-Gg: ASbGncsH0pGx3xDpKwSrTy9rVL3q5hCxvU+ay7QdmWT9z3DACM1hsJRxH9Xnczk/tnp
	NXlxXKQsq1ojG9feZytAU7X18vskIVhwcLWF979hdTZ+GVX0WVwPyyDEGhLEdvRr9GMC97X1jLQ
	==
X-Google-Smtp-Source: AGHT+IFM0f330U43ortWPUKF0iJ56Mj9E5WoCWA/XhfTTh/fArr2w0KrCgkPwY9Mc5jlHQd8ylLPs19oiYZgjhtVUmA=
X-Received: by 2002:a05:6902:1442:b0:e4a:c0bb:7b25 with SMTP id
 3f1490d57ef6-e5da820c6b3mr5854381276.41.1739516100054; Thu, 13 Feb 2025
 22:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123134908.805346-1-arnd@kernel.org> <67ae71e1.170a0220.69f3b.9ade@mx.google.com>
 <CABBYNZJz0yFAyphL-wRPWJHhqUBX_s5r1U91bZo+U7V46c7yMw@mail.gmail.com>
 <CAGFh0267CagMx0UFg9YQputn2EK=OHVgx+n_OTbZ7tZYMYU76Q@mail.gmail.com> <CAGFh026t7RQJos=uCnUb4kg4Oc0U_GbwsNdGLzP2BaPofwu7tg@mail.gmail.com>
In-Reply-To: <CAGFh026t7RQJos=uCnUb4kg4Oc0U_GbwsNdGLzP2BaPofwu7tg@mail.gmail.com>
From: "arkadiusz.bokowy" <arkadiusz.bokowy@gmail.com>
Date: Fri, 14 Feb 2025 07:54:50 +0100
X-Gm-Features: AWEUYZleTiGNI8DB_nnvYPTSo_Yhdw-h7bp0xxILsthzgiBegSL6T6ugdtQUlxw
Message-ID: <CAGFh025imky9XB87USUem5FBpExMUc8hMsDXE_vDAqwsa-2MwQ@mail.gmail.com>
Subject: Re: hid: intel-thc: fix CONFIG_HID dependency
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Content-Type: text/plain; charset="UTF-8"

I've just submitted a "test-runner: Allow to use host CPU on demand"
patch which should fix that. Unfortunately, I'm not able to test it
right now, but I think that it will work.

I've tested it like that (on my RPi) and it seems to be OK:

$ tools/test-runner -k bzImage -H -q /usr/bin/echo -a
Using QEMU binary /usr/bin/echo
Using kernel image bzImage
-nodefaults -no-user-config -monitor none -display none -machine
type=q35,accel=kvm:tcg -m 256M -net none -no-reboot -fsdev
local,id=fsdev-root,path=/,readonly=on,security_model=none,multidevs=remap
-device virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root -chardev
stdio,id=con,mux=on -serial chardev:con -cpu host -kernel bzImage
-append console=ttyS0,115200n8 earlyprintk=serial no_hash_pointers=1
rootfstype=9p rootflags=trans=virtio,version=9p2000.u acpi=off
pci=noacpi noapic quiet ro
init=/home/pi/bluez/build/./tools/test-runner
TESTHOME=/home/pi/bluez/build TESTDBUS=0 TESTDAEMON=0
TESTDBUSSESSION=0 XDG_RUNTIME_DIR=/run/user/0 TESTMONITOR=0
TESTEMULATOR=0 TESTDEVS=0 TESTAUTO=1 TESTAUDIO='' TESTARGS='(null)'

I've just noticed a "TESTARGS='(null)'"... However, maybe that's
intended. Anyway passing NULL to snprintf is a risky business.

Regards,
Arek
