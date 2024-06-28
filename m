Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290819D071;
	Fri, 28 Jun 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582855; cv=none; b=k0WOeEfJt+tQK68q5b4CLsxtcM2S1Xz0qXH2T9ozfnenJegk5EdLZislKMay7QP2WNd+7XDhi0mvGBUY2uHEuaQxZV3dT1o4OSuRcmltS/CrLvtp4FSwKmBH6/tTPdIEJ0HI0/cwxPr59Ua1Y5z48HWSnYUpmF7WZjQav8lYjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582855; c=relaxed/simple;
	bh=UgpEY5+i8/Z6anCuEas02ZZMxpMB3cSzEqAgIVlS860=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhNgndlqiwYdtCmv/303HkBlal+yOIwOehqiNa/INRDQNsrz73gT2QAGCGw3wWmI8M1+2x95Jc4PsZFTyfHm4QJHMDKvvs0mw7AE6KWg27ZWhKnGyKYlcxSRn4/UbgaL9pFlXlf7ehB/tG4KuexCirtKvizBzph5B+m2lpVBqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWnjvkgl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWnjvkgl"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cdf579dd2so693719e87.3;
        Fri, 28 Jun 2024 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719582851; x=1720187651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBVbpnvb0gPLHGQCBLbrd5zY6O8ILSt6Tx8Dxy4I+hk=;
        b=hWnjvkglObuPsGQTncVFBXOyOLhAjeVRS6uowgYRfaNK/8cIUF/DoGiF9OMkqdqpgu
         a8KGnVeH6cJPIGkjTa0kksiPg2Vrih8PLkI2lnxEGd0ePg0dJgmCbE4Bq+iOohT+KUgH
         Hlg+ENYtAy3AeUebwDCLcKV9E0Srlc3BisCMUVBgKxMc39biTLDkzxQmF83U05edlp5i
         NybiMyHADGIHfYMkKQfQu6j61rdBqF9O/qTYfaSBobxcfbGBx3RGO58+Bbfef1g9WQ9p
         5czFC8dbrqBINRqnZRiUk0cPjN9s8TaC5bj6GJh6+ktwMlqh2f6Sa70qwNGnDdz6wPA3
         CNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719582851; x=1720187651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBVbpnvb0gPLHGQCBLbrd5zY6O8ILSt6Tx8Dxy4I+hk=;
        b=uMIfAz9o0JvTjOkhcFtTAniouaAHntXjhZ+AS1SCB7DFg7V/BWOMpuMbP/ZylV/7MD
         kDQC8pOhc77r8SPa1pypCLoFaDavFe/alN0FVTQLmNcP0oQ3OiRnBglvf8ouLLe3sahQ
         3o4D88upgFkJys+FOEkyQhhgMzqVgkEj/mDN42KCuyciMWZxisytls7OIlzpinwRuV1a
         JK7I2Jinjk7AYsTjdypxrmS8NINAHCTa8qHAO4fvfJLFKIrkuuModvICzZ/dh2EWMPwd
         xS7ps3Dj4OBUKRCI6wVbYpk0pGeveIvB2Dw76058w69GGuoGhpuboU5LutiTdHs/Mk+y
         zAtw==
X-Forwarded-Encrypted: i=1; AJvYcCX+E4qlVoFG2G1TyGnON8yfkHp+YQvOcy8wlkGE8b72dwkNW6HQtyny87C5FVW0Dx0y0EX8ve0dAxxZ4lbKHcxtkcor84qqoRyha0XqcaLsN3s1BzUV2dwWF0vW1NZNLXEVtds3SWVrw6ZlK7nE
X-Gm-Message-State: AOJu0YzQJcxWKMsSeLvanqN/ouXlVYp0mrXdp/QBc5rfreSrct7qgrMw
	IhV8VOCD4B9wQLEDoigyHToq/bGD0Db94apu9RsX9MV44/sbQ2LUKp+rwRnkUMDZcyiapnVJ52e
	YlIUk264W1ZS9MQp2AGeM75y6XKI=
X-Google-Smtp-Source: AGHT+IFdMCMIxWZoGul4vB1a9jhW+TJOXLlIyStoMES0g4ZuRUhGFqFY2NkZR96uhzX/xaj9qno/V66OQd1nbEiaboo=
X-Received: by 2002:a2e:bc88:0:b0:2ee:4c72:204e with SMTP id
 38308e7fff4ca-2ee4c7223e0mr37847691fa.0.1719582851072; Fri, 28 Jun 2024
 06:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628101624.3470355-1-hildawu@realtek.com>
In-Reply-To: <20240628101624.3470355-1-hildawu@realtek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Jun 2024 09:53:58 -0400
Message-ID: <CABBYNZ+ZUJJ7p7+Wv6_NByVN4pX3=UwRvr7DTVPTmztMi8YmWQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btrtl: fix duplicate SCO packet
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn, max.chou@realtek.com, 
	kidman@realtek.com, apusaka@chromium.org, yinghsu@chromium.org, 
	johnlai@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hilda,

