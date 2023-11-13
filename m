Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC29210F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium.com header.i=@essensium.com header.b="ix1pftYo"
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6811A10FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 07:01:53 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f06931e4f7so2964677fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google; t=1699887712; x=1700492512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXRTaKo6j+tqF8f0KuNqtcbp0Qu6XSznJzofnpp1uYs=;
        b=ix1pftYorUHhw+PsotR99D5zYQsUwNoSmBiLBWRXf7QaxpEpmOOVq1n404ykbPu6Zn
         +EBeYa2r8GbuDADFSK+br1sXJe/DySiWtwcih966P2//C6ah+puR/Mr3ez/WqIgVv0Ny
         bkW9/C6NXI9jZI2roY4GnguQFdDb45Qpy/fQT2AC/tzi5mQF4FpMEcYXRdjUSBDsECjt
         lst5/5rdB17Uiz1OkOm0AkgxAgfoSoVDyFpPCptpEVyOg6w+soXDGc5i94StFk3UOcsu
         3gHPjIoATs9MQyQoYt6uUUxx/Gs1sqBNpHOWb2tjGB50r5MeZFcYe6ncOMaN7KQ3Yqt8
         a0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887712; x=1700492512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXRTaKo6j+tqF8f0KuNqtcbp0Qu6XSznJzofnpp1uYs=;
        b=nk3lmB1nja7oca5gk1DIY8ojHsIzmrvhYsCHZpE2qAe4PWtE/Y2utUlq6ZPJgX/dFT
         PPFtwvSPVx2Q6THDeoV/JsNQoBXi0svSlw9M3oXoc2lFfPIvURyvcvgSiT7KWQ4o1/68
         0aUYpb2lvNXAJcVOTfTwn6PdQI4M8ppKJIn9vJplRfbf1aNy3DSOjMNNu+D4AG5fb1sL
         jp9TJeZj1uxJjyjP4xO6bQj2YD1hwTeUibXbNSC4cuVttiPvBG58KmikW1eSG9Bnv6i0
         Ui5mxNH0rrpJS6HF/vLHoN94OFvmuMLy/d30gQYTQY0dfa7D+rAjudCO+yQ/uiquYnRl
         nP8g==
X-Gm-Message-State: AOJu0YzZXtOZbXWIAqXBHztW8zMIfvGDyVfR51yJBAv5EnqzP4i/x1t2
	j6Gl0+rDNbfGxUEyikvMxC9OYQrHPnjlIAcnNhH4uA==
X-Google-Smtp-Source: AGHT+IHEu49gyevap1zMCfOxyiE6xoEgy3wbBm1SlVPwdi996K+k6XAI9gLtTEksh9qY0qvkKyn3Mv3Fj9tn57Ddhks=
X-Received: by 2002:a05:6870:d0cc:b0:1ba:cc77:1d81 with SMTP id
 k12-20020a056870d0cc00b001bacc771d81mr9614071oaa.46.1699887712469; Mon, 13
 Nov 2023 07:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
 <CABBYNZKRwLmio749-YqGsVaRiyfgfG4xFZWWY8Svt5rK1z4B6A@mail.gmail.com>
 <7f4eab50-2532-4975-8bee-3f38bfaee3e1@mind.be> <CABBYNZ+LopfJdjzBocxKTzbA1Qq8A8Y-t182cvqLe5cH0mM2Wg@mail.gmail.com>
 <8325a09c-c944-4a6a-a815-0407edb9baa0@mind.be> <CABBYNZK=x-rDp0=JO5KxQzO6nAuFSp6EfTW2VHssRGLSJVOoew@mail.gmail.com>
 <CAJav_R4Dp1rddk67vNDPvwS4208pk7-aORXM0KiwXPaOkXmGkw@mail.gmail.com> <CABBYNZLBv7ZWJq1R_z6os5dJe7j7FyTZLMAG4Vw=t4y4W4Fh5Q@mail.gmail.com>
In-Reply-To: <CABBYNZLBv7ZWJq1R_z6os5dJe7j7FyTZLMAG4Vw=t4y4W4Fh5Q@mail.gmail.com>
From: Marleen Vos <marleen.vos@essensium.com>
Date: Mon, 13 Nov 2023 16:01:41 +0100
Message-ID: <CAJav_R7tqwv4Q5DRmbNSnQK=oSy2dypSLTtXT+9g4UAODq6dgA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] Fix a memory leak in Bluetooth L2CAP
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, "Olivier L'Heureux" <olivier.lheureux@mind.be>, 
	Arnout Vandecappelle <arnout@mind.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Nov 13, 2023 at 3:59=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marleen,
>
> On Mon, Nov 13, 2023 at 9:23=E2=80=AFAM Marleen Vos <marleen.vos@essensiu=
m.com> wrote:
> >
> > Hi Luiz,
> >
> > On Tue, Nov 7, 2023 at 4:10=E2=80=AFPM Luiz Augusto von Dentz <luiz.den=
tz@gmail.com> wrote:
> >>
> >> Hi Marleen,
> >>
> >> On Tue, Nov 7, 2023 at 3:46=E2=80=AFAM Marleen Vos <marleen.vos@essens=
ium.com> wrote:
> >> >
> >> > Hi Luiz,
> >> >
> >> > Because Olivier has been and still is being swamped with other work,=
 I'm
