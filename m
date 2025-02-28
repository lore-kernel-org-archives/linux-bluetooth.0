Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68E188721;
	Fri, 28 Feb 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757303; cv=none; b=sFHrM5xj/EisxgiqGzjsNuw5LBtNiJMLCGfQ0IRcD1Y5HemD9CpGBErG8wp0KQ/uCZMjF0YTJWUnoo8N+nzpqdbQDf+bjGCVBez8fn8U6E09pBLkO5Ka1ZsLrmwiRfdaOejKM3ZDy2E2hLsE0rPzJzVREn6v/D9GxYUiro8sPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757303; c=relaxed/simple;
	bh=DJLPQ5JGZhcfs2Kw16P7wl3ZJUNBN3zQxdlstBLUJb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTnXcek4BvWnp4TAwmw1vckF7NbvP3jRsumsTn9BtQTird75jIRedh3CdWB8bwUaHcluL7KbgjYlqVE8ivfgd6yTCUCQ/r4bToowfiykl9e9XJoyWNZrc7S9OYkL52VBtGog9HSuKO9c7galPUHi1ior9eaTbTPIa5SvJteXSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA/TLi9K; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA/TLi9K"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30797730cbdso21615861fa.3;
        Fri, 28 Feb 2025 07:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757299; x=1741362099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPDtPTzn/laJuqWNLbr3aC2gYWBY//cGMLqVAaYzzjo=;
        b=VA/TLi9K+7JVNq79n8rNv/JnUt+1R0xbwOqTwTaNGeV535UeqOKSpzKe0GkAAZ2NbW
         Ds9B4Zqu3c7dg+pz2Ji6aJX4CXRLl8a8SN6eDO4m/5jKBCO6uZ32O+PGoloR8RYovT2l
         ddv2DBZv6eR313cXBF6eRF9Wu+hXhIVBHBvHR8oEThpN9a3T1S4FdyKeu0+hbqldftQ8
         ODfFkwt7bSiwnVnRVL4Sb9FHhSjNaMFOK7W9AXx3UsyC88jtBqUSRQYxI52R0acL3li7
         83b2SQKZ5slffZYxOnuiU+dN1lkVzAF7duohqtjuBj177WbRsdZXIRI1MPz+/loVBXZa
         go9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757299; x=1741362099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPDtPTzn/laJuqWNLbr3aC2gYWBY//cGMLqVAaYzzjo=;
        b=Q1MbbQ4I2v1AdpDK7/3dPti34oR3ENqfe4H6Rt+2LhqEaZUanmvMdj9zVpcKaBdS2d
         Fxt7enf5rS6xgebtNGNjl1J+XwvpIPBWacOWpHo/O2HBH5YH9HQzrjDo4WsiLJgN4dGj
         kRGv6qjeJdpIzOj5a/u+SIydV4QyNnFYWpfX7jmQaYY4jCNzrHtAtxXJLYru3BRTAhl4
         p1zYWvcURn+yY7HfEpFyGggJ64euwsM+wEszCaufLXHb9DYxEpl5unkc6/+HuGdBri++
         8IkUzr1sK++el1iM5rKmsiYfkibp/KZvcmQtf5NqkXXEvWeXv1NoXy60OL0Ro+356H9T
         j54w==
X-Forwarded-Encrypted: i=1; AJvYcCUtw6rdyr8k96jVzfqKUD/UVpIgaqYZI/RJ9grlv/3JFd3wJDcT4hGPMIGWYJCUmq8JgZmWTmAzAugR@vger.kernel.org, AJvYcCVbpasxcB3WczU70JZG11CUdQdz1RJvyv34a8CLL0Sj+4ZSLnFmBX++0oaGuqfeNRQYdz+XrRH64bDKH5r7crxw@vger.kernel.org, AJvYcCW9aWrzjoHpimChCTJkdeYFi9JQaH+VQVZwF7ORcgvhQn6OjlHzNikLUSpaw6MV6GAy41EhZF3rzy1UGTQa@vger.kernel.org
X-Gm-Message-State: AOJu0Yykotgu4yNHXE2D5Evsr7vBhPzf28gHacjS0ESXUleLu/n2yf1W
	acV24lGNOp7eI1DyRfe55oUV9MA6LS2zCf7SeyX2XrXuX3LLhRgXS3kwPyPQ4GVHR5sz/BANLqq
	wdVJ1fW++srSr/RFEckTaEi7nYfU=
