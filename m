Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A9378828
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644135; cv=pass; b=XqtD4Gjmi5iyMJpRSek4BJ7tXhs7UW/rRdwiOf9cxbxMBUO3L+UZNxxROXBRccitqpF+gFeNwTDDThcoIZBaY0KL5iBrWbfLSwL/boNn5MLbp4MR8Is0UnWUr0zX7iV73wMM6ze4YI77P7FNV5LzJcTXezith3VJ+A77Dxwb02g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644135; c=relaxed/simple;
	bh=/XObGync8LF5uD4NItfTT98WgYVcbAUhgyFwZeuLv8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0VxlWPk1PH/bDQwscaQ7Tdtgh+ibPa1EPHM1gzj8JUdg9WcaoxPKZkQ0N2EabQBr71ALCkijpKkU07nPUIdTLa17z5+MFidnmmrFXRQaAdmaZnMwomsDfO5Lh1flinTcPSnX4SQYBr9YSDfhnL+A0wbqkvM4yWwF3B+NTKT/p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYw2fsPy; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYw2fsPy"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e6f0b4610so117507187b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784644133; cv=none;
        d=google.com; s=arc-20260327;
        b=DiHEm7jq8dYxRnziEK3XMYYXr+8T1SQr7Kr7kTi+gsAJINnVZ999jkWzUPhGhwzZZ2
         en6bHKGGr0xQi7S8an+9Imj1P3AkSyUznSvZmiWnd/U/YBp19BX1+lnue0RefGRrSGny
         136/E7yICwj7GBI3+BOl5/O32JWKcpRH6aCt3f+ZXUU8QYwppXpCRlXTo3zUBnbEr4SI
         3LuYn3zitdm8MnCB9FOlMD9IMcuTfcNgpnca6jSVeBM4ctPkYD4H8Vwuf+owLnpPCBau
         gAJR0YtpH9XDU1Do3Vy4KzGgeBuFBzpw9jys4ZjjDQxJzkEYHY0DSXSTbXSyc23Pi3vy
         cegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hzvh/69IIJP1fZXlO6gE1a1KGEe5Idh5edoVt/6oOpc=;
        fh=h0t8UKtdkJEtExGnMDmoafJH1yFcBNHSNlp+JUzL/60=;
        b=kz58A7YN/GwdezFfHYZe/0yYRInJI2e0KX3keJ/eyNhBU9ZWR63J8ncYvxHEjtZymZ
         g77ZK4cGIV+PTScZPpuy8pF6uSUrGroFUP4+zuwuTlMfvGnku9VYgOYdtYovL1+BCn58
         nEy5sasY11ULcIgRhGPNbPQqCkvm2KtRmdvIVnzG8pHy0fje7pse8XNKzNUqpXsKKJiC
         u2lFz6cA9lQOy9kuOHpwYqqaWFcwnkxaIP8UkRTOtLKTaA7Iaac8TUp/hahZsdPGioxz
         zuL/KiUaSKt6rVh8ZENNnGzU2JwCZJqrtLD1grqlAovi+o+1lmcSCN6I+5Wu3xMUhULZ
         P5HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644133; x=1785248933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hzvh/69IIJP1fZXlO6gE1a1KGEe5Idh5edoVt/6oOpc=;
        b=YYw2fsPyzdjCZll5rsbdscA387rKIi357u3dALHptIMkuZksRMqlP1YABqxSlMcrEj
         WaN9NPT0oRSlHZq0rTEH2QpDJftY5qASSKxsiJEKZ0ciIRlrTRPhNjmQdWKMpVfF3HLZ
         L+ntuI0wSAqMslSmEe0Yd6NOuzgjw7BdcIte1Oc/T9CljNA+XU6TjiWCE1BTHEKevrHc
         Wu7FoViwJGZ+9m8so9HhVNT4TCTtlI/ONigzX1o2fLBtAa8/qiCeYgFiwXKAbHwUbHEa
         xZBd5yibiaDW/Gy5xY9blY+IzNWH5TzFyYlNuZdFP6aoVAnvpRAoSmsKbyEKzETMEOG0
         Xmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644133; x=1785248933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hzvh/69IIJP1fZXlO6gE1a1KGEe5Idh5edoVt/6oOpc=;
        b=iD4UI6GUxlizkoXbEKuMjuUMiEEMbB2nCFy/4LJJhzXgi8+SZQGFCuXmYj7c9/Fe73
         7xjIoBSVK52k9uU257IFRv9Tm6TvDoRECbnWRlFJrIu/lGAEHAy1qtKq/upF/47eCkDr
         D3eZSh0L7KydWTlroCGvHmI8kn28bL2K0qHIEvViP4GRnpw7nPD6C8ruxqooY1WAQts/
         WYKLbzGWn/ucl9z9ke/s9kkoPTquWZPtX5BGjdXIFCvWYezdgRmpdnBSTYXhjnAWEzL/
         4zshOU84uXLDyPQpMa3dH1BUU/NuOAFlJpFruTmAeO17Xszz3avPDXYHR7GKX8hbDkMP
         f1Fw==
