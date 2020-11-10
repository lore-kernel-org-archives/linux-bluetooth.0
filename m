Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94F3C4741F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C24B2065E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20150623.gappssmtp.com header.i=@freebox-fr.20150623.gappssmtp.com header.b="L2zDObHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKJSBa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJSB3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 13:01:29 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF81C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 10:01:29 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id p12so1190423ljc.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 10:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=v0n5/J1KccCSBwZA2y/H17gxWlOuSMmfs0m2sTQRf9g=;
        b=L2zDObHGgv+gNdMt9Dsf+ThNmU3cCCVw0u3IFDdCcCl0k5ujHxXyfp0aY+4xPDNoSV
         aGer0v8PMpICZiyX63JqUfeRlU2tgFC60Y5FBkhWOC26/nHHL9ewbq9z2qnlmkToZbWl
         Y90xWLoVNgZuO5ioJXI2rYjUzpUgGojibZLHVredhOTZZPkitKJLChRzSEWsJQrieE6b
         el2UKEMQGutBMznkYMb1Nket9QFEhO2ka6RjwE9B27hK9QdwcL/YlJirhJwMnVewV1XV
         7jff7cXaaEowrjRK0GtrVz6zbb6EBXFPo17oxUR34yyiMJyou0jCLVhR6v01WukuiBfH
         AI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=v0n5/J1KccCSBwZA2y/H17gxWlOuSMmfs0m2sTQRf9g=;
        b=r2QRCf27KXR+hN3SZPQ09hwegAV2IqPu/DPecy3T/fdihlmoswxAqicmXU/N51WMn3
         IGRLjEI2vf0JpVVyl7koB+5CEQDRhX1zDHiLXtrewhkUb+qoCrTOXh4yu7l+Q/y8SY8E
         RzwPOfcY/LtzvJ4r/pqkLGLQ6b6m498CVPKWr5tdunRId4t1L2v0lcxEZgSOmdYNT05N
         RRXp/e+DCVw6JdaBNeWi+gxPaSlMljdfbikfMbbaIxGx6det9XCw6ohyt4PjWdY6Bdm5
         ORCgNqY2pNez41015aOCn4J4Kz9I9HIr19bHPGwXYBn5Dq2DIIyA/RgKa1dtFuF94Pub
         JYqQ==
X-Gm-Message-State: AOAM531PgbKmdCVWoSrDUgbU09DRRdVU4Lt+dJFcio8qJbDbb2h7yDHk
        l2KkaOBEnjwy5X73Cpjkygilg12yZHxCEmWUlJbjrg==
X-Google-Smtp-Source: ABdhPJwFmOMJ1KHKAlr1kH3S8t3hSOpfDQtzL5tCSOOyGEc4qlSBJz/jtzAkPdEI1XhcUgzkk6/cU7oHLeWEjkOEa0k=
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr7811451ljf.241.1605031287556;
 Tue, 10 Nov 2020 10:01:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHNNwZCdPyetZeM_ArHsAoAyVPpciG_3WHv=QuaQx2+6BAdWOA@mail.gmail.com>
In-Reply-To: <CAHNNwZCdPyetZeM_ArHsAoAyVPpciG_3WHv=QuaQx2+6BAdWOA@mail.gmail.com>
From:   Nicolas Schichan <nschichan@freebox.fr>
Date:   Tue, 10 Nov 2020 19:01:16 +0100
Message-ID: <CAHNNwZDfPnyh9Syo6UZ9hzdUaYB5db_78O+bhCgsZ_ADxj0o+g@mail.gmail.com>
Subject: Re: Bluetooth RPA timeout related intialisation failure
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Sathish Narasimman <nsathish41@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Nov 10, 2020 at 6:50 PM Nicolas Schichan <nschichan@freebox.fr> wrote:
[...]
> Changing the mask from 0x40 to 0x04 made bluetooth work again as well.

I probably should have searched the list before sending an email.
Sorry about that.

This looks to be the exact same issue that I have here:
https://marc.info/?l=linux-bluetooth&m=160378222632366&w=2

I have tested the patch in the linked message and it resolved the issue.

If the patch in the message linked above is in need in for Testbed-by
tags and it's not too late:

Testbed-by: Nicolas Schichan <nschichan@freebox.fr>

Regards,

-- 
Nicolas Schichan
Freebox SAS
