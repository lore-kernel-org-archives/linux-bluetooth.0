Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3C13665B;
	Mon,  6 Jan 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736180963; cv=none; b=hzVALPyjltiMt/UuRqT+CyVNaqO9Yzw74o90K7Hrn3LCNy6rbzMmK+whQip9LBGQqV95Eqm3Cjw+wFpF/yyAXWzFkxq0zlhVnhPBSxzph2ZHgho19BeC80LlsB4rPRtS6p/S2uqm/UNoOYSntFEqhIlkb4ExXTF/IwHQ867lpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736180963; c=relaxed/simple;
	bh=OEEWAOJZqUV97MPgoyH1YHcN0G2bQJk0vxQW9n+ueQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFgmMxSOUgwtkFESiN+mtTC4oMCowRXYIivKiJVzd/h6dASL/Rt2uDDT8O51fJrpuqgNdyT/auLkt6OBDxFUWJ9WZs+Ssu+tUjw9IVY+EuXjmb0/BVjMvXYdf9kCZ75IFIsxBSfNOuPyvSbFLDzMIVy6R9T/C4P2Tk0PnpjN4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSFS5GqQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSFS5GqQ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54263b52b5aso4118990e87.1;
        Mon, 06 Jan 2025 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736180959; x=1736785759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGsnUEsCVBxajGYVwChdxqKzDzDFSb30Rf6eXdmmZOU=;
        b=PSFS5GqQMKs0QNA3Xh+645eHlMa0U4Dx9uwQBnkfGKD0zHlBcvO/Byc0uh7IxKTEf+
         WxRGLMVB2q509HFsEjqFq65a0DvLDW/ZXFMnhzR2Ti1rMYtpgOo+BsbdpRBtDvXPeD8a
         5GGNb7MwKBRE6JJu1jFpMgZPWypBcXv3CpoYa1hxu+MCQJDNJtgj8OSS2ysfQ6n/SyYk
         CfKatLFgWzsjTBSKyPTxm0LVnGeqaBGvdhjcA06WkWtfYZaYBlB5nF71qpJP4kP5YTq2
         uXlcndnsZl6R+3c1g/CfS31H18phLZKLN8vHtkpAJsUdfFpmLoBqXk+OUDUEg6/OhIUh
         mWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736180959; x=1736785759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGsnUEsCVBxajGYVwChdxqKzDzDFSb30Rf6eXdmmZOU=;
        b=P91wXT4WZE51F708U7riNgXn5o+M2/NUo35wHDhugysImsLDy9ZhOIs5rYR4wT+dfH
         pkFGAZdEV8wVBF37VoAtIHSYoA0JHr31Bp+zZTKh/dZC1sG9c8dqVBM44UmlNdjDDTBi
         lFIGBTufsD0nk7T1vCKTvwb8JNk6Qylj0QVM9W+Y2yu/bXTI56oEEe5GYwSAiYX3Q4DG
         a3BaR2EJOIbRELMwfZCOBKeeYU4aD7XMURnGhRORhNV1heBeAWGO6AYMWP/mYQt/+G2q
         yVRLLv8gGEoVwAPJPn2tPUSZA4/cq5ZY9KwNfQEmUyxiFTUEubuJseVqZLCjaAGz/6FT
         Ahrw==
X-Forwarded-Encrypted: i=1; AJvYcCUs8vtSNyTpBrthTaeQ0m8bGM3Y9rdjD1C2GlgwQ6nOFcK7KeK7h4Iaq8CoU8qgAW/tdOR36LyU6K9c/oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCqpDPh+VwYMymOQlXPLhbF1dVYgkXJMK17LsDFJnosELT6UI
	hT9zgCOPmz87VVYNe6OiasJ4Zk/5j08u6TcHSKLJw/F1CHISq/8sFcTbW6GaYNJrPJNJPJJ9vft
	JaoTshNOEUQgiL/gOc/NJcF6V7Zw=
X-Gm-Gg: ASbGncvQUO7afg1XNMIQhCB6hqyLXve76cLFAkyabot2yTI4Gsa7dLFB6seb4a5UQYb
	fNxhK87EpBF0wHw6Mqu1IFZtQ8OvhGEi/nM0f
