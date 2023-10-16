Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C9CDB482
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 17:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjJPRFh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjJPRFT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 13:05:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1742611
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:01:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso34663281fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697475693; x=1698080493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+bcVr75RecMOzOjHAeghgpkMsBPnl5cdswmzluAU/E=;
        b=ihgM8Sii+FJvIXHTcnO6WJTwkZLmtOLmZnT5GwxyaLL31gmEfL+KqSkRqz2HD/geXE
         J8gEc3vxLv0hnXEJfIK/owUP4aW9aLqnMZ5LO+1EhL7tBk5c5iAELbNpLAvxv31Pp3aX
         ohy+d13p+hTepRgLUx+hRm7MLTKpq+xtK0PmNvOnapKoZjA69J6uUKzzxpcHlUexVOO8
         dNIx+4zaDDUTqlsHR0wogRc2C0EVICTSWYif25SxeHzn3Ph0Mhd/OZhyB/Kyj07ZEUVj
         /ubrib79p2unbAuDrxQ+zGtRzMB7pzOkJ6Y1rQN252sbqRkWTniW9DjsuSD5wz+ZL62j
         S+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475693; x=1698080493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+bcVr75RecMOzOjHAeghgpkMsBPnl5cdswmzluAU/E=;
        b=Vk9ZvrFQ4vBuHOu3zCbgoIeCqHj6cWVep4CtOcvq5YdHzM+0B/PsnJmgR43msgrB0Y
         Ttwu95o21vrdLuG0HShOkWznJjNJThkIJBbkBEdLU46ud8cYzjLqG71tLDLyseuX+v4Q
         IEiB4yB0xw11CqBn3etSCVxwUjSOKk6uUNwZfskS2J4B2lrnCXyCy/CwWzZTUHSeuJFD
         s5hS193HKT6Ybnjxq6VsY7LbRIWiCfR5P9V58NJ+ELz2GAXW13ZfkNV9YEl1gd6QgAW4
         12cAP9EBCqjiUnW9mQJN+aBpEHtDfd6DguNrphVdpxzqW1H10iLtHbqnbGnJsjZY+C0o
         FAMw==
X-Gm-Message-State: AOJu0YyZ1WtmF/Re0Ietc5fr5OzYoD0YQH7dPX+lOMU5V0RGAs+wJ09W
        NtXzgeRGH9mSjJ15SXkZv+StW0+unaHgWw/LhAaZGADo2zNXgdF4
X-Google-Smtp-Source: AGHT+IFqkEUGlCu/iisTafdoyPE1hOJn9hhnNGN/lESg5xZhN0wWxTHcRkGfixacQdBbpp+VG50jFxlPojYLyPGqYpE=
X-Received: by 2002:a2e:b535:0:b0:2c5:1900:47a4 with SMTP id
 z21-20020a2eb535000000b002c5190047a4mr3643180ljm.0.1697475693138; Mon, 16 Oct
 2023 10:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231016154900.3094-1-iulia.tanasescu@nxp.com> <20231016154900.3094-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20231016154900.3094-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Oct 2023 10:00:47 -0700
Message-ID: <CABBYNZJ21w6h_hvBWsEwwDTevYqiZqY7oOOf8oEXDRmDPxmHYA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] btio: Handle closed channel in server_cb
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Mon, Oct 16, 2023 at 8:49=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This handles G_IO_ERR and G_IO_HUP conditions in server_cb
>
> ---
>  btio/btio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index d45b8240d..c63a6d1df 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -247,7 +247,8 @@ static gboolean server_cb(GIOChannel *io, GIOConditio=
n cond,
>         GIOChannel *cli_io;
>
>         /* If the user closed the server */
> -       if ((cond & G_IO_NVAL) || check_nval(io))
> +       if ((cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) ||
> +                       check_nval(io))

I believe this was done on purpose to only check for NVAL, the other
conditions shall probably be notified back via callback so it can
process the error reported.

>                 return FALSE;
>
>         srv_sock =3D g_io_channel_unix_get_fd(io);
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
