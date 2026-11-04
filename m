Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793804851;
	b=VaY3uEu06CmpIM6fKURIQvlJAXG3wJJu+fdcmHRa9tKiETYovXXDYqno2n6oOg8tdmXb
	 UhyRlg+oHmXA7+57k1aFdAh2VIKNiaZw18EH7yFLF9wrqRSJK1161vLKNZ709HPZMGMNP
	 foN5I4GlUMqtXQXl/Gkbu2XEnLs54YjsM5Y5wi8UcHBjMNWKFaDsAQ3f8Mvisai/7zXpS
	 /TCYKZw9qPJU4/jd5Li7gZVFzSD+rNoORhFOmfRN2uhwzY0+fUy5uYQjvKLqaGbgvE9n6
	 ooXk8k8ue/El3XwxgbkH9luKzjBdgeN9Bctu9gLNuK6Yf+rDW6nuMw2HD8Pd+LU+40Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=HgsYnqY/UtgCcMuLilirnY/lblioi6DjhJ75x1MFrH4=;
	b=OjFLw5wMPWhuKhYyQZDI4eIn3i/mNtqha2j6+WG4KfwpThFvV8l5KcUZiIs8dbilyYob
	 mLT6ZSiEZToNJwY9XVReo7oXpYnOAKw/Zi+ltiXllugOqA8NiZTya+8+VH7iGqZzc1NDc
	 Xrb1SI3TDcbdvBR951e8wou3lozR22lRM2+95jQ9wwbEWQ0Ca6l1uLQo1eSMv3DO6tsK/
	 1m5ToYyU9ZGcuc1kWAeCOHRjmrbNYqk6IW6F0vgl7vujx9wgn1brC1a+LRrzT/tIXYLgm
	 sG1SBve0wl/5aEcB7MkZ55oz1NrRoTy+2KmiDyleAqsoNi546IIT8NPdLvzzE1eKDOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+l54USJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB740606D804
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 15:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB740606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+l54USJ
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0a921ee46so7655897b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 07:07:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793804850; cv=none;
        d=google.com; s=arc-20260327;
        b=SNci8ODDXCFSAZmWm/w2DJytO5pPJSzsVGsYnMlyG8HCmOV6XoZUOCSCM/CsUJZpYf
         Qn1apbJHbBs9pf8yu4ci16r61iJ+jJxBEe6XxrIQtRQQmqUIdLV4ChAw1ayy0f6ixf1u
         B/cTRQMp5EcdvrkV5paGUGBv9yLdUdDOlFUC+1qpGoL6oQ0v+PhxWmHhjeGWrr3qb6Za
         4FX0WaWldlJY21tn1YwolasZwT0HmPY2bUJq/crHZnRdnedZLtZn2fVOM/TFO4ZR4M6M
         SCEpR3qHuptaZwxmSkcHetVYtj3ORyx34WswWahSFK+L4T7gGIZavXJ1uDGkgI51pyMd
         qO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HgsYnqY/UtgCcMuLilirnY/lblioi6DjhJ75x1MFrH4=;
        fh=yMRINOhWSIvW8hRDgEW9Bw3sYRl+Gmh1YYZQy/HWyJI=;
        b=aq54NVIuAmJJFrmvObEQvNhoQfgm6hcGcjrdIMZXVm79BMz4Y9COlMrdmosSSYanrN
         FVlt1IfvgP5V2AWQ7yGuwGi0durChqe0YxbHx8p0vh2kL92uXLwNQWBZWHPGix9kH4EP
         s7cfFUflJNtzwfWQ63UjQ9g6iccoqtq39CsETaX0onLHpwh1sxhqvZVuUmHF2tNp1rFo
         EhEKk2aA6t9chj5hRQLtq67jIvyhG8yLtKVXDtumqdmUD709h1ayZaUw1jSwH9+wNJRr
         GjNfVJU16kkwxbmCA99tmG6I7mwRphlI6p+w+v++UEzaOwiNdGr1UMc1mPXTTPtZML5+
         wruQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804850; x=1794409650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgsYnqY/UtgCcMuLilirnY/lblioi6DjhJ75x1MFrH4=;
        b=C+l54USJUGUrvJDnDB/nQQgnnlTj1wPVjZgy3SeLAzokRsWjkN9RIrBz7PNnYptnHY
         MURIjVDNJv+IUJ1Ava2U7eusvMmbjjQI9OVNNh5qVw+7TDlpnnBdEVolgMXMSQj8/IOw
         NWmO/xISEBWTHCJ+j9+QZMiPfhSF7TJJP4Aq3Kh2st6Gvcp3oiytX/PdH42MCEctv671
         1u2bq9ozStQySOPqkzNDVO6fWwPuXTxv2x6AoWMZLBy+mMOqPOzdyGxqnthOGxzSNAQo
         hwyD/44wECknAHQl1bF3kTWK3JW1RPtUwECVdk3Z2fBo/RjEgTzcJiivP7bEKOGbaLU0
         OXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804850; x=1794409650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgsYnqY/UtgCcMuLilirnY/lblioi6DjhJ75x1MFrH4=;
        b=0bCEtK5sx1h4qHUgK270lEyuuB+/LEOAn8b3lXnxPHRgEwjF2xRvQWk0UZMIi+XUZ+
         OLb5Kjl1jGUxPwAiLT5q5QvCnnqE+m71af+5Q7h6Vkp/i1X4K8hW+31J7IcIiutYUTWA
         T8beX7S46Wy8zvOgLdNcrDh+U902Tyi7q/i9vNLxrBRGVTU08hlWxWb9I7I+RkxW0wCf
         nhgqI/SJHxkQuzoJb6KuPIYvNWzU3TVQv2BzHrAKbbtIA3M2fQLF2P044Q8fAQXK+N4p
         s7s/0W+O6JxPKkugAzMxtSqLVtMkZgU6ieo09QxGe3pxv3IQXv7unBXfxGyksnts1Gnz
         fJog==
