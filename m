Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03328331ED2
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460534; cv=pass; b=YikjBibmq6KdG2LME2LW5yLEWyqOIlRGcKC30cUwTyajaQeAzEauij1eAmzDlI9zbCKgII2X2xyGAyQLAPZclG3s9gmB86DrTcV1ZRrtofnByw+XnApW5t17FV45RUpZMIWNrBBwRhlcoMdC2DVkkncRVW0iTvCwi97E+CY6dxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460534; c=relaxed/simple;
	bh=j4vbTkMHrqahFcFEYeT5VCU61Ma6CvquGXAoLyjKjpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZqhXZPyFNrfT0dO3BLD0jYKxbCrao9l5OrQuJRK+LlYEWm1EU8zCaDmwsTdEEmvUlyESKP81aKYKaOJBURMSxY89L3bGbII8MCJ5fTQLeAk8ifDtcQGi1PQiczME020EfDIUxRhLhcXkHy5Kl157BAUFff1jK4oE7zKu7nYtfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nreC9w+8; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nreC9w+8"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e9f7491ffso43793627b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786460532; cv=none;
        d=google.com; s=arc-20260327;
        b=cZ2lZpN2La4sJR33VHu3drGTWqb1KPIyibEamQ+VVFca0RB2FowGduXFSCi+3QSLfB
         YtFXpth13STXAT60404ouvKFRy1e7gt9kVPd/JfXJAkQ46kRvMbzwd0uly3xbJhUTXIn
         4wRXM04mr2eZeWZUpFUwPk9VS/r9l+FUgxEb0srfn7XdMGQW42vKbCqnVVTD2N7O1MfO
         E+jiI7C4ynH1R2JF7j8Z5SOky8v5rLaQ3MxGgdavyu5aTNg9MXCL2FzEFEZrFONujsRA
         vFZ1LyPtuJRSnIjmY8xhDch047qkgFRyNdmO3tZK62d6cgB8157squ2WBL53P+Mr4HvZ
         TNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DOFGdGD/+2nP6RQWzZ2s2mHQTcJH8q2oU5hHFRYmAkY=;
        fh=tjmbpJMjMK1/ssswgOSgZ+FtqYhLBowA+FQh1IEwcr4=;
        b=kMCcbq5UzlmL3PVjopqSwL5OXNbhngjYnB8a7A6aQ0d/Q3zReuZtqciXUDQycSQ8aK
         ET+BhnO8exlhJcj4gAM08G9bjCDXdS+w/hiejQup31Nkqoey8T/IGyiHp2r5JEc+FgZ3
         A9h04xQBwpNuIn2MslOPgnPN33oS1Tj0xB/PfJIY2vLjGVDQwDSMKz+qqoKum8Iu7d/w
         SHIicIA0bXb3Vk4InetPSQ51rUKQ80WahWFuedx/zB3OzoYoV2aceVBlnl2PQLCCaqHV
         lnN+VHo2fzccvV/J3TjjuQF5PCspEaKzCqoxOSbLG7myJ+a1u2R8JnTp/bKp8TqXGy+H
         nH8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786460532; x=1787065332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DOFGdGD/+2nP6RQWzZ2s2mHQTcJH8q2oU5hHFRYmAkY=;
        b=nreC9w+8mbwcmAzCTMzQ+kg4JRjBD6fexMUvdbe2BD3y/UqIiu4ZkpLcU8o007LcS5
         IO3k5POj0JPLJuX2EEbPayeAF0TOpLuHfWfsUYF5S+WamMYBw6eFyF6pujow3PIAoZ+U
         IjMlCixpxFtxTT/omasGzsMqUPZ7TqWj2rGHaO3qLGQUg1FN592r6SqFztSU2+6i3TkZ
         o6B9AYocblNvq94G0wv5OKSAEOTXMa4tSDFXzpTzImwmj8+Z0vzFvt0Fp70Luyc95nRP
         mVcnMpsEYtrAfDidFvUayUlMFZnE5b95p2AWpYErtCWpODIRz5mzjsNtT6DKntf1KiI3
         n4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786460532; x=1787065332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOFGdGD/+2nP6RQWzZ2s2mHQTcJH8q2oU5hHFRYmAkY=;
        b=YKeATGBPYPHdpNDlcwTHUhoTjRS9O+aBbPzDnZ9uryYYpshvJLo7o2GJOJNVGV0VAG
         gSFC75Zxt3AMjANPbvWCfIrA5k3Ah9/C5iX+VPy51TaEoqstMsvrlUDjGLHM9mYF1Lpr
         nDlogYX2Dae6EAb8OqpKBY5kymhpuEGt7NuL7wxCbzp9NGyRW/RbbJavcpNTZ8yQn+RQ
         Zyn2RLIZjDkTtwm6qpp+mdvwSCGMsu2GLqA98f0SJXHV5h+E8mV80XQiT1gYjzFvGoOS
         hjrYbGoU0setzmuYW8T5M31Ay5odPG2A8D341lr/rc2OLmxGYeloCLJS5oipuemIbToS
         sH4A==
X-Forwarded-Encrypted: i=1; AHgh+RruilCFgG1DW3CC3/ir0whRO0i5OlXhMSBluCrKCs12p4tvVpID+HdT9+BkuWndtvfLIIJRxwduLiNmCAPf7xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTDHqaeCN+FU+dOEjzgn/HN5f4jbncULygf6YlFWMmwCkLmjV
	tvooAz8XqUWxIJ6el+P2NbHB+ohSNoZuja2rFezjdQTDQRT0E0Vgq6m+C/gY8Ci8+meswCfQ4Yy
	cfAvEXhJDUnPav3Nclo0zGvLn4lmSsM4=
