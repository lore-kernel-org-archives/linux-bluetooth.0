Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A991C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2004A21850
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 15:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6IiI1GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGCPHU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:07:20 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:39221 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCPHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 11:07:20 -0400
Received: by mail-oi1-f177.google.com with SMTP id m202so2351653oig.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjBHIw1mVzvkRtA4exdDflfFeF/rBXHNSev11+RBIzk=;
        b=m6IiI1GHALs4GQggRysMIcyhSg/Toy5qWVervamCPk/gHzR4k+pCcJA2etZTwJMgnp
         N/0CVFaylMyBU+x4bvvjgU3DZ5cDMR6xDGY4ZWK//ejXwHfrAZVmzJmrAIbFFofDVDAZ
         bXxxme63GB8Tl+osj5eGxVypp2XkVVbZBV0P22K9dXJeP2q9wCJUrA7ycOEntGFUgMJq
         feiW5sBGGXtnoJsORb6XgiwyNU8XNNlQtQlRpib9+Gh4kYJ+lB7Qz91aJpWJJJoZyDMd
         88j6J7YuwX2uKkiEvqDeTje4Nr8tB4NfKzmNBJtbOtLFwd4m6ndQrqjKTKlRzKVsUrn9
         H4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjBHIw1mVzvkRtA4exdDflfFeF/rBXHNSev11+RBIzk=;
        b=hR5apCBzA8sGLT2dK0gHnWcRV+GUs7Ccytsifloug1Da+SRxNjTi5Jceb8+4QCrslB
         ZKM6/nAqBgSSz1A/+NabWwfMyKhRFErSIMRHtrhFR+cOi98+rW4HZVfs37Dt9Qj30b3T
         VhgGj5k52Nx0SN3eBIAA2FcnRYK14AVX+YEDs+u6ReJOpgLAFkbUD5irewALPw3/TX9z
         HyRCeKFSmA6AkkdY9JSfX7mHaIaisX20qPPA3qNkPTCNTW7FDJ+yJj7Zcb0IFhgOjeNm
         tfGh5WjS5rauCexUg4GvWk04qdZmQVXAeAis//4E7L87Gkj84/YJjcOlUssqdHaE4mTN
         4Kdw==
X-Gm-Message-State: APjAAAX9ViDfGNjHfIHoWMpm5HQ8b5PEigRYFmsh+6SzddN8laLWNgTq
        J+PFuRXcsPtLMGLzlZDXrzqQPoW0OmuDNnTLO4U=
X-Google-Smtp-Source: APXvYqwfC//Nb4Fv7D9hcwwG7mZerlyJaSDP4MmeLh9cXagmQfEDGS4qxkZbfrheQ14tz2pWc3uDvPXP0R9Ksed6pxk=
X-Received: by 2002:aca:e4c9:: with SMTP id b192mr7211251oih.82.1562166439633;
 Wed, 03 Jul 2019 08:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK_dC=N+YvA1mH5XJDO-P3CV38NbK6UiLrBQe9na-AT8yraVAA@mail.gmail.com>
In-Reply-To: <CAK_dC=N+YvA1mH5XJDO-P3CV38NbK6UiLrBQe9na-AT8yraVAA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jul 2019 18:07:06 +0300
Message-ID: <CABBYNZKf5=Kvi21Q=HH8f2KLo0qCTe1U=DeY2QfEGi46m-5x3w@mail.gmail.com>
Subject: Re: PTS test case (GATT/SR/UNS/BI-01-C) fails with Bluez 5.50
To:     Edward Fung <jjsheepman@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jul 3, 2019 at 5:42 PM Edward Fung <jjsheepman@gmail.com> wrote:
>
> Hello team,
>
> I'm performing PTS testing (PTS 7.4.1 Build 2 and Bluez 5.50 stack)
> for SIG certification and the test case GATT/SR/UNS/BI-01-C always
> fails with the following response error codes. Can anyone shed some
> light on this? Thank you!
>
> Test case : GATT/SR/UNS/BI-01-C started
> - Running test case with ATT bearer setup over BR/EDR.
> - BR/EDR Connection setup successfully.
> - BR Security not initiated due to TSPX_security_enabled value.
> - Sending an ATT request with an unsupported opcode.
> - Received data 010C-0000-04
> - Invalid Error Code received. Expected=0x06 Received =0x4.
> - Connection terminated successfully.
> -Final Verdict: FAIL
> GATT/SR/UNS/BI-01-C finished
>
> Test case : GATT/SR/UNS/BI-01-C started
> - Running test case with ATT bearer setup over BR/EDR.
> - BR/EDR Connection setup successfully.
> - BR Security not initiated due to TSPX_security_enabled value.
> - Sending an ATT request with an unsupported opcode.
> - Received data 010E-0000-01
> - Invalid Error Code received. Expected=0x06 Received =0x1.
> - Connection terminated successfully.
> -Final Verdict: FAIL
> GATT/SR/UNS/BI-01-C finished
>
> Test case : GATT/SR/UNS/BI-01-C started
> - Running test case with ATT bearer setup over BR/EDR.
> - BR/EDR Connection setup successfully.
> - BR Security not initiated due to TSPX_security_enabled value.
> - Sending an ATT request with an unsupported opcode.
> - Received data 0116-0102-01
> - Invalid request handle received. Expected=0x0000 Received =0x201.
> - Connection terminated successfully.
> -Final Verdict: FAIL
> GATT/SR/UNS/BI-01-C finished

Is this all the same test which cause different errors to be reported?
It seems to expect request not supported over invalid PDU, but the
second one is returning invalid handle which is weird, do you have the
HCI for these runs?

-- 
Luiz Augusto von Dentz
