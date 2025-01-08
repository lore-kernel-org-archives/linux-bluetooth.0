Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA9259497;
	Wed,  8 Jan 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350397; cv=none; b=IQeMzlosbyBBQ7aFjfVQcWTWELhv2az97LOOIZcLd9/Yz4CzqTKP+cTST3Uz2Pxeu3E4A/LnG/JV7Pvq8p8IfnC06HRiUHHCMdxgW/VfgCKjY7qf2yd14MLPEX1dxryNb/HC1tUkArCPsaaWObxp7OhbZgoWMIF8d+Ad7q+jvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350397; c=relaxed/simple;
	bh=DOSvn8/01dhBtrR9mx7aW2niz2uWGndvvoG9WLdv5sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEnrbrLIXT1vejGEnBugRR5chZXN5GvOphxElpt+j1zq3WjAuf27OoyeSAL+Wl1dBPfGWlkEnbvx13VLYCA7kpObKJqtx7pr0JFWLP8GW31NG0NnphIsvocfVxMvpHPKbQc8ssgXYr5xwZwrmCEMgheEGnW8Lk/5Na74WRaPRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKF0iVIu; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKF0iVIu"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3022c6155edso108431321fa.2;
        Wed, 08 Jan 2025 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736350394; x=1736955194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyMW9fcE0jO9ycIJnCWN+E1iTMGz6u8O2Iv6BPir27c=;
        b=CKF0iVIuyXILlUL1+SkRwkAzwr18xB14oen53LhbYXHlrmYDvBxkEgHfCNsnucwObZ
         lJLV98j3mq1G6qjJ4nOHh4cXYRFVE9u1MqeWT53d2M3tgA6PEGa+vdytsaaem4+GVOMa
         OKbYhGjLoSJIi/isSFr3wVmELd8M8kwiJh5l+NeivgCtzAjXXzUZFiJsKEZvfYwdK5d6
         q+dXPpBcF8qVGCdrrO3sllhHdC9WONCa0vC4CEgGqTNyJy1oL6+aeVKzkFz71XObfJmv
         Xm6eATdKjmxzA8AZCKPX1+eghtWGQrL9paHMI3SMmMR05fzJHqiP5JrVuGa92s3NF61Q
         S79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736350394; x=1736955194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyMW9fcE0jO9ycIJnCWN+E1iTMGz6u8O2Iv6BPir27c=;
        b=cpxt2DEtpbqN9NucV9cXi2PyYjjTVl1mBJC9NDScKYR2lbcUoP/5h1oQ9eUCN666qp
         HxeeKRiOWQWnnfQ9j1A9FPGsKzygX2bC++RoVcZGS82FvXODZqN5kjabfhJ4JxCC6ose
         JNa8iaEN4nK/Z2D/ZHhPOjjtj1ZmWPHWKE5imzULQX/42APsLYem3lKeRDZGrdjBek6V
         Heyiav/LcvkE2fzvo4LUlLpQgt6v9Qnu7jZILdR+F47eDmEhE/mCoXbrHrQnieIzsuof
         i2vNHJ/RykajI7zDsP3LOhLAuyQSvhyj+7C146Lhl1Zo39TPJc+SQJ1N6DI4ajUPgs8n
         6G7A==
X-Forwarded-Encrypted: i=1; AJvYcCVpi1YPBCXb2Javjgi1NcSSRAhS3Lad1QG0on8y9RdwJHsUnco68gI0cFfdmtJDB3lsX0bdANXESHkBrpxf+/c=@vger.kernel.org, AJvYcCXNJmkfJaY6EuZveue4dOpKRS1Boa1PLb9InqW0ZCFGH8c//RWz6a8mrx/h7Vz7Cx4TSMDDFZ5A7dSoBNKN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jgUj4NkgoIJOJ/FE8o6zf85BIlQwULnF5WUB8dag+cvVQ9+A
	poapiKYklAXHD/ZgAMIoSn91T1ur73zZRxKB8m8ZhjXACB4GwTKteLtHcBySCXtwLU5YFmVHdsf
	Gz9Fz5yWc+iE8Cf/vrh94pZq+mnAjiKfrzgY=
X-Gm-Gg: ASbGncsN/eHVf/L651sAbe56so8HKxYu7dDKYyOs2g54e/YoZ7VkjCVbBCxWSZHP3D4
	icjxaYEOmNtjNH37Lr7yDOKCX3SeY3h4MHcJ9
X-Google-Smtp-Source: AGHT+IHMS4h/jhSsE87koiy+ebpOF/DSzLHg5HfeI8xWQarGX1AGsohWYMODXrCRGqFY6VAFmH4iBy1FUe/PDVgK0ns=
X-Received: by 2002:a2e:be8b:0:b0:302:4131:56c2 with SMTP id
 38308e7fff4ca-305f45310bbmr7842461fa.4.1736350393836; Wed, 08 Jan 2025
 07:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
 <2025010829-used-halves-7342@gregkh> <CABBYNZLEG4rQBM6WYyRNJwOYWQU2ajyCTxWwe3+6aCYm=Gk4dQ@mail.gmail.com>
 <2025010853-stalemate-upheld-10f4@gregkh>
In-Reply-To: <2025010853-stalemate-upheld-10f4@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Jan 2025 10:33:01 -0500
X-Gm-Features: AbW1kvbNFTpOALZpDQ52xKaUM-bz8xbZsbUa3mgkoXN9517wKPDgyRwnUVKYu1A
Message-ID: <CABBYNZKM9BsNFq=uFiOws6Tvtc-NQGTnVrD8-AJb=N6-EQk3bA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Allow reset via sysfs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hsin-chen Chuang <chharry@chromium.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Jan 8, 2025 at 10:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jan 08, 2025 at 10:06:34AM -0500, Luiz Augusto von Dentz wrote:
> > Hi Greg,
> >
> > On Wed, Jan 8, 2025 at 7:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Fri, Jan 03, 2025 at 11:20:20AM +0800, Hsin-chen Chuang wrote:
> > > > Allow sysfs to trigger reset via the cmd_timeout function in hci de=
vice.
> > > > This is required to recover devices that are not responsive from
> > > > userspace.
> > > >
> > > > Also remove the cmd timeout count in btusb since we only ever allow=
 one
> > > > command in flight at a time. We should always reset after a single
> > > > command times out.
> > > >
> > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > ---
> > > > This commit has been tested on a Chromebook by running
> > > > `echo 1 > /sys/class/bluetooth/hci0/reset`
> > >
> > > You forgot the required Documentation/ABI/ update for your new sysfs
> > > file :(
> >
> > Looks like I've missed that when reviewing these changes, anyway no
> > pull-request has been made, I assume we should follow what is
> > documentation on Documentation/ABI/README?
>
> Yes, all sysfs entries must be documented that way.  We have a script in
> the tree that you can run to verify that all entries are documented, but
> I don't think anyone runs it very often :(

Do you recall which script it is? I'd like to include that in my hooks
and in our CI so I don't miss it next time.

> > Does it include debugfs
> > entries as well or only sysfs are required to be documented?
>
> Only sysfs as that's the only stable api, debugfs can change all it
> wants :)
>
> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz
