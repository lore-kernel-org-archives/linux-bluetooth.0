Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360B2744F
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040269; cv=pass; b=lzZ+CFOTZzgEy9ydqJ1BF69D3jU32Iq4GwzqiQDTRFAAt6so8IA1C2/egVY0T7ZgimeUPkx3E9RhavkUFzNTCr4/cFDus7TXR/Xi78AABikX2mOiKEd/n4fwS0551NjKcmViEd1RWyxoJQm+m6FC8pUs2NHtkXgNFkzEA41zRKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040269; c=relaxed/simple;
	bh=BbRfX0tYQrT4+WNjn2pwjyjpvI2cNjmm+lh5Gg4c1bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ydp0bSEb2EBuiL3SG6vZfX5xjQMLOyUGzmAP9ZO/EPO+pKuhco3XHcIqQyzhiztr9hpj1JJ3zE8PaxRtd/oWULQdnYvK98edhlkykof3VEp2ku1XESF4GL4nBPeCuK2sGtTUcri7WQinWXq7TplXrtHhxAyYvXR//MFgd1oGSbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/5GiCCK; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/5GiCCK"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64caaacb9bcso861177d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:24:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772040267; cv=none;
        d=google.com; s=arc-20240605;
        b=RF2Fi9Mq+W+IJJcZz/r/pytBuYeEAkIZLMnUeNtsDTX/Z79797fZZzRONoHWQodfSe
         88Z8qxBeV6TPR/INtOjt7qrBDrgb0CzCf6Pw6o6bT9jacsqNod8183/3xE7o7NMpc56f
         ANWIbM9u1JKNNT/7Gr4qwHMSDPnpNCzgTfIcgPAy54pXd56FehE+Hfn+7bTSf4/miLEP
         dpehDmbLEOid1EHFLqBs45bJsNDMzsEuLiyxRv51BsHg3H8M7/quA+uU6SbdJ/u3ziUd
         4b0N/wuXg5RmrEEzW1nEy3fRfW8gLYBk7zEpIO04obIqqYFowQj6rB5Xl3A92JXQt4mJ
         Nalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9pQDPGcRhvp38OAbiarWlbLBP4cv5C7nNsjq2DKu8XQ=;
        fh=+mGyZxl1WdRVCHxbjv10jRCGOpKnfyPV1+5S/t7lKRM=;
        b=UXv1KePv3BtwusnFywSuD6uhZJ1aZP14Ii6YIDFThStkmXeZrz9biTn5HpWz0TnJN2
         tEx6l9bNtESTeKUUkUNn2ORgnGMac20qetsTytESWxKX6H6s0CbvYkQS9U28o+WpMUs9
         tMn7Aw8XERf+JscgmCmBQk0PBs28HTcrd6wUxHfeGH36IaxNCamYPa0TSMR3TtHAelS6
         NP2NjLNmjChiE9f8apx9ktwrJ9YS+FRdxgrFwGG3YRRLx9AvjcmnxRKcPibpGlqt7akj
         F92u9fUHKFur2utvP4/JohnyKLbD2DCDuZumI2HwPHihGjSUMi/DwgvvhOgvnX53zr+I
         NTVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772040267; x=1772645067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pQDPGcRhvp38OAbiarWlbLBP4cv5C7nNsjq2DKu8XQ=;
        b=j/5GiCCKWVEhb0jZJvF0kHY+5akVC667+jIM0LSr7X71mUOmXawIRxjLO9INh3u7qq
         kUq6EkO3wLBYOxQnCBm87ecrQXvnhaFQ0YuN1kWRvGuP8Q1Cqy3gNKE+0zj3Oc5eb6Qy
         dpnvQsYJ8QPYEc1GDKI76aWZAG8dTMmUHdyP0xNe46zjFewUuVJkuaehX7btHd6frG4U
         7yrAGHbws/A2mC507YUfzHyiib1WQR3+skkZ9GlUijbvgmN5Ge5qA6FnCCguGK4ZOCyo
         oH0V+Ded5zrueTO80EQV9GxWaPX+iTfYHjTrt7GwVXIV43Yl6oZWUrDhTmIH+sMDO1fP
         eXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772040267; x=1772645067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9pQDPGcRhvp38OAbiarWlbLBP4cv5C7nNsjq2DKu8XQ=;
        b=X7WZv7SYDL+TF9fGRZ9qtKiRI4qBqMsOvQL8x2PnRehmIDS4q3VhsNNiPDWl2EMNxx
         LRonBkX0WPSPoKsdmWw9AN0v5CBD1JI2dEOd52GFO+MbDWLToS3k13tjVc/of8aTPi33
         2GFxeI7iXt195PIcR5nlAYk5p58KjBBW2EWvWmTgZGjX6WOQz6ePqlFwssQuUVpEaej9
         SKyfA5Ja0+BH+9i3X9djFZNC9MwVEkJHKSwRuC4SYxdpaJ7A6xCCXT3XQ6wYPUId/MgA
         ESwN7wxLcL5/H8zrEcmOF3vYp7TdFAr6UQ3bqx+b7H+VlQyM7QpkOwK7pe5f4pElrB+i
         Mzhg==
