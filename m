Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793805902;
	b=FFUl78+E1Sx6JN3EG6u2woO85kUP8OFCNn9Ha9CaZST9hxb+FeJGbm5L0k4aQ2DEZiqY
	 TKEXvLgL6ZLMFu6ydhGg2Loig5rned9aSygbhHWktVJ3cTFdMK7uSOfUXf2a0Vk37J5MZ
	 WqXtHv7G7h1h8bvwzEp2QTavQthh0q/krpOo7+cXYJjUn9WYTrPg/djAi0KC0OVIFqz43
	 QsnLiQLkym3pLJYjKB6OXA5rwIz+BQUEe6V2UBYuyoRHL9d0hvTX5QmwQkdstaixN8GWN
	 RiuXiZKURuna2O8yOLmUE3/RMEvHvGWwZlJv7MmJ2ODi7Jeu6lkdgT6nOJBg5WYyOoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FQAPIWMbbJdCSrqpLgLYAqpkKK9TOoJ/Jv2La7z0jSE=;
	b=mKmfPzvuQKVaQavUoKEgch+rBiMr0cjAhK25YGAIdiLnAyFD3HR3Votl5F0mKQRvAaXi
	 uF2jMGDMhr4ojrMgIyMIrhUKJ2g93EvXAd7xDWXEGiMExkepnQj1/JrkNZLdMOr8MXgBi
	 kaLdoykDGd88kVtjWELgh5x+Y34lVcp/Iui7Uuhxq/KTGiHaWKQDSzxL3kdGMgzCGfe5I
	 nnWjejhKcUZtXI2Rj1Lxlv552KhXfNoA1h2jcE91asBmICQrHRVtJBrepVDgQxHtUIePO
	 hIEBbbkR2+5UMK7hpgLXlH8fm7hGQnh0bo5utHoHG0jYuY5e8ZIzfaNlWlc1xxScSNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SW7+KUHb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB793606A330
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 15:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB793606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SW7+KUHb
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-716d052dc23so35448eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 07:25:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793805901; cv=none;
        d=google.com; s=arc-20260327;
        b=lsEftuADnBIWAlqc5X54Dtwzhx4kC4HqDb5TWJkhX1ZWhhRPkjmCTqR3qaBAg6dAnj
         1zL1MunpNqYMD7lS5C7NsM7UunSTIwu2pjq5Uvix9mCBK0bPFBsl/p4muQjaeqGY2fgN
         Yz4oMG10lZVltsWvV4mFJev8bn59QeXuaflvj8iTqbxiGcVJABtgznr7iwQboMT7OTL0
         vPMxxlSc8RbY1hCR1UWKw7WTLTAIJKHUSiLaWds8VFUJZc2BGlsv+kPsoNFhGv+9rI4c
         60YZFh/CBFNWMqGl1YYSmNYo+YIOBxaL+xC7/1ZiXNhBrpyMHh5xQYGoNmGM5rlZEZ0S
         GqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FQAPIWMbbJdCSrqpLgLYAqpkKK9TOoJ/Jv2La7z0jSE=;
        fh=mixkwJ78xLZdqfOpebCll0MvWXrOtRFf3Qm0Tt+J13M=;
        b=cyZIprkqE98P9G975kOZ53cwKiGdpBo97W921YYAgTYSToQSYVLhIfkcXRH2BQnJ8n
         R2aV732rKlPV2hmCXceTi3eIL8U9tDIRFhwF5AqlvzO1ovgISDeQgMUFoUFbj4pCV0zU
         TJJX9dT66EFCQ6mJfiidk4/WzbOLlBKZNdG2U/E9sBmmxgnMa0dLIwp3uPQ/+r/opF5O
         clx8yUFc5R9ofav+GBbtMc/PIihLXZV0LiruyCzlAxhMtn4lg824DhGffyPJYUy0tBVT
         vNY7gIdhym4Qc5yJDgclREK7KWocO9sIvHYF4R4CBKQlsGt4hQcp4ZQ8XERO/KSpfky2
         +LJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793805901; x=1794410701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FQAPIWMbbJdCSrqpLgLYAqpkKK9TOoJ/Jv2La7z0jSE=;
        b=SW7+KUHbqceBCpm7SHbzvuK7/txWeKUd5nWKlSJQjsO5R/d2+fgKjM/R21d6V0+nUY
         nMZhx+E71d/laSUmXmBhnUrIeyahY+l4tdDtH3hLG3Y5BfF5sdu/GvLP9w/1b7VzdouM
         HI4LzyAwX6BBjlpqBT+jGmS9jb0QVuzAAtW3A7vgf8rvDmC1PgUZNC7GCDNGcvTevn4R
         zXrxRLi78GVER1m+DFyRQoexkolIQOx9AvE+6yQ73eJF45OT4Up8dXXwTdc3flbaTILW
         ETuTR+1QkL3gdaixVWIemIHTe/WzRxQXjuv5g3E/zai0tZKz4HHuTmUxj6bDliqHvRot
         Q5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805901; x=1794410701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQAPIWMbbJdCSrqpLgLYAqpkKK9TOoJ/Jv2La7z0jSE=;
        b=HZRJf19iiilXfmD36EyvQXuIgR1Gnuz2quXOAPbSqgooXnU++BRrHs39oF6Po53sqq
         X4UAbmbmvo7U8jXsjcz4djaIK4HOulkif6C3o2C0T26mhCRpwkjgslpOPr0lN9PsaHkY
         R/qXJ8M4djTF37u599yAgsv4TxRRtB1AWolJ6wEzORoVpzQjr6JmndVnROTBSUmehKUQ
         xw/SaAO1MhLvY0iBDx0QQmM88AsViXLAzuZPQYSJaZ+g/h6rd/M/pgjfLyOAZKFUwATC
         yCcz6ckm+EflYghvF55l/v5rLh+KH8y/voixqXtV4H+P4CgwPyBpHuM3SFiCDGgHJv4T
         86AQ==
