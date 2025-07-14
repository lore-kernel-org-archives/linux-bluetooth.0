Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931625B1FC;
	Mon, 14 Jul 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517196; cv=none; b=RNlWqhDPxrnamRWhW8uNsAEM/8p6UJCG05WZ1kgt0uWY0S6ffNWd0fPH6VyVKntzvTPDtlAc6AWAk0CzcfhYcrqCgiKUMGrNxZ09gT5ioiagjR2HK2/I0bybOdV9VXxvB0UCNJeEQfqLonb5IquKKcxc6fJXuO6JiPrlfUBdaDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517196; c=relaxed/simple;
	bh=lj6HGJcRu30YDWGiOEAztzRVc3P7Ei3hTMPoLMagtdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq7r+jY7idMOI29j/sPki05OazrxPUVB5Bd+wtLu+jfmZvqwtDk+d1zd4Kn9TrxhnHmYWh1TQLvwqfbD8iEMMy7Xs7xW3h3poz7hGRL4atTfR7PPiCNbf/lX44uyhDZZFqwFmDh6xu2aodSffayNLH8eQ6hBOqA+IGSzpH315RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW0jUKfo; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW0jUKfo"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b561a861fso39607581fa.0;
        Mon, 14 Jul 2025 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752517192; x=1753121992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWLea9krwsMx32Ex5knaUCEUbdLbUBV+mv8AAUJif5s=;
        b=LW0jUKfomAhVARE2q0YY+oyraVJ+UwUKluaEDrS65HTlm9vGcNu8eLdjm0chHNttx1
         PscfI006WbOBcBHqm7zquR/TvcPByjO746Ue76KAZ15TWdiURmYJ55l9sXou/HYTggmN
         8s28+8X27/xQsgeO9eJInW76wnI1/kly+heoRJyllLxr5z0AF0+yc/0BugXiNTgpCa2L
         TtDWvB/ukTkofbEURCQFbl087kM3VqbJEwNr4D/+vYC5mI/PEFMdqYVGqhpZGen0CAAp
         d+5QD2x6TnXBVAScdNBU93KIcIOx8++iLMWvI6fVKwpTPMhmrk52XSnMOprHq9TfVOyV
         rUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752517192; x=1753121992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWLea9krwsMx32Ex5knaUCEUbdLbUBV+mv8AAUJif5s=;
        b=CJuEkFqMuJCtWKE3DmMmX5yKI/6RVIblfgezi1uQQ1IMOUSypV+LOJcBX7rXY5zCoq
         AHBfabjWGOZ83HtIlbGh7/Z/7q6FG/IQ4fqtVoR1WyXSQxjHmrUly+9Y2zRv0vQW09sn
         PGGJqN9yw7JNjvZLNdk8xXMcZNSKRLuCm9JPTMg6OwR0GITNMxncMKJnaWcdH/mWjqHC
         FKEVyvtumJRnhUhqRWYFurzvlFHdoh/I1Oh8EVyvZuErlsC7OJcWGD69UK2NIGyhWda4
         hWTJKM0ziOfVNQ5GyKc6QtN4d4KkCfSCeF56M4idPND5E0AR3NHYl4BeF2Yn066WxPBL
         wj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2ptZ21tOEslj49vmidPqfeXMnr+HJNsh7BX2LZ40R3rR2hkhq5ADRqSqKymajLt+afuEMRdc40nBCzXvqW6k=@vger.kernel.org, AJvYcCWTygSZP2Fp41a5dXkLLWmTXqsediXt0LdvJkNj9TjvxwZVdJnqovC6DgtHCn0Ra3+e4s7WxYKRGInvhzo2@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAGLsHglsgvgo2x7NicsUph5XhjWVmD5ymE66cCYxRHFYs8fC
	PYQls9FeiL0eaNAB9oocAN6gx1K0NM0J1rsGEqv5QUQYfeaG7RL0+GVjTeqdHsNxvLe5NZZF9DY
	FJ2q2OL5DE4OvW9XIXHJFtiGi2/i7uHEtQ4htoNQ=
