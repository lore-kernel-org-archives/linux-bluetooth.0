Return-Path: <SRS0=sa2S=XB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D115FC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 08:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE3B206A1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 08:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll/wCNfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbfIFIO7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:14:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38297 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfIFIO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Sep 2019 04:14:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id 7so4255888oip.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Sep 2019 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZVH49PXJOp/7gofccBp83gZidHl61c7GtFdiLSiuOcU=;
        b=Ll/wCNfZI3Ygprs/IlwekrxwuNSbFSJhTw19rJmGZO164HWGTGX2CBr2NzZZ41cM+S
         jLc2e77oiVcHJmKxt5NH0H+6IXAzC4uvb6OGcC918bNJRgocpbTNx86pN+mnSmEPoUXi
         yIicgFr/Jb4w7b8SDV0bREK1qZqW0w0iMXMBt4+vg+S4uIE1gxTCcXD15Crh3z95j6Nh
         Qoyl6D9368x7piC24oMCe6n9/rB0kUHZZKxaF0a4u9FJ3RF3wgxN21BAqmW8C6fQPRAP
         QVdlj2FeyYA8cEilLPsApPHNx1grrSB6F6iHCJwpCyVt/LCh3xM+O3XRWKf2V27NQvC9
         ao+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZVH49PXJOp/7gofccBp83gZidHl61c7GtFdiLSiuOcU=;
        b=oeMEipaDAnmIWYRBlPi1Tus63qhVFzoUCOUFoUfB+abOW4SE9PqE/ApMyxIx3s7UpN
         1nplTA3Nn5DL8wCuaIgf4jTS48dMZiuyGH+F5yqsGlJP+o8erwI6cjQUFC4xvdcl9tgY
         JK91na3YJA3ryUncH7xLOsne/JKGkx90Z3+tR7E48qgM8kJZ+e1eYBI/X2iAvOmB6l8w
         JTe9U8r3NWlCxKOi1dpFhW2wWQrO9A4WJ5z2oZvfGKuKXiw44i5JyR8d8qlUMpeT0rus
         IPrbNL7YkOBFpK6uagMD9B0ziy6KG/xDSVMu+LtP1swGTKZmCzQsRrbEPFqPgPrSvmGV
         00sw==
X-Gm-Message-State: APjAAAW05k99zOC6NPXX0yJ/8cTv3ZT39sZM5YQeQSeTqRnA7+aUry9a
        YRLnRB/7/QsoL2sFEzyzjN9mnfrHO+uVy0KDMc9RZx8ihdo=
X-Google-Smtp-Source: APXvYqxY8OHrIZNwVbcos6x/QLEgWWhMJRkz2/Z77pHuHXDobEJ7zk6u/IVZHiMHP9oGOXGFBWxLJEzTm4DWZ4iY0Nk=
X-Received: by 2002:aca:5710:: with SMTP id l16mr5745853oib.8.1567757698125;
 Fri, 06 Sep 2019 01:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190826120613.23233-1-luiz.dentz@gmail.com>
In-Reply-To: <20190826120613.23233-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 6 Sep 2019 11:14:45 +0300
Message-ID: <CABBYNZKLNF3D79r8M11yP7LKE-mQC3rELgTi8Q3PC7pZyQhirA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-client: Automatically add CCC when discovering
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Aug 26, 2019 at 3:06 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The spec mandates that a CCC exists if either notify or indicate
> property is marked:
>
> BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part G page 2357
>
>   "If set, the Client Characteristic Configuration Descriptor shall
>   exist."
> ---
>  src/shared/gatt-client.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 225915d43..38a416ed3 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -659,6 +659,31 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
>
>                 desc_start = chrc_data->value_handle + 1;
>
> +               if (desc_start == chrc_data->end_handle &&
> +                       (chrc_data->properties & BT_GATT_CHRC_PROP_NOTIFY ||
> +                        chrc_data->properties & BT_GATT_CHRC_PROP_INDICATE)) {
> +                       bt_uuid_t ccc_uuid;
> +
> +                       /* If there is only one descriptor that must be the CCC
> +                        * in case either notify or indicate are supported.
> +                        */
> +                       bt_uuid16_create(&ccc_uuid,
> +                                       GATT_CLIENT_CHARAC_CFG_UUID);
> +                       attr = gatt_db_insert_descriptor(client->db, desc_start,
> +                                                       &ccc_uuid, 0, NULL,
> +                                                       NULL, NULL);
> +                       if (attr) {
> +                               free(chrc_data);
> +                               continue;
> +                       }
> +               }
> +
> +               /* Check if the start range is within characteristic range */
> +               if (desc_start > chrc_data->end_handle) {
> +                       free(chrc_data);
> +                       continue;
> +               }
> +
>                 client->discovery_req = bt_gatt_discover_descriptors(
>                                                         client->att, desc_start,
>                                                         chrc_data->end_handle,
> --
> 2.21.0

Applied.

-- 
Luiz Augusto von Dentz
