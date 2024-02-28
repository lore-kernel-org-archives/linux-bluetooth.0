Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339398624A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154096; cv=none; b=YoFVjQ3lUfA5T2iCyVsuRBuazdJhkHZNXAb1OymwOmDn9EDyoTNiRE65RKHiWvSk1dNcfbNZBN2U9C5gWYY7ci7G7V4Zqi3Bw3K8s+DRSTQilsJqrkI2ObzxEQ3t5n3fsK93vX7nftEE+OAT8DHv5BucZvUXnUWosmepZj+czpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154096; c=relaxed/simple;
	bh=oGyxVTyJeFeGaaCfU5DG/l5Y15GiqrS3cjAPgEoTMXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhR1fcvevO42XdelRwt7xYVtFSA/Too95O/yvfHZ4FS9xsDY//DhoaPyV2EzvIKX3yLLu9qTL27Z0UzpigMYpcSGjEMPaTdCjx32vH14J5I5CNyUBcBUB7Z2maw7w++mJJGlNakHKPdOI29rhIZa3od6kKhxnF8KM6tBjDaN6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMc8sGQj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMc8sGQj"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d28464c554so1966201fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 13:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709154092; x=1709758892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocIaTqiPEIodc+sa8cxXdGWBmxIASc/bN1F+xgQreZg=;
        b=PMc8sGQjAYSCTHLIunobOUngkFDCQ8EgGiFSfkvHAD2TlEvun6RhwvI7DplhoL7JMf
         wvJWElchbG5gDpHIGgV3ci2+YUZrbYBvFXH0brdfaZH8FsYWe8Mwa+37uYOXoelQEKcZ
         JyzPmh25mzCnDDSvM64wHJzpYq2dB76JT2o0TOw9sH5W0OAvuOuh7tkiJVmtuQa9hzzN
         35B5MPjNsypI8Yc0Ht65aZ0e4o9JAMwZO/eawLlV/VeB4aPz/4hypQRoiG2zPG0NGM7/
         TNSjwLO8dkfBgmwNpouF/HDDYW9yYFofnkvv6JaF+xk/m8LzfPSkjEqHJjqNnUPEOvEE
         6FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709154092; x=1709758892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocIaTqiPEIodc+sa8cxXdGWBmxIASc/bN1F+xgQreZg=;
        b=NV9MY7n++gUwGY3fQOeStBkQatb07HcSGXzoTCvQwR6nmBbneZvJju0W5kZAo0/M9L
         luoQAZB6smsDZElqjYsX7zgrjZCn5X5kHRK0oatDVQcwO1NSg4YQKAVTCgc5GINX2QZw
         edaSSKOctGY8ZlbTFE0PFw8/biWG0yVpr/RwV+NvOQDmw9ORr5xqE2MYt87erWQC/CQK
         kv9GKkjH6tlElPUpb6sIwhmimT1RNknpiyEzfHqcSnJVkOm77ZyWQdStW4H1j3+Eme3z
         gg0RdIhEqGV4iMxLSvQ/wfI5gloXm9azb2KCw02d1AFrtx117vWfXsXhVN0e22//WRRn
         r1aA==
X-Gm-Message-State: AOJu0Yx0X/e+4tjvZ6OX69+R6i6vDOJQfQIBRMpQFsw5/YyU+vX5HZcM
	CaPMhjlfn4c+Ik7VrF9IR9r2QKMD1Q9aXTLKGWLIfH3o8ZMXlpce9oQLB60cbK3ejKhJppGlW4Y
	jL698M5N4XeVXc8oqCQZQTQoMMp8=
X-Google-Smtp-Source: AGHT+IEjkIiVombk5tRwGslnKkp9NYeLuLlFPLh0I0dQePRlSo9uvdoG01FYySNX8J1mG4fyiJ7xiRGaeDA55eFURUY=
X-Received: by 2002:a05:651c:140d:b0:2d2:a19a:8625 with SMTP id
 u13-20020a05651c140d00b002d2a19a8625mr24383lje.40.1709154091974; Wed, 28 Feb
 2024 13:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709150574.git.pav@iki.fi> <CABBYNZ+J_SUi_T987ND3hyN228zvX0gD62QNqk5D=GDc+nypTQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+J_SUi_T987ND3hyN228zvX0gD62QNqk5D=GDc+nypTQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Feb 2024 16:01:18 -0500