X-Google-Smtp-Source: AGHT+IH6J6MwPziZw8o6LICTXHRcm4Ur3xAwuiOa6ZgXKyOF3YYPQ3/IusrRvKlv21DvsMRuS2QgAAcJKNDpcSmjT3Y=
X-Received: by 2002:a05:6512:334f:b0:542:2990:722e with SMTP id
 2adb3069b0e04-54229907232mr14673644e87.15.1736180959216; Mon, 06 Jan 2025
 08:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
In-Reply-To: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jan 2025 11:29:06 -0500
Message-ID: <CABBYNZKDRm7vf1RewwW-+0fBwHTS0RXKqxNME_HpyB-q-mNLYQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Allow reset via sysfs
To: Hsin-chen Chuang <chharry@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Thu, Jan 2, 2025 at 10:21=E2=80=AFPM Hsin-chen Chuang <chharry@chromium.=
org> wrote:
>
> Allow sysfs to trigger reset via the cmd_timeout function in hci device.
> This is required to recover devices that are not responsive from
> userspace.

Don't we have a similar control over USB to reset the device? I think
that would be better than introducing something btusb specific.

> Also remove the cmd timeout count in btusb since we only ever allow one
> command in flight at a time. We should always reset after a single
> command times out.
>
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
> This commit has been tested on a Chromebook by running
> `echo 1 > /sys/class/bluetooth/hci0/reset`
>
>  drivers/bluetooth/btusb.c | 10 ----------
>  net/bluetooth/hci_sysfs.c | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 279fe6c115fac..a4810c77fa0da 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -879,7 +879,6 @@ struct btusb_data {
>         int (*disconnect)(struct hci_dev *hdev);
>
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> -       unsigned cmd_timeout_cnt;
>
>         struct qca_dump_info qca_dump;
>  };
> @@ -912,9 +911,6 @@ static void btusb_intel_cmd_timeout(struct hci_dev *h=
dev)
>         struct gpio_desc *reset_gpio =3D data->reset_gpio;
>         struct btintel_data *intel_data =3D hci_get_priv(hdev);
>
> -       if (++data->cmd_timeout_cnt < 5)
> -               return;
> -
>         if (intel_data->acpi_reset_method) {
>                 if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_data-=
>flags)) {
>                         bt_dev_err(hdev, "acpi: last reset failed ? Not r=
esetting again");
> @@ -997,9 +993,6 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hde=
v)
>
>         btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
>
> -       if (++data->cmd_timeout_cnt < 5)
> -               return;
> -
>         if (!reset_gpio) {
>                 btusb_reset(hdev);
>                 return;
> @@ -1044,9 +1037,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *h=
dev)
>                 return;
>         }
>
> -       if (++data->cmd_timeout_cnt < 5)
> -               return;
> -
>         if (reset_gpio) {
>                 bt_dev_err(hdev, "Reset qca device via bt_en gpio");
>
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 4b54dbbf0729a..7bf2b10b0a7cf 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -90,9 +90,28 @@ static void bt_host_release(struct device *dev)
>         module_put(THIS_MODULE);
>  }
>
> +static ssize_t reset_store(struct device *dev, struct device_attribute *=
attr,
> +                          const char *buf, size_t count)
> +{
> +       struct hci_dev *hdev =3D to_hci_dev(dev);
> +
> +       if (hdev->cmd_timeout)
> +               hdev->cmd_timeout(hdev);
> +
> +       return count;
> +}
> +static DEVICE_ATTR_WO(reset);
> +
> +static struct attribute *bt_host_attrs[] =3D {
> +       &dev_attr_reset.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(bt_host);
> +
>  static const struct device_type bt_host =3D {
>         .name    =3D "host",
>         .release =3D bt_host_release,
> +       .groups =3D bt_host_groups,
>  };
>
>  void hci_init_sysfs(struct hci_dev *hdev)
> --
> 2.47.1.613.gc27f4b7a9f-goog
>


--=20
Luiz Augusto von Dentz
