Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652175;
	b=ASbondu8DtxRsQqgInc2tgh6rZnu1ZJDvYYO4HtQ4Ui7RPABdVow3Ea4vdOJ/6FMNX1O
	 dtktU1uKOAmiZ/fJcHQLVhifET1xlpi2TbO9Tc9e/TRUpRIfBs/qf6UkCExHiG0v24487
	 +u8pBpldKjYjA58zaHiF84cLyw9VOJVp4+f1M+xFSRLMWQ7sWDDkqZBtIg+/8fSmghzat
	 g/X4817eF7i86JAW9NCwrmrINfI7ySbttZtQPpdsQBP4xPYGanlnqKl/lTQyhTRMC1bk7
	 e0zNAUkvL5hDJra3qAFrWVYCZENKFxr7k+d/hkhwaplDDWmLL8yXptUBkY5pz7kqs0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/QLI8mJYFnXRVSxZ2KQLYsglmS3jX9PmCrZKy4kv14w=;
	b=w6qjR0OeovMJaDSr04D3QIHxYHInH2G0WBa1gGLj0QEskzZzqUz+DhmrFs+6iIjF+rQH
	 7MjOAKPzETTtz7ve94YIdPbTimiTQLwNSQyzIGFy3vsX01GbcuKj7O4t5s25yGXhvpAEI
	 GcBp0MneCzpAcqxMlA1nwZYZ/A+ryM8mlDtzDnE2Eb/mfO2RnCIJ+aAzTntgGvaxZG6R/
	 6LGecGqpiZZAe2gOXYInmxpdFjpQLTjEc+UadWfZHNniltUenx27o2KT8UvPsn0/XHVrr
	 weK7jS/6WwxopqsMrck6oyjUy8xlG+hoCToYwfGcQsuwu071K+qG3m9SRblVw/oLCIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tqAWcKvi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC152606A327
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 20:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC152606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tqAWcKvi
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ab38a051aaso35108897b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 12:42:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652174; cv=none;
        d=google.com; s=arc-20260327;
        b=jXQLdfYuamWvSTsHCzdSJwI6fVxSHYf+uf5A080FHVV/S2fH8i/i2Q9mBk52cIm7c5
         RC/QPjBg+bUUYmg8dALKSNtAo2NA9PaXU2xuexvbhkLZH22pjH1iX/UcJTcZvDYt1a4q
         IhOFzsYxIZZzNc5LnjG2spJzTZlmn//aT2MMf3QA0kdtEyvaTzQSR6WryH6nPxkzRmGP
         voDPod4dBN0/Gx8Oh5K8Z1lNh4cfITXxhCbZTZlQYr69/NXfMJP8iysBA1dP6oLms3HO
         nV8izbekEnadvZ40LBe5au1uw0JvCuLJ86ehfTJBW55sOR2mIIP/msfZtRalMdaMwsAI
         NtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/QLI8mJYFnXRVSxZ2KQLYsglmS3jX9PmCrZKy4kv14w=;
        fh=Qcul7Qb9Ws+gm0aG81888SKudUNFFW0RiNvt8B1QGyg=;
        b=gBIibsNb70/KZUosmHBxBKWpi1sSr/dbb4YoScBuVPGahrM0M0tdgPOKF/anxxOiJ0
         f/3gH4MGc7ZWUMybtSh/fPpMZbEBU9wt47YQ3Ks9gdQe4jlN2ps/HDAbKupLeb5GRW2f
         aFgH+3Eauvdpee8XBvWorbcAwqfwQYOMg5pwGaozGCEK2zYGISulQNSSYb1AANqUZMbZ
         ktRsFiWCsuQVZBpTDA0C1h0cpcIuSExtsEStsJJx7ekKGt4XTDCpGsNSqKV9E53ghrY4
         ava5n6Zua3/OahB2dEpNJBo0dEMqHQRr6UBOgHk8ny3f1npLsioeYQKJJzpK71qyR2UL
         AHcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793652174; x=1794256974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/QLI8mJYFnXRVSxZ2KQLYsglmS3jX9PmCrZKy4kv14w=;
        b=tqAWcKvi01iaz2VcTj1SEyKzhY30jMQVNBKNd91ir6stqSQxqnZGOu9jBrJmff0B4u
         9mfeW4pn623QOXd8MueU52xkfQPx8Jpo2Mt3BMIHjk7YA04lboch9jZKQXOXrsiR5u5s
         xCxXRL+hXLZSIedK22FIVu6wymC33gIw1na03e+pdk85T59gGxc+A5zwdYHukKYquGky
         tUo09uKLyNTaO9DtVqpuF8NlZMchceG1WM8ECeajUUO2kjHPZodmUWc5Kqp+GitqcqR4
         rc6j0xPgfybQMo0csnpGYEJSxmZa6twyBkxL4vJSpggcpqjC4I5HlYlmH5EMchtTH6Ey
         oUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652174; x=1794256974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QLI8mJYFnXRVSxZ2KQLYsglmS3jX9PmCrZKy4kv14w=;
        b=RrVHPI239h6kFaxrkYxoINobWVI57PY5X7ssLrT2TxE20/rbTAaJS6Z7fHV326+x/y
         1JJ+ATV3JjwK9GhWsoMQ+RU9VUSs+tIGtiSMx2tRZhQENyZKToJ2xboXAStXDL3fTJzH
         eXtA1B1Wd+hiVcAsT0WAm2RlrJZzsOOW5I200z4QFqDDDPC5Hv+YtqNDOSr60kocT1YX
         v7yd3q6uwn88USORZv0sQ7gbUIb+3Bode6IW2t9jn65XuSIu1ERP0j543kXvkuz9O/h4
         pza7M7NH2+ILhf92enEK8+MbfX++BOEp21cV92Gb2JhkLLn/VqTUN6ztVxyHvmJyBZa0
         zC8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwOD0oEDBN1CLiwz30rlw6PkenOKav/py9LuoEdfFDmwkVoFUe5yE3arU18HRLge6Jss1oTz5v9iLfmvGGzUAU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ng0XpOesj/qApgpBoEz2CxDW7bsbEEnfz2CQzerPShpNnlkhs
	CrRGaGhz8rO586UmFJn9MPr1BRB/sEP7nxS/19vsbtv+YT9EjcAxI/u/qYwDQXwjPpczzy7Y2rz
	lCKdvO6JC/AJNGzSyDDx9ITtJ/9A+HGPxE0lL
