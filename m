Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AF1EA7F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763418433; cv=none; b=mV/ADU3egyohN2hv+jcJmqM5ZscoPWRIG8sRFsIjeP97Z9ZbNAsheHAgNtl0GGhD40QPypXkoX7GwY+Nn8dzmQUoWGaAPIifX1R3NAjVqBgb6E7OPW7u8mTcyO78PCYZd6apK2nSSmPkKHChIL3W98glNKrw0pqQhO+jgw6mrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763418433; c=relaxed/simple;
	bh=tIHHuwQm4Lt+auCGs23022yd4eJb0ZRsBsQqGdQv/uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMXYDoGz2V8QUEXEXHHylp4GwLTfEPcVNMA1yfHcNTgLWl9WoD9edlNfkJTA6wORPl1e1axXW4jf9kA8AlQxCmgzADLonjcBucXzbNs1uWPojROcLUyVCFaLe5JbqKRiw3ppLIDu/4CTSf7Ujtkly/l/9GIgvKCgHaSsnfy51Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8OO18sl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8OO18sl"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37bb8bef4cdso20700361fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 14:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763418430; x=1764023230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCjb3/PVquZIXlgJN5Tjc/fWoGd59L8yISedWbB8bs8=;
        b=f8OO18sl6LefG4TjoODGIy8xL6hgH5tPKU+GzHwYguwO+KzGnTHF7/10ef+psApj72
         sZg69kRsX+pXY1E1gQ7QkWPCA/JvU8tdoxOls/4atIusJuVuDvEUdPE3Ez9Gc0v51Wco
         BR5qooPkJjIGMqVP2RVZxBt2AyqjzGfpV4NoR2eHfCC81C3qe7+W1OYFUsWiqdHkaSFP
         SWKMAT7BeF5N7QSwlARJ45PnETE0ELE9mpG9f/qs+BZoxAJz1a/+siZZtnMkgywzU5m+
         OxaUJivUtb8aMQZtmCA5Lt+SD9ckKPkjN3Lvv7wyMPODxqOdM8r8afGsEU30d+l+Ki43
         1Gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763418430; x=1764023230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCjb3/PVquZIXlgJN5Tjc/fWoGd59L8yISedWbB8bs8=;
        b=Aip8kI2fGeGmPcl/X5TIhTdwYdDKXuwtF5E/MYR55LqO8DtdIW4YKOR0NiRrxWYRp2
         GbM7mItGgp/V93WJhKKwzFUdc3OCJLqCZMSXFYSmCdw214OGNInp1f08RPPUOATPQtQm
         j9jJRRKz+XtPm+ECQxoTAtbci/toz375N7BGtRSJca1HQLYJ1w1vy6Wd8LL+7npYW6Ry
         OehznsgZf4wbAXMCUY+7WBKUhxk61hRgi87Yp6kBwdeGAYZG5M5yjF+mZT5g8GO52Q1V
         vO4YRsVuXAO8MNi59wJx23ETT4d0euYuVzgH+Tc9DvffXGYyWdCm4ChhGi6pF7vqENJo
         YyKg==
X-Gm-Message-State: AOJu0YxT/wqic9AB7RGj7FkXDujwLW001BGe4zPrUDHoZqiBvO7ywZux
	9fGQ5TQUVOvNx//beCWgpt1/aaOY1jmRwYURsu9iBeOVNHQ0Io42xIAKFbvCpg69roEOHDrWdzX
	kbShYJoB1FxHjGyxRoFHuoiw30H8z3fPUfGcQSXk=
X-Gm-Gg: ASbGnctkDXw4HRbaMqIKvXNzuoS+95xAxQubImj0cLLMmcLpR5pOnd/gbNdLa22otpD
	7bK2w27YcNH6dMKDncMh0/QYGGgFuZ/GAqWpHAy48N+ePlHFWUqgZgZL6Ljhd9Ju2NrSgh6BWkF
	bO3MGTctsjkX6uv7DJl6uCIzwqaoeFMqIFpKjaFSCEgnomE+T4cc9GAxLTBBNDn3bBfUlQs5uU/
	1h+LYW590lk5qpbvB1SR/YFUCWUBBksEtOhPg1l88a2Q5FLvZyzZehZNn+2oAj8fN8q8AqQwsgA
	vVFL
