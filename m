Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55C3D3008
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735002; cv=pass; b=LCpK6yv99io8Erm1MsPcWgqUfBr045hi+eTKS+nDNd7U67UZCJJxM+cIhukCUJEAQIOnhaXHJiDE6e9CMoRjsvaSgkOVAhVhWTLXUcFxIeZSB+6/nl0Haa9Gcy2gnO/HQwiOYlXibLKJJfUdIYN849nilDeu3P6lI2pWj8Ro96k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735002; c=relaxed/simple;
	bh=WbD3zgKqSP/0H/SbXYuLbh4PSBjslfEzkOc5QFzydM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDpZu+g6CgMPdDFVy7AhkVityg6PnAb0cBxm5XGMi3180hk4y0E9sfeFe9Qa7JtX6/0PK3ZvJCfePlDkCqbLYfjsrdwZit291EwYfNa6Fp5NFKi/YWjhPlKv3U6h0Zzy8t3xoFdl/pq5CB+zRJ86WAzKlToiiLSf26VrF9YFeSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b98BZCll; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b98BZCll"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81dfdbd86d1so85657477b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 08:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784734999; cv=none;
        d=google.com; s=arc-20260327;
        b=eqtLmKm34vjeLeNTMerU3mIG/i+U8avHX11qA4KwYKdVF105P4FxgzYM9zS12T+7O2
         +fw+YIB321/60Lm/4bMa0DPUtWW99pvctMEWxPfPqV80hMTqc8DXHP3H9woD8MSjWDBZ
         yVTKs120i8rMOdGKBkFP9KfhuqEl4xL7/zmiZEprexjxGim1PMpkN1Rq9n41R78GgEdX
         AcZyqVQILlZOzdFuyAV5L9a5RMNCsTNk3PRQcZRdl1p/Cff1GEWv2VTLTZzOe7Bw5plK
         GOGAapDR/k+ymg/MzWvU+/TKPxvnB+9aDUTv356ziRgHetv5hoavoYB+dhUYyrF7mFYn
         Btgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rH709ktQPKWxykyMvDVRbOqRBGHAPKjmUXb900ZrZWM=;
        fh=C+sH73R/8D8MBd3pdChzhvbDRzZBcckYuBXvIg8EdNE=;
        b=I5ircqk2aB9zwI5GYV408bC/qJZKUKzQ2CSlIjD1cL98JYcqJrXPobcEkMgkNF3paQ
         oQKpZFbPmKEFawvrhBxN7zvESciJuE9fn9X5yQECAqWKCEFNe6NcSv0fk0jAwZ08AhVQ
         CMprrUHz6j2MG3nhbLFfyXm3xAPZzIrtfe6HIksSGYkRDeVUWm5B1fycB6ingtngv0st
         mecsGV8TqexnBfzmAc76uDxGUwb55bkV9B1OW5E6e/5hTRbWh2CvLk0g15OvXCT4lcEc
         Ntd+Ec79zX3iKoh16BGSgS1PEWql4pkwGBBMcK/QlrHrcSTK6iv8Am4xmfybDRzcfofY
         MuiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734999; x=1785339799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rH709ktQPKWxykyMvDVRbOqRBGHAPKjmUXb900ZrZWM=;
        b=b98BZCllK0SHT0vC+djK9dIz7FTDupi0PzuchuVPXVxjAUCqjQ6tYkgLIJaKlvRNJK
         fkSqZz3wOHR3E3pUcKf9nzrV6WTeJm7EDnTNJdSy/cq8xJznO3+bcd2O2jHjD7k0tV3N
         JnH48QqQpWaOAId44NXQLVyw2sN+VEVHXT/KFfOSH1n3hTc9HxtbQIrLQM+jbR060y/c
         c5ygkgQr/KxNQrHp4DpkApyOr5mEZpLMJMrTgoXFmZaGJHtFXtzzeeOfpT+3K4nZ9qxv
         1aJCSgBpfMwLqKsKO4asd7V5qJFEGyyorZ3yJpIOGiZNB4sGhbnKHr31eC7WgyofZhRG
         /fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734999; x=1785339799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rH709ktQPKWxykyMvDVRbOqRBGHAPKjmUXb900ZrZWM=;
        b=DbHTIG+6S0qwTjg95D3bScxUEesiSqBExhUxPfxFygpfosQHJao9AhQ5E1VQFSb6yU
         cchfdKvWPPy2qnOmbcPMxatICxPM7mfOorlVntk+gqxBgiBoeWALAqRtGZUht9RyuYoj
         9tXEHyf1sOmRc+c+ZYGP+dNrUc7OGa2zLNEAb1ecI2roYFtfTHxE1Xx4AgimrTcYOHnD
         xWTl2saigSQRn/R8lnybNJqmARtPWrDP42GB1jKU+27YkWDc8t62ckWFjovdSQhrHIWa
         N69+I2PlTi6yEm5Zdh8GpIKNvH3kDBARa0jU/GJqF+BwEEGoaAjkTTbKjwXckvFVe5vd
         kczw==
X-Gm-Message-State: AOJu0YySw5T6BQegLVv/MB1R+3NwhYxXbbiCs+xdCY9GotyzvuBnQPBk
	yo1hC/Gro52Rf2ysvYR9riGD+ntznYZ5xMAER71JsCMxg0HyCm7SbDlFAGhd+ChZLPs6wKKD6jY
	uqJj7vYjYNLrmC6I6udzoIyNcmAb7z1o=