X-Forwarded-Encrypted: i=1; AKwUvBwm/hTb97TIK1S6o47WclhaLMmZv1uka1hVIubPi5imkwvcN/M5BlVRTZh7BFKnLVdxjHj6DN2FC+LRaE4DHtE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xln45oCNxS5MnWIxV60KZ2G7Un6tgiivnCSAjbwtRKqA5BPoY
	DcaH30HxX0pyynJlm+pcOUdu65TKrNd3naGKsDqvooqXnVzWdIVcTs+xXGMlkSn50B9ZMSUG5mQ
	Jzypf55BcZg9WOnzwdjLTz8lhrSA02pw=
X-Gm-Gg: AYBFou094EjjpfSNe/U+l6EUdyLgKlxRP6cPohpKaj5Mb3IwhFbZhm6nyn4BH02FwSs
	Uhsyd80EDpdUpG3kGjh8nH4fZHFuWRuhPvj3zsg2qz07ReGHCqtg772gYOda27ZPXI+HArVOGl7
	EvLcMbOk154akK/dnzfzjGVB9jTeLtuPmEpndBKhmEx2xaOLaiCHf1HrdH8JGKu/mGbl6VycEvi
	1l6/+jrQkC/31vmzsB2ckbxqHTxFjRe3zbjz/THqx1ApFwi/ZkUHiZYO5JqdKOtiBCwaQ/N6Axs
	qHQgEpDNt6TnAXGkTgoMtJ3WzhSeM+x54ghbonC0IEdcOctlf360BTzZg1sQYv4ViDEon6vS43X
	a+EAB+Q96deh97NHWj9cmcnGq9H0iFDy7WWZsxA8ncLuQOfFrKwIBW2mPErYvORDzHdBXtN9EsP
	SD13ujhq/9mpwdUVJ1KiKrNddfD5pERDwIQefxK4jEwuEtRiNdRYjtaOX9
