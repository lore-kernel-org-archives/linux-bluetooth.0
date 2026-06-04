Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2722F8E81
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585012; cv=pass; b=CEhiiMLtSZ0SCEgOIg49vFrjJbvDmONPO/22ok5tYhrowNiQNH12w0c5l6c7PmWMO4h4CiUv2E1n49bg4iZPsui3O/9zabIwS4hHu8BIPVr+9JGEN78Fh6bpAuRFnD1X6UaDjLNZgb/XBSYA2kj/bF2kwaCE1PB9XBnwXTz4Lok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585012; c=relaxed/simple;
	bh=vuvdfuVEXm6r+nZaxsT8hYAdAQV14OGtelaGTRqRIFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4CW55o0+L2rjFRjQxZW87hN1P6YX8DfBsBSh3gsU6uq5T2fIsqjoHmS05MgHDXiBZylANKVvJjmi6GqXpxNFDc+N2Nll+ZCY3BJgjtdt+LCBGWCUPbDJXmEycDpV2jMP12lsuuGgDyTrowl7qk6VEZc6bjWsUcIt5LWGDuTi84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghEipviZ; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghEipviZ"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6607048fa62so956340d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 07:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780585010; cv=none;
        d=google.com; s=arc-20240605;
        b=db4cDq1smF+CpuCkf45sQRPUzHdFR1DmA5+TjE6pCcE9TyveobiYY52Ez0frrNZLI+
         23GRJKV7pGL8NB0XyGs9Rw0tnwPCf4eZGQVw3VtOkRANEQglPIt7bnRTmZ5+mDdsWoO/
         e360yoIlW2eya+AW/pHxlomyeyY68kLVGFKNmoRPx6HMK40NsaI/daID5gjrEf6Y+JBx
         bAOxvUXS00tH2HkO5MTgWjIg7PJnVEMC92ODHS5kRbsO41cTG3+i+LJZSaVqHAx7YB/s
         jNUE4S+g5WW1h+jA6JW2qu3cNhLzBgfgsyuuGWtPejTsJ3F3JTVE0GBfVtrFwIq+uQkb
         gbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OdKP+/2Hpg9NhhPOCQ/9EcKhfr4G+vcEoZJN1Hnhxc4=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=hWSOOZzQGGXF2zdHC58BoiBn/QX7boT303VA6Ew9GoORKfkMduLAnzZ/tslZ5xM6N8
         eZqELYCWgGobpxmioPgA+ynbfsZ3N54WFws04v+iham/s8vZMQSbSULkA1OvotvgP8Qb
         YbLZkD3gc4sehINWxrnmbOoXnDJAL24wLqFJhiU3W4sEIFWdjKEKh9u5vRXtAx/hL0WK
         wf7QKr7EhgPoz5qO5hD5tVza+WqhBuX0d6e3XSxMzksxvsokQTahyvMfZ4xw/7jZbHGx
         8R/Ngqcf7IumPZ372HhdzCP5chBEhGVv4tnVsoMGpRU2sEvWULvF9GIzhkaNpCqjX9BO
         4Jlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585010; x=1781189810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdKP+/2Hpg9NhhPOCQ/9EcKhfr4G+vcEoZJN1Hnhxc4=;
        b=ghEipviZzKBllPwTOT92baydwEkpgindAG+pjsQwsYXCziUzu1WkKp024TDwwOKrtH
         6qWK7Sfn4za8JvezMq2qg8KitNW3vAST86nSAfh98ifOWpQOSJAaU/KrxajUNlF30eCR
         SD0R1fMNWiGFLglB7CVBBYbPkXo6zoaYzcDJyWnkgI1uy0b+lIyT/SofmwT26Z7nTniS
         +deZrz/6ctTrw5UiTh3tJjVhZcZ87N2Qp/r9OBxYm6CkpC4H+eFR+s/N4NI7IKHch2mZ
         NjrPG03EOE1f29obs8/iUTpWdomqINddOEU40e348lhqFpLDwcW5Db9oXt35XYrQGxFD
         3/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585010; x=1781189810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdKP+/2Hpg9NhhPOCQ/9EcKhfr4G+vcEoZJN1Hnhxc4=;
        b=orCzLhd1EWoDUClBMxlt9I9L8rY2x9iKqHxLZIq9QN0ZVnM5OyFntAMFbU1uCgbLTp
         8AQTgIHXaIfpNRQTXfY5bVDKtubvlR8vLHjs1siSJd1R8BPOxT4YdfPImYvGFbiYvlfG
         O846KyuJ/kRxdgpWZaMrFsL3kIMMflD5osKrMj14fxts/8l9a43/NdrddmQSOleX6vmF
         LOWYHeScjaPK62bzTTv6yWwHalLW1MIjQoVT3CSsMgqlPtyLb99JiARPgsgf2rhL7wRm
         xE89D40pfo4iD1n2iLzbkULsxJVlQ7ychd7Qzlm6z8s4q6J5wrXklSKDcBj5r4EBm+f9
         p5/Q==
