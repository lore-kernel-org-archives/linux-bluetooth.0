Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0272472AB
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397445; cv=none; b=nx3XazpcvjFGTRKOQbtw3Jwmd4Cb1BA8ywKXRnF3X12AtxXuIbEQzUNvIzIZFj6wiQZlmDBSpENJVqMua1N1th1TKfMWk8yCSGUTpvHqG7ErfEywVxVOMK95SzRLhU67H4utphFSBg2MoLB4L5YK5oJjM3+tKRhphf3Itel1b98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397445; c=relaxed/simple;
	bh=Ts+bP6tNh1SEHsJEnWUZjK94w5+0Z23I7ohV73mi434=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3efVC737RUvuKpHH2AuS5Ie+zS5S4WNytFp+S3+RxCUWIhRxWyh1JTMtwJzyYnCD3gQWGDwt+SXIwxyAHacAcPAq8eQMLV7cZLwhb9nAnHo/yXPODe3trjmwZfJ1axIgibumu/+7g9UXXay8Uh0XfcGnZz4NvPGpnyEYeahVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/hmQK03; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/hmQK03"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso6396569a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397441; x=1752002241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ork46AdHLg9l5jNZjtYPe6Q8ukSd6Ew0REyeAHNkjnE=;
        b=l/hmQK0391ECJUf3SEZIiceGJAphVJ1PB99QK+5gTjcGU3qUZte6m/UQjcIIxb9wcy
         afnSDtszVJr8XuWap2o5bmYJqNESMj9AbIYFoGd8ytPiIFBctZ+SeRsBFIJWON9N0gtc
         Fq0So9XlpEC1QupagClsAF/qA2uwZiKcx2ENUjP9sSusrsPxaSEUWr6VnQyOKa22lar4
         E8IeAJwLBhykhnR5OuX4+ds6j+1zO9fQBcLl3PvpHSTOBFOEd08avmeBs9zrdSz/98Ek
         L2+bqGTTVf5rGXTmYwETafcSYhH+nbx+4pHrnky2CcnvGfZThtka/QgNBO68EX5Z763y
         2q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397441; x=1752002241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ork46AdHLg9l5jNZjtYPe6Q8ukSd6Ew0REyeAHNkjnE=;
        b=j0Lu/F5voocahw8WzbHd4s9Y6D2r4GWS7h8ePnBZPyWLHvhBhLo0L+Ju97rMqifsit
         SWawrY0ohmqLmReJqpIbv9Qry6Y7/O1fpMGcqotcxyWs7DXwVv1kWhRkZhVTr4JgzDf+
         h5NfL5cKOHyf1kvxCEU+gpyaMVunCsdGIoHNvwkyxhBOrSNj3FWlOKcVX6/4M0wGmbZV
         +XGdwI4OTilfphoG9AGfio1UepP1/bwY4eVGf58cU5VL8IsFxMNPJslFDcyLLEURA6Mr
         Tc1jc8IuIf4z8N0NcT4lprLeG7HCXCuRBXLLn3DRkQjGAd2pYoeM1DjN3UYfzh1XhFyW
         VFWg==
X-Forwarded-Encrypted: i=1; AJvYcCWo6iM1oyUQD1+nxfSlzquA4ETRSYRaLeox/4cxBHcCsimHSyRHVlcC9646dPX4jRtSYOyUkn17aJEOdOeeWok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Ao1st0E82H6j916Wqk7SrbkT+0TIFtrIul8XdhV8NLWHvn3r
	tRaR9EETaba5aB9K4YskLojy58WG5E/dQW0OrYxfvs5eHnMXhH3pnWfx7mUmXQQhVSM02aoaJVY
	8Kl43lfcK/Y3Mm9TH/4UtGPzoTmoVTjH76A==
X-Gm-Gg: ASbGnctxxRDEmvkGE/4foezEjscVdCs8kZXd8YLTx74FlZUI4ADuH0yKYnPEcD/GHs3
	bXx1n0H1zVxjdeM7vY8bG0wbEpt8I5JbOLtg/FYOhUgfbX4RKN8FaU7T4JRRbDKIYwzCUIk4P29
	gPbr1G/3LBOPt4PMBt8/6USIXMPkAq0TXBkdwY4hyO94c=
X-Google-Smtp-Source: AGHT+IHLZctPq/DsWsqp0OGAMWMix0t/Nh/B61pZZgCtVv+EDlNol8Fr2fif5arKBGehozM0uqMitw3noc8zb4Ic4S0=
X-Received: by 2002:a17:907:2daa:b0:add:fb01:c64a with SMTP id
 a640c23a62f3a-ae3500fa6a3mr1939641366b.43.1751397440909; Tue, 01 Jul 2025
 12:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701144647.19572-2-ceggers@arri.de> <CABBYNZLUu3KnXBOeCkWHtpG_es+yF7vzXjd-fOsHv-S_UMWU2A@mail.gmail.com>
 <2308158.vFx2qVVIhK@n9w6sw14>
