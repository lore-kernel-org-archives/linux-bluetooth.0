Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0375279DCA
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877552; cv=pass; b=sQ7GxHaDrtMqGsY51Z82yshORFTCZgZvgMHjdLu7gLKEuFx/pus45jT1WcFlLz8xF9RF+CPHz0Ezxq5iFgoW5tGIm14a3fSoQBsxzUDQdZMk6N4Z3g6MMten4VqldKdTzlFw9eV8es5V0p69Qai6Rb+f0iTs0LNOkvCD4sfVM7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877552; c=relaxed/simple;
	bh=9Tfk5PHOcFWoQ/3+xOOD+Hr9tKZtG3koqhdKdMgleGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RERUhqZJHotrLxgpfq9rASWQxjQftNL6z8+U0CUuKFQKPb4x5eSmfV6YhgdLhje0aLB6LhrrdCyUSBFT1pGOwwDtvBDGbTFHYE8HtjIrR6ykkmyCfns+H7FyalZ46PryfyZDq06ac/N8l6SgkRssw8uPYv4yLpvBB6XHPSGN7h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhm9n6ke; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhm9n6ke"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6501418152cso2404318d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 06:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774877551; cv=none;
        d=google.com; s=arc-20240605;
        b=DZ8881PSmFCPQI6ITYFmgzoRqP0yp6vFfTLMbXlPLRlxMzcFBdAGO92YBj0rAWxstU
         72Z62YDlQ56tXRiQqBUj9s8VNzr2ftRyPwJdmj7d+lEiaTgqBfMk5lXpdRluclIaW0Pa
         9O5yOms5uxgiCV8xZvO+g5d5SS2PCmC+V2MOagu/lXdpDm99fttLTXpWGnj9s6L4yORF
         77fda6OuxEeqfNOQASaUsw5yv2oeqjYug6Rqey7FZIRmXeYYYvAt48+qQgoHo1AyWzgD
         77HADXEvntW+M/XVMarnADjNYod781MECs/LdCBOIs79frmzarOaK+CL4fl4oHnSqQhS
         f0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8WIXNx1Gs6ypeqEM3hbuY6rh2HZr63lrEoEcbHGmm8=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=ZRFI/E/HmNpZtVh6PDIV1oaVNIBxSIfQ453+pWnK3R6Bnfu7aD9+UJqSbHwbp25qAY
         +pVgi2etPJPJI2sj7Z11roVACQO1YCNkG8IK9vcqvT3KWAi/goI6P/06Q8uTAJUyUX6F
         Po4e5JD6cbcPip8gJ1rP4PSDmjaBXM7/IdThJ1WU47lHD3dY8t+gNDOsyykq+rUwVykz
         bPJgnZTUaglf8kiQwfWuquiFUqrS9N5M00wcEkdSmIjP+pdfQdeMEOFnnsMulUVgW+uj
         ov3H7rljOpmjYmaFgruymNNbON13WIlhGkia6sY6eCMjoLjSGB746MMTteY3uKGby3Qs
         Da0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877551; x=1775482351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8WIXNx1Gs6ypeqEM3hbuY6rh2HZr63lrEoEcbHGmm8=;
        b=Dhm9n6keJLAy4LSRw02K6GmE9Efyc5mD9K+26q2ZkEdyLbYH7O1tYBgTRNZ9wTyTNW
         RjHI4E3tm1B1e8HARy+H1Muyoo7QGxECsDhP4D6kHK5tKBBj2zTQw7XCDIjRwB7rZIzn
         /Dl4yhw8kuwItoTvDB7WTWRQwkIW8/tw+rHHxdToQxsLkebW+n7+TShihKcKPTLu647L
         Hd4gQW9FXQmcrVma89ofhFL6NXR3R2B+dA+bUSklfrKv70yL235ZsGrolmd+YW77u8MB
         Wo0zhd35ve3yKCCcJ6rRKbfI84Xs+hfbovQcWIarhdbkYAWCgSo60l60xvy8RGFjYNLm
         79PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877551; x=1775482351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8WIXNx1Gs6ypeqEM3hbuY6rh2HZr63lrEoEcbHGmm8=;
        b=SIAAIlagy7PU6GzvV5fwcxpHYfLcCbKPY5OfnSd6DyACPxaItv8KODclJTVAO9LnM7
         0QgftQ3gmi9QY4vutv3qjFeWiWIRUOaZIjml9sGyrsZ6oZsn4NUQP6tlWoQljIsqGwNG
         nG31hGX5mwm/oXMpM9J+FeaEcXVmjerYhWNzGhwKXVAOPLa1a7fDilwCNa4aWL396R3z
         +vcfsjXcUHpwM8Gcui2Q7IS+maadKbDQBbsd/IK+gX1eAb0/aGI97dpOaYMdKL2pDreI
         tHIKv04vaGYEuIKPBR/UY8BF3es8dofr+LDRYM4dbJp+FgRhY53Ce4H99lyrmuSKyoY1
         dmCw==
