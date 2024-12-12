Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A222332D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026568; cv=none; b=KzzIHv6x+rMyN2gvbUs/bbJAqh+NvXTYZBFuh7S1XyJ0+19g7nCGyfh9cb40Dg8b6FhfHsD3guxFvoHcLivhmJpzuhL7PH6nH9UEYzmVSIm4C7NaIXsLDUhXfUaNG+r57mj9Mc/cyZscCmVGAxQ584jDG6BZ5CD+mpW+iKhQzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026568; c=relaxed/simple;
	bh=oxbmTRlcxN3jtA8tepERzzxu+M4YDZ80ch1ICBiV73U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2jz2UYt+WMwG93YyR4Trc+IYfWSQyyX2mpoOeEGml4Ip0B3qn5Yo3KWQS1EuKmRcOdS7M22YuuLDOsBGU2h5e6b7JFZUqOVydNqu3nVMzSllMkJ5aLdrlXuI1XVU5N7WyQDFUaEdAQJKvxo7VvkoApjqSNVlmFWtIAmkBIcOdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGPG8iYd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGPG8iYd"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso8765891fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026565; x=1734631365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXTvNxvl2eaWd4YJASDFR1yAUVz1qyVHxeRdoiIYb1k=;
        b=GGPG8iYdcimpfQ4EtqFwEz6IQnYObODA3vWMAlCGEnt7lUf1vrW6E0vMSPMdpBLDtM
         KkxRS2DBoBpIsvk9oAWVSVhftiuKt2+lpgYxvAcHHtjbaKz5IcVjg4McdHr3DHXZfkX/
         tbGghR7z5haK+3lUV5TzHbOguyxV9wtElpAMTt3XVSDEyW/uy2HJN7y9lKgtZYqhl/w4
         hQzB3h2yMROQV4tX6jScAtp+W0vpjBnYLkzh8CiUZXgcI1z+clmiqOQ5e75JddDflc4r
         lTYLq71hwVIrEsUoOYRAHQXIhA79nOcEC5vwelDeY1aazkU6xtJcinJKuSiaN2XuEXV2
         +4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026565; x=1734631365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXTvNxvl2eaWd4YJASDFR1yAUVz1qyVHxeRdoiIYb1k=;
        b=utViJzoOKVgAD8/mJn4liexYJ+xmG/byXJp4bFVobfhVIF9diodwUY1c0dO0w/p3OI
         vkN0VDUZ7Ed9UhGhRH+d01szej2D5Yt/wL1dY4i2/vW8DZcox0RjMPjT0KIsysc15c1t
         UWhNtdDJtaqRLQce+BgCpKudKjFmamYfeWFJidpi9LA1QH2J4dVGma4vxUdQFFGaXu+v
         sb6N2x6XeeZ8YUoL4yZdVRNzlDsGTDDgFwMeYCx8Tse376bMYd4gdu5Hl8Mm0jLtgj7R
         xIvdJPNHXkvhjdZWYDktv+mpozbflfqIxS2NkuwG+Zm45kSZexdYGsefRLMCdz/w6ptM
         yW9g==
X-Gm-Message-State: AOJu0YxferQJtC0KyAWl7OJuKab6u49m057mARpFT4tsZNTke3QfLzze
	Ktgom/YJCJWJ0AH2OUxNqV5LGi36OzWfpByxJQ/VcqHbPZIYhDeBWxhkvwSdChqpfReW+iSWO7r
	bIvBgltQU6pq9vHcFHJZLoBemLaFOcUvt
X-Gm-Gg: ASbGncvGt7NCZ9i5iexVKd9+YpJPiX/BTJ+a8+3fGOVWWlt4OunUv6O0qpsLScqFHAB
	hqfmwhO5+yR/nTNuEej2lWUWmsLaTo3TKmR+lJeM=
