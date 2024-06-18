Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B02139DA
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724210; cv=none; b=Dop9PbGLFGvEqyYa4LFaHxA+sjo63KYwHFW8fzMxCVpl/QE9MGe8y0cWhpEKqpIUq7g/dhnaIgc/RhQGedb6f29bJoQzGJEksO6x/SmaBLFiJxTioS3b4vGPK4EpPGvQMd7wfSSpTlx2bn8jJ3bUAjmmhueghfEDAlSUkzb44QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724210; c=relaxed/simple;
	bh=8f7CZjGdDg6QlT+MM67DVYhdy2cHPd1iQ6+zS30CHhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDjIAwtzw1W91AT/pwVp9oddU5l9jnLR3suisGzLCgKrvryxetceUKnHF0Wjl9Ta96iEEyp3p06q5Vm3EtWq2GYPuyy4ZGYuAufBHfsB+V9hUpzm7aimWTTt7JZxv0TgHfB/ogCuA0H7XFoFSRpRvlMOSyTSCN7PJSc3Lz1fg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL+GUhcb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL+GUhcb"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e72224c395so56900521fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718724207; x=1719329007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PFAD5KYWYUmG6jGt3O/qtsgBdxBi1U5ZL6l97w8Vv8=;
        b=JL+GUhcbDX3OORkGZTeA9QQ8oa+MeBhvo7purjRf10hG8q+hFuMtcZkAwIdDEd98Te
         B9jXB8LalmCUZEcoxnBK+BVUL1AOzexmwZNzPTaOlW3OAQohDTcjuMaW85CCqMrgUuU8
         rTzaUhaTi9JWNCvskquuGAJ4nFSPBKmoVlQhuPs01r0cJBM9fMCIq1KZF3tchr5yRQHo
         b1ZqcM68qAAXtHLsy5c+KXXZZYtAS5nlioL99vTwhpkEe+hJQb/RrsnJayECHXhLuYss
         +aK0jlkMe84LilgVgwJLprVNIYoLTdWu/AfsaxR3GcJwLmU9JjDX3na/c/e4PEtrolpb
         +M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724207; x=1719329007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PFAD5KYWYUmG6jGt3O/qtsgBdxBi1U5ZL6l97w8Vv8=;
        b=PecNhU2j6O6d3/CmkvuV0Td8CL4y6OiT7CqQ+oOmbPa+z9i6/bsQA1s7B3jCzDeRLH
         KITGCqKQhrZfyFqbSmTXO7yRy3lUtnASbMsmk3qQLTqwf2LXuTjnZ392VRsfgT8WGJix
         vIDm+AjN8vzVfatHcoAM4BK9HUf1en8vZ844obHIGgwumbs7HsjqzeNjld++U60T1JuT
         OEUkld6QWqvD1tFWpNuL+G8lRDMvtVVcD9oC/ofgYnks2VWPTckPpJzF7XA9wRBtScD1
         +OSLSg9eQxcNq5nOBHm/JxUIL8uM259zGhYib/jRNUIFQ4/ehs84yqhTyi2C+6gY6qEp
         cyzQ==
X-Gm-Message-State: AOJu0Yy+EAI24AU9mxtID1WJ+zWKZhUInxhD9DL7QF5vSaSOtjdjfpxF
	jz1trZ/Bob8w+4o3jpBq6XrMqnNZqPWInq8FsfYYMEkltcs3BJjYq0Qn+d5dOgc8yVgvvGqrat2
	TPEbpFNDER7j9Ey7Zq1rq+3Zp6Jb0Ug==
X-Google-Smtp-Source: AGHT+IE3lus8eNskRCuyFCFC3ne31nTQDbvXjIJf6xHrp8EtIfdE9eV7IgapgVGceMeykiN0hbpN4xtAIKT691rU/Mg=
X-Received: by 2002:a2e:9245:0:b0:2ec:b0e:1cee with SMTP id
 38308e7fff4ca-2ec3ceb8e54mr1373711fa.19.1718724206674; Tue, 18 Jun 2024
 08:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618085823.30798-1-vlad.pruteanu@nxp.com> <20240618085823.30798-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20240618085823.30798-2-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Jun 2024 11:23:14 -0400
Message-ID: <CABBYNZJeqg5yHUZDO7j_5awbgagf7fu47zV0gVmK2PkVBM539A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] bap: Allocate memory for broadcast code
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Tue, Jun 18, 2024 at 4:58=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.co=
m> wrote:
>
> This fixes segmentation fault caused by trying to write to
> unallocated memory.
> ---
>  profiles/audio/bap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 53e7b3e34..3d249a4e4 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1041,10 +1041,12 @@ static void create_stream_for_bis(struct bap_data=
 *bap_data,
>         setup->qos.bcast.packing =3D qos->bcast.packing;
>         setup->qos.bcast.framing =3D qos->bcast.framing;
>         setup->qos.bcast.encryption =3D qos->bcast.encryption;
> -       if (setup->qos.bcast.encryption)
> +       if (setup->qos.bcast.encryption) {
> +               setup->qos.bcast.bcode =3D new0(struct iovec, 1);

I wonder if it wouldn't be better to add something like struct iovec
*util_iov_new(void *data, size_t len) so we don't have to do this in 2
steps?

>                 util_iov_append(setup->qos.bcast.bcode,
>                                 qos->bcast.bcode,
>                                 sizeof(qos->bcast.bcode));
> +       }
>         setup->qos.bcast.options =3D qos->bcast.options;
>         setup->qos.bcast.skip =3D qos->bcast.skip;
>         setup->qos.bcast.sync_timeout =3D qos->bcast.sync_timeout;
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
