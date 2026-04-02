Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809523F1658
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151505; cv=pass; b=Hgax4IftfGEXXz3NCxEPY8uk1AvdEIk5YDETOCTxs+KhyYDmXN1c8T8Hmefsi/8SvX+CnelzKeJ8q2f0oMQuDOM/xylMauIsNCYTa0PlOJxQeecYXHSIviwtp5r+IBXlz0kFCzWfPrxRcBexo0CbL/N39QzUnl06c/pFjUo10Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151505; c=relaxed/simple;
	bh=SzbJwTXRZXsBVnSpx7j3Af64jKPyKHqsQ9mhZ3LlPzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NW7Ewe7ksOgDRJelH9n/3zxpFn+AIcSLfvG9lqquJVZgYztO/i/1XijwxX0hwfyLIWozTTY/J9IUXptnstyan9nQVin4yajAlKRu8A/yqmmGknktiD+YjldCXGU/DYWm1Q1q3GKJtU+1VR0mXpuky5ACOOCBz5Aw5Jadlrrfbbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8TUKeOo; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8TUKeOo"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-650152687c8so1229271d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 10:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775151497; cv=none;
        d=google.com; s=arc-20240605;
        b=VOqNTvwEn6dDE6jVYfBJ3YyEEW91VEN01sWcnbnf+diK0MlbhVYvGN9PUGBZripXDj
         7gZZMrPlb/ujn8To/dI9OPOmv7WgT10vm+dxeZS+UzgiAx01EKNzJ3ItlTR5jD+BRPtt
         KP+MTDBaCTBdv1rvOsxkcy5QkygqdqHx7zb6Uknw/E9f58ugpBqfFX3VwutsPy2rIc88
         rU8AkqlZQo2ui+IynHGDMEuorz2ET384X3GR/bSGpIOMKV/+EqB4X51UzoecUwl/yujW
         QpN5sCVt5RxApeOrckGD7Kt2LL5/mcQK8O6Qu9Y4gyMB3zItsUAzD0xAVCzU+164LP2J
         GfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lpumUzlPo0nRNIUD9t4oRBFl+zm528JCX67OfIWxSVE=;
        fh=vmWSazVVLzanhlshhwyzmpIyejn+dDTBv2FHGOZnY84=;
        b=ZV10UII4hWjBmPUOedM7iKcH//fMLduvHr8BvnzbHB0+jcDEoTxD3b+QMqz9DxhY2l
         Fgr4mPdEsDzBScpcb91HciI8Q3bTHbT0P2IY8aoeesW4nd84ib/feOqHTql1ww4BcWlr
         jAvbqnKcF5bwoLczdrnrmKQEAnMCmeqjGkOHUlvktI26BWVuVO/TIcAasye45reFgHUm
         62WtnlA+9FP8fANgs6lBMz+VvNTsn1xQna0tysYyINFYWLToArz/XJUroo+G0jjnjbKY
         5HA1OV9N69MMioNmH+8D0jayoP+yF28FWbOLG0yky2pi7fHHvqyi8f0k3NhGRbkbaN/C
         kEng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775151497; x=1775756297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpumUzlPo0nRNIUD9t4oRBFl+zm528JCX67OfIWxSVE=;
        b=P8TUKeOocbr/49n7e+vm3L6tJQZixVRvuOLJ6FYfyO8NAgv5wf19zuFj+LPtMWnPbU
         wj0fJZfTAYHzx/RNpO3Jnklfl3njVszi/wlbG8enaZ0t4jZATVAqyRUn0Y8byBFCg6ll
         upsL1Ew3Y/r6jhuk2etpb1WcG+524mOrZ1Aipi7PXXhUcwgS4uGTe9W84sKirz70tHXF
         RuUP2+sGVBiZ5DAapo+ysHM+v9YKXVLTO105ROBZ1uWvOv0CaOMn1wpCPw0HQTPXQh7s
         4yXY5GwreQSB8L3LR0okcZ6+uOlVVTG0TO/gJINlS2YFNcJLWzPNcWpGlnS++V8YSN1H
         1Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151497; x=1775756297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lpumUzlPo0nRNIUD9t4oRBFl+zm528JCX67OfIWxSVE=;
        b=euEbKstkCDRxQbztR1DnAhK6jRVpz9bYgfapLcaxtao35vRQwZJS6kB/iqAagUxkYm
         9z8FFAeFbq2l8xJH5rw9i8tRrTNk82lzrrZ3K3ge//s3AVW/kudq84P3JUgODn3ktR0h
         TT24JS5mDN9NdH++6nXabCS6mgz9HL+jGXXskMFjPP0r9KxbPcj0mmaxX9z6XcZSNkHR
         agdwrxEKPnPjkNd4gQjbKzyilumAL+zuYGRDPDfCr07p1d2MQGE7ChiJZ0RlrrXWhuoh
         DrYDYcGN6MXJkvriXsmsCTGO9slP5oDT/FMilymtvfW25Ie0aupAxPKai91LQ0ZiF8sk
         hdjw==
