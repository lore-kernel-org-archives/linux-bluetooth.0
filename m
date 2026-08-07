Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1938333A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118792; cv=pass; b=bPfmhhOFNJtfE/DKB9U/t8o6MokhrQcUv8DdrRgJeDxVWB8aJK5MNMq5WsXYJx5qOeYU/zSB9xztLwrHu3xv6SBnvCfDGXCewEZVHhYbI7GLAmPX9c41fFLilBTtmJleQA0U1m7US25kCwuy09sReFt3aYdU0lfU0omF43/XPX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118792; c=relaxed/simple;
	bh=ebo8CrDowmZ2y55Mjv+Iy8j7vAUacsUGTwSVNNKBCCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEylGaaS+5wUTx0o1COZ/Ph7wu5eYZUJiEoneN8oxYrGWK+aSexKCW2SPvFW49VVYWJb2aMdSdJz6j26XS7QWYROIDGb/bydB4Tval7lmff9lNkpS1ztSOzT/N3ZjgxiA8x92TyQxWs+jbGawV1p+WZfvijzxhNg+dsTzVD/naY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6X1OGGH; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6X1OGGH"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81f36179d72so54015027b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786118790; cv=none;
        d=google.com; s=arc-20260327;
        b=aHW2t0I40LTrbyp6XX4jCTpJopFJGJ7KkVGVg2K2dhHB4APf0QrbLnse9a8R24idN+
         ki5KU8wQGFtircVWrJ0aczp2iW5ETUVwNUJOh2SGeYRf6xv8236M+tFSVF4+CZvf1Mnd
         i+v0AutVy16LJMxZKGh/J+dLSsUsuiKuvfoWvPQMCGphcrIoFazDeWWkOyGRaUdq8do0
         BXVFbKu6HD6QGPIVJwSNSGzTdO6MkdxCIxQkhs1zTHBQbzXal7Z8SnwvgQXwlusJ2sP9
         dEQUvDZfyWeqXDZAAHvAVxG3EuHM4i5fpW0vVPpC+9Dg4CPZ6mWOpjP0Yn+adY9DsZvW
         VnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=roxSmUxSKsYyhutGcXaoY8nERDYuzfftuWpIiGKxtCw=;
        fh=2wS6qLHTAlSPeTaOVyTZ3SM1tkI7mC7d3AWCY9O/ujI=;
        b=AwO6taDE9b1TDlR6ASD+1Mu8v5S70PDIzTLwPzcLcMO9vxc4UGNITMwn+dx9SNvgeb
         EDDBeKb1Y7HxZhEV5EzF5MBjTSTHs8pTNFhyMPCTxkr7VO/O9CdXbH7m90swgPFgR044
         KIinpdW8QS/Lk1Til/eETDxMsc7mx9sSRe0j7ajvK8elZFxVJOnOA8dwIsrkEghe65JA
         vZbTC3fYMx6EJxy5Hz8/1am9q6n3Fojtr0nMCsMaVE+uf6aZIw22cocQI1ANudW5Kt75
         fVqjZRd6sPn3fWkiKgsuh1amIGUPYYv5Y982rIG07fA/H8rqAd4cMq0mxrtLRdW6sY6V
         N73w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786118790; x=1786723590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=roxSmUxSKsYyhutGcXaoY8nERDYuzfftuWpIiGKxtCw=;
        b=g6X1OGGHCDci4uB1LCyNZqyAViT2rOlw/OyT2BpZu4zKh2NroafmQ6RGC1V+e53Zq8
         KKpb1GSoelPwKN/U2JU/+Ix6M14fFTv9KJude+zP7iDkfGcMFtr8XIKAYhsfxSIm5oJC
         3B9QDooyxQwAsG39DeBK0lNViepNJoP/ErvL24MfF6Hb9lKhBgSK60G3ZM1oJaqVooRQ
         QlIptVdd1h92e1FOCU6iB/M/mdpcbVySA2Khh14XYat1oaSS/qjUHZaSQPyZF7evCFtk
         cHFHmcy6c0qLRWoC91eBC31NxU0NjHjETIBmPWCGV1nzEUxPKgV771hw64Gm42TKuoID
         prnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118790; x=1786723590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roxSmUxSKsYyhutGcXaoY8nERDYuzfftuWpIiGKxtCw=;
        b=ZZ6buHj0TGgL6iYA4uPcF/shK6UC+l4s98lw1baz0VaRHyAICtj6VAaeDDyOiIUwpv
         H12LQrApx9XuB10cIpGxTye5xh63cLMkOFjj2AXZ1d5TjmQtMQBJ0XhiBQXwvxtfWKuM
         r+EaAWullORZTBYCSxIkLgcgE4sloZ7TuFZF9LQaSAgisr1JZf4w+SRwc/7nhQYESHip
         oKZy8+FkTmCtmw5vtC333p818IfozhvYXi4qZkv8Ommh2F2yTjaCyxc+UzZP/e1o04P1
         TT8T1Pd/DeenZOQbrQPj7tqk2eL4sB35SbyZ7FkzxNEaBdtiLn7qZGRfNrFriXeM1R/n
         OPNA==