X-Gm-Message-State: APuU4Z94IM2/G+hooNUBNNbRArXWjONQMPGxFAFiliQZ+lGKFmK6lHlp
	ka6Wwosbg1WwzkQLC499MHybHMyp/XrY26uZ+qeDWlQ0taq8HUwSVQWLcDAADET1Kg9UIfeuEyc
	OGOsFs5a8Y25My37T98sTspr/PnvTQI8=
X-Gm-Gg: AYBFou31L4BAghCDcIcB4Vm2Cs7Fatyjm+3drjwlse1IpNfYtu6Z+GTc9n+IpNAM8Xc
	8gf8RqxUL6GzzncdUdoEvC18qhCMRCNi20hb8wbudFCdj4VWGFU3Ed0BAoAAEi/AMAzbAb3KkwT
	QRnRONkXVT2V1Pztu9bZ/EwPpH3nUIS4wQVXQnzsoNtIL0dopsU31LNK8ginPsErn+QxVYzAQw6
	9mZQgfckwFlLdhZybAYGPw9T2bzm4lWpyCQVYoMKi+hh9doMGKdeovI6jxxYiPPmIzYTDH7C8ak
	fKpDKwj3xYeEf/HTKRSv8thcJXTCFPJbiXjI+j4brb1GBR+bzSOvq4UsGuBKRch5GExqBAJqdTP
	pdmlZYjnm4ANm+7sdIxELYkCQA6YN0/k2ULCx6mI3EBY3urTuNXIuQ2MdUBQM3546v/gAVOTvyh
	YL6by/EazycV+9XLAshFjgQvZ1wzRQUs5WI2iM/uUy1w+xoLs8Cg3J6JaW
X-Received: by 2002:a05:690c:e199:10b0:8b1:8738:bd35 with SMTP id
 00721157ae682-8b2b66c7d3bmr60103897b3.18.1793804849597; Wed, 04 Nov 2026
 07:07:29 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
 <CABBYNZKjiVFVgNxxjTGYKBD0kZD=bQc6kbavcV=6cHGirBgMGg@mail.gmail.com> <5941ceab-3f38-4d11-bede-054898c8680e@oss.qualcomm.com>
In-Reply-To: <5941ceab-3f38-4d11-bede-054898c8680e@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Nov 2026 10:07:17 -0500
X-Gm-Features: AclHuK-VMRLvMbw1zB1xsNWMxA4fDV0ue8stqbwY3BO1gcBjWrWlwhdi24dmqOg
Message-ID: <CABBYNZ+C5fm3OzC0s7kp+Z2pxjsSFqBgXcKpinRhoXR-GvANNg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/15] Channel Sounding and RAP fixes
To: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com, 
	wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Tue, Nov 3, 2026 at 10:04=E2=80=AFPM Cheng Jiang
