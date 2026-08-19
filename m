Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A93AEF55
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156467; cv=pass; b=n2VNZKHS9CzUmgK+vQiq7CWzjrVKYrtM42WkM51T6xN/BR/CS14IOgPcA/vanruLMp3SRTqADQr40l7p3UPQGexs3plxtyoEPTEttDi8bv17L2Sr3O1eGmHCquJmFQNumRxyxqhUR80XnApJR9sS/7TEl063DuV5aKm617bQEyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156467; c=relaxed/simple;
	bh=7m8VXYeB9OpD8Nsd8xAsp0vdhWVMnTy2Uk/uWxDSkYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duu7URS7wTTPqQxX2LJVHGcUI1xDdVlOEnhDhMp6iFW8UJhyNG1PAzmFH9edXEbS8idULh/XjdcJZpwlca2iORZ8pbOLszCouPJyjc1RzuEBWBzaIPyi0Y84H2JEKpKAcGhedvLqrqeP/v4n/p9SYxYwFmshFHRDhMHqBqKCaBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgiE74hr; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgiE74hr"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836ce6cbe1eso19344077b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787156465; cv=none;
        d=google.com; s=arc-20260327;
        b=DF8rxriD4DAmYZvBiYxaJMVpdLX1XeSiOQ7GY8OirjnVChbE+PG7K5V1Cz4Z/wGhcr
         d6RQTml2vy7kXbUtlArgO4zkQ7kgO75kuqPL/6urEO02ksa0NogCCl2x462AN+lwW3Qm
         ECcWfkZFEWlgjdhfX+Mb0QrOZCITX0ULk+9QrcgfOV7WUwURdXx96FahMYlsJA3lKnjz
         FLOA6dQTiY7hP4oi7dEdxj+dat9HbSGO78Hp/pC79kowtvr226RpCSBdpttg3iucjO0T
         ZmJiRp5KreuhhT6BRqKXzvUS6I3rVz5pig1WOHpBsNlZqi3u0/JLnUOmHkrx4J42j8jX
         2EjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2YNqI+yjFdhnNUGgs7nsz5NAKMG1HDIJc25Zeyp/Z4=;
        fh=iCN6Yvulx+G3tJ+JPEjqPYPd+8Vdgenie90mkDmcUe8=;
        b=XnmDdZ2XIm+95nkdRcq/qas/mBH56CEcUe2b9HfPriSDhnW22083OO+rDBbGfJG8G2
         skOtScPDinaY6ljz0otV664828gz4F14WR3B6TDuxWnAiug9P4X/uTOJFjbHSA3pqhRI
         kANjG1ab97/CQ1VH/Jb3MWkkeNA/iT1ztsOPxx3LHYzULgTTtxJQ5aM1qiyH3/WLgdmr
         pTgctSvAjLFECtxbv9L/iODZZdqKPJiCL8tDbqzstY+CxZXW09O5sbES7/B0S+RzAcuk
         6va0vPt4rO2qJgxYmuE9K/zBy3RsTEYFGy8u7gsK7gcXMfswFxDHf4OzpUoCnc5lSOHc
         QXWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787156465; x=1787761265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2YNqI+yjFdhnNUGgs7nsz5NAKMG1HDIJc25Zeyp/Z4=;
        b=rgiE74hrvV65R5h6/76tYlDCNmj/5agBYBBrvKyTvVRyGuiw42YHswrfblbB3PXyBa
         efbuxsa1cb3o7cM5pkt3TJthi2nbKT5lwq4Xma6Xup7nYyfq8hV1i6ad+UxZbrPb/32Z
         mOpduxx4MpzrXT2o55z90/zIHldB+szlLme1yqe5opFDb0KsFjli0tLrMm/AixNxUebW
         NuuHQCAJHoJpgv4DfmfBHsbAj4oy0Ir7G5bQuzmhWYBYU2bvXrx4TCiSOqmE9KiwXQK3
         GoFPPNraOeaDXmeDlORrA2MkJ/BMC9UzkVU0wQZbzgQnyS1oTSIGeFSzWMhH4YJOawqA
         YRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787156465; x=1787761265;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2YNqI+yjFdhnNUGgs7nsz5NAKMG1HDIJc25Zeyp/Z4=;
        b=PT8YKbk6CIaXJtuKspiXxIY+dcNjj/i7HOet6N2LL6/UQeLI4Q9w05mKfeM4UH7axQ
         AkEF1EG103RiIWMIj8i5zQS1+T8tinuMRd6uXIyuYhRvhFt1VE33/qrH+gDdYaq9lRHn
         r5509B5qLzVuHEAPUtsg07srcUwbnmUEULGleH8e3oh1186L2K4hrIZte44OL7OnlC2+
         u8cW0z+ibyUrClioXiQtVqS9S05fSTivtsIKklAuPcl7sLVTZ0QeKbnWAgZknYXvCkAo
         WLzPdflHGYKZkdtS+lKlsMoER/lgyJzU7JMmgmd6aExzKlN8OYTzmo/A5ZLCgREMtbGi
         M2Nw==
