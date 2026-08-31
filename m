Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E240472777
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191689; cv=pass; b=Sb+3m82+3SsoinTb9yws/hABfYwlvlGJBUYUs/UwJn8OcEWDzawG8RMeXuZav37XLdMoXIaxxrYAzV1TZjF6UWPTddSbBFXw6RYFR5BdoMuynLV00BDU7lH3KtPGKtm4yrenUJzJ/q+zfxn3j0HcECCzop9G82b/d3ZE/YaoN6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191689; c=relaxed/simple;
	bh=3SDMEhLYxp7ih+dvT+KJpzTrFiW8XqxGuotRpW7/BM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU8gDoaBWYw2TWTcXwzbcaf1oWwT4QpF5iU5pYj4AgcoVhyNfz9JRmEhK/0eaFgZGulCWtpC+OyGJFshQeOSQZcLqotkeogTJwClLe558XA2iQddCk12ItTYamyrtDhJakQr9a1nKBct2bXXR36a6HDwAjdiYw0IicCRFF6cKAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBast05/; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBast05/"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66e3d262d43so1268255d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 08:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788191686; cv=none;
        d=google.com; s=arc-20260327;
        b=QysiKEXTXZlPRGHYYYPEc+vmuPzCHERImOa5WThpL8uA3HeKtTGs29SeyuTcTEqCWF
         L67ycw+h2370vab3GWGmzuNVaJksAknpVxmdPcCT+WNK+Tj8qoJ1JQkeBxrVsFLtHmqT
         gFNZJUohsQIfwrnGXT5/2xFi1tzZJRrC/XsRm45V8avEYrS6mCNY0T11jXFS25W9fLOT
         ZbIz2AZC/ejwFfeY+HUT0gSK2exjT8pGyUOBfFFiU1UZUfq1ETkaCbiiM5xrS6efFu5c
         rjgbO/tjTb9IWzxDamictW4k8gWRxAvC5+HUX586MGklJBt6qhLaX9lIs5TCLXNJaW+8
         kCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hMpxnGTN8AP4g+iJOlRKmLXSYbQMVz9R9hLcCB9PEjs=;
        fh=0Tquiw4b0DrcAUgFLU5v3YjKccR5lWnOLB9ljYi4ApY=;
        b=PxH6AWSVNL83QCdtAXTAGOKOT7e4WWoTpnu8ayigm/HuwYlg8NjjjPIlad/x1PM0Qk
         UaECn7t0cIZ3f/MfayQEaOhnWvekULbMFb10BVx4TJjobwkjUTHW7Dugxwfm+tX0Z3lL
         5R3OyJk6SWhs29/+pghATP32e12SGD2e7sPJD3uuqL5y80aDTcxqb6eroU1BXp1dAPby
         A/6KpB2bm64qMb6g1rP6optoniTTnWrLDnZ0c8pISB/K3Jbuo2BAWBCsEAoVPS8twky1
         3McrCSqvcE98lU+Ajw6MN2xSJYGo2tbnrrf8XHTgHVom2xfgayNrrykUeofKSc/yzUZE
         gbXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191686; x=1788796486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hMpxnGTN8AP4g+iJOlRKmLXSYbQMVz9R9hLcCB9PEjs=;
        b=CBast05/PD7gQ/qscK45fQIG+dLHpeTJwZce/dsQz/zxyNDINTprCOnfPBzn95dcOe
         t6HnZ1Dqa3X1gqyHAO2Jb4FsZDRFAeYwq/nKZZ3MRPgNtBalMYl1iC1hQftsUQOxXG4s
         1+F42YVuBybhNySgDPwnnGVJkEF4//EZNM1u9crH5b3Dd+OMOVU/BsgQN43IDw+aP/eh
         k2KgAHVsNUBaeXSJHtB7I80GBRa/vptlsJuKh9/2S2QT1qPcnx2R+77kyxnG0a0+sSzG
         0ryJLYs7KoxIv9w05f3ZYXAEhc1plzRXK4Yys0NkvwSBZO4TC/H53p2v5iGd9rUywx3T
         lZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191686; x=1788796486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMpxnGTN8AP4g+iJOlRKmLXSYbQMVz9R9hLcCB9PEjs=;
        b=bR3+roF+Snvm4/L8p7oS9cNjoB4FeTfkuFJ2xa7+L80FDZkMmfZVLqcys7+WLqnMCt
         KPHwSwJAr1GTWnbbV4dQ4Pn6fQveoKKoNlw9UGfv6dFK0Yp2nhw1CTwVaJLjTV5FMFfx
         a5IK88Nb66fy95/+AoXe9QKWN2R9aX7kFMJ0har6LN6avyWT5HJBtnX029DH574m8pFv
         gNMt7oXHL1gQRRFw+JDshIHBzBLfx0RiKYElIVToFO8+wUsh6SF99+q8JMQFy1JUo9GZ
         mxzhDWjvbTnPE7lgNAb9Gg5m1jSMfX06+bnyXAyu6f+74rc1+/gB7ua7+lHzUZnXknN2
         dFJg==
