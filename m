Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876A360EC7
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412532; cv=pass; b=jQzrsGMqMC99R6SHDV4B+zFmjxZVFyAEm+Vint3EVkKz45jgLimJGl//Yk0LzJZGpXYYG/1UBKj/2A7RFoZ/MWoPUoZv/nGjR/r52ar75DiUtunpBnr82Qt7cJQkQF5EC3qmX6eic6qrGKEkcyY8xGqoXrBVRtPqW7axXX32NSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412532; c=relaxed/simple;
	bh=2hXSN8NgND6QBHDue5Fkydpp9df7M3UdaglcY7YCfzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfRaC1vYxYGzk64YZbIf4zfP5plUJDF7PXJ72UdcCG4qyOmbjXISPlYvac6xv/KxrJyh+1HrE9vvSGzUNVTnVHvoevjkH8ldbvnWjnv7gp8PMZx7zlqH+903OJscIJ/MC+feEdYRAdUy4DpEVVbnjrI4U/vnpIqrUfXxQQeKMQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIYdtZdT; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIYdtZdT"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-660463977b1so4877418d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 08:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412531; cv=none;
        d=google.com; s=arc-20240605;
        b=hJ3w7YfejGb6nkrv4jEfQpI/To9G7VVUFotV+UbJrvYnu8QJfij50lG0dbNd2dkUIx
         r2XjZtQ64+MEZKzWI76HQOQRBgRXH6oj5vD5daFNm/PVN+R8Vrw5CPP1kAx0Ss9Z2qRz
         1edcOx8qMDWpVgVux0bqiB/wBOXPQfbf62A5Q2L/dkzkImNTEQWxDoj5pIVayqSPUCq3
         nmEa0l/19DHNsj9Mw0husc3BZIwFCvyJKOobILQ6Gb16lwXhiCNCC8w4kycvN1OyqlLr
         czv+/A5KYnr2puRXDOMibFQXreJKiFFnV8Ms4iF9h3wULQOOqUnCw+xXBLtbbOkOXvTQ
         rh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NA6OL4UIXqcHlVS4y4AlNkc6cNibgN+LuxFkyYjT4UQ=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=jcultMNF86FaXn62NSubCc0PPoIJkWJShjm3E0D/LW0E8T5V70y4vpBHrSkLvr1skf
         sjMUn3Xr+t3dSqLB45RKxKkungl0MikKf9KIFI/pZASjChEG1FV3JHCy4jxmD8RLNNa9
         Az21/EeF6SG4Zw6U5UHhVUDsIFRPP4nOIA/W+IA2ViP4bIiixGsLBo7F9h90O+SpKjnP
         9mOv4ZtCkC7RWXVzrXU/WxRiBlR9IH4Ot/cKC+YyPBNCVXxCHKXuZ+FQ4UIWHBYtabrN
         spZwg5YcNx/7H57Mp411CcqtDwBoYFUdcglbdlYJxavy/SqsrRX9rSjrNRyRud5OAlz3
         wHaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780412531; x=1781017331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA6OL4UIXqcHlVS4y4AlNkc6cNibgN+LuxFkyYjT4UQ=;
        b=GIYdtZdTHzHRlfsoWMaob+sI7NBP7hJYrqJwmyTSO0B2l5jHR1juc4oBfSR1u21Q9d
         E36U8F6QSTCvoQEs1NdygotAXGM6RhlMhaSOXE5VFO3IRxdDuXHcuhIWDa2FlOPJLPfm
         wmqc+5FozW+GKDvL+o/cpwrqXneJGQ+2PB/oJi89nIbJ863qcw7pWfLOW32QPc0NqNOc
         Zj04P1XeYzOWXa9NB0WSVb02kB8DhgdnF8o6XY7snGCfYo9PxB1NCL6BBEuxYp+kpwX/
         mHHwBB/l0D2VwnvVYR9zpl0w23iPzao5TbyJdjnM8Nfe0QsXb1XO0VLKifufMeWtVxPl
         KU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412531; x=1781017331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NA6OL4UIXqcHlVS4y4AlNkc6cNibgN+LuxFkyYjT4UQ=;
        b=k6pvZ3uiwvSihrJgzwS1HmfO+TfcOaQsOjLbDCkLu4TLancfzsqnzEJTQPC3pnhNIG
         jBFztkzX2LgomlJ8eSicEIDnJCx4SJiQmJA2KEtLVKAI1NGFZuqHExP5zHgnUEHQi0cX
         KgoRs4zxTT0kLGH2wwRONZ1zUTqRUyJo0r7xwzexmtA3SxojhtCDCMSooP0Z7l07t6Zl
         qyGaBDdHtw+iPOgotz8WLQh2CHR+5Ffq7grF2RsIM4vicbExgu8pFEsosYWv0iy+AQhj
         5wLP5BYOi/+7eco3Vc58bLShaVD6gOqZUuOgOwt6O94G5uq6PTTBfVUuW1WJy+DeUKSm
         xDbw==
