Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513257;
	b=pZNeWdGSmRXsQVNR/7+q03oFtQfmGG10AMvpEMe1U+cZdcGTBYVlv6DOPCeIo5K2mM4m
	 NOd10yG+n/K1+mG/abyHLHdmSiaJdwVRnd6sNTpQRZ8GTLlhQbGqI1wCkGZ1A1e/HM/UA
	 igvjFcyET9EP5rauLHJkmvRkj/j3+oKE4hRDvXi2IiFovl3hqNpaNArtG6SkyZhgYwNWA
	 vmWXvdeAw0Fg92b5OGdIBuOs0vkC08nBdAXn+/da6AcIaguqh8LlW3xjgYsmb47yZbCTq
	 OemS1dSeG64EAYmsL55eTQJEkZ0gX26kYNZguvE3zqQOUXQOI0PnOcYgA4dEPZjdedQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rR5/yMID20iQAlo6wmBhffVoxV5K4QIpDT1XmQHAm40=;
	b=tLME65wWL6qqDkAXoVI0vT97QgGikHttKSAiyXEF9Vmur8v5CfKXH6G1CdggUs2CeYzb
	 tH43geTR8ntarzEjp2cE7rspr+S6eSSOb1iBh71tVmhvhdL1jif846+HxEgBdw8SYebeT
	 cWjiMUVP3lrezUeFEvvwlw7e3zmwAYfnNjjzxtCaRx6Q/Zc6Lpgm6awFHLVjYOklcfKGv
	 0fvYQBowC8GxwQ0dDl4FwYAWMAQcEUswkLtUmXJeLJiRCrVO2WHvsDsVbSc1RT4Wfq09c
	 Z9kegJ8J2KbhCz0XHJRy8Sf6TeA+3dJ3aAOYtjZKYNMq65H/IDUueyH+/XgU4sWeZDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYvgJs3X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167C606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6167C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYvgJs3X
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c24619b19so151608d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 11:54:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794513256; cv=none;
        d=google.com; s=arc-20260327;
        b=LBtWNUNWci3ghtREkcHVA/gtou8uwpF3d5bhW4/s/E3Fe2oLhDAGPASv+/zeWs6tzv
         iJg2UdEAbSUiNJEJvzGpmk1k8MuFxnYFTyybQv9gJl1qVfITkNIIiRpS6Xs+3OGpoa8v
         1YiHGrKqNKFtiT1KXr1GJljZjSqV9654JEu2QYngWNO+qT4hZyjp+YTs5c7FZgZHrBeM
         fpeObftzoCJ7r2iSv/bul0G8R+olAtFmNoAs249Jjdmg9QzR652dJUjpG/Kwl02UUOSi
         SkgOQtpg3Ft1juUJO0XxyNl8skegcPvXY1RxGjXnRSVVYQP+stTzMWLh/0qFiixgpmDu
         mRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rR5/yMID20iQAlo6wmBhffVoxV5K4QIpDT1XmQHAm40=;
        fh=9anyiwJieUTuuI8v2F7GQIn2V8gEbC0GKLmdGod1GN4=;
        b=AZ1Cae7dwLKZYCYSPprdNMNthLBFVL6NJXBuqmDOzt7AM0jw+jWXZ9curJ/ozDKSQ5
         EtB/F11aOT/fXtvONlDsFkM0jBkIYNuZsCP9mctRff7KPXZqC6AndSqWiPLDsNoHdchC
         gx7QU4zw+3aDcVtSyz8RNGKtPtchdf/HVRwlyKquSmOx7+5rm9x3oO0HH79B4K/tHbiT
         DdCRcgCnf3wffFWvLoLn7KwghbxDFGz+HFJei7VMzwaeVisRlPFyJuBwAYV8vzhT5+EC
         l2khEwp7CSvuEPvZ0pMujRZ2zWZbFIAqKE4dLfAaExmIQNWQVt1FthCc8M3+LhcvaWgA
         TBog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513256; x=1795118056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rR5/yMID20iQAlo6wmBhffVoxV5K4QIpDT1XmQHAm40=;
        b=bYvgJs3XA1sAEV8iZmi5xIHD2tzK4xO0k15q8Rnuu/qFfXObetviw8pm4UW5ZjBvhT
         oGkfxykjCb61us4SEqjEnKcXbdDaoYuon7Ek4EY6JTLcdteP06eb+quZoMSLd+5wDVx8
         6whO02WGQqP4Uhq5v6RXld4LJoU2CykkX61t298/s+7bGuLU6/b1eDpNkFYa1fiXh23A
         2m+/JbW27srvr17XFg5G035uOQKJi759ODasLPqXy3nRhRWC9MHfnhU1zYzrq4xR4ofI
         jvwaJQAasiGrjJKp/gyKVxwK2vMyYIfZOinI1li6CrQ4Et4cK08QCWClruXUze4vRJzt
         Hvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513256; x=1795118056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rR5/yMID20iQAlo6wmBhffVoxV5K4QIpDT1XmQHAm40=;
        b=Jji5/EOaDRwfRYhbq5lfKXlcPql6P0t1nnH+W9P0JGBXc5na50s6vlToyzUT+we717
         YMhylvsY+i1fZlc7gVHef7M/dUVjYyA/KC943OLLliiQvDhBAt7yyMHOSmUxcB69bqKV
         3jyZBtYA2ljkaSH+f4v+AAf+DbXruuDEXIYQpnMssNMQe5pMgteq8IBOS1K/He9RVcPe
         h+ODreGjZ5M/N+k6TDuHwAJpv/a+dLRtmnscb0GQ+qdE/pWrJbx9dOkTWtoh4l+VJw4U
         zSCpGRJq5hFjMeLb7D9srQGd/L833fwd4Xq53wkYKzhHQK49nPRU/iguIEA40vBTnmE1
         uHTw==
