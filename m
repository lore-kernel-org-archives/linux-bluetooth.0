Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363BD18B498
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105330; cv=none; b=CBF/JxtA55g/Cy/8AT9o8nWNeP01yBekxdTPgguTOMWKL2p8NNrbp5ytYafXSAMRviOWU5im0oL+YuTNWrJbvkoZ/PVpXURUKmJLYAQHwlgws+MuU5yuGZ7U4xpUs6WwqDPAcglKc90svQLTqhCoTfSI0Wv6/JNUNhhOFYg9J7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105330; c=relaxed/simple;
	bh=ocey4K10QxnxQ53s+8XNiYej8Fx0C4FfuN7n6zKJQWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVN2cFDEPgIBS0XavBSclRGFAFou3TweUrQNkr2wrCWBO/1yKtCouhLmCqh48EtNpTWiU84QINbyRJR4roG86b0hcUqj6gJCBqO8YJw7BzOes9wO+utVZNYfFD88GQCAhg9hZe0a4YLVfHhcCUroyM3h3+w9GcVMbfWraNUrgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNmHa0ss; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNmHa0ss"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so2303611fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729105326; x=1729710126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocey4K10QxnxQ53s+8XNiYej8Fx0C4FfuN7n6zKJQWU=;
        b=UNmHa0sscLGHN9qd7skHOueFbSmm/s8J81NT8pShFL8+09mvzYyGxIiw8fTkrd8ISH
         +K1ExnfcsR+vK8p2x1l6EuHQT5w8cVCqi80qgqwTythRi3URaX81UO1l8OfAidU1NO9R
         m9OW80OUtC05pudB1vC1rOBXhGj7DlILCFyxf3/3HdzJLC5vvHTXod/sGVesXHBhKsqY
         9lvNCbXNhwNryZjQE2IwxPhDwBtNFkThMQMDvPQ+MgsUTlGfQzX7xXWYK9SXtHduzhyl
         2tS4viKmyhr366oIX4QE9ghnIbxUQ49tvcFHWUJ0gHMotOWU05/980971V6fraSg5GMQ
         H83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105326; x=1729710126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocey4K10QxnxQ53s+8XNiYej8Fx0C4FfuN7n6zKJQWU=;
        b=eBqGRhacJzS7eRClxPl/UGPhOQAHZx/rh2RGg0fw1uRhxjCMFpkwNT7Y2xlLoxQGiT
         pixREAPRqAY5dpUzYbP03Mj8Y8OJ0sb9lXnwzl5Y2ZwLtZGN8fMJ7hVXsYojVC5kVsxD
         6XJfSZKSWf7MxNWRc6Y/Q2ShHvs9CeoxkQEVi8GJdX+/rlhHeUYZJeGuXZyaLAFNRi5w
         gSW9kOTFyoHSkRkkIUmnGIcNOj0jm3FI7y0qUXSSvJzV3JNhAlKPGqCSjsPNbhvvYrEv
         AjB3g020spa/p6zxvgLBxobPxX60hrhXwB/CaeuhkSI836VBh8V+Mhz55Nz5BCmLfvtq
         92pA==
X-Gm-Message-State: AOJu0YyDM6+cKR7ZsxECp3iX6VmIaR4L2UFiUkGxpLZk410Laj/cC5x7
	RSzbq+x9smcSmgjhecwJ0CI++GVfwwSMYENPJG9sl1HCqZjwa0vq+ZDaXCGon5K0NmWJWRAiKHz
	/Xwu/XWjLUgNkIoS+CaRVOcoZMuA=
X-Google-Smtp-Source: AGHT+IHKZOCnrhcwcPnrhU/0eWSFyveYDFtp6T9Yg7pRoqLmla1bEz8vRQ/58kt6LyD3qYOp8kjIypPJFezmrZgb/ss=
X-Received: by 2002:a2e:be1f:0:b0:2fb:30d5:669f with SMTP id
 38308e7fff4ca-2fb61b3e651mr33720571fa.7.1729105324549; Wed, 16 Oct 2024
 12:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014202326.381559-1-luiz.dentz@gmail.com> <36e9550a-3b45-4489-8370-afdc4f2fa6b5@molgen.mpg.de>
 <cdc7072b-239b-491b-a1c5-ff9eaf4d5222@leemhuis.info>
In-Reply-To: <cdc7072b-239b-491b-a1c5-ff9eaf4d5222@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Oct 2024 15:01:51 -0400
Message-ID: <CABBYNZLC17+si9FLXHO5ujH_OzmTgdWDpMmSStyCnZsEmkthSA@mail.gmail.com>
Subject: Re: dedicated -fixes branch in the bt tree (was: Re: [PATCH v1]
 Bluetooth: btusb: Fix not being able to reconnect after suspend)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Kenneth Crudup <kenny@panix.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Wed, Oct 16, 2024 at 2:29=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [CCing Stephen JFYI]
>
> On 16.10.24 07:12, Paul Menzel wrote:
> >
> > Thank you for the patch.
>
> +1
>
> >> Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend
> >> requests")
> >
> > That commit is not in the master branch,
> > 610712298b11b2914be00b35abe9326b5dbb62c8 is.
>
> Luiz, please allow me to ask: is there a reason why the bluetooth tree
> does not use a dedicated "-fixes" branch like many other subsystems do?
> That would avoid mishaps like the one above and all those "duplicate
> patches in the bluetooth tree" messages Stephen has to sent every few
> weeks
> (https://lore.kernel.org/all/?q=3Df%3Astephen+duplicate+%22bluetooth+tree=
%22
> ); reminder, you can have both your -fixes and your -for-next branch in
> linux-next for test coverage.

Not sure I follow, we do have bluetooth tree
(https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git)
for fixes during the RC phase, or are you saying the fixes for RC
shall not be integrated thru bluetooth-next but directly into
bluetooth tree and then once merged they are pulled into
bluetooth-next by rebasing to avoid changing the hash? While possible
this would be hard with our CI which only tests patches against
bluetooth-next tree so by not integrating the RC fixes we may be able
to detect similar changes.

Regarding the duplicate detection, I wonder if that really a problem
or some script failing to detect it is just a hash change, because git
seems fine with those and in most cases it will just say it has
already been applied and move on.

> Ciao, Thorsten



--=20
Luiz Augusto von Dentz
