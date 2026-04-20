Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4E296BD3
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711979; cv=pass; b=u/AHsCmSPfI9YdGpUB4Zp6CHJbS7sVoqpt4I0gFZuIiiUXPewaSZ1+HiAiX+HWyCO7Wn9uKE9bnTqnwmqxVnJIbL8E2lTcV5ux/b+TtJdEW4k3HGrPlsD53D75h3vyWHLVIJ5eZmRlnFelCYdam9cegqynaLNA0j+Qaqz1dCq7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711979; c=relaxed/simple;
	bh=ITDRCLL6iQtCAcNDw1CfvU0dYmsh4uuQ5HG+bBBQaes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/9KVaPc8Fgz69vJyQgr17txathDj7lc/Ud7D1xCvxLYzkIMhR0aOSV3dq6LJkBRB2E9DEGcqCmvfq/r/r/gQr5Kjljdj6/u+TnaewwbudtwCvs8WFzsMvAm28V/8OG7II42Du7MT1axmtkQ7Q1FN5gNIaLJY5wCp5jOlQr+7YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt3IbHiQ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt3IbHiQ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64eaf8aa893so2750603d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 12:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776711976; cv=none;
        d=google.com; s=arc-20240605;
        b=NTma9a9sL1iJvM1EyjOfAbZAe1tqYOiw3gjI8KM0CVB4ifAZ6e1J9pbKcSPjU6GYin
         sd6Cpg/FLN5WYTZi51UbIchaI1szOf4X1rKTUpPQXQINhcn2p6vJeJjG+498nROaHftm
         iGSA5MJBHAHY8ZJE4F4WQYu3CnYQDpEc65MEMI9MmOzvvuZS7QtypSKbcEiySapCr8ch
         wQdgVgRfc+DIxmRnC0qbvnKHChqcjfeBP2RXlv8iT+klF3hgllBGSeSyImmVG6ogUWqA
         HbemUVhkqOfW1nLZqvLuYxNTrUDDUb2e+Ao78q6TLeYTgBCtPtEEyqjj5Ulr81yzE5p5
         1JEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYWI4absxQ/bp1qKiQ6rfgUeoAwdmHId6fE4xEEnoNk=;
        fh=dNV++GsZo+/ip3nZhMBNcPhmzB9VkPyQIFx3QSVxfhY=;
        b=dMr6H7XTzlwsraK+tOxtJtSqCXQ7KLnJIbKgSLmvL3/BMmW1gREti2b94dnpRYd8kG
         Lm2zfZMe43dtqAmfFx3L3Vf35ZNVt9QV2ER3lVJXBGv27/ZZ8zRvNMl0qjk88UPrjQ7F
         xwxtClKjBZS/c153F0LUgcx6sKfsXnxk4VfPxShpbZOLXGhUsoVWMdLy+tpSS65JVnQ9
         m+jM+WnV8Xo0+tPgVKW125Pd0O5ldF3JGNIWJT1dVP97qQIBgdPkp+jQmHwC+rsLZvVw
         yB71vpTgyDi/lie0jSZZo/1aas9LtVU5FLEyOmya7qNh2ae+M6jj9g5MrBjn2SmdHE2L
         ETWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776711976; x=1777316776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYWI4absxQ/bp1qKiQ6rfgUeoAwdmHId6fE4xEEnoNk=;
        b=Nt3IbHiQqugtvpayEewre+vrWDDt1dguf3k/vIQgSeYuornpmvz5DDe5/QamLOvsV2
         Nr4CXRTe68XZ6R+5Uuu26A4VTE79/JbX65viFQDS611dHVrh+VkRmeoLXsingIGCJSRZ
         3S9fGG+JrYjne9wYvi5wOwhey6w8r9iNYSwOX5ae2CwlajX0qeKbzERUrpeszuHCM3ws
         0DOzlfA8491wTBKlRwaOFs8YrH2k7tnMYF1+LZ6S2NMtrTK3qqWiobsasxw+9K3iGzqy
         eqXTOfP1vIpMUYTjTbgLLajgg7N+wTBIf+LmOM5osFSibLsr8VthiQrfrNkbVr5YfDCA
         Fkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776711976; x=1777316776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYWI4absxQ/bp1qKiQ6rfgUeoAwdmHId6fE4xEEnoNk=;
        b=pcLx+rZ/VKz85PkDYgCqeKr9qye8Vfd1JPXzmz+4hCxijpjxIlWRDToelboWqTc6Ix
         JXzgpnGhJjQn7WMTiMIqb0QYCXj9LkjokhJBRN4eonrKJGZFt4ujKa10rLXT7aqUoGnI
         T6kTk09Or8taMlaD9VrCLVGWyQaFv6p7KPgmJ0IMUAZKowSdH/kiAM0SOvZ5dPWbiBip
         jW83aKxL/maCk6TXndHfItS9zOXo/+/DduqG8rMxloWQDJU1gkgg1fVrH4Okd3VjNpyq
         WyHZng8iY5sWc51ilixWETR0teqGNjnMvzog60GLmznMyAzRMVxDbVXxXNM+o/Ii1Kog
         InTw==