X-Forwarded-Encrypted: i=1; AHgh+RqkEAJiBJzhNsb2pP6AScNmfzWqgS8kbXs4zCigwmKlNT0TZpLr1JydG16srmeIZfGSq723/SOu5CiQBhrdt8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/56cs8tWXEN2SE0uEhv4n7HWbihXKHAnHcTuOTovovJqxZGkh
	xm15x3rxAhobrkQomf69pNs3O6CQTr4YfSl2b5OVSR+3NuWCZunsppZ2Mi9e0D3+ow+7MOBnStq
	Ou/fbV/929e3V8jaoaZPjn1c5ud4knB3ffqSkd58=
X-Gm-Gg: AR+sD10nYph7ciDdwDyKFSYNcj4IBpkgTq3GWK3O8UK2WwXzM6S/HTacQyEjyj2EJyU
	Kmona/OJ8NWItkG9qttcP7uSx7kplnUQdV1fGji5SVDlPNTYSlbCIsdSg2HZKpscdlAN+g9Xwpz
	qxk1FVhTWDZGentQ6fDCW9tlPmB1Bd0wgM9LOjSTDehOdRSnDTzW/uvAePmrQ6mvjsBaq60xKiu
	3DGaz0u++yQ3pjKmAdDqrEKLDFDM82DqKte1HLcytdZKjxEHHyIyGm4e6dv9Xk/7GfEf5r3Ex+z
	sJA2swFtMAHGg6Ixd6Jxykf2ZI+xEsXajp9aDQ+oldl0faY0NV/g0nil8PKSs90i7yjzuCz3zVo
	44WZPLLDiWQiQMuRSfEcKqxcYEWAACXc=
X-Received: by 2002:a05:690c:3:b0:7ff:1a06:472 with SMTP id
 00721157ae682-8201f0c14camr146359407b3.4.1786118789920; Fri, 07 Aug 2026
 09:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0BDE51B0554940FB+20260805103612.916678-1-zhaojinming@uniontech.com>
In-Reply-To: <0BDE51B0554940FB+20260805103612.916678-1-zhaojinming@uniontech.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Aug 2026 12:06:18 -0400
X-Gm-Features: AUfX_myUM0GqP11n9hBmUdzos4mGx9AD3_SQJsEtsXYTXXhrOo231vAZy5h2dxQ
Message-ID: <CABBYNZ+mwb4z_x-jwdJVftSLDGa3x_v6ghgUd2uND87q8fP1rg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ZhaoJinming,

On Wed, Aug 5, 2026 at 6:36=E2=80=AFAM ZhaoJinming <zhaojinming@uniontech.c=
om> wrote:
>
> hci_uart_unregister_device() frees the HCI device (hci_free_dev)
> before cancelling write_work via cancel_work_sync(). If write_work
> is executing concurrently on another CPU, it can access hu->hdev
> (serdev.c:61) and write to hdev->stat (serdev.c:75, 83) after the
> memory has been freed.
>
> Additionally, HCI_UART_PROTO_READY is not cleared until after
> cancel_work_sync, so the write_wakeup serdev callback can still
> schedule write_work via hci_uart_tx_wakeup() even after
> hci_free_dev has freed the device.
>
> Fix this by mirroring the same ordering used in the tty/ldisc path
> (hci_uart_tty_close, hci_ldisc.c:565-593):
> 1. Clear HCI_UART_PROTO_READY and close the serdev port
> 2. Cancel write_work (no new work can be scheduled)
> 3. Unregister the HCI device
> 4. Close the protocol (may access hu->hdev, e.g. bcm_close)
> 5. Free the HCI device
>
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
>  drivers/bluetooth/hci_serdev.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serde=
v.c
> index 593d9cefbbf9..e06b9d5b3846 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -397,18 +397,22 @@ void hci_uart_unregister_device(struct hci_uart *hu=
)
>         struct hci_dev *hdev =3D hu->hdev;
>
>         cancel_work_sync(&hu->init_ready);
> -       if (test_bit(HCI_UART_REGISTERED, &hu->flags))
> -               hci_unregister_dev(hdev);
> -       hci_free_dev(hdev);
> -
> -       cancel_work_sync(&hu->write_work);
> -
> -       hu->proto->close(hu);
>
> +       /* Clear HCI_UART_PROTO_READY first to prevent the write_wakeup
> +        * callback from re-scheduling write_work via hci_uart_tx_wakeup(=
).
> +        */
>         if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>                 serdev_device_close(hu->serdev);
>         }
> +
> +       cancel_work_sync(&hu->write_work);
> +
> +       if (test_bit(HCI_UART_REGISTERED, &hu->flags))
> +               hci_unregister_dev(hdev);
> +
> +       hu->proto->close(hu);
> +       hci_free_dev(hdev);
>         percpu_free_rwsem(&hu->proto_lock);
>  }
>  EXPORT_SYMBOL_GPL(hci_uart_unregister_device);
> --
> 2.51.0

It looks like sashiko found some problems with these changes:

https://sashiko.dev/#/patchset/0BDE51B0554940FB%2B20260805103612.916678-1-z=
haojinming%40uniontech.com

--=20
Luiz Augusto von Dentz
