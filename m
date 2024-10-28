Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8B1E1A25
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147610; cv=none; b=LaY5J7xuOBrQtYlmUm5VUy0LJJ5MBbEUK+SpIO+Ksix5IsatJv9jceFlwpojWjhErwwwKt7u4Q3QVNTtbpi87GvqIggv1OT/GXp5LGHw3NrIyBs25vgFRsZ5T9sxc3cyEdXR9ZKHAyNguHHtMwcw8ZbbZcmY/s1OnCSHioaqWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147610; c=relaxed/simple;
	bh=MKf1ybovE8O+VMbgMU8aqHdEgk/0KrJ3KpNRKnI0lhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYsdpjMKWj030rKv9SQQS0iqdsSpABFm6lyA0bt0mMecwV4XLWoUOIekp1N/WOsTDZMMij556/GQWv1ZC7Iw/Z3IV08JSzjx6gS1/6M4qmYHFhs6POLzFXAO6Tx/LhEdhGSvJR0taFrKjNxM9LlDnfZL0oBFMFDmbuNHD5T9s2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE3Y9d4T; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE3Y9d4T"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc1af9137so2550869eaf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730147607; x=1730752407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaMBFBUMZdn7/BAHvfDBXuU09JGy4R/6FLeD+A0CgsI=;
        b=UE3Y9d4TJXD2eUlP6G1FWzNOis41x3T3cUGuNJr+OG9Iw+4kD8rrHT/VKBfViQA495
         zxLGfoAgsd4nQIAJW9qxzVAqWAgyAxlbgIJf9E7VthUjwyYt/w4XTMcEw+xMRJlpUClK
         d7p8Yy7WcfEuwJGMlkItuWKEOFB1Wr2CcMvkMYcfPgPWaBnBsMEkJWPGtyYj6PfMuQP/
         N9u1b/jr5K3RQdql7oStAItdpFnEBbu3D1POPzece4YQbj7korCUVA7uoMkHbKLFRYwG
         Vq6JiiDNwMm7QJ+awwzGuwbDFC2U2QemnQjt4M5vCAgwNBF6LE8pEwpU/gacery29UUK
         J+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147607; x=1730752407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaMBFBUMZdn7/BAHvfDBXuU09JGy4R/6FLeD+A0CgsI=;
        b=VKoZSkvEbupxXe1rNMOEzCXW52PnzCEISm/YNVP10vlm6TyoNboYBgXhCmH0DJgdWj
         B2vy4uJ+By+M13+rICd4lbRXR0xQ97v/+AGShLRX/l1mCW1aSWvZ7Qhoj39J6e0VA0tR
         eXrzQBQc7WImttRw3cifUiZybzNjPR70i3A8sdT2UTVslqsdAL/k/Zfe9ztUc3bav/HQ
         tYJoFxDafUAU7wI/BMoFg5EQQTYZUqywT7yasTk1pCB7AnjPZWVbQnvKHvlvz/A5JW47
         AdKxBqaOgGhp9DlgsDE3yqRumpxZcCELjLtAgQvq4ZOzJHflAmEDyF72T3UaNLW2ZvI/
         5I2A==
X-Gm-Message-State: AOJu0YzKDeMJ+O3ISfEIwXZsKbRIayHutibj7dRcOAX6qXFDQ7p/faxW
	E6fB+L6W+2VrP0j6Ux8wzYk3+8SZOMMC2Vi5FnhnLpshaW5xU+mEHqtOmMYQUu43iiiVikpwb9a
	w/Yn3SGv4OxwnNArsigb7YIsLK6c=
X-Google-Smtp-Source: AGHT+IFzhk3zGYOCM9giZVhI1BAOtxeflJv2OLMYMGG/5Z7X0cvLqNCaqoELAufmfxHG/sF+LRHqlGUEZ1CV7cKocN4=
X-Received: by 2002:a05:6820:1629:b0:5eb:827b:9bbb with SMTP id
 006d021491bc7-5ec23a6971emr6415253eaf.5.1730147607308; Mon, 28 Oct 2024
 13:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com>
 <20241026191434.556716-2-arkadiusz.bokowy@gmail.com> <CABBYNZJk9jrmHwAgCR4LH2Y7+M9GWNdgSFqC7K9YtEGVDZ1QTw@mail.gmail.com>
In-Reply-To: <CABBYNZJk9jrmHwAgCR4LH2Y7+M9GWNdgSFqC7K9YtEGVDZ1QTw@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 28 Oct 2024 21:32:35 +0100
Message-ID: <CAGFh026BwotTDPmvTbyzLrjev8j9Jxv3fGWUV436SpqN5+SN=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] transport: Allow to set A2DP transport delay property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +static void set_delay_report(const GDBusPropertyTable *property,
> > +                               DBusMessageIter *iter, GDBusPendingPropertySet id,
> > +                               void *data)
> > +{
> > +       struct media_transport *transport = data;
> > +       uint16_t arg;
> > +       int err;
>
> This really needs to check that sender is the owner of the transport.

The problem is that currently there is no mechanism which will allow
to get the sender name in the property get/set callback (at least I
couldn't find any). The statement "this property is only writable when
the transport was acquired by the sender" is also for the Volume
property, but as for Delay (which currently lacks the setter) it's not
implemented. So, now the question is whether you would like to fix
that as well (or amend the doc)? Some users might say that allowing
others to control volume might be a feature. For the Delay I'm not
sure... Probably you are right that the Delay is more intrinsic to the
transport, and external manipulation would not be desired.

As for the design of this authorization check I can see two possibilities:

1. Pass `message` to the `property->set()` in the
"dbus/objects.c:properties_set()". But this will require updates in
all setters (and maybe for symmetry the getter should also receive the
original message?).
2. Add a dedicated callback for setter/getter authorization, in a
similar way the `exists()` works.

In either way I think that this should be a separate patch, applied
either before or after the Delay work.

Regards,
Arek
