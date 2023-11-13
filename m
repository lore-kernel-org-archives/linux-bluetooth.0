Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD42208AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkvKthUI"
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A77132
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 06:59:11 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5b7764016so54797281fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699887549; x=1700492349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZFFCUkuaPFkMGaGGqjOLMI6BX+lsWEOcHD1uz333kU=;
        b=jkvKthUIuNmOv0m5Ttl9rIyvEcerSDkZCAIu30gSbL+mK7FSjEI1yTVtvSxmUbv0m/
         riY9DL23EortoA0tBZUKuED7yQ8vruAqimBFXYg+x3D+kyN6JvU3hRUa1bgUeAij/5iH
         eeK3PU70VVNSG68eCa9+QgUvBvtjIH1sqGZSHAWQcJBwkbxW27tCJ2BO0caMld1ogMJf
         x4kY25xolDbsaPIOY+wKjoMhQhBS/U43XJzMEBeYaRDMEsFYtB+duZxfll386yXXOzz8
         tylZJp7frm1rKn2wDO9ocauaFKILlIo62sHtQkEllhNr2C8CwtBFKct5yQAr4xyp6Frh
         pKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887549; x=1700492349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZFFCUkuaPFkMGaGGqjOLMI6BX+lsWEOcHD1uz333kU=;
        b=sJ8PrRYz3qm+L8b6LCVNec86xQy/kc2tNVTWiCd77ceqZlqABohliv9LflzCGiZd/d
         TdjnTZ+dtUpLFBULA9d6o1eOnkafPa83JeuXqkO+eGOPawhsTYEhvpi/Oi6jaJSVww8B
         J2vUhfJXl6wA4XX+oeO1y85EvHx3xhtI+n4rJD92GPixbkKlzQWCnI1HJF4BHk95Gwiv
         hkdXCqa1csmVmsogoJ+SrL7/8PVDpqk36zliUP4MAZLKcxowfhWpMmPI9ZUCrraL9dEw
         soLXH4fryy9Eku7Pt8JNemkBZwuVHaATHqVaVW+jx3HiA4vuwoAE3du068SvTVNeRQvb
         qWkw==
X-Gm-Message-State: AOJu0YzGgyrIbPu26zLTOeW+CyytnxyGKCz8G5GtBQsbXxq85h58IVZa
	bb7Ny2WPK8GImubnNZvDP6l/XfOv0ChQ18a0Oog=
X-Google-Smtp-Source: AGHT+IGasprlfrC8+ZMpIyUSnOrsQ4dA8utZK/KBJ24B5xj8Fpjv0QtxldGf4zYgTpBd4JGai9FC7jqGACYBqY2y7/Y=
X-Received: by 2002:a2e:b17a:0:b0:2c5:2fcd:2598 with SMTP id
 a26-20020a2eb17a000000b002c52fcd2598mr5402472ljm.8.1699887548882; Mon, 13 Nov
 2023 06:59:08 -0800 (PST)
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
 <CAJav_R4Dp1rddk67vNDPvwS4208pk7-aORXM0KiwXPaOkXmGkw@mail.gmail.com>
In-Reply-To: <CAJav_R4Dp1rddk67vNDPvwS4208pk7-aORXM0KiwXPaOkXmGkw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Nov 2023 09:58:57 -0500
Message-ID: <CABBYNZLBv7ZWJq1R_z6os5dJe7j7FyTZLMAG4Vw=t4y4W4Fh5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] Fix a memory leak in Bluetooth L2CAP
To: Marleen Vos <marleen.vos@essensium.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, "Olivier L'Heureux" <olivier.lheureux@mind.be>, 
	Arnout Vandecappelle <arnout@mind.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marleen,

On Mon, Nov 13, 2023 at 9:23=E2=80=AFAM Marleen Vos <marleen.vos@essensium.=
com> wrote:
>
> Hi Luiz,
>
> On Tue, Nov 7, 2023 at 4:10=E2=80=AFPM Luiz Augusto von Dentz <luiz.dentz=
@gmail.com> wrote:
>>
>> Hi Marleen,
>>
>> On Tue, Nov 7, 2023 at 3:46=E2=80=AFAM Marleen Vos <marleen.vos@essensiu=
m.com> wrote:
>> >
>> > Hi Luiz,
>> >
>> > Because Olivier has been and still is being swamped with other work, I=
'm
>> > kind of trying to take over these patches. So far I can reproduce the
>> > memleak on a recent kernel without the patches.
>> >
>> > Olivier told me you added tests to check for the memleak in
>> > l2cap-tester. Can you point me towards more info on how exactly you ru=
n
>> > these tests, as the info I find on the web is rather minimal.
>> >
>> >  From what I read in the thread, it looks like your tests don't catch
>> > the memleak?
>>
>> I'm currently on vacation, I should be back next week, try checking
>> l2cap-tester to emulate the leak as you said it was still
>> reproducible.
>
>
> I hope you had a great vacation!
> Using git bisect, I found that commit 4ab81f16c68a602b2b69e333ae08d8748a9=
398de is the one where the leaks stop being reproducable by the method we u=
se. At first sight the changes you made seem unrelated to the memleak, so t=
he main question for us is now: has the resolution been accidental or inten=
tional?