X-Forwarded-Encrypted: i=1; AJvYcCV6qVMwGGomv5Tz9uCY4rEyp/DRgTe8fOyL/EDqgtCdymU6cl8P8zy4Mi34BbRXJFSoIjGeGYEw1GtcjR3kInU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjrBDPUGabyMY+tX4pKhgKIMERiCX7J6a00OJEJeR3pdW0fCui
	rAkwoSze3beGDxzFo6GfRukM4bCPahG0PTszHZ/sRwfLrwz6ysjInBiPMllp1f1jZTbkvvGyt1/
	zowRBj67rg0t1ALqEZ0WvJjB5rsW3OsQ=
X-Gm-Gg: ATEYQzyK+J3+qFuz85lvwPtOUp3KzeojWfv6gAOw9RFSbjKp5VLZcZC3ohH2p55yNMT
	49U08qHlQOWrUzygKLgC6q2YZHhwlKuQVf4mLJe/NM/CMDDqUuY7baN2ThwY6x7cP//WyJHSBv7
	Nprwu7ySdFF7bHTq6OI6nLspBTDtyBongBE3XipqwjoMVhy8wE9B4tJ/WwbBBOL9S3zoFHBUMc9
	SQc3BGcrcanvJ1ntnuRf+t8pZHZ2boM5bglb+5GhGhSEr3vNv5w9g2uj9Te1+tKG3zhh6AO6Uzg
	OnfvlUmNONUJ+v80ZUi3WW+oEFBqW9JI6kvRn1+io4wk9T4iRbWEDDljoCuCAbQZtfc=
X-Received: by 2002:a53:cbca:0:b0:649:4689:c4a8 with SMTP id
 956f58d0204a3-64c788d1b48mr10070434d50.29.1772040267160; Wed, 25 Feb 2026
 09:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225170728.30327-1-ceggers@arri.de> <20260225170728.30327-2-ceggers@arri.de>
In-Reply-To: <20260225170728.30327-2-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Feb 2026 12:24:16 -0500
X-Gm-Features: AaiRm53oiKC-T2I4zlVk6DAz0AZm2T6TXh6oR8yiKUODRg7px9GOe8Bp6CvmfI8
Message-ID: <CABBYNZ+VjSe9J-UzkVGt1opK+7PbnrbuxHmqZo9WPHxxa3kzgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: L2CAP: CoC: Disconnect if received packet
 size exceeds MPS
To: Christian Eggers <ceggers@arri.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Feb 25, 2026 at 12:07=E2=80=AFPM Christian Eggers <ceggers@arri.de>=
 wrote:
>
> Core 6.0, Vol 3, Part A, 3.4.3:
> "... If the payload size of any K-frame exceeds the receiver's MPS, the
> receiver shall disconnect the channel..."
>
> This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
> 0x0027 -V le_public -I 100').
>
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
> Maybe the naming of 'mps_orig_le' could be improved...
>
>  include/net/bluetooth/l2cap.h | 1 +
>  net/bluetooth/l2cap_core.c    | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 010f1a8fd15f..c6744cce75b1 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -552,6 +552,7 @@ struct l2cap_chan {
>         __u16           retrans_timeout;
>         __u16           monitor_timeout;
>         __u16           mps;
> +       __u16           mps_orig_le;

Hmm, I wonder if it wouldn't make more sense to have imps/mps_rx and
omps/mps_tx? I guess that is why you need a separate field; otherwise,
the MPS is updated with the remote MPS, causing us to accept the
packets as valid. That said it would need to change quite a few more
places it seems

>
>         __u16           tx_credits;
>         __u16           rx_credits;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ddac5b9270bf..c9555b0a3461 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -568,6 +568,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *=
chan, u16 tx_credits)
>         chan->tx_credits =3D tx_credits;
>         /* Derive MPS from connection MTU to stop HCI fragmentation */
>         chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_=
SIZE);
> +       chan->mps_orig_le =3D chan->mps;
>         chan->rx_credits =3D l2cap_le_rx_credits(chan);
>
>         skb_queue_head_init(&chan->tx_q);
> @@ -580,6 +581,7 @@ static void l2cap_ecred_init(struct l2cap_chan *chan,=
 u16 tx_credits)
>         /* L2CAP implementations shall support a minimum MPS of 64 octets=
 */
>         if (chan->mps < L2CAP_ECRED_MIN_MPS) {
>                 chan->mps =3D L2CAP_ECRED_MIN_MPS;
> +               chan->mps_orig_le =3D L2CAP_ECRED_MIN_MPS;
>                 chan->rx_credits =3D l2cap_le_rx_credits(chan);
>         }
>  }
> @@ -6662,7 +6664,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *=
chan, struct sk_buff *skb)
>                 return -ENOBUFS;
>         }
>
> -       if (chan->imtu < skb->len) {
> +       if (chan->mps_orig_le < skb->len || chan->imtu < skb->len) {
>                 BT_ERR("Too big LE L2CAP PDU");
>                 l2cap_send_disconn_req(chan, ECONNRESET);
>                 return -ENOBUFS;
> --
> 2.44.4
>


--=20
Luiz Augusto von Dentz
