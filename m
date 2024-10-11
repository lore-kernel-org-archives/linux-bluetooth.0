Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E61D0E1A
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728677183; cv=none; b=nsTQ2hnTAXtDltmQjGwAqWC+5D9qtZjgXHOvIFZvyaniy2JQR984bhmmnrJWzURAS4lkuqn9eRzbOF0FlXgaUaADYEJNpUZD2pUgNmen0rz0i50RUaeHLEGdKkl4CyGieuSBK8HFjZu/3oaKlrDlLwc0OQ9gnjTp4uwvjz3Npss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728677183; c=relaxed/simple;
	bh=b5yUhITZfshwpPK8BEK9zAmLhWSo2HbpVE7LdPkcMJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLPPzrRSAQkY9sOjGh/2SZRWiIfViUR10W1IHG7dlm5Dtw+jYlOlGSy1NzQB+WL2tab2yb5S5h3tz0I6995f2bm3r5aUicubAgaApi6Kk2sqtgQMpNq1LXDqBP3LPHWVfYIgsK3nWQEoFUzwKrTlKDPooIBHp52jtAGyFcyNDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnHSGIFt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnHSGIFt"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac787f39fso27471051fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728677180; x=1729281980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY5mG8LMmyjWmgpDZ//8s+hxHHYHDX4JfFP5LDo/CNI=;
        b=ZnHSGIFtT2xO4WGhMOQGuQgNKG6Z6B5dtJbKx6eHsEIKwQiv0nWrVOpscN7xST/Fm/
         hlyuSp4lN5Yr7g3V7uBal6FSKJMiOxl+gN/kasG906CAuXEOl5mgRI43EhSIVvHzv2yf
         1X5R/rSRME1GAZsRrKfKpDXP3EQ7x5hj+SFKP/T8LKdKNF4UM9/ZWNMO4ng8WONw0EWN
         8PYObfgiqMNKfUUGu1JLAAVXOOBO0sjP2SmQbPwDFdiRa2RIADV9G1NnDrC4CPOELACy
         dNJITCWcrbPCwBH/YDWL1KcsYquC0VM2OF3rUT4/yDJPvkOO4v2T+rnkPnErK4m6sphu
         fodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728677180; x=1729281980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY5mG8LMmyjWmgpDZ//8s+hxHHYHDX4JfFP5LDo/CNI=;
        b=LX9VkCCt5RhBXMtv5GEVjG3qpQIgjaLAGvolm7NjagIiCr0bfKzZQXZVT7ozV0zTOu
         8kvZAHZAabt1CuXWNi9yurnESozoTPvpss/o4hmqCGjIaVCy3G4H6dyjPrr11OS+fRYV
         umsKG0KJfJOjJYyjFgsNZnX1+wxxCLmlCAWZlRG4MlbJxI4phHoWIaYsyPt8iRF1GEso
         8pWTq2gBusv2qlEOSPp8nBK2++YffZoGK3/8f7HPpJhECefljMfeusRoEisK0ca2qGMS
         xHKE8bxprNvoqqnc433Mw5yLk9TdloCL+5Erugt7UcDAg+UC4yj2hTlsz9YL02IPGE87
         vxTg==
X-Forwarded-Encrypted: i=1; AJvYcCXfk2PzzgYHTtII6LTFPn8NaB7/KtmWiENcyNz1IHeAXlqAvTMzyNd4IolckHM3cmzFampvxwaZBC0MWcacFMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvYjEJI4zsBJe5idoluxh/tIMwcWVR3Rp9N9h4NK+t1VbKd3X
	2yz4ELzQTzua2j8as5osZN8763K1qr8yOvd68dc7DJ4VBO13PTi7+OXP16eKuGZ1z+ocULDqJyh
	3CRl/qr4EQt87oVvJXJVsXxHc3S4=
X-Google-Smtp-Source: AGHT+IGoEqgyNulp5BQI9pLiPULjYMIylVGxCiDoHv/1wuHeGkw4WhZiu0y9wGJXatdIiTT8zeqeWGJL7lV///Uk7lI=
X-Received: by 2002:a05:651c:548:b0:2fa:d345:18b9 with SMTP id
 38308e7fff4ca-2fb329b2a01mr22174841fa.38.1728677179300; Fri, 11 Oct 2024
 13:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
 <CABBYNZJMWni33VQ2sX9EDcNbsFbX7pjAFj4QLri9N7jyLY0HvQ@mail.gmail.com>
 <c8b5c842-463e-4c30-b7e0-f41bf1d59305@gmail.com> <CABBYNZ+kcwgPvCNFZHZZok_a6ZNXEPNABNefb4iaSNDNm4wPVA@mail.gmail.com>
 <CABBYNZKbXE4unZi3MPP2LPzYcv0OLHoaqqey02N1qUzSR=4PhQ@mail.gmail.com> <d85205ed-dd47-4690-99a3-8f20ea7ab237@gmail.com>