X-Forwarded-Encrypted: i=1; AKwUvBx1wLdEc55neqZAUhf104+nJRP5bfhzSPKR65AGdqVE5kOwPp5Fx762kRLHyQ1b8QMucpqY+3cTVBTRkHsNgb4=@vger.kernel.org
X-Gm-Message-State: AFuF++nfmArtxrOzMXEVfH0cQf4cv9RGdweohizcyTsZLLRoEoBWqwdp
	bip1Lac1e2UR2Zt847VaO4gBBkZKL0LDYV35J7SNp3EFzwSnbJcdB3egLiwxz7eVabU/p2DlL+1
	6ekjg7/APGgBgOeW5Qigqq1iU/dnAowyYGh/VRVPkFDTl
X-Gm-Gg: AYBFou0bjsUPtNeLCW/qVpmH3aOASIgtTPVRvurzknmmfl2bHjJ1uk/Ns4XZ6XoHvjD
	oiwwplGwL2LWSyYWx18iIhOp435J0NrH1NwslLXiuk2SwtwXOQr5iyvfCSh6bZHm8CuWHrSx3Y6
	njzRffDKwo3f9Pshsa/1xdALMDNM6R6ypIDwiAuYNJ1XIeGauW/vMb//qDc7GvXM1xfD303lQcb
	4p9WzPEZSrDoy3FYc/tt7x1i9V/4zAnWVjuVKdMQ9ZKm8vj8TiXaPhA+oB89Nyl4trf+PX94ekY
	v3QcM+oFYbGcL/dFIMpxfToB1+t3E7fvw3jTiOrea/Fg/1ZdYb5ZvLo+LHz6zR8rapfTWwFYWsX
	pj+bt92PKMZewn5C2qMwngdJ5gjNNqu0=
X-Received: by 2002:a05:690e:12c4:b0:66e:6486:e809 with SMTP id
 956f58d0204a3-66f87597547mr601609d50.30.1788191686274; Mon, 31 Aug 2026
 08:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831084329.3141802-1-zhangchen200426@163.com>
In-Reply-To: <20260831084329.3141802-1-zhangchen200426@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Aug 2026 11:54:35 -0400
X-Gm-Features: AcwNN1XeBVP39gHSIcb0vLLLNd-B90RXoCLcUpRLBG9SuIp7sgDR5GC5oPv-kfw
Message-ID: <CABBYNZKH6c7oxcvrTomzL84dy6sMXXNRb6MoHPZr_oKG-bO_5Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Reject controller operations while powering down
To: zhangchen200426@163.com
Cc: luiz.von.dentz@intel.com, pav@iki.fi, linux-bluetooth@vger.kernel.org, 
	Chen Zhang <zhangchen01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 31, 2026 at 4:57=E2=80=AFAM <zhangchen200426@163.com> wrote:
