Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6A1E0095
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149573; cv=none; b=XMPSsl/OlX2mW3alr1tGq/2StsGIwzsNNQR1uyINtIB4qKPqfHPI7ObWf1Bq3EnWAT9NgddRV4vscWGm4QJ83RQnVzNUvdrDI94cvRIJjfjtEKCxcbIOG6OT7jZpDCQT4byKfaIsIl9bn1IrK7nUKzshbW1m4JBdetQy4WihKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149573; c=relaxed/simple;
	bh=wJLandP4QeGUSHAH+Ui+QN7al+ttMEpqKpmfJloz/eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGd8h2eFLWVpM/tEYqlj1Tj9Ew8iH09xV7Uw0ZzZGjgWDlyJ5gCBdC3yDjiim75020qiSHVFERT2S77ivBsu1dRL3hoVc6JmY8uHIoX2fDABOHyg7fPQ2J6/WsTU9if29VxWJCaiOE+Akw4KRcXg8844mX9bqcmxU8HzOojm5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI+sFIjZ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI+sFIjZ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ec1ee25504so1320895eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730149571; x=1730754371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iFRyuHhWuKlP592AdGgKrWeAA584/pLcm8LCiOs3N3g=;
        b=iI+sFIjZEDhshGipfuvDFvfgoL+VM2gUMvRc95oixQX+1+omgkfsVLYdnhOQua/+dY
         JVQVBEgJ1CDiDYpLwMtY3yJVJKeZeIdD2OESbJ1DuZIm3He9De3mSU+QQIv3CsLCdCsY
         ybAxoJBOPUtCqFUPG6M5eQK5v5xBR6OzwMyfUWjQsrHi7uDtOsToVmrVK38pfJ0ecVIP
         lhUNxerjtiYu2wzx0VpZocDdw1JAu+BNGBKlSGymeApJUGEQhf+BDxIeC9d8kkRgeuc1
         +wLDIg1SpuhqIR5Px2qavXCJC8XUY0qM+S80ILD33n5IOKGHY7pXfGeo32iSkyjmDqby
         tD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730149571; x=1730754371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFRyuHhWuKlP592AdGgKrWeAA584/pLcm8LCiOs3N3g=;
        b=WUIDS3hexx3TlyDxax91yfG+QwZvx1VVJSQbc6RNXQ6SXgi9qgnY7MbrLnMeEKvyJU
         6+cC8zQraEb2XmUz3+cKM4BrIEqD1h49+fJF3ZBY+0cRtevQU8+GyJYnpEraYJw6BhbZ
         +8cxPJj4mmYCWhuYwUKEmTFApnonAwT/uBgGd6b7xi743W49vXlNsa3tCw/0w4tQdOxv
         nTi23juwoiW5wCQy1A2+7L3hrLIyf2ZIwg/hxh8Z5DmRSKYBvdhm7wWDOdFiu7D5RDYd
         E3oOJLPsFdUkX+RkI6wtdSfhlS1uEkZspkgpol/N7X4LWRj2JdfGjHIQoQR2lVnd738x
         R6Lw==
X-Gm-Message-State: AOJu0YzudSrjUjLKKI0Xs1BrgOztg2d5fsM0a3HrlBUnt/IQkFIjIPfF
	fFRpv9rDNG+UTAWRxGelCK/LxHYyP6NbmA7WjBRE4H2f1bFINzPzW9JObssD+GBB8qZ2s4UiTBz
	sGzyFJ22wsv+8YjxSFKNhK9iHva7eIqAb
X-Google-Smtp-Source: AGHT+IGUAt3ffaadzHRkDM1pc3eUCGT+JyMi+2ONpGboEX4xZyAsjVDkGjx+aoJGOD55Ig3CJiVX3WFdqLZ9PyllL60=
X-Received: by 2002:a05:6820:16a5:b0:5eb:c5dc:a636 with SMTP id
 006d021491bc7-5ec237f0068mr6615602eaf.2.1730149570804; Mon, 28 Oct 2024
 14:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com>
 <20241026191434.556716-2-arkadiusz.bokowy@gmail.com> <CABBYNZJk9jrmHwAgCR4LH2Y7+M9GWNdgSFqC7K9YtEGVDZ1QTw@mail.gmail.com>
 <CAGFh026BwotTDPmvTbyzLrjev8j9Jxv3fGWUV436SpqN5+SN=g@mail.gmail.com> <CABBYNZ+fzEkcL1u9uct3+UC4u+7XBY1uNozojKB=VGomTjQfug@mail.gmail.com>
In-Reply-To: <CABBYNZ+fzEkcL1u9uct3+UC4u+7XBY1uNozojKB=VGomTjQfug@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 28 Oct 2024 22:05:19 +0100
Message-ID: <CAGFh025H4pK9ddaWoGF4CMwv88OTONjBb3U=Cgsb-DU5ZKo3Xg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] transport: Allow to set A2DP transport delay property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > +static void set_delay_report(const GDBusPropertyTable *property,
> > > > +                               DBusMessageIter *iter, GDBusPendingPropertySet id,
> > > > +                               void *data)
> > > > +{
> > > > +       struct media_transport *transport = data;
> > > > +       uint16_t arg;
> > > > +       int err;
> > >
> > > This really needs to check that sender is the owner of the transport.
> >
> > The problem is that currently there is no mechanism which will allow
> > to get the sender name in the property get/set callback (at least I
> > couldn't find any). The statement "this property is only writable when
> > the transport was acquired by the sender" is also for the Volume
> > property, but as for Delay (which currently lacks the setter) it's not
> > implemented. So, now the question is whether you would like to fix
> > that as well (or amend the doc)? Some users might say that allowing
> > others to control volume might be a feature. For the Delay I'm not
> > sure... Probably you are right that the Delay is more intrinsic to the
> > transport, and external manipulation would not be desired.
> >
> > As for the design of this authorization check I can see two possibilities:
> >
> > 1. Pass `message` to the `property->set()` in the
> > "dbus/objects.c:properties_set()". But this will require updates in
> > all setters (and maybe for symmetry the getter should also receive the
> > original message?).
> > 2. Add a dedicated callback for setter/getter authorization, in a
> > similar way the `exists()` works.
> >
> > In either way I think that this should be a separate patch, applied
> > either before or after the Delay work.
>
> Right, or we could just implement something like get_sender_by_id then
> the callback can just call it to check who is the sender, that way we
> don't need to modify existing code if it doesn't care about it.

Yeap, that was my 3rd idea, but I thought that it would be a bit
hackish since the `pending_property_set` seems to be kinda private.
But OK, I can make it that way. It would be definitely the easiest
way.