<cheng.jiang@oss.qualcomm.com> wrote:
>
> Hi Luiz,
>
> On 11/4/2026 4:38 AM, Luiz Augusto von Dentz wrote:
> > Hi Cheng,
> >
> > On Mon, Nov 2, 2026 at 3:21=E2=80=AFAM Cheng Jiang <cheng.jiang@oss.qua=
lcomm.com> wrote:
> >>
> >> This series fixes problems found while running the RAP Requester (RREQ=
),
> >> RAS Server (RAS/SR) and GAP CS test cases against PTS. So far the
> >> Channel Sounding code had mostly been used between two BlueZ devices,
> >> with the local side creating the configuration as the Initiator. The
> >> test cases also cover the Reflector role, a configuration created by
> >> the peer, peers with different antenna counts and every Ranging Data
> >> mode, and most of the fixes are for those paths.
> >>
> >> The patches do not depend on how the CS session is created; they apply
> >> to the existing session set up from the RAP profile probe. Creating a
> >> session for a peer without the Ranging Service is a separate question,
> >> which I sent to the list earlier and is not part of this series.
> >>
> >> GATT database and RAS (patches 1-4 and 15)
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>  1. A device removed while disconnected kept its CCC state in the GATT
> >>     database, and it was restored when the device paired again. Drop i=
t
> >>     from device_remove().
> >>
> >>  2. The Ranging Counters read from Ranging Data Ready and Ranging Data
> >>     Overwritten are scoped to the connection (RAS v1.0 3.4 and 3.5),
> >>     but were never cleared, so a new connection read the counter of th=
e
> >>     previous one. Clear them in bt_rap_detach().
> >>
> >>  3. On-demand Ranging Data was always subscribed with notifications,
> >>     while the RAS Control Point, which only supports indications,
> >>     followed the requested transport; with notifications no On-demand
> >>     transfer could be requested. Follow RAS v1.0 Table 3.1: the
> >>     requested transport for On-demand Ranging Data, indications for th=
e
> >>     Control Point, and indications for Ready and Overwritten whenever
> >>     the server supports them.
> >>
> >>  4. Reading RAS Features subscribed to Real-time Ranging Data at
> >>     connection time, when no procedure is running yet, so the 5 s time=
r
> >>     disabled it again. Subscribe when StartMeasurement() is called
> >>     instead, unless SetRangingDataMode() already did, and use On-deman=
d
> >>     when the peer lacks Real-time Ranging Data (RAP v1.0 4.4.2).
> >>
> >> 15. RAP v1.0 4.4.1.1 counts the 5 s Real-time timeout from the start o=
f
> >>     the CS procedure, but the timer started when the CCCD was written,
> >>     possibly seconds earlier. Start it from CS Procedure Enable
> >>     Complete.
> >>
> >> bluetoothctl and shared/hci (patches 5-6)
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>  5. Fix a use-after-free in the StopMeasurement() reply of
> >>     bluetoothctl, where the Active=3Dfalse property change had already
> >>     freed the session.
> >>
> >>  6. bt_hci_get_conn_handle() always listed the connections of hci0 and
> >>     took the first link matching the address, which could be a BR/EDR
> >>     ACL or an old link being torn down. Use the right controller index
> >>     and match the link type; this adds LE_LINK to lib/bluetooth/hci.h,
> >>     replacing the local copy in hcitool.
> >>
> >> CS role and setup in profiles/ranging (patches 7-14)
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>
> >> These depend on each other and are best applied in order.
> >>
> >>  7. StartMeasurement() returned early for a Reflector, so it never ran
> >>     the setup phase and dropped every event the remote Initiator
> >>     drove. Run the setup phase for the Reflector too, subscribe to
> >>     Ranging Data as for an Initiator (the RAP roles are independent of
> >>     the CS roles), and do not send Procedure Enable on stop when no
> >>     procedure runs.
> >>
> >>  8. With Role_Enable permitting both roles, the GAP role decided which
> >>     one was used. Since the setup phase only runs from
> >>     StartMeasurement(), take the Initiator role, and tolerate the LL
> >>     Procedure Collision that two simultaneous configuration requests
> >>     can cause.
> >>
> >>  9. Config Complete overwrote the Role_Enable value with the negotiate=
d
> >>     role, so a second StartMeasurement() sent an invalid Role_Enable.
> >>     Keep the two in separate fields, and do not send Procedure Enable
> >>     from a Reflector.
> >>
> >> 10. Config Complete was only parsed in the state reached during a loca=
l
> >>     setup, so a configuration created by the peer was dropped. Parse i=
t
> >>     in any state, ignore events for other links, and ignore a removal
> >>     whose parameters are undefined.
> >>
> >> 11. The Set Default Settings response rewound a setup the peer had
> >>     already advanced, and an Initiator then created a second
> >>     configuration. Only advance from the initial state.
> >>
> >> 12. CS Security Enable needs an encrypted link (Core v6.2 Vol 4 Part E
> >>     7.8.133). When the configuration completed before encryption, the
> >>     command was never sent. Defer it to the Encryption Change event.
> >>
> >> 13. The antenna configuration was always ACI 7 (2:2) unless the
> >>     application set another, which a single-antenna Controller on
> >>     either end rejects. Choose one that fits both ends' capabilities
> >>     and the negotiated role (Core v6.2 Vol 6 Part A, Table 5.3).
> >>
> >> 14. A StopMeasurement() during the setup phase did not stop it, and th=
e
> >>     Initiator went on to create a configuration and enable a procedure=
.
> >>     Remember the stop until the next StartMeasurement().
> >>
> >> Testing
> >> =3D=3D=3D=3D=3D=3D=3D
> >>
> >> Each patch builds with --enable-maintainer-mode and unit/test-rap
> >> passes. The PTS runs (PTS 8.14.0, Qualcomm controller) used a
> >> BlueZ 5.86 based tree carrying these fixes.
> >
> > We really need to start testing with test-functional though, since
> > unit/test-rap only test bt_rap itself, it is very tricky to do a
> > proper verification if these changes don't break anything since we
> > don't have any functional testing coverage yet.
> Thank you for the comment. The current changes have been validated with
> the BCS certification tests using a BCS-enabled PTS dongle.
>
> We=E2=80=99ll also run end-to-end tests with a BCS-supported remote devic=
e to cover
> more functional scenarios. I=E2=80=99ll share the results once the testin=
g is complete,
> and then we can decide whether to merge.

