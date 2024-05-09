Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD11292E6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293412; cv=none; b=g7GXZyZzpslVP3wyDNPwo7lYSAXiPIdZxgicFDBMxzIAlH7J++oNmXnZZ9ZkTW6cAwiFGWywY7Qwr6PQQmEujG2LGRtquKmvB4h3lkLVIpQRKAfmwkuZPN8IY7xl8NFHvb6Y/PA6I+1Fwio2CO5DZkann1kcFiV3uercyzwoWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293412; c=relaxed/simple;
	bh=ujtHeXGGZ+idJFPVBlDBxelVhiQm6qMxCY59RV0nu7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYXnCdmVHelAMx4qEPAcy9gd874z2pMOzSr37yVMGiEd9v8qxdm3TEI7ttRZ6/X9rViCQoI/3OWRSA3DR/cahIV/j+fMblMBwaQIPuTMP4+QyHVB9bQ5h+556rF2KA2+qOECyhot4wlyw0l4EKf/mNmKxaPn1orCNKDnoY5hrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFHsoJ6A; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFHsoJ6A"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e3e18c23f9so17882771fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715293409; x=1715898209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkAPHuFAqgVKkwPXOmVKd4nEJl7twGAILgmFeDyg/14=;
        b=hFHsoJ6Ap+uyGZocI77ONQ4N8Cag082eddbgDSYVns24hiEGjknsXaM9uRdjKSgX+K
         kNhBs5XtS4YrNnXyxFbWY7VyRbgFOooA7AsyDqWWYJZAcF6FYmO/84l+CAQsKHZ4QsJe
         C+t2BwsUqIX9poDAB7E3xD6Vj2g1JeoeVOivehQ3ijClQnc/7XqtzD/Pg3ksTZVcG9It
         Dl6dQAexwzNl6mH6jWj/NdU6wWRXvGmMyQWy3OCMZXgRtG6YT/0D2dRE96E/uU+cVVOG
         qfKtXnZ+dhBph+P4Z5qaYz28/6gv0eyIhvZ298tNM7jGUsRjZk2XsxEvdzFKKULO/cgi
         yohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715293409; x=1715898209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkAPHuFAqgVKkwPXOmVKd4nEJl7twGAILgmFeDyg/14=;
        b=wxUZmh7fLzu2zsIv6qUwq61uHSt/xJNtt72zB9QOmub026iQT/3f5vjjNmxZ+uoHmP
         kmiR8cuMSSKtCNPtEbc+UqnNJeBRgqKFweM+6OSKvm5ffWtVbBI/jU8O+BpEeW4zRoFN
         55jLlDLveIYv022WoXx+PFU1AquzovXlItDgA1d3pDKOXdb8Oqo9YobDsQ+Kd4p9qF13
         7EoUMeu3XFLSFLOxD1l0SVsas1f+mYEcMHQ9qMGPKuvWVfo9Kd0eK9X0Xc4mYMONTQ9Q
         SfujnxqdeSmbwxBiLHPc3oDUM7Q/kBQ9lByjyXxUVfC41+RYUObWNWMPI4WBY2OzoZJ/
         Yp+g==
X-Gm-Message-State: AOJu0YwFzHzQPntnHz5tTrKDBTSp/+sqJcvMTwCyREB/9M+MtS4gurWc
	8CQ4xnldSIhEAmKSZo5PpUuXHaSS7d1wLOS+YE1ujwQR33ipflxKGIQ0rLkjSQ4TRouhsikuPmx
	6ACn0Fe1dmT6kdyVUARTCA18XQQynIA==
X-Google-Smtp-Source: AGHT+IGLe/J80f0oxe7aMe45qxKdLEoNXDk0U0AAhmjA3BkH7bcJsQ9vyZ7yq8lTCRIWXKTsxD3HDmYrA53UkViRG2c=
X-Received: by 2002:a2e:9253:0:b0:2e2:a0f0:4e74 with SMTP id
 38308e7fff4ca-2e5203a44b5mr3717461fa.52.1715293408869; Thu, 09 May 2024
 15:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
 <Zjz0atzRhFykROM9@robin> <CABBYNZLMODHp+jBu2oVDC5Pg6fyAKJugQF0N-XgarjWQJJPObg@mail.gmail.com>
 <Zj0tcmseJCjR4hK2@robin>
