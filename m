Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F001F2C57;
	Tue, 21 Jan 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475132; cv=none; b=RRvNR8wiQ0k5L+sej5DqJwoSep1KWb5+Kg7X3Cx+mamowilRVtpIC+V9RUHReb+Jv3ZEcc3RkGoxc0f/Fc/hKpTpMrn5f82C/v63SbfV+vo/W7sV5x21hLXNze+/QBxbq+TWMbMc5/JCPlm4polkJtdUK4nQCBQAyc50yLDjjQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475132; c=relaxed/simple;
	bh=BeK5sGxoxqXeaKLJNCa8Ce/GUWz9adAvQqpelT86ZfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck9lDaH+QsRvqTdN3WDSu30lCa+EDCHctixBdcApHjNtoF5zLn+JWH/glunOIdbXJellZgPW1TTSjCB1EJt3QuHJfKudUmGA7EAv+nO2E4UkJ+yKGnDBldk2+27b+2fwAFOZZgl+HzNdfRbAIgE5ZeiynxORYJnnBJl2FH3N3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqbeuh+w; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqbeuh+w"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30613037309so58151561fa.3;
        Tue, 21 Jan 2025 07:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737475128; x=1738079928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5KHWwgcFdIA67jNB7pNMfK6Szvrf5G/qL/ON4cLx8A=;
        b=lqbeuh+w/LkKlSo4e0DNqS+z0oCkj9nHr2U/C1sk1CGanhn9B2fr4iVJxFFwvDou6K
         4XEuW7wpCNjX8jAuYib1z23AHHPUqNN79cmj8dVeYUsojxrx8asxsiD56Wp8qHPHI4lu
         dqVnwZ3GhIT2qWyncVEjKPGP8ouA0d6EjDoprQtagw6ZtfdbA0SgAmywMrDtNHjSD1GI
         SIDK27EmIq5cJIjbjqqUxyn7+zFi2lPRTOmQh2lIpV/mljdLa4etD6qkjJDnQVv6fNvf
         D18/AmUsETShzl+Q2D4ETDNjSr7CAvhtQOO3YS5jtX6gdkk+eiPL1sRNDADllpnWBqJf
         0rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737475128; x=1738079928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5KHWwgcFdIA67jNB7pNMfK6Szvrf5G/qL/ON4cLx8A=;
        b=lWL/UADzrVoUydAwZhNNmAooSfZbDAXXtYMZIKpiQg1BER6CE90JMVkb/HyUiCvjKd
         m/QfEuq+8tVeRa/73TVRHBVwRh8VPLhKD5ltjgIiIySsqSTxe77/dfMgd9nxULkTeAJr
         Ov0XW6OyA5ek52hjiUWLsKrKs2ZwhZe5AObt/5dznTN8cbUpTfcc5NiMntc4uKqLdylk
         jThgo8FBV2Z+GtGccdVMJmF43h3vcedf7cG3oQRBJnRPgXXj2+eW05BibO8L1172EW7I
         KgRKbhm6jGwW0vknwEFR0vR9AKeoB87zilJ+n9FIsK/as+fOyvmNlaJfvXH8LA7wJ8KY
         SxAw==
X-Forwarded-Encrypted: i=1; AJvYcCUnx1WtS9QdMZD3KeL7uqi+JZBMlwfWcNMlzR+FaW2O2sH7GY9r7n/nXOIJ3k/pZVVlLK7eHhk3Ig6H3FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuUsxG+xyAgAof889HJvF3gIX6EroPL/+mg/HeXpOIDyBh4EW
	LTVJYGv+fuCUvVExV4eolk7lJhMfP5lwwFAt1l0q3uzTJe1ckO1BLwH3nsT4T5hnyiyFod/soS+
	Peo5a5jIFb5W71XXdPkSbdTTMUcNAyQ+N
X-Gm-Gg: ASbGncscIe/x40u/o3wAXBLa6HHZlx4SuzddJJjWqX80AcW0w3rxh+Yl1fqNDkY9LEa
	2RfZXVQCPQjPpyt19i5i0u1Ic9t40n6Y633whXdI2prJtohD/l8bR
X-Google-Smtp-Source: AGHT+IF6HSshVr9F2ct6Bn542GAiKDL+wajvltBAko5UhDirjDK15gfVTM1WWIJtsPQDKPA9qscZHhrxUMDKq1+7l9o=
X-Received: by 2002:a2e:b8cd:0:b0:300:4362:40 with SMTP id 38308e7fff4ca-3072cb28501mr65597991fa.36.1737475128084;
 Tue, 21 Jan 2025 07:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121151532.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250121151532.2.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
In-Reply-To: <20250121151532.2.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jan 2025 10:58:35 -0500
X-Gm-Features: AbW1kvaDr0eBVTpAHSKQVaJrDhO88zV70Hfz_1xrTJAD6uGZ5xOdMw6u83HtlCs
Message-ID: <CABBYNZ+esphP5CqCnazjyhHmgBLSRMVieaMBOwryorLO4oaGfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Allow SCO packets regardless of hci_conn_num
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Hsin-chen,

On Tue, Jan 21, 2025 at 2:17=E2=80=AFAM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> The SCO packets from Bluetooth raw socket are now rejected because
> hci_conn_num is left 0. This patch allows such the usecase to enable
> the userspace SCO support.
>
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
>  drivers/bluetooth/btusb.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f419d0827ee4..3e2d7ea6de5c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2107,9 +2107,6 @@ static int btusb_send_frame(struct hci_dev *hdev, s=
truct sk_buff *skb)
>                 return submit_or_queue_tx_urb(hdev, urb);
>
>         case HCI_SCODATA_PKT:
> -               if (hci_conn_num(hdev, SCO_LINK) < 1)
> -                       return -ENODEV;

Hmm, we probably need to check if USER_CHANNEL has been opened instead
of simply removing the check.

> -
>                 urb =3D alloc_isoc_urb(hdev, skb);
>                 if (IS_ERR(urb))
>                         return PTR_ERR(urb);
> @@ -2588,9 +2585,6 @@ static int btusb_send_frame_intel(struct hci_dev *h=
dev, struct sk_buff *skb)
>                 return submit_or_queue_tx_urb(hdev, urb);
>
>         case HCI_SCODATA_PKT:
> -               if (hci_conn_num(hdev, SCO_LINK) < 1)
> -                       return -ENODEV;
> -
>                 urb =3D alloc_isoc_urb(hdev, skb);
>                 if (IS_ERR(urb))
>                         return PTR_ERR(urb);
> --
> 2.48.0.rc2.279.g1de40edade-goog
>


--=20
Luiz Augusto von Dentz
