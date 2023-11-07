Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A6DF72
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhK2ybqB"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F926B2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 07:10:40 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c6cb4a79deso62305061fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Nov 2023 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699369838; x=1699974638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwCFDC+CuFqArMfm+eD49Q8l6abqD3QVMce5Gdl/OHs=;
        b=DhK2ybqBYEBCVCBK6y4Qz5nmiCqwExbTR5+Hvm2RxE/hSzLsV3bGEDNWBZpAHCm72j
         cn+f9n5yS0tNslluPkcfOm/2Ccv9gAwSZPfl1F+bTXm8VwQ7ZkYXvbtq38YGdTeG2Emk
         b9TtFfZn0bP3PNTra5RMGjOCdwIN5RcF1SYOXw+SgaCGdI4YCxO1cQlbMD8+o+Y3/NMY
         H+CZRg7hqvJ16xNiXkadwLOmw7AxVWouRjCIuzoUoCJnwZe1zwblazNYemhPsJHAqK8X
         llYYZx6Uu9pOJHNbbXWciDoUI5p7RbTTCs32nUc32aBjGxdpez1Yu541BfIehs0K06a4
         Y58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699369838; x=1699974638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwCFDC+CuFqArMfm+eD49Q8l6abqD3QVMce5Gdl/OHs=;
        b=BIZgcqrzdrsTmXw7pAqPDkLeOrsB2yTgeVabXwDU88ixPxljlH04QpOOcQ6ZX1xX0N
         jlLN+sVYs8T1l5BquIeBDWYhxOnSS7umxDwfZW6oKiNpCQu4+yvNgVzqfxgZ83Az1/OR
         /lZXtvuzy0oU/opmZhDfEYYTS6Zr+5klR4EguODwMfJwiyFfjNpxOSxSvNEGdoQNVH/I
         6+qGsh9E5uBLuU6Fs3FaJysix6l6Qb/fffrM00FSZ4XZYsZxOKL6XRJUuCqGM4FL81DO
         GOvDJB6v0LVxTmQayixyKL0smv0E4TGnillp0W2Ad38ndGJIbtywCzU7x+iuTeDvKN3A
         ul1w==
X-Gm-Message-State: AOJu0YyHwVQJ9wj3jKFfVVTomyXwO1ZFzuyeinIyV40tFSGvB/e/1Jhw
	UMs62NxuE3SP1o9+Ab6qwDTFzzuu0RntCuEKA50FJ0XlVCk=
X-Google-Smtp-Source: AGHT+IEPWt+LBMsvVmTugtqb3w7k75NwCD2nuvc0x7uRnxIIF0zxVtuDft4awUB8/M16gTpgrcuPe3x4j/7+/2Zszkc=
X-Received: by 2002:a2e:3a04:0:b0:2bf:f861:f523 with SMTP id
 h4-20020a2e3a04000000b002bff861f523mr1050312lja.4.1699369838325; Tue, 07 Nov
 2023 07:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
 <CABBYNZKRwLmio749-YqGsVaRiyfgfG4xFZWWY8Svt5rK1z4B6A@mail.gmail.com>
 <7f4eab50-2532-4975-8bee-3f38bfaee3e1@mind.be> <CABBYNZ+LopfJdjzBocxKTzbA1Qq8A8Y-t182cvqLe5cH0mM2Wg@mail.gmail.com>
 <8325a09c-c944-4a6a-a815-0407edb9baa0@mind.be>
In-Reply-To: <8325a09c-c944-4a6a-a815-0407edb9baa0@mind.be>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Nov 2023 10:10:25 -0500
Message-ID: <CABBYNZK=x-rDp0=JO5KxQzO6nAuFSp6EfTW2VHssRGLSJVOoew@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] Fix a memory leak in Bluetooth L2CAP
To: Marleen Vos <marleen.vos@essensium.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, "Olivier L'Heureux" <olivier.lheureux@mind.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marleen,

On Tue, Nov 7, 2023 at 3:46=E2=80=AFAM Marleen Vos <marleen.vos@essensium.c=
om> wrote:
>
> Hi Luiz,
>
> Because Olivier has been and still is being swamped with other work, I'm
> kind of trying to take over these patches. So far I can reproduce the
> memleak on a recent kernel without the patches.
>
> Olivier told me you added tests to check for the memleak in
> l2cap-tester. Can you point me towards more info on how exactly you run
> these tests, as the info I find on the web is rather minimal.
>
>  From what I read in the thread, it looks like your tests don't catch
> the memleak?

I'm currently on vacation, I should be back next week, try checking
l2cap-tester to emulate the leak as you said it was still
reproducible.