X-Gm-Message-State: AOJu0Ywagba3ESI4DTIVnRCNm0osoeAhR87nz/x7NYNOXWuc8NaoSewE
	1RGiTKvFpUcSbapVLKRUzZOh7PAXA6CMfEE1r9kHn+MiuQDecEq6/dBeOmuBnS6njHW+Gy2U+IR
	gv61XQ392fLyOxJEo4UVOSY+QJ+ww9Ng9Q7m2kCE=
X-Gm-Gg: Acq92OFr3TO3sFWhJ6CLSgWOyQAkUHOrHO3GUQyaZCC114BJ0a6bFcLWp3jsUQOkuQ9
	dN/3pGwCdOwwYLyGGqzrpgOW5MSJs+3yDJNSCAs23u92aC6PwQxFIrS5MACEy80OwrEdCoCRr+/
	fTaixO0trg+xP7VXlXQsrTtwKikBSC6dBQn/+oTCd1qcqGvdalBG9xAttHTmqBdxg8mF6dfYOb3
	zxUSPCbDTWn919JLlkkSK+U9frxleFW7/wSTqdiwvRbLI/mddljLQZf9RGAfxNSHPIbBr0k1sKz
	waYOaM0F5nd3ePWD0V6PK9v4Xl4LDLncNZE30o9JxP9Gj/jftJoKpi1F9jTzZxFCjjLnrA+TAvk
	kZLd98BD0Ifsk
X-Received: by 2002:a05:690e:140e:b0:660:eada:ea0e with SMTP id
 956f58d0204a3-660eadb1954mr5413759d50.39.1780585009976; Thu, 04 Jun 2026
 07:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+UzUk+MHSo87vttd7YF-s3Zuzsywf+wnoOboaD2bLhFg@mail.gmail.com>
 <20260604052052.10667-1-raghavendra.rao@collabora.com> <20260604052052.10667-2-raghavendra.rao@collabora.com>
In-Reply-To: <20260604052052.10667-2-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jun 2026 10:56:38 -0400
X-Gm-Features: AVHnY4JAcr56XUzONcL_J2gor6LsdTOOhh1Vb_GrLPvf2TEo2iIrsrO_mHYlp6U
Message-ID: <CABBYNZKQuFeXvtEE3d3nOUbkKZTAFsfB=1=NDFp48CFEg2e-=Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 1/1] shared/bap: add ASE Control Point error responses
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raghu,

On Thu, Jun 4, 2026 at 1:21=E2=80=AFAM raghu447 <raghavendra.rao@collabora.=
com> wrote:
>
> From: raghavendra <raghavendra.rao@collabora.com>
>
> Add SPE unit tests.
> These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.
> ---
>  src/shared/bap.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
>  unit/test-bap.c  | 64 ++++++++++++++++++++++++++++++++++

Please split these into 2 separate commits, one for shared/bap and
another for the test-bap and add the tests in the commit description
of the second.