X-Gm-Gg: AR+sD10u7saCTq3u8YY0wYT44bfOrly6Er8RssMkG2VA8XCkdHeNrfrd2xkLdA5rsv1
	/WfWHq5HwXRbB4Gwn3gYEItFDrUx7JJyRgLvZrbeTsoke0EUC7H9ooLTJdFKDD1fkxVn1GEh5UZ
	2CusMPVM39kS3VJWsr0mkBPnqDk8hifvwSd0PvGtuKkijMiM+a+6KJFUNBkd28ETfqnVfxMsD+G
	reWXon0ZUgeyPee2ql75KPlR2Ygg1cz1ofcSxHpeV1ssEFF2uKlmbT94v0LO9NOSWSwMQjWhWt9
	yIPYX29KOAlfVl8sOK4gSv69Cs9OfcDtpCUFQG1Al6/rm4aluWRZNEW3SKs=
X-Received: by 2002:a05:690c:9c09:b0:810:c988:1d36 with SMTP id
 00721157ae682-81ef2603ab1mr73574087b3.54.1784734999420; Wed, 22 Jul 2026
 08:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com> <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Jul 2026 11:43:08 -0400
X-Gm-Features: AUfX_mzrryXQu-X5IXXuDXLfI-DiKp090IDHfy23y_YIgUU8XDPjjL4hjV2Xy5s
Message-ID: <CABBYNZJ6NM55ykYVrMxx-HLZOPC53bZrBzXWhjQnZ7gKSEwNWw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for PLDR
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, bhelgaas@google.com, 
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com, 
	kiran.k@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandru,

On Tue, Jul 21, 2026 at 9:22=E2=80=AFPM Chandrashekar Devegowda
<chandrashekar.devegowda@intel.com> wrote:
>
> Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_rst
> to allow userspace to trigger PLDR (Product Level Device Reset).
> Reading the attribute displays supported reset types. Writing
> integer 0 triggers PLDR. Any other input is rejected with
> -EINVAL and a warning log.
>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com=
>
> ---
> Changes in v4:
>   - Rebased on latest bluetooth-next (6f55ad8fb0ac) to fix
>     CI apply failure
>
> Changes in v3:
>   - Dropped reset_type parameter approach from hdev->reset()
>   - Directly call btintel_pcie_request_reset() instead of manual
>     flag manipulation and schedule_work()
>   - Accept only integer 0 for PLDR trigger
>   - Handle schedule_work() failure: release pci_dev_get refcount
>     and clear RECOVERY_IN_PROGRESS flag
>   - Fix remove ordering: device_remove_file before disable_work_sync
>
> Changes in v2:
>   - Added reset_type parameter to hdev->reset() callback (1/2)
>   - vendor_rst sysfs used reset_type to select PLDR (2/2)
>
> Changes in v1:
>   - Initial vendor_rst PCI sysfs implementation
>  drivers/bluetooth/btintel_pcie.c | 42 +++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 2e28847263ab..a412ca7ff3ad 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2781,7 +2781,10 @@ static void btintel_pcie_request_reset(struct btin=
tel_pcie_data *data,
>         data->reset_type =3D type;
>
>         pci_dev_get(data->pdev);
> -       schedule_work(&data->reset_work);
> +       if (!schedule_work(&data->reset_work)) {
> +               pci_dev_put(data->pdev);
> +               clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags=
);
> +       }
>  }
>
>  static void btintel_pcie_hci_reset(struct hci_dev *hdev)
> @@ -2791,6 +2794,36 @@ static void btintel_pcie_hci_reset(struct hci_dev =
*hdev)
>         btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
>  }
>
> +static ssize_t vendor_rst_store(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       unsigned int val;
> +       struct pci_dev *pdev =3D to_pci_dev(dev);
> +       struct btintel_pcie_data *data =3D pci_get_drvdata(pdev);
> +
> +       if (!data || !data->hdev)
> +               return -ENODEV;
> +
> +       if (kstrtouint(buf, 10, &val) || val !=3D 0) {
> +               bt_dev_warn(data->hdev, "PLDR rejected: invalid input");
> +               return -EINVAL;
> +       }
> +
> +       bt_dev_info(data->hdev, "PLDR triggered via sysfs");
> +       btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR);
> +
> +       return count;
> +}
> +
> +static ssize_t vendor_rst_show(struct device *dev,
> +                              struct device_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "0 - PLDR\n");
> +}

Ok, so I assume this will be btintel_pcie only right? Not
Bluetooth-wide? In that case you can call it pldr directly since it no
longer need to generic and only applies to btintel_pcie driver.

> +static DEVICE_ATTR_RW(vendor_rst);
> +
>  static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
>  {
>         struct btintel_pcie_dev_recovery *rec;
> @@ -3010,6 +3043,11 @@ static int btintel_pcie_probe(struct pci_dev *pdev=
,
>         if (err)
>                 goto exit_error;
>
> +       err =3D device_create_file(&pdev->dev, &dev_attr_vendor_rst);
> +       if (err)
> +               bt_dev_warn(data->hdev, "Failed to create vendor_rst sysf=
s (%d)",
> +                           err);
> +
>         bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
>                    data->cnvr);
>         return 0;
> @@ -3046,6 +3084,8 @@ static void btintel_pcie_remove(struct pci_dev *pde=
v)
>         disable_work_sync(&data->hwexp_work);
>         disable_work_sync(&data->fwtrigger_work);
>
> +       device_remove_file(&pdev->dev, &dev_attr_vendor_rst);
> +
>         /* Cancel pending reset work. Skip only when remove() is called f=
rom
>          * within the reset work itself (PLDR device_reprobe path) to avo=
id
>          * deadlock. current_work() returns the work_struct of the caller=
 if
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
