Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F9392C25
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437891; cv=pass; b=ftCzKWpVlDmJcH8dCdfIeoMbSWEq5TTwgoMZqRPbf6GiRYZY7EFW+cTUT7aAP9Z0278/iGyTHPQEGLOl98zSCy6k7Gsyj76uHQ7GDRBeDjOVQRh2JK9nmpRObXWg+TXEW6TONrl0U6balSX/GxX1ajN5aw2eGXnShn541ocVsPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437891; c=relaxed/simple;
	bh=0njRmYSn4poVC/mArPlC/fR3QLIUbG65yqc9jFtPFNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsW2jrtkoMj/J0vZyrc74oang+lR5RQB6cfju8iyha1mNmKmhd1NOEX7ULwzgG95kxOLFjwYzHgS+fgcfQzrwlFJnZ61FSVTqfcuXve/GP1rt/UpGy684aSXHyr0aZjhonn9ARTyMyeoRX+bnSdiyv3FDupDWW62Dgvku11kKAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu8XhiBE; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu8XhiBE"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6651bc57458so2824725d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 08:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783437889; cv=none;
        d=google.com; s=arc-20260327;
        b=FdXroioUwmIXTC4BfnuFmbhNhUcfegZkG/y87D5S1SGH3BAJGrUum8xiwAT7XJhSTh
         /bxHWxM1+eDoPQNmV5lahf0rXK3g9GuSzM2dyJKp+mDvaXXmAikv1xrJA+G/aTaj1R6r
         zVdeTVe3iDjb7y0qs9e1EXxejxsTCSNL3MaHGAoh9aPiY/YU8ZxDu+6HKksZgKSmFwP3
         nY+RdvO7MdE7/5PZ2cVSomrlZktQ0NfTFFh5U4sqBrxAtnKzFjF9oTt3KULhnMlk+CjC
         MqzUd15GyZieiKpwix06Y4L6haE7zl7+BFDorrABfRhUOpgYqrcJ2dKtrI50JPmHDDgx
         jydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zr16SPndHGc73+Bu8u8Xgo96h3SOtHbZhzKK4VPFL3g=;
        fh=lws5iHjulVLgvh9ohQEtbaPsL/WD+WhZ4o381VGA54s=;
        b=ewMbPfYBdy8dnbnQfHkOC7tbjKBf1Prjdp52MfmTD34pBTy01LEa9p//hwL+xb0esq
         cmxHn36xuaK5KdkQplOHtST54/muZcjHY/8mVU35DOIPUZJR2Qc92bNtDlKaF2hnmEDW
         upHis3Whx02cMYkvb4qa80oePBpGi2iuArhgdBrWRAtULXMIpHPIHhaSKd+tiBZ3palI
         XC6SMxcc01lJUwj4H7W4TRKvA9a2jXLL3TMwCFUJVoizgdqAuSWmhNStY7DThcODpMDo
         Z7dzrkc4gpi6WE62m3SVLegLo1Hv9kpBX3wQXoUleu5J7r+s2vJArc9ebojhFRBbdjeI
         1ewg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437889; x=1784042689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zr16SPndHGc73+Bu8u8Xgo96h3SOtHbZhzKK4VPFL3g=;
        b=iu8XhiBEHwIpt3lm28pfx4LFgtKE82qpxPVMQFxNCBdpDv75PTXzZa9n9MLYClkumA
         18bdXjSdBXph65dpqhtYMDgvQQD4QxRnW+THcq+oLbW83KrESPoqGthn50EZFVuqTPEy
         UfdLpLGVMw4j7VGmCYBiHmc6+PlGwy2erp6GBVJ3AzWsYdOFzzP/3NFqIwJBLyDL0XuT
         59wqko9P1jX5RnZsE5kO+p5Z5uUh79v0xHjkTGEI7bTPHRbx8lkJI4wdefrngInTJEUw
         xXXKc0pEK4sX0KIvrM3wDqBhIh9kA8hSbjyyJujSxnGkRmGVzc/g3LyicHEa3zQROr98
         7j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437889; x=1784042689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zr16SPndHGc73+Bu8u8Xgo96h3SOtHbZhzKK4VPFL3g=;
        b=Pzu3wtEQh5OBZQvG9mp2WbAEJInjuYpWUSDVASTbJXRw4GhGnlKgewq9bYGFPD8Wxx
         75VpGOdsw9tpNmcMI1hwXIX6VjWdG/mnSCl+Vy42XPTNEWQ6cWPaxWhFMuCj+dI6rFt/
         sH8kPq9KpWU7euPn9WNQE6gL4Ou1ELMer/9Doo9IYED1MC+VvLxvdplnSvBBHwbM995T
         hpQZvldzV4JAEvHFJVSOrNzfbzks5lWyTo1ayHtlsrbQQGAE8grQZTFAjGRuX+R1/nlm
         zh3Y1UyEJpvXXYeNgyipGp28VXNvF4WBgZxXjN4C/YeM5GioLiLQmkyN4MLjcsBbGx+f
         cGQA==