X-Gm-Gg: AYBFou0NdWHqKda+4lAdhc5sHdrVdHLZfzDs74NIFju1/+voaB53ab90XTx01uke5gL
	ZNZ47oOs5FIWrb2qrdtrHCmFIFxjYQXELuQ/ddyG/gWp//2nU1AFQLdp9UclciCkusbagi5j/0P
	WxCLbcItqR8iJWPVpLI7xi7KgZj7gF6vUtjm/TTswVJH9j4Bde5+hOR9kLdLBa1isE5c+OSFxL3
	lOMpCjt67dUFO5XfvLn0gdrYmeUYzIsTd2EmK+vZYtlyMEEOMTsrzwSbic6+0hdEgHdFB0r6VO0
	Ut25MYVm0yHpRaySfdsJeYKTJ/+KbUfVtdelIAdCN6MVcNOLx9mN4IPKtIXApbakxLSp0RyUYtq
	co8YcHjDQr5lZ/JMljFCCMMvN873WhRUj7AakdmqnBWwwJQ/0TUkx2vBp5YSAO1HAAqbqOTBBhP
	dVkgS3a7nftia3IfkW4mah6HyML0SWx95gkTkxx7XpcMe7Glx2iAdpO81M
X-Received: by 2002:a05:690c:6602:b0:8ae:dfee:cd30 with SMTP id
 00721157ae682-8b2b6798d15mr84579077b3.56.1793652173493; Mon, 02 Nov 2026
 12:42:53 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101-for-upstream-le-conn-params-rpa-v1-1-988629a09bc9@podgorny.cz>
In-Reply-To: <20261101-for-upstream-le-conn-params-rpa-v1-1-988629a09bc9@podgorny.cz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Nov 2026 15:42:41 -0500
X-Gm-Features: AclHuK-CPNGDsNR-b_xddiTj6w8veiNPQv8o9T2cZKCI2JUnLIv-tAla1SNVBM0
Message-ID: <CABBYNZL4Ab4CYiQg7ZKnn0WZR8B63GqnazqGoUz9nRFQTwJvjg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: find an RPA peer's connection parameters by
 its identity
