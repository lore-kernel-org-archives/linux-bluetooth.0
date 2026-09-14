Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BD475346
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394763; cv=pass; b=Q/m8OsYOTXbqKufe7+8t1mqiKdLifvOrIIN+ctnRe4ne2lQK6vrV5wlaudjUQzUFQxlTOR9DfVbQ5IzlKxHIVSVXDXgfKqif8PINRoL1rcJQ6d1wCP3ZnBSDC50pjqv4JyW59c8uTatlk1JTfFvG21uS8o1GCCCFTiDAgMxxGns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394763; c=relaxed/simple;
	bh=Hmk0hio/+v9Sq6QCGLY1Vj7O+t7pbTMdbPT8rsUVCRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SC4oSlYBMBZx1sN/Cqp6nx7PsX1GOR0XVZcvbUBeE5zxr3J8XJobUumAlOzbw0u+t/nmWXXSewZZIEQHxPT9QHdt9eoTjBHx/zaca89YtrVxkwqIDGyUS13g/cqdmbNmE1KeuIhhsCSx5vR/NaRigRW+lub77/gR+JUhPytR2nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBN05uFD; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBN05uFD"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67124ad7615so3236011d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 07:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789394757; cv=none;
        d=google.com; s=arc-20260327;
        b=nBpR76Wu/z3uitkl+bTrMsiBqqRggZ52ORiNeVdzkEHQ3mc+iexGq5HcSb7VHbex3t
         Jtee9MEFrfH5tHjyZjgXjVwrOHD4wlc6CCGFFSnpNBOUX/Z6UYf0T/+eWYxVPHk9TnAq
         wC1lO+iKkPExCK4iZ9JREL3LnQzcQ3HvT/QhHdp/Fd7E6awL8MAvyz+tVwkfDWwe51oX
         cB8Dl76jCl35dQKygghrU5Od+m7crwp/RrcukcDzUDYV4X4enzrATs8IhziOEGtCFY4u
         /pzhi2mXU31BkXjL9XFHg255Go9lyiAvdgdZ6fWkaELeuatrUo+XwNIH/giQ7HnUbiw9
         Eftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ptvwdsSJglQVzgKp+FYr9aouOwiPCbztkA+vkBu9aAw=;
        fh=cYNTM5zCH1bt3SKpplINqS9i5wB6Yc9ZEG4Xy1gDHDM=;
        b=hYe2bfXFJn8tmEbjAjO3S0xmSRAQUAIkOSIM6ATrPJ2tF5GJiKAGwfpxyaF9Hf5/Xy
         cPjwtTBEjrC9M+vZv2PbHGF7XrSHPZCdFey+ZRpZFGLeVpsmH/nf4nhUGRcxN64YO9KM
         44Yu3wkBCKFsTACQlbNAPpifF71dwMJ3VjaWCgFigQ8n/wiLOVcmdIFG81brxEga/sEN
         vz5y7BPPbNbo9hd2cqVT8qAyTpbqspaDUmL9FJzrK4hgwAPk9uS5raWFjhuyMsZOc2cl
         4TDpwF/8hd5pCyVxKJbbRaLp4QEwcVfR8phZCpE5uwdyhLm/OrjWACn3kPiZ4Xg31BP6
         sU5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789394757; x=1789999557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ptvwdsSJglQVzgKp+FYr9aouOwiPCbztkA+vkBu9aAw=;
        b=QBN05uFDIn0aCXfDOptPcLLBREyrx1YM8BeLmtx9FnuD6FALkqnRsq4PXGINSdxHjI
         6bTCpo885oWOdoMhKOaTEUTjv1oE8vEkYYUBhwKP1mOBlxguF9ARmNcX4RXMPqlccrlH
         QyLtdLFV8pTtrLaFZ6WOLTrtsR7NBYO2ZRjnaqqruDEuXd1X1SUlBLLeUlF22XQUkqSd
         OUuZ3Wf3mu32Q0Rh1XRf7q17XRAXXOkehD52UZLBaTQKcKkFYLnSTkcFHvntOSadmpWh
         sWpdx9fURPsumyV104BF/Ce1uH+/OJVIdvKZQbrw/RJKBQsTxhbqukJScCBu7ElgRaSh
         xiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394757; x=1789999557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptvwdsSJglQVzgKp+FYr9aouOwiPCbztkA+vkBu9aAw=;
        b=iZhh8S0bXeHvsGnWKbf2HUrkVmLG10OVG4IZjUz+MKoYJ+MriuDYZs89rTNTXP4Xgh
         IagHk1/Wd7+fwjStuxBj6bnApSGnRgSSDNQ0Q7OaUj6plDSEDixU/XmDr/zKcijncqhg
         GMvudAynDvAJs1hxom4CPeKX2SNa6JAPz/WCyS0uwq7tv+5KwmEqpWaDMMZ2Q0AC/zlx
         JiOk+jODbIUVqCXLtFI9J75+WezrX5q7xCAuUy/EN2SBvBIk7EQb3uAdsmYzCvmtnV7m
         gGmSvwv4EqMg1J0W67G616T2G8GtJTsqapoHY8B3lZm17cgSZvbGVGgovRsnKAQkj1iu
         eaAw==
