Return-Path: <SRS0=nJmK=NN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF8AC65C22
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Nov 2018 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACB92081F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Nov 2018 10:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmurJfyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACB92081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeKBUBY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:01:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40899 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKBUBY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Nov 2018 16:01:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id u130-v6so1225537oie.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Nov 2018 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/Y73WP198gKa+gLexvQMfVq7Ufn7FYRHt60+6Qpc/Q=;
        b=EmurJfyqzHbeXZg74rMOWI+75KLj3Ehxn8JZudgDlvErS7w2xYDoh5uvKl84lFMMJ1
         mfv7Kk1t5XMXx2TPdlRN5k6Zn2tCclAv81zofy0yQ/bR7a/J8HFWfcxwWiJwyayJeW5m
         q6CCtks5UEOdB+Qz4kL9fuJ3WtTkOkoHOgoVyxqCd7w4au0d3/vKEWQy/LkFk9hPvYYT
         Yoqfr8EvhuiM0ZFFGa2WfNKpsoiLGaRtsZ6SAgKsKYQPH4Dy6ptqxNHGHteHsop9Z3x4
         IwFeV+Y17PUmMpv9t5P1MCk40TNJPGcFNEz5IL/CkDUVRRDeVOlURKxnpooQIJoRnz5n
         c8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/Y73WP198gKa+gLexvQMfVq7Ufn7FYRHt60+6Qpc/Q=;
        b=P02+5HEmzTEbSpLsAkPkasHOLnVWfUNmnXub4Zy4UbUHk1+USzt5a+7Le3vfoa36jI
         3ys0HALqA4x7OBzODYNRjAkagq0ABZvm7ONfOQzS/Azz+ohPKQnMkEL/x2dkT1OgMVZm
         ZIw+77rAqIdwf032h839coU/QKwuMwB1zeZCF1rpgQOTbunVHr3lOvP4eNpuWdSIyqsW
         HTVvZw00zQbGJYUacXdwTD5huVJ0TcFd2FqJThBtNzLmai0X8vTGAB4ALSwExgS7drVO
         SwZb4tAfLoVIPb1wOfR5kezA9TvBNbDNhl13y94lrmNgP672zu7KgCQUPMpxkLMC3eHn
         CkIw==
X-Gm-Message-State: AGRZ1gI1kZfyPOYncKIT3GBHDWYqWcM43CXhCxa4MC/8D/FTOPV3j6RU
        L5FHiwJDHpHIyXWe664Je+7d4XfhIiWj2sQ7mokY7/cR
X-Google-Smtp-Source: AJdET5eCPvR+bu/+oYQrd5wg8Lj8Q5rUC/NE4OCiSD2uNH2XOqqf4ZmYDDJ7NJn3x/yXy+pybK9xKnAxfLOjRu81fZ0=
X-Received: by 2002:aca:aa4f:: with SMTP id t76-v6mr6738830oie.273.1541156079171;
 Fri, 02 Nov 2018 03:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181031081508.25927-1-acho@suse.com> <20181031081508.25927-2-acho@suse.com>
In-Reply-To: <20181031081508.25927-2-acho@suse.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 2 Nov 2018 12:54:27 +0200
Message-ID: <CABBYNZKNiqLDAnV0hB0tZ_=fCr6RK8Q7Wyn3UTWk=PXSREMupg@mail.gmail.com>
Subject: Re: [PATCH 1/3 BlueZ] hcidump: fixed AMP Assoc dump heap-over-flow
To:     "Cho, Yu-Chen" <acho@suse.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        jlee@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Wed, Oct 31, 2018 at 11:08 AM Cho, Yu-Chen <acho@suse.com> wrote:
>
> amp_assoc_dump() didn't check the length of amp assoc struct of
> Type-Length-Value (TLV) triplets, and the Connected Chan List
> (number of triplets) is also need to check, or there are wrong
> length for the number of triplets.
>
> Signed-off-by: Cho, Yu-Chen <acho@suse.com>

Please remove the Signed-off-by, we don't use that in userspace.

