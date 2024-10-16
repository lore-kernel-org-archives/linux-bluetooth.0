Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EE206059
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080389; cv=none; b=Tx1fU0WFCyjUMS7HovGoUtdfyD5trWm685/8D6CIEV0HiZnE/2kErqk9PkHmN8EiyDDW1axrOCZKXavE0/3DK3m1CF3wE/KHcBaDtrymWmb+AoHGQvMSQkJs9GY+LJ6GAkLmjj9YUKvgBnBQHV5colCAmn+HSP1mPNjkB4NKRH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080389; c=relaxed/simple;
	bh=4SN5X0bez2mgGWMgG/3SzrmV/uR+JHsw64U1/RLOqNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZ37dBldEu7Y1JJUQKdHg9C3kL6gyZeW6sirKEmNDyR5KaO3WUCqqomftLVIBk13Y/Xejk8W5Bk8cBMuJP0a9iC4FuXTBGogD/nUceeToIYKdSvLIsvUvD+T4qFJeKUgMAMH3GLLUE2CQ+Rtib8RE28FREvCyHej93iU/ngGN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHM24hvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHM24hvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD78C4AF09
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729080387;
	bh=4SN5X0bez2mgGWMgG/3SzrmV/uR+JHsw64U1/RLOqNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WHM24hvhZNzqG8g6DyhPAZa+OvK8mMR4suTqqJQxUDXBGbwIJG1SFdqTpW1ZOuttT
	 WQDafF4Zlll1Wz/ZiI5a/q02UYbCZgaBGpjnGzkNqht4C2vXbWryMZguTXTr1MKyB3
	 WhT5tIjZCl+nbErSeHGiJxaN/rewqJO/qMgl1CSPKeFSgrvP0Ua740/vvg1uymIVyd
	 fgfTahpxO0WWc7wJjyNMCNLX6I6jmFyYovL/AfpRP7KN4bLg2fhIYo+fkPbHUnAvCl
	 z777XJGPjymFCCNrf5QoMHfqyb7L6TiLQyTH3Mc+jgtEACutIVafl63YO++RhO1Esg
	 saJcBzIYnxRWQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-27beb2496f4so1712934fac.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 05:06:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YyZap5VIUKmltRTm1NfJL60gaHX2IpND+/DJlPoHhdtWSLQFthj
	N7AS8/7l7Q3l7q2ZOaDkJyHMomRKlNSVx93asmQnZerxzuYGhUAZ1Dlv36+Ax1YGidE+sCIHmpT
	qXfBpZHDwwPA73sZBjmDWz9R1btc=
X-Google-Smtp-Source: AGHT+IF8IwDbv9a7wpg1OvVbK0nx6zsS7xUpNJoNGtSHzhypwhJ3cuCezuV7E/7xB1NJ9YwElHDfP4OAGlj4g4dDqDY=
X-Received: by 2002:a05:6871:72b:b0:277:f51d:3ed3 with SMTP id
 586e51a60fabf-28887344cc5mr8732415fac.16.1729080386887; Wed, 16 Oct 2024
 05:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014202326.381559-1-luiz.dentz@gmail.com> <36e9550a-3b45-4489-8370-afdc4f2fa6b5@molgen.mpg.de>
In-Reply-To: <36e9550a-3b45-4489-8370-afdc4f2fa6b5@molgen.mpg.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Oct 2024 14:06:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hE_MVn2OJomHQzFK1Ft1hA4LWqp4KEauQYLt1CZmPopg@mail.gmail.com>
Message-ID: <CAJZ5v0hE_MVn2OJomHQzFK1Ft1hA4LWqp4KEauQYLt1CZmPopg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btusb: Fix not being able to reconnect
 after suspend
To: Paul Menzel <pmenzel@molgen.mpg.de>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Kenneth Crudup <kenny@panix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 7:12=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Luiz,
>
>
> Thank you for the patch.
>
>
> Am 14.10.24 um 22:23 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Calls to hci_suspend_dev assumes the system-suspend which doesn't work
> > well when just the device is being suspended because wakeup flag is onl=
y
> > set for remote devices that can wakeup the system.
>
> Please mention that you revert most parts of the problematic commit.

Yes, it would be good to say in the changelog that this is a partial revert=
.

> > Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> > Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> > Reported-by: Kenneth Crudup <kenny@panix.com>
> > Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend req=
uests")
>
> That commit is not in the master branch,
> 610712298b11b2914be00b35abe9326b5dbb62c8 is.

Right.