X-Forwarded-Encrypted: i=1; AFNElJ+653HuzEo4NrG1YH3HR0kERv0rNx5znxXewya7zu8YovbfMiLLHcqxM1P8+1z0hDv6OmEk1YDjF3ZgU/yrBrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQRxFxWaXozQDjU5spv+xnopxKsI7RaMJQb4V3opkZ43XrEuc
	qZ5+TekWh6rfzzPcgbWr7tylBrcBYYoeX3Arp3fnVQJETNooe4N/yLmhUPZRbAFEwgBwfDeM8hh
	u/ctNs+BTs8j6pX6Yqe8eoD8c/R6PRzfHavE6cwY=
X-Gm-Gg: AeBDieudH9UX2Uxx4IX8YJF25zwgW9D0oEhybrM8ZRs4r9Yv37NVT7iay1ae0/JvpZ/
	+ntZywedbvDnwnNkchJ+Im7/Ep0pXxYoL6ySqV1VHWli+CpYrrXxrKVh0dLW8cijprwUdvMflVR
	LvS2VIwODsiYTHNYuHM+KQNxS7+S8jUn74tj0AY0da6K6Ed23I6iVQRtaqQnrLiVFYhpVA9Cjym
	GeQQ2jxGhr+k7C75Fn/bRjzabKD94zXRfq1Pxsf1U9S2GvBLG0Gwt1TGyLobI5wCWHNa4S2damv
	dy8R4N9bV3N6ijZzEC2msf4XOhTr6vRl/cQTJv11+aoIaGW2nkdxid1hdhBJ+siojGdmx8DiT4M
	iZA==
X-Received: by 2002:a05:690e:1592:20b0:651:be8b:e87e with SMTP id
 956f58d0204a3-65310a2c1ccmr10986168d50.34.1776711975711; Mon, 20 Apr 2026
 12:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
