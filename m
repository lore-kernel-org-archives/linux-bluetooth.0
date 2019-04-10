Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13AC282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE7820820
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554925890;
	bh=gLqxa+fXD7ZR+IdyPU5iivWrSAnfZHb5FWMr81rU764=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0XPqiZL1Uko2kMdFYVaEsIGPKW3fe+qzDP/XRmePMJQt5I86OyvPrJqufC4TD0vwa
	 PDAdtqmfbhV0yn4h5QYKDmvuQ+yu/wA9cseWQOT4oT1r/THiYfZS36enlodk8O0MKi
	 iQETYbjh+T9rqsdbzMES5sBcV4hh8ofjDmyqScls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDJTv2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:51:28 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:33854 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDJTut (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:49 -0400
Received: by mail-lf1-f54.google.com with SMTP id o199so2773241lfo.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2019 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyqnNvbfmn5m1e4SIudC+WMARrUmp/Qx5i0nxm+Q0lw=;
        b=eVQ+3v+1kuVPCQhKn6JTctvz1ha2XK3y1oD4BjWDkgXVAfqE6/TQWRVurqMlxNzfaA
         rKuAaAp8gAkIFKC9/euTBToRXmNbqpaVY5UvBowdRbsgmFYQF75PNXT5bDtXDaSiSD1W
         g/50tACWbFVgSeXTeqshZtg2JQuQ91MQZMI4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyqnNvbfmn5m1e4SIudC+WMARrUmp/Qx5i0nxm+Q0lw=;
        b=U/RunYQ35enNSPnTisB3C3yWX0SHFV3nTJt8zCPDM/mfTEWo3U5iT/kq/SIu9EEjuI
         xAhLv+ObtGHd9pFVqYg3L1Nvo4pmFg1Q97X9hZHY/klRpXJcNNxGUSmz2PNuCsEK0DeY
         qf0szN3AL6wp33BR+tzt/9+69rokMisSGTpHzV9Ti7wIr4e8wgML45Yp6xYMCWpkQvAM
         pkRcjRIZmC5CaUoKNaqH2TsoYO/DLNplzGXgO2YOWS6yBKoMIsxEuV0VpFRSZVzf9O9T
         Q4IX9p7rt+HuD6fbA1bhFjAVH6Au4nOZDTjeIuAGLxI9mqkRdrS3Uop4NaUZeHPbqAmM
         CvWA==
X-Gm-Message-State: APjAAAWQo4nj3a5Yt7CoD+63OWGRkRbAXFdMITZhryyAxdHhsOOwQ1Qv
        8r0ByO3pvjPCJ6A5R1dD0Kj42IntipA=
X-Google-Smtp-Source: APXvYqz/kq6RyWTVN3YdIqt7NnbDNrKnmi8tItGwfOP3KVHb8Ai5in1xmGauA1e60+56jEAbXUALrg==
X-Received: by 2002:ac2:5457:: with SMTP id d23mr4346735lfn.11.1554925847001;
        Wed, 10 Apr 2019 12:50:47 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x6sm7216098lfe.67.2019.04.10.12.50.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:50:45 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id j89so3280636ljb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2019 12:50:45 -0700 (PDT)
X-Received: by 2002:a2e:420c:: with SMTP id p12mr24527546lja.1.1554925845465;
 Wed, 10 Apr 2019 12:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org>
 <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
 <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com>
 <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com> <CA+ASDXMYiDpYx06LDrZcn5gVWu_7q3DK5G0Eb1jmwjUJZAA_KQ@mail.gmail.com>
In-Reply-To: <CA+ASDXMYiDpYx06LDrZcn5gVWu_7q3DK5G0Eb1jmwjUJZAA_KQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Apr 2019 09:50:29 -1000
X-Gmail-Original-Message-ID: <CAHk-=whCWwWwdqbeYTDTSTWC11czp0QxR_FUuzeAgSpjRj7Gig@mail.gmail.com>
Message-ID: <CAHk-=whCWwWwdqbeYTDTSTWC11czp0QxR_FUuzeAgSpjRj7Gig@mail.gmail.com>
Subject: Re: [PULL -- 5.1 REGRESSION] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Brian Norris <briannorris@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 10, 2019 at 7:44 AM Brian Norris <briannorris@chromium.org> wrote:
>
> I think our key difference here is in how much we trust the device:
> knowing the quality of the firmware running on some of these devices,
> I wouldn't totally trust that they get it right.

No.

You claim that IRQ_NOAUTOEN makes any difference, It doesn't.

I claim that you should get rid of the disable/enable_irq() games you
play, and replace them with just requesting the interrupt.

At which point the whole  IRQ_NOAUTOEN dance is entirely pointless.

Just don't do it.

This has nothing to do with trusting hardware, and everything to do
with "why do you request an interrupt that you aren't actually ready
to accept, and the hardware isn't even properly configured to generate
yet"?

See my point?

               Linus
