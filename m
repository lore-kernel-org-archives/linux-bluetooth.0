Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049694A92DA
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363394; cv=pass; b=hWu999iPPTJIu8JX3lpOVqmDwclbVJ/wWqRTFYLgERjbqqgMCjbevG3TsVKsjSeUX5Kifruy06AjTgC8klWFy3ODjqzPEFfeyUdisxwDl9kA9YLq2NGmNjG6PZYYYB0mG7mKUI01QyfWPASJN2XzB3H4DD9L5poFWzInBwW/5Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363394; c=relaxed/simple;
	bh=iv0Lt1uvb/WyVqSMikRTam/gwdXXf3NBwzMDNRrj2PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUvzFLmxAIGO2YkKH6CfmcyVf1RiS40ucssWO81BNGtX2VOkPEKRe0O3qZU86B4DMdgDQ9Num7DbJ5OZLSCaCTh5orfhSavYjXxrWZoH6tuXI91ZrT/15vQ05K9+ETuKv1TgXU7iz3z2ZkPIrrPsXZ3q8HFDCTPJTJYBx04VGGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLjm9TK+; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLjm9TK+"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-86d43cdee51so7977197b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788363376; cv=none;
        d=google.com; s=arc-20260327;
        b=JoILzaA/UgYW8XyqpDSqAg3NpBcyIM2WQ1eafevaIELmHojNA0DZ7/GCWN/wB/RaXo
         i4KSeGWLmNAPKS8lUN2LyInXFp3kRe4n3/RN4p8ljBrkugDtK0Msd/vu2fBMztIbMMNN
         y41hRrZh87unT0MFI+0Y3H3xhFaRsBBVaXcwZn4TDKrc4CLZydDnQA9XMVLr+rL0cXaK
         wXG+Ahi200jW6+m4T5dl6Uf3xyexi7SF4EEZeHND66w4MwJGy5jKo5mYgp8+YGv41FGr
         BX4SD+5j0CexGc14W2nfNL/knGPck5jfmeCqy1Yk2T26aT2FutUKnCJNikN7+TTn4kWV
         oEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c77EkXJn1VVNiGi36VEJBeh9IGt/wD19yNnrwqvMJZw=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=Pycb7VFjzUXmdCa3Mv0Xhy+4hnVJOrxSICh9cmbZIiN+Rhnfxe8U9ToDAXi1YkaMqn
         ABr03dQjJkqskVKfG3h3ojQjY2n5N/3cU4VQLaYH9/Z7s6vspP+V2/ciNpgCwHhwbtMw
         AvhTccsXLR33KYEqR0H2wAvld4vhp0r4ob7axFkrMWlmcyDyUfhfFm/mLXgj+3RfzYJf
         3PJ+XCQlbgNT6kbWPOi3y0dxi9zNfrwxEXuBEIvpOt1HbAwRUDgC/qrzKcv6q4oOAWf8
         Nh5KIg40BcJs3hE4h2d/MPxA77d5z6ulomdhAraksWN6Ci2QCSzaAM5edcCcPgZ/RF3n
         S7ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363376; x=1788968176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c77EkXJn1VVNiGi36VEJBeh9IGt/wD19yNnrwqvMJZw=;
        b=rLjm9TK+OyA5v92WEizUn4qK56ywe4RWgdQ5jebnPcql3NiYbk8FT5U3jldLcuhoS/
         vO6H3kVv0O6ybsxF0G08EkiE5WLYPSbD05XzMt3Ge2j/ulLIcjsGn6OQasDA5QcVKfns
         N/aJ6B4m4Fe3EiDWQp5oA5QpbEv5ZIN3dxG5gQ+aXYJg5EVog5VzQoqrtV2F/PXbdWN0
         yfykN95jSvxAONQm8C52rKPOolKe0SfzEcECvAYOWz05k+4DDBc7+Qo4w3G7sx9Q+wV9
         k8nL2/5K0OcvtGDljI6obmRopkeXr5vY2QCIW13M/Oz74v4e+dimGQWEhZLZVOQYxQX5
         wdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363376; x=1788968176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c77EkXJn1VVNiGi36VEJBeh9IGt/wD19yNnrwqvMJZw=;
        b=DOfKo5Kt+2J0zoT6cOY5+KQd1yOD3zYBLnY80CkepfDi+9jgfwn2xjuWKSyyoxvGHS
         ncxwqC1PbC+Ia59gjRo0OA1uD4JR3dIUjAlj822+GvREHgTXwd5ekEDuMtvZWewP5BoQ
         KhLy+KjgL8wOBrw51gJbXdiBKPueg2k8xwdnMqS0TBsWtQM9FMmQ8gxkBxiCkzr0SAME
         Hi1xygFrLqg3caO0gbyQxtNSC9pNjIPxVY49++5E+sTtuGfy+Fv4xO84uf99WPOACjQH
         3wiIu0ILmj+AuQ1nhTb2zwaJUQ2pXqBDmWdTnDerlEuy1frnXqEWDpHPiSqNurwDhukO
         7IIw==
