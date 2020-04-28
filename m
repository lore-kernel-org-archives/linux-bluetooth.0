Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4707C83004
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 04:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFF7206A5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 04:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jg+Gg59i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD1EbE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgD1EbE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 00:31:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CCC03C1A9
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 21:31:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so21359084wrx.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 21:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SpQ7K6wQ1aj6ugFVjXXQYvTcE/OMVm1XliEHKMaaeNw=;
        b=Jg+Gg59il240ihNv9nAFDFFPvKkQ7f5seJCULvryFAIOBUhlLmb8xm42NRexVQYEPh
         CFNge4kjXrjkocHcnt9azXmEXiflbqV7C91IgOwYiCsZFf8EIRgqNMP/1bKs8Fq9x0Cs
         vK9zWZDjwHf3ANgRbmi6HbRc2Ug3ssiQzo7THdmi/+qewUuxSDz0vHpyH+61nFMzC64Q
         Hru/dcT5gEct2aGE+bmfdo+m7DZD5WNf5nAU8QFOaB0zBZHIu8s4oIf6N5GFmqm1E+X2
         8PWED9Vh9atqXZLh7bMTLpoejTHdiFsPI8499kbDnJ+Y0Bxuf+1dMcuPCyMzZAWbFU5l
         TPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SpQ7K6wQ1aj6ugFVjXXQYvTcE/OMVm1XliEHKMaaeNw=;
        b=RfffWGJ3LTWOrEQsYy+hEUCjGZFdCKci+GoJVvL+n3cIWWFJKMqXvOfS4IOM3FNXa5
         5qjOhGNK6pJZq2LAR+6CXjF1TmSxG8MqCrzw60xOynqqTElcQf41qyvUe4TeMLZ8g0r1
         leqALjcBh8LIqoznJyTxDuyXfKHBfhYyiCJTRJT4/u90TIWhfPz1aSH3qUOvuBiiMWA4
         oGSG+RlWNoyrT6nnhbM95TaWWTDFtv4mFkg+Ghwd7Bjc7Joy1guWxGfWGk+5LZofvTKO
         QIo5QwLsag52IZenSjOr26FTxrmPXBZWKj87M66mJ24IN45QFOc7PTm2xOJcEE1u5aJq
         xAAw==
X-Gm-Message-State: AGi0PuZS+HYsgbGnUznEU1eeZXojNlEV9Xn2E0M/UQgACqpQI4aOcHIp
        wpPjZVuq9Vh9fiG/cTF1I4VzPBtlGr3f+xOjeZJA1bG4
X-Google-Smtp-Source: APiQypJK/GF4MtWl26ThFVvamteuWqeAB0/Knw3gMUaybqyymjuZhDaH/INRNiHn+IfwmhAedKrwtrfkS5fYlu9+2vE=
X-Received: by 2002:a5d:5651:: with SMTP id j17mr30223539wrw.406.1588048262099;
 Mon, 27 Apr 2020 21:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200421155828.Bluez.v1.1.I6e4fbf41b1815dc3d497da5d9c94b18e9c912cba@changeid>
In-Reply-To: <20200421155828.Bluez.v1.1.I6e4fbf41b1815dc3d497da5d9c94b18e9c912cba@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 28 Apr 2020 12:30:51 +0800
Message-ID: <CAJQfnxFxJwgAj+JWFFCG+b=zDRSX04a1e0mA2cB1fCpsJmoMug@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] gatt: Fix service_changed characteristic permission
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi BlueZ maintainers,

Please kindly take a look at this patch, thank you!

On Tue, 21 Apr 2020 at 15:59, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to bluetooth spec Ver 5.2, Vol 3, Part G, 7.1, the
> service_changed characteristic is not readable. Therefore, this
> patch marks it as such.
> ---
>
>  src/gatt-database.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index f2da27694..8cbe09bae 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1197,7 +1197,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
>
>         bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
>         database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
> -                               BT_ATT_PERM_READ, BT_GATT_CHRC_PROP_INDICATE,
> +                               BT_ATT_PERM_NONE, BT_GATT_CHRC_PROP_INDICATE,
>                                 NULL, NULL, database);
>
>         database->svc_chngd_ccc = service_add_ccc(service, database, NULL, NULL,
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
