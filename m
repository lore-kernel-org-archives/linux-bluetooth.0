Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15251C9EA3;
	Tue,  1 Oct 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796574; cv=none; b=sUmt3YxsV1/0m87wFw6iGMlxdmpq8goXZW9MgCUeukrnSQuJT3jKuOuaqaRbN8iabY7yG/tSk+dx/vfk2r5BqqVD3ZkjpXDq12J4n1549kymx7n8kqU7W0WWASlEGdHNCo0FA/35VH0ddVYmh2ahcPjJB4ieZkii1O5tfxxYpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796574; c=relaxed/simple;
	bh=ExSg9jxWWOXUZIYAenu/yAYPq0EsIP31UsbMrncQcVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bu8IiZNogKScFPyQ2v8pg/1T7c0SDdt6vJctq/sVQLJSVPUnlrvSTf7uNqYbYvjKZ1PlEOjZNLYr46JjpBXv/wV48vQ0PiKp/5cOD4IReQVl6ngynjNEiBUu8wNQoyQNwgHw2fDbqDMhcZy0iDm3ZfNnfOGvWzXRwviNJrqRmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFgWid9N; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFgWid9N"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fac275471dso29385461fa.0;
        Tue, 01 Oct 2024 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727796571; x=1728401371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKiujOg6CYINrgCG2TnZdYyyvY37bP0hD4EoAW2yqHU=;
        b=bFgWid9NwEbkQ7M1EAD+urGmuAq7ppj+/OrKCi3mnEpvqjfgjlvKdb3HGlZYlcPjjW
         PhpUq8SZVxoJiPK1ZV0hQYZ/9glnaZJj4Llu13dzZfSPk7bg4V6BQ+uS9HJ3CjR08Jzz
         c915d8SKLuirOwxYiNPpAIPu8g9stMwKcc5GsSdKGXH9YZnsHifdej4SSbxLn1jlKlwl
         VtLGRHCqXQTj3TIdrmQkUpUEVh6BLRXpxYz5fGsURifSlXe5+SMEUAwQg675faZukRHB
         8MN0/7PEh1qPcWWQqWuhVcTfAc/gBvN7HCM/f4wgIP6wZvx3VlcyDAkRzibyHdzK4dxo
         hpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796571; x=1728401371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKiujOg6CYINrgCG2TnZdYyyvY37bP0hD4EoAW2yqHU=;
        b=FEVFddsUwsM3zqBx6G6CtsAYwrtrNKsCXKzABJDdEFfVS7GPsnSilghjynu5KBSp+b
         RcNKaVIyYKwYg+J/xTHDUSXuA61jXinpY6U3Im62SMw+lCr0s7B1HFLN+xfisbcEiqjl
         R8qPj/hwMK0Ohv/blROpJ1Vn59SIPT4TeK8KWRvpZVNPtFYxJN3zcGITezrllqwJQ/u4
         DgszZt2HAM0XeCzxAOgQ/MSJyUr4PJ/zy9QEW3r4nE65wcIE//ewta+VC6nIV/nvWyLX
         n+5QdTlnTc26IVWhadkfBDYQQYOk4ewdPiO+p3EXiwpFeaOTfhuubC7y+9/QcDWgOZU2
         vp3A==
X-Forwarded-Encrypted: i=1; AJvYcCX1DW3rubLrnni0e42Jgz4wcMYi/neq4oxltZaG6fsMWtgb+ritCf0M9WQC6WJ5c59O6XDCASli4Qgb/bvQ1yc=@vger.kernel.org, AJvYcCXiPqNCSCN+4JrqDT7vAQxGJYIy7AIN/qUo6+U5h6ZjLlBSFym9hiVvyHRjTLhfRbVuzhkA32q4fBduc7ER@vger.kernel.org
X-Gm-Message-State: AOJu0YyGebafo60zxeroCwLbKPY7n4140sEX4SBnktgUA3ZwFwPAc9Ae
	tjt9M0YhMzXcK59IKuXrlrvjo69wpiLeOn33pQFX2LFZifxSInC5kPhxG/8IVQ7Rb9lFp6PP4uV
	goykQ5kuz9Ers7m0x9k6TQ0iZc3g=
X-Google-Smtp-Source: AGHT+IGWY4UN/+6v16SuDRnsJsC9wBlxJW95T/Ea6m+RdbOLxmzcd6XTbioSzCVIjgQoRhDE3YcGu6heBwkap1rVVfU=
X-Received: by 2002:a2e:be27:0:b0:2f5:2ba:2c89 with SMTP id
 38308e7fff4ca-2fad86962c9mr15446781fa.11.1727796570754; Tue, 01 Oct 2024
 08:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001074339.1160157-1-hildawu@realtek.com>
In-Reply-To: <20241001074339.1160157-1-hildawu@realtek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Oct 2024 11:29:17 -0400
Message-ID: <CABBYNZJj+gtmSUUz4gUigkg3GUaBuR29jEU=ZxKjxu7cPSv1Yw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from
 10 s to 2 s
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn, max.chou@realtek.com, 
	kidman@realtek.com, howardchung@google.com, apusaka@chromium.org, 
	yinghsu@chromium.org, johnlai@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hilda,

On Tue, Oct 1, 2024 at 3:43=E2=80=AFAM Hilda Wu <hildawu@realtek.com> wrote=
:
>
> The original timeout setting for HCI Reset on shutdown is 10 seconds.
> Since the HCI Reset processing time is soon, so decrease the timeout
> to 2 seconds for HCI Reset on shutdown.

I guess you are saying that HCI Reset shouldn't take 10 seconds to
complete so instead use the default timeout for commands. I can update
the description myself if you agree to use the above sentence.

> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> V1 -> V2: Modify commit message and summary
> ---
> ---
>  drivers/bluetooth/btrtl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 2d95b3ea046d..7128a8a0ba25 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1371,7 +1371,7 @@ int btrtl_shutdown_realtek(struct hci_dev *hdev)
>         /* According to the vendor driver, BT must be reset on close to a=
void
>          * firmware crash.
>          */
> -       skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIME=
OUT);
> +       skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEO=
UT);
>         if (IS_ERR(skb)) {
>                 ret =3D PTR_ERR(skb);
>                 bt_dev_err(hdev, "HCI reset during shutdown failed");
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
