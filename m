Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FA1DFDBE
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148787; cv=none; b=q/bTyuOv7OvqcMTbl4fsNMsa3zk6gLcE/bSonUxAMTt0FX/Wyj+gkrwqsTqMMl9MAqxVdbd6hch+hbpIAdO8E+V5wOGy/Q5FX1aRfobwkcu6Idxre7o1Ote7c9Ge8Sy1XgB/EwpX87LIo2qq+foW+NTQJu/KJtSa/RDPXaW/EUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148787; c=relaxed/simple;
	bh=A199YsPChxJd7e2ip0WBxFoRzhgUFqukZgXFeFDPQ7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSVmxs/4PNKNpLvyDnRCVUcNTuEi1QkLmKoHy6LVAEy84VV1Yu/OhQI4D9QhyGhX+XYKCBoMdeGBMftW6wlSBphzV09zrqTm7hcesTLv7q8Hf7TkQCZCS3xlOvDGqM07cpdUh1sUm8VV018wTUFtcz52YklWAhWnguvl2H6i6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9bLc2Ix; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9bLc2Ix"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fc968b3545so46164341fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730148784; x=1730753584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYNL+1H7B1RqHSveXFZyqktSNG2Hkp2wCCMopzE8VoE=;
        b=m9bLc2IxBRqejWBvk2/gqrvcUPJvPYyTuYB9UH1XaUNhK3h9GkeJl5E8NPo5npSf9q
         j9r4xbroUjwrmaj2CqCnK246ybmgO/RWmA/F+e8BNPxpfO4cV17GR+r/BmB+NkPYjMxq
         R2ACbYRGHBHizRNrGjIA1xh1YB9kBau/RZ4NZ7IYqgfJudG56RACHj+fCwzHHycCPmYW
         CYv15Xfc6WKleC8nB8NBfcwHeBBm7mv3CAQGPi7WWm6e9SWZT3rRwylQ/iPUT9e51jYj
         Gq+F709MJy8lpJBOh3VyWxYlggfgQfDA/wzzFnndNGut/TF9GitDxzcwmWH+tZ44RM4n
         ZAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148784; x=1730753584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYNL+1H7B1RqHSveXFZyqktSNG2Hkp2wCCMopzE8VoE=;
        b=wbyEH2qXehRItovoJv2XEmajndIuK8WzgVk7j+PDWBMBbxzjg/MD1AOO3NezRlEPLL
         WRZn9bRzgfeUa54jo0YU8rOQ2kLoP98kBDsgpmmk/78WTndANJ27IIHs4ZLPD9YgLBIT
         gWN3YuTKql8ioFagQCu4U0YbFjMQNk+ckV0URFoi9JVM/DSl1Buuk/M//a4RDTGVOMcJ
         wedXa8fmGKBoc7iHfb5ofJm0tCBFRts9LC7//PXSSCOLLval3GonTiskO3PEnzkL5WE8
         obslc5FlhEGtTsYinbVxCiWlNJXSqbRy+OkmsZmGgyVlAsr/lAxctPhOYwVtZH+TFfAP
         TzkA==
X-Gm-Message-State: AOJu0Yxnw9kcpmnlq+bHEtsKZuNsdsSo8l4Myu4v75p3LAv8QMfIcXOO
	3ImmmyNS56wEN4r2KBsempZu7X+6z05K5cdthlJWxio9TpqxMvbzVLRgLTqQNT4JQRaDbabdJHD
	LZnxN2vTvykLKl0JeqvLD7KjIlQg=
X-Google-Smtp-Source: AGHT+IHzZPplRupEE9XnE0LXEMuzZFmL0N7lAZJs61AARbRFmtS3ECUKdW4KN/XLY3Ugtv8QIkDOoeMUc+8AjJNAAPI=
X-Received: by 2002:a2e:802:0:b0:2fb:4b40:1e1c with SMTP id
 38308e7fff4ca-2fcbe095f21mr34676131fa.36.1730148783606; Mon, 28 Oct 2024
 13:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com>
 <20241026191434.556716-2-arkadiusz.bokowy@gmail.com> <CABBYNZJk9jrmHwAgCR4LH2Y7+M9GWNdgSFqC7K9YtEGVDZ1QTw@mail.gmail.com>
 <CAGFh026BwotTDPmvTbyzLrjev8j9Jxv3fGWUV436SpqN5+SN=g@mail.gmail.com>
In-Reply-To: <CAGFh026BwotTDPmvTbyzLrjev8j9Jxv3fGWUV436SpqN5+SN=g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 16:52:50 -0400
Message-ID: <CABBYNZ+fzEkcL1u9uct3+UC4u+7XBY1uNozojKB=VGomTjQfug@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] transport: Allow to set A2DP transport delay property
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Mon, Oct 28, 2024 at 4:33=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > > +static void set_delay_report(const GDBusPropertyTable *property,
> > > +                               DBusMessageIter *iter, GDBusPendingPr=
opertySet id,
> > > +                               void *data)
> > > +{
> > > +       struct media_transport *transport =3D data;
> > > +       uint16_t arg;
> > > +       int err;
> >
> > This really needs to check that sender is the owner of the transport.
>
> The problem is that currently there is no mechanism which will allow
> to get the sender name in the property get/set callback (at least I
> couldn't find any). The statement "this property is only writable when
> the transport was acquired by the sender" is also for the Volume
> property, but as for Delay (which currently lacks the setter) it's not
> implemented. So, now the question is whether you would like to fix
> that as well (or amend the doc)? Some users might say that allowing
> others to control volume might be a feature. For the Delay I'm not
> sure... Probably you are right that the Delay is more intrinsic to the
> transport, and external manipulation would not be desired.
>
> As for the design of this authorization check I can see two possibilities=
:
>
> 1. Pass `message` to the `property->set()` in the
> "dbus/objects.c:properties_set()". But this will require updates in
> all setters (and maybe for symmetry the getter should also receive the
> original message?).
> 2. Add a dedicated callback for setter/getter authorization, in a
> similar way the `exists()` works.
>
> In either way I think that this should be a separate patch, applied
> either before or after the Delay work.

Right, or we could just implement something like get_sender_by_id then
the callback can just call it to check who is the sender, that way we
don't need to modify existing code if it doesn't care about it.

> Regards,
> Arek



--=20
Luiz Augusto von Dentz