> ---
>  tools/parser/amp.c | 65 ++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
>
> diff --git a/tools/parser/amp.c b/tools/parser/amp.c
> index 158ca4a75..bd7f91000 100644
> --- a/tools/parser/amp.c
> +++ b/tools/parser/amp.c
> @@ -33,7 +33,7 @@ static void amp_dump_chanlist(int level, struct amp_tlv *tlv, char *prefix)
>         struct amp_country_triplet *triplet;
>         int i, num;
>
> -       num = (tlv->len - sizeof(*chan_list)) / sizeof(*triplet);
> +       num = sizeof(*chan_list->triplets) / sizeof(*chan_list->triplets[0]);
>
>         printf("%s (number of triplets %d)\n", prefix, num);
>
> @@ -80,47 +80,50 @@ void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
>
>                 p_indent(level+1, 0);
>
> -               switch (tlv->type) {
> -               case A2MP_MAC_ADDR_TYPE:
> -                       if (tlvlen != 6)
> -                               break;
> -                       printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
> +               if (tlvlen !=0) {
> +                       switch (tlv->type) {
> +                       case A2MP_MAC_ADDR_TYPE:
> +                               if (tlvlen != 6)
> +                                       break;
> +                               printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
>                                         tlv->val[0], tlv->val[1], tlv->val[2],
>                                         tlv->val[3], tlv->val[4], tlv->val[5]);
> -                       break;
> -
> -               case A2MP_PREF_CHANLIST_TYPE:
> -                       amp_dump_chanlist(level, tlv, "Preferred Chan List");
> -                       break;
> +                               break;
>
> -               case A2MP_CONNECTED_CHAN:
> -                       amp_dump_chanlist(level, tlv, "Connected Chan List");
> -                       break;
> +                       case A2MP_PREF_CHANLIST_TYPE:
> +                               amp_dump_chanlist(level, tlv, "Preferred Chan List");
> +                               break;
>
> -               case A2MP_PAL_CAP_TYPE:
> -                       if (tlvlen != 4)
> +                       case A2MP_CONNECTED_CHAN:
> +                               amp_dump_chanlist(level, tlv, "Connected Chan List");
>                                 break;
> -                       printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
> +
> +                       case A2MP_PAL_CAP_TYPE:
> +                               if (tlvlen != 4)
> +                                       break;
> +                               printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
>                                         tlv->val[0], tlv->val[1], tlv->val[2],
>                                         tlv->val[3]);
> -                       break;
> -
> -               case A2MP_PAL_VER_INFO:
> -                       if (tlvlen != 5)
>                                 break;
> -                       ver = (struct amp_pal_ver *) tlv->val;
> -                       printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",
> +
> +                       case A2MP_PAL_VER_INFO:
> +                               if (tlvlen != 5)
> +                                       break;
> +                               ver = (struct amp_pal_ver *) tlv->val;
> +                               printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",
>                                         ver->ver, btohs(ver->company_id),
>                                         btohs(ver->sub_ver));
> -                       break;
> +                               break;
>
> -               default:
> -                       printf("Unrecognized type %d\n", tlv->type);
> -                       break;
> -               }
> +                       default:
> +                               printf("Unrecognized type %d\n", tlv->type);
> +                               break;
> +                       }
>
> -               len -= tlvlen + sizeof(*tlv);
> -               assoc += tlvlen + sizeof(*tlv);
> -               tlv = (struct amp_tlv *) assoc;
> +                       len -= tlvlen + sizeof(*tlv);
> +                       assoc += tlvlen + sizeof(*tlv);
> +                       tlv = (struct amp_tlv *) assoc;
> +               } else
> +                       break;
>         }
>  }
> --
> 2.19.1

Please fix these:

Applying: hcidump: fixed AMP Assoc dump heap-over-flow
WARNING:LONG_LINE_STRING: line over 80 characters
#28: FILE: tools/parser/amp.c:88:
+                printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",

WARNING:LONG_LINE_STRING: line over 80 characters
#42: FILE: tools/parser/amp.c:94:
+                amp_dump_chanlist(level, tlv, "Preferred Chan List");

WARNING:LONG_LINE_STRING: line over 80 characters
#48: FILE: tools/parser/amp.c:98:
+                amp_dump_chanlist(level, tlv, "Connected Chan List");

WARNING:LONG_LINE_STRING: line over 80 characters
#70: FILE: tools/parser/amp.c:113:
+                printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",


-- 
Luiz Augusto von Dentz
