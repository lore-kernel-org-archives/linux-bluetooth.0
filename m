Return-Path: <SRS0=2B3h=CF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB2DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 17:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9AF207CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 17:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROO70edL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgH0Ryy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgH0Ryv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Aug 2020 13:54:51 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260BEC061264
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 10:54:51 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n23so5109768otq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxWSHY4tkPz7kEIppnRnRKwJg/ftBtShNG0VfcOcllg=;
        b=ROO70edLc3yR8M4k/6F4f7W67wSQ493oDcm8IK5ZVfLv//zwHrYYm4oGp85zwEW2Gb
         eqLymJ++shHHrd3DFWCiUTSefTaDYPtZkkBVtb0p2n0gJWEZ1VyPec1qbUWF/Eh0jH1/
         cLTh3wufLPAifohZABvLSwfeqneqrCY1BWdYULvE58wIbdmjCXRR3HNjEMKHLRmgAksg
         4cBW+Kic/KNEA3rJG+A6LMoDbpwKaRYI5HH0KH8lLV/xNNN8VdXbcyC0znTEC4mIDnw7
         Sf1WMRrgcLN/X/zleThohYArLx4AZO/rSLdLfakC4/979qZyRETjwODDqsDjKAhDCNDA
         sDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxWSHY4tkPz7kEIppnRnRKwJg/ftBtShNG0VfcOcllg=;
        b=DCoRDSZHlHQ+VVOWbsxBk6g1LmYPeaAOmk3ZvexG2POojCc5xkt/Oxxr3Scf1l4HzB
         +eFwuceMJfjT7jKZMGTlfBEYNEut8kt85VLj2K3wUwh7jaAJVRNhpw9IHh+Qz4XHbIKR
         ecQMxOugQ32VWcgkwRx8vxkN6onLW7g/WTQc8noyDk6gmb8lf2n5aCZQZ9m4Ow0nVPDW
         F+p+j62+bRcYbgHBn+jE0LyStxiMISnGyVX9HKYFgLgI0Yewo7IXZpy2hQhPzqvsSnXu
         otKbGKr4hf6EhGZPBTsAPQTJMuMLZH4hqNWQn1vroB7KatXbMiQL9rzPBm9xa0447lZh
         bPag==
X-Gm-Message-State: AOAM532SoSNpHLFY+X7ClXR19Z+04WcEDjP0r4Imr9cMd6gqQhnL+pIY
        5PPdiOIpdCqKBOECvlfcXkmpGhDw/YNWd9S3UEm1yuMb
X-Google-Smtp-Source: ABdhPJz29ZWvS/3nQqb4tWNOcZtjJwAdCUZj/cSBtc9JTb9//jrN/7vKdxhu5IQyviG9G98CSYmmuUkVavYoREwqQO4=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr13543766otj.362.1598550890523;
 Thu, 27 Aug 2020 10:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200826063742.76007-1-sonnysasaka@chromium.org>
In-Reply-To: <20200826063742.76007-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Aug 2020 10:54:39 -0700
Message-ID: <CABBYNZ+EPTW1OHcZj_JYRrpbKy0zMbLQ9gc2yRCntxfEJDwXdw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Accept empty array in parse_includes()
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jie Jiang <jiejiang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Aug 25, 2020 at 11:43 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> From: Jie Jiang <jiejiang@chromium.org>
>
> Currently parse_includes() will return false if the "Includes" property
> is an empty array. Empty array in the "Includes" property should be
> treated as valid.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>
> ---
>  src/gatt-database.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 07d567078..e7e4a36a6 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2008,6 +2008,7 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
>         DBusMessageIter iter;
>         DBusMessageIter array;
>         char *obj;
> +       int type;
>
>         /* Includes property is optional */
>         if (!g_dbus_proxy_get_property(proxy, "Includes", &iter))
> @@ -2018,9 +2019,9 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
>
>         dbus_message_iter_recurse(&iter, &array);
>
> -       do {
> -               if (dbus_message_iter_get_arg_type(&array) !=
> -                                               DBUS_TYPE_OBJECT_PATH)
> +       while ((type = dbus_message_iter_get_arg_type(&array))
> +                                       != DBUS_TYPE_INVALID) {
> +               if (type != DBUS_TYPE_OBJECT_PATH)
>                         return false;
>
>                 dbus_message_iter_get_basic(&array, &obj);
> @@ -2028,11 +2029,12 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
>                 if (!queue_push_tail(service->includes, obj)) {
>                         error("Failed to add Includes path in queue\n");
>                         return false;
> -
>                 }
>
>                 incr_attr_count(service, 1);
> -       } while (dbus_message_iter_next(&array));
> +
> +               dbus_message_iter_next(&array);
> +       }
>
>         return true;
>  }
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