X-Google-Smtp-Source: AGHT+IE7vLi3imLypzTZhHv9/v+NnkWSCooE8hP8sJppjgEuiV/7dyfovz2z5yTh58gZqYhY/ug8obSAmF477mekHtY=
X-Received: by 2002:a2e:8785:0:b0:302:22e6:5f8 with SMTP id
 38308e7fff4ca-30251e2fdf3mr3517831fa.22.1734026564621; Thu, 12 Dec 2024
 10:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212173551.192925-1-yinghsu@chromium.org>
In-Reply-To: <20241212173551.192925-1-yinghsu@chromium.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Dec 2024 13:02:32 -0500
Message-ID: <CABBYNZKcWJFgGbEW_pxadfQ=P4_ia5c9vnfJuKvkJrFWUhvehw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: add sysfs attribute to control USB alt setting
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ying,

On Thu, Dec 12, 2024 at 12:35=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> wr=
ote:
>
> When a Bluetooth raw socket is open, the HCI event related to SCO
> connection changes are not dispatched to the hci_event module, and
> the underlying Bluetooth controller's USB Interface 1 will not be
> updated accordingly.
>
> This patch adds `isoc_alt` sysfs attribute, allowing user space
> to update the alternate setting of the USB interface alternate
> setting as needed.
>
> BUG=3Db:382526205
> TEST=3Dread and write /sys/class/bluetooth/hci0/isoc_alt
>
> Series-to: linux-bluetooth@vger.kernel.org
> Series-to: luiz.dentz@gmail.com
> Series-cc: chromeos-bluetooth-upstreaming@chromium.org
>
> Commit-notes:
> This commit has been tested on a chromebook with AX211.
> END
>
> Change-Id: Ifc708cc471a8834b344c26fce1ce2fe3e5992cad

Ok, what is up with these artifacts? I don't think we use those upstream.

> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> ---
>  drivers/bluetooth/btusb.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 279fe6c115fa..e8446f3e026e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3645,6 +3645,32 @@ static const struct file_operations force_poll_syn=
c_fops =3D {
>         .llseek         =3D default_llseek,
>  };
>
> +static ssize_t isoc_alt_show(struct device *dev,
> +                            struct device_attribute *attr,
> +                            char *buf)
> +{
> +       struct btusb_data *data =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
> +}
> +
> +static ssize_t isoc_alt_store(struct device *dev,
> +                             struct device_attribute *attr,
> +                             const char *buf, size_t count)
> +{
> +       struct btusb_data *data =3D dev_get_drvdata(dev);
> +       int alt;
> +       int ret;
> +
> +       if (kstrtoint(buf, 10, &alt))
> +               return -EINVAL;
> +
> +       ret =3D btusb_switch_alt_setting(data->hdev, alt);
> +       return ret < 0 ? ret : count;
> +}
> +
> +static DEVICE_ATTR_RW(isoc_alt);
> +
>  static int btusb_probe(struct usb_interface *intf,
>                        const struct usb_device_id *id)
>  {
> @@ -4032,6 +4058,10 @@ static int btusb_probe(struct usb_interface *intf,
>         debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
>                             &force_poll_sync_fops);
>
> +       err =3D device_create_file(&intf->dev, &dev_attr_isoc_alt);
> +       if (err)
> +               goto out_free_dev;

This should probably be behind a check for data->isoc, otherwise it
won't be useful to export into sysfs if there isn't any interface to
begin with or that has been marked as broken (e.g. BTUSB_BROKEN_ISOC).

>         return 0;
>
>  out_free_dev:
> @@ -4052,6 +4082,8 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>                 return;
>
>         hdev =3D data->hdev;
> +       device_remove_file(&intf->dev, &dev_attr_isoc_alt);

Ditto, make it conditional to data->isoc.

>         usb_set_intfdata(data->intf, NULL);
>
>         if (data->isoc)
> --
> 2.47.0.338.g60cca15819-goog
>


--=20
Luiz Augusto von Dentz