Message-ID: <CABBYNZ+PJTyWXdBE7Mm4YtjYDKc5eX6YfPk4_Sh8S5mdDf76AQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Bluetooth: add transmission latency tracking for
 ISO & L2CAP
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Feb 28, 2024 at 3:31=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pauli,
>
> On Wed, Feb 28, 2024 at 3:11=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >
> > Add ISO/L2CAP socket ioctl() BTGETTXINFO which informs the user how lon=
g
> > it took the kernel and controller to complete their sendmsg(), and how
> > many sendmsg() are in socket and controller queues.
> >
> > This currently provides information of the latest packet only, in
> > principle there could be a ringbuffer containing few latest packets, no=
t
> > clear if that would be useful.
> >
> > These patches allow fixing / working around controller(?) issue where
> > two ISO streams in same group get desynchronized.  Having accurate
> > knowledge of the packet queue lengths, user application can drop packet=
s
> > if it detects the ISO streams are not in sync.
> >
> > Pipewire side:
> > https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-ts-test
> >
> > With this change, https://github.com/bluez/bluez/issues/515 is more or
> > less fixed, and the sound server can figure out the total latency to
> > audio rendering (tx latency + transport latency + presentation delay).
> >
> > For ISO, this can be changed to use LE Read ISO TX Sync, when the clock
> > and sequence number synchronization issues there are figured out, and a
> > quirk is added for controllers with nonfunctional implementation.
> >
> > For the L2CAP latency, I'll need to think a bit more what is the audio
> > use case. Motivation was that AVDTP delay report values appear to be of=
f
> > by ~0..40 ms compared to observed audio latency and this amount can var=
y
> > per connection and time, so not explained by unaccounted code
> > algorithmic delays etc. Currently it's not clear if there is relation t=
o
> > TX side latency, so it may be down to receiver side implementation.
> >
> > This needs a bit more work to figure out, but the L2CAP patch is anyway
> > here.  Due to the possible fragmentation in ISO sendmsg(), it seems we
> > anyway need the tx_info_queue thing and can't easily do it by counting
> > packets, and L2CAP required part is small addition on top of that.
>
> That is not how it is normally done with sockets, normally this is
> done with use of SO_TIMESTAMPING which is then reported using the
> socket error queue:
>
> https://www.kernel.org/doc/html/latest/networking/timestamping.html
>
> Sorry to tell you just now, you might have lost a lot of time doing
> all of the changes, next time just drop and RFC early on with the
> general design so you don't spend too much time before getting any
> feedback.

There are some samples in the linux tree if you want to take a look:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/r=
efs/tags/v4.6/Documentation/networking/timestamping/txtimestamp.c

The nice thing with that is that it is not a new API and it has a
little bit more finer control since we can add support for the likes
of SCM_TSTAMP_SCHED, SCM_TSTAMP_SND and SCM_TSTAMP_ACK, so we have the
possible to instead the timing at different layers.

> > TBD: iso-tester / l2cap-tester tests
> >
> > Pauli Virtanen (3):
> >   Bluetooth: add transmission latency tracking for ISO and ACL
> >   Bluetooth: ISO: add new ioctl() for reading tx latency
> >   Bluetooth: L2CAP: add new ioctl() for reading tx latency
> >
> >  include/net/bluetooth/bluetooth.h |  39 +++++++++++
> >  include/net/bluetooth/hci_core.h  |  30 ++++++++
> >  net/bluetooth/hci_conn.c          | 110 +++++++++++++++++++++++++++++-
> >  net/bluetooth/hci_core.c          |  14 ++++
> >  net/bluetooth/hci_event.c         |  66 ++++++++++++++++++
> >  net/bluetooth/iso.c               |  58 ++++++++++++++--
> >  net/bluetooth/l2cap_core.c        |  12 ++++
> >  net/bluetooth/l2cap_sock.c        |  50 +++++++++++++-
> >  8 files changed, 372 insertions(+), 7 deletions(-)
> >
> > --
> > 2.44.0
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
