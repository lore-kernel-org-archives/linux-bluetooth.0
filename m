Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D03563FB
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384955; cv=pass; b=pQBVEMWoxGLbg8t9nmIz0ZCCG42y2u+xR40rmwqiymX/LNXvlp0pJ7VPOTCHlGbCd/tfsvMAwJdnF73cbIsfSwS0KC7XD/C3SH65rXUJF51wE1LxOGFv+540nxDBhZentuoUb3Lihyu0rRYxqBgruK93trq+QlbDEIK/pcfmoR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384955; c=relaxed/simple;
	bh=ae0cg04ZviHa0OoZ9XLGd1lwCm6ZIDz6wVtHt87Lx1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5rbpec/4FhUH+Fao2FZXdxhcNVTxAH7be9JtaXSohFAZE7uLeyFWG35B24dTH8i8B+IkXcfQ6cRNQIwJe4gkT5+1Wm6JXfi23yEBGLF78zOTz3qiRjNdKz73eQDrKxp4/1WhGuypsqE3YQ1YtIHGZBFdp1eR4m7aGR8J6Lh+mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qW09ZEVV; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW09ZEVV"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79ab5fd969aso29015687b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 13:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774384953; cv=none;
        d=google.com; s=arc-20240605;
        b=jzCWJ/0PDYOHj+HK23Me2cNE1dQKfADDMmlmrMOqW+3AkgOmvGw8/Sf0c6iqNRP7tr
         phBQN2XnqGoFPD2fzdGjM/eEKfRxCPux61mGOjSMJBE8MNL18BZmZRAKPLHgCwzvTqtL
         9xzI9GgnDkN098YMQAq0l+Rq+P/E0r+BhdpbOQyMMScX2QuKgfBdXzFU/xU1P0GsE6vT
         7VG6K+IqKxnwvUeosq/OGzO3zUcvPLIni7Dk75pTmHQ2NmcBliNdS62GJv4sbgO8CTWH
         h638AZg63s+s4zYZR78AleMNr6k9ntCttYWx9ujD9T0HYs4JY+jj9/h1oYvA+7tX047y
         Gw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lIWHYWF8OakNU+6jdY/vdAWx5C9SAXTwjn6JUQFRk2M=;
        fh=Z3O6ex5q4O2CnZelDHBdckm1hkaok0h16uvHApbhZo8=;
        b=DUrCFC7uZ5SzZJvXIoULUFlTySRKbQWm8pNNM0eBFVaiQ7qkEFpmCay5rLdqSTWIB1
         Mk1SqEbJzTThWN+e0lbQ7RfAhUzmieGQxMEkufkkmz1PPDcB1cozPpRYTma0TUHk9VbC
         YsrWeFo+E+S/24nmPztwE2w2b1OxAId2EcnYCw9I6iX+vMBn+GrrXN53GxCt2Aa+T2Vu
         14Wo8DMyRQm1cXV/kyY4cQLszBwlEpnbcwNUIVl1VpCsdBgUkTTREKGrY7msuqhTKh/F
         SvdviZvrTQLFXjUtB+Q1esg+3x3g3C9fRnOG/AbYMxK9nkmThgp9DN+vvCRjClfJzBpu
         XoLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774384953; x=1774989753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIWHYWF8OakNU+6jdY/vdAWx5C9SAXTwjn6JUQFRk2M=;
        b=qW09ZEVVXGzCCTuUOT7WZxhB/Zt7JER1jJBzajogduWIVbVne4lO5T5d8/1X+RqbNp
         nwlJfTXOMb5RneoIqLPJ/knFS6qF0esuXpI+4jnMmkkcB01tJS01N1G4567jyVLAWnYW
         Y2YErybcuJxEvf2kM9hsY1m5z3s+IRR6EMGgB1tzUvvwBxsqWPLsEGkla+Y3MELzptuD
         vMrMmSD025ATmce/PgKkJFD6UozJf4E+WP+NH9fc0xO8/FNYpSqRntFH09BfRSBUAh8i
         OWA0BiSEWGGKh/BZRyR92gAJQbMQCiFMLv8TMGUR4tC1crAjFGlQ1xt80mpjKmVgL/40
         lrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384953; x=1774989753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIWHYWF8OakNU+6jdY/vdAWx5C9SAXTwjn6JUQFRk2M=;
        b=rzhTugX5s63GBuYmPxdv2fi2/kpAqy5Ju42s5wIij4aG7C7/+0tcIPUqGULSDbva6M
         4ZGkXHcFwIexd85cy64pLLWnEziZ8MjoqbWBa7o1oq8pljLqsUTLGdLOu0RkvsRamMTa
         SYYSUDy8cKvdpD/azc/DSED0zTH4Tkgry4AZk8C2Nn+EJeZw/jDYvE24En1Jaz5fxt68
         vw8ulyziHg0xmzrmrxifXfPNl46IVQR9FLSw3whLDdX96x0uuGpvXekn7hmLHSgDWirz
         P5CzjExWMu7BqcntXg3NV2lYt6bocWRD01IuN8FMBtrLwHs1fhXvoJgGF938MOw2O7DD
         hijw==
