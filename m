Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA9EE3F0F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 19:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjILTTi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 15:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjILTTg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 15:19:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C140718D
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 12:19:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bfb12b24e5so6932891fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546371; x=1695151171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k87CQb77XRGb4GR9WtiivdV23/3YmFziINx8fw/T63M=;
        b=V3BHsJT4/6XsYYcv3UqTlgmPIvxDhh20fXV+LKJCTFuvES3vmpeNDjj3RTLE7BYNsG
         nVH3Qym9RWYdFI+I7vOlwOx8xWQtXEnnUr3q/JCkoMtom7uf6o6bng+iUFrqpZCnBeyX
         CpjJFbN1PaWml4POKEHbFMYvbMmjop9JaCCYs2QxStEb10wFsb0PCuedXd/RQgbCfZ9X
         pgWKEjstOmAbHaivKqootEo3sBH/0ADJCAZ7RX0uxw13GM8IsfQOuTh12K0fwKKaf0mC
         D9WkVjfowWjQuVs8V0Vzuy9WzRKUaePuxth6Lhketm+I2mHjah11456t4trL5E8UsBCc
         yZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546371; x=1695151171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k87CQb77XRGb4GR9WtiivdV23/3YmFziINx8fw/T63M=;
        b=Sq+dIaAodqbmakmna2OfPqM4XQBi0aiEA5J447j0B2F9eYs91SqELukSDT7y/lsIIc
         kbESABY5zzkZNaSvTF1vseTGVh8nZ0PxhQ7SKn5YHEghtUfUrVYjkrQSN8QO98z039YM
         nhea+Ll/bFxDn9XgnXwPRz7BGO8sFKc/zIXsShBZVoLJut04wyk520gjcDzcDM9A6d2l
         tvamDak/KWqk6RrKy1iIx0hFHmjPrrtWmR3HkLrTUADsuBbM4mf4+bFqckM1TeNK0Xop
         +F5L8cICzCnNoJquS58cAsFM1v+OO+vH6UU6BMihKtIWZ8e9flVelY6xgmYPUIuyQxHm
         HlyA==
X-Gm-Message-State: AOJu0YxX9U9dcyYxjcE9LclBSCqZ5Xi/jS08A+UUHfR9O5wj3uPJyZbs
        B3Q5yM0C59WsXEZKgHSXIehstbenma5RV8E2max0LA+d
X-Google-Smtp-Source: AGHT+IEJzPao3ahtHVXtTRI4XWKLT9KzF9gCJJ8u4FpZOnQ+8gZVS3oWpo7OBH2RCPQggIIk7Ev1TEAdah/lTucgkRU=
X-Received: by 2002:a2e:7302:0:b0:2bf:a0d1:b12a with SMTP id
 o2-20020a2e7302000000b002bfa0d1b12amr544793ljc.44.1694546370618; Tue, 12 Sep
 2023 12:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230904221158.35425-1-olivier.lheureux@mind.be> <CABBYNZKRwLmio749-YqGsVaRiyfgfG4xFZWWY8Svt5rK1z4B6A@mail.gmail.com>
In-Reply-To: <CABBYNZKRwLmio749-YqGsVaRiyfgfG4xFZWWY8Svt5rK1z4B6A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Sep 2023 12:19:18 -0700
Message-ID: <CABBYNZKThP+smouTYj9eSFoQVxnf=UKG4vHvBMP031PhAk4t4g@mail.gmail.com>
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

On Tue, Sep 5, 2023 at 1:42=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Olivier,
>
> On Mon, Sep 4, 2023 at 3:12=E2=80=AFPM Olivier L'Heureux
> <olivier.lheureux@mind.be> wrote:
> >
> > Request for Comments
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > We have found a memory leak in the Bluetooth L2CAP subsystem and fixed
> > it, but this opened the doors to use-after-free problems, which are
> > not completely fixed yet. This patch series present a way to reproduce
> > it, the proposed fix and the status. There is more detailed
> > documentation in [1].
> >
> > Memory Leak Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > We have found a memory leak in the L2CAP layer of Linux's Bluetooth
> > Subsystem, the same as reported by syzbot in "[syzbot] [bluetooth?]
> > memory leak in hci_conn_add (2)" (2023-09-02 23:25:00 -0700) [19].
> >
> > We can reproduce it. When, in a loop, a user-mode program:
> >
> >  1. Opens a Bluetooth socket at the L2CAP layer:
> >
> >           sockfd =3D socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP=
);
> >
> >  2. Set a timeout on the socket:
> >
> >           timeout.tv_sec  =3D 2;
> >           timeout.tv_usec =3D 0;
> >
> >           err =3D setsockopt(sockfd, SOL_SOCKET, SO_SNDTIMEO, &timeout,=
 sizeof(timeout));