X-Forwarded-Encrypted: i=1; AHgh+RqxsktfebL/9+hPD0j4IyD7NcG+55X8cehPxQmGMbhJ3vxTxmaL7+v9ds/2nMxDLJsjRcBbkVI0svDTlj/tl8A=@vger.kernel.org
X-Gm-Message-State: AFuF++m7YUdWzjFb/YJtTLsqNsHcBtKZec2KclOyR8eop0/6mj0NVYER
	NER/kCkXNlB0nwUIoj+Q0qY5Udhdp2MBrD0OA0G6ke4DQ0BcKjQfai/uZ03m2ND5uuc+4sEv9B7
	+fTFn4ffcpg7tddtIrp4J08VMcdEg73A=
X-Gm-Gg: AR+sD131oavOjpy8e4dpMMS5qkYJfjxtakejqitF30CnO55QiYiHwGr+St2PgSz03Su
	qNH03GIaLUvqm6uctLA6f+5ffalxS1oqBvepBakBW+ReF9tZ9YSiESP8vUTijnmFAkv/34lizCK
	wNMcRcD700fNyfF4/AmZL1w3EULIr8yWgbdj4vAvK9oHxdJCXLBzL8Ker4b9cb0s+JcHhGBtvap
	6SNkSggC502HdSs6u/1df6L5Wa8TvcrasMVIPrgUruvup6iY6GIziusbrCiClI33Y+v1f232Ekm
	quBb5uRiz97E3LPbQ7vKl0CNwZWQz6ug8X8w/sSWKBb4W0qS9fk049557FkRvOPc0Zar7jMhxY8
	7PCQdcCQQwVrAVde/HCHzZAXbMgbx
X-Received: by 2002:a05:690c:c630:b0:7b2:1bf1:8016 with SMTP id
 00721157ae682-844dd14444cmr22494967b3.2.1787156464978; Wed, 19 Aug 2026
 09:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819064115.2449018-1-lijun01@kylinos.cn>
In-Reply-To: <20260819064115.2449018-1-lijun01@kylinos.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Aug 2026 12:20:52 -0400
X-Gm-Features: AcwNN1WsCdi1WGEsaYhNl1e74CnX05dGw-1-_FS4h2yZ_1abo7De57EdI-8Zju0
Message-ID: <CABBYNZ+ui5j6cum42s8pxnZYewZ=C4Bi0ihUXkrQyMrsKJMbeg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
To: Li Jun <lijun01@kylinos.cn>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Li,

On Wed, Aug 19, 2026 at 2:41=E2=80=AFAM Li Jun <lijun01@kylinos.cn> wrote:
>
> use SIMPLE_DEV_PM_OPS for btmrvl_sdio_pm_ops,and add the value of
> .freeze .thaw .poweroff .restore.if these address are null, may cause
> error in s4.
>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_s=
dio.c
> index b91fc63bc9fe..197237e78a3c 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -1726,10 +1726,7 @@ static int btmrvl_sdio_resume(struct device *dev)
>         return 0;
>  }
>
> -static const struct dev_pm_ops btmrvl_sdio_pm_ops =3D {
> -       .suspend        =3D btmrvl_sdio_suspend,
> -       .resume         =3D btmrvl_sdio_resume,
> -};
> +SIMPLE_DEV_PM_OPS(btmrvl_sdio_pm_ops, btmrvl_sdio_suspend, btmrvl_sdio_r=
esume);

It looks like we are missing a static in front:

https://sashiko.dev/#/patchset/20260819064115.2449018-1-lijun01%40kylinos.c=
n

>  static struct sdio_driver bt_mrvl_sdio =3D {
>         .name           =3D "btmrvl_sdio",
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