X-Google-Smtp-Source: AGHT+IH3/eFxwBVn66IgqA+6i/XfAIZmBgXRXbpP/AoGEK/gMD/txZCBrp1e42sO+A1C0htVCJtqS9PiiBgDrMcCmko=
X-Received: by 2002:a2e:9217:0:b0:378:de30:74e6 with SMTP id
 38308e7fff4ca-37babd6e232mr28391721fa.25.1763418429606; Mon, 17 Nov 2025
 14:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117092408.336966-1-frederic.danis@collabora.com>
In-Reply-To: <20251117092408.336966-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Nov 2025 17:26:57 -0500
X-Gm-Features: AWmQ_blf4A-G8ot0ujFMhO_1yCG5WThOmzEwxz1LynJcu0czcVxpInrYQKmRxvI
Message-ID: <CABBYNZKvEUPPNZxrqTqWJHPTtfKJM-khkx_ciUU6e30kCFr9gQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Accept incomplete SDU
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Nov 17, 2025 at 4:30=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> During OBEX Abort command, iOS may return an incomplete SDU packet
> which ends with the reply to the Abort command.
> During OBEX Abort command, iOS may return the L2CAP_SAR_END packet
> before the normal end of the SAR packets:
>
>   < ACL Data TX: Handle 21 [2/8] flags 0x00 dlen 11  #194 [hci0] 14.92374=
1
>       Channel: 3080 len 7 ctrl 0x060a [PSM 4101 mode Enhanced
>                Retransmission (0x03)] {chan 0}
>       I-frame: Unsegmented TxSeq 5 ReqSeq 6
>         0a 06 ff 00 03 47 84                             .....G.
> ...
>   > ACL Data RX: Handle 21 flags 0x01 dlen 458       #382 [hci0] 19.70185=
4
>       Channel: 65 len 1006 ctrl 0x460e [PSM 4101 mode Enhanced
>                Retransmission (0x03)] {chan 0}
>       I-frame: Start (len 32767) TxSeq 7 ReqSeq 6
>         0e 46 ff 7f 90 7f ff 48 7f fc 43 48 41 52 53 45  .F.....H..CHARSE
>         ...
> > ACL Data RX: Handle 21 flags 0x02 dlen 552         #383 [hci0] 19.70185=
4
> > ACL Data RX: Handle 21 flags 0x01 dlen 458         #384 [hci0] 19.75591=
8
>       Channel: 65 len 1006 ctrl 0xc610 [PSM 4101 mode Enhanced
>                Retransmission (0x03)] {chan 0}
>       I-frame: Continuation TxSeq 8 ReqSeq 6
>         10 c6 6e 6f 73 61 69 72 65 73 64 65 73 69 67 6e  ..nosairesdesign
>         ...
> > ACL Data RX: Handle 21 flags 0x02 dlen 552         #385 [hci0] 19.77501=
6
> > ACL Data RX: Handle 21 flags 0x01 dlen 458         #386 [hci0] 19.77502=
4
>       Channel: 65 len 1006 ctrl 0xc612 [PSM 4101 mode Enhanced
>                Retransmission (0x03)] {chan 0}
>       I-frame: Continuation TxSeq 9 ReqSeq 6
>         12 c6 69 63 6f 20 43 69 74 79 20 54 65 63 68 20  ..ico City Tech
>         ...
> > ACL Data RX: Handle 21 flags 0x02 dlen 552         #387 [hci0] 19.77502=
4
> > ACL Data RX: Handle 21 flags 0x01 dlen 458         #388 [hci0] 19.82154=
2
>       Channel: 65 len 1006 ctrl 0xc614 [PSM 4101 mode Enhanced
>                Retransmission (0x03)] {chan 0}
>       I-frame: Continuation TxSeq 10 ReqSeq 6
>         14 c6 6c 74 69 6e 67 20 50 61 72 74 6e 65 72 0d  ..lting Partner.
>         ...
> > ACL Data RX: Handle 21 flags 0x02 dlen 552         #389 [hci0] 19.82161=
0
> > ACL Data RX: Handle 21 flags 0x01 dlen 458         #390 [hci0] 19.82161=
0
>       Channel: 65 len 1006 ctrl 0xc616 [PSM 4101 mode Enhanced
>                Retransmission (0x03)] {chan 0}
>       I-frame: Continuation TxSeq 11 ReqSeq 6
>         16 c6 6c 74 69 6e 67 2e 63 6f 6d 0d 0a 55 49 44  ..lting.com..UID
>         ...
> > ACL Data RX: Handle 21 flags 0x02 dlen 11          #391 [hci0] 19.82161=
0
>       Channel: 65 len 7 ctrl 0x8618 [PSM 4101 mode Enhanced
>                Retransmission (0x03)] {chan 0}
>       I-frame: End TxSeq 12 ReqSeq 6
>         18 86 a0 00 03 3e 5d                             .....>]
> < ACL Data TX: Handle 21 [1/8] flags 0x00 dlen 12    #392 [hci0] 19.82249=
1
>       L2CAP: Disconnection Request (0x06) ident 10 len 4
>         Destination CID: 3080
>         Source CID: 65
>
> In this case the re-assembled packet should be 32767 bytes as defined
> in Start packet (#382), i.e. 33 segmented packets, but the End packet
> is sent as the 6th packet.
>
> The l2cap_reassemble_sdu() function returns error -EINVAL if reassembled
> packet size !=3D expected size, triggering the L2CAP disconnection, which
> disconnects the OBEX session, preventing further OBEX actions.
>
> Log this, discard previous segmented packet data and only send data
> from SAR End packet to upstream.
>
> Closes: https://github.com/bluez/bluetooth-next/issues/17
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
>  net/bluetooth/l2cap_core.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 35c57657bcf4..5fe1d058455e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5703,13 +5703,20 @@ static int l2cap_reassemble_sdu(struct l2cap_chan=
 *chan, struct sk_buff *skb,
>                 if (!chan->sdu)
>                         break;
>
> -               append_skb_frag(chan->sdu, skb,
> -                               &chan->sdu_last_frag);
> +               if (chan->sdu->len + skb->len !=3D chan->sdu_len) {
> +                       BT_DBG("Incomplete SDU, expected: %u received: %u=
", chan->sdu_len,
> +                              chan->sdu->len + skb->len);
> +                       /* Discard previous data and keep only L2CAP_SAR_=
END data */
> +                       kfree_skb(chan->sdu);
> +                       chan->sdu =3D skb;
> +                       chan->sdu_last_frag =3D skb;
> +                       chan->sdu_len =3D skb->len;

I don't find anything supporting this on the core spec, in fact I
believe this would hit the following condition:

I-frame with SAR bits that do not correspond to a normal sequence of
either unsegmented or start, continuation, end for the given CID.
[]https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Cor=
e-61/out/en/host/logical-link-control-and-adaptation-protocol-specification=
.html#UUID-7ad8e66b-9d04-f9b8-6745-628dff5b511a

Not sure if this perhaps is handled specifically for OBEX Abort
command, since that has the effect of aborting the transfer, but in
L2CAP there doesn't seem to be an equivalent of that, so it would have
to finish transmitting the outstanding data to complete the packet
(MTU) before it can abort, so it looks like Apple got creative and
invented their own method of aborting without first checking if that
is legal.

> +               } else {
> +                       append_skb_frag(chan->sdu, skb,
> +                                       &chan->sdu_last_frag);
> +               }
>                 skb =3D NULL;
>
> -               if (chan->sdu->len !=3D chan->sdu_len)
> -                       break;
> -
>                 err =3D chan->ops->recv(chan, chan->sdu);
>
>                 if (!err) {
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
