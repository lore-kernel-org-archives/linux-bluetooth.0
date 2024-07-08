Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA89461
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451879; cv=none; b=Sorwh50cRhzgEmf+s2xE4hObyqMgPNWUZPOuFwhqS/+dn6a7iNfKTGIjxrcKkeJujV52DWVRVtn52Ga4CvHOb8BQaUExhRSXubYrOBU3TIgPGZmecsgZjg1wOkm1+Gj7sZqlMD1mKxUHNdw6zMjxxkefsFsUIjBd0SU+Dkz5qjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451879; c=relaxed/simple;
	bh=RxA4x0ZPnCE4BsxkdNXQRsJ3lDT7uNVRtL/3T0SGtsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pep/hBBZyrDjlSy0cwxt3g15Sq4RNTSXlhqPLoflxK94+ddLRGGRVJVbLoib6wZ2IE3QIvm50gfXnwgTP1RGEFLG0nFfIRICP2jCdz0aLDlEbuqnZkPvP+w9TQEttcJQhIttLkXw7k2EHv37lB9ccmVB45QSRqq/18rZeUA/wCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cG6QUp+N; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG6QUp+N"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee817dac89so46221921fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720451876; x=1721056676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psAfcI9A/KxXP6KAKCcOyfo9i7jrjLyOAA4SO+RpVzU=;
        b=cG6QUp+NWU3oS+0Ee6QbGU6Ct5zvBj7kH7UsmqwevVWJQbPkuZEtrhDJpg9tbKLzgr
         xX/XJqixKpnIKUKQt+8vKEBe9fVlUVgcUxpdYAUl4CQ63HEgALB4D06c310sbGCeQOhQ
         G35qwz+xrGCn35luzefJm2T4EyK/xlAy0KLRLLymUWb6RinraLLjN3qYqhsPPY5z2rNN
         9DVmeGvcXzFJHHj4HTupdQi0T2NiiTbHRM3+KcfYVnQwJA/r9VpoftS2L6Kzbgr//Lrj
         5rGn1bYn/fySuYakbvBIwbRqwx1RGx37EMgkC8gkGXJsJoemf9QyTp72d2Qjhv1XComa
         1xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451876; x=1721056676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psAfcI9A/KxXP6KAKCcOyfo9i7jrjLyOAA4SO+RpVzU=;
        b=eCYzS99NAQ7dOVhInfuD8BGqqzdDYAamMf+ednLF6gN1W+wPTRXBso/mdmjoD1N2Zt
         HH0ui3YiEJciuXbtytGt/aFvT/UWcMzsHjEfmG/8Uz4rhhNZlxAmawLn2cIzdMTj8+8X
         cy1cj5JvyTKI8EiMZX2c4s1/HFHoYJdu6bOhqhaCxDk+lWhRdZ+7szMBJa8KETcpbZ2s
         x1vfVFj7VAt5wf2YGnKYEp0tMugc5T+pHZepKmvpX6RHeWSc9laLD8K0j8JFuFkXVVXj
         BMKwQQRcnyt/JI+/DlUJf+MTB7bwHX7+zyjhfEU6n5n02SsqcadBOgZNFO6aN+rHZmM/
         X2yQ==
X-Gm-Message-State: AOJu0YyIkXiB3jbQzGaMg4Fwj/VK9HYYxbQoxEGr2mUSquxyBVHVD2NK
	O3yqZ98zqmzH5Rzap+2LjoJ4niT4o+d+7k/Ocmu1Il8ttOitbi82K8zVX1fCnu+qRe3S68qLRXw
	qOXB5KKFQQ3fasditAGdeVl66ZAJCJg==
X-Google-Smtp-Source: AGHT+IERfSZI7+CB+zkLpcnMnosFwus7s/45F2kpgZtfzVSwCApeG0jlLkj/oUgMLLOrqreg5GLHP/bX1VJZMhZWXuc=
X-Received: by 2002:a2e:8183:0:b0:2ee:7378:2d58 with SMTP id
 38308e7fff4ca-2ee8f2f2c1cmr41428001fa.19.1720451875968; Mon, 08 Jul 2024
 08:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705085935.1255725-1-hadess@hadess.net> <20240705085935.1255725-9-hadess@hadess.net>
In-Reply-To: <20240705085935.1255725-9-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jul 2024 11:17:43 -0400
Message-ID: <CABBYNZLot6GBtvSGLyn_+wtk6RVCO6OuS23VoVuVcxMYLvaeog@mail.gmail.com>
Subject: Re: [BlueZ v2 08/11] gatt-server: Fix integer overflow due to cast operation
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Fri, Jul 5, 2024 at 5:00=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> Error: INTEGER_OVERFLOW (CWE-190): [#def25] [important]
> bluez-5.76/src/shared/gatt-server.c:927:2: cast_overflow: Truncation due =
to cast operation on "((unsigned int)mtu - 1U < len) ? (unsigned int)mtu - =
1U : len" from 32 to 16 bits.
> bluez-5.76/src/shared/gatt-server.c:927:2: overflow_sink: "((unsigned int=
)mtu - 1U < len) ? (unsigned int)mtu - 1U : len", which might have overflow=
ed, is passed to "bt_att_chan_send(op->chan, rsp_opcode, (len ? value : NUL=
L), (((unsigned int)mtu - 1U < len) ? (unsigned int)mtu - 1U : len), NULL, =
NULL, NULL)".
> 925|    rsp_opcode =3D get_read_rsp_opcode(op->opcode);
> 926|
> 927|->  bt_att_chan_send_rsp(op->chan, rsp_opcode, len ? value : NULL,
> 928|                                    MIN((unsigned int) mtu - 1, len))=
;
> 929|    async_read_op_destroy(op);
> ---
>  src/shared/gatt-server.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 66e370d1fe3d..e0e1776779cd 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -908,7 +908,7 @@ static void read_complete_cb(struct gatt_db_attribute=
 *attr, int err,
>         struct async_read_op *op =3D user_data;
>         struct bt_gatt_server *server =3D op->server;
>         uint8_t rsp_opcode;
> -       uint16_t mtu;
> +       size_t mtu;
>         uint16_t handle;
>
>         DBG(server, "Read Complete: err %d", err);
> @@ -916,7 +916,7 @@ static void read_complete_cb(struct gatt_db_attribute=
 *attr, int err,
>         mtu =3D bt_att_get_mtu(server->att);
>         handle =3D gatt_db_attribute_get_handle(attr);
>
> -       if (err) {
> +       if (err || mtu <=3D 1) {

Also pointless here if the mtu is 0 then we should not attempt to send anyt=
hing.

>                 bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, =
err);
>                 async_read_op_destroy(op);
>                 return;
> @@ -925,7 +925,7 @@ static void read_complete_cb(struct gatt_db_attribute=
 *attr, int err,
>         rsp_opcode =3D get_read_rsp_opcode(op->opcode);
>
>         bt_att_chan_send_rsp(op->chan, rsp_opcode, len ? value : NULL,
> -                                       MIN((unsigned int) mtu - 1, len))=
;
> +                                       MIN(mtu - 1, len));

And this is incorrect as well, we need the mtu of the channel here not
bt_att_get_mtu.

>         async_read_op_destroy(op);
>  }
>
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
