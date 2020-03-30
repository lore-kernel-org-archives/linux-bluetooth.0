Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A587AC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 23:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7236620784
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 23:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eky9+P5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgC3XOh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:14:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41692 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XOh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 19:14:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so17300911oia.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 16:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rknbqjutgBSTudD2Y4+sw3QTe4JdzLaehn0U2S3BNU=;
        b=Eky9+P5fAHRPmWdrjwfWpXFS1ONOwkpHhTeqaekddHI1qjLMxFkWUzY6tkpPlJRVJE
         5s2rzZDOi1/nVFVUI2Qz6hXgxLBkj2R8Wg3LcHvkpgY3efA9sZzkwWAopOPBb1gFVoqE
         uoPu97ySj+lp0dkex3vm8AlH2cIcHYVrIw5pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rknbqjutgBSTudD2Y4+sw3QTe4JdzLaehn0U2S3BNU=;
        b=BaosWipnoG3gcXSyrICfICMhCfVaXbL4kZG5hcRd/rar62uup8DuxKnYf2Q0mZ8pDa
         zQWDbAlwcNzmnds0eSsonFukHTHbXzZpPd/5vdI/IBCJQVHpyr9hQ+kbbaxdsLtWcJ2F
         YCVX8uScalAlJo87jlyTpYxycFeg+bAIpiQaN7r9ChmEgVYtbl8iJC55me7lUaonp6Ut
         FzoiLIn3tE7EmOwsmT8ajK2nJbmriTaJvRqqp3z2fCr8ZqWPDEflpKv/m3OfF15vGEqu
         tmypsSuGgPLkndliKRS5WWHDcKTx68kYXr01MXdWqPJyDCnd2mkgmhVwFw6Dw0GaOW3S
         oIAA==
X-Gm-Message-State: ANhLgQ3e3KN5cfvKy+XlTW/UUyjb3wRE0INEiU2jUwRILUIbw7HzueUY
        jcVXhcTq8ZPnZRmdxCBBHoTPyXT1oAEvYpfxjklN8dtx
X-Google-Smtp-Source: ADFU+vtukEEsROiZkHV64NMYREvY1ellCkjIjKNCOuoqmuptmhNbwfEdLRAzT2TiRSAEGaifb6BPWxNrB2rbLzQU0ow=
X-Received: by 2002:aca:d10:: with SMTP id 16mr334707oin.142.1585610076831;
 Mon, 30 Mar 2020 16:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003423.14079-1-sonnysasaka@chromium.org> <CACE38CD-C394-4420-900A-3FF35932AE3D@holtmann.org>
In-Reply-To: <CACE38CD-C394-4420-900A-3FF35932AE3D@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 30 Mar 2020 16:14:24 -0700
Message-ID: <CAOxioNk-XHEOLZXenaYOhid5t7d44vFm2C6sqmk=a_2PABHejw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Always request for user confirmation for Just Works
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks, Marcel.

On Mon, Mar 30, 2020 at 3:24 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > To improve security, always give the user-space daemon a chance to
> > accept or reject a Just Works pairing (LE). The daemon may decide to
> > auto-accept based on the user's intent.
> >
> > Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> > net/bluetooth/smp.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