X-Received: by 2002:a05:6808:23d3:b0:552:2c0b:905f with SMTP id
 5614622812f47-5640dc2c531mr11109420b6e.10.1793805900632; Wed, 04 Nov 2026
 07:25:00 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104151601.70493-1-dev@deq.rocks> <20261104151601.70493-3-dev@deq.rocks>
In-Reply-To: <20261104151601.70493-3-dev@deq.rocks>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Nov 2026 10:24:47 -0500
X-Gm-Features: AclHuK8hxLtpKa8aXaTi7mu-MijqC4C86dfWCBKmhN_R5OdoXiTiEBf1-KSgMMk
Message-ID: <CABBYNZLMVso40XpULwTwBwAE4tpXndSJMKhmoVLrmgm+unBNCA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: btbcm: clear vendor bits in LE advertising
 report types
To: Andre Eikmeyer <dev@deq.rocks>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sven@kernel.org, j@jannau.net, neal@gompa.dev, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	66ton99@gmail.com, josemiguelo.ochoa@gmail.com, aditya.garg@linux.dev, 
	Yossef Osman <Yossef.Osman@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Wed, Nov 4, 2026 at 10:16=E2=80=AFAM Andre Eikmeyer <dev@deq.rocks> wrot=
e:
>
> The BCM4364B0 of the MacBookPro15,1 (UART) and the BCM4377 of the
> MacBookAir9,1 (PCIe) set bits 4, 5 and 7 of the event type in LE
> Advertising Report events. btmon on the 15,1 shows types 0x10, 0x13,
> 0x14, 0x20, 0x23, 0x24, 0x93 and 0xa0 next to plain 0x00, 0x03 and 0x04,
> the same advertiser shows up as 0x13, 0x23 and 0x03. The kernel log of
> the 9,1 lists 0x10 to 0x24 and 0x80, 0x83, 0x90, 0x93, 0xa0, 0xa3.
> process_adv_report() drops every type above 0x04 with "Unknown
> advertising packet type", so most advertisements never reach the host.
> An AirDrop sender was reported as 0x23, 0x23 and 0x13 and only the
> fourth report, 0x03, reached BlueZ 32 s after the first one.
>
> Add btbcm_fixup_le_adv_report(), which clears the bits above the type,
> and call it from hci_bcm on Apple machines and from hci_bcm4377 before
> the event goes to the core.
>
> Suggested-by: Jose Miguel Ochoa <josemiguelo.ochoa@gmail.com>
> Tested-by: Yossef Osman <Yossef.Osman@proton.me>
> Tested-by: Aditya Garg <aditya.garg@linux.dev>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  drivers/bluetooth/btbcm.c       | 30 ++++++++++++++++++++++++++++++
>  drivers/bluetooth/btbcm.h       |  5 +++++
>  drivers/bluetooth/hci_bcm.c     |  5 +++++
>  drivers/bluetooth/hci_bcm4377.c |  1 +
>  4 files changed, 41 insertions(+)
>
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 0facfe62333..527a5c75fd6 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -282,6 +282,36 @@ void btbcm_set_acl_priority_on_connect(struct hci_de=
v *hdev, struct sk_buff *skb
>  }
>  EXPORT_SYMBOL_GPL(btbcm_set_acl_priority_on_connect);
>
> +/* The BCM4364 and BCM4377 of the T2 Macs set bits above the event type =
of LE
> + * Advertising Reports, 0x13 and 0x23 for ADV_NONCONN_IND for example. T=
he
> + * core drops reports of unknown types, so clear them.
> + */
> +void btbcm_fixup_le_adv_report(struct sk_buff *skb)
> +{
> +       struct hci_event_hdr *hdr =3D (void *)skb->data;
> +       struct hci_ev_le_advertising_info *info;
> +       u8 *p, *end;
> +       u8 num;
> +
> +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT ||
> +           skb->len < HCI_EVENT_HDR_SIZE + 2 || hdr->evt !=3D HCI_EV_LE_=
META)
> +               return;
> +
> +       p =3D skb->data + HCI_EVENT_HDR_SIZE;
> +       if (p[0] !=3D HCI_EV_LE_ADVERTISING_REPORT)
> +               return;
> +
> +       num =3D p[1];
> +       p +=3D 2;
> +       end =3D skb->data + skb->len;
> +       while (num-- && p + sizeof(*info) + 1 <=3D end) {
> +               info =3D (void *)p;
> +               info->type &=3D 0x0f;
> +               p +=3D sizeof(*info) + info->length + 1;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(btbcm_fixup_le_adv_report);

I don't think I agree with this being cleaner then doing at
hci_event.though; not only is it more code but it also walks the
packet which is inefficient and may have security implications as
well.

>  int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
>  {
>         const struct hci_command_hdr *cmd;
> diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
> index a4d47b242e9..56936e64b5f 100644
> --- a/drivers/bluetooth/btbcm.h
> +++ b/drivers/bluetooth/btbcm.h
> @@ -60,6 +60,7 @@ int btbcm_write_pcm_int_params(struct hci_dev *hdev,
>                                const struct bcm_set_pcm_int_params *param=
s);
>
>  void btbcm_set_acl_priority_on_connect(struct hci_dev *hdev, struct sk_b=
uff *skb);
> +void btbcm_fixup_le_adv_report(struct sk_buff *skb);
>
>  int btbcm_setup_patchram(struct hci_dev *hdev);
>  int btbcm_setup_apple(struct hci_dev *hdev);
> @@ -101,6 +102,10 @@ static inline void btbcm_set_acl_priority_on_connect=
(struct hci_dev *hdev,
>  {
>  }
>
> +static inline void btbcm_fixup_le_adv_report(struct sk_buff *skb)
> +{
> +}
> +
>  static inline int btbcm_setup_patchram(struct hci_dev *hdev)
>  {
>         return 0;
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index cf4f1455cf9..1ae9619ee1e 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -148,6 +148,7 @@ struct bcm_device {
>         bool                    no_uart_clock_set;
>         bool                    use_autobaud_mode;
>         bool                    acl_priority;
> +       bool                    adv_type_fixup;
>         u8                      pcm_int_params[5];
>         u32                     max_autobaud_speed;
>  };
> @@ -686,6 +687,9 @@ static int bcm_recv_event(struct hci_dev *hdev, struc=
t sk_buff *skb)
>         struct hci_uart *hu =3D hci_get_drvdata(hdev);
>         struct bcm_data *bcm =3D hu->priv;
>
> +       if (bcm->dev && bcm->dev->adv_type_fixup)
> +               btbcm_fixup_le_adv_report(skb);
> +
>         if (bcm->dev && bcm->dev->acl_priority)
>                 btbcm_set_acl_priority_on_connect(hdev, skb);
>
> @@ -1100,6 +1104,7 @@ static int bcm_get_resources(struct bcm_device *dev=
)
>
>         if (x86_apple_machine && !bcm_apple_get_resources(dev)) {
>                 dev->acl_priority =3D true;
> +               dev->adv_type_fixup =3D true;
>                 return 0;
>         }
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 30fcadfae3f..8d99a7a8f76 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -691,6 +691,7 @@ static void bcm4377_handle_event(struct bcm4377_data =
*bcm4377,
>
>         memcpy(skb_put(skb, len), payload, len);
>         hci_skb_pkt_type(skb) =3D type;
> +       btbcm_fixup_le_adv_report(skb);
>         btbcm_set_acl_priority_on_connect(bcm4377->hdev, skb);
>         hci_recv_frame(bcm4377->hdev, skb);
>


--=20
Luiz Augusto von Dentz
