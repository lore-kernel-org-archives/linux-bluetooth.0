Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570953C467
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928264; cv=none; b=J2yW8Avb58ecAQzVd2osdmZnv6JshR4nEyDU0Eo+6Wqwc5afvzdoUeI8a1SHwAbXkr6T6vzsteCSPU8J92UFqdvb9KhdGq76XZmEKeA4JvWfHSer4Kpt1IZZRmLKTkxZAVQk+uGMywuy8RQc9dn6Gr23pNGsJBYkQ+bNCCLiiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928264; c=relaxed/simple;
	bh=/pEYGv5J9LGh3P5S3DoAnhj6soFr3oajjduf3+o6HLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ktivf5p3ubslruB79pSHhuQ9q70ZQyCgdf+sau9fassTij+RTeuEpAoY/ZKCA3yuDzXeEN+Xl9OWB7M3dzHaEVZD4SDNMV43t6uj2q58XZCP9ogsdsG/rUAc3SOIENNg/wCTI83CpjZk99FgwM3/EvALXLaQhXUWXpBqJ7tANzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkR59QDh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkR59QDh"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so74725011fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710928260; x=1711533060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKLww8Ci/BbD3UE0UuQPCCAX6/UZsF54eeur5DBeP08=;
        b=SkR59QDhva0lzZeGvw7Q5E6bSVcSnVFQUFHzleMFRN7+AQ7GZQxhoaJaAk5tlo1NE7
         Um2mdwjgu4SH84l6TJEVblpFDJ7QEGTTwqWpyKWUcZbLUP3Jy639d5zqSRQy3n3/pEKt
         XgrqSXgYTBL8jIDGakQaulSkL5eOfZliXosCcb30/PGTSiDUqGa/O4YtURuUXzd/af2j
         tpAj2t07FGBefYZgAilIJi7R0Vf0jag1hhS+4RGLRh8K7ynLL9AKs31gu9uRMAhixJmD
         6RTFOnYDUG1J+q41WI821eoUunwpRuiAuQrblzJN4Mba0UesTRK5KDJxcB0p2gcQOWfh
         2T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710928260; x=1711533060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKLww8Ci/BbD3UE0UuQPCCAX6/UZsF54eeur5DBeP08=;
        b=G+lqc6+Gm0ebmAX74r9732JR3wArhb31JKwHmjcvTAeaaeorZ2ZZFrjZTxmHFJ3Em3
         5hGNGfrYCKpikdxyxLnIa2EV/8s2gkOms4XvpDCkOIw+hqpUCXZ8GsL72zRvXivpgpnt
         2M8hDt92RBp/V3u54lOeCTHGeZaGocX3oQ2J0icEFnkMnNlaeCYO1TOT3zgxK8pQ6wK1
         mNYJ8ZQ3E3g8ljiUwcRdrGLlOTBaHy+QiL2zqdCTuDXls7LVGfsJj7Bi3Yy8WtLTGkWh
         MHqzz5GOlIDcHvCSuPkpVJ9/OD9vqGT7ZJHwjlR78r06kEIHNAGkmseNtoRRE22+d6Q6
         rBqQ==
X-Gm-Message-State: AOJu0Yy9da7nuCdsbwV5AL8nQhMlUXzbDihpAqCWoY/eiEFO4/4k0rUw
	D789I+BRKbC3QEucloKAqRv3RxDccmhUyHyfCFHRA9PMGTU/EF0MDsORFkL1ntm9fJ9o9Qhu1mM
	enPVB3GK0aj/w+w54aw1EEgch0nvv6D13pGPBzg==
X-Google-Smtp-Source: AGHT+IF/Tmfkm78f8Wy60y224TY6DxXGb6160o013wvga9QkOdC9zgmLMExS8qfynFyXQx59EgMk/FWlm9iIinKqzQg=
X-Received: by 2002:a2e:9008:0:b0:2d4:5bc6:23a9 with SMTP id
 h8-20020a2e9008000000b002d45bc623a9mr11278067ljg.33.1710928260132; Wed, 20
 Mar 2024 02:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318123712.9729-1-mahesh.talewad@nxp.com> <20240318123712.9729-2-mahesh.talewad@nxp.com>
In-Reply-To: <20240318123712.9729-2-mahesh.talewad@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Mar 2024 09:50:47 +0000
Message-ID: <CABBYNZKvAmb5JjfxkPADED6CQKD+GxsRqLajHX=w0GE+imhCMA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/1] LE Create Connection command timeout
 increased to 20 secs from 4 secs
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com, 
	sarveshwar.bajaj@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Mon, Mar 18, 2024 at 12:37=E2=80=AFPM Mahesh Talewad <mahesh.talewad@nxp=
.com> wrote:
>
>  - As per specs LE Connection timeout is 20 secs but in implementation,
>    it was 4 secs. Hence increased this timeout to 20 Secs.
>
> Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> ---
>  net/bluetooth/hci_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 4ae224824012..06fe5f6b9546 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6067,7 +6067,7 @@ static struct hci_conn *check_pending_le_conn(struc=
t hci_dev *hdev,
>         }
>
>         conn =3D hci_connect_le(hdev, addr, addr_type, addr_resolved,
> -                             BT_SECURITY_LOW, hdev->def_le_autoconnect_t=
imeout,
> +                             BT_SECURITY_LOW, HCI_LE_CONN_TIMEOUT,
>                               HCI_ROLE_MASTER);
>         if (!IS_ERR(conn)) {
>                 /* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owne=
d
> --
> 2.34.1

Afaik this is on purpose since it is the autoconnect procedure, rather
than user initiate connection, so are you running into a problem if
the timeout is different?

--=20
Luiz Augusto von Dentz
