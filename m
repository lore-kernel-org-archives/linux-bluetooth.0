Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B117C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DA42077D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 18:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fbpv8Xk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404405AbgDCSBd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:01:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43450 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgDCSBc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 14:01:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id a6so8168442otb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuBbPMKDCUHal3YChYN7SwAq5qn+4cOH1ygeT0YfwwY=;
        b=Fbpv8Xk3jcW7V3DMp6gFLQOpJhRU5pFM6OzlabKX3Xxsr/7HcazaC5Tx1QUB0prE+N
         ZePhL+ZClVuVP2CzDaGWGIlZmz1nqovDyyvgUfY0KFnmE15DVzZMBgX8X3fLyp2ZH8fn
         OZd1WvqKX8KXrxF1hegX4CGIvQu1sOkjVD/z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuBbPMKDCUHal3YChYN7SwAq5qn+4cOH1ygeT0YfwwY=;
        b=oBviUrJn9uSGyb++LMTN1Jl8B1Pn+mAqsAOHal/AVWmRAXBCOgSZ2jwH1anRb6PVwS
         vaZuFLrKFrQYOvhGZRXpaTLS9+N2arCG5S2922pXS6UcDXgoV6MZmR8dFOf5Emha0zK1
         8IoFXaroSabErw3dDoQllapug4JjRuWrKq23MAUB75PmSqqgoyZZtRL2QZyR6YaIKIQU
         L12CZCtNBkLjUjDtapg8NOvOV7MPzqHkVzDeJEgQgSk74zx9mhafw4VGWTguIwtOWakk
         S+LWiUgUbvppdeb6NK3tWBbeKkKT/3OHy/dldGW1StZuQWmjWVUqo/b02XErfgYvcv3i
         EXXw==
X-Gm-Message-State: AGi0PubxvwJuL54quTZS3sk/NyC7LlC02zUsHJKgBaOS1HeI2a32mpYG
        MgKZ50nCZ0rDnUS3gTjg9NcG8DAxR0BqQHPas7TKvFx2
X-Google-Smtp-Source: APiQypJBGykF7PbuGaiSGaa2NZpQg3Zla8ZNbFGjE2Si3Reh/FvJV0PQIXhkK3c70ZsjMvYKbc+7uuT/g/9miNCpyM8=
X-Received: by 2002:a4a:9c86:: with SMTP id z6mr7932543ooj.68.1585936891961;
 Fri, 03 Apr 2020 11:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200331003355.14614-1-sonnysasaka@chromium.org>
 <7CA6DAE1-09E7-4CEC-BA78-E8C4E104D92E@holtmann.org> <CAOxioNm27+wmWeCp+hoWCF-5W1=xm_gdvn3xWbDJVeYE=wmyiQ@mail.gmail.com>
 <CC80769E-941D-4AD9-AFB3-C24DD84E940D@holtmann.org> <CAOxioNnC-sC1SxcK-=VjMLQa8jmQ6DA-uKX3cLfGK=2zXN6PcA@mail.gmail.com>
 <7FDB98C0-49AB-4AD6-A997-7C04386B273E@holtmann.org>
In-Reply-To: <7FDB98C0-49AB-4AD6-A997-7C04386B273E@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 3 Apr 2020 11:01:20 -0700
Message-ID: <CAOxioNmG7O47vT-WQGdwMjGqbC4DVTy7hda1W7cHGCSK+i4nYQ@mail.gmail.com>
Subject: Re: [PATCH] tools/hciattach_ath3k: Load BT board data based on
 country code
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>, yixiang@google.com,
        Zhifeng Cai <caiz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Ack, thanks.

On Fri, Apr 3, 2020 at 10:58 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > There is no need to apply the patch. I sent the patch because I didn't
> > know of the deprecation plan. Thank you for the feedback.
>
> actually I did apply the patch. I really dislike if distribution carry too many patches. Just remember that this tool will go away eventually. So make a plan to upgrade to serdev.
>
> Regards
>
> Marcel
>
