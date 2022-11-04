Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC4CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 17:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKDRI3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiKDRI3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 13:08:29 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968E431F8F
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 10:08:27 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id mi9so3608595qvb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jNIi3NLp/0QE0eLEgGhnlZnXslRxZtVSsauwMnJ52A=;
        b=TyCMiI4ARMPxd18RVlEv+qm2LWR7zC104Hlivn40qb5lZJslIeDFuCNMNvjneFE/Nj
         LFwCX5vAwmEX/R8qjGO9x9K9/hgdwoRd2q59WUqMzWoiDvISQjer+tTT1jJ7UfSLA8Vn
         fR3VeAjk206NeR5DC2lSXJH82ZME8JVM9jplc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jNIi3NLp/0QE0eLEgGhnlZnXslRxZtVSsauwMnJ52A=;
        b=UQAc+ao61lAR/3qjTAAV0lCwy3F+DSF/BDV9sJx4Xx5c59KLduzMklrm2kJzIs3ViO
         dyjL5I0GfxgpUAZwDNg+Y0LPaQD1+n1Euqh9yCdz3ixj4h2CBgHX+WGdyvv65FUYlXd5
         B4Jfildslnk9bwBWiUqNOxMgpr0zsLSKP0tDVAunQpL3dJgMgc29QYldGZ4WTRph5tV3
         ZDPjeHzhlp83qUVo1K4uTT3i7me9cNgqMO21KU4KOo+Q2kd4klO9yHT2NYCG9KL5f5wW
         8HLfGMMMQizIx7eTHKkqwzEvN5zikazWm/1qi36/+ZeQazb7DXIYKo0PpOd2k3xHwene
         VqsQ==
X-Gm-Message-State: ACrzQf3jklDoHrb/wvAoz8yiyf842rkznBXW227M738+30B4vGQK3j0r
        VLo3dqcR87mWCMcMeo/uK2cpvX3etrtI8Q==
X-Google-Smtp-Source: AMsMyM4yEo7JNZrwgPN2ap15162rV/rf3AOaKg5k5X3h+H1NZnuVV4DW3EZsFGKijIUg6r19hCej2Q==
X-Received: by 2002:a0c:f0d4:0:b0:4bb:6583:66e6 with SMTP id d20-20020a0cf0d4000000b004bb658366e6mr33526859qvl.123.1667581706533;
        Fri, 04 Nov 2022 10:08:26 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84996000000b0039953dcc480sm2746526qtq.88.2022.11.04.10.08.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:08:26 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 131so2138161ybl.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 10:08:25 -0700 (PDT)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr27409344ywf.441.1667581219811; Fri, 04
 Nov 2022 10:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org>
In-Reply-To: <20221104054053.431922658@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 10:00:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKE5UL+AuCC2wK8oq8D_ueSO_T7-9Acx4POouqVi8ZHg@mail.gmail.com>
Message-ID: <CAHk-=whKE5UL+AuCC2wK8oq8D_ueSO_T7-9Acx4POouqVi8ZHg@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 00/33] timers: Use timer_shutdown*() before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-edac@vger.kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bluetooth@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-leds@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Nov 3, 2022 at 10:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Ideally, I would have the first patch go into this rc cycle, which is mostly
> non functional as it will allow the other patches to come in via the respective
> subsystems in the next merge window.

Ack.

I also wonder if we could do the completely trivially correct
conversions immediately.

I'm talking about the scripted ones where it's currently a
"del_timer_sync()", and the very next action is freeing whatever data
structure the timer is in (possibly with something like free_irq() in
between - my point is that there's an unconditional free that is very
clear and unambiguous), so that there is absolutely no question about
whether they should use "timer_shutdown_sync()" or not.

IOW, things like patches 03, 17 and 31, and at least parts others in
this series.

This series clearly has several much more complex cases that need
actual real code review, and I think it would help to have the
completely unambiguous cases out of the way, just to get rid of noise.

So I'd take that first patch, and a scripted set of "this cannot
change any semantics" patches early.

                Linus