X-Forwarded-Encrypted: i=1; AKwUvBw4sLvEkydBJGSlDeaa7ZJyWXN9eTxHAeuzPw62LmkMjpLOUYAKUjRmycM9GhMVLyDyEsLOBULZLYXT7ZILBic=@vger.kernel.org
X-Gm-Message-State: AFuF++l/FB7JCJcLHRLYgEc3oWZbAqg6mNq6Eo1lJZdnqr+1dpVwvoE0
	5G+QlEUloYIkNm2uCUdQSnXwhBS4g7eReIIv3IYVww2cKM1vz/CmyEk+aG7GFHepCGbdjr0Dv16
	oy3tsJdvYtXBAfEWREN0jqY82pORTV3Q=
X-Gm-Gg: AYBFou0ATtocSx+aVQ9lbF3ND5cmK532zxOQSalBmy2LUNaPE0y2/sdvRqu+QEPjFGf
	PU0avjRUMftJI8U15DCdPD4ZQp9D8HzbqtGaR9jR+/yluAQ8gidlH+Av4bwIu7+G3QmEBIKgN+s
	E4iHI5N+odW4yg6FHNljGAufvR1W7DJPnYrg78M4Vv3LHrLnaGXv8d0apLd73QALa2YnFUNSCzn
	LymcBwA8+/AJc3cXNZAbDLn0qNen8Hu45dBdV2En/FrmKK1nRoHObe4MTT5l+oAZw0CYpW9TUek
	HG7EXETMyyu+DtThMUnJlc5Ew/69bUySM8yABVjAvAxi2dI5tPoZO6DqlaY4ByipQgprZ9Qjhlu
	ZsKisf/Xikt4atKL2l7POC6SbhbZyRtbv0QG0dz9RWQ==
X-Received: by 2002:a05:690e:d8a:b0:671:1880:17ba with SMTP id
 956f58d0204a3-6714e1a228dmr572822d50.90.1789394756676; Mon, 14 Sep 2026
 07:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com> <20260913-misc_fix-v1-2-558c1e4028b9@oss.qualcomm.com>
In-Reply-To: <20260913-misc_fix-v1-2-558c1e4028b9@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Sep 2026 10:05:45 -0400
X-Gm-Features: AcwNN1X4x2Jn_HQuWP1CvY-sUU6PZRXZ8e3BCnElDU8YY8MEUBdC6jcAj5uupHA
Message-ID: <CABBYNZJpwkbFB8E4uHu4AcHjtR8R0CKnhj0Zesf1umoLyiqecQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: coredump: Fix btmon heap-buffer-overflow
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Manish Mandlik <mmandlik@google.com>, 
	Zijun Hu <zijun_hu@icloud.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Sun, Sep 13, 2026 at 11:43=E2=80=AFPM Zijun Hu <zijun.hu@oss.qualcomm.co=