To: Radek Podgorny <radek@podgorny.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radek,

On Sun, Nov 1, 2026 at 12:20=E2=80=AFPM Radek Podgorny <radek@podgorny.cz> =
wrote:
>
> hci_le_create_conn_sync() looks up the peer's connection parameters by
> conn->dst. Those parameters are stored under the identity address, but
> hci_connect_le() puts the peer's cached RPA in conn->dst, and
> __hci_conn_add() no longer converts it back when the controller cannot
> translate an identity address.
>
> The lookup then misses, and the connection is created with the
> controller-wide defaults in hdev instead of the peer's interval, latency
> and supervision timeout.
>
> Resolve an RPA to its identity before the lookup, as
> hci_connect_le_scan_cleanup() does. The other lookups by conn->dst run
> after le_conn_complete_evt() has resolved it, so they are not affected.
>
> Measured with btmon on a BCM4345C0 against a bonded peer that rotates
> RPAs, with stored parameters of interval 12, latency 0 and timeout 600,
> over six forced reconnects each way on v7.3.1:
>
>                        before          after
>   requested interval   30.00-50.00 ms  15.00-15.00 ms
>   requested timeout    420 ms          6000 ms
>   link interval        48.75 ms        15.00 ms
>   link timeout         420 ms          6000 ms
>
> Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air whe=
n we cannot resolve")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Radek Podgorny <radek@podgorny.cz>
> ---
> This is the follow-up to the on-air address patch that Luiz said could
> be done on top:
> https://lore.kernel.org/linux-bluetooth/CABBYNZ+5zV8xzhHZKTUQYT4tLHaZAO7i=
iKOEsKuT8aA+YNLjPQ@mail.gmail.com/
>
> What this does not establish:
>  - tested on v7.3.1, not on bluetooth-next; the patch applies to both
>    and bluetooth-next was only build-tested
>  - it shows the stored parameters now reach the controller. It does not
>    show that links are more reliable: all twelve reconnects succeeded,
>    with or without the patch
>
> Per Documentation/process/generated-content.rst: the patch, this message
> and the btmon test runs were done with the Claude coding assistant
> (model as in the Assisted-by trailer). The prompts asked it to fix the
> lookup miss named in the on-air address review, then to measure the
> result on the author's van, with and without the patch. The author
> directed the work and reviewed the result.
> ---
>  net/bluetooth/hci_sync.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 9d829c20c31604..810d6f5143342a 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -7018,6 +7018,7 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>  {
>         struct hci_cp_le_create_conn cp;
>         struct hci_conn_params *params;
> +       struct smp_irk *irk;
>         u8 own_addr_type;
>         int err;
>         struct hci_conn *conn =3D data;
> @@ -7057,7 +7058,16 @@ static int hci_le_create_conn_sync(struct hci_dev =
*hdev, void *data)
>
>         hci_dev_lock(hdev);
>
> -       params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
> +       /* conn->dst may hold the peer's RPA, but connection parameters a=
re
> +        * stored under its identity address.
> +        */
> +       irk =3D hci_get_irk(hdev, &conn->dst, conn->dst_type);
> +       if (irk)
> +               params =3D hci_conn_params_lookup(hdev, &irk->bdaddr,
> +                                               irk->addr_type);
> +       else
> +               params =3D hci_conn_params_lookup(hdev, &conn->dst,
> +                                               conn->dst_type);

I guess this could be incorporated to hci_conn_params_lookup
internally, so we don't risk other part of the code missing the params
and any address used, RPA or not, should resolve to the same entry.

>         if (params) {
>                 conn->le_conn_min_interval =3D params->conn_min_interval;
>                 conn->le_conn_max_interval =3D params->conn_max_interval;
>
> ---
> base-commit: 42b8c2d729268a65a2d98064e8dc59ff53646b14
> change-id: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7
>
> --
> Radek Podgorny <radek@podgorny.cz>
>


--=20
Luiz Augusto von Dentz