X-Forwarded-Encrypted: i=1; AL+hErGNIAn3e6CYkkGnYNoOImNcNcs/Zv4AKwEp1GBRNqvAxjDnShZcEGkT2m+vkW1As6CCLbCVs+uNyPYSL9hkmyU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LEuISF27LwE0AtBCF0DgFvGhNF23QrtNvAMSPYIeFTaAIxdda
	YK/WvkcxUEg+l/opSzG5BaU4/uXSdSMUH9aOlz/9iCKz4VeILg9aqxlWg7+PmWQeWiixrKlUZcU
	UVB266gyDL329AtIa1WuochPZH5g1d90=
X-Gm-Gg: AYBFou1Pm13mZjBWCvvd1KmOcOoZURBBfNtuWU0QP19ju45WWPKbrt3B5XU62IEsc68
	AopOXnHoNtpb/cE2Pcjw5mrmlZdc+sS1pDVbEN/A462pDzXPfWFCHnAzbmaQZhP9LUfPbO4x3k2
	NrtOUR4OuW5OYxgg1QattuxyttMQ/tFzpZErz1Jc+3oLrGbIAdqXW8Aiokvbqv61BCXVXpRpGbg
	TS5wMh2P90TjrypibPOrN75p3S/2Q0oqRQajYIuUw3JbZi7J6l29hiFSrqJ4Bg2tXzK4cCKm8Yz
	rntKznNOIfWFmosQEWHHf6T8caF3CuB2mEOSRTZeBEYeVzAuP1CRCvfWl+1yyMlPVr2DF0H5iz0
	NuZCWsD/bnG7SRQ/SrM491EJ9N6ohXlPqsm8WFaaGv5ZCexA2NnOMeTwWb2FmxKEPhvXbu5g9tD
	x395yPa2R7sRJVdTygiwznyJJEL9RhxiK5LWbHBE2ZeefjY4liI1sYp6421TRiTRQaccJiF0lbV
	s9Xjk/Q
X-Received: by 2002:a05:690e:4881:20b0:67c:1887:ff57 with SMTP id
 956f58d0204a3-67d895a8a51mr219004d50.23.1794513256080; Thu, 12 Nov 2026
 11:54:16 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112173812.18696-1-piyus@iiitd.ac.in> <20261112173812.18696-2-piyus@iiitd.ac.in>
In-Reply-To: <20261112173812.18696-2-piyus@iiitd.ac.in>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 14:54:03 -0500
X-Gm-Features: AclHuK_lkn4_D_KourMkZU9cofz_4_L2A0BKE0kH3D7W9IXvjBxYzT9Avx9Y52M
Message-ID: <CABBYNZK4akYzoWc97v8FTXc77+godNTHASn8ZnfNji=jPd2oiw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: clear the SDU before the receive callback
To: Piyus Kedia <piyus@iiitd.ac.in>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Piyus,

