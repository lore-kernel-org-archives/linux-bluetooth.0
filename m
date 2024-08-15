Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56574059
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750535; cv=none; b=jbz4AzBbcV2tEpQ8I1+88+Y7c7JAhkVaqMOqbrbD6NpbmCDRQZJcga+CTZq+vPw5THfNjacobHvyptAPyatOOjAwcD2UAnPEvXaVRRIkRP89H5iYfJRg0W8kX5awGTn41nHlQ5+TJhlBZLq70ZqP8+eKtfA8C9exczeVSLRwsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750535; c=relaxed/simple;
	bh=OyIcDB5JXidzlaj6egent3oo7e8ugXdD+OM48hpjtlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOS5px6P9wJOwmglt7wAbEF4m/wdALIzCJtBVszYcXxtlV6qFjmrO5OHqY5JvHJxx1Pu7Hu1uxGSaBUcqKbVA9Rx/nvO9ZcfbQ/D3J3BbuVrxRMiQTk9lGCu5e+bKuNwWURwYnSrEyxYwIHQPBQaninPgPIf9hDzH1jLBUPHF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=los2kvqB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="los2kvqB"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so17762151fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723750531; x=1724355331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyIcDB5JXidzlaj6egent3oo7e8ugXdD+OM48hpjtlM=;
        b=los2kvqBRvsSIjWmWiWyOy16XXQxIRwtPoV57CQM0nEfsdzt6iuaKEGt5LN2nVvw/Z
         lU6UuG2ItRrmecoaJuKPfZL1CGRaAgknedbU1mULl9EmiTPpY4s6GF6Tai2Nnugaam/Y
         zZQa1+ImpPc3JxejxlVvrKOVzOfPf51jT3ate/WluJgdmG9d6Z5esVIfDRiBOIJ3sk89
         o2DoI+LaIkGHQmYffhzdlSr4kT2AhKCh+l8/k9ylCEt4r5T4xn9egDVlQwOYcM6k2lK0
         4wc1SrhvZWDVzI037Q0ESaix8QLsKHM3br+90qhowjKm2OqSSz8S85fjf9JFsf5JYtXR
         ZtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750531; x=1724355331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyIcDB5JXidzlaj6egent3oo7e8ugXdD+OM48hpjtlM=;
        b=xFqoSaJqK7/wmilAXDOFWvDNkMtxOCMi7Ko+KY9wfkSIF/mgt/U+hFvn3IPsnxBMDO
         e8ZciKM85R4MMFiDC896QPXeajjBd1vpZ98a4kdiLya9oTqOYnkZTFbX2bCFKDEXXCEu
         Uthwv3SWnI+r3lwYAajtx/YhhfgVk52DogCjcFnCMMYp/b1Qt8tuY5dCnoL9yGoTz4bp
         DZ0rjlL0TCmDvxB7c8Bd39EtSXxkZTNAt29hrStlDhpahdRp7fxNgxB0qC7GXFavYCUi
         De9OBO4GX99m3a6j441y537V0goehb768bzfyrTWhNxnVn9HUHH4KtNF89+JpihiRD7K
         vn/A==
X-Gm-Message-State: AOJu0YxvGIlZ1YWaG4gFfZMf96rjfZ6wSULAot4nw2uR/vEOMzuILYFq
	RvzUR3CzuXwwoXZ1f3ylxUqdmPyE0iE3gY8qpiUEBYBAFftBFso6chQORaRtU8Q9hvwgR+0ycJD
	BVcLYGDl13LVayPlMAvmeL30MWnmIdScb
X-Google-Smtp-Source: AGHT+IFjyZt+mShQYw60hErcxVU25TYO7/KORG3iSRR2O7+cT47auwsJgl10E88EoLwADkBwDExaDIV0ix9eLsxFPj0=
X-Received: by 2002:a2e:9d89:0:b0:2ee:8db7:47b7 with SMTP id
 38308e7fff4ca-2f3be5ae55dmr4103351fa.26.1723750531098; Thu, 15 Aug 2024
 12:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172362641171.1463.1558884635182654862@lain.khirnov.net>
 <CABBYNZJ0OK=yfrzFneNXBD+ye8UF7w_5pLJah+Fyfr+XHefLsQ@mail.gmail.com>
 <172374276216.7554.15339600683100081438@lain.khirnov.net> <CABBYNZLXvvM2knc6khd+iFnx0NkDFiuF-d5UjcFpFj-xD85Drg@mail.gmail.com>
 <172374663027.7554.6790757631293861028@lain.khirnov.net>
In-Reply-To: <172374663027.7554.6790757631293861028@lain.khirnov.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Aug 2024 15:35:18 -0400
Message-ID: <CABBYNZKk6h7iQ5ZwRvycxiOccKFfFFz6NTMqw_dbKAqAwmwYbg@mail.gmail.com>
Subject: Re: monitoring advertisements from specific device(s)
To: Anton Khirnov <anton@khirnov.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Thu, Aug 15, 2024 at 2:30=E2=80=AFPM Anton Khirnov <anton@khirnov.net> w=
rote:
>
> Quoting Luiz Augusto von Dentz (2024-08-15 19:34:41)
> > On Thu, Aug 15, 2024 at 1:26=E2=80=AFPM Anton Khirnov <anton@khirnov.ne=
t> wrote:
> >
> > > Also, the advertisement monitor interface already does almost exactly
> > > what I want, except for the fact it forces me to receive advertisemen=
ts
> > > from devices I'm not interested in.
> >
> > Yeah, I was gonna say that, but this is a vendor extension,
>
> I don't follow, what exactly is a vendor extension? IIUC in-controller
> handling of advertisement monitor or_patterns is a Microsoft extension,
> but what I want is just a nontrivial device whitelist, which should be
> standard.
>
> > not really following about forcing you to do anything, or you are
> > saying you want to connect rather than parse something on the
> > advertisement? It is a little bit hard to give you any advice if you
> > are not really explaining what is the use case,
>
> I wanted to avoid flooding this list with too many unnecessary details,
> but seems I went too far :) Sorry.
>
> I'm writing a data collector for bluetooth weight scales, which I'd like
> to run in the background and work automatically without user
> interaction.
> Advertisement reports for a weight scale contain ServiceData that
> indicates whether new measurements are available - when the collector
> sees such an advertisement it should connect to the scale and retrieve
> the measurements.

Ok, enable LL Privacy:

https://github.com/bluez/bluez/blob/master/src/main.conf#L139

And register the service UUID via GattProfile:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.GattProfile.rst

That will get the bdaddr of the peripheral in the
allowlist/whitelist... you are welcomed.

> So what the collector needs from the bluetooth stack is to monitor
> advertisement reports for a given list of devices (the scales it
> previously registered with).
> The advertisement monitor API almost gives me this, except it always
> uses an unfiltered filter policy (as per the block right above the done:
> label in hci_update_accept_list_sync()), which means advertisements from
> all devices are processed by the kernel and sent to userspace. This is
> not a fundamental problem, but it seems wasteful as the controller
> should be able to filter just the devices I want.
>
> > also if you are involving a daemon then perhaps you are not really
> > using bluetoothd?
>
> Just to be clear, I am using bluetoothd (via bleak), but AFAIU the issue
> is in the kernel code.
>
> Thanks,
> --
> Anton Khirnov



--=20
Luiz Augusto von Dentz