In-Reply-To: <20260417221628.1674866-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 15:06:04 -0400
X-Gm-Features: AQROBzBslDU4lfxJ3rMX5ZoFfuxzh4odzH9UJusA1VXQPZvYBJe0ECmBeMBLMww
Message-ID: <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, Apr 17, 2026 at 6:16=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> Bluetooth L2CAP ERTM configuration (RFC option, type 0x04) carries an
> unsigned 8-bit txwin_size field.  Core Spec v5.3, Vol 3 Part A, section
> 5.4 specifies a valid range of 1..63 (or 1..0x3fff under the Extended
> Window Size extension).  A peer-supplied value of zero is out of spec
> but the current l2cap_parse_conf_req() path stores it into
> chan->remote_tx_win unchanged whenever CONF_EWS_RECV is not set.
>
> The zero then reaches l2cap_seq_list_init(size =3D 0), which computes
> alloc_size =3D roundup_pow_of_two(size).  Per include/linux/log2.h the
> result is undefined for size =3D=3D 0.  The runtime behaviour is
> architecture-dependent:
>
>   * x86, arm64, RISC-V, MIPS, s390x, LoongArch: the ISA shift
>     instruction masks the shift count by (word_bits - 1), so
>     1UL << word_bits evaluates to 1 rather than 0.
>     kmalloc_array(1, sizeof(u16)) returns a valid 2-byte slab
>     allocation with seq_list->mask =3D=3D 0.  ERTM retransmission
>     silently collapses every reqseq onto slot 0 (correctness bug,
>     no memory corruption).
>
>   * ARMv7 (AArch32), PowerPC 32-bit (slw), PowerPC 64-bit (sld):
>     the shift instruction returns 0 for shift counts >=3D word
>     width.  1UL << word_bits therefore evaluates to 0,
>     kmalloc_array(0, sizeof(u16)) returns ZERO_SIZE_PTR, and
>     seq_list->mask becomes ULONG_MAX.  Any subsequent access to
>     seq_list->list dereferences ZERO_SIZE_PTR (0x10), which is
>     always an unmapped low-memory address, and the kernel Oopses.
>     This is a remote kernel panic driven by a single peer-sent
>     CONFIG_REQ; it is not a demonstrated code-execution primitive.
>
> Verified on qemu-system-arm -M virt -cpu cortex-a15 (ARMv7-A, same
> LSL register-shift semantics as the Cortex-A9 class still shipping
> in automotive infotainment on NXP i.MX6 with long-term availability
> through 2028).  A KASAN-inline kernel built from mainline panics in
> l2cap_seq_list_init on the first peer CONFIG_REQ carrying
> mode =3D L2CAP_MODE_ERTM and txwin_size =3D 0:
>
>   Unable to handle kernel paging request at virtual address
>   9f000002 when read
>   Internal error: Oops: 5 [#1] SMP ARM
>   PC is at l2cap_seq_list_init+0x140/0x28c
>   r2 : 00000010   r1 : ffffffff
>   Register r2 information: zero-size pointer
>   Mode SVC_32  ISA ARM
>   Call trace:
>    l2cap_seq_list_init from l2cap_ertm_init+0x588/0x758
>    l2cap_ertm_init    from l2cap_config_rsp+0xeac/0x1158
>    l2cap_config_rsp   from l2cap_recv_frame+0x1260/0x8000
>    l2cap_recv_frame   from l2cap_recv_acldata+0xb78/0xdb0
>    l2cap_recv_acldata from hci_rx_work
>
> r2 =3D 0x10 is ZERO_SIZE_PTR (the kernel's own decoder annotates it
> as such).  r1 =3D 0xFFFFFFFF is seq_list->mask after the 0 - 1
> underflow.  Faulting address 0x9f000002 is the KASAN shadow for
> pointer 0x10 (shadow_offset 0x9f000000 + (0x10 >> 3)).
>
> Trigger is one peer-supplied CONFIG_REQ on an L2CAP ERTM channel;
> no local privileges required, no pairing required, no local
> interaction beyond being within BR/EDR radio range of an affected
> host.
>
> Fix in two places:
>
>   * l2cap_parse_conf_req(): when the peer sends txwin_size =3D 0 in
>     the RFC option, clamp it up to L2CAP_DEFAULT_TX_WINDOW before
>     the chan->remote_tx_win assignment.  This matches the existing
>     clamp on the CONF_EWS_RECV branch in the same function and
>     mirrors the shape of commit 25f420a0d4cf ("Bluetooth: L2CAP:
>     Fix ERTM re-init and zero pdu_len infinite loop") for the
>     sibling RFC max_pdu_size field.  This is the primary fix: it
>     prevents zero from ever reaching l2cap_seq_list_init() on the
>     normal config path.
>
>   * l2cap_seq_list_init(): return -EINVAL on size =3D=3D 0 as a
>     defence-in-depth check for any current or future caller that
>     might pass an unclamped value.  The existing error-propagation
>     in l2cap_ertm_init() and its callers already tears the channel
>     down on error, so the peer simply loses the ERTM channel
>     rather than silently corrupting an unmapped ZERO_SIZE_PTR
>     allocation.
>
> Related but distinct from commit 25f420a0d4cf ("Bluetooth: L2CAP:
> Fix ERTM re-init and zero pdu_len infinite loop") which addressed
> the sibling zero-value issue on the RFC max_pdu_size field.
>
> Fixes: 3c588192b5e5 ("Bluetooth: Add the l2cap_seq_list structure for tra=
cking frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  net/bluetooth/l2cap_core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..b2fe094263ca 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -323,6 +323,17 @@ static int l2cap_seq_list_init(struct l2cap_seq_list=
 *seq_list, u16 size)
>  {
>         size_t alloc_size, i;
>
> +       /*
> +        * A peer may send an ERTM RFC option with txwin_size =3D 0, whic=
h
> +        * propagates here as size =3D 0.  roundup_pow_of_two(0) is
> +        * documented UB (see include/linux/log2.h) and produces a
> +        * semantically broken seq_list that silently drops every
> +        * retransmission slot.  Reject size =3D 0 explicitly so the call=
er
> +        * (l2cap_ertm_init) tears the channel down cleanly instead.
> +        */
> +       if (!size)
> +               return -EINVAL;
> +
>         /* Allocated size is a power of 2 to map sequence numbers
>          * (which may be up to 14 bits) in to a smaller array that is
>          * sized for the negotiated ERTM transmit windows.
> @@ -3593,6 +3604,17 @@ static int l2cap_parse_conf_req(struct l2cap_chan =
*chan, void *data, size_t data
>                         break;
>
>                 case L2CAP_MODE_ERTM:
> +                       /*
> +                        * Peer-supplied RFC txwin_size =3D 0 is out of s=
pec
> +                        * (Core Spec v5.3 Vol 3 Part A 5.4: ERTM tx wind=
ow
> +                        * range is 1..63, or 1..0x3fff with EWS).  Clamp=
 up
> +                        * to the default window so the subsequent
> +                        * l2cap_seq_list_init(remote_tx_win) does not
> +                        * receive a zero size.
> +                        */
> +                       if (!rfc.txwin_size)
> +                               rfc.txwin_size =3D L2CAP_DEFAULT_TX_WINDO=
W;
> +
>                         if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
>                                 chan->remote_tx_win =3D rfc.txwin_size;
>                         else
> --
> 2.53.0

https://sashiko.dev/#/patchset/20260417221628.1674866-1-michael.bommarito%4=
0gmail.com

We should probably fix the double free if it can occur; perhaps the
others should be addressed in different patches.


--=20
Luiz Augusto von Dentz