On Thu, Nov 12, 2026 at 12:38=E2=80=AFPM Piyus Kedia <piyus@iiitd.ac.in> wr=
ote:
>
> l2cap_ecred_data_rcv() completes a reassembled SDU by calling
> l2cap_ecred_recv() with chan->sdu still set, and only clears the
> reassembly state after it returns:
>
>         if (chan->sdu->len =3D=3D chan->sdu_len) {
>                 err =3D l2cap_ecred_recv(chan, chan->sdu);
>                 if (!err) {
>                         chan->sdu =3D NULL;
>                         ...
>
> l2cap_ecred_recv() hands the SDU to the channel's receive callback,
> which takes ownership of it on success, and then updates the credits:
>
>         err =3D chan->ops->recv(chan, skb);
>         ...
>         l2cap_chan_le_send_credits(chan);
>
> l2cap_chan_le_send_credits() calls l2cap_le_rx_credits(), which reads
>
>         size_t sdu_len =3D chan->sdu ? chan->sdu->len : 0;
>
> so between the callback consuming the skb and the assignment above,
> chan->sdu is a dangling pointer that is dereferenced.
>
> For the 6LoWPAN channel the callback frees the skb outright -
> chan_recv_cb() -> recv_pkt() ends in consume_skb(skb) and returns

Looks like this comment doesn't hold:

https://sashiko.dev/#/patchset/20261112173812.18696-2-piyus%40iiitd.ac.in

The 6LoWPAN does actually free on error as well.

> NET_RX_SUCCESS - so the read is a straightforward use-after-free that
> KASAN reports:
>
>   BUG: KASAN: slab-use-after-free in l2cap_le_rx_credits
>        net/bluetooth/l2cap_core.c:576 [inline]
>   BUG: KASAN: slab-use-after-free in l2cap_chan_le_send_credits+0xa8/0x3e=
0
>        net/bluetooth/l2cap_core.c:6811
>   Read of size 4 at addr ffff88800e134070 by task kworker/u21:2/11352
>   Workqueue: hci0 hci_rx_work
>    l2cap_le_rx_credits net/bluetooth/l2cap_core.c:576 [inline]
>    l2cap_chan_le_send_credits+0xa8/0x3e0 net/bluetooth/l2cap_core.c:6811
>    l2cap_ecred_recv+0x63/0x120 net/bluetooth/l2cap_core.c:6873
>    l2cap_ecred_data_rcv net/bluetooth/l2cap_core.c:6976 [inline]
>    l2cap_data_channel net/bluetooth/l2cap_core.c:7028 [inline]
>    l2cap_recv_frame+0x6c3c/0x9650 net/bluetooth/l2cap_core.c:7162
>    l2cap_recv_acldata+0x6fd/0xe60 net/bluetooth/l2cap_core.c:7902
>    hci_acldata_packet net/bluetooth/hci_core.c:3865 [inline]
>    hci_rx_work+0x3c0/0xbe0 net/bluetooth/hci_core.c:4092
>   Freed by task 11352:
>    recv_pkt net/bluetooth/6lowpan.c
>    chan_recv_cb+0x88/0x150 net/bluetooth/6lowpan.c:367
>    l2cap_ecred_recv+0x61/0x160 net/bluetooth/l2cap_core.c:6864
>   The buggy address belongs to the object at ffff88800e134000
>    which belongs to the cache skbuff_head_cache of size 240
>   The buggy address is located 112 bytes inside of
>    freed 240-byte region
>
> Offset 112 is sk_buff.len.
>
> Only a multi-frame SDU is affected: the single-frame path already calls
> l2cap_ecred_recv() with chan->sdu NULL, so l2cap_le_rx_credits() reads a
> zero sdu_len there.
>
> l2cap_reassemble_sdu() completes a segmented SDU the same way and has the
> same defect.  On an ERTM or streaming channel l2cap_sock_recv_cb() calls
> l2cap_publish_rx_avail(), which reaches l2cap_chan_le_send_credits()
> through l2cap_chan_rx_avail(), and that function evaluates
>
>         u16 return_credits =3D l2cap_le_rx_credits(chan);
>
> in its initializer - before the mode test that makes the rest of it a
> no-op for a non-LE channel.  So chan->sdu is dereferenced on that path
> too, and the result is discarded.  What makes it a use-after-free rather
> than a stale read is a consumer that frees the skb from another thread:
> BNEP's session kthread takes it off the socket with a lockless
> skb_dequeue() (net/bluetooth/bnep/core.c:530, freed at :533) and never
> takes the socket lock, so lock_sock() is no defence.
>
> Fix both sites.
>
> Clear the reassembly state before handing the SDU to the callback, which
> makes the fragmented path behave like the single-frame one, and free the
> SDU on the spot if the callback refused it - the error path's
> kfree_skb(chan->sdu) used to do that, and the callbacks leave the skb to
> the caller when they fail.
>
> Clearing it first is also the arithmetically correct input, not merely a
> safe one.  l2cap_le_rx_credits() subtracts sdu_len from chan->rx_avail
> because a partially reassembled SDU will claim that much receive buffer
> once it completes:
>
>         if (chan->rx_avail <=3D sdu_len)
>                 return 0;
>
>         return DIV_ROUND_UP(chan->rx_avail - sdu_len, chan->mps);
>
> A completed SDU is no longer waiting for that space.  If the callback
> queued it, l2cap_sock_recv_cb() has already called
> l2cap_publish_rx_avail(), which recomputes rx_avail from
> sk_rcvbuf - sk_rmem_alloc with that skb included in sk_rmem_alloc; if the
> callback consumed it, as the 6LoWPAN one does, it occupies nothing at
> all.  Either way the reassembly buffer is empty, so zero is the right
> sdu_len, and a NULL chan->sdu is how l2cap_le_rx_credits() expresses
> that - the same value l2cap_le_flowctl_init() depends on when it seeds
> chan->rx_credits on an idle channel.  Carrying the old length into the
> calculation instead would subtract the SDU a second time and under-grant
> credits on every delivery, and once rx_avail fell to the size of one SDU
> the channel would be granted none at all.
>
> Per Documentation/process/generated-content.rst: the use-after-free was
> found by an AI-driven fuzzing harness built on syzkaller, developed
> jointly by Kapil Vaswani and myself, which drove a virtual HCI
> controller and a 6LoWPAN channel under KASAN on x86_64.  The root-cause
> analysis, this changelog and the patch were written with the assistance
> of a large language model over an extended session, and reviewed by
> hand; the before/after testing below the --- was run by us.
>
> Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
> Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
> ---
>
> Tested on net/main itself, before and after.  The kernel was built from
> a2fd526d6442 with x86_64 defconfig plus KASAN and the Bluetooth, 6LoWPAN,
> vhci and configfs options the test needs, gcc, no instrumentation, and
> booted by hand under qemu against the same unmodified rootfs each time
> (-snapshot, so the image is never written).  The only difference between =
the
> two kernels is this patch:
>
>   unpatched  7.4.0-rc1-ga2fd526d6442   KASAN on every run (4 runs today)
>   patched    7.4.0-rc1-g63fe746a609a   no report (2 runs)
>
> WHICH SITE THAT COVERS, because the patch changes two.  The reproducer
> drives the ECRED path, so l2cap_ecred_data_rcv() is the hunk those runs
> exercise.  For the l2cap_reassemble_sdu() hunk, the same patched commit w=
as
> rebuilt with CONFIG_BT_BNEP=3Dy and driven with a segmented SDU on an ERT=
M
> channel with a BNEP session attached, under two kprobes:
>
>   l2cap_reassemble_sdu   14 hits
>   l2cap_sock_recv_cb      6 hits
>   interleaved rr-C rr-C: two entries into the reassembly function per
>   callback, which is a START frame installing chan->sdu followed by an EN=
D
>   frame completing it - the branch this patch changes - and not the
>   unsegmented path, which would call back on every entry
>
> with no KASAN report.  So the changed line runs and reassembly still
> completes.  What that run does NOT do is reproduce the use-after-free on
> that path: it needs the freeing thread to win, and the harness that found
> this bug did win it with BNEP's lockless skb_dequeue(), where we did not.
> The argument for why that site is affected is the ordering one above, fro=
m
> the source.
>
> The clean runs are not setup failures: on both kernels the reproducer
> reported the same L2CAP LE channel and the same frames -
>
>   SUMMARY mtu=3D1280 mps=3D1017 credits=3D2 scid=3D64 chan_gone=3D0
>
> - and exited 0.  Only the report differs.  On the unpatched kernel the
> console shows the program's own marker immediately before the trace:
>
>   [   45.878309] LOWRUN sdu
>   [   46.063560] BUG: KASAN: slab-use-after-free in
>                  l2cap_chan_le_send_credits+0x86/0x1d0
>   [   46.063711] Read of size 4 at addr ffff88800c9a82f0 by task
>                  kworker/u21:0/353
>   [   46.063838] Workqueue: hci0 hci_rx_work
>
> Offset 112 of the freed 240-byte skbuff_head_cache object is sk_buff.len.
> On the patched kernel the same marker is printed and nothing follows it.
>
> The same reproducer also faults on an unmodified 7.3.1 kernel, and the
> harness hit the signature 19 times over eight hours on a third kernel.
>
> No Fixes: tag: our clone is shallow, only 27 commits of l2cap_core.c hist=
ory
> are reachable and git blame lands on the shallow boundary, so we cannot n=
ame
> the introducing commit.  The code is byte-identical in net/main at
> a2fd526d6442, in mainline at 79eb6679ef6a and in the 7.3.1 tree this was
> found on, and is present in every v7.3-rc tag available to us.  Please ad=
d
> the tag if you can resolve it against full history.
>
> Reproducer: not included here.  This bug was found with AI assistance, wh=
ich
> Documentation/process/security-bugs.rst says to treat as public; the same
> paragraph says not to post the reproducer publicly.  It is one C program
> needing no Bluetooth hardware, it is tested, and we will send it on reque=
st.
>
> What bounds the scope: the channel's receive callback has to be one that
> frees the skb, which is the 6LoWPAN one, and the SDU has to arrive in mor=
e
> than one frame.  An administrator enables 6LoWPAN through debugfs; after
> that bt_6lowpan_listen() listens on L2CAP_PSM_IPSP and a connected LE pee=
r
> reaches this with an ordinary fragmented SDU, needing no local privilege.
>
>  net/bluetooth/l2cap_core.c | 53 ++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7dcb0586a10b..fb965e4d75f2 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -6186,6 +6186,7 @@ static void append_skb_frag(struct sk_buff *skb, st=
ruct sk_buff *new_frag,
>  static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff =
*skb,
>                                 struct l2cap_ctrl *control)
>  {
> +       struct sk_buff *sdu;
>         int err =3D -EINVAL;
>
>         switch (control->sar) {
> @@ -6246,15 +6247,25 @@ static int l2cap_reassemble_sdu(struct l2cap_chan=
 *chan, struct sk_buff *skb,
>                 if (chan->sdu->len !=3D chan->sdu_len)
>                         break;
>
> -               err =3D chan->ops->recv(chan, chan->sdu);
> +               /* Reassembly complete.  Hand the SDU over before the
> +                * callback, for the reason given in l2cap_ecred_data_rcv=
():
> +                * the callback takes ownership and may free it, while
> +                * l2cap_chan_rx_avail() -> l2cap_chan_le_send_credits() =
reads
> +                * chan->sdu->len on the way out - it does so before the =
mode
> +                * test that makes the rest of that function a no-op here=
.
> +                * Return directly, since the state this leaves is what t=
he
> +                * trailing error block would otherwise set again.
> +                */
> +               sdu =3D chan->sdu;
> +               chan->sdu =3D NULL;
> +               chan->sdu_last_frag =3D NULL;
> +               chan->sdu_len =3D 0;
>
> -               if (!err) {
> -                       /* Reassembly complete */
> -                       chan->sdu =3D NULL;
> -                       chan->sdu_last_frag =3D NULL;
> -                       chan->sdu_len =3D 0;
> -               }
> -               break;
> +               err =3D chan->ops->recv(chan, sdu);
> +               if (err)
> +                       kfree_skb(sdu);
> +
> +               return err;
>         }
>
>         if (err) {
> @@ -7245,12 +7256,26 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan=
 *chan, struct sk_buff *skb)
>         skb =3D NULL;
>
>         if (chan->sdu->len =3D=3D chan->sdu_len) {
> -               err =3D l2cap_ecred_recv(chan, chan->sdu);
> -               if (!err) {
> -                       chan->sdu =3D NULL;
> -                       chan->sdu_last_frag =3D NULL;
> -                       chan->sdu_len =3D 0;
> -               }
> +               struct sk_buff *sdu =3D chan->sdu;
> +
> +               /* The receive callback takes ownership of a reassembled =
SDU and
> +                * may free it, while l2cap_ecred_recv() goes on to updat=
e the
> +                * credits - which reads chan->sdu->len.  Drop the reasse=
mbly
> +                * state before handing the SDU over, and release it here=
 if the
> +                * callback refused it, so that it is still freed exactly=
 once.
> +                * The reassembly state is already clear at that point, s=
o
> +                * return instead of falling into the failed: block, whos=
e
> +                * kfree_skb(chan->sdu) would have nothing left to free.
> +                */
> +               chan->sdu =3D NULL;
> +               chan->sdu_last_frag =3D NULL;
> +               chan->sdu_len =3D 0;
> +
> +               err =3D l2cap_ecred_recv(chan, sdu);
> +               if (err)
> +                       kfree_skb(sdu);
> +
> +               return 0;
>         }
>
>  failed:
>
> base-commit: a2fd526d644233d6a892c28173f07c61e21e4c93
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
