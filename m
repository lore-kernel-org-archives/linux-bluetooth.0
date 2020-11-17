Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9DC63697
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 18:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54682465E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 18:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVG7etzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgKQSNY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 13:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbgKQSNY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 13:13:24 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E33CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 10:13:24 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id c80so23602661oib.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmDnrp30VzXKB5snD3DTuIN4lxrki1OVtIDiu5GeY/8=;
        b=FVG7etzEm6W1CCLGajbK40IQpDLYY51OdcTcEZ6XyrVyY9R89UFNoDaFNX3if5RKDv
         YvMbr5WSWStxtvaHy1vbUPG/Q9I5CbxYIGfJ3nNUjknokIgj6c7xGbNj2yl0pms0NRCJ
         EWUd4+3z54wYY43W20TltXcIrN1DWGQYcAhBpw+6tFLFe4PgdM6UYxCf5KpvoOKY4S9w
         VMjlxdICpd59NPvCqppcgaLwloJX4QtUFRqbs68moxqpjoBVFKgy1CqhMkXUFhALKiG5
         pKn1OqWzWNkT69cjnYIE/6NPXo9NdAMv17cLFaAVlLXamYFN+UNz7AqIM72/IVll48U8
         u96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmDnrp30VzXKB5snD3DTuIN4lxrki1OVtIDiu5GeY/8=;
        b=uDT6uQ7OJxlqyQfrsEli7mOk2hx1I+M6Es5b6utmR7VLrGh3hP7RwQztRxzmPcuisu
         requNuhhRzLR06d8um/o/pOGDHRgoxn9VR1u6BXCs2u1O0icaOoBZsAhTa9lxKhCJ3pX
         uJA4X3wUlz6r900KS8GDqGQgs6o/NJcKaSTUGdVcroECmWPgJWZINHmoljhYkf9L0qGR
         3jl7KgHnDVENQQ+Q/4c5CzKOJI0UrB4k9V25J32uzxstdqEPv4RVhi3lwpiCL8WntCzd
         /nXSK9JHRTOCWFPzjE2HH3nsk+nVnWlVaf9WjjcXFfnCfrCU/uKa4PUr1WnKb6FTBMel
         Ku+Q==
X-Gm-Message-State: AOAM532tpdWsgkMkwA4VOh7bjMm8aNBFco8imXfKDUmk9NKXxi48/3je
        RMdd/t7fXzNiJEfdbE39pgZcPbbBprMxQzM7PX10lmkY
X-Google-Smtp-Source: ABdhPJwVHYxUruJy2G/nwzr3ONy3rgXlECf7ip9tCEZ4hCNdduJmSCDlpI3t7rV1jETJdts0ewoNl6GKykCpPfPyN4E=
X-Received: by 2002:aca:f156:: with SMTP id p83mr258814oih.64.1605636803303;
 Tue, 17 Nov 2020 10:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20201117155703.30268-1-szymon.janc@codecoup.pl> <5fb3fe46.1c69fb81.baefe.4e47@mx.google.com>
In-Reply-To: <5fb3fe46.1c69fb81.baefe.4e47@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Nov 2020 10:13:12 -0800
Message-ID: <CABBYNZKVGTwsecSbHwemZN7mrs+X+qcKVcoK5fgN=M58F7syvw@mail.gmail.com>
Subject: Re: device: Update cache only if content changed
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Tue, Nov 17, 2020 at 8:52 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=386087
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