X-Gm-Gg: ASbGnctyBaFUvN5lDByLSnV2DHmWvwkZoOFD5sl7JQVKbU/s4s8j9sh3+AMBiAJlmrH
	1OdUNrdDUMOWc3mB6Z9WNfOV90N80VqMQH3PQkzsSQbgxqqfDmDagGmsbQxXo/hHIo8mPKx7uhy
	cVxfgmgWxSimIDGdyitoCRqnxv7jSyhx/ENBOdZjppIrevRkE8mJWPSiYAwqgd5Z7H1BPq/iArs
	QCGAg==
X-Google-Smtp-Source: AGHT+IFoe0ldR+5enpsWqfXLzFt5V7a6KMaFs2xjFAK1TM+9UhqRHSUv4ZcBbQJ8R7LHtG7LF84y00xuFvMbeJJLZKk=
X-Received: by 2002:a2e:a7ca:0:b0:32b:456a:54a7 with SMTP id
 38308e7fff4ca-33054fbc856mr39131991fa.16.1752517192192; Mon, 14 Jul 2025
 11:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22185131.4csPzL39Zc@n9w6sw14> <f14e501d2d478604554cc5280d863caabf6d5e94.camel@iki.fi>
In-Reply-To: <f14e501d2d478604554cc5280d863caabf6d5e94.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Jul 2025 14:19:39 -0400
X-Gm-Features: Ac12FXyrqSOKFOOhBKeQ7o-NABBhlmFMT_tsEM99Mj1Tya9UXrz-Xac4Sd7PKu0
Message-ID: <CABBYNZJZV4t=9LdKOGJNi9B8WHKt6X0iWpb53q2PfwKsh17RJg@mail.gmail.com>
Subject: Re: struct hci_dev::quirks is running out of bits on 32-bit platforms
To: Pauli Virtanen <pav@iki.fi>
Cc: Christian Eggers <ceggers@arri.de>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Christian,

On Mon, Jul 14, 2025 at 2:03=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ma, 2025-07-14 kello 19:09 +0200, Christian Eggers kirjoitti:
> > I just tried to introduce another quirk for Realtek Bluetooth controlle=
rs
> > when I recognized that the underlying data type (unsigned long) has alr=
eady
> > run out available bits on system where sizeof(unsigned long) =3D=3D 4.
> > The number of entries in the (anonymous) quirks enum has already reache=
d 34
> > in the latest kernels.
> >
> > My first temptation was to simply change the data type to something lik=
e __u64,
> > but this is not as easy as it seems. The test_bit() macro used almost e=
verywhere
> > for assigning quirks is guaranteed to be atomic and my platform (ARMv7)=
 seems
> > not to have support for atomic operations on __u64.
> >
> > I mainly see two options:
> >
> > 1. Introducing a 'quirks2' member (bad)
> >
> > This obviously would work, but requires another enum and will (I think)
> > introduce stupid bugs if the wrong quirks member is exercised.
>
> The pattern used for hci_dev::dev_flags is
>
>         struct hci_dev {
>                 DECLARE_BITMAP(quirk_flags, __HCI_NUM_QUIRKS);
>                 ...
>         }
>         #define hci_set_quirk(hdev, nr) set_bit((nr), (hdev)->quirk_flags=
)
>         #define hci_clear_quirk(hdev, nr) clear_bit((nr), (hdev)->quirk_f=
lags)
>         #define hci_test_quirk(hdev, nr) test_bit((nr), (hdev)->quirk_fla=
gs)

+1, that is probably the best option if we don't want to do something
bluetooth specific.

> > 2. Switch to using __64 with non atomic operations
> >
> > About 99% of write accesses to the quirks member happen from probe() or
> > setup() routines which should (I hope) not allow simultaneous access fr=
om other
> > contexts. I found 2 exceptions (as of linux-6.12):
> >
> > a. btusb_setup_qca() is called from 'struct hci_dev::open()' (maybe unc=
ritical).
> > b. Two quirks (strict_duplicate_filter, simultaneous_discovery) can be =
toggled
> >    via debugfs.
> >
> > So it looks like using non atomic operations can also introduce trouble=
 if
> > not well reviewed. But as the 'strict_duplicate_filter' and
> > 'simultaneous_discovery' quirks are only used at very few locations, ma=
ybe
> > these should be moved to a new member for "atomic quirks", allowing to
> > convert the remaining ones to non atomic.
> >
> >
> > Are there any alternatives? Anything I missed?
> >
> > regards,
> > Christian
> >
> >
>
> --
> Pauli Virtanen
>


--=20
Luiz Augusto von Dentz
