Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DAE1CCB51
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674800; cv=none; b=nc88bnuDigSWomO36BjGxJ7fuY/+rIJRtHLoXJ7EmlTLEw6x9NqXuPeB894dzx1xxSxidQJCWyDTnJ9sGRiUxYBJHOAktL6NmhoHmMS7up7TccW6odCFX+cEYvubhKp05mmRaK4LUolWghUp7VpMGwQ0IMOpkMHeoS+AQmfhT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674800; c=relaxed/simple;
	bh=n1cg2/8t64zyA77wzsQMHnfJqQZVIwqPmmR2fWXepHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORNBmCFVAjabgZq/xSRdznui/D/XQTTYGql7S+o+3mNCufdFbUW+HFN9By6jqYlqBwcW2xx0hVZYtz9PV91RYdQd8s7tuHfMgYTetyF7QmlWr6UGWWYcPpy2hYSHi1ENWcnrfZUxsLneFZYDvoh3pWw1wOXq/fj97so+KI0hCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbaAayW9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbaAayW9"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb3110b964so14061511fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728674797; x=1729279597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sP0VIkIY+itHzYYjO1rth+/1N5KeqGXh5g4fF3XRNg=;
        b=DbaAayW9DWpKeOVwyMFSO2RLBzn07kZXzg63R/fBrm7+Et1likVuN/qm0W4NdXH2SR
         KOMFovGm+686XiPkH6Dd79N+/2TkUf+klM0VBU26VYrlUwtzEyZsFC14zVUwN18fxkAu
         iN3svnlXb+5FoUXXJgK6qHzQ6kX7y0qrn6Eu3HJ55nRVBtGO/bHg5Y/evfrG7t2phNvK
         BQ4lw+LA6Clo9P5oPnZviH1a7+MwS7uYti0wb7w1IVToOaMK21VClJGaV/Ie6YnujJxb
         yuiaHscY1+RkHMAAcbV3sfGDBFXubVbjCnl11KlG4KFK23K0BK4ZeCcXBOSKGTAFbAKP
         x85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674797; x=1729279597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sP0VIkIY+itHzYYjO1rth+/1N5KeqGXh5g4fF3XRNg=;
        b=hrVlv+ULxOXmk3c0p+R6x2PcvcIhKUhdmMPBC0+nHpElPjlAU28t9pM+94UHKFXbin
         FWXjQ3ix4b38dVTCBN+a5FiBUYEV62bVnVt2cWJQVHD8MUWFL5HPyyVsB0dyZ1tbhN71
         U0yNWHOw5ZF+jqsQ/PaLVqB94pBM02+Z427E2ExdObo8BrjhkeH7I42KgEGhlWxvythy
         98ldm+5tP6/64JInCjcHpSYGK25JEbSr5sIz8r1nO/eripKXvWkc+N402Cl8T18Xbks3
         0hwFfr+dFTAkH9dCtJ+JqmQa2sh7IXMqZcLQhFdrlxxEY+8/XEgE5plas/tjbkAEjsFN
         WVDA==
X-Forwarded-Encrypted: i=1; AJvYcCWr5FQgeldCFZ5pLMreAPtD9USgR6yx9+Y2j1vescGU7D0hIc7aa0LgaYnaUHuUJylalOFqJnlBluBupcoqFPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinJqumFXUkcMDTvWETLn/CdAJK803FOxU9vOn8ygHatTvaVZ7
	nereV2Xr7lwy30AjjYct7mX+lFWy66AD6dhpUH41Z/wQu6iFS37rID45BeSN7FuKlQr+CWEgh55
	fAqEJHjO2vzZDyNTT70hZSuzvN20=
