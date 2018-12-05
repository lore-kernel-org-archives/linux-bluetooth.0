Return-Path: <SRS0=1GGh=OO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9342CC04EBF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Dec 2018 12:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E89720850
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Dec 2018 12:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeExl23O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E89720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeLEMKM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:10:12 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37987 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeLEMKM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Dec 2018 07:10:12 -0500
Received: by mail-ot1-f50.google.com with SMTP id e12so18406657otl.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Dec 2018 04:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ueBQlxcrbASqUOhcHRsoRzvg2pOyMlOEtu5cbqND82E=;
        b=OeExl23OVyQZdWOmD/css9B4ja+H7KTWg+BEOGrQRqrF234XJ7dWlcbbUfz1pkTwKF
         HxNL9N5boY32gL4lwpgp61HzqSc541hgwsDtO8tWetuk5O7Kio1LY6QeqPx43pAoLYiX
         0zpucNTdZ85+4rVgV1G5HgifqyxGN4H4MTY1PmILDxf252PZFpkwoNigv3/d74dUWK1o
         MD7FZCBPOUd0yYO+RcBzJEbBcx7Bg3E7q0bIvP7JTtHFnngbBaJyvB6OB7uqJe3ClnkO
         D3gioI3X+OZO92sp4a2QpxlXNpyxdHlCL/1Y911OOn+gYZIEBqDr2iPNkCzHWojx8Ph6
         MB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ueBQlxcrbASqUOhcHRsoRzvg2pOyMlOEtu5cbqND82E=;
        b=mtR7TbNa7bxlewyrrmXgsyuuGAO3gtDO1sDqkiShQQgvWFKV6IRHZk6+YnTlBzPv+y
         fa14qBTGSLtHOgUH+0CIYTdrkej2JjZvBKJmN24cWhr5UMmkdYvpRm45S4Lvp66+B3Nr
         n2Rgdl+OIDy4w/zDFHl5fo6aCg9EuCy1ui++rVRHCvFxX/x9J7BdBHwHJ9+lmD0Eqhlp
         Tg9hRrBZFqUQvIn+zxHaihsCwQszZnY8BJkHHbWPG5vjSZD8NVWyw8QB5roqVHkdQK36
         kuEdpw14P6xJqtK8M+AkQbNoKsOrcwIBhW1+HbViWN/ZcFrD0fq2G0NGKfXv5IEC3/50
         N1Zw==
X-Gm-Message-State: AA+aEWZUfj2ij3sAEETrwhnZ+vCJMfVjp6jsk/OpixnsL83AmAk0uX0m
        LYnIxQPW/arjx1t2B88jdvzbC33oXIQ74XVjAE3G2x60
X-Google-Smtp-Source: AFSGD/VubMX4FmYR+e7d+FBCcKLfxop6hH2tW7eKO48glAb8coNQQIt3lHNmUm9Ks5zAE1d6WHbHj/uCzT80UHQYT8c=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr16060032otl.342.1544011811726;
 Wed, 05 Dec 2018 04:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20181204194429.13829-1-luiz.dentz@gmail.com>
In-Reply-To: <20181204194429.13829-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 Dec 2018 14:09:59 +0200
Message-ID: <CABBYNZ+3PmJv98iY7UHLZJTS5rquaJeh71DsdtAFuyyqDkoOwQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Register GATT and GAP services as SDP records
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Dec 4, 2018 at 9:44 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This ensures that GATT and GAP services can be discover over SDP as well
> as over GATT.
> ---
>  src/gatt-database.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index c31afa0e9..2c2f035b1 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -847,6 +847,8 @@ static void populate_gap_service(struct btd_gatt_database *database)
>                                                         NULL, database);
>
>         gatt_db_service_set_active(service, true);
> +
> +       database_add_record(database, service);
>  }
>
>  static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
> @@ -1071,6 +1073,8 @@ static void populate_gatt_service(struct btd_gatt_database *database)
>                                                                         NULL);
>
>         gatt_db_service_set_active(service, true);
> +
> +       database_add_record(database, service);
>  }
>
>  static void register_core_services(struct btd_gatt_database *database)
> --
> 2.17.2

Applied.

-- 
Luiz Augusto von Dentz
