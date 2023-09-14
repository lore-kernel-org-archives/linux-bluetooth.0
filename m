Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92490EEAA77
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 21:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjINVR3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjINVR2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 17:17:28 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB12A26B2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:17:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bfb1167277so23402961fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694726242; x=1695331042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfcL5xeSxjD/jHpkf123r5JPZ8uZu0YfkTDuBfy1ak0=;
        b=sZJ0y7rHm/CgevwLP5pb9lB+0r2EvUirwxXBA4E24WhKhQM6+k1lO2qvakM8WR04D5
         uRt3GKFuTbB3ypfXiWGuv+al0MumiQSwiKU44NnCJxVe6kwxpwMTMR5Rhb7uBMbnazos
         gRiCbk5tsHSZ85932kTMo+p3j18ks6uwzD8gPXTvR7iy0DAF/wVkvd5ddSrTmFk4/jOd
         IGHeku0wnWVAap3DYMbOo8BJ/op4zXqXrCk61Qq1HcTvPtvOUqCh441+uf1X8zmp9Eqc
         DaJfDtDs98fOxjIVZfYWY45sJVa+hdymy4uzNaHrFxGUFmUZYO3ah9trr/R8kX5ZndZu
         e3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726242; x=1695331042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfcL5xeSxjD/jHpkf123r5JPZ8uZu0YfkTDuBfy1ak0=;
        b=I6SYyfo9/UcY/rhvM5IhS/YcswSLBf2m4VGjQlpe1XC+lyRC1KTbHTL2vOB9Oh9EJ2
         0Ql7xVV67cn5tjOzHWPJ/G2zKFPmeUtt/RWMSlKb3UEq931AAT5FdxrYGZRdtYhnsRWX
         cyFPpp2wePH3fECE52QXJk/kY4owslsf0Y22Z0WhbSyLzir+XYgVBw+T0PuxOTS57ZDK
         7v7QPeoeg6aUxbjJM5lyfaQxj3Zw28UxyFEPOaMSST3ZedIsHN7UUeuXWxL+SNhCEFwK
         AqQxglBDh8dVJEoYAyau6RIVvycwyZnhsS0u0HcnV/AoaGbn5EuE//AehHzkczKzxV/D
         BFBA==
X-Gm-Message-State: AOJu0YwiJcFphDItcbEQ2PE31lrp8bL9bEbwafKwXENqftErWDuM3075
        Kla5CNnLWjmmQ8JsUJzcSBzvAz4DvaXlkf8jOMY=
X-Google-Smtp-Source: AGHT+IH+MvCkHxzBHI+zb1BAa8eCZWgj4MHLUm5VqErsxkBZZJ2lHMDiY2YqY9z/9CccnfMCPt+/Oq0Ox9m0l4rndso=
X-Received: by 2002:a2e:8194:0:b0:2ba:6519:c50f with SMTP id
 e20-20020a2e8194000000b002ba6519c50fmr6048076ljg.52.1694726241717; Thu, 14
 Sep 2023 14:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
 <CABBYNZKRwLmio749-YqGsVaRiyfgfG4xFZWWY8Svt5rK1z4B6A@mail.gmail.com> <7f4eab50-2532-4975-8bee-3f38bfaee3e1@mind.be>
In-Reply-To: <7f4eab50-2532-4975-8bee-3f38bfaee3e1@mind.be>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 14 Sep 2023 14:17:09 -0700
Message-ID: <CABBYNZ+LopfJdjzBocxKTzbA1Qq8A8Y-t182cvqLe5cH0mM2Wg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] Fix a memory leak in Bluetooth L2CAP
To:     "Olivier L'Heureux" <olivier.lheureux@mind.be>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Olivier,

On Wed, Sep 13, 2023 at 3:25=E2=80=AFPM Olivier L'Heureux
<olivier.lheureux@mind.be> wrote:
>
> Hello Luiz,
>
> Thanks for your review.
>
> On 05/09/2023 22:42, Luiz Augusto von Dentz wrote:
> > Hi Olivier,
> >
> > On Mon, Sep 4, 2023 at 3:12=E2=80=AFPM Olivier L'Heureux
> > <olivier.lheureux@mind.be> wrote:
> >>
> >> Request for Comments
> [...]
> >>
> >> The "ble-memleak-repro" program reproduces the memory leak, if the
> >> kernel is not patched. Its source is in
> >> "package/ble-memleak-repro/ble-memleak-repro.c" [18].
> >
> > We should probably create a test in l2cap-tester using SO_SNDTIMEO
> > first, so we can make sure CI test such case and we are able to detect
> > if the problem is reintroduced later:
> >
> > https://github.com/bluez/bluez/blob/master/tools/l2cap-tester.c
>
> I didn't know about "l2cap-tester.c". Agree, it would be great to
> integrate my test app into it. I could try, but I don't know the test
> framework yet.
>
> >> Memory Leak Fix
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> We have fixed the memory leak, see the patch series in
> >> "patches/linux/":
> >>
> >>   1. The first patch
> >>      "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.patch"=
 [11]