m> wrote:
>
> The collected coredump data can exceed btmon's maximum packet size of
> 1490 bytes, But hci_devcd_dump() forwards the entire coredump data as an
> HCI_DIAG_PKT without checking its size, causing below issue in btmon.
>
> Why ?
>
> For a monitor packet, its payload length @len in header may exceed
> BTSNOOP_MAX_PACKET_SIZE, btmon uses it to access payload in @buf.
> so cause heap-buffer-overflow.
>
> Kernel:
> include/net/bluetooth/hci_mon.h
> struct hci_mon_hdr {
>         __le16  opcode;
>         __le16  index;
>         __le16  len;
> } __packed;
>
> BlueZ:
> src/shared/btsnoop.h
> monitor/control.c
> struct control_data {
>         uint16_t channel;
>         int fd;
>         unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
>         uint16_t offset;
> };
>
> Issue:
> ERROR: AddressSanitizer: heap-buffer-overflow on address 0x51b00000065c a=
t pc 0x7f50b987a029 bp 0x7ffde88dc8d0 sp 0x7ffde88dc088
> READ of size 17916 at 0x51b00000065c thread T0
>     #0 0x7f50b987a028 in write ../../../../src/libsanitizer/sanitizer_com=
mon/sanitizer_common_interceptors.inc:1096
>     #1 0x5b4f3443ae3a in btsnoop_write ../src/shared/btsnoop.c:289
>     #2 0x5b4f3429cbf0 in data_callback ../monitor/control.c:969
>     #3 0x5b4f3444fa9d in mainloop_run ../src/shared/mainloop.c:104
>     #4 0x5b4f34451da6 in mainloop_run_with_signal ../src/shared/mainloop-=
notify.c:196
>     #5 0x5b4f342953fc in main ../monitor/main.c:303
>     #6 0x7f50b8c2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_star=
t_call_main.h:58
>     #7 0x7f50b8c2a28a in __libc_start_main_impl ../csu/libc-start.c:360
>     #8 0x5b4f34295ed4 in _start (/usr/bin/btmon+0x29fed4) (BuildId: b41ca=
afb24db693946c283eaea48112186863d2d)

This probably needs to be fixed in btmon if it attempts to read past
the buffer size. Also, since it now supports vendor packets that may
not be limited by HCI packet size, perhaps we should allocate based on
the channel MTU which probably needs per-vendor configuration to allow
collecting its vendor packets.

> Fix by forwarding the collected dump data as an HCI_DIAG_PKT only when
> its size <=3D 1490.
>
> Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  net/bluetooth/coredump.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> index 71fc8dab4004..61b45ba58a65 100644
> --- a/net/bluetooth/coredump.c
> +++ b/net/bluetooth/coredump.c
> @@ -250,36 +250,43 @@ static void hci_devcd_handle_pkt_pattern(struct hci=
_dev *hdev,
>         }
>
>         pattern =3D skb_pull_data(skb, sizeof(*pattern));
>
>         if (!hci_devcd_memset(hdev, pattern->pattern, pattern->len))
>                 bt_dev_dbg(hdev, "Failed to set pattern");
>  }
>
> +/* Align with BlueZ's BTSNOOP_MAX_PACKET_SIZE. */
> +#define HCI_DEVCD_DIAG_MAX_SIZE (1486 + 4)
> +
>  static void hci_devcd_dump(struct hci_dev *hdev)
>  {
>         struct sk_buff *skb;
>         u32 size;
>
>         bt_dev_dbg(hdev, "state %s", hci_devcd_state_name(hdev->dump.stat=
e));
>
>         size =3D hdev->dump.tail - hdev->dump.head;
>
> -       /* Send a copy to monitor as a diagnostic packet */
> -       skb =3D bt_skb_alloc(size, GFP_ATOMIC);
> -       if (skb) {
> -               skb_put_data(skb, hdev->dump.head, size);
> -               hci_recv_diag(hdev, skb);
> +       if (size <=3D HCI_DEVCD_DIAG_MAX_SIZE) {
> +               /* Send a copy to monitor as a diagnostic packet */
> +               skb =3D bt_skb_alloc(size, GFP_ATOMIC);
> +               if (skb) {
> +                       skb_put_data(skb, hdev->dump.head, size);
> +                       hci_recv_diag(hdev, skb);
> +               }
>         }
>
>         /* Emit a devcoredump with the available data */
>         dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
>  }
>
> +#undef HCI_DEVCD_DIAG_MAX_SIZE
> +
>  static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev,
>                                           struct sk_buff *skb)
>  {
>         u32 dump_size;
>
>         if (hdev->dump.state !=3D HCI_DEVCOREDUMP_ACTIVE) {
>                 DBG_UNEXPECTED_STATE();
>                 return;
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
