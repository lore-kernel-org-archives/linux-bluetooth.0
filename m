Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF593DD87A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416900; cv=none; b=eK/puNBDEcKDFizZ2THi9TF9q5/hNPwRnCzWrT6FHkHNQIzeQ9EvLHKY3j3D4aPPfX2OTMqbPybtr0eT1Wy94EGcF9Cp2J9+xzU7GjlIThihQYPEh7LY66ka+GLPp6+Ur+/Whi62qF/Yc+HBYpTzmikuQjr++rjv7fD/To79FVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416900; c=relaxed/simple;
	bh=lL1zHR2IFb+gPf8hWQ++nvFThHcVEYvzC0CHBXvFRq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxWGv5m8jEB+2p6FOvamrIqy9J+hDnvnkg1f82V7YqEiaA5n9kXFGfya/wfsCFqZ/zkF8gERBA08jaRPScW74n/vNfgKKdsRPU1RU2KfZN/Fzc9GuSqt3nZn1lf0ajAoa/TxFtprOd5/yocuDba9YwZ51Lu+q4Xrb/3qOju+wO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI6jObQh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI6jObQh"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8422c327755so1588288b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780416898; x=1781021698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xGmhscCRZ5kqGIMs9rnifmd/lKYyPDpcb87Wiw54uy4=;
        b=KI6jObQhtoGUhJrZlFmliEFHcAnEPxgHTJulk+kEC7DUl1sor5QRNxafszVRQ7kHXJ
         r+/nwQyT87TdYCMSOllNjysPidn1kjLckJmDzgOWn2giMoFpXlyTfuFUuECgCDYGDy4t
         3ai/X+kU2UaiTRKbkneG9KeBtXriKR+9QLHEbzwD9Ryx0o0XZbqY6a+x6BHi5AAjYheA
         R5RY0okCkBMOBFYRpBkQXWzWjhGH4uUSPdISNU6KrvJfbTzZhsahibK/AeT4+mU+NN2Q
         R8iKxAjO3Vx5pcJtLN5LbCuKDZylnnbE8su/dBa4rpOJVC4J63w89l1wImtASHh5L2xp
         WXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416898; x=1781021698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGmhscCRZ5kqGIMs9rnifmd/lKYyPDpcb87Wiw54uy4=;
        b=a9iVHw0fX43YHijjFDtjiQwIXQ1NoH0xPy0GsFKTTR2emBeV8l4UejL41kxHuOrehP
         lnL56V4gzeU657DLopgspK7k3s36VKGYzmZtJg3jT8ZlyRta9L9tC8iPtwRxomyilmeH
         j1hyOr0tsq2IHuVr5Yhd7Q7F9WP75W1CfJ5UIWpHumXDgDnri8T5RKMWt56cGO/68VRp
         KKwwDDZ4JKd2h4FnvbjC0tMu3NCQh/utIURcBJhn8oLObovqhgFqAhcOr7fB1nXhzCDR
         EJMxdkNUodAe5wzRv/FB+iwMwp/ilITWS9vnj7jBLJpN2sVq3o3p8oR0+BYcSf8C2XBs
         OgHQ==
X-Gm-Message-State: AOJu0YzJURrIo3N3u5vbJvLy69CNqM+FQHaO+CxQQQbUAe/WHsSFsY66
	DREQ3KSYrz+SAW60NdaxMNfGZZTFhV5bWp70zT4qHRBDKK5Ie88aPELo
X-Gm-Gg: Acq92OEz1CYjl5h8aMOflmXUxZWF+TyAjWZo8H5709VH+4wrisVlVV/79jgAbCXY2U7
	tmJwFfTcpWuqyHN2GwYtfAHL1dKY7Z0LE/bekOxcpAs5EXBZUPHbd0BRAaIxG3qhZ4+jCEiDcuO
	YoEi1m+8dUaFv4JzuT1o6oC0XqOhEZs/fi1fxT+dqodwuV1YmCQ+vWqxVh69uDWxaAacczg5D8M
	php7TZUWQ4HLLTwWwfVXhwqqBusfxVSFl1wWsIvqZQKnK2l8H1LwA6wepiFBTOkQyKGY7vGABkJ
	BiL1pG/eUDaDrfBn9XKjW+f1It6YTfNuESB+HD90T/2CSPt5WwOoT01iOlePkbE7e/9g3oZkn7g
	Y7Y7HsByKuXg4nYXRZPqsBlqjsYVLtKWv4e1L7GJ3HzkDVX8v/lk4jlLHOf45IbAPw82I15dECO
	WBPkl7E+GJhdEQKJFUitBRquqM0IpsUqg/N4qHOCfxC3+FLlpYkmwoH41UiiJvyw==
