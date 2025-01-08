Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D142AA6;
	Wed,  8 Jan 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348812; cv=none; b=uAR8VDCZJlkclVQkGal4w/kEW7VpFg8O1KqC0cyBdGCRu+EEdrJMqm4YssHHmIalx3hLckC4oDwsjA8gcTy0inmeqrZTwXwu2nToKIBEwxcSiQqwf3skS5DcuO+Qdb07c7UZFjl86O8W1UUj2ehyFbvNTmyo3VHNdGJHl9s7kGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348812; c=relaxed/simple;
	bh=QTJ7PBLTf16VwwErifTox7GhLnv2TI6RLdHSrNQBeGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7JfZ9XaS6174JUy3w31UmM7v65pwOWIsjp191XyEPpob/GemWlWTEEj4Y8s/4Wn907h+KykUpNcX0Xoo4rAHmq2UUovYUgSnE/kJ74UXAE3YIr6K1MX41FZBRald1aSzQ5ibh8UV9+CRLxv0nT3+2URQNrixdRXHf9eMRy+RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyQvc9MU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyQvc9MU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso225608881fa.2;
        Wed, 08 Jan 2025 07:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736348809; x=1736953609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTJ7PBLTf16VwwErifTox7GhLnv2TI6RLdHSrNQBeGs=;
        b=PyQvc9MUcAJ8jNyrbmJRIOpQWKmbfjLkrFjCDd1l8o6aT67Tlpx5EsJHfhcT6UUhRR
         g0n8ENsTOoz92OJPnn0Vdc4MVNhgs3KjRF1QscXqHr+Zfj59rwi54Ws98EoVqdkja4LD
         sRBY2boElBvIYETCnYlR3VPmucCrKFdL/hwmXkKFjImUEjMWtn14leMrYqMU0I1B6YVf
         jOWSUiYgQpqo9AXj3uu1w09E5EsI4IfJlpcscxUZp7Lsyh28uWVTJ7QY9Oa9+H/K3VgB
         f/YF/pQjSehOEb29AQYscwOQglYLNfCl513H4adiTJBEns2Wjaufbwqh8Fg8JnAZkDA7
         nu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736348809; x=1736953609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTJ7PBLTf16VwwErifTox7GhLnv2TI6RLdHSrNQBeGs=;
        b=k2rCJFAJTrCnxc5fi0m2eTWoR6Gx+vzVTw0+OrVjQAOe4W8S5r6WZKty+K8LY3f6Xf
         0mZXJKiUz9jgNL+RyvB2csxvfwEquFR5pIu8T6/KnT0wl6lMl2+TJsVuho2Eu2VEEbAg
         4GdNEj1tOKHaRWX3bk5TTeiYrzRRglZoOLpyo7/cuYFj3Zv5Yt7J22cpuZ3GUT2sCF8y
         yii7/vTs+cRrdsNhPhgwDSZHnjWB4NfaNJvh/EXSW9q2Jkf3SvvPaHICTlsGqagjlM/2
         pIsDcHf6zB1eqmz3DBX8PCU4HXS1mAPQZJZOCCgGUGzBH4j/XtqYOYSlQ4cxmx9Wg3cs
         mCSw==
X-Forwarded-Encrypted: i=1; AJvYcCU9lq8+hJsDiCHmbx+czoYcJtdu6TwpMmsQ05tdmnweBlQ86RwaL/rvG8ECg9q8sQ8IdKPGGXo92548Blbe@vger.kernel.org, AJvYcCWF55jh0Si8ZpiW1MgHYkwzSLwa5HKNTjVAO7S8fzGK8agcD1CSHAfSl920MKoZc08/wv/e05L+1cUqaTrJNTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7TnyivYYVBNzCIZB+moRodV2vV//xL1jrXZAYi/PXvGcW6ua
	JqtcDDEerAU8w7/BdY4xSf1XfW3SnnbiCs0Sa/6fvNGVQtChDbIKr/mmz3YenBxZ1t5B/Ra2CnO
	Hkcw0VVaMXKZzmWd37PN8chHixf0=
X-Gm-Gg: ASbGncvemFdpFHN43v2f/ZJX6jmTXOq2c02O2/s7vGXOz2l/NX9ihlztE2HQWZ3ipBt
	3OIDFaxT+UYsM+ld7t9YAtXpwThNL3q6hbmbnVlg=
X-Google-Smtp-Source: AGHT+IHw2uw3mBG8uPcmab586uGQx91MYjd/Sg+3Fm9TIvG33vDem0kNfKDGmjalZ3qAF7yX6Irwjh/ZDjacIRI+IOQ=
X-Received: by 2002:a2e:a987:0:b0:300:33b1:f0e1 with SMTP id
 38308e7fff4ca-305f445efbdmr8717811fa.0.1736348807151; Wed, 08 Jan 2025
 07:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
 <2025010829-used-halves-7342@gregkh>
In-Reply-To: <2025010829-used-halves-7342@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Jan 2025 10:06:34 -0500
X-Gm-Features: AbW1kvY-gRJcSFsca6ElGRazjNUH_l3-fYwe1f9sa7cbKh4G9V-Lv4oQgT7H1Ao
Message-ID: <CABBYNZLEG4rQBM6WYyRNJwOYWQU2ajyCTxWwe3+6aCYm=Gk4dQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Allow reset via sysfs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hsin-chen Chuang <chharry@chromium.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Jan 8, 2025 at 7:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Jan 03, 2025 at 11:20:20AM +0800, Hsin-chen Chuang wrote:
> > Allow sysfs to trigger reset via the cmd_timeout function in hci device=
.
> > This is required to recover devices that are not responsive from
> > userspace.
> >
> > Also remove the cmd timeout count in btusb since we only ever allow one
> > command in flight at a time. We should always reset after a single
> > command times out.
> >
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> > This commit has been tested on a Chromebook by running
> > `echo 1 > /sys/class/bluetooth/hci0/reset`
>
> You forgot the required Documentation/ABI/ update for your new sysfs
> file :(

Looks like I've missed that when reviewing these changes, anyway no
pull-request has been made, I assume we should follow what is
documentation on Documentation/ABI/README? Does it include debugfs
entries as well or only sysfs are required to be documented?

> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz
