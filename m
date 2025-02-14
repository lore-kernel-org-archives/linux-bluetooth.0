Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072641EA91
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556351; cv=none; b=X4rj752TQAFipGpelZNECVGct2lIwFAdgleuLklJs/301VHVaafmzZ1gk0/Rb+zgiXnIqGLPLtdMvK+7uwaJTGjCE3dBThchn27k1DqM8dCEv/HcUCtsaRnmXPYYgmv/VnpfzWe5XwbgwvNeEAl9plylehHXUA4z+XvG6mJ2W3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556351; c=relaxed/simple;
	bh=CILG9PzksWmHvC9i+z0YzMqejqJpGinQdMXL08rJH+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWcriyk1RoTgQd2bziiBuMwDyPmyb8oX17Bsil+cbznf8bBNV4Xhd4gkSMpCoxE42SndMPlPlV6uDr0BKBuFFAjtzWpVzKA1a2jx8zU5tVEf4voH+OuQUlzBtZ7pjYx24EYXJ+5vRqzTnXJbIMZ6uWOE7w+LvVml+ioXql5X5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa6jY7mI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa6jY7mI"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-308eebd4938so22189111fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739556348; x=1740161148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CILG9PzksWmHvC9i+z0YzMqejqJpGinQdMXL08rJH+U=;
        b=Wa6jY7mIz5m2a5g+AQ+BGmO90LyZaqWLJ3EtRoWS1VQ9/PpQdatv1U5cJRWSsnzn6l
         RHzb9hQr85IYCRFhzYzhDRcoMD0V77M5u2VgkBNZohaRgH3D87u6Cc2Es6D80OYxqjjx
         SrjAW8fs3xZ0uLGQndwEXblttuibmFtr2LP++cReZObunNHycMmQisNlmlbWNgEwzIfX
         gE6NXodnspyHkn9GGzm7yqsy6oCWrFhAx3yilGSTkNL/PSh36CQbNoUpMn1pV8j5+ezS
         dWgylEFPx1hwvAbmj+ZLRx/mjaMFzDs8JdUOB/SBFVEZU0OBdcHV6xU3GdXvZobfSVPm
         huAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739556348; x=1740161148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CILG9PzksWmHvC9i+z0YzMqejqJpGinQdMXL08rJH+U=;
        b=YZ5uJBIrb/waCgq9xFeqSU3imEVpULqIWAeDBqqv7KO8oWpp1yaB1avq+eayudAVw0
         XXZtWZZATR552JSLp9kqEdosvfvZIhCBWiBNAxlYGuIOspqJOcJs8S6NCvv1AY3LHS4P
         TiJkF6VEX8/Un/aZsIQoPTM1TCjTU/2w6rPaBBBmz063+RLSjzMr7LKfSOuINji/bq+N
         jhvN3XrBl4ZCtdghSpbOHXoUNzOr7eSkB/qajz7LRy7D9odk1xjvF8VYPkd5RMv7WZzF
         KiYWg34LQz1yWizfaxwHC+5PhXa8Kj9zSIlHs4Tq8sK3fUL40WiGR2Jt5jCRu7K0TdVS
         b9uA==
X-Gm-Message-State: AOJu0YwetOAB7HPJ4NhCv4cgWndrHh1Fm9TYy/fSTgxZ6+fLGmNfbjVR
	9v7/pj8aWWeHClbHOJL3BHU7oJdOIH+a7N9RgJ/EUdN7Q6+C9br5IO4J+/3wmz95jiVuM5nJguF
	r2eOiaxp/MBrb2xJ1x6NTJ/dLW8Y=
X-Gm-Gg: ASbGncuQgitlVQ3XP39+IxurApkJ3DK/EWlJ0DXEzYPfY/GShyuh9tDoHxT9kHvpaWO
	crCwsKyA/+rihH5fa5x7itMyz2jt9eSgbCXuWx9nvmJdGymUBCLKtLuP7L5p1pEU1HavX/Zk=
X-Google-Smtp-Source: AGHT+IEgI8b8BecRdttSDRS8AHtCWBYbu3pgaBi/pb1aAgaIo2vaOZGJJ3yZA/dxQeBpGrsLUDSsxYLn8NkHy9iOwMI=
X-Received: by 2002:a2e:9b4e:0:b0:300:2ddb:aaa5 with SMTP id
 38308e7fff4ca-30927b1e734mr1694341fa.30.1739556347834; Fri, 14 Feb 2025
 10:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214153711.887794-1-luiz.dentz@gmail.com> <67af70df.630a0220.120429.66a7@mx.google.com>
 <CABBYNZJqkSkG+1oNhn4_Gff_YzCLDbF-Qbo-UBvu_pYpqMEaWw@mail.gmail.com> <CAGFh026Kopho-c3Oi2JmwY1SynYGnh2pcPf3-Y6Dzkjm4-hGjA@mail.gmail.com>
In-Reply-To: <CAGFh026Kopho-c3Oi2JmwY1SynYGnh2pcPf3-Y6Dzkjm4-hGjA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 14 Feb 2025 13:05:33 -0500
X-Gm-Features: AWEUYZkNOEbw866lzzWLSg6XWgjqfDTC81_1IxnYKKHij3uFUlW3O8fMjPTn_Ec
Message-ID: <CABBYNZJ4igtnTvVxMzDTW3ymCcS31ZJ7Hg7239gcfjLHKx4C-g@mail.gmail.com>
Subject: Re: [v1] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Fri, Feb 14, 2025 at 12:56=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > Looks like these errors are due to fa4d477ab535 ("btdev: Broadcast
> > EXT_ADV packets based on its interval"), if I revert it passes all
> > tests, so something is not quite right with it or we need to fix
> > iso-tester. It seems you remove scan_ext_adv from
> > cmd_set_ext_scan_enable_complete, I suspect that is the reason since
> > it probably no longer pickup things immediately which makes a lot of
> > tests very slow.
>
> Hmm... OK, I'll look at it over the weekend and I will try to fix it. May=
be I will have more luck with setting up a proper testing setup this time.
>
> Anyway, It's strange that this was not caught by the CI: https://marc.inf=
o/?l=3Dlinux-bluetooth&m=3D173945291115583&w=3D2

That is because the kernel CI that uses the testers, not BlueZ, we
could perhaps attempt to run Kernel CI with userspace changes like
this but then we need some logic to detect when something related to
kernel CI is changed e.g. emulator changes.

--=20
Luiz Augusto von Dentz