X-Gm-Message-State: AOJu0Yy42snTDoha6v9Bk+hgjcf2WbqpYOy7cXeYQ9n+/tCWfowXTzPl
	9Js8yMmDRZFleyqKJ0OEhULqi0ZojSXDytp+F+7FE3yR+tooj5fpDEVAhMGfwK5g57ks3fiNnGc
	/zfRUvbsOtV4TylthEX2bpf2VbI25sVvPE/XQ3H8tRQ==
X-Gm-Gg: AR+sD11NyPgbZ6rF4Sv2x3mXoj6S9MHZJ4MB4z5vtfgRvmM3TY1HSBmuF6039GZZpCG
	fpb+Vu9Fpfw7Xqix14AFgH/mZy/dofpa7+MXp3Ad/Md0vG98k8K828FyFwh9l4uLwDiuXzo7ouw
	tZ3R/wrDN+VGb0MAqlmqA/02nS6BsDQDNfFArPHJkDvTIOWHlx+4+Wpc87e3ozKdX0jTrBD+jxM
	9/VTA9vDQC9MJqO2jJ2LaBP8G1AdnfNxl8plZGXihEh+86nPw5dMrw3O7x6PBpvkHj7Aiz6RtyX
	s5AZt2v/9HgFa8pK9NzpLkby58f8hxMURu+7RhL+yj00H7Y1
X-Received: by 2002:a05:690c:6d0f:b0:81d:6af3:b9b5 with SMTP id
 00721157ae682-81ef25a1889mr53344857b3.9.1784644132696; Tue, 21 Jul 2026
 07:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753084800.git.Pakrohk@users.noreply.github.com> <patch.1753084801.git.Pakrohk@users.noreply.github.com>
In-Reply-To: <patch.1753084801.git.Pakrohk@users.noreply.github.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jul 2026 10:28:41 -0400
X-Gm-Features: AUfX_mwQnPTNMM0hVSwtE8iDlgfty8UthdizMTrGpCSx606gz7D0dSwxIFucnrc
Message-ID: <CABBYNZ+mrXB0jju86xd7VcxW=WU3vO=sK1vL-N5QRbXuQvEguQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] src: add HMAC-SHA256 to bt_crypto using
 kernel AF_ALG
To: Pakrohk <rhpcir@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	Pakrohk <Pakrohk@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pakrohk,

On Tue, Jul 21, 2026 at 10:17=E2=80=AFAM Pakrohk <rhpcir@gmail.com> wrote:
>
> From: Pakrohk <Pakrohk@users.noreply.github.com>
>
> Add HMAC-SHA256 computation to the bt_crypto library using the Linux
> kernel AF_ALG interface. This follows the exact same pattern as the
> existing cmac(aes) implementation.
>
> The HMAC-SHA256 function is needed for verifying external quirk profile
> signatures. The previous implementation used popen("openssl dgst ...")
> which had command injection risks and an openssl CLI dependency.
>
> Using kernel AF_ALG:
>   - No external library dependencies
>   - Matches existing BlueZ crypto patterns
>   - No shell invocation or temp files
>   - Works in bluetoothd's process context

Well I guess kernel crypto doesn't want us to add new usage like this
since AF_ALG is to be considered deprecated, even though I have to
agree it is much simpler and probably safer than using an external
crypto library.

