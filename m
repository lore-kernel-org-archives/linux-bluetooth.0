Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793819850;
	b=q9kh/sSHhjst61F0dgjYyEt+fS1RWDbsi+I+gxkdIo4mESDmo6oQUkPHB6rQ4CGd8D31
	 sijiYBBou7bRTslXUAVMB13vOOPPBHwUrD5SQq9N+V9rOJrPmW3qAnRmIaeO5tmH7/afE
	 oKWIvXKStTqm2KG4AaPM+5XDikYOvf+tnkJ8rD8iMrXuhWkct6yyd+Zro9H8Vd2qOgee+
	 Fc8nIHwmD+c45Kz9KSFlnvF1uhXQ23Z8uq1P6qly9c8TiWeHEm5K9m7PRNcyIbwNwfCAz
	 ik2Rs/uMkjBxNTuZuBRbGPB1AemKx97DlLA5SKw1y9dlc/3ND/GGrs3+PsubUdBc5DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=X2FkZOaTFMA6Pn4J0yswUwZWXL0yiL9M7M+FKObeBMI=;
	b=R6PrC3PQmoPk4SjwWBNyoncQArXYxbVRlQQ4MsEyJ3xyh/3Xe1aS25YOkMOP4xqDQui0
	 RmXKdIK7t/BK1zXRHQiU5xVCVsjm6yqSyG0oQ593Qp/a3Bhrt4ZVW2M06/e15KTaZ5mDw
	 YZHf4Fz6FajB35PVBbNahExF+qx9WBy3mZbvl0r6V5YHOCEcxrXbebzvNWk7dQtRZYHc8
	 3RKNvrYxdU2sQE9GZGeeeGszw0rMlvxf9neKkTvTXbctzcP12Xcyr2E/K5H4k1xRWSGaM
	 +7JInNNvYO7af9K2R7O0W58xA4FdX4uSgTTEvRDb/s0FooCopbTDWTgHSZ1g4ZKiAyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DczrfccH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73E60A2620
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 19:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F73E60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DczrfccH
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b306bbff8eso8724257b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 11:17:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793819849; cv=none;
        d=google.com; s=arc-20260327;
        b=AsiTt3gUDOxr2xlSKKsx+FWK5igoNHHOESleFpXbKvcyk7M6V5Qs0R05INxReoTCJE
         ooMw8gGodzjX9c3Fg6xkrdLSZ7z31QihML6J8+Y1tNQZ0e5vA+c4xCad+u11ND+CJ6ho
         YS4pbpCgTG/alBtSDSZAnR6C9JzB+ROxKPMBg4qkyG2l+eahkGuNnWc2uPp5lJjgTL1T
         iQXn7cqyj+tV2Zl0eiU1U7g6/D3FKK87L1xsr8ylbsGyznXmJUCpEo3wbEFUGxHavFRL
         oY2O1oxFKLkaenGwkclseCcR45U6cx+WKx7SneGT2Wc2poUbBRCSc2hovwXYT85SP70L
         zvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2FkZOaTFMA6Pn4J0yswUwZWXL0yiL9M7M+FKObeBMI=;
        fh=x6aCmrIQNmP7dsV6a+bqB7PnT76WM1oaMmPegXey7Ms=;
        b=H4NnismssZyzwFNJyZ0sF7PRVV1SCyQUhJi++Toh1VlKzIBrULg0htqTJN91XSYiuF
         Y6TJlUDiMp+AB8cQb+8hBLVoiFZTiYLjRzPW3rN8Rk/RkTPYV2x1RQeLcEe5m0Exvk5I
         WZtD5e7SgKd567KDlnpGXsTaV16EcU5CIuwnIswm7My0bzL0VtpVg3dVwVcUD3cb3i/J
         zJlpV7Y69xsEJfQslDj8oAuZ5DPLAXAPCYV2t9iDSpxM73zQ5RLLiGO70hJGonPG6gtR
         eOb5BvPMfwxHkzADmDXyXsmzw/VJX6M9/IUcIk+Y+RBTHpnSNiToGEy1lVxA4lrFryEX
         +1hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819849; x=1794424649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2FkZOaTFMA6Pn4J0yswUwZWXL0yiL9M7M+FKObeBMI=;
        b=DczrfccHl1vCyfye/MRZShyO0W7Vf1kRuO/DiQYoaNOH03T3Tz1GxvlATnfwiva9JJ
         1M3f3I4rBWdMsOqaySVcF1FA6RC974QbHcUoLVxb1R09dVZnNQ5NHrdDt+XIoE9XzOGS
         usa4jLpmdkL8BdaovGZDewJ3dtam3tMC0x5SvxGrorazWbpGtCxXN9ulX+pikgTWS4WY
         HONca1YNCn33KM9j66uy0zhvNK1GU/4/FBAI0afGcOnF4v/N0tzJedr/FbOhp45SyIpW
         JMioSuqPHkhBbxRi6EVwS79MHxwxzdaOe3150wKDvfPte+5o7JuDIb96uqYgdbc8Iw9W
         I8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819849; x=1794424649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2FkZOaTFMA6Pn4J0yswUwZWXL0yiL9M7M+FKObeBMI=;
        b=t9EwVWZguGJQBKyg/XMkXMnM0cMAybpiOawfZASzf5JD+adF3Dvz4ZNeUKNnYPBlyw
         Dcp9O0SIiAALpKBSdi3vbJj8xKTHQ1XrLqTaCPm/eY7P0uso7wmLXLZlPUoa9OjKnyo1
         /BMsrn/kIDkJ1RrNNNkpepcOaO9cYO0Hgd4PVkj+ItXCbDCKN9lFT6ZWku5qp8LIz8mC
         BcfNd/jQvkk6qJHVmjQErv/+Kg5ETdAPMiw9AFXSPYf7aPVfGNXWMdVBU18AcKASmx0V
         mevjNF1adthn+9BZXRqro7nRSqyt0+x7f7Ss3zBFE/sZi8ao6upBIpQGcHh/qDjfIcSf
         6fiw==
