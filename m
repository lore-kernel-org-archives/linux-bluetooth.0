Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CD1C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 21:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5171D206F6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 21:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBK2v2cS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgDCVl5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:41:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38148 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCVl5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 17:41:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id t28so8897831ott.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+pTd8MnSsCum1ecuHS8sXQ0EgvSlsuHN6dM4YW5VNY=;
        b=EBK2v2cS7JUXxpllab3f1I2lxYE+Br5Q7daAA4eKkOymV4WCpST4t3gj+/CF82KDfV
         nJQIucPPYnqMSQ2NXlvApbNeAD6FY+bkrIaht9JYMdXB3SJtj6csS0kez/6P23CLzQBu
         70Lq8o7ftclBJh1a0Xe7gWPI7nHa+Mulat7tLU3UuVHgwlFaPOrn/tA/pM1XxBVG9pec
         tMaPChVrKNyJELtqCI+0J6P3bYjINrC36uMsLgU2ywcAV9RVEwf8UEB6TMErVb0IxYGP
         aM2Nwvoh0YwnnZv3KwuTkRX7BZqk9RM12VrlOxgau4nU/1QxzHlHgEtzo4tf6jMkIVrZ
         /5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+pTd8MnSsCum1ecuHS8sXQ0EgvSlsuHN6dM4YW5VNY=;
        b=O6uyFkQZIxZ5BqiV6Okwb+tW0ZBfHl7yIkfjnfAb7kL1/gCSikuMDg8XGoo485qqjf
         b/AvzwBsjcF0/4qkS/FI6idxy22wNrQF3aHsG4lnku2WKe001YPJYzgLfuno2qo1mq18
         NMBeiPhug44XtzBUDOVq4NpJCSUFSTS7OBbHse0sUnn26zB8KYFQEFDs+6wnjZkN71bL
         l21bFZEdWr1+oiZ17y8EfX1t/1Si1CHaayhx2okXoyWNYWEgjbER6LSl0KEbKz4J+6tP
         PFogrt1aGfqEpR99LcMfP0IDdbRaaZAONElI18Iuv2+7d865JmXfq5FIDncDGnTKlJ49
         U4aw==
X-Gm-Message-State: AGi0PualgPOuGUa0QV2aW8rcD5doutYp4AX2d/GoXFPhWFta9aKF5Mjb
        3JjusNTDgHr5GZwXNcgDbRTnDZQEaKkRR4GEoK8=
X-Google-Smtp-Source: APiQypK3rgMWz2HyoBrlUeieuW+vJI/q7KmH07Xs0ri30CkVMzBncHN2eNx59YZWQo6vRiGdT5Ywju7WFnEuK9mrgSU=
X-Received: by 2002:a9d:67c6:: with SMTP id c6mr8211875otn.11.1585950116424;
 Fri, 03 Apr 2020 14:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com> <1585899591-14623-2-git-send-email-thorsten.klein@bshg.com>
In-Reply-To: <1585899591-14623-2-git-send-email-thorsten.klein@bshg.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Apr 2020 14:41:45 -0700
Message-ID: <CABBYNZLOjT7bp=M+P1QDLh2pAB0rBwjnbG5zvfaVKh_ZqQkMkQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] ManufacturerData field added to ScanResponse
To:     "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Schachschal, Maximilian (BSH)" <maximilian.schachschal@bshg.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thorsten,

On Fri, Apr 3, 2020 at 12:42 AM Klein, Thorsten (BSH)
<kleinkastel@googlemail.com> wrote:
>
> From: "Schachschal, Maximilian (BSH)" <maximilian.schachschal@bshg.com>
>
> Keys are the Manufacturer ID to associate with the data.
> ---
>  doc/advertising-api.txt |  6 ++++++
>  src/advertising.c       | 25 +++++++++++++++++++------
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index b0565ea..14ccae2 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -51,6 +51,12 @@ Properties   string Type
>                         the Advertising Data.  Keys are the Manufacturer ID
>                         to associate with the data.
>
> +               dict ManufacturerDataScanResponse [Experimental]
> +
> +                       Manufactuer Data fields to include in
> +                       the Scan Response.  Keys are the Manufacturer ID
> +                       to associate with the data.
> +

Don't really like to do this, beside it seems to be optional to enter
either on AD or on SRD so the scanner is really at fault here if it
only able to parse the data if placed on SRD, that said we could have
some logic that detects if manufacturer don't fit on the AD push it to
SRD if that has more space if the advertisement is discoverable.

>                 array{string} SolicitUUIDs
>
>                         Array of UUIDs to include in "Service Solicitation"
> diff --git a/src/advertising.c b/src/advertising.c
> index 45ff19f..0e1a3f1 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -328,12 +328,12 @@ fail:
>  }
>
>  static bool parse_manufacturer_data(DBusMessageIter *iter,
> -                                       struct btd_adv_client *client)
> +                                       struct btd_ad *ad)
>  {
>         DBusMessageIter entries;
>
>         if (!iter) {
> -               bt_ad_clear_manufacturer_data(client->data);
> +               bt_ad_clear_manufacturer_data(ad);
>                 return true;
>         }
>
> @@ -342,7 +342,7 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
>
>         dbus_message_iter_recurse(iter, &entries);
>
> -       bt_ad_clear_manufacturer_data(client->data);
> +       bt_ad_clear_manufacturer_data(ad);
>
>         while (dbus_message_iter_get_arg_type(&entries)
>                                                 == DBUS_TYPE_DICT_ENTRY) {
> @@ -373,7 +373,7 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
>
>                 DBG("Adding ManufacturerData for %04x", manuf_id);
>
> -               if (!bt_ad_add_manufacturer_data(client->data, manuf_id,
> +               if (!bt_ad_add_manufacturer_data(ad, manuf_id,
>                                                         manuf_data, len))
>                         goto fail;
>
> @@ -383,10 +383,22 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
>         return true;
>
>  fail:
> -       bt_ad_clear_manufacturer_data(client->data);
> +       bt_ad_clear_manufacturer_data(ad);
>         return false;
>  }
>
> +static bool parse_manufacturer_data_adv(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_manufacturer_data(iter, client->data);
> +}
> +
> +static bool parse_manufacturer_data_scan(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       return parse_manufacturer_data(iter, client->scan);
> +}
> +
>  static bool parse_service_data(DBusMessageIter *iter,
>                                         struct btd_adv_client *client)
>  {
> @@ -941,7 +953,8 @@ static struct adv_parser {
>         { "Type", parse_type },
>         { "ServiceUUIDs", parse_service_uuids },
>         { "SolicitUUIDs", parse_solicit_uuids },
> -       { "ManufacturerData", parse_manufacturer_data },
> +       { "ManufacturerData", parse_manufacturer_data_adv },
> +       { "ManufacturerDataScanResponse", parse_manufacturer_data_scan },
>         { "ServiceData", parse_service_data },
>         { "Includes", parse_includes },
>         { "LocalName", parse_local_name },
> --
> 2.7.4
>


-- 
Luiz Augusto von Dentz