X-Forwarded-Encrypted: i=1; AJvYcCVA6bzSL4HSkApm5h7GkqvxA/yT+a1VbuCnul1kS/yrEmTqSbUqAUqe0zZE97dfskSyBAog8ESjUE7XRlPZSYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKcKk9Hbg4gQAnU6gJ78YFp/mXvRvOp8IHLngw6X+fC5GrZhg
	ckVlfUID1R1hBf6Npn5ynCCemUzmJdhmaB85a0bVuaJef5c7Z3xE51QLJEy+PdpI6wtyT/D+Daq
	BwyYCQtlR9QDnTUqfMYkoq8atq5Kp1i8=
X-Gm-Gg: AeBDies9aih97zLyK+ItYo4UDKy+J5mKPhLphle7IDHjoD5VGCvPLCY8NtJNCrT2McP
	5PkaAGtOktIXb26ZK/etFeor16P41W0+fCTGiywiwapZK91xwmrXYS4KbYj3ouSs6avQzhv0oyg
	yQhxASVr+S6t/gekkg2Y8/xvR4LHL41b4A1jbj9ZGoDaR/+UwZkY83jxHq4TFfodxoAmCsT3YA1
	R+beWGDEXIG3RJRDvx3TWFJJw0slY6897kwVfKsX9VnxjefZbyQtMKELvQM9zWsSC+8LumTqqd3
	dG5iHJvQyrYPc5zbRVxMx1Nc4X6hmYuG40DSyknBLpTLeIF+oT6WyuQUibLNeNXoBdqVOw==
X-Received: by 2002:a05:690e:130a:b0:64e:8d4a:d0c with SMTP id
 956f58d0204a3-6503bb72ba9mr3642415d50.31.1775151497414; Thu, 02 Apr 2026
 10:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771930508.git.stefano.r@variscite.com> <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
 <acp0-qWerjms3n5U@Lord-Beerus.station>
In-Reply-To: <acp0-qWerjms3n5U@Lord-Beerus.station>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Apr 2026 13:38:06 -0400
X-Gm-Features: AQROBzDGF5hm1kQ9UTfuGvBZjmmHfu6BSh2_5Rfsnx7KwaHncTIYco-FWsKxtZs
Message-ID: <CABBYNZJFW8Y-HcvS_tVtfi6ySPmGjPP7EHutpr_p3DyCkfhYfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN
 for WL183x
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	pierluigi.p@variscite.com, Stefano Radaelli <stefano.r@variscite.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefano,

On Mon, Mar 30, 2026 at 9:05=E2=80=AFAM Stefano Radaelli
<stefano.radaelli21@gmail.com> wrote:
>
> Hi,
>
> On Tue, Feb 24, 2026 at 12:12:35PM +0100, Stefano Radaelli wrote:
> > From: Stefano Radaelli <stefano.r@variscite.com>
> >
> > TI WL183x controllers advertise support for the HCI Enhanced Setup
> > Synchronous Connection command, but SCO setup fails when the enhanced
> > path is used. The only working configuration is to fall back to the
> > legacy HCI Setup Synchronous Connection (0x0028).
> >
> > This matches the scenario described in commit 05abad857277
> > ("Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk")=
.
> >
> > Enable HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN automatically for
> > devices compatible with:
> >   - ti,wl1831-st
> >   - ti,wl1835-st
> >   - ti,wl1837-st
> >
> > Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> > ---
> > v1->v2:
> >  -
> >
> >  drivers/bluetooth/hci_ll.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> > index 91acf24f1ef5..6f060eec3b81 100644
> > --- a/drivers/bluetooth/hci_ll.c
> > +++ b/drivers/bluetooth/hci_ll.c
> > @@ -68,6 +68,7 @@ struct ll_device {
> >       struct gpio_desc *enable_gpio;
> >       struct clk *ext_clk;
> >       bdaddr_t bdaddr;
> > +     bool broken_enhanced_setup;
> >  };
> >
> >  struct ll_struct {
> > @@ -656,6 +657,10 @@ static int ll_setup(struct hci_uart *hu)
> >                       hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR)=
;
> >       }
> >
> > +     if (lldev->broken_enhanced_setup)
> > +             hci_set_quirk(hu->hdev,
> > +                           HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
> > +
> >       /* Operational speed if any */
> >       if (hu->oper_speed)
> >               speed =3D hu->oper_speed;
> > @@ -710,6 +715,11 @@ static int hci_ti_probe(struct serdev_device *serd=
ev)
> >       of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed=
);
> >       hci_uart_set_speeds(hu, 115200, max_speed);
> >
> > +     if (of_device_is_compatible(serdev->dev.of_node, "ti,wl1831-st") =
||
> > +         of_device_is_compatible(serdev->dev.of_node, "ti,wl1835-st") =
||
> > +         of_device_is_compatible(serdev->dev.of_node, "ti,wl1837-st"))
> > +             lldev->broken_enhanced_setup =3D true;
> > +
> >       /* optional BD address from nvram */
> >       bdaddr_cell =3D nvmem_cell_get(&serdev->dev, "bd-address");
> >       if (IS_ERR(bdaddr_cell)) {
> > --
> > 2.47.3
> >
>
> I noticed that this patch has not received feedback and is now marked as
> archived in patchwork.
>
> I also saw that the CI reported some test failures (e.g. mgmt-tester and
> others), and I was wondering if this might be the reason why it has not
> been considered.
>
> Could you please let me know if I should address those issues or if any
> changes are needed for this patch?

Please resend.

> Thanks,
> Stefano



--=20
Luiz Augusto von Dentz
