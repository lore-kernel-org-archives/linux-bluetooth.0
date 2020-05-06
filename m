Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E73C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFF3208E4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3WOutE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgEFQfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729444AbgEFQfY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 12:35:24 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F201C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 09:35:23 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so2317232oif.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H/67JCRYE9SIq5M6TDo8nSRX5PJlRjsbRBe3GiQXYrE=;
        b=f3WOutE0mRT5zwN1AXfsHxGa54bsDqbMdOTCEebFFDQZBaSMTTqKyZ2TssxT5jWpAd
         I+80Oyu4qxU5v5ZrstGx2JeWqOFDL3vkzvbOirJFdexZ1d6L62SVoIcZBoWTUpfwn3Ln
         Wg4mIa1+oDmX7EG1RfYrgeDkR+JZ5L3gydK5J3NPFRoc8dlDbgqt2FeFQkmKQcWA8QiJ
         OJc5s0OV1JVt0rG4jIcZ/S1k4oJkO4nHEqdDM0cUVdnPB3Riii+Tfjl5qq/Ozg6iHz+H
         JjxY9lsBBXzMceyO4xXS4Ex81JRIKxkLMr//My+2zJl8auXf46v9B31ea1peQOJfTsce
         N7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H/67JCRYE9SIq5M6TDo8nSRX5PJlRjsbRBe3GiQXYrE=;
        b=gAE2UdhqyMSXWk66FO4YW/Tw+9Ve2lu3wNsXI2gRQScvupiMKcPqfyGazBX5NLVGrZ
         tZ7kkKgozT/u33JdwdqAR+5N3HAcHF8XorWO4j1gt/1ds3aSZpRRS7BIxGDJfKhrbcR7
         XHys+yJ1TR5mdFZpAb8NPfjXpjo/Ycs7hy5dVxlqatSDKn+hRQGUugz50sfz54IIdtlf
         oorslfObyrcnn4U58+lzwgyjuZPyhNO2iONib2cZaN92arZR/kEcvpwo2HUDYg52GIJG
         Ov4sRjDSrcLi2ebkJ/AV74Tyni1hd1hmSEtjbUEnOQ8sN8ZJFQDiJBFPupVxluXWF2dn
         07rA==
X-Gm-Message-State: AGi0PuYQQg0cYqLx87SzCl+RKT7wk7upXeeYaLJ6qHIx8DDoruFijz6w
        HgIUJIIBbFOarxw4eYn8jcncG01OHUMmqaQsuiY=
X-Google-Smtp-Source: APiQypJeIQHzlBnn+8UuTvR2FwCujyq3s2OjjWIDDALTIbQGBuqf560daQHZ7xBj0M6JShd3QRkDKEgK7TimLh1i9yM=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr3432731oif.108.1588782922684;
 Wed, 06 May 2020 09:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200501215352.23858-1-sonnysasaka@chromium.org>
 <4A9E7F0B-4AB8-4330-BB2B-1A0EAA4EFDE8@holtmann.org> <a4650a5e465c23915d951b296ca86de9f2d91b44.camel@hadess.net>
In-Reply-To: <a4650a5e465c23915d951b296ca86de9f2d91b44.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 May 2020 09:35:10 -0700
Message-ID: <CABBYNZK2SwcOO0jdpvtcdyjHFzw=WNocRU-a37hRsK3=yJ+d3Q@mail.gmail.com>
Subject: Re: [PATCH] build: Add option to disable battery profile
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Bastien,

On Wed, May 6, 2020 at 7:14 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2020-05-06 at 13:24 +0200, Marcel Holtmann wrote:
> > I have a little bit concern splitting this since battery service and
> > HoG are kinda connected. Wouldn=E2=80=99t it be better we have a cleane=
r
> > interface. Maybe we should actually integrate cleanly with
> > /dev/upower or similar.
>
> Wat?

I guess Marcel was refering to something like uhid though Im not sure
that exists, or does it? That said one alternative would make uhid
integrate the battery status, but I guess devices can also expose this
over hid directly so I wonder if we can translate the Battery Service
status to hid power strength that way we don't need any communication
over D-Bus.

--=20
Luiz Augusto von Dentz