That is not exactly what we have as test-functional though, anyway I
went ahead and asked copilot to review and it find the following:

https://github.com/bluez/bluez/pull/2747#pullrequestreview-5770367325

Please have a look and lets address them if they are valid.

> >
> >> Cheng Jiang (15):
> >>   gatt-database: Drop stale device state for removed bonds
> >>   shared/rap: Reset the readable Ranging Counters per connection
> >>   shared/rap: Subscribe on-demand data with the requested transport
> >>   shared/rap: Subscribe to Ranging Data when a measurement starts
> >>   client/cs: Fix use-after-free in stop_measurement_reply
> >>   shared/hci: Look up the connection handle on the right link
> >>   profiles/ranging: Let the Reflector run the CS setup phase
> >>   profiles/ranging: Let StartMeasurement() pick the Initiator for Both
> >>   profiles/ranging: Take the CS role from Config Complete
> >>   profiles/ranging: Act on a CS configuration created by the peer
> >>   profiles/ranging: Keep a peer-driven setup from being rewound
> >>   profiles/ranging: Defer CS Security Enable until the link is encrypt=
ed
> >>   profiles/ranging: Choose the CS antenna configuration from both ends
> >>   profiles/ranging: Do not start a procedure after StopMeasurement()
> >>   shared/rap: Start the Real-time timeout when the procedure starts
> >>
> >>  client/cs.c                        |  40 +--
> >>  doc/org.bluez.ChannelSounding1.rst |  21 +-
> >>  lib/bluetooth/hci.h                |   1 +
> >>  profiles/ranging/rap.c             |  16 +-
> >>  profiles/ranging/rap_hci.c         | 414 +++++++++++++++++++++++-----=
-
> >>  src/device.c                       |   3 +
> >>  src/gatt-database.c                |  25 ++
> >>  src/gatt-database.h                |   2 +
> >>  src/shared/hci.c                   |  12 +-
> >>  src/shared/hci.h                   |   2 +-
> >>  src/shared/rap.c                   |  82 +++++-
> >>  src/shared/rap.h                   |   6 +-
> >>  tools/hcitool.c                    |   3 -
> >>  13 files changed, 484 insertions(+), 143 deletions(-)
> >>
> >> --
> >> 2.43.0
> >>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