X-Gm-Gg: AR+sD12Cb2lT0ZHbyHbCuzK8MdiogTh4kQjVEQi4bFCahMhVsY7HMyWmTOqeamuOoqU
	WrCbLxPRvptMRi8A28m1NvGbUEb2oXSghLnnwNK+dwfCzsRBggqYDl694iFr5YOL+rfXkP0+1/p
	JKt3CKko9zH0b3xZ/MB+Yj5Ff0YPvOkGC9oR8Kt4tBxGphxc5mdw+BlzIE+TeRZiDTqTiNsbKXS
	0KiULnEMHHgH6UoeQLiFZHQnHgMsKbhcU9oF4S04xehCRqAQpXsjD1+VRbOf1uDCoUp7t1pTw2L
	dAr0ynmkJaE3oVpe0G2Jv+QBzMxP/z/Fxd6fWgvi4gqLXNmTz7tgqkHYJ1Ia7d85iMFJWCrdzmj
	cFNYbXjfoUJ8EJqDaHVyiR7JuE6inb2Q=
X-Received: by 2002:a05:690c:88:b0:7ff:1399:9317 with SMTP id
 00721157ae682-8303dc941b6mr6987997b3.11.1786460531677; Tue, 11 Aug 2026
 08:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <anpxFdwNxk0XwPjQ@makrotopia.org> <2026081139-strenuous-greasily-f4e5@gregkh>
 <cb0d42dd-4755-49a8-8a05-297e4283914e@oss.qualcomm.com> <2026081133-crazy-enquirer-97ce@gregkh>
 <154779e8-5f73-4f3e-8618-104effb85538@oss.qualcomm.com>
In-Reply-To: <154779e8-5f73-4f3e-8618-104effb85538@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Aug 2026 11:01:58 -0400
X-Gm-Features: AUfX_mxYe-nElnQSrdmasbUvVVMeEoXpj9A_1Sq8Txj9OmoMmXB5_-_tVdXTCcc
Message-ID: <CABBYNZLHnKnorEbp=LuxcvCUBOpoKHZbV=R9DYzjJyOiFUU06A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] device_schedule_reprobe(): core helper and conversions
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Golle <daniel@makrotopia.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, 
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, Kiran K <kiran.k@intel.com>, 
	ChandraShekar <chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Aug 11, 2026 at 4:51=E2=80=AFAM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 11-Aug-26 10:07, Greg Kroah-Hartman wrote:
> > On Tue, Aug 11, 2026 at 09:32:45AM +0200, Hans de Goede wrote:
> >> Hi Greg,
> >>
> >> On 11-Aug-26 04:33, Greg Kroah-Hartman wrote:
> >>> On Tue, Aug 11, 2026 at 01:47:17AM +0100, Daniel Golle wrote:
> >>>> Three in-tree drivers (iwlwifi, hci_h5, btintel_pcie) schedule a
> >>>> deferred re-probe of their own device from a work item in module
> >>>> text.
> >>>
> >>> That's a mess, why?  Why not fix that up to not do that?  Thousands o=
f
> >>> other kernel drivers do not do that, what makes these so special?
> >>
> >> I can only speak for the hci_h5 driver where I added the reprobe code-=
path.
> >>
> >> The problem is some of the Bluetooth HCI devices using hci_h5 loose al=
l
> >> state during system-suspend. This means that the HCI and the Bluetooth=
 core
> >> end up being out of sync.
> >>
> >> So we basically need to tear down and re-build everything including
> >> e.g. the firmware upload which happens at probe(). Doing a full reprob=
e
> >> is by far the easiest way to do this.
> >>
> >> I suspect the other 4 users + the pending driver which triggered
> >> this are similar.
> >
> > Full reprobe feels different than the THIS_MODULE stuff, which is what =
I
> > objected to here.
>
> Right, the helper from 1/4 to safely do reprobe from a worker actually
> removes the need for THIS_MODULE stuff :)
>
> The THIS_MODULE stuff in the open-coded implementations is there to
> avoid someone doing a rmmod while the reprobe is running. The new
> helper replaces this with some checks in the workqueue function
> checking the driver has not been rmmod-ed in the mean time.
>
> >> Sure we can do the whole tear-down + setup from some worker
> >> scheduled at resume, while keep the driver attached but if we need
> >> to duplicate that over 4 drivers + the pending driver which triggers
> >> this then IMHO those 5 users are a pattern which deserves having
> >> some helper to do this through the existing probe() + remove(),
> >> rather then requiring those 5 drivers to open code this themselves.
> >>
> >> Note that we already have device_reprobe(), which has 15 existing
> >> users. This series just adds a helper to do a device_reprobe() from
> >> a worker in a safe way.
> >
> > That feels a bit better, as long as this code really is "safe" :)
> >
> > So, how can this be tested and fixed up so it isn't a RFC anymore?
>
> To me it looks like the main things are:
>
> 1. Agree that a helper to safely do a device_reprobe() from a worker
> is helpful (I think this is done now?)
>
> 2. Get patch 1/4 reviewed. I can do an initial review but I'm not very
> familiar with the driver/device core internals.
>
> 3. Test this. I can test this on a hci_h5 BT HCI that will hit this
> code path.
>
> I'll try to get 2. and 3. done soon-ish.

The 2 Intel drivers are related; they are part of a combo Wi-Fi + BT
solution. This is why they attempt to reprobe each other to recover if
the entire system (not just wifi or bt) has run into a fault and needs
to be recovered as a whole.

As for introducing device_schedule_reprobe that seem to be a great
initiative, thanks for leading it.

--=20
Luiz Augusto von Dentz