> >>      enables Bluetooth on the DK2.
> >
> > This above should probably be sent separately.
> >
> >>   2. The second patch
> >>      "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.patch"=
 [12]
> >>      adds many dynamic debug traces that help understand the kernel
> >>      behaviour and freeing problems.
> >
> > I'm fine with this change, but we better use the likes of bt_dev_dbg
> > instead of BT_DBG.
>
> This commit intended to increase the visibility during debugging, and
> I was not intending it for a permanent presence in the kernel.
> But if you find it useful, I can submit a patch RFC v2 with
> "bt_dev_dbg()" instead of "BT_DBG()". Note that there is currently no
> "bt_dev_dbg()" in "l2cap_core.c" yet.
>
> >>      "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.patch"=
 [13]
> >>      and
> >>      "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch" [=
14]
> >>      fix the memory leak.
> >>   4. Patches
> >>      "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.patch"=
 [15],
> >>      "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.patch"=
 [16]
> >>      and
> >>      "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch" [17=
]
> >>      fixes the use-after-free that appears when the "struct l2cap_conn=
"
> >>      [5] and "struct hci_conn" [6] objects are freed.
> >
> > These I'm not very comfortable applying as they are, I'm afraid there
> > could be regressions if they are not accompanied with proper tests,
> > besides I think there are less intrusive ways to cleanup l2cap_conn,
> > see below.
> >
> >> The commit messages explain why the commit is needed, which problem
> >> the commit solves, and how.
> >>
> >> The first and second patches are present for the memory leak
> >> reproduction only, they should not be part of a final fix.
> >>
> >> Patch Status
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> As of writing, the memory leak is fixed. The fix opened the door to
> >> other problems, especially use-after-free, sometimes followed by
> >> crashes due to NULL dereferences. We think there are weak references
> >> (i.e. pointers that don't increment the refcounter) previously
> >> pointing to memory that was never freed, but now is freed. On kernels
> >> v5.13 and v5.15, patches 0005, 0006 and 0007 seem to fix the
> >> use-after-free and NULL dereferences, but not on kernel v6.5 yet.
> >
> > I think the problem is that the lifetime of l2cap_conn shall be hooked
> > with hci_chan, but the likes of hci_chan_list_flush -> hci_chan_del
> > don't actually trigger l2cap_conn_del, which imo is the culprit here,
> > because connect_cfm/disconnect_cfm is not called when the connection
> > procedure has been aborted prematurely, so perhaps we shall get rid of
> > the likes of l2cap_connect_cfm/l2cap_disconn_cfm and instead do the
> > cleanup with in the following order:
> > hci_conn_cleanup->hci_chan_list_flush->hci_chan_del->l2cap_conn_del,
> > that way we avoid having multiple code paths attempting to cleanup
> > objects associated with hci_conn/hci_chan.
>
> I fully agree with your analysis, which correspond to mine: we should
> call "l2cap_conn_del()", it would properly clean the allocations in
> "l2cap_conn_add()".
> I have tried but it was not obvious to find the right place to call
> "l2cap_conn_del()" with the proper locking.
> As you write, connect_cfm/disconnect_cfm is not called when the
> connection is aborted, and that is the root cause of the memory leak.

Btw, I was trying to reproduce it with the following test set, but at
least kmemleak was not able to detect leaks of l2cap_conn:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D784343

> Your proposal is most probably the best way to go.
>
> > I'd change hci_chan_create to take a del callback to avoid having
> > circular dependencies on one another though.
>
> Interesting, could you explain how you would do it? Perhaps point on
> a callback example?
>
> >> Reproducing with Buildroot
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>
> >> We have reproduced and fixed the memory leak with Buildroot [7] and a
> >> "ble-memleak-repro" test application on an ST's Discovery Kit DK2 [4].
> >>
> >> The "ble-memleak-repro" repository [1] contains the sources of a
> >> complete external Buildroot customisation [8], with the patches, a
> >> README, and more explanations to reproduce the problem with Buildroot
> >> on a DK2.
> >>
> >> References:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> - [1]: <https://gitlab.com/essensium-mind/ble-memleak-repro.git>
> >>         "ble-memleak-repro repository"
> [...]
>
> --
> Olivier L'Heureux



--=20
Luiz Augusto von Dentz