In-Reply-To: <d85205ed-dd47-4690-99a3-8f20ea7ab237@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Oct 2024 16:06:06 -0400
Message-ID: <CABBYNZL7BJq57iJEm8y6D1JWikymC-gSP-N6jHXpgBjgWC_B6A@mail.gmail.com>
Subject: Re: Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't
 fail external suspend requests")
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	BlueZ development <linux-bluetooth@vger.kernel.org>, Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Fri, Oct 11, 2024 at 3:44=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 11.10.2024 21:26, Luiz Augusto von Dentz wrote:
> > Hi Heiner,
> >
> > On Fri, Oct 11, 2024 at 3:05=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi Heiner,
> >>
> >> On Fri, Oct 11, 2024 at 2:52=E2=80=AFPM Heiner Kallweit <hkallweit1@gm=
ail.com> wrote:
> >>>
> >>> On 11.10.2024 18:36, Luiz Augusto von Dentz wrote:
> >>>> Hi Heiner,
> >>>>
> >>>> On Fri, Oct 11, 2024 at 6:49=E2=80=AFAM Heiner Kallweit <hkallweit1@=
gmail.com> wrote:
> >>>>>
> >>>>> Since linux-next from Oct 4th my bt speaker fails to connect if I s=
witch it on.
> >>>>> It just hangs trying. Manually connecting it via bluetoothctl works=
 though.
> >>>>> With this patch reverted it auto-connects again.
> >>>>> If you need additional details, please let me know.
> >>>>
> >>>> I suspect something is trying to suspend the controller then, it
> >>>> shouldn't be USB auto-suspend since that should behave as it
> >>>> previously but if there is something externally (aka. userspace)
> >>>> trying to suspend then it will force it to suspend.
> >>>>
> >>> On the host side it's a combined WiFi/BT PCIe adapter (RTL8822CE).
> >>> Runtime PM is enabled, so this may kick in. I'm not aware of any
> >>> userspace tool which may try to suspend the WiFi/BT adapter.
> >>> Disabling Runtime PM may be a workaround, but I don't think that's
> >>> the actual solution.
> >>>
> >>
> >> Well I assume it still using USB as transport, not PCIe, otherwise it
> >> wouldn't be using btusb. Regarding runtime PM, I assume it still means
> >> PMSG_IS_AUTO Documentation/driver-api/usb/power-management.rst:
> >>
> >>      'External suspend calls should never be allowed to fail in this w=
ay,
> >>      only autosuspend calls.  The driver can tell them apart by applyi=
ng
> >>      the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
> >>      ``suspend`` method; it will return True for internal PM events'
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
> > Perhaps there is a double call to the likes of hci_suspend_dev due to
> > system suspend and device suspend acting together, so maybe we need
> > something like the following:
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 779c4aeaef22..c257759ae2f4 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2812,7 +2812,7 @@ int hci_suspend_dev(struct hci_dev *hdev)
> >
> >         /* Suspend should only act on when powered. */
> >         if (!hdev_is_powered(hdev) ||
> > -           hci_dev_test_flag(hdev, HCI_UNREGISTER))
> > +           hci_dev_test_flag(hdev, HCI_UNREGISTER) || hdev->suspended)
> >                 return 0;
> >
> >         /* If powering down don't attempt to suspend */
> > @@ -2843,7 +2843,7 @@ int hci_resume_dev(struct hci_dev *hdev)
> >
> >         /* Resume should only act on when powered. */
> >         if (!hdev_is_powered(hdev) ||
> > -           hci_dev_test_flag(hdev, HCI_UNREGISTER))
> > +           hci_dev_test_flag(hdev, HCI_UNREGISTER) || !hdev->suspended=
)
> >                 return 0;
> >
> >         /* If powering down don't attempt to resume */
> >
> >
> No change in behavior with this change.

Ok, I guess we can rule out system suspend then, does commenting out
the call to hci_suspend_dev makes it works again? If it does it means
the device is suspending and it appears the likes of
HCI_FLT_CONN_SETUP either doesn't work or is not being set to the
controller to allow incoming connections, since it is an Audio device
I think the problem is that we don't set HCI_CONN_FLAG_REMOTE_WAKEUP,
only input device do set it, so we may need to treat device suspend
and system suspend differently.

--=20
Luiz Augusto von Dentz