In-Reply-To: <2308158.vFx2qVVIhK@n9w6sw14>
From: Brian Gix <brian.gix@gmail.com>
Date: Tue, 1 Jul 2025 12:17:10 -0700
X-Gm-Features: Ac12FXyNuXd7IRRtUyRHiZOtD66elobUTtEhe-JdaDYiayk4yWnEY537nh5kLJ8
Message-ID: <CABUQxGwc49GMW56GzUX=0zzzpcxKzdcrGi7u35-BfgGWntAADA@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 0/4] Initial support for GATT Proxy Service
To: Christian Eggers <ceggers@arri.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	Inga Stotland <inga.stotland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 9:38=E2=80=AFAM Christian Eggers <ceggers@arri.de> w=
rote:
>
> Hi Luiz,
>
> On Tuesday, 1 July 2025, 18:07:06 CEST, Luiz Augusto von Dentz wrote:
> > Hi Christian,
> >
> > On Tue, Jul 1, 2025 at 10:47=E2=80=AFAM Christian Eggers <ceggers@arri.=
de> wrote:
> > >
> > > This series adds initial support for the GATT Proxy Service feature.
> > > This allows provision and management of MESH devices from mobile phon=
es.
> > >
> > > Before continuing, I would be happy to get some feedback about this i=
nitial
> > > part (and about what has to be done in order to mainline it). Any hel=
p for
> > > doing the missing features (e.g. relaying between GATT and ADV) would=
 be
> > > highly appreciated.
> > >
> > > What seems to work:
> > > - Provisioning from another Linux computer via meshctl (sometimes I n=
eed
> > >   to repeatedly enter 'discover-unprovisioned on' and 'provision <uui=
d>'
> > >   if it doesn't work on the first try).
> > > - Reading the composition (composition-get in meshctl). It looks like
> > >   meshctl tries to connect to the GATT Proxy Service automatically af=
ter
> > >   provisioning, but I have to enter 'connect' several times in order =
to
> > >   get a connection. You also need to manually set the target unicast
> > >   address ('target' command in 'config' menu).
> > > - Adding extra network keys (Advertising for GATT Proxy Service cycle=
s
> > >   between different network ids every 3 seconds).
> > > - Transferring and binding of application keys.
> > > - Using the OnOff client in meshctl (you again have to set the unicas=
t
> > >   address in the 'onoff' menu).
> > > - Provisioning and configuration of an OnOff device from iOS (using
> > >   the SMART+ app from Ledvance). This app requires at least basic
> > >   support for proxy configuration messages (patch 4/4).
> >
> > Meshctl is sort of considered deprecated by meshd, it was created
> > because at the time bluetoothd and meshd couldn't operate in the same
> > controller so we need the GATT client to be used against bluetoothd,
> > which is why the whole tools/mesh-gatt is sort of duplicated from
> > mesh/ portion, but now that there is possible to have both bluetoothd
> > and meshd we should probably move meshctl to be a client of meshd
> > directly and then remove the whole tools/mesh-gatt/ directory.
>
> <Not sure whether I understand you correctly>
>
> I am working on the GATT Proxy Server (in bluetooth-meshd), whilst meshct=
l
> implements the GATT Proxy Client. Having a deprecated test program is muc=
h
> better than having nothing :-).
>
> Although I haven't checked for this, I guess that meshctl could become co=
mpletely
> obsolete if GATT Proxy Client support was added to bluetooth-meshd. In th=
is
> case, provision would be done by mesh-cfgclient regardless whether the
> link established by bluetooth-meshd is using ADV or GATT.

Proxy-Client should never be added to bluetooth-meshd. As you point out, a
deprecated GATT proxy client is probably "better than nothing" for
testing a GATT
proxy server.

We had hoped that the need for GATT Proxy Mesh would dissipate over
time, because
point-to-point ACL connections within the mesh ecosystem is disruptive, and
not really "mesh".

>
> My patch series mainly makes bluetooth-meshd a client of bluetoothd (whic=
h
> normally operate independently). As bluetoothd is (exclusively?) responsi=
ble
> for GATT and LE advertising, using these technologies in meshd requires i=
t
> to use the D-Bus interfaces provided by bluetoothd.

This answers one of my questions from an earlier (perhaps suppressed) respo=
nse
I made...  This is the correct architecture for adding a Proxy Server
to bluetooth-meshd.

I am officially a retiree now, but I will try to review this patch set
this week, or next
week at the latest. Between holiday trips.

>
> >
> > > What maybe added later:
> > > - Proper selection of the output interface (GATT vs. ADV) when sendin=
g
> > >   messages.
> > > - Relaying of network messages / beacons between GATT and ADV
> > >   interfaces (in order to access further devices via the proxy).
> >
> > Afaik the tools/mesh-gatt does already relay messages, but since it
> > has been a long time I don't deal with mesh perhaps I don't remember
> > it correctly so please have a look.
>
> I only had a short look, but I think that tools/mesh-gatt can only perfor=
m
> configuration of the 'relay' feature on a GATT Proxy Server (switch
> relaying on/off on a remote system). But probably I haven't got the big
> picture yet.
>
> >
> > > Note: I don't use the test-join script, because python3-pygobject is
> > > (currently) not available on my (embedded) system. Instead, I use a
> > > custom C++ program for the 'Join' and 'Attach' D-Bus calls.
> > >
>
>