X-Gm-Gg: ASbGncu3vHfMeJicMfroX2NjmZvVSmlAmouiywxog+9Y8t+2i+GSNxYE2cwGKMGhxF8
	josGA+aXooKxaJIFReVPJ4A/zUtjCCXiJZTPhsZQ1eSrKALPlTSa1UAHIQCmNnkpi629YE5IFPI
	a18//J1A==
X-Google-Smtp-Source: AGHT+IHhRKNnwVG84x9Gp7sYpTFMGa9cQBb1SVUjJLGLT2xxrqFMI/AI4OWU+Mtnq4chRzQAY16BsKcub+6KRQlKTH8=
X-Received: by 2002:a2e:be15:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30b9326afc7mr18302251fa.18.1740757298276; Fri, 28 Feb 2025
 07:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228152917.5432-1-neeraj.sanjaykale@nxp.com> <20250228152917.5432-2-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250228152917.5432-2-neeraj.sanjaykale@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Feb 2025 20:41:25 +0500
X-Gm-Features: AQ5f1Jrbl8x9_1Zdis8fXWqZa_Zr_A5lHppkYmsuWomgk0zq4BbeLnkyT7ZMLRk
Message-ID: <CABBYNZLMFYaEjgRhO7J+sDRdp=JPVhgLdLrUNWkum5YTc5dv_w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Bluetooth: btnxpuart: Add support to set BD address
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	amitkumar.karwar@nxp.com, sherry.sun@nxp.com, ziniu.wang_1@nxp.com, 
	johan.korsnes@remarkable.no, kristian.krohn@remarkable.no, 
	manjeet.gupta@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neeraj,

On Fri, Feb 28, 2025 at 10:27=E2=80=AFAM Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> This adds support for setting BD address during hci registration. NXP
> FW does not allow vendor commands unless it receives a reset command
> after FW download and initialization done.
>
> As a workaround, the .set_bdaddr callback function will first send the
> HCI reset command, followed by the actual vendor command to set BD
> address.
>
> The driver checks for the local-bd-address property in device tree, and
> if preset, it sets the HCI_QUIRK_USE_BDADDR_PROPERTY quirk.
>
> With this quirk set, the driver's set_bdaddr callback function is called
> after FW download is complete and before HCI initialization, which sends
> the hci reset and 3f 22 commands. During initialization, kernel reads
> the newly set BD address from the controller.
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
> Signed-off-by: Kristian Krohn <kristian.krohn@remarkable.no>
> Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v4: hci0 interface shows RAW mode if 'local-bd-address' not defined and
>     HCI_QUIRK_USE_BDADDR_PROPERTY is set. Add Quirk only if device tree
>     property 'local-bd-address' found. (Neeraj)
> v5: Initialize local variable ba, update Copywrite year. (Kristian)
> v6: Elaborate commit message, add User Manual reference. (Paul Menzel)
> ---
>  drivers/bluetooth/btnxpuart.c | 63 ++++++++++++++++++++++++++++++++---
>  1 file changed, 58 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 1230045d78a5..2eb14b9beb70 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *  NXP Bluetooth driver
> - *  Copyright 2023 NXP
> + *  Copyright 2023-2025 NXP
>   */
>
>  #include <linux/module.h>
> @@ -98,13 +98,16 @@
>  #define PS_STATE_AWAKE          0
>  #define PS_STATE_SLEEP          1
>
> -/* Bluetooth vendor command : Sleep mode */
> +/* NXP Vendor Commands. Refer user manual UM11628 on nxp.com */
> +/* Set custom BD Address */
> +#define HCI_NXP_SET_BD_ADDR    0xfc22
> +/* Set Auto-Sleep mode */
>  #define HCI_NXP_AUTO_SLEEP_MODE        0xfc23
> -/* Bluetooth vendor command : Wakeup method */
> +/* Set Wakeup method */
>  #define HCI_NXP_WAKEUP_METHOD  0xfc53
> -/* Bluetooth vendor command : Set operational baudrate */
> +/* Set operational baudrate */
>  #define HCI_NXP_SET_OPER_SPEED 0xfc09
> -/* Bluetooth vendor command: Independent Reset */
> +/* Independent Reset (Soft Reset) */
>  #define HCI_NXP_IND_RESET      0xfcfc
>
>  /* Bluetooth Power State : Vendor cmd params */
> @@ -310,6 +313,15 @@ union nxp_v3_rx_timeout_nak_u {
>         u8 buf[6];
>  };
>
> +union nxp_set_bd_addr_payload {
> +       struct {
> +               u8 param_id;
> +               u8 param_len;
> +               u8 param[6];
> +       } __packed data;
> +       u8 buf[8];
> +};
> +
>  static u8 crc8_table[CRC8_TABLE_SIZE];
>
>  /* Default configurations */
> @@ -1197,6 +1209,38 @@ static int nxp_set_ind_reset(struct hci_dev *hdev,=
 void *data)
