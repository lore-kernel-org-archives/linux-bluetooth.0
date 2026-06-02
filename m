Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6229AAFA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431476; cv=pass; b=DmRaDx9rh5uSOlfxAvsCWs9c1VYWRTLX2LbXbxhv5mmLwHigqXUrPMxSjLPSiL19HwvKsXEwSU+QcA38a7yl/AiHkt3JUjWU0isEUyrpxs9Z1jMFblNJlQt7NVrc6Th2yE8GU27jXykZP3l9XtJuOXzRPnz/efK4zRKBAoC0VFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431476; c=relaxed/simple;
	bh=KV4tXvP4aBrFWsY6sjkN0dkFhvRao+gJp03Os9CWd2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwcqCUsNsdxk0bkmXjSkyuE9rzey+2mgCr5Z5W6QF15MszbFRaGu/VodJ3QhJwYE2sHZ8GH1geUorOaJnXsgakr8LccA/53rYyfxlYpvC8dKqcSqAnmlBEQKhIFOyWqKrIDSb7TMDOBdpItAvUSK3zRKCH/m0zwkvBlo800T2Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQBRPfX6; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQBRPfX6"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66036d6bcb3so6045648d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 13:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780431474; cv=none;
        d=google.com; s=arc-20240605;
        b=SuH7CasKMi5NojV+w5LWvUGvjTvUs4yYQxaB7UGF15m1xKZkXCPNul6hSJAPzSem+d
         O73fQVPiWa8jgxfYzpuEafC4AMjpNaxSSvKvQlPElH/w+FEP2gjmY8fFcRLojAgGjOg8
         NyTLEahbguxmzAyhOXz9dnF5x6zsOEs51LFTYKGKMMaDByN/N5zUHu7Ay0D1dj1hItYa
         sZ6pBcGmeFqhIKBW9ZMxLXqojIWgdNx8oi/Syj3Y4tdxw6oE8oREl+0qh4x1GOFzDrHu
         zo5uAV32/kIXLkwzeXQYPcTZ5gQqnq68kkBDYWLitazBys8p00CEXTo9lHTlbpPql2Np
         m2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKsMonQC5G7XWaA2CSgjEPFRaREI73ukAL/zHqHWCkE=;
        fh=I4qoUnrsgE1I1TlVCznsU/wCvgQMGVTRNGNdLMxzKQQ=;
        b=KX8bDDnHi27AqalLcnstnHFKtSRlLmQJ1dK1cYUFrIcsOs8BeFwOBufX9wwpnZUnVZ
         Y5uk2OocGVg842VMa3d71f13uGQwLzXT/pmq2yGKS/xkfONhqUBpBKTEqww5hnfQ7H6W
         mCDj+3kOFrjSBy6vZQzIoGyuUk1X01HyjgTS45Lqmb50kt0AmxongQrKL8x8ZXbT5gkZ
         sL1KxK0zPYI7JN6jyCHeL7roKcx1Mtjh9xsDKQpXEKKvqpx2m69rlj6NXDzKUMLaxnJF
         lf1KycL2bfBmhlkPGzAyOULr1rjKB6j0UyJpmawbQ7ZQyeQy3gpZOGz0YKDk8PgCnhHl
         /E1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780431474; x=1781036274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKsMonQC5G7XWaA2CSgjEPFRaREI73ukAL/zHqHWCkE=;
        b=EQBRPfX61QM361v4QjzEXZC2uJi1YRKAjeZOGd4eDcljmmirVi11THJqBH0IPAd+Nc
         nczD7NORLsMk8w8ZrmO1oS5l7S8mNc7MWR98VET+tgaHbDLOUUEtmN9TbhvElsOVmZHT
         Q912jdvPUJwx7PPdWdq8+fK5C9YwXbNP8l4i+iajYCjUK1cPZJOfOG+WetkpbjsWolQK
         vikRWTvKhECL3dFwQ79XBfzVPOowBNUcKamSAkHMmr2DXaG6cQaF5VZC4m6k9sz7NS/6
         1ZEvIYKx6yqZEau09/IBPKk6+67g86nvBjlU3WvfQg7pAbHJXhWpgOtv7qOxdHSLeAFc
         aZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431474; x=1781036274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uKsMonQC5G7XWaA2CSgjEPFRaREI73ukAL/zHqHWCkE=;
        b=ZXm9znEmUec8P7lh3JdwCJLbEVcDmB+KOxg2eXOknc2V8ks4yj5mWM0M5EzR0ZVaUC
         0KZRXmF2Ek7ty7ZeRlC5uf1a/z/oDfwstTeZpyyThOxL9j7y6N2/imwLEBMquNgLbfhE
         q43z+Sk+5/V52vdavO6G0EJQosbBVcIQAYfYH1qqSl0yrLBnns0pji1zoH8hU8hDfSWA
         Aw8/shi3G1xrBUjD9HkIhFftPJpxoTfdUCeY5P5nBybo9ydd/GIxcPgQinF9imAWxNDu
         5FLV7UIr7cXXY0rDk2YyNkODa3qCwnS6ZqIEWQWbO9wVsBHRL0t/1U9d2AgxAjd9cRdP
         VOog==