X-Received: by 2002:a05:6a00:400d:b0:842:6004:3fd4 with SMTP id d2e1a72fcca58-8428310e867mr200503b3a.24.1780416897881;
        Tue, 02 Jun 2026 09:14:57 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428235006dsm277081b3a.13.2026.06.02.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:14:57 -0700 (PDT)
Date: Wed, 3 Jun 2026 00:14:51 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bluetooth] Bluetooth: eir: Fix stack OOB write in
 eir_create_adv_data()
Message-ID: <ah8Be0zMOU7OOMI_@Air.local>
References: <20260601162203.1253918-2-xmei5@asu.edu>
 <CABBYNZKmodLjPqOCtmY9R-4OccC2vBV=pDQfwY9vCFbwZo+LtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKmodLjPqOCtmY9R-4OccC2vBV=pDQfwY9vCFbwZo+LtQ@mail.gmail.com>

On 26-06-01 13:38, Luiz Augusto von Dentz wrote:
> Hi Xiang,
> 
> On Mon, Jun 1, 2026 at 12:22 PM Xiang Mei <bestswngs@gmail.com> wrote:
> >
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > eir_create_adv_data() builds the advertising data into a fixed-size
> > buffer of "size" bytes (31 for the legacy path in hci_set_adv_data_sync()).
> > It may prepend a 3-byte "Flags" AD structure, but the per-instance
> > advertising data is then copied without checking that it still fits:
> >
> > skip_flags:
> >         if (adv) {
> >                 memcpy(ptr, adv->adv_data, adv->adv_data_len);
> >
> > The "Flags" structure is added whenever BR/EDR is disabled
> > (LE_AD_NO_BREDR), which is the normal state for an LE-only controller.
> > However, the mgmt length validator tlv_data_max_len() only reserves
> > those 3 bytes when the user-supplied adv_flags carries a managed-flags
> > bit (DISCOV / LIMITED_DISCOV / MANAGED_FLAGS). Adding an instance with
> > flags == 0 reserves nothing, so adv_data_len is accepted up to the full
> > buffer size. At advertise time the 3 flag bytes are still prepended,
> > and the subsequent memcpy() writes 3 + adv_data_len bytes into the
> > size-byte buffer, overflowing it by the attacker-controlled tail of
> > adv_data:
> >
> >   BUG: KASAN: stack-out-of-bounds in eir_create_adv_data (net/bluetooth/eir.c:302)
> >   Write of size 31 at addr ffff88800b7e7bac by task kworker/u9:0/51
> >   Workqueue: hci0 hci_cmd_sync_work
> >    __asan_memcpy (mm/kasan/shadow.c:106)
> >    eir_create_adv_data (net/bluetooth/eir.c:302)
> >    hci_update_adv_data_sync (net/bluetooth/hci_sync.c:1689)
> >    hci_schedule_adv_instance_sync (net/bluetooth/hci_sync.c:2015)
> >    hci_cmd_sync_work (net/bluetooth/hci_sync.c:332)
> >   This frame has 1 object:
> >    [32, 64) 'cp'
> 
> Add the btmon trace of the MGMT command when this is triggered, and
> explaing how the advertisement was created, as with bluetoothd?
> 
> > The inconsistency dates back to when the managed "Flags" field was first
> > added to the Add Advertising path: the prepended LE_AD_NO_BREDR flag does
> > not depend on the user-supplied adv_flags, but tlv_data_is_valid() only
> > reserved room when MGMT_ADV_FLAG_DISCOV was set. Commit 47c03902269a
> > ("Bluetooth: eir: Fix possible crashes on eir_create_adv_data") later
> > added the "size" argument and bounds-checked the "Flags" and "Tx Power"
> > AD structures, but left this copy unguarded. Guard it the same way so
> > the data is only copied when it fits.
> >
> > The bug is reachable by a local user with CAP_NET_ADMIN that owns an
> > LE-only controller using the legacy advertising path.
> >
> > Fixes: b44133ff03be ("Bluetooth: Support the "discoverable" adv flag")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  net/bluetooth/eir.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
> > index 3f72111ba651..e574f8f61e16 100644
> > --- a/net/bluetooth/eir.c
> > +++ b/net/bluetooth/eir.c
> > @@ -297,7 +297,7 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
> >         }
> >
> >  skip_flags:
> > -       if (adv) {
> > +       if (adv && ad_len + adv->adv_data_len <= size) {
> 
> So we have 2 options: 1) Don't add flags if there is no space, or 2)
> Don't add the user provided data. We should probably choose option 1,
> not option 2 since option 2 probably means the advertisement is
> useless.
> 
> >                 memcpy(ptr, adv->adv_data, adv->adv_data_len);
> >                 ad_len += adv->adv_data_len;
> >                 ptr += adv->adv_data_len;
> > --
> > 2.43.0
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

Thanks. Agreed on option 1. I'll send v2 implementing that shortly.