>         return hci_recv_frame(hdev, skb);
>  }
>
> +static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> +{
> +       union nxp_set_bd_addr_payload pcmd;
> +       struct sk_buff *skb;
> +       int err;
> +
> +       pcmd.data.param_id =3D 0xfe;
> +       pcmd.data.param_len =3D 6;
> +       memcpy(pcmd.data.param, bdaddr, 6);
> +
> +       /* BD address can be assigned only after first reset command. */
> +       skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIME=
OUT);
> +       if (IS_ERR(skb)) {
> +               err =3D PTR_ERR(skb);
> +               bt_dev_err(hdev, "Reset before setting local-bd-addr fail=
ed (%ld)",
> +                          PTR_ERR(skb));
> +               return err;
> +       }
> +       kfree_skb(skb);

If you don't care about the response, just the status, it is probably
better to use __hci_cmd_sync_status, also since the hdev->set_bdaddr
comes after hdev->setup doesn't the later do perform a reset anyway?
If you end up with 2 resets in a row it problems means you don't need
to reset again.

> +
> +       skb =3D __hci_cmd_sync(hdev, HCI_NXP_SET_BD_ADDR, sizeof(pcmd),
> +                            pcmd.buf, HCI_CMD_TIMEOUT);

Ditto.

> +       if (IS_ERR(skb)) {
> +               err =3D PTR_ERR(skb);
> +               bt_dev_err(hdev, "Changing device address failed (%d)", e=
rr);
> +               return err;
> +       }
> +       kfree_skb(skb);
> +
> +       return 0;
> +}
> +
>  /* NXP protocol */
>  static int nxp_setup(struct hci_dev *hdev)
>  {
> @@ -1500,6 +1544,7 @@ static int nxp_serdev_probe(struct serdev_device *s=
erdev)
>  {
>         struct hci_dev *hdev;
>         struct btnxpuart_dev *nxpdev;
> +       bdaddr_t ba =3D {0};
>
>         nxpdev =3D devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL=
);
>         if (!nxpdev)
> @@ -1547,8 +1592,16 @@ static int nxp_serdev_probe(struct serdev_device *=
serdev)
>         hdev->send  =3D nxp_enqueue;
>         hdev->hw_error =3D nxp_hw_err;
>         hdev->shutdown =3D nxp_shutdown;
> +       hdev->set_bdaddr =3D nxp_set_bdaddr;
> +
>         SET_HCIDEV_DEV(hdev, &serdev->dev);
>
> +       device_property_read_u8_array(&nxpdev->serdev->dev,
> +                                     "local-bd-address",
> +                                     (u8 *)&ba, sizeof(ba));
> +       if (bacmp(&ba, BDADDR_ANY))
> +               set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +
>         if (hci_register_dev(hdev) < 0) {
>                 dev_err(&serdev->dev, "Can't register HCI device\n");
>                 goto probe_fail;
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
