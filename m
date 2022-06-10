Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078D2C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 20:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347415AbiFJUkF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiFJUkE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 16:40:04 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F41176084
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 13:40:03 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31336535373so3510357b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wDRce3AGrqfAbEy6z7LsvAHDJeb4VDZDD+z9sMl+S8w=;
        b=m+ShoRiCUwvEwhdVU4wv327nA2yt44jI0NN5VDou4sNHW4CrgHyc2Ztlo3TN5bx9PN
         mK3Cp3AK1yQ8mltkXweNfh/EhAv3rLBKSeh+rHLm4EcW+7yPMT6XI15aqmzfx2Xvh6So
         MVqKmhkt9j05dY52/t/3T0vYtLptTfW/BPh/W/wtGx7z2ziPO0yocPg/yaxGFQ1KP0/g
         jg6cwKQ2ca8LK+yxtw0+YCxnFdv4BJX9GU+rho+YomRDPRDNAXTlpmJ5jKFEE1bAjmOH
         NhMd6Gtk5r4EgkLBFXnK+8S3Q+R9hMg7y94GAL/tkkpfjC6T1rR40zD6oYn5XprEmUNL
         OEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wDRce3AGrqfAbEy6z7LsvAHDJeb4VDZDD+z9sMl+S8w=;
        b=n2ev4r3K3bVivEmXtYRsRsbsgRJhsAQOR8oAvNzAxosBtAvPrd7W3S2zJBH8ymRHEG
         RIikGwpatq4GQlvG1YqQ7TTaJsH8wUKnnW/tNyDL+4rrgdgSDF1pK3fqAd9jVvTbQR9+
         7DDtBzhloshx/kKJKUL/sGvetiuTD2ekES/QHw7wl0bpuvsNRfYidc/iVzSMBGFScz/Z
         h3K2+bEvlWVC4wzsGS5rfmWF0/vxNTzyyuk6aJqtSFcOsGGC6O9cU80dNf3JjhJ7egAb
         sizENpzs6naM87Uhh1etjcc8Z8zWU2i5jnO9DO5dHpR++94T27I1NJaAEWp6iibwjwLs
         Kl/Q==
X-Gm-Message-State: AOAM532FDD7aLwL8KE6dt8o5fF7b3qXORiaGyzQBDpCuC/NzDpdPXB0a
        tBtwdooBCioZLayFInTTLTHdx+g0sT5LQmHsJH6sgljO
X-Google-Smtp-Source: ABdhPJxtGRXdkeN/Y4J546HSYpnWJM832Fhx7LrbVRbqtp6lrriY/Mwq8ZQGkuNxaGl+xbxvCXhY3bVAsnTeq9M+GtY=
X-Received: by 2002:a81:be05:0:b0:2e5:6c26:59fb with SMTP id
 i5-20020a81be05000000b002e56c2659fbmr51767136ywn.94.1654893602955; Fri, 10
 Jun 2022 13:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220603223225.20296-1-puffy.taco@gmail.com> <CAB7rCThDckbnpLiooSUR9z0J1jdRVe0N2qTBup9m1Ue=OptCgA@mail.gmail.com>
In-Reply-To: <CAB7rCThDckbnpLiooSUR9z0J1jdRVe0N2qTBup9m1Ue=OptCgA@mail.gmail.com>
From:   Mike Brudevold <puffy.taco@gmail.com>
Date:   Fri, 10 Jun 2022 15:39:52 -0500
Message-ID: <CAB7rCTgu2a0yYcWneOToe-LQrjTyT0pW1sfFGoG0tYSaMgP=ag@mail.gmail.com>
Subject: Re: [PATCH 0/3] LE OOB pairing support
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Found the issue.

On Fri, Jun 10, 2022 at 12:52 PM Mike Brudevold <puffy.taco@gmail.com> wrote:
>
> More testing below.
>
> On Fri, Jun 3, 2022 at 5:32 PM Michael Brudevold <puffy.taco@gmail.com> wrote:
> >
> > From: Michael Brudevold <michael.brudevold@veranexsolutions.com>
> >
> > This patch series implements userspace support for LE OOB pairing. It was
> > tested against an nRF52 dev kit with Nordic's NFC pairing example. Support is
> > only for reading a tag; generating and sending back OOB information was not
> > implemented.
>
> Further testing indicates that the OOB pairing data was not being used
> (beyond BD addr).  I tried corrupting the relevant fields and it still
> successfully paired.  The bluetooth capture in Wireshark shows an SMP
> Pairing Request going out with the OOB data flags set to zero (OOB
> auth not present).  This is a 5.13 kernel from Ubuntu 20.04, so I'll
> check that it isn't a kernel version issue, but a coworker tested on
> an Ubuntu 22.04 instance and had a similar high level experience.  I'm
> still digging into where/how the OOB flag gets set for this request.

Looks like the issue is that I need to update the adapter code to put
the rand/conf values into the appropriate hash256/rand256 for LE SC
(was only written to use hash192/rand192).  With this change, I can
corrupt these values and pairing becomes unsuccessful.  I'll get this
updated and send new patches.

>
> >
> > Overall, LE EIR data is not dissimilar to BREDR, but the OOB blob starts off
> > slightly differently necessitating a different code path before reaching the
> > EIR parser.
> >
> > Michael Brudevold (3):
> >   eir: parse data types for LE OOB pairing
> >   Accept LE formatted EIR data with neard plugin
> >   neard: Update D-Bus path and interface
> >
> >  plugins/neard.c | 64 +++++++++++++++++++++++++++++++++++++++++++------
> >  src/adapter.c   |  3 ++-
> >  src/adapter.h   |  2 +-
> >  src/eir.c       | 21 ++++++++++++++++
> >  src/eir.h       |  4 ++++
> >  5 files changed, 85 insertions(+), 9 deletions(-)
> >
> > --
> > 2.25.1
> >