> >> > kind of trying to take over these patches. So far I can reproduce th=
e
> >> > memleak on a recent kernel without the patches.
> >> >
> >> > Olivier told me you added tests to check for the memleak in
> >> > l2cap-tester. Can you point me towards more info on how exactly you =
run
> >> > these tests, as the info I find on the web is rather minimal.
> >> >
> >> >  From what I read in the thread, it looks like your tests don't catc=
h
> >> > the memleak?
> >>
> >> I'm currently on vacation, I should be back next week, try checking
> >> l2cap-tester to emulate the leak as you said it was still
> >> reproducible.
> >
> >
> > I hope you had a great vacation!
> > Using git bisect, I found that commit 4ab81f16c68a602b2b69e333ae08d8748=
a9398de is the one where the leaks stop being reproducable by the method we=
 use. At first sight the changes you made seem unrelated to the memleak, so=
 the main question for us is now: has the resolution been accidental or int=
entional?
>
> So it is not reproducible anymore?

No, starting from the mentioned commit, we can no longer reproduce the leak=
.

>
> > The commit message says:
> > commit 4ab81f16c68a602b2b69e333ae08d8748a9398de
> > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Date:   Mon Jun 26 17:25:06 2023 -0700
> >
> >     Bluetooth: hci_conn: Consolidate code for aborting connections
> >
> >     [ Upstream commit a13f316e90fdb1fb6df6582e845aa9b3270f3581 ]
> >
> >     This consolidates code for aborting connections using
> >     hci_cmd_sync_queue so it is synchronized with other threads, but
> >     because of the fact that some commands may block the cmd_sync_queue
> >     while waiting specific events this attempt to cancel those requests=
 by
> >     using hci_cmd_sync_cancel.
> >
> >     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >     Stable-dep-of: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_d=
isconnect_all_sync")
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > Maybe you can shed some light on why this commit seems to fix the leaks=
?
>
> Well I suppose it is due to the cleanup process freeing l2cap_conn in
> the process, while perhaps the previous code didn't.
>
> > Kind regards,
> > Marleen
> >
> >>
> >>
> >> > Kind regards,
> >> >
> >> > Marleen
> >> >
> >> >
> >> > On 14/09/2023 23:17, Luiz Augusto von Dentz wrote:
> >> > > Hi Olivier,
> >> > >
> >> > > On Wed, Sep 13, 2023 at 3:25=E2=80=AFPM Olivier L'Heureux
> >> > > <olivier.lheureux@mind.be>  wrote:
> >> > >> Hello Luiz,
> >> > >>
> >> > >> Thanks for your review.
> >> > >>
> >> > >> On 05/09/2023 22:42, Luiz Augusto von Dentz wrote:
> >> > >>> Hi Olivier,
> >> > >>>
> >> > >>> On Mon, Sep 4, 2023 at 3:12=E2=80=AFPM Olivier L'Heureux
> >> > >>> <olivier.lheureux@mind.be>  wrote:
> >> > >>>> Request for Comments
> >> > >> [...]
> >> > >>>> The "ble-memleak-repro" program reproduces the memory leak, if =
the
> >> > >>>> kernel is not patched. Its source is in
> >> > >>>> "package/ble-memleak-repro/ble-memleak-repro.c" [18].
> >> > >>> We should probably create a test in l2cap-tester using SO_SNDTIM=
EO
> >> > >>> first, so we can make sure CI test such case and we are able to =
detect
> >> > >>> if the problem is reintroduced later:
> >> > >>>
> >> > >>> https://github.com/bluez/bluez/blob/master/tools/l2cap-tester.c
> >> > >> I didn't know about "l2cap-tester.c". Agree, it would be great to
> >> > >> integrate my test app into it. I could try, but I don't know the =
test
> >> > >> framework yet.
> >> > >>
> >> > >>>> Memory Leak Fix
> >> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > >>>>
> >> > >>>> We have fixed the memory leak, see the patch series in
> >> > >>>> "patches/linux/":
> >> > >>>>
> >> > >>>>    1. The first patch
> >> > >>>>       "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32=
m.patch" [11]
> >> > >>>>       enables Bluetooth on the DK2.
> >> > >>> This above should probably be sent separately.
> >> > >>>
> >> > >>>>    2. The second patch
> >> > >>>>       "0002-Bluetooth-add-many-traces-for-allocation-free-refco=
u.patch" [12]
> >> > >>>>       adds many dynamic debug traces that help understand the k=
ernel
> >> > >>>>       behaviour and freeing problems.
> >> > >>> I'm fine with this change, but we better use the likes of bt_dev=
_dbg
> >> > >>> instead of BT_DBG.
> >> > >> This commit intended to increase the visibility during debugging,=
 and