X-Gm-Message-State: AOJu0YyhmcEScKU/PMuPXE5okFl+95BRBVAqX4YpExXk0nTSHf7vf6D+
	MQu8ZtYhoz9FBpxnTAUZjaDpjZ5g3vkRua1wjHxZYIQD7pVwmwsCmt5a+SpwirTINqf963yiBLt
	3/25S/pFwTmGdDt4zWp2+PQHeRPW0Ma0=
X-Gm-Gg: Acq92OEdBvaQhgmGOA+uDj+aiBkd33Rl/tWr71WEdHk2aNY9ESbk/xFRyeetgZjvfjF
	d7q5kRGqCZCTkuaBkMaFHfUgXf15EvgOa4s6FvGmQwNJxukmHC+q86xxyhahZAcHLjsJILBOv0+
	ygiqS3izsbJ70rrfxIW3bhuvT4bT2lQBRZtEUj1Ro2rMDMl7zLTzR4zpAlSjdImL3MN0f43sHqk
	R1d080UgMg/JJmVDeWpxBua8f4bWU6KSaZPARflH3uI5i5Rfd3jm/AmBCibkk8nslZxVPDPgvFj
	RVbCR35Fu82sXCmoED/+qnlNgbGZjd2zeVQuYP+kNdPKdIF3/vGG51LfzJCyRz3JR1yrfaVoWfs
	OPg==
X-Received: by 2002:a53:b1c2:0:b0:660:77b5:5342 with SMTP id
 956f58d0204a3-660d5e505a9mr109556d50.2.1780412530268; Tue, 02 Jun 2026
 08:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602082925.7061-1-raghavendra.rao@collabora.com> <20260602082925.7061-2-raghavendra.rao@collabora.com>
In-Reply-To: <20260602082925.7061-2-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 11:01:59 -0400
X-Gm-Features: AVHnY4KQksJ408YLuzrJU2fLB1Tc0h5Umm2xxy3jAQOkRe_FSdRK8btVlpvZG_c
Message-ID: <CABBYNZ+UzUk+MHSo87vttd7YF-s3Zuzsywf+wnoOboaD2bLhFg@mail.gmail.com>
Subject: Re: [BlueZ PATCH 1/1] shared/bap: add ASE Control Point error responses
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raghu,