On Fri, Jun 28, 2024 at 6:16=E2=80=AFAM Hilda Wu <hildawu@realtek.com> wrot=
e:
>
> In some platform found unknown connection handle case when HFP. The
> unknown connection handle may affect SCO audio sound quality.
> After investigation, it was found the value of the unknown connection
> handle is actually a duplicated data.
>
> The duplicate data affected the unknown connection handle in some
> Realtek chip. This issue only occurs in (e)SCO, does not affect ACLs.
>
> This commit is to filter out the duplicate packet for avoiding influence
> SCO audio.
>
> Below btmon trace gives a better idea of what we're filtering.
> The following excerpts are part of SCO packets in the HCI log:
>
> > SCO Data RX: Handle 11 flags 0x00 dlen 72      #23327 [hci0] 132.343418
>         8c a3 55 4f 8a d5 56 e9 35 56 37 8d 55 87 53 55  ..UO..V.5V7.U.SU
>         59 66 d5 57 1d b5 54 00 01 08 ad 00 00 e0 10 00  Yf.W..T.........
>         00 00 85 c6 d5 60 e9 b5 52 94 6d 54 e4 9b 55 b1  .....`..R.mT..U.
>         b6 d5 62 91 b5 57 84 6d 56 e4 5b 55 75 c6 d5 51  ..b..W.mV.[Uu..Q
>         2d b5 53 9a 6d 54 a5 1b                          -.S.mT..
> < SCO Data TX: Handle 11 flags 0x00 dlen 72      #23328 [hci0] 132.343600
>         01 c8 ad 00 00 aa db ba aa a9 72 b4 d9 5d af 14  ..........r..]..
>         53 0c 75 b0 a6 f3 8a 51 b3 54 17 b1 a6 d5 62 c5  S.u....Q.T....b.
>         d5 6b 35 29 8d c5 1c 56 4c 24 96 9b 8d b5 d7 1a  .k5)...VL$......
>         b2 8d bc da 3b 8c 46 ae 1d 4d a4 04 01 f8 ad 00  ....;.F..M......
>         00 3d ec bb a9 98 8b 28                          .=3D.....(
> > SCO Data RX: Handle 11 flags 0x00 dlen 72      #23329 [hci0] 132.353419
>         55 55 c6 d5 62 29 b5 57 b2 6d 54 00 01 38 ad 00  UU..b).W.mT..8..
>         00 e0 10 00 00 00 0b 00 d5 62 55 c6 57 b2 29 b5  .........bU.W.).
>         00 01 6d 54 00 00 38 ad 00 00 e0 10 00 00 00 92  ..mT..8.........
>         36 d5 5a ed b5 58 6c 6d 55 b3 1b 55 6b 26 d5 52  6.Z..XlmU..Uk&.R
>         d1 b5 54 23 6d 56 82 db                          ..T#mV..
> < SCO Data TX: Handle 11 flags 0x00 dlen 72      #23330 [hci0] 132.353581
>         6d 5b be db 89 34 66 e9 fa 99 a6 6e e5 6d 9f 1a  m[...4f....n.m..
>         1c 57 d2 66 92 63 98 99 a9 3b 8a 6c 3e 5b 5a 34  .W.f.c...;.l>[Z4
>         a4 96 e2 21 21 8c f8 88 0f 3d e0 52 48 85 18 00  ...!!....=3D.RH.=
..
>         01 08 ad 00 00 0c eb ba a9 a8 28 ca 9a d0 3c 33  ..........(...<3
>         45 4a f9 90 fb ca 4b 39                          EJ....K9
> > SCO Data RX: Handle 2901 flags 0x0a dlen 54    #23331 [hci0] 132.373416
>         d5 48 a9 b5 56 aa 6d 56 d2 db 55 75 36 d5 56 2d  .H..V.mV..Uu6.V-
>         b5 57 5b 6d 54 00 0b 00 48 01 c8 ad 00 00 e0 10  .W[mT...H.......
>         00 00 00 5e c6 d5 56 e1 b5 56 43 6d 55 ca db 55  ...^..V..VCmU..U
>         7d c6 d5 5b 31 b5
>
> This is HCI SCO data RX packets.
> The packet 23327 was a normal HCI SCO data RX packet.
> The packet 23329 was the abnormal HCI SCO data RX packet.
> The packet 23331 was the invalid connection handle case but the packet is
> affected by the packet 23329 abnormal HCI SCO Data RX packet.
>
> So this patch expects to filter the packet 23329 SCO data RX packet
> case. The packet 23329's connection handle (0x0B 00/11) and length
> (0x48/72) is normal.
> This btmon trace is SCO packets in USB alternate setting 3, payload
> length is 72 bytes that consist of three SCO data packets.
> The anomaly is due to the intermediate composed data.The duplicate
> data in the intermediate composition data, but it affects packet
> combination. Cause the system parses the next packet of the connection
> handle mistake that shows unknown connection handle messages.
>
> This commit can estimate and find out its abnormal rule to filter the
> duplicate packet out for avoiding influence.
> Check fragments and filter out the abnormal packet, and then it will
> not affect the system parsing of the connection handle subsequent.
>
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
>  drivers/bluetooth/btrtl.c | 49 +++++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btrtl.h |  7 ++++++
>  drivers/bluetooth/btusb.c |  8 +++++++
>  3 files changed, 64 insertions(+)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index f2f37143c454..f286654a8fae 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1300,6 +1300,11 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct=
 btrtl_device_info *btrtl_dev)
>                     btrtl_dev->project_id =3D=3D CHIP_ID_8852C)
>                         set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &h=
dev->quirks);
>
> +               if (btrtl_dev->project_id =3D=3D CHIP_ID_8822C ||
> +                   btrtl_dev->project_id =3D=3D CHIP_ID_8852A ||
> +                   btrtl_dev->project_id =3D=3D CHIP_ID_8852B)
> +                       btrealtek_set_flag(hdev, REALTEK_SCO_CLEAN_DUPLIC=
ATE_DATA);
> +
>                 hci_set_aosp_capable(hdev);
>                 break;
>         default:
> @@ -1479,6 +1484,50 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>  }
>  EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
>
> +int btrtl_validate_isoc_data(u16 mps, struct sk_buff *skb)
> +{
> +       u8 *prev;
> +       u8 tmp[8];
> +       u32 *a;
> +       u32 *b;
> +       u16 i;
> +       u8 *next;
> +       u8 *start =3D skb->data;
> +
> +       for (i =3D 0; i < 2; i++) {
> +               prev =3D start + i * mps;
> +               next =3D prev + mps;
> +
> +               if (!memcmp(prev + 4, next + 2, 8))
> +                       continue;
> +
> +               /* Check the current fragment with the previous one.
> +                * If the current fragment is redundant but it is a littl=
e bit
> +                * different from the previous, drop it.
> +                * For example,
> +                * 04 00 48 55 4E CB 55 52 80 95 55 07 XX XX ...
> +                * 04 00 55 52 4E CB 55 07 80 95 XX XX XX XX ...
> +                */
> +               memcpy(tmp, prev + 4, 8);
> +               a =3D (u32 *)(tmp);
> +               b =3D (u32 *)(tmp + 4);
> +               *a =3D swahw32(*a);
> +               *b =3D swahw32(*b);
> +
> +               if (next[0] =3D=3D prev[0] && next[1] =3D=3D prev[1] &&
> +                   !memcmp(next + 2, tmp, 8)) {
> +                       if (i =3D=3D 0)
> +                               memcpy(start + mps, start + 2 * mps, mps)=
;
> +                       skb_trim(skb, 2 * mps);
> +                       hci_skb_expect(skb) =3D mps;
> +                       return -EILSEQ;
> +               }
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btrtl_validate_isoc_data);

NAK, the driver has no business deep inspecting the packets like that,
specially since you are not doing any length checks.

>  MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
>  MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION)=
;
>  MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index a2d9d34f9fb0..3ddb691dff94 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -105,6 +105,7 @@ struct rtl_vendor_cmd {
>
>  enum {
>         REALTEK_ALT6_CONTINUOUS_TX_CHIP,
> +       REALTEK_SCO_CLEAN_DUPLICATE_DATA,
>
>         __REALTEK_NUM_FLAGS,
>  };
> @@ -148,6 +149,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>                             unsigned int *controller_baudrate,
>                             u32 *device_baudrate, bool *flow_control);
>  void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name=
);
> +int btrtl_validate_isoc_data(u16 mps, struct sk_buff *skb);
>
>  #else
>
> @@ -195,4 +197,9 @@ static inline void btrtl_set_driver_name(struct hci_d=
ev *hdev, const char *drive
>  {
>  }
>
> +static inline int btrtl_validate_isoc_data(u16 mps, struct sk_buff *skb)
> +{
> +       return -EILSEQ;
> +}
> +
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2d7d47f9d007..2b66211eb02c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1317,6 +1317,14 @@ static int btusb_recv_isoc(struct btusb_data *data=
, void *buffer, int count)
>                 }
>
>                 if (!hci_skb_expect(skb)) {
> +                       if (btrealtek_test_flag(data->hdev, REALTEK_SCO_C=
LEAN_DUPLICATE_DATA) &&
> +                           data->air_mode =3D=3D HCI_NOTIFY_ENABLE_SCO_T=
RANSP &&
> +                           test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags=
) &&
> +                           data->isoc_altsetting =3D=3D 3 &&
> +                           skb->len =3D=3D 3 * data->isoc_rx_ep->wMaxPac=
ketSize &&
> +                           btrtl_validate_isoc_data(data->isoc_rx_ep->wM=
axPacketSize, skb))
> +                               continue;

Can't you take a simpler approach and not use the ALT3 setting to
begin with? So instead of handling this via
REALTEK_SCO_CLEAN_DUPLICATE_DATA just don't set
BTUSB_USE_ALT3_FOR_WBS, if that means WBS cannot be used then so be it
since NBS is still better than a broken WBS.

>                         /* Complete frame */
>                         hci_recv_frame(data->hdev, skb);
>                         skb =3D NULL;
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
