Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89EDC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 12:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E1D21873
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 12:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU6wQ0Mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfCVM6f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:58:35 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:44584 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbfCVM6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Mar 2019 08:58:34 -0400
Received: by mail-ua1-f43.google.com with SMTP id r21so683865uan.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2019 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eS4rUlj272yGSPanlxVfPUZMu/SIwd0YpEg2TpRZZEY=;
        b=dU6wQ0Mo3UJvpHPgRUtz1RoReR6CEpCREgg3yfnkPymIGpfFg9xmeh3UdZZjVcqizI
         hpJdBHZmCYGsvy98wqH/RJjoVN3yNZPEcW5sFGWMcsWO9vDf+BdCBYVkNOZvHTgT2oIx
         Ye/st2oSkOwv4ATNZUFlDX78UxUY2VhoTHjimxRKg0/r/7HLWbYFN9WL4rAfgCtg4UT9
         MBlXgb4/DIEI732lxsGgN5n9NT6TUk3LEyC4maaZpyqaRPlgnriezB7RVQKaa9YB8sHD
         ewBZxf1jnJNcoafnxCanqtAlrVBz/AYEuXjTTEFBB7c7cvc3M8PLB+bH1eRfxVm4Rp2L
         W/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=eS4rUlj272yGSPanlxVfPUZMu/SIwd0YpEg2TpRZZEY=;
        b=TgYvb9JW3dKAso2DzqrPn71HdR6VvF+mYxKF9qtm4tkYnhMdXv8McOXTIBKkw2qYJa
         TForP+W6pRh9MMBLKfC2966c5otsZmV7Kre43pkhx7Gi4CbPCXLMyhHGh0HS9Okq77zx
         vMrfzF9uvDFpJerF+odzKwTnJUBenqkkSU2eSl6gtb3CID8yJ3eEVX5U5In0yq0Mqe4w
         qBcfY/0X71f1qv3wLo/foRpJ/8ZzGP78Zhtqut3r97bbnjyElTSqTZ3ABecOE2OwP+xy
         2Q94sErEb5fjgRe4eqz0C9X0Tf4yQdwOpD3BInkGHbNBgr5HGf4oHbs9BZhmBJ1WRzhF
         zd0Q==
X-Gm-Message-State: APjAAAVQq/s/8hu0RCAXT5sI8RGkZTUgRLNmfUhC3pEdThvVZRjtsyZW
        RA4/mowrVhKAxoI69Ru6gfantNaBDOFSuD61zGaEf0iy
X-Google-Smtp-Source: APXvYqwub3OauE+mFWcL3B80rL/VTgpOcgUYaljIyqXbuGgfPEjo4qQ1DQzCtSpukacw1M4KbInAzcEJARWTPsKz7ac=
X-Received: by 2002:ab0:714a:: with SMTP id k10mr5168180uao.82.1553259513270;
 Fri, 22 Mar 2019 05:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+5PdQZ19gL9Rc_mDZ+kOOfyucA8oOLOtdjoNNoD=+Dx=zLxyA@mail.gmail.com>
In-Reply-To: <CA+5PdQZ19gL9Rc_mDZ+kOOfyucA8oOLOtdjoNNoD=+Dx=zLxyA@mail.gmail.com>
From:   Christoph Schweers <christoph.schweers@gmail.com>
Date:   Fri, 22 Mar 2019 13:58:15 +0100
Message-ID: <CA+5PdQacc+Q_s1Mz_AXdnGbLgS9WtuHx6m6ZGmhnufLeu40bLw@mail.gmail.com>
Subject: Re: Disable 'Filter duplicates' setting for HCI 'LE Set Scan Enable'
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am Mi., 20. M=C3=A4rz 2019 um 12:16 Uhr schrieb Christoph Schweers
<christoph.schweers@gmail.com>:
>
> Hello,
>
> I would like to disable the 'Filter duplicates' setting at hardware level
> with the HCI Command 'LE Set Scan Enable'.
>
> First I tried to tweak the 'DuplicateData' parameter from SetDiscoveryFil=
ter
> (org.bluez.Adapter1), but this doesn't change the value of 'Filter
> duplicates' parameter. btmon shows always that 'Filter duplicates' is
> 'Enabled'
>
> I also searched the debugfs for a proper setting without success.
>
> Is there any way to change this HCI parameter setting in bluez?

I got further insights, a 'hcitool lescan --duplicates' does the trick

As my application uses D-Bus I tried to figure out how to archive this
behavior with 'bluetoothd', but I was not able to find any info about this
in the man pages for 'bluetoothd' and 'main.conf'

I would greatly appreciate If someone could give me a pointer on this issue=
.


Many thanks!
Christoph
