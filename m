Return-Path: <SRS0=h9/h=US=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC1AC31E49
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436CA21479
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 08:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="hlJB1rlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfFSIbw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:31:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37587 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbfFSIbw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jun 2019 04:31:52 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so36345896iok.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2019 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ylMjhfbS4+9blNaDjdcp4es5BTIvyJGHmPrRMT/TaJI=;
        b=hlJB1rlfequpP1SUjwTqSzFVHTXGgz9q7VhnQYaI61rrxV09FtbvFojq/q9Fdj3L3U
         f668j67lMlIomwfYaebb0OJgHA1G3vVMUsLOOOj5h8tTFsMutKPSaX7CrJpe7mHm6wWs
         Pr+5hRWbj8EJF/rOWUJ+cyY/VpkLsgyHfkmvKCJqZFzhXhrQD7/E35lRQshuZLZGgYmd
         QlmRkkj6u2/NqGVotMQivYQin5uuJ2Fl1uVpeVFdvfxqg6J9k6xCM9RAue+CsCfITPnz
         FQKdNx9kYIcDWmZf/s/mO4a1KbOopQM7C9NrtotXlqhKbIVsLnN5SMFtQQjC3QPHdIGJ
         EiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ylMjhfbS4+9blNaDjdcp4es5BTIvyJGHmPrRMT/TaJI=;
        b=QcQxWvl3HvljdnsPKrICoOBVDf/vXm8n0e2F3vQpOO/1SNbrVHUqrZMLvvySDwWEum
         1eSltpe5HKvqHNagPftR5Qa7zIg8YdBgQNjJYzUYvwCO7DLejoozoj9czHmyi6DbBl0a
         1u+PxWiLD4ma/kJPQgGAWaNDENvc0zBaip1CIs0sEk/KPtV94HZvgQI7R1S7Q9kopjhh
         ajP5uJ4b26lulGkyMVDIDHiRoXfrMfI9UycmeflhmKslaFCnhQrBqCyqxWjVI0Lanqzn
         9dQzKsSrAQqk/LiTKQ+e7tgC+WgeKzhwEMzOmNn7r07QmGYBIrYjI35Yb20gGCSKU67A
         YITg==
X-Gm-Message-State: APjAAAVcmV4UkJTfOAvls4cuHvDlrzNscCZnJgGVBRtbD0CoVknPrzUP
        4nEMQVbCQNuQhuRY2MGEjwTlcoEu+/QAVS62ckobJg==
X-Google-Smtp-Source: APXvYqz3cc7FPH7OgdYiIxgw1Myk14qmvn/bGSTVblJRVRWvKYbEiw2ofMuJloTjgSnt1TsMT8NXOLQ1VQsvMbtQK3o=
X-Received: by 2002:a5e:d615:: with SMTP id w21mr7580093iom.0.1560933111826;
 Wed, 19 Jun 2019 01:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190619074851.24039-1-jakub.witowski@silvair.com>
In-Reply-To: <20190619074851.24039-1-jakub.witowski@silvair.com>
From:   =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?= 
        <grzegorz.kolodziejczyk@codecoup.pl>
Date:   Wed, 19 Jun 2019 10:31:41 +0200
Message-ID: <CALevQMaSheh9nY88L53bV==vS=7V0DBY6wFtf+A=UyHDnjYS=g@mail.gmail.com>
Subject: Re: [PATCH v2] mesh: Return dbus error code on Leave() with invalit
 token given
To:     Jakub Witowski <jakub.witowski@silvair.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jakub,

You have commit message typo "invalit".


=C5=9Br., 19 cze 2019 o 09:49 Jakub Witowski <jakub.witowski@silvair.com> n=
apisa=C5=82(a):
>
> This removes NotFound error from mesh-api.txt from Leave() function.
btw. what is the purpose of this patch (or why is this needed) ? since
commit message describes what can be easily read from code diff.
> ---
>  doc/mesh-api.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> index 2a800468b..c82732d2c 100644
> --- a/doc/mesh-api.txt
> +++ b/doc/mesh-api.txt
> @@ -112,8 +112,6 @@ Methods:
>                 identified by the 64-bit token parameter. The token param=
eter
>                 has been obtained as a result of successful Join() method=
 call.
>
> -               PossibleErrors:
> -                       org.bluez.mesh.Error.NotFound
>
>         uint64 token CreateNetwork(object app_root, array{byte}[16] uuid)
>
> --
> 2.20.1
>
Regards,
Grzegorz
