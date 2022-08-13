Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF121C25B08
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Aug 2022 07:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiHMHb2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Aug 2022 03:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiHMHbZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Aug 2022 03:31:25 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF3183BDD
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Aug 2022 00:31:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 123so4563953ybv.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Aug 2022 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0o+izfVZjXN3pdahlXpbkj1dX4aHv6voSVsqXVYNcIU=;
        b=BFgWL0b/A2u/3KSbHPDS1arX31NnSM63HQVnHmca3V8GBvbTWk8qQvTlsG0fwGDcFG
         vL5mFP16FFf+unBDQtptwDluc1zDdU8ipku56HTxeyULcjUEFy8WJ64bhUVIB/IhSGNn
         sJ+1UjL2asGN3OBQ7sQ7k1VUQCT7xIwzz8QmbqoufkCq+oRTpNbV+B+PAlETC3ILQKUV
         pSn18hGjCS7txZYwfva0K5vSz+vCPZXcs7Zwn+t/2zharhdzspDk3C3oQUa1g3JgvKjW
         NTzE7uv3NfSfavpDYa6efr2rmAv9eE83RNiKPKpIHJgIunA5RNMUpCF9oXJxodZZqVzX
         JQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0o+izfVZjXN3pdahlXpbkj1dX4aHv6voSVsqXVYNcIU=;
        b=076fpYS2aNBk8lmcTKG2/uUlM6Dj/JqpUKUPocylhZAMrlA47JXqCIqGIGGe8v7jtN
         ONmh8Hq9QCV/X6YN8aynBjdaP0HVITH+nJRV4xHPtYZcE2/xQ2h8J3LhLF/y5hPMa7Qo
         cPnKRM751zff36nVJ/oTTo3Cr8e1VlMGbwttk2k7I+cvSKHn95VNPrU4ji1A9pF1O+j8
         Iy5tsceQeaBhCipW65omw6w6EY25h/WvonRmbTry7jtmm6lKuESR5GBCV+Lcrodf/l6K
         O1F4pXAMfDvUGOq9EJqnaJMAUsaLMaC2jgl1PLrxzbw2KZJBuPShzvm2J496BEZnSqQD
         lNhg==
X-Gm-Message-State: ACgBeo1lKDHvC4xe1PjKmYEs55VPjdWeBcZI+WcZfnoFW7TrhTAOIpxr
        rrwKlmh2MixVBw11Aa+eesGpgbk/YsqU35rJ/2Bj+lvlTNga3w==
X-Google-Smtp-Source: AA6agR5r0NzkRJTh2WZzl/pUH2x4zMroksIXtlxlGWM6JDhE+xXZKDymNTLQpryUnEezKGhOoQYqYG6kiaStO14M8Eg=
X-Received: by 2002:a5b:845:0:b0:683:6ed7:b3b6 with SMTP id
 v5-20020a5b0845000000b006836ed7b3b6mr3991553ybq.183.1660375882507; Sat, 13
 Aug 2022 00:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220812223939.530428-1-luiz.dentz@gmail.com> <62f6dcd1.050a0220.5ebd8.1241@mx.google.com>
 <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
In-Reply-To: <CABBYNZLOxE17vp3FOWR2hABjoCD8M62YLa6_LDdaQeJ=nrnusA@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 13 Aug 2022 08:30:46 +0100
Message-ID: <CADVatmN_wx=KJ=C0QGMz5ZLoVECjF9kKJa1X8ay4XWwuszeo=A@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix build errors in some archs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Sat, Aug 13, 2022 at 12:12 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Palmer, Sudip,
>
> On Fri, Aug 12, 2022 at 4:05 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667285
>
> Could you guys try with the above change, I think the culprit is
> actually setting c = NULL which triggers some compiler to think it may
> be passed to bacmp.

I get "No patches to display" on that link.


-- 
Regards
Sudip
