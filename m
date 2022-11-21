Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65766C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 16:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKUQh2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKUQhN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 11:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE34D5A27
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669048535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uey9BFIixQm3jWN0lqHsZfoFIxzEui2/+ljprIZsSVk=;
        b=euZoWVfKAIy70rx9X9u3kMhxNpBAkse78PxeTLd4MVJTu5E4p5Pxa+HN4GicAHKLdLuStc
        27iX+5dP4VDMO+WUf8UvxVfVOxGsbiCeRo3vCxL5QSLRr1y/umcV8qL4/R4250QgiwQgsX
        mx80/R841V9B2mc19szu6vbpZt/+eTI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-xuiuaZqcMAORRkWEcFgYqw-1; Mon, 21 Nov 2022 11:35:33 -0500
X-MC-Unique: xuiuaZqcMAORRkWEcFgYqw-1
Received: by mail-pf1-f197.google.com with SMTP id u18-20020a627912000000b0056d93d8b8bdso7764452pfc.16
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 08:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uey9BFIixQm3jWN0lqHsZfoFIxzEui2/+ljprIZsSVk=;
        b=ZTv1Fj3k0Ic8dTlY5c0bYLDMvf4ANzkkqKgqKB/KNR0FlaUOZ5VapUj6ytpc970sNq
         FXICixpLO9H1h5ul95HVUppr24Oho3Fiz71UR6YN4O5rF4O9tAUDhvYBR7+tBc07f8gw
         UQFKYWBBMvETIV9YcxGXlPcHRbWVmOs3Sxp8McGjSARDPpXuJhnq/Z9P98eNM1pY12C0
         U363KNmpYy3ZiCm8QHK54HI+kPt5W/YAP1Fu4xDiib9EA+PwmpVuIltRRQStJ3QD2ylM
         Loy800YSHDtJ/98UoF5PPClDqDz76nAqGOmgXOealThUo7w/6xfVYViYn3TxdRcq18os
         DCUg==
X-Gm-Message-State: ANoB5plj5De7KcDCTYuzWf98O1oaioYuTUeJwuQHJ6BMINFsygitubzo
        wCBPWyyXD/9E3ofUF9Opr1kWyIJAXWzc5stwHZ9GbUp88bvH6Sp8pZ5Oxa7A6ePcg37HmP1gfDR
        VMn6dXbRFgpke5eRMAxImOj1BCrRW8SjDQjTyxs2Q12oU
X-Received: by 2002:a63:4b24:0:b0:476:e640:d016 with SMTP id y36-20020a634b24000000b00476e640d016mr18242053pga.205.1669048532472;
        Mon, 21 Nov 2022 08:35:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7A3cpC0Y768q6n1BR2+cjhQQLfduwmt/qipZb46MWH2KWTEDz0/0nve5ZsdnK6jxmJPLAACt67UFW/baEpj4U=
X-Received: by 2002:a63:4b24:0:b0:476:e640:d016 with SMTP id
 y36-20020a634b24000000b00476e640d016mr18242036pga.205.1669048532227; Mon, 21
 Nov 2022 08:35:32 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
 <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
 <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
 <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
 <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net> <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com>
In-Reply-To: <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 21 Nov 2022 17:35:20 +0100
Message-ID: <CACT4ouf8vDzhXkFAOh-LAbi1GKYp66YNMG_5VrkW0CqnxVBt0g@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 12:08 PM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com=
> wrote:
> > the fw 74 seems to be a different issue - could you post more info abou=
t
> > separately?

This was my fault: I was checking many different things, and I checked
this with an outdated kernel. With latest wireless tree and fw-74 it
works fine, both with the patch from this thread and without it. Sorry
for the noise.

So I will wait  for this patch to be posted so I can backport it to
RHEL, but using fw-74 also fixes the issue, as you said.

Thanks

--=20
=C3=8D=C3=B1igo Huguet

