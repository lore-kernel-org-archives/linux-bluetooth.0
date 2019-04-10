Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFEC10F14
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 03:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6F02075B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 03:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554867816;
	bh=pwYW5LDpYufYVBWlHVyuyKFi32Ot9rugHxniUv/K4bE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q8Jt+jP9iRB28cGkban8uiUw4uLnCx0RU2EXFFHAhtLhVJWAGuO4hu2BvwefITL7o
	 5wW5Y00L0734Jr2p3HzbzD3t3xkQWo7GDjCbDkXR7LEFMV4Hb8lbDQHrlfJd/mVIR+
	 F0dEaSBPQXCSFZ5pa603O87TtuDWsNrPQVIwQ73Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfDJDng (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:43:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38475 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDJDnf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Apr 2019 23:43:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id u24so617140lfg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2TY6+WDFY0M+O7zE/xS5KsETwIiGHgXd+XLHr+An+E=;
        b=DLU/vV5jjcXtx8wcFNtEF351Eqm+MTzENyAlOX8192y7r1PtpqynGUInvU1h4FklWQ
         +TlavDjtW31ZEW5ekepXPUI3FNy5e5vdnCI+QabNoFC07tK5Adcqy6UVRiEa95oQLv7K
         kdihWXxYUqabZkH+dlthFq/OAeynYwN6suYNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2TY6+WDFY0M+O7zE/xS5KsETwIiGHgXd+XLHr+An+E=;
        b=ulaxYloaiEbnWvm3+EQFhVWGAP+X/NxQCDO/jrDpoPnVW8TiMjpZ8nRpvoRJdE87/q
         ShuWbaNK3+22qujftmTABtNzaRIkXJxDbHiDX+aKv3ZI8NpGUUaSSS6tOGBNOR6SylDt
         maPgAw+ynOxdoT6KFnW2OMJNWZK/WylEUVtOgt6Kh8jXcTFxO9JJEq8+3kSNOmZTlyww
         WAgeS19iYjnNO1+CLQ3yrWsaJekY75kTFekRP93V5H9NGLuoEg7S51H+A4t57yjKiy7J
         s585LbHVm9Z3quiEOENvnnYn9dkPOq1uaVCnI6/jFWOmRmodaO7Ufii/qdDk+ZtdKaQO
         hibQ==
X-Gm-Message-State: APjAAAWou9MCe2OC33PMltztrnMu7Adhn8lX7BlZFubv5KFK1ifQuhQk
        6GDRa2Dd8pWZ0YbT1SS9SKIgwmJ8EWA=
X-Google-Smtp-Source: APXvYqwWrK4sJ0MvKORSopOH/4pN8Q1bhYUK1yM+T/0iW0SmWB8sIgry6RARQ9nw8Md4hjss5QeS1A==
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr12413580lfl.22.1554867813181;
        Tue, 09 Apr 2019 20:43:33 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id s10sm6800801lfc.20.2019.04.09.20.43.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:43:32 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id t4so730739ljc.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 20:43:31 -0700 (PDT)
X-Received: by 2002:a2e:9597:: with SMTP id w23mr15716867ljh.111.1554867811666;
 Tue, 09 Apr 2019 20:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org>
 <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com> <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com>
In-Reply-To: <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Apr 2019 17:43:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com>
Message-ID: <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com>
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

On Tue, Apr 9, 2019 at 5:26 PM Brian Norris <briannorris@chromium.org> wrote:
>
> So, I think the problem is still potentially present no matter when we
> request the IRQ. The "uninitialized" state of the hardware (or,
> firmware) just exposes the issue extremely clearly.

Well, I think that as long as you don't request the irq, and it's not
shared with anything else, the bogus state of the irq line simply
doesn't matter. So the NOAUTOEN shouldn't matter if the irq is
requested properly late.

Either it's edge-triggered and you'll get one possibly spurious
interrupt for an old issue, or it's level-triggered and setting up the
hw should bring the irq line inactive and you'll be ok.

But I've applied your patch for now simply because it seems to be a
smaller change.

But I think you should look into whether it can be fixed by just
requesting the irq once the hardware is really up (which may indeed be
as late as open time).

                   Linus