>  2 files changed, 152 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 8fc2fb14d..edb84efca 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -57,6 +57,11 @@
>                 (1<<BAP_DURATION_LTV_TYPE)|\
>                 (1<<BAP_FRAME_LEN_LTV_TYPE))
>
> +#define BAP_METADATA_PREF_CONTEXT_LTV_TYPE     0x01
> +#define BAP_METADATA_CONTEXT_LTV_TYPE          0x02
> +#define BAP_METADATA_PROGRAM_INFO_LTV_TYPE     0x03
> +#define BAP_METADATA_LANGUAGE_LTV_TYPE         0x04
> +
>  struct bt_bap_pac_changed {
>         unsigned int id;
>         bt_bap_pac_func_t added;
> @@ -3304,6 +3309,40 @@ static uint8_t stream_enable(struct bt_bap_stream =
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
> +       uint16_t supported_context =3D 0;
> +       uint16_t context;
> +
> +       if (ep->stream && ep->stream->lpac)
> +               supported_context =3D ep->stream->lpac->qos.supported_con=
text;
> +
> +       ltv =3D meta->iov_base;
> +       if (meta->iov_len >=3D sizeof(*ltv) &&
> +                       (ltv->type < BAP_METADATA_PREF_CONTEXT_LTV_TYPE |=
|
> +                       ltv->type > BAP_METADATA_LANGUAGE_LTV_TYPE)) {
> +               ascs_ase_rsp_add(rsp, ep->id,
> +                               BT_ASCS_RSP_METADATA_UNSUPPORTED, ltv->ty=
pe);
> +               return true;
> +       }
> +
> +       if (meta->iov_len >=3D sizeof(*ltv) + sizeof(context) &&
> +                       ltv->type =3D=3D BAP_METADATA_CONTEXT_LTV_TYPE &&
> +                       ltv->len =3D=3D sizeof(context) + 1) {
> +               context =3D get_le16(ltv->value);
> +               if (!context || (context & ~supported_context)) {
> +                       ascs_ase_rsp_add(rsp, ep->id,
> +                                       BT_ASCS_RSP_METADATA_INVALID,
> +                                       ltv->type);
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
> @@ -3335,6 +3374,9 @@ static uint8_t ep_enable(struct bt_bap_endpoint *ep=
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
> @@ -3568,6 +3610,9 @@ static uint8_t ep_metadata(struct bt_bap_endpoint *=
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
> @@ -3673,6 +3718,23 @@ static struct iovec *ascs_ase_cp_rsp_new(uint8_t o=
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
> @@ -3697,7 +3759,7 @@ static void ascs_ase_cp_write(struct gatt_db_attrib=
ute *attrib,
>                 return;
>         }
>
> -       if (len < sizeof(*hdr)) {
> +       if (!len) {
>                 DBG(bap, "invalid len %u < %u sizeof(*hdr)", len,
>                                                         sizeof(*hdr));
>                 gatt_db_attribute_write_result(attrib, id,
> @@ -3705,9 +3767,26 @@ static void ascs_ase_cp_write(struct gatt_db_attri=
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
> @@ -3716,7 +3795,14 @@ static void ascs_ase_cp_write(struct gatt_db_attri=
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
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index 3a67e7016..e43d1d2ef 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -4349,6 +4349,69 @@ static void test_scc_metadata(void)
>         test_usr_scc_metadata();
>  }
>
> +#define ASE_CP_RSP(_op, _ase, _code, _reason) \
> +       IOV_DATA(0x1b, CP_HND, _op, 0x01, _ase, _code, _reason)
> +
> +#define ASE_CP_RSP_TRUNCATED(_op) \
> +       IOV_DATA(0x1b, CP_HND, _op, 0xff, 0x00, 0x02, 0x00)
> +
> +#define SPE_CP_TRUNCATED(_op) \
> +       IOV_DATA(0x52, CP_HND, _op), \
> +       ASE_CP_RSP_TRUNCATED(_op)
> +
> +#define SPE_CP_ZERO_ASES(_op) \
> +       IOV_DATA(0x52, CP_HND, _op, 0x00), \
> +       ASE_CP_RSP_TRUNCATED(_op)
> +
> +#define SPE_METADATA_TRUNCATED(_ase) \
> +       IOV_DATA(0x52, CP_HND, 0x07, 0x01, _ase), \
> +       ASE_CP_RSP_TRUNCATED(0x07)
> +
> +#define SPE_METADATA_UNSUPPORTED(_ase) \
> +       SCC_SRC_ENABLE, \
> +       IOV_DATA(0x52, CP_HND, 0x07, 0x01, _ase, 0x02, 0x01, 0xfc), \
> +       ASE_CP_RSP(0x07, _ase, 0x0a, 0xfc)
> +
> +#define SPE_METADATA_INVALID_CONTEXT(_ase) \
> +       SCC_SRC_ENABLE, \
> +       IOV_DATA(0x52, CP_HND, 0x07, 0x01, _ase, 0x04, 0x03, 0x02, \
> +                       0x00, 0x10), \
> +       ASE_CP_RSP(0x07, _ase, 0x0c, 0x02)
> +
> +/* Unicast Server Rejects Invalid ASE Control Point Procedures
> + *
> + * Test Purpose:
> + * Verify the behavior of a Unicast Server IUT when a Unicast Client wri=
tes
> + * invalid ASE Control Point parameters.
> + *
> + * Pass verdict:
> + * The IUT sends a notification of the ASE Control Point characteristic =
with
> + * the expected Response_Code and Reason values.
> + */
> +static void test_usr_spe(void)
> +{
> +       define_test("BAP/USR/SPE/BI-01-C [USR ASE Control Point truncated=
]",
> +                       test_setup_server, test_server, NULL,
> +                       SPE_CP_TRUNCATED(0x03));
> +       define_test("BAP/USR/SPE/BI-02-C [USR ASE Control Point zero ASEs=
]",
> +                       test_setup_server, test_server, NULL,
> +                       SPE_CP_ZERO_ASES(0x03));
> +       define_test("BAP/USR/SPE/BI-03-C [USR Update Metadata truncated]"=
,
> +                       test_setup_server, test_server, NULL,
> +                       SPE_METADATA_TRUNCATED(SRC_ID(0)));
> +       define_test("BAP/USR/SPE/BI-04-C [USR Update Metadata unsupported=
]",
> +                       test_setup_server, test_server, &cfg_src_enable,
> +                       SPE_METADATA_UNSUPPORTED(SRC_ID(0)));
> +       define_test("BAP/USR/SPE/BI-05-C [USR Update Metadata invalid con=
text]",
> +                       test_setup_server, test_server, &cfg_src_enable,
> +                       SPE_METADATA_INVALID_CONTEXT(SRC_ID(0)));
> +}
> +
> +static void test_spe(void)
> +{
> +       test_usr_spe();
> +}
> +
>  #define SNK_ENABLE \
>         IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x01, 0x04, 0x03, 0x02, 0x=
01, \
>                         00), \
> @@ -10259,6 +10322,7 @@ int main(int argc, char *argv[])
>         tester_init(&argc, &argv);
>
>         test_disc();
> +       test_spe();
>         test_scc();
>         test_bsrc_scc();
>         test_bsnk_scc();
>


--=20
Luiz Augusto von Dentz