>
> From: Chen Zhang <zhangchen01@kylinos.cn>
>
> When an adapter is powered off with devices still connected (e.g. a
> Bluetooth keyboard or mouse), the shutdown sequence issues an HCI reset
> which returns Command Complete while the controller firmware is still
> rebooting. A concurrent command sent through a raw socket during this
> window (e.g. periodic hciconfig queries triggered by the Bluetooth
> status change) can leave the firmware in a stuck state where it stops
> answering any HCI command. The subsequent power on then fails with
> 'Bluetooth: hci0: Opcode 0x0c03 failed: -110' and the adapter is lost
> until reboot or re-enumeration.
>
> Reject controller operations while HCI_POWERING_DOWN is set at the
> public entry points in hci_core.c, which covers the ioctl (HCIDEVUP,
> HCIDEVDOWN, HCIDEVRESET) and raw socket bind paths:
> - hci_dev_open(): return -EBUSY
> - hci_dev_close(): return -EBUSY
> - hci_dev_reset(): return -EBUSY
>
> In addition reject raw command transmission from an already bound
> socket during the power down sequence in hci_sock_sendmsg()
> (-ENETDOWN), and fail early in hci_sock_bind() (-EBUSY) to avoid
> toggling HCI_USER_CHANNEL while powering down.
>
> Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
> ---
>  net/bluetooth/hci_core.c | 28 ++++++++++++++++++++++++++++
>  net/bluetooth/hci_sock.c |  4 +++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d1e78ae7728e..a0533f260471 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -445,6 +445,16 @@ int hci_dev_open(__u16 dev)
>         if (!hdev)
>                 return -ENODEV;
>
> +       /* Reject opening the controller while it is being powered down:
> +        * the firmware is rebooting after the shutdown reset and any
> +        * concurrent command sent during this window can leave it in a
> +        * stuck state where it stops answering HCI commands.
> +        */
> +       if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
> +               err =3D -EBUSY;
> +               goto done;
> +       }
> +
>         /* Devices that are marked as unconfigured can only be powered
>          * up as user channel. Trying to bring them up as normal devices
>          * will result into a failure. Only user channel operation is
> @@ -515,6 +525,14 @@ int hci_dev_close(__u16 dev)
>         if (!hdev)
>                 return -ENODEV;
>
> +       /* Reject closing the controller while the power off sequence
> +        * is already in progress (see hci_dev_open for details).
> +        */
> +       if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
> +               err =3D -EBUSY;
> +               goto done;
> +       }
> +
>         if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
>                 err =3D -EBUSY;
>                 goto done;
> @@ -556,6 +574,16 @@ int hci_dev_reset(__u16 dev)
>         if (!hdev)
>                 return -ENODEV;
>
> +       /* Reject resetting the controller while the power off sequence
> +        * is in progress: the shutdown routine already issues its own
> +        * HCI reset and a concurrent one would hit the firmware while
> +        * it is rebooting (see hci_dev_open for details).
> +        */
> +       if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
> +               err =3D -EBUSY;
> +               goto done;
> +       }
> +
>         if (!test_bit(HCI_UP, &hdev->flags)) {
>                 err =3D -ENETDOWN;
>                 goto done;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 070ca388f9ac..897596614939 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1296,6 +1296,7 @@ static int hci_sock_bind(struct socket *sock, struc=
t sockaddr_unsized *addr,
>                 if (test_bit(HCI_INIT, &hdev->flags) ||
>                     hci_dev_test_flag(hdev, HCI_SETUP) ||
>                     hci_dev_test_flag(hdev, HCI_CONFIG) ||
> +                   hci_dev_test_flag(hdev, HCI_POWERING_DOWN) ||
>                     (!hci_dev_test_flag(hdev, HCI_AUTO_OFF) &&
>                      test_bit(HCI_UP, &hdev->flags))) {
>                         err =3D -EBUSY;
> @@ -1850,7 +1851,8 @@ static int hci_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>                 goto drop;
>         }
>
> -       if (!test_bit(HCI_UP, &hdev->flags)) {
> +       if (!test_bit(HCI_UP, &hdev->flags) ||
> +           hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
>                 err =3D -ENETDOWN;
>                 goto drop;
>         }
> --
> 2.25.1

Sashiko found quite a few problems:

https://sashiko.dev/#/patchset/20260831084329.3141802-1-zhangchen200426%401=
63.com

The fact that a lock already serializes these operations probably
means we should either check HCI_POWERING_DOWN or we do it after the
lock, but if after the lock acquisition the HCI_POWERING_DOWN it
probably means someone is powering the controller down without
properly locking it meaning this would be more of a workaround.

--=20
Luiz Augusto von Dentz