> >> > >> I was not intending it for a permanent presence in the kernel.
> >> > >> But if you find it useful, I can submit a patch RFC v2 with
> >> > >> "bt_dev_dbg()" instead of "BT_DBG()". Note that there is currentl=
y no
> >> > >> "bt_dev_dbg()" in "l2cap_core.c" yet.
> >> > >>
> >> > >>>>       "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-c=
o.patch" [13]
> >> > >>>>       and
> >> > >>>>       "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.=
patch" [14]
> >> > >>>>       fix the memory leak.
> >> > >>>>    4. Patches
> >> > >>>>       "0005-Bluetooth-introduce-hci_conn_free-for-better-struct=
u.patch" [15],
> >> > >>>>       "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_=
c.patch" [16]
> >> > >>>>       and
> >> > >>>>       "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.pa=
tch" [17]
> >> > >>>>       fixes the use-after-free that appears when the "struct l2=
cap_conn"
> >> > >>>>       [5] and "struct hci_conn" [6] objects are freed.
> >> > >>> These I'm not very comfortable applying as they are, I'm afraid =
there
> >> > >>> could be regressions if they are not accompanied with proper tes=
ts,
> >> > >>> besides I think there are less intrusive ways to cleanup l2cap_c=
onn,
> >> > >>> see below.
> >> > >>>
> >> > >>>> The commit messages explain why the commit is needed, which pro=
blem
> >> > >>>> the commit solves, and how.
> >> > >>>>
> >> > >>>> The first and second patches are present for the memory leak
> >> > >>>> reproduction only, they should not be part of a final fix.
> >> > >>>>
> >> > >>>> Patch Status
> >> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > >>>>
> >> > >>>> As of writing, the memory leak is fixed. The fix opened the doo=
r to
> >> > >>>> other problems, especially use-after-free, sometimes followed b=
y
> >> > >>>> crashes due to NULL dereferences. We think there are weak refer=
ences
> >> > >>>> (i.e. pointers that don't increment the refcounter) previously
> >> > >>>> pointing to memory that was never freed, but now is freed. On k=
ernels
> >> > >>>> v5.13 and v5.15, patches 0005, 0006 and 0007 seem to fix the
> >> > >>>> use-after-free and NULL dereferences, but not on kernel v6.5 ye=
t.
> >> > >>> I think the problem is that the lifetime of l2cap_conn shall be =
hooked
> >> > >>> with hci_chan, but the likes of hci_chan_list_flush -> hci_chan_=
del
> >> > >>> don't actually trigger l2cap_conn_del, which imo is the culprit =
here,
> >> > >>> because connect_cfm/disconnect_cfm is not called when the connec=
tion
> >> > >>> procedure has been aborted prematurely, so perhaps we shall get =
rid of
> >> > >>> the likes of l2cap_connect_cfm/l2cap_disconn_cfm and instead do =
the
> >> > >>> cleanup with in the following order:
> >> > >>> hci_conn_cleanup->hci_chan_list_flush->hci_chan_del->l2cap_conn_=
del,
> >> > >>> that way we avoid having multiple code paths attempting to clean=
up
> >> > >>> objects associated with hci_conn/hci_chan.
> >> > >> I fully agree with your analysis, which correspond to mine: we sh=
ould
> >> > >> call "l2cap_conn_del()", it would properly clean the allocations =
in
> >> > >> "l2cap_conn_add()".
> >> > >> I have tried but it was not obvious to find the right place to ca=
ll
> >> > >> "l2cap_conn_del()" with the proper locking.
> >> > >> As you write, connect_cfm/disconnect_cfm is not called when the
> >> > >> connection is aborted, and that is the root cause of the memory l=
eak.
> >> > > Btw, I was trying to reproduce it with the following test set, but=
 at
> >> > > least kmemleak was not able to detect leaks of l2cap_conn:
> >> > >
> >> > > https://patchwork.kernel.org/project/bluetooth/list/?series=3D7843=
43
> >> > >
> >> > >> Your proposal is most probably the best way to go.
> >> > >>
> >> > >>> I'd change hci_chan_create to take a del callback to avoid havin=
g
> >> > >>> circular dependencies on one another though.
> >> > >> Interesting, could you explain how you would do it? Perhaps point=
 on
> >> > >> a callback example?
> >> > >>
> >> > >>>> Reproducing with Buildroot
> >> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> > >>>>
> >> > >>>> We have reproduced and fixed the memory leak with Buildroot [7]=
 and a
> >> > >>>> "ble-memleak-repro" test application on an ST's Discovery Kit D=
K2 [4].
> >> > >>>>
> >> > >>>> The "ble-memleak-repro" repository [1] contains the sources of =
a
> >> > >>>> complete external Buildroot customisation [8], with the patches=
, a
> >> > >>>> README, and more explanations to reproduce the problem with Bui=
ldroot
> >> > >>>> on a DK2.
> >> > >>>>
> >> > >>>> References:
> >> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > >>>>
> >> > >>>> - [1]:<https://gitlab.com/essensium-mind/ble-memleak-repro.git>
> >> > >>>>          "ble-memleak-repro repository"
> >> > >> [...]
> >> > >>
> >> > >> --
> >> > >> Olivier L'Heureux
> >>
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