> Kind regards,
>
> Marleen
>
>
> On 14/09/2023 23:17, Luiz Augusto von Dentz wrote:
> > Hi Olivier,
> >
> > On Wed, Sep 13, 2023 at 3:25=E2=80=AFPM Olivier L'Heureux
> > <olivier.lheureux@mind.be>  wrote:
> >> Hello Luiz,
> >>
> >> Thanks for your review.
> >>
> >> On 05/09/2023 22:42, Luiz Augusto von Dentz wrote:
> >>> Hi Olivier,
> >>>
> >>> On Mon, Sep 4, 2023 at 3:12=E2=80=AFPM Olivier L'Heureux
> >>> <olivier.lheureux@mind.be>  wrote:
> >>>> Request for Comments
> >> [...]
> >>>> The "ble-memleak-repro" program reproduces the memory leak, if the
> >>>> kernel is not patched. Its source is in
> >>>> "package/ble-memleak-repro/ble-memleak-repro.c" [18].
> >>> We should probably create a test in l2cap-tester using SO_SNDTIMEO
> >>> first, so we can make sure CI test such case and we are able to detec=
t
> >>> if the problem is reintroduced later:
> >>>
> >>> https://github.com/bluez/bluez/blob/master/tools/l2cap-tester.c
> >> I didn't know about "l2cap-tester.c". Agree, it would be great to
> >> integrate my test app into it. I could try, but I don't know the test
> >> framework yet.
> >>
> >>>> Memory Leak Fix
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> We have fixed the memory leak, see the patch series in
> >>>> "patches/linux/":
> >>>>
> >>>>    1. The first patch
> >>>>       "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.pat=
ch" [11]
> >>>>       enables Bluetooth on the DK2.
> >>> This above should probably be sent separately.
> >>>
> >>>>    2. The second patch
> >>>>       "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.pat=
ch" [12]
> >>>>       adds many dynamic debug traces that help understand the kernel
> >>>>       behaviour and freeing problems.
> >>> I'm fine with this change, but we better use the likes of bt_dev_dbg
> >>> instead of BT_DBG.
> >> This commit intended to increase the visibility during debugging, and
> >> I was not intending it for a permanent presence in the kernel.
> >> But if you find it useful, I can submit a patch RFC v2 with
> >> "bt_dev_dbg()" instead of "BT_DBG()". Note that there is currently no
> >> "bt_dev_dbg()" in "l2cap_core.c" yet.
> >>
> >>>>       "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.pat=
ch" [13]
> >>>>       and
> >>>>       "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch=
" [14]
> >>>>       fix the memory leak.
> >>>>    4. Patches
> >>>>       "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.pat=
ch" [15],
> >>>>       "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.pat=
ch" [16]
> >>>>       and
> >>>>       "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch" =
[17]
> >>>>       fixes the use-after-free that appears when the "struct l2cap_c=
onn"
> >>>>       [5] and "struct hci_conn" [6] objects are freed.
> >>> These I'm not very comfortable applying as they are, I'm afraid there
> >>> could be regressions if they are not accompanied with proper tests,
> >>> besides I think there are less intrusive ways to cleanup l2cap_conn,
> >>> see below.
> >>>
> >>>> The commit messages explain why the commit is needed, which problem
> >>>> the commit solves, and how.
> >>>>
> >>>> The first and second patches are present for the memory leak
> >>>> reproduction only, they should not be part of a final fix.
> >>>>
> >>>> Patch Status
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> As of writing, the memory leak is fixed. The fix opened the door to
> >>>> other problems, especially use-after-free, sometimes followed by
> >>>> crashes due to NULL dereferences. We think there are weak references
> >>>> (i.e. pointers that don't increment the refcounter) previously
> >>>> pointing to memory that was never freed, but now is freed. On kernel=
s
> >>>> v5.13 and v5.15, patches 0005, 0006 and 0007 seem to fix the
> >>>> use-after-free and NULL dereferences, but not on kernel v6.5 yet.
> >>> I think the problem is that the lifetime of l2cap_conn shall be hooke=
d
> >>> with hci_chan, but the likes of hci_chan_list_flush -> hci_chan_del
> >>> don't actually trigger l2cap_conn_del, which imo is the culprit here,
> >>> because connect_cfm/disconnect_cfm is not called when the connection
> >>> procedure has been aborted prematurely, so perhaps we shall get rid o=
f
> >>> the likes of l2cap_connect_cfm/l2cap_disconn_cfm and instead do the
> >>> cleanup with in the following order:
> >>> hci_conn_cleanup->hci_chan_list_flush->hci_chan_del->l2cap_conn_del,
> >>> that way we avoid having multiple code paths attempting to cleanup
> >>> objects associated with hci_conn/hci_chan.
> >> I fully agree with your analysis, which correspond to mine: we should
> >> call "l2cap_conn_del()", it would properly clean the allocations in
> >> "l2cap_conn_add()".
> >> I have tried but it was not obvious to find the right place to call
> >> "l2cap_conn_del()" with the proper locking.
> >> As you write, connect_cfm/disconnect_cfm is not called when the
> >> connection is aborted, and that is the root cause of the memory leak.
> > Btw, I was trying to reproduce it with the following test set, but at
> > least kmemleak was not able to detect leaks of l2cap_conn:
> >
> > https://patchwork.kernel.org/project/bluetooth/list/?series=3D784343
> >
> >> Your proposal is most probably the best way to go.
> >>
> >>> I'd change hci_chan_create to take a del callback to avoid having
> >>> circular dependencies on one another though.
> >> Interesting, could you explain how you would do it? Perhaps point on
> >> a callback example?
> >>
> >>>> Reproducing with Buildroot
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>>>
> >>>> We have reproduced and fixed the memory leak with Buildroot [7] and =
a
> >>>> "ble-memleak-repro" test application on an ST's Discovery Kit DK2 [4=
].
> >>>>
> >>>> The "ble-memleak-repro" repository [1] contains the sources of a
> >>>> complete external Buildroot customisation [8], with the patches, a
> >>>> README, and more explanations to reproduce the problem with Buildroo=
t
> >>>> on a DK2.
> >>>>
> >>>> References:
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> - [1]:<https://gitlab.com/essensium-mind/ble-memleak-repro.git>
> >>>>          "ble-memleak-repro repository"
> >> [...]
> >>
> >> --
> >> Olivier L'Heureux



--=20
Luiz Augusto von Dentz