On Tue, Jun 2, 2026 at 4:35=E2=80=AFAM raghu447 <raghavendra.rao@collabora.=
com> wrote:
>
> From: raghavendra <raghavendra.rao@collabora.com>
>
> These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.
> ---
>  src/shared/bap.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 8fc2fb14d..ce56efbb2 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -3304,6 +3304,33 @@ static uint8_t stream_enable(struct bt_bap_stream =
*stream, struct iovec *meta,
>         return 0;
>  }
>
> +static bool ascs_metadata_rsp(struct bt_bap_endpoint *ep, struct iovec *=
meta,
> +                                                       struct iovec *rsp=
)
> +{
> +       struct bt_ltv *ltv;
> +       uint16_t context;
> +
> +       ltv =3D meta->iov_base;
> +       if (meta->iov_len >=3D sizeof(*ltv) && ltv->type =3D=3D 0xfc) {

What is this for? Why is it checking for type 0xfc?

> +               ascs_ase_rsp_add(rsp, ep->id,
> +                               BT_ASCS_RSP_METADATA_UNSUPPORTED, ltv->ty=
pe);
> +               return true;
> +       }
> +
> +       if (meta->iov_len >=3D sizeof(*ltv) + sizeof(context) &&
> +                       ltv->type =3D=3D 0x02 && ltv->len =3D=3D 0x03) {
> +               context =3D get_le16(ltv->value);
> +               if (!context || (context & 0xf000)) {
> +                       ascs_ase_rsp_add(rsp, ep->id,
> +                                       BT_ASCS_RSP_METADATA_INVALID,
> +                                       ltv->type);

This seems to check if the metadata is a context and then checks if
it's setting undefined bits. I'm not sure if this will age well,
though, because the moment any of those bits are defined, this check
will become invalid. Perhaps the intent is to check if the context is
set to a value outside the supported contexts, in which case it should
be rejected? But then we shouldn't hardcode 0xf000, instead we should
probably use something like: ~supported_context.

> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
>                         struct bt_ascs_enable *req, struct iovec *iov,
>                         struct iovec *rsp)
> @@ -3335,6 +3362,9 @@ static uint8_t ep_enable(struct bt_bap_endpoint *ep=
, struct bt_bap *bap,
>                 return 0;
>         }
>
> +       if (ascs_metadata_rsp(ep, &meta, rsp))
> +               return 0;
> +
>         if (!ep->stream) {
>                 DBG(bap, "No stream found");
>                 ascs_ase_rsp_add(rsp, ep->id,
> @@ -3568,6 +3598,9 @@ static uint8_t ep_metadata(struct bt_bap_endpoint *=
ep,
>         meta.iov_base =3D util_iov_pull_mem(iov, req->len);
>         meta.iov_len =3D req->len;
>
> +       if (ascs_metadata_rsp(ep, &meta, rsp))
> +               return 0;
> +
>         return stream_metadata(ep->stream, &meta, rsp);
>  }
>
> @@ -3673,6 +3706,23 @@ static struct iovec *ascs_ase_cp_rsp_new(uint8_t o=
p)
>         return iov;
>  }
>
> +static void ascs_ase_cp_rsp_add_truncated(struct iovec *rsp)
> +{
> +       ascs_ase_rsp_add_errno(rsp, 0x00, -ENOMSG);
> +}
> +
> +static bool ascs_ase_cp_rsp_invalid_len(uint8_t op, size_t len, uint8_t =
num)
> +{
> +       switch (op) {
> +       case BT_ASCS_METADATA:
> +               return len =3D=3D num;
> +       case BT_ASCS_RELEASE:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
>                                 unsigned int id, uint16_t offset,
>                                 const uint8_t *value, size_t len,
> @@ -3697,7 +3747,7 @@ static void ascs_ase_cp_write(struct gatt_db_attrib=
ute *attrib,
>                 return;
>         }
>
> -       if (len < sizeof(*hdr)) {
> +       if (!len) {
>                 DBG(bap, "invalid len %u < %u sizeof(*hdr)", len,
>                                                         sizeof(*hdr));
>                 gatt_db_attribute_write_result(attrib, id,
> @@ -3705,9 +3755,26 @@ static void ascs_ase_cp_write(struct gatt_db_attri=
bute *attrib,
>                 return;
>         }
>
> +       if (len < sizeof(*hdr)) {
> +               DBG(bap, "invalid len %u < %u sizeof(*hdr)", len,
> +                                                       sizeof(*hdr));
> +
> +               rsp =3D ascs_ase_cp_rsp_new(value[0]);
> +               ascs_ase_cp_rsp_add_truncated(rsp);
> +               ret =3D 0;
> +               goto respond;
> +       }
> +
>         hdr =3D util_iov_pull_mem(&iov, sizeof(*hdr));
>         rsp =3D ascs_ase_cp_rsp_new(hdr->op);
>
> +       if (!hdr->num) {
> +               DBG(bap, "invalid Number_of_ASEs 0");
> +               ascs_ase_cp_rsp_add_truncated(rsp);
> +               ret =3D 0;
> +               goto respond;
> +       }
> +
>         for (handler =3D handlers; handler && handler->str; handler++) {
>                 if (handler->op !=3D hdr->op)
>                         continue;
> @@ -3716,7 +3783,14 @@ static void ascs_ase_cp_write(struct gatt_db_attri=
bute *attrib,
>                         DBG(bap, "invalid len %u < %u "
>                                   "hdr->num * handler->size", len,
>                                   hdr->num * handler->size);
> -                       ret =3D BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
> +
> +                       if (ascs_ase_cp_rsp_invalid_len(hdr->op, iov.iov_=
len,
> +                                                               hdr->num)=
) {
> +                               ascs_ase_cp_rsp_add_truncated(rsp);
> +                               ret =3D 0;
> +                       } else
> +                               ret =3D BT_ATT_ERROR_INVALID_ATTRIBUTE_VA=
LUE_LEN;
> +
>                         goto respond;
>                 }
>
>


--=20
Luiz Augusto von Dentz