X-Google-Smtp-Source: AGHT+IFwyYC9Dhi8Hvvjv51iOMkEiS/rhodBsXryD2kYp3yk0kQXch6tXU7C1JxnISuxNjciuegswXnrNf+t1ho2uSY=
X-Received: by 2002:a05:651c:b0d:b0:2ee:974c:596f with SMTP id
 38308e7fff4ca-2fb3f2d1680mr4203301fa.28.1728674796307; Fri, 11 Oct 2024
 12:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
 <CABBYNZJMWni33VQ2sX9EDcNbsFbX7pjAFj4QLri9N7jyLY0HvQ@mail.gmail.com>
 <c8b5c842-463e-4c30-b7e0-f41bf1d59305@gmail.com> <CABBYNZ+kcwgPvCNFZHZZok_a6ZNXEPNABNefb4iaSNDNm4wPVA@mail.gmail.com>
In-Reply-To: <CABBYNZ+kcwgPvCNFZHZZok_a6ZNXEPNABNefb4iaSNDNm4wPVA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Oct 2024 15:26:23 -0400
Message-ID: <CABBYNZKbXE4unZi3MPP2LPzYcv0OLHoaqqey02N1qUzSR=4PhQ@mail.gmail.com>
Subject: Re: Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't
 fail external suspend requests")
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	BlueZ development <linux-bluetooth@vger.kernel.org>, Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Fri, Oct 11, 2024 at 3:05=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Heiner,
>
> On Fri, Oct 11, 2024 at 2:52=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail=
.com> wrote:
> >
> > On 11.10.2024 18:36, Luiz Augusto von Dentz wrote:
> > > Hi Heiner,
> > >
> > > On Fri, Oct 11, 2024 at 6:49=E2=80=AFAM Heiner Kallweit <hkallweit1@g=
mail.com> wrote:
> > >>
> > >> Since linux-next from Oct 4th my bt speaker fails to connect if I sw=
itch it on.
> > >> It just hangs trying. Manually connecting it via bluetoothctl works =
though.
> > >> With this patch reverted it auto-connects again.
> > >> If you need additional details, please let me know.
> > >
> > > I suspect something is trying to suspend the controller then, it
> > > shouldn't be USB auto-suspend since that should behave as it
> > > previously but if there is something externally (aka. userspace)
> > > trying to suspend then it will force it to suspend.
> > >
> > On the host side it's a combined WiFi/BT PCIe adapter (RTL8822CE).
> > Runtime PM is enabled, so this may kick in. I'm not aware of any
> > userspace tool which may try to suspend the WiFi/BT adapter.
> > Disabling Runtime PM may be a workaround, but I don't think that's
> > the actual solution.
> >
>
> Well I assume it still using USB as transport, not PCIe, otherwise it
> wouldn't be using btusb. Regarding runtime PM, I assume it still means
> PMSG_IS_AUTO Documentation/driver-api/usb/power-management.rst:
>
>      'External suspend calls should never be allowed to fail in this way,
>      only autosuspend calls.  The driver can tell them apart by applying
>      the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
>      ``suspend`` method; it will return True for internal PM events'
>
> --
> Luiz Augusto von Dentz

Perhaps there is a double call to the likes of hci_suspend_dev due to
system suspend and device suspend acting together, so maybe we need
something like the following:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 779c4aeaef22..c257759ae2f4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2812,7 +2812,7 @@ int hci_suspend_dev(struct hci_dev *hdev)

        /* Suspend should only act on when powered. */
        if (!hdev_is_powered(hdev) ||
-           hci_dev_test_flag(hdev, HCI_UNREGISTER))
+           hci_dev_test_flag(hdev, HCI_UNREGISTER) || hdev->suspended)
                return 0;

        /* If powering down don't attempt to suspend */
@@ -2843,7 +2843,7 @@ int hci_resume_dev(struct hci_dev *hdev)

        /* Resume should only act on when powered. */
        if (!hdev_is_powered(hdev) ||
-           hci_dev_test_flag(hdev, HCI_UNREGISTER))
+           hci_dev_test_flag(hdev, HCI_UNREGISTER) || !hdev->suspended)
                return 0;

        /* If powering down don't attempt to resume */


--=20
Luiz Augusto von Dentz
