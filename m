Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B057C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 20:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1306206F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 20:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hStsKtHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGMUfj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgGMUfj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 16:35:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC44C061755;
        Mon, 13 Jul 2020 13:35:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h1so10583113otq.12;
        Mon, 13 Jul 2020 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMz/znSoLz9ThqeCcpe4Ta7Jp3PPK8McYiisRlujivo=;
        b=hStsKtHDhzby1OziHm2z4ZQk+Kkfk9/Mcn796MrAlo/9drWdmxlAcPuTuicZD1grg8
         gOUvemNn47pIFrqgyvq5RftLnHBTSYynDPES9gZSuekAexiFT9dShOwrZRuuhCsjdIqh
         ES7X8I3oQSjgC+hvYTE3PDBnuUSgpuzKNC8phve2H4f08dQFHIj3hqlFBB6+2e9U+RHa
         8VhPOTCx0CBu1BhdtKziMQKKtcAVkMbsAVh3yBQsMHplFKxpnR0/w0t4VXU7HeH1n8fD
         Tlm1bW3dEU6cd7uCSqivbZGo3Nu/+d7fPAQATByu5Q5b5yNzHn1idjFVx5fSTz38CQVh
         xLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMz/znSoLz9ThqeCcpe4Ta7Jp3PPK8McYiisRlujivo=;
        b=lfDsDclCMtmmyowBjBM+YtoAWVCrWeOKIrxZD9k6a3wYTzapPhbS9mZ4U6MAY64sr0
         5W29LMVglOwAqob1TYXqUtu3eTkxtzSWlxdH2x4bfPY9aGqsFBe6goB7XQU2viFcYkPS
         r1bXzcIWwtZwzIm5rA+/NqVbqUiiHf0RdHPCsgYjsxbP4zEXDt+bhh2qTl1s/v6/lAFa
         Zdjs7YNrR6CoiL4BPkrJNIRwjPw1dROIblwKRaIXahqKUIjAbvnGcq+F8qqAhXslhRBc
         9YwUhENO0Y6F8ncg8GxIb7gtBooDc0CNKDvtloz6LWnQft1jy0dS7CodmMdbdMN8O3BH
         S0Ag==
X-Gm-Message-State: AOAM533Lohmq9+kch1vq7HCtU4bNME7Y0MaU9h7jeGmRY8zqp6CpzzZe
        uwr4Z1PRvNVip0HCrXnQk+gJyxrfJ737BKxp2iE=
X-Google-Smtp-Source: ABdhPJxAwXcETK2JBSmwcyZs2GuvhTSgKHjPRSVCcrg3mbOwWp1QuZ+rnU6DBdJFuhfZkIsMgRa2b/NB+zG/bhT6xxM=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id v19mr1233271ota.91.1594672538465;
 Mon, 13 Jul 2020 13:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200713201441.235959-1-sonnysasaka@chromium.org>
In-Reply-To: <20200713201441.235959-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Jul 2020 13:35:26 -0700
Message-ID: <CABBYNZJ+7SFRra4S890bv+_oCbUXHPexVmxvGS2pAzdnHyhJXw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Per-device option to enable/disable internal profiles
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     linux-bluetooth-@vger.kernel.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Mon, Jul 13, 2020 at 1:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> This patch series adds a mechanism for clients to choose whether to
> enable BlueZ internal profiles (e.g. A2DP, Battery) for specific
> devices.
>
> The motivation behind this feature is that some applications (e.g. Web
> Bluetooth or Android apps) need to have control over all remove GATT
> services, like Battery service. With "battery" plugin being enabled on
> BlueZ, it becomes not possible for those apps to work properly because
> BlueZ "hides" the Battery-related attributes from its GATT Client API.
> Disabling the "battery" plugin won't solve the problem either, since we
> do also need to enable the plugin so that we can use org.bluez.Battery1
> API.
>
> The solution that we propose is that clients can choose whether to
> enable internal profiles for each device. Clients know when to enable
> internal profiles (such as when a user chooses to pair/connect via a UI)
> and when to disable internal profiles (such as when the connection is
> initiated by a generic application).

I wonder if it is not better to just have a flag indicating if the
profile shall claim exclusive access (such as GAP and GATT services),
so profiles that don't set that will have the services exposed so for
battery we can probably just have it exposed by default since it
doesn't appear to would be any conflicts on having it exposed.

> Sonny Sasaka (3):
>   doc: Add "AllowInternalProfiles" property to org.bluez.Device1
>   device: Add "AllowInternalProfiles" property to org.bluez.Device1
>   client: Add set-allow-internal-profiles command
>
>  client/main.c      | 38 ++++++++++++++++++
>  doc/device-api.txt | 13 +++++++
>  src/device.c       | 96 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/hcid.h         |  2 +
>  src/main.c         | 10 +++++
>  src/main.conf      |  4 ++
>  6 files changed, 163 insertions(+)
>
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
