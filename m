Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4BCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 09:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJEJvN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 05:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJEJvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 05:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E922DA8F
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664963470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVnoRHWfL/uXph9fh+9JwKJ/yaZo6gYLYksyFHbNHmw=;
        b=cg4cQrgFHv4iHnrHX/yi1AdnW+Nko6hidlNv+vqZsYzniymAuqMrgf9z7uNqqjF5mZr+l3
        oJYLgoWcvRtm67W+Sl+oLexLhIH17o/IPRf9GsFmsRQxDzWH5D0V0FHoGnZhm44a/1X2YH
        QQA29HIrgUZfSDqY5SBzvTY2dLqXI7Q=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-520-c4k5Y1LwMDa69mvMPehsIg-1; Wed, 05 Oct 2022 05:51:09 -0400
X-MC-Unique: c4k5Y1LwMDa69mvMPehsIg-1
Received: by mail-pg1-f197.google.com with SMTP id q63-20020a632a42000000b0045724b1dfb9so1709367pgq.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Oct 2022 02:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVnoRHWfL/uXph9fh+9JwKJ/yaZo6gYLYksyFHbNHmw=;
        b=p3WAsZzvF8YXr8DjT+aABeXEQbvAkkt/Et/Nq9FTOWDXKE3DEM6g6kXs1dxHZz4QH1
         hsvu7k69IaHB41e9nWYXx6qkMx1Fa6Rgfgx8dUwAkPQoVyLleqfEarcqA6baTuf/yfcB
         /3Bh35yp0+BkTvRAGT/exi6jfxAFL0CVDUEIiVyOhtfbjV7W99MYMNBCNeahN88H1Mjs
         Ukupl5gdBJdJNwc16fqee33Gqf7NLSEJhzA3o5273tlHi1XVORdcgGni6OzNXmOd+1BK
         55fVRaAE/GsgHXvw502LwmrzX8SFGp3xUo8HAn7JdZZ2DI2z597oFhcdjlFupVrhoklb
         buYA==
X-Gm-Message-State: ACrzQf1U5O1TPe5uhHTXG4WLxcSmjPDhmG5/sgn/gx6FzlG/Gobmlb73
        NK11bWYaqTgW09owJ3YezC30Irv/Vxq1akM2LCTfU7G4M18c84XetrCEVFGc3uJ1gfyb/vYEC5W
        tsRyOJfCc6nGxkVdSP/5T+yr4Q+tAafREIODb+X8yg+FX
X-Received: by 2002:a05:6a00:80b:b0:545:c0d2:9729 with SMTP id m11-20020a056a00080b00b00545c0d29729mr31839063pfk.66.1664963468058;
        Wed, 05 Oct 2022 02:51:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Fz1y00T7ng7HEj/X2cNDx9rAi25gQaQhbhvgxs7dUKMajX7H77hTgr3IT9SBNoosLAWGkMKemx1e0FBuW+uM=
X-Received: by 2002:a05:6a00:80b:b0:545:c0d2:9729 with SMTP id
 m11-20020a056a00080b00b00545c0d29729mr31839038pfk.66.1664963467795; Wed, 05
 Oct 2022 02:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
In-Reply-To: <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Wed, 5 Oct 2022 11:50:56 +0200
Message-ID: <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0 versions
 above 55
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     gregory.greenman@intel.com, golan.ben.ami@intel.com,
        jonathan.sade@intel.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 5, 2022 at 11:35 AM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Fri, 2022-09-09 at 12:41 +0200, =C3=8D=C3=B1igo Huguet wrote:
> > With an AC9560 installed on a system with Quasar (11th gen processor,
> > in my case) we're getting a firmware crash as soon as you try to do
> > something with the card. The problem doesn't happen with the card
> > installed in older platforms (8th / 9th gen), and it neither happens
> > with firmware iwlwifi-QuZ-a0-jf-b0-55 version, but yes with any other
> > newer version.
> >
> > I've tried different versions of kernel and firmware, including the
> > latest kernel and linux-firmware available today, and all of them fail
> > unless I remove all fw files above version 55.
> >
>
> I believe this is a duplicate of
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D214343
>
> which was supposed to be fixed in firmware, but evidently that fix was
> never backported to older images.
>
> Internally, FW commit d8887278 fixed this, so FW version 69 should be
> OK?

I don't think so, we've reproduced it with iwlwifi-QuZ-a0-jf-b0-71.ucode

>
> I'm not sure we can easily workaround it in the driver? Maybe we can
> detect the RF, but that's kind of awkward.
>
> johannes
>


--=20
=C3=8D=C3=B1igo Huguet