In-Reply-To: <Zj0tcmseJCjR4hK2@robin>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 May 2024 18:23:15 -0400
Message-ID: <CABBYNZLnYz-vPrMbtsJTsLPsyo62j+cxctSkLjRom3bWEU9N3A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
To: Janne Grunau <j@jannau.net>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Janne,

On Thu, May 9, 2024 at 4:09=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:
>
> On Thu, May 09, 2024 at 12:30:21PM -0400, Luiz Augusto von Dentz wrote:
> > Hi Janne,
> >
> > On Thu, May 9, 2024 at 12:06=E2=80=AFPM Janne Grunau <j@jannau.net> wro=
te:
> > >
> > > Hej,
> > >
> > > On Fri, Apr 05, 2024 at 04:40:33PM -0400, Luiz Augusto von Dentz wrot=
e:
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > The extended advertising reports do report the PHYs so this store t=
hen
> > > > in hci_conn so it can be later used in hci_le_ext_create_conn_sync =
to
> > > > narrow the PHYs to be scanned since the controller will also perfor=
m a
> > > > scan having a smaller set of PHYs shall reduce the time it takes to
> > > > find and connect peers.
> > > >
> > > > Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by def=
ault")
> > >
> > > This commit in v6.8.9 apparently has regressed connecting to LE devic=
es
> > > like Logitech mices with Apple/Broadcom BCM4388 devices. Those device=
s
> > > carry HCI_QUIRK_BROKEN_LE_CODED which became necessary after 288c9022=
4eec
> > > ("Bluetooth: Enable all supported LE PHY by default").
> > > Tested so far only by reverting aaf06285498861d6caaff5b26d30af70dd2b8=
19f
> > > on top of v6.8.9. Looking at the change I don't see anything obvious
> > > which would explain the breakage.
> > > I would assume v6.9-rc6 is affected as well but I haven't tested this
> > > yet.
> >
> > Would be great if you provide the HCI trace to confirm the problem.
>
> looks like there is an issue with initiating "LE Extended Create
> Connection":
>
> | > HCI Event: LE Meta Event (0x3e) plen 26
> |       LE Extended Advertising Report (0x0d)
> |         Num reports: 1
> |         Entry 0
> |           Event type: 0x2515
> |             Props: 0x0015
> |               Connectable
> |               Directed
> |               Use legacy advertising PDUs
> |             Data status: Complete
> |             Reserved (0x2500)
> |          Legacy PDU Type: Reserved (0x2515)
> |           Address type: Random (0x01)
> |           Address: DF:F4:9E:F3:A9:72 (Static)
> |           Primary PHY: Reserved

Looks like broadcom is using Reserved value as primary PHY, no wonder
it doesn't work, real piece of art that broadcom and apple manage to
produce and it is not only the PHY that has out of the spec result
other fields are affected as well.

> |           Secondary PHY: No packets
> |           SID: no ADI field (0xff)
> |           TX power: 127 dBm
> |           RSSI: -60 dBm (0xc4)
> |           Periodic advertising interval: 0.00 msec (0x0000)
> |           Direct address type: Public (0x00)
> |           Direct address: 5C:1B:F4:7F:BF:6B (Apple, Inc.)
> |           Data length: 0x00
> | < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
> |         Extended scan: Disabled (0x00)
> |         Filter duplicates: Disabled (0x00)
> |         Duration: 0 msec (0x0000)
> |         Period: 0.00 sec (0x0000)
> | > HCI Event: Command Complete (0x0e) plen 4
> |       LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
> |         Status: Success (0x00)
> | < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 10
> |         Filter policy: Accept list is not used (0x00)
> |         Own address type: Public (0x00)
> |         Peer address type: Random (0x01)
> |         Peer address: DF:F4:9E:F3:A9:72 (Static)
> |         Initiating PHYs: 0x00
> | > HCI Event: Command Status (0x0f) plen 4
> |       LE Extended Create Connection (0x08|0x0043) ncmd 1
> |        Status: Unsupported Feature or Parameter Value (0x11)
>
> Full trace attached
>
> Janne



--=20
Luiz Augusto von Dentz