> The hmac(sha256) algorithm is available in all modern Linux kernels
> via the crypto API (/proc/crypto).
>
> Signed-off-by: Pakrohk <Pakrohk@users.noreply.github.com>
> diff --git a/src/shared/crypto.c b/src/shared/crypto.c
> index cb99116..f5883bd 100644
> --- a/src/shared/crypto.c
> +++ b/src/shared/crypto.c
> @@ -69,6 +69,7 @@ struct bt_crypto {
>         int ecb_aes;
>         int urandom;
>         int cmac_aes;
> +       int hmac_sha256;
>  };
>
>  static int urandom_setup(void)
> @@ -126,6 +127,28 @@ static int cmac_aes_setup(void)
>         return fd;
>  }
>
> +static int hmac_sha256_setup(void)
> +{
> +       struct sockaddr_alg salg;
> +       int fd;
> +
> +       fd =3D socket(PF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
> +       if (fd < 0)
> +               return -1;
> +
> +       memset(&salg, 0, sizeof(salg));
> +       salg.salg_family =3D AF_ALG;
> +       strcpy((char *) salg.salg_type, "hash");
> +       strcpy((char *) salg.salg_name, "hmac(sha256)");
> +
> +       if (bind(fd, (struct sockaddr *) &salg, sizeof(salg)) < 0) {
> +               close(fd);
> +               return -1;
> +       }
> +
> +       return fd;
> +}
> +
>  static struct bt_crypto *singleton;
>
>  struct bt_crypto *bt_crypto_new(void)
> @@ -159,6 +182,16 @@ struct bt_crypto *bt_crypto_new(void)
>                 return NULL;
>         }
>
> +       singleton->hmac_sha256 =3D hmac_sha256_setup();
> +       if (singleton->hmac_sha256 < 0) {
> +               close(singleton->cmac_aes);
> +               close(singleton->urandom);
> +               close(singleton->ecb_aes);
> +               free(singleton);
> +               singleton =3D NULL;
> +               return NULL;
> +       }
> +
>         return bt_crypto_ref(singleton);
>  }
>
> @@ -183,6 +216,7 @@ void bt_crypto_unref(struct bt_crypto *crypto)
>         close(crypto->urandom);
>         close(crypto->ecb_aes);
>         close(crypto->cmac_aes);
> +       close(crypto->hmac_sha256);
>
>         free(crypto);
>         singleton =3D NULL;
> @@ -1005,3 +1039,35 @@ bool bt_crypto_sirk(struct bt_crypto *crypto, cons=
t char *str, uint16_t vendor,
>         /* Encrypt sirk using k as LTK with sef function */
>         return bt_crypto_sef(crypto, k, sirk_plaintext, sirk);
>  }
> +
> +bool bt_crypto_hmac_sha256(struct bt_crypto *crypto,
> +                               const uint8_t *key, size_t key_len,
> +                               const uint8_t *msg, size_t msg_len,
> +                               uint8_t res[32])
> +{
> +       ssize_t len;
> +       int fd;
> +
> +       if (!crypto)
> +               return false;
> +
> +       fd =3D alg_new(crypto->hmac_sha256, key, key_len);
> +       if (fd < 0)
> +               return false;
> +
> +       len =3D send(fd, msg, msg_len, 0);
> +       if (len < 0) {
> +               close(fd);
> +               return false;
> +       }
> +
> +       len =3D read(fd, res, 32);
> +       if (len < 0) {
> +               close(fd);
> +               return false;
> +       }
> +
> +       close(fd);
> +
> +       return true;
> +}
> diff --git a/src/shared/crypto.h b/src/shared/crypto.h
> index d85f807..6b234bc 100644
> --- a/src/shared/crypto.h
> +++ b/src/shared/crypto.h
> @@ -62,3 +62,8 @@ bool bt_crypto_sirk(struct bt_crypto *crypto, const cha=
r *str, uint16_t vendor,
>                         uint8_t sirk[16]);
>  bool bt_crypto_rsi(struct bt_crypto *crypto, const uint8_t sirk[16],
>                                         uint8_t rsi[6]);
> +
> +bool bt_crypto_hmac_sha256(struct bt_crypto *crypto,
> +                               const uint8_t *key, size_t key_len,
> +                               const uint8_t *msg, size_t msg_len,
> +                               uint8_t res[32]);
>


--=20
Luiz Augusto von Dentz