X-Forwarded-Encrypted: i=1; AHgh+Rqwm3YBLrrg/APHinTAeSr8BIgrV7ednPKn1dwyynwQfkdZMR69J+VCfRggImIPoYn8WRL5NH7ipZZIbuU46Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIiy8h7FGHo+cqBJQZcupxDJDq9tTFfaLU5zlkbDbHkoygsCs
	2JooAREQw9ABTNnI0vzqTAot9lvcD970AtEYR9RnUcyBAjuj/bXuT+z/uyT4To/31ng0HtTyPPr
	agmk9mFTh8RuQjP8Dxg4/M+WjZJoeTk8=
X-Gm-Gg: AfdE7ckBsmiOJesjgCqEfRY/SwFeWNDOcY7KBN/3TXcyU2BnukKaK08PHXsBwX0xW8e
	5hsPWxbkCayczUv3Pw+0Cgadxlc7rF7XtySxw+SMNiWI/djTrlBWo43kycRGuZX0VcW0eGqbNgD
	FE9ukZtj+8nMcn9xft7VuRh47NTQ1DTvHZLWGHhdfgi50mbWTzAOLQ7fhOEF9EsHa+f5dL472IB
	eiUlxkBnpE6uxwws1s5oBv+hZ+UG2PQgQbY1ij8BKuwKTlB9/I/gACv98dZzAYUNovlst3uAdQl
	coToXYn2UIDL7f20kJax8ZB0zwVvsuAA45tZ77CPPC52pmZoA7r53LeRkiA=
X-Received: by 2002:a05:690e:43cf:b0:664:ae6a:ef0 with SMTP id
 956f58d0204a3-6677fde0a83mr2583709d50.78.1783437888639; Tue, 07 Jul 2026
 08:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707072955.3093138-1-haoxiang_li2024@163.com>
In-Reply-To: <20260707072955.3093138-1-haoxiang_li2024@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Jul 2026 11:24:37 -0400
X-Gm-Features: AVVi8CdZEiVUSZgzA4k-tWFUHnxIdsPOK0Oc2mjU0zfxCwAA-C_N3ia-In58D3Y
Message-ID: <CABBYNZ+Bjs2U-gsWFisYG7vHKE2JCFDJmRyBvcGM1c7fC=4BiQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: virtio: Fix HCI device unregister on probe failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, mst@redhat.com, error27@gmail.com, 
	yangyingliang@huawei.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haoxiang,

On Tue, Jul 7, 2026 at 3:30=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.com=
> wrote:
>
> virtbt_probe() registers the HCI device before opening the virtio
> Bluetooth device. If virtbt_open_vdev() fails, the error path frees
> the HCI device without unregistering it first.
>
> The probe error paths also leak the virtio_bluetooth structure after it
> has been allocated.
>
> Rework the probe error handling into an unwind ladder so each failure
> path releases the resources acquired earlier. Also close the virtio
> device before unregistering the HCI device in virtbt_remove(), matching
> the cleanup order used by the probe failure path.
>
> Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver"=
)
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Rework virtbt_probe() error paths into an unwind ladder.
>  - Free vbt on probe failures.
>  - Reset the virtio device and unregister the HCI device before freeing i=
t
>    when virtbt_open_vdev() fails.
>  - Close the virtio device before unregistering the HCI device in remove(=
).
>
>    Thanks Dan for the suggestions. The blog is very helpful.
> Changes in v3:
>  - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.
> ---
>  drivers/bluetooth/virtio_bt.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.=
c
> index 140ab55c9fc5..c063c2391c5c 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>
>         err =3D virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info,=
 NULL);
>         if (err)
> -               return err;
> +               goto err_free_vbt;
>
>         hdev =3D hci_alloc_dev();
>         if (!hdev) {
>                 err =3D -ENOMEM;
> -               goto failed;
> +               goto err_del_vqs;
>         }
>
>         vbt->hdev =3D hdev;
> @@ -383,23 +383,27 @@ static int virtbt_probe(struct virtio_device *vdev)
>         if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
>                 hci_set_aosp_capable(hdev);
>
> -       if (hci_register_dev(hdev) < 0) {
> -               hci_free_dev(hdev);
> +       err =3D hci_register_dev(hdev);
> +       if (err < 0) {
>                 err =3D -EBUSY;
> -               goto failed;
> +               goto err_free_hdev;
>         }
>
>         virtio_device_ready(vdev);
>         err =3D virtbt_open_vdev(vbt);
>         if (err)
> -               goto open_failed;
> +               goto err_unregister_hdev;
>
>         return 0;
>
> -open_failed:
> +err_unregister_hdev:
> +       hci_unregister_dev(hdev);
> +err_free_hdev:
>         hci_free_dev(hdev);
> -failed:
> +err_del_vqs:
>         vdev->config->del_vqs(vdev);
> +err_free_vbt:
> +       kfree(vbt);

Sashiko flagged a new problem regarding the code above:

https://sashiko.dev/#/patchset/20260707072955.3093138-1-haoxiang_li2024%401=
63.com

>         return err;
>  }
>
> @@ -408,10 +412,10 @@ static void virtbt_remove(struct virtio_device *vde=
v)
>         struct virtio_bluetooth *vbt =3D vdev->priv;
>         struct hci_dev *hdev =3D vbt->hdev;
>
> -       hci_unregister_dev(hdev);
>         virtio_reset_device(vdev);
>         virtbt_close_vdev(vbt);
>
> +       hci_unregister_dev(hdev);
>         hci_free_dev(hdev);
>         vbt->hdev =3D NULL;
>
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