> >
> >  3. Connect to a specific Bluetooth address:
> >
> >           struct sockaddr_l2 ble_addr;
> >
> >           memset(&ble_addr, 0, sizeof(ble_addr));
> >           ble_addr.l2_family =3D AF_BLUETOOTH;
> >           ble_addr.l2_psm =3D htobs(0x80 /* L2CAP_PSM_LE_DYN_START */);
> >           // l2_bdaddr=3D00:0a:07:a3:22:00
> >           ble_addr.l2_bdaddr =3D *(bdaddr_t*)("\x00\x0a\x07\xa3\x22\x00=
");
> >           ble_addr.l2_cid =3D htobs(0);
> >           ble_addr.l2_bdaddr_type =3D BDADDR_LE_PUBLIC;
> >
> >           err =3D connect(sockfd, (struct sockaddr*)&ble_addr, sizeof(b=
le_addr));
> >
> > and when the user program does those three steps in a loop, then the
> > kernel leaks the "struct l2cap_conn" [5] and "struct hci_conn" [6]
> > objects allocated in "l2cap_conn_add()" [2] and "hci_conn_add()" [3].
> > Those objects are never freed.
> >
> > The "ble-memleak-repro" program reproduces the memory leak, if the
> > kernel is not patched. Its source is in
> > "package/ble-memleak-repro/ble-memleak-repro.c" [18].
>
> We should probably create a test in l2cap-tester using SO_SNDTIMEO
> first, so we can make sure CI test such case and we are able to detect
> if the problem is reintroduced later:
>
> https://github.com/bluez/bluez/blob/master/tools/l2cap-tester.c
>
> > Memory Leak Fix
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > We have fixed the memory leak, see the patch series in
> > "patches/linux/":
> >
> >  1. The first patch
> >     "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.patch" [=
11]
> >     enables Bluetooth on the DK2.
>
> This above should probably be sent separately.
>
> >  2. The second patch
> >     "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.patch" [=
12]
> >     adds many dynamic debug traces that help understand the kernel
> >     behaviour and freeing problems.
>
> I'm fine with this change, but we better use the likes of bt_dev_dbg
> instead of BT_DBG.
>
> >  3. Patches
> >     "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.patch" [=
13]
> >     and
> >     "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch" [14=
]
> >     fix the memory leak.
> >  4. Patches
> >     "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.patch" [=
15],
> >     "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.patch" [=
16]
> >     and
> >     "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch" [17]
> >     fixes the use-after-free that appears when the "struct l2cap_conn"
> >     [5] and "struct hci_conn" [6] objects are freed.
>
> These I'm not very comfortable applying as they are, I'm afraid there
> could be regressions if they are not accompanied with proper tests,
> besides I think there are less intrusive ways to cleanup l2cap_conn,
> see below.
>
> > The commit messages explain why the commit is needed, which problem
> > the commit solves, and how.
> >
> > The first and second patches are present for the memory leak
> > reproduction only, they should not be part of a final fix.
> >
> > Patch Status
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > As of writing, the memory leak is fixed. The fix opened the door to
> > other problems, especially use-after-free, sometimes followed by
> > crashes due to NULL dereferences. We think there are weak references
> > (i.e. pointers that don't increment the refcounter) previously
> > pointing to memory that was never freed, but now is freed. On kernels
> > v5.13 and v5.15, patches 0005, 0006 and 0007 seem to fix the
> > use-after-free and NULL dereferences, but not on kernel v6.5 yet.
>
> I think the problem is that the lifetime of l2cap_conn shall be hooked
> with hci_chan, but the likes of hci_chan_list_flush -> hci_chan_del
> don't actually trigger l2cap_conn_del, which imo is the culprit here,
> because connect_cfm/disconnect_cfm is not called when the connection
> procedure has been aborted prematurely, so perhaps we shall get rid of
> the likes of l2cap_connect_cfm/l2cap_disconn_cfm and instead do the
> cleanup with in the following order:
> hci_conn_cleanup->hci_chan_list_flush->hci_chan_del->l2cap_conn_del,
> that way we avoid having multiple code paths attempting to cleanup
> objects associated with hci_conn/hci_chan.
>
> I'd change hci_chan_create to take a del callback to avoid having
> circular dependencies on one another though.

Are you still planning to work on these changes, or perhaps you need
more guidance regarding the suggested modifications?

> > Reproducing with Buildroot
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > We have reproduced and fixed the memory leak with Buildroot [7] and a
> > "ble-memleak-repro" test application on an ST's Discovery Kit DK2 [4].
> >
> > The "ble-memleak-repro" repository [1] contains the sources of a
> > complete external Buildroot customisation [8], with the patches, a
> > README, and more explanations to reproduce the problem with Buildroot
> > on a DK2.
> >
> > References:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - [1]: <https://gitlab.com/essensium-mind/ble-memleak-repro.git>
> >        "ble-memleak-repro repository"
> >
> > - [2]: <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2ca=
p_core.c#L7833>
> >        "l2cap_conn_add()"
> >
> > - [3]: <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/hci_=
conn.c#L986>
> >        "hci_conn_add()"
> >
> > - [4]: <https://www.st.com/content/st_com/en/products/evaluation-tools/=
product-evaluation-tools/mcu-mpu-eval-tools/stm32-mcu-mpu-eval-tools/stm32-=
discovery-kits/stm32mp157c-dk2.html>
> >        "STM32MP157C-DK2 (DK2)"
> >
> > - [5]: <https://elixir.bootlin.com/linux/v6.5/source/include/net/blueto=
oth/l2cap.h#L674>
> >        "struct l2cap_conn"
> >
> > - [6]: <https://elixir.bootlin.com/linux/v6.5/source/include/net/blueto=
oth/hci_core.h#L685>
> >        "struct hci_conn"
> >
> > - [7]: <https://buildroot.org/>
> >        "Buildroot is a tool to generate embedded Linux systems"
> >
> > - [8]: <https://buildroot.org/downloads/manual/manual.html#outside-br-c=
ustom>
> >        "9.2. Keeping customizations outside of Buildroot"
> >
> > - [11]: <patches/linux/0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-=
on-stm32m.patch>
> >         "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.patc=
h"
> >
> > - [12]: <patches/linux/0002-Bluetooth-add-many-traces-for-allocation-fr=
ee-refcou.patch>
> >         "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.patc=
h"
> >
> > - [13]: <patches/linux/0003-Bluetooth-L2CAP-use-refcount-on-struct-l2ca=
p_chan-co.patch>
> >         "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.patc=
h"
> >
> > - [14]: <patches/linux/0004-Bluetooth-L2CAP-free-the-leaking-struct-l2c=
ap_conn.patch>
> >         "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch"
> >
> > - [15]: <patches/linux/0005-Bluetooth-introduce-hci_conn_free-for-bette=
r-structu.patch>
> >         "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.patc=
h"
> >
> > - [16]: <patches/linux/0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struc=
t-l2cap_c.patch>
> >         "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.patc=
h"
> >
> > - [17]: <patches/linux/0007-Bluetooth-unlink-objects-to-avoid-use-after=
-free.patch>
> >         "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch"
> >
> > - [18]: <https://gitlab.com/essensium-mind/ble-memleak-repro/-/blob/mai=
n/package/ble-memleak-repro/ble-memleak-repro.c?ref_type=3Dheads>
> >         "ble-memleak-repro.c"
> >
> > - [19]: <https://lore.kernel.org/linux-bluetooth/0000000000000fd0120604=
6e7410@google.com/T/#u>
> >         "[syzbot] [bluetooth?] memory leak in hci_conn_add (2)"
> >         2023-09-02 23:25:00 -0700
> >
> > ---
> >
> > Christophe Roullier (1):
> >   ARM: dts: stm32: Add Bluetooth (usart2) feature on stm32mp157x
> >
> > Olivier L'Heureux (6):
> >   Bluetooth: add many traces for allocation/free/refcounting
> >   Bluetooth: L2CAP: use refcount on struct l2cap_chan->conn
> >   Bluetooth: L2CAP: free the leaking struct l2cap_conn
> >   Bluetooth: introduce hci_conn_free() for better structure
> >   Bluetooth: L2CAP: inc refcount if reuse struct l2cap_conn
> >   Bluetooth: unlink objects to avoid use-after-free
> >
> >  arch/arm/boot/dts/st/stm32mp157c-dk2.dts | 11 ++++++-
> >  include/net/bluetooth/hci_core.h         |  7 +++--
> >  net/bluetooth/hci_conn.c                 | 18 ++++++++++++
> >  net/bluetooth/hci_sysfs.c                |  8 ++++-
> >  net/bluetooth/l2cap_core.c               | 37 ++++++++++++++++++++----
> >  5 files changed, 72 insertions(+), 9 deletions(-)
> >
> >
> > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > --
> > 2.39.2
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
