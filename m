Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FDEC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843E222C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nl+JfdfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCJSEq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:04:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40230 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSEq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 14:04:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so7150944lfe.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3fudmkkEvf4B9+rOYdbkWDvtuUoA45GUsiPjLXXO74g=;
        b=nl+JfdfU365M1mIb+Wp4SwFoVGSKcyLhesZ5XofUST8l2knckmJ7x01DHp4P6WGbry
         FtaFfxorZlB+EYsYk6gCo5j4HLsnWjePhiLNdOmAahrrdQYveg25IlVV/SceTnKuXD/z
         oCrnas9ijFsRdoPvresVoEZI6oH9Oys4+mNlCgf+SteWQKzZ31QRd/fQku5/aN+t84wp
         NFyPt76j3r1PpPxvhCu+C06PEq0mjw0FlttHV8fR+yXD4YZUU1pclOh3HDerI0zPYpAy
         qA7JhmAREbwmuoLtIthp0qoOsyNg1Fy78DT2QYmmIE2HlPmEbWJVwjxI7U9/1FAX0iOC
         MsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fudmkkEvf4B9+rOYdbkWDvtuUoA45GUsiPjLXXO74g=;
        b=tT5yUSauHgfahcq/Ra33wYZdftsTs4y6L6+fXcKoDoE5ga+46GqEB0qvbWlDLxbbkp
         FxaB5gPhqzQ+BVvQzrCqToFq7bB7u9umxUi1pVKDV3TRjE8+vP570xZwY9rXqSERMWpx
         2EoqKcp1V1iByxY/2FEbyc8PDVLWp+6GxfyuX7ugdPf6FyzgJAT3B1OME7qKQE+NcRMv
         Puw9MgkltJdl3apf+S68XJLgy/rd/NZbb5F6dd5irL5rPIRyGXYaaF420SME9LBpnnuz
         /cs83E9o8OsVoSjStJFoCD/CfkWhAFtXyeHIAerETsN1OAQ7MNhpz9Q3I1nTMPzhFHBT
         jmWw==
X-Gm-Message-State: ANhLgQ1YfbOxPQfAr7/TC4D0YL7l7zoNM0CY/Pf+DLeLLpzv+7Z+V9bp
        0W+QLMrVkgLV/uX0wvdwj2My2S3wVYp7XhSVwcA5uA==
X-Google-Smtp-Source: ADFU+vtKYuyuVQVSGR57h7Ue1hzokPgyw6qeVM3q+QlY8gdDoqrJLscthPNP+NXegLW5lulTjTRZMLganzx95bCyq5w=
X-Received: by 2002:a05:6512:49e:: with SMTP id v30mr4201433lfq.158.1583863483872;
 Tue, 10 Mar 2020 11:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200310173649.32722-1-luiz.dentz@gmail.com>
In-Reply-To: <20200310173649.32722-1-luiz.dentz@gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Mar 2020 14:04:31 -0400
Message-ID: <CALWDO_U+J1mCf1TzeWM=tSvy-NCsxnyoMeHppFsLKkaaYTiwug@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Mar 10, 2020 at 1:36 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This attempts to set the security if the device is not bonded, the
> kernel will block any communication on the ATT socket while bumping
> the security and if that fails the device will be disconnected which
> is better than having the device dangling around without being able to
> communicate with it until it is properly bonded.
> ---
>  profiles/input/hog.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index dfac68921..f0226ebbd 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -49,6 +49,8 @@
>  #include "src/shared/util.h"
>  #include "src/shared/uhid.h"
>  #include "src/shared/queue.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-client.h"
>  #include "src/plugin.h"
>
>  #include "suspend.h"
> @@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *service)
>         }
>
>         /* HOGP 1.0 Section 6.1 requires bonding */
> -       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
> -               return -ECONNREFUSED;
> +       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
> +               struct bt_gatt_client *client;
> +
> +               client = btd_device_get_gatt_client(device);
> +               if (!bt_gatt_client_set_security(client,
> +                                               BT_ATT_SECURITY_MEDIUM)) {
> +                       return -ECONNREFUSED;
> +               }
> +       }
I wonder if this is really necessary.  For example, this may cause a
device the user has not deliberately bonded to suddenly expose a HOG
Service which will trigger the user to pair (most users are known to
blindly accept the pairing).  I believe the previous posture is more
secure by having the user deliberately pair HID devices as opposed to
on demand.

>
>         /* TODO: Replace GAttrib with bt_gatt_client */
>         bt_hog_attach(dev->hog, attrib);
> --
> 2.21.1
>