X-Gm-Message-State: AFuF++lKH8CCTck3Z1NdvFvU1eXlZHlJRT7mb312mMOijwKAwDleUWdE
	USkKq8XbwM1KR5d9Fjg3GkrBCoxOKRhnFk9kwhmEwamVPTB8noCW3u9ZfRRoPVTzWVkDuLJj/jU
	2XEMP1sUOmxkIMI3r72/f25G00rFP12Y=
X-Gm-Gg: AYBFou30sIx82XtoaA38LWgnsvVo6UHqxQ8YJuda66zExF9AIMNe4D/IJksConR5fLF
	+SNokbIM3HWBsNKnZa4cmoGFgBpx3Y/Pn+FetkixnOds5BZq6vseKrey+WD5SMUgDuoNZJQi5li
	9in3LdutYTTEhhlqPPpSwDoDHy3A5XCeTQOzEKmdll8Iei8JVU06BlT8N/Wsv/1TGRQB5+Ng5/S
	anSCSk2vHMayE8EJtgUIIoRthYWI/VMFG8PzitZt70/MucucJf2BNXIaGoazWxuv7MGsOjhjj5e
	FlVaaaidqszpk/KcVOyAulM43XFpgbLqpSnw+wFuaYiBgwwc/qU4IeE90mB35JZqKgl5o3Qwov1
	xN18ZRxGr62wPdhIjvlNuIApU9L1QgH8=
X-Received: by 2002:a05:690c:c057:b0:866:e57f:58dd with SMTP id
 00721157ae682-86c533981e0mr24779437b3.21.1788363376538; Wed, 02 Sep 2026
 08:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831061144.7767-1-raghavendra.rao@collabora.com> <20260831061144.7767-4-raghavendra.rao@collabora.com>
In-Reply-To: <20260831061144.7767-4-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Sep 2026 11:36:05 -0400
X-Gm-Features: AcwNN1V1SFcqkO_kpn5X6Io4H7StW-7K2odL-H7Jv9Fzskx9lB1GyNkvA4FzfcU
Message-ID: <CABBYNZ+dKAf3E1r+CbuuLkWdfbs3OterJQQ95zB+J19F3rPrtw@mail.gmail.com>
Subject: Re: [BlueZ PATCH 3/3] shared/mcp: Notify unsupported RFU opcodes
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raghu,

On Mon, Aug 31, 2026 at 2:12=E2=80=AFAM raghu447 <raghavendra.rao@collabora=
.com> wrote:
>
> From: raghavendra <raghavendra.rao@collabora.com>
>
> This is needed to Pass PTS GMCS/SR/SPE/BI-01-C test.
> ---
>  src/shared/mcp.c |  4 +++-
>  unit/test-mcp.c  | 14 ++++++++++++++

Split the changes for the unit and shared components.

>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/mcp.c b/src/shared/mcp.c
> index a954869b0..583ae40dc 100644
> --- a/src/shared/mcp.c
> +++ b/src/shared/mcp.c
> @@ -324,6 +324,7 @@ static void write_media_cp(struct gatt_db_attribute *=
attrib,
>         int ret =3D 0;
>         int32_t arg =3D 0;
>         uint8_t op;
> +       bool rfu_op =3D false;
>         bool ok =3D false;
>
>         if (offset) {
> @@ -337,6 +338,7 @@ static void write_media_cp(struct gatt_db_attribute *=
attrib,
>         }
>
>         rsp.op =3D op;
> +       rfu_op =3D !op;
>
>         cmd =3D mcs_get_command(op);
>         if (!cmd || !(cmd->support & mcs_get_supported(mcs))) {
> @@ -370,7 +372,7 @@ respond:
>                                                         ret, rsp.result);
>
>         gatt_db_attribute_write_result(attrib, id, ret);
> -       if (!rsp.op)
> +       if (!rsp.op && !rfu_op)
>                 return;
>
>         /* Make state transition immediately if command was successful an=
d has
> diff --git a/unit/test-mcp.c b/unit/test-mcp.c
> index 6331c6c99..21997915d 100644
> --- a/unit/test-mcp.c
> +++ b/unit/test-mcp.c
> @@ -2057,6 +2057,19 @@ static void testgroup_sr_mcp(void)
>  }
>
>
> +#define GMCS_SR_SPE_BI_01_C \
> +       WRITE_NORESP_CHRC(CP, 0x00), \
> +       NOTIFY_CHRC(CP, 0x00, 0x02 /* not supp */)
> +
> +static void testgroup_sr_spe(void)
> +{
> +       define_test("GMCS/SR/SPE/BI-01-C [Media Control Point - Opcode no=
t "
> +                                                       "Supported]",
> +               test_setup_server, test_server,
> +               &cfg_sggit_gmcs, GMCS_SR_SPE_BI_01_C);
> +}
> +
> +
>  static void sr_spn_value(struct test_data *data, struct iovec *buf, size=
_t size,
>                                                                 uint16_t =
uuid)
>  {
> @@ -2132,6 +2145,7 @@ int main(int argc, char *argv[])
>         testgroup_cl_extra();
>         testgroup_sr_sggit();
>         testgroup_sr_mcp();
> +       testgroup_sr_spe();
>         testgroup_sr_spn();
>
>         return tester_run();
>


--=20
Luiz Augusto von Dentz