So it is not reproducible anymore?

> The commit message says:
> commit 4ab81f16c68a602b2b69e333ae08d8748a9398de
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Jun 26 17:25:06 2023 -0700
>
>     Bluetooth: hci_conn: Consolidate code for aborting connections
>
>     [ Upstream commit a13f316e90fdb1fb6df6582e845aa9b3270f3581 ]
>
>     This consolidates code for aborting connections using
>     hci_cmd_sync_queue so it is synchronized with other threads, but
>     because of the fact that some commands may block the cmd_sync_queue
>     while waiting specific events this attempt to cancel those requests b=
y
>     using hci_cmd_sync_cancel.
>
>     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>     Stable-dep-of: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_dis=
connect_all_sync")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Maybe you can shed some light on why this commit seems to fix the leaks?

Well I suppose it is due to the cleanup process freeing l2cap_conn in
the process, while perhaps the previous code didn't.

> Kind regards,
> Marleen
>
>>
>>
>> > Kind regards,
>> >
>> > Marleen
>> >
>> >
>> > On 14/09/2023 23:17, Luiz Augusto von Dentz wrote:
>> > > Hi Olivier,
>> > >
>> > > On Wed, Sep 13, 2023 at 3:25=E2=80=AFPM Olivier L'Heureux
>> > > <olivier.lheureux@mind.be>  wrote:
>> > >> Hello Luiz,
>> > >>
>> > >> Thanks for your review.
>> > >>
>> > >> On 05/09/2023 22:42, Luiz Augusto von Dentz wrote:
>> > >>> Hi Olivier,
>> > >>>
>> > >>> On Mon, Sep 4, 2023 at 3:12=E2=80=AFPM Olivier L'Heureux
>> > >>> <olivier.lheureux@mind.be>  wrote:
>> > >>>> Request for Comments
>> > >> [...]
>> > >>>> The "ble-memleak-repro" program reproduces the memory leak, if th=
e
>> > >>>> kernel is not patched. Its source is in
>> > >>>> "package/ble-memleak-repro/ble-memleak-repro.c" [18].
>> > >>> We should probably create a test in l2cap-tester using SO_SNDTIMEO
>> > >>> first, so we can make sure CI test such case and we are able to de=
tect
>> > >>> if the problem is reintroduced later:
>> > >>>
>> > >>> https://github.com/bluez/bluez/blob/master/tools/l2cap-tester.c
>> > >> I didn't know about "l2cap-tester.c". Agree, it would be great to
>> > >> integrate my test app into it. I could try, but I don't know the te=
st
>> > >> framework yet.
>> > >>
>> > >>>> Memory Leak Fix
>> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >>>>
>> > >>>> We have fixed the memory leak, see the patch series in
>> > >>>> "patches/linux/":
>> > >>>>
>> > >>>>    1. The first patch
>> > >>>>       "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.=
patch" [11]
>> > >>>>       enables Bluetooth on the DK2.
>> > >>> This above should probably be sent separately.
>> > >>>
>> > >>>>    2. The second patch
>> > >>>>       "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.=
patch" [12]
>> > >>>>       adds many dynamic debug traces that help understand the ker=
nel
>> > >>>>       behaviour and freeing problems.
>> > >>> I'm fine with this change, but we better use the likes of bt_dev_d=
bg
>> > >>> instead of BT_DBG.
>> > >> This commit intended to increase the visibility during debugging, a=
nd
>> > >> I was not intending it for a permanent presence in the kernel.
>> > >> But if you find it useful, I can submit a patch RFC v2 with
>> > >> "bt_dev_dbg()" instead of "BT_DBG()". Note that there is currently =
no
>> > >> "bt_dev_dbg()" in "l2cap_core.c" yet.
>> > >>
>> > >>>>       "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.=
patch" [13]
>> > >>>>       and
>> > >>>>       "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.pa=
tch" [14]
>> > >>>>       fix the memory leak.
>> > >>>>    4. Patches
>> > >>>>       "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.=
patch" [15],
>> > >>>>       "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.=
patch" [16]
>> > >>>>       and
>> > >>>>       "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patc=
h" [17]
>> > >>>>       fixes the use-after-free that appears when the "struct l2ca=
p_conn"
>> > >>>>       [5] and "struct hci_conn" [6] objects are freed.
>> > >>> These I'm not very comfortable applying as they are, I'm afraid th=
ere
>> > >>> could be regressions if they are not accompanied with proper tests=
,
>> > >>> besides I think there are less intrusive ways to cleanup l2cap_con=
n,
>> > >>> see below.
>> > >>>
>> > >>>> The commit messages explain why the commit is needed, which probl=
em
>> > >>>> the commit solves, and how.
>> > >>>>
>> > >>>> The first and second patches are present for the memory leak
>> > >>>> reproduction only, they should not be part of a final fix.
>> > >>>>
>> > >>>> Patch Status
>> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >>>>
>> > >>>> As of writing, the memory leak is fixed. The fix opened the door =
to
>> > >>>> other problems, especially use-after-free, sometimes followed by
>> > >>>> crashes due to NULL dereferences. We think there are weak referen=
ces
>> > >>>> (i.e. pointers that don't increment the refcounter) previously
>> > >>>> pointing to memory that was never freed, but now is freed. On ker=
nels
>> > >>>> v5.13 and v5.15, patches 0005, 0006 and 0007 seem to fix the
>> > >>>> use-after-free and NULL dereferences, but not on kernel v6.5 yet.
>> > >>> I think the problem is that the lifetime of l2cap_conn shall be ho=
oked
>> > >>> with hci_chan, but the likes of hci_chan_list_flush -> hci_chan_de=
l
>> > >>> don't actually trigger l2cap_conn_del, which imo is the culprit he=
re,
>> > >>> because connect_cfm/disconnect_cfm is not called when the connecti=
on
>> > >>> procedure has been aborted prematurely, so perhaps we shall get ri=
d of
>> > >>> the likes of l2cap_connect_cfm/l2cap_disconn_cfm and instead do th=
e
>> > >>> cleanup with in the following order:
>> > >>> hci_conn_cleanup->hci_chan_list_flush->hci_chan_del->l2cap_conn_de=
l,
>> > >>> that way we avoid having multiple code paths attempting to cleanup
>> > >>> objects associated with hci_conn/hci_chan.
>> > >> I fully agree with your analysis, which correspond to mine: we shou=
ld
>> > >> call "l2cap_conn_del()", it would properly clean the allocations in
>> > >> "l2cap_conn_add()".
>> > >> I have tried but it was not obvious to find the right place to call
>> > >> "l2cap_conn_del()" with the proper locking.
>> > >> As you write, connect_cfm/disconnect_cfm is not called when the
>> > >> connection is aborted, and that is the root cause of the memory lea=
k.
>> > > Btw, I was trying to reproduce it with the following test set, but a=
t
>> > > least kmemleak was not able to detect leaks of l2cap_conn:
>> > >
>> > > https://patchwork.kernel.org/project/bluetooth/list/?series=3D784343
>> > >
>> > >> Your proposal is most probably the best way to go.
>> > >>
>> > >>> I'd change hci_chan_create to take a del callback to avoid having
>> > >>> circular dependencies on one another though.
>> > >> Interesting, could you explain how you would do it? Perhaps point o=
n
>> > >> a callback example?
>> > >>
>> > >>>> Reproducing with Buildroot
>> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> > >>>>
>> > >>>> We have reproduced and fixed the memory leak with Buildroot [7] a=
nd a
>> > >>>> "ble-memleak-repro" test application on an ST's Discovery Kit DK2=
 [4].
>> > >>>>
>> > >>>> The "ble-memleak-repro" repository [1] contains the sources of a
>> > >>>> complete external Buildroot customisation [8], with the patches, =
a
>> > >>>> README, and more explanations to reproduce the problem with Build=
root
>> > >>>> on a DK2.
>> > >>>>
>> > >>>> References:
>> > >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >>>>
>> > >>>> - [1]:<https://gitlab.com/essensium-mind/ble-memleak-repro.git>
>> > >>>>          "ble-memleak-repro repository"
>> > >> [...]
>> > >>
>> > >> --
>> > >> Olivier L'Heureux
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