X-Forwarded-Encrypted: i=1; AKwUvByZ+ulCc5tzzgZ+VapywMzFbtILUQhsKqsTd6KO2tub86gxff5u6XD5QH9Idwu40bFRo3qDGwdCFkPRsap5VcU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HqnC86XdY5RWGJPcPW+D2buqx4Dz31TnGicEySdZ6T2V/HT3w
	Up4wOFFjODN46Oe3vEvhgxBcn9G8uWUIFjPXqOgR09hBwbO+7z8Bcfyey1Oq0k/4BrgChk6aqks
	1sKgs3mZOw/dyN0Rmz/7re40+GXnerLc=
X-Gm-Gg: AYBFou1Pptn7QFEHEsnRYnZAMxKLz0cSHKZOhzJnk8DF3WweB+r4CqfqOxm5m9lxk6d
	5iOlOzP0CrYcnwuroCiHmFNdH299FtOH03O2bU4ZqS1tTBC1Neg9zLW+srCCEHBQtbooICKOWu1
	zLCzfLfpXkzQ7lsxeespnZKDHx/Yho0svzA0wbVJOBbfOWxBYKt73HIZS627PMFxXRy1Q2gpmtd
	W6F/JdxOuFKQ/JfUV8lDk1nuKf5gUPRSfDZr5fsOTKAzc4/vd7hwmaXL6TOrCltICzmo1yn64G8
	zZPm5sV0j9xccEiORD79ldCtq2GcJKr6cJaQzqWLgc8WOtMPcy9bCFatMSiFb0lDf7m4CiQBM5i
	maKFYmucEjWWr17RxABmKbVSDk6PPycfWPyiUfFRfME+ooJJX7m9d2KsASXkxv3jqSv/RpbGYFE
	zlPncnyYEAaEYrRn7amVPlBtdfmbkI00b45wolPWfLpASDuEj1rnboghEPJ11/PpHbAEFQ2ZfMB
	6TM9w==
X-Received: by 2002:a05:690c:ec5:b0:8b3:392:dc1c with SMTP id
 00721157ae682-8b30392e155mr29915517b3.36.1793819848895; Wed, 04 Nov 2026
 11:17:28 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102110440.2589-1-25031212351@stu.xidian.edu.cn>
In-Reply-To: <20261102110440.2589-1-25031212351@stu.xidian.edu.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Nov 2026 14:17:17 -0500
X-Gm-Features: AclHuK8Gh1sKwYgmSHyb8ITOSoc6I6dAtMKDKXBc5cQEbXG-axXVKo592cfZme8
Message-ID: <CABBYNZ+iU=riZ8MSTkbqv4vn0OJGLymtN98uJ8_0pw6hEaVWYQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: fix use-after-free in force_poll_sync
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi YuanZhe,

On Mon, Nov 2, 2026 at 6:04=E2=80=AFAM YuanZhe Liu
<25031212351@stu.xidian.edu.cn> wrote:
>
> The force_poll_sync debugfs file uses the driver's struct btusb_data as
> its private data. The file is created under hdev->debugfs and is removed
> only when the HCI device is released, while btusb_disconnect() frees
> btusb_data unconditionally. The HCI device can outlive the driver data,
> for example when an HCI socket still references it, so reading or
> writing the already opened file then dereferences freed memory:
>
>   BUG: KASAN: slab-use-after-free in force_poll_sync_read+0x129/0x140
>   Read of size 1 at addr ffff88800cfb7038
>   ...
>   Freed by task ...:
>    kfree
>    btusb_disconnect
>
> Remove the debugfs file before the private data is freed.
> debugfs_remove() waits for callers that are already inside the file
> operations, and any later access fails with -EIO instead of reaching the
> driver, so btusb_data can no longer be dereferenced after it is gone.
>
> Fixes: 800fe5ec302e ("Bluetooth: btusb: Add support for queuing during po=
lling interval")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
>  drivers/bluetooth/btusb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dc7191bf4234..d928580512fa 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1066,6 +1066,8 @@ struct btusb_data {
>         int (*disconnect)(struct hci_dev *hdev);
>
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> +
> +       struct dentry *force_poll_sync_dentry;
>  };
>
>  static void btusb_reset(struct hci_dev *hdev)
> @@ -4560,8 +4562,9 @@ static int btusb_probe(struct usb_interface *intf,
>
>         usb_set_intfdata(intf, data);
>
> -       debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
> -                           &force_poll_sync_fops);
> +       data->force_poll_sync_dentry =3D
> +               debugfs_create_file("force_poll_sync", 0644, hdev->debugf=
s,
> +                                   data, &force_poll_sync_fops);
>
>         return 0;
>
> @@ -4602,6 +4605,9 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>         if (!data)
>                 return;
>
> +       debugfs_remove(data->force_poll_sync_dentry);
> +       data->force_poll_sync_dentry =3D NULL;
> +
>         hdev =3D data->hdev;
>         usb_set_intfdata(data->intf, NULL);
>
> --
> 2.34.1

Looks like nedev sashiko has found a problem with these changes:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102113654.8724-1-2=
5031212351%40stu.xidian.edu.cn

--=20
Luiz Augusto von Dentz