X-Forwarded-Encrypted: i=1; AFNElJ8oCVaWZRxN025RW6om3OTN1QTa6Qst8DBIjAkF25yaXk9yKqyx2tMOqVHaeFbJIqJBF3W1BIMsP3jXwxfnzW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcJb5b9hm4PS+cpagjjQo0uz/R9b6GvnfEqmnVKSn1LSAJkqf
	JvCzP+u87ny6jAGFmgu7qpomP87Nj1U8jdifFO7IYG6WruBmapEArXqQUTjdvl1/xAb+g0cuHsY
	kkKdI1TA4hz5c4fRhsCY7PtxEKcZuMGw=
X-Gm-Gg: Acq92OGZnhRfhRCDdDQaSSj7hSA5BfdRcduOEgvN+MkRuOEPGbe26r9FFICH5j6NdC5
	ePe4n0LXq3mApKt3iRw4zpp1GMsNfhQ3b5A1KCsH+fU4f6zHbdpUWVMr8MSVY6COCuTDNgazqyJ
	TdNAPY07JqsDcXRD6mvzgmry2ljtmSQcsbiB5oz+jlYJcmacf6DiKh+LhGUe5HZEXsVdEetAlg0
	vBJDbjDSxSyv2B7JwSWD1JdsAQNqC3qIys7vbjSAjpY2unL6asg/PQ+OBsgFDbcbBhCmQAKBPE9
	8mH4lUeRcRFe+NGayc5EBmOOzXt5gTjHr/kpVTUASyCk/w4NCo7n9k4gh1QVzqlnk86Mi2AmCSv
	qn923b/3NwfEyeV0=
X-Received: by 2002:a05:690e:150e:b0:658:1e1d:b8c6 with SMTP id
 956f58d0204a3-660dc561be6mr299290d50.44.1780431474440; Tue, 02 Jun 2026
 13:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515143819.1157807-1-michael.bommarito@gmail.com>
In-Reply-To: <20260515143819.1157807-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 16:17:42 -0400
X-Gm-Features: AVHnY4JW6r7RulhKRr1Hz6rP90kkk5ro9_ZQJaO6i7n6ZseUdjT4PmoDFB-vUxg
Message-ID: <CABBYNZKh-J9sHf3ma=HJTBz=j0QL+eEti_0hOAJU=4Okm4Lz1A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: validate Add Extended Advertising Data length
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Daniel Winkler <danielwinkler@google.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2026 at 10:38=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> MGMT_OP_ADD_EXT_ADV_DATA is registered as a variable-length command,
> with MGMT_ADD_EXT_ADV_DATA_SIZE as the fixed header size.  The handler
> then uses cp->adv_data_len and cp->scan_rsp_len to validate and copy
> cp->data, but it never checks that those bytes are part of the mgmt
> command payload.
>
> A short command can therefore make add_ext_adv_data() pass an
> out-of-bounds pointer into tlv_data_is_valid().  If the bytes beyond
> the command buffer are addressable, they can also be copied into the
> advertising instance as scan response data, where the caller can read
> them back via MGMT_OP_GET_ADV_INSTANCE.  The trigger requires
> CAP_NET_ADMIN in the initial user namespace; KASAN reports an 8-byte
> slab-out-of-bounds read.
>
> Reject commands whose length does not match the fixed header plus both
> advertising data lengths before parsing cp->data.
>
> Fixes: 12410572833a ("Bluetooth: Break add adv into two mgmt commands")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/bluetooth/mgmt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b05bb380e5f8..de5bd6b637b2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -9110,9 +9110,15 @@ static int add_ext_adv_data(struct sock *sk, struc=
t hci_dev *hdev, void *data,
>         struct adv_info *adv_instance;
>         int err =3D 0;
>         struct mgmt_pending_cmd *cmd;
> +       u16 expected_len;
>
>         BT_DBG("%s", hdev->name);
>
> +       expected_len =3D struct_size(cp, data, cp->adv_data_len + cp->sca=
n_rsp_len);
> +       if (expected_len !=3D data_len)
> +               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_=
DATA,
> +                                      MGMT_STATUS_INVALID_PARAMS);

So it appears this was never tested with the likes of
bluetoothd/bluetoothctl> advertise on:

bluetoothd[40]: @ MGMT Command: Add Extende..   {0x0001} [hci0] 16:04:53.31=
8270
        Instance: 1
        Advertising data length: 3
        Advertising Data[3]:
        02 01 06                                         ...
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Scan response length: 0
        00 00 00 00 00 00 00 00                          ........
<- Extra bytes
@ MGMT Event: Command Status (0x0002) plen 3    {0x0001} [hci0] 16:04:53.31=
8287
      Add Extended Advertising Data (0x0055)
        Status: Invalid Parameters (0x0d)

That is probably a bug in bluetoothd but it breaks backward compatibility.

>         hci_dev_lock(hdev);
>
>         adv_instance =3D hci_find_adv_instance(hdev, cp->instance);
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