X-Gm-Message-State: AOJu0YwamLE4ViG43vMnSPwcEj7/2PTidHs7FYBsepi7W1GpOj9vmpSH
	pJvivRQPb7mcJque0j1Swg1vAnLVrbb/NEaHeyjJ3bSfwwipgk/OfQIVX+mpHrEn2C1cQsvHGJt
	1plZIVzLet7Ibn7Ohwp3D7lxavYIdHnnfRQpi
X-Gm-Gg: ATEYQzxVEYkpNQp5/0TIHIkOIDmq/rcDL0la4rskm/gSnUq5lZk6TSaxtFCFFpGtxm+
	CZ03RfXlhSGdNIiFALuWyiBF+5OB1/xENiRDAHsazBA/EagciqOrBAxEkWzTDVrGNmD0DGBYHzh
	QsxIhW4TSQD3zFu+pM4GGFNm0VgKhNfntoUKvh8Avu4Fpx3eHxvC7vxqh0pXMe3Uq1srjzzqcC3
	f/3rLclbWfUdBor5D1+h6qBzlGwMiA2y9T7PrA3bEmKnmaZyT7ZvN+8vRtNme4+W44gMpZkhuas
	RKSglv1+k+BhJye89eMy5ScWBgZcdN5HJjFqIm4/IY26uUZdvecFetSqlEmAlsOf1NZIRg==
X-Received: by 2002:a05:690e:488a:b0:64a:d2bb:9072 with SMTP id
 956f58d0204a3-64ff73f6c33mr8723339d50.53.1774877550682; Mon, 30 Mar 2026
 06:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
 <4677ae5da08686a59e6d7d9f12cf19f3ff2b0e31.1774787570.git.pav@iki.fi>
In-Reply-To: <4677ae5da08686a59e6d7d9f12cf19f3ff2b0e31.1774787570.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 09:32:19 -0400
X-Gm-Features: AQROBzDdm-uDKLNCVC6sk66oEgtYtNYJo4WTziEZqRVxW2TLP-dpARXYaCi--Qs
Message-ID: <CABBYNZKMkmtfHCkfCtuRN4u==KLq_+-wYwV3z=SGZ1bhT54jtQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix refcounting in le_read_features_complete
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Mar 29, 2026 at 9:43=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> hci_conn refcount acquired in hci_le_read_remote_features() must be
> unconditionally released in the destructor, or it leaks.  The destructor
> is always called if hci_cmd_sync_queue_once() returned with success.
>
> Fix the destructor le_read_features_complete() to always release the
> refcount.
>
> Fixes: 60562bebb651 ("Bluetooth: hci_sync: Fix UAF in le_read_features_co=
mplete")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     This probably should be fixup in bluetooth-next/master if it wasn't
>     pulled yet

Yep, I will amend that change. Thanks for looking into it.

>  net/bluetooth/hci_sync.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 91d0252ae661..92f87761468b 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -7390,9 +7390,6 @@ static void le_read_features_complete(struct hci_de=
v *hdev, void *data, int err)
>
>         bt_dev_dbg(hdev, "err %d", err);
>
> -       if (err =3D=3D -ECANCELED)
> -               return;
> -
>         hci_conn_put(conn);
>  }
>
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