X-Forwarded-Encrypted: i=1; AJvYcCXcAZFVS4RltQF4CLXopxy/dgFmxPazVhXgpeSj3oPdxklRMff0F6c3DCwQLThUjaGaZqhTiLlb1wUon8zVGRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZtAibfqDZoPwvkiSoUneTFhhZbWvSixsK3cM8c8ukwGM4S/n
	2Hya7ZUdUHkJIZ3JtSznp1Sywr1Kr0uh/idt/0WvyStq/impe4sEi3224HXp2qFMrlCp+fFiRsE
	9rgc7Y3SEGyaKPC5g3cz0HtFwMYGU50gos5sMJ6w=
X-Gm-Gg: ATEYQzyaZTZeKJ6nn+GpWePacxLxpibLda268zuT2q+Y3U+48o0T0T/cpIMf4Q8IhW3
	dVEzJms72JXVz4PV9QGnEMRKbkijwyarxD7hlqsqBIIiikn6bs5wV6BcWEm43k75vg/jE10TKWp
	1VT2Xi989NwLq9JmQ5Xx4w5MCFwiUDbiFcLBk6kDeueXpb2zY49kQefmFPP6hTfsFA5nk0m68RU
	eoLgwNyiKBVxsijzTYKdx5hR2dsF/19hqVfuR9HwiO3SWGbj+XfjVeuSCnZKDGnsvxVvX2rg9dE
	t1rKGu3qp1h/TVls+b9vtdHahkAMGNmPOr1SfiotPqqrF3H1Xnklx2Dzd/qBdByCn7aWI4BkI54
	nuoLd
X-Received: by 2002:a05:690c:89:b0:79a:3a79:a488 with SMTP id
 00721157ae682-79acf6693bbmr12389737b3.45.1774384953159; Tue, 24 Mar 2026
 13:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322210849.68743-1-abysamross@gmail.com>
In-Reply-To: <20260322210849.68743-1-abysamross@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 16:42:21 -0400
X-Gm-Features: AaiRm53xVGvFUACt_xjDEeNeSDDWZ3aGmctn6lY46YXy13_FatKarmyfpOVBQME
Message-ID: <CABBYNZJ0hJaVRpqPOknitzD_VnKwQ3RkS00EH4GStdbW6E+ADg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_release_dev: disable delayed
 devcoredump work
To: Aby Sam Ross <abysamross@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	me@brighamcampbell.com, syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aby,

On Sun, Mar 22, 2026 at 5:09=E2=80=AFPM Aby Sam Ross <abysamross@gmail.com>=
 wrote:
>
> It is not necessary that the pending delayed hci devcoredump timeout
> work, hdev->dump.dump_timeout, submitted to the hdev->workqueue by the
> bluetooth devcoredump state machine,
>         hci_devcd_rx()
>                 hci_devcd_handle_pkt_init()
> will be reset by it or by the timeout func hci_devcd_timeout(), using
> hci_devcd_reset(), before destroying the workqueue or before the hci
> device is freed up in hci_release_dev().
>
> In this bug the active delayed devcoredump timeout work's timer object
> is active when the memory associated with the hci device is freed up in
> hci_release_dev() causing the ODEBUG WARNING.
>
> Make sure that the delayed devcoredump timeout work is disabled before
> the hdev->workqueue is destroyed and before the hdev memory is freed in
> hci_release_dev().
>
> Tested the change with the syzbot reproducer that uses vhci device
> locally on x86_64 and on syzbot portal as well. Ran kselftest with net
> target.
>
> Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
> Reported-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db170dbf55520ebf5969a
> Tested-by: syzbot+b170dbf55520ebf5969a@syzkaller.appspotmail.com
> Signed-off-by: Aby Sam Ross <abysamross@gmail.com>
> ---
>  net/bluetooth/hci_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 01f8ceeb1c0c..1c7ee2a33337 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2747,6 +2747,9 @@ void hci_release_dev(struct hci_dev *hdev)
>         kfree_const(hdev->hw_info);
>         kfree_const(hdev->fw_info);
>
> +       if (hdev->dump.supported)
> +               disable_delayed_work_sync(&hdev->dump.dump_timeout);
> +
>         destroy_workqueue(hdev->workqueue);
>         destroy_workqueue(hdev->req_workqueue);
>
> --
> 2.53.0
>

https://sashiko.dev/#/patchset/20260322210849.68743-1-abysamross%40gmail.co=
m

Both points seems valid, that perhaps the dump shouldn't be attached
to hdev object since it maybe necessary to unregister the hdev as part
of devcoredump handling, anyway if it is required then upon unregister
it shall actually cleanup the dump object as well.

--=20
Luiz Augusto von Dentz
