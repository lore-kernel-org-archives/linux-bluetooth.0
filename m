Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F32C54EEB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 15:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1C20753
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 15:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCWPCT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:02:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37168 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgCWPCS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 11:02:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so14986125ljd.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 08:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOVNgV2XL7No0fBNblL3Wi4RvNnDh+Ky/HUEgDMyr78=;
        b=pA4YV1C2TlM8uYsz8IRjE7MQ15f+U8glTeSaz55H9vNlk6QVEz29Elf3AJdV3oDIMh
         nCk1AolUbqo/G073O66F9cPojWzZ52Kqepdt5M0rfblv8mwBgecMB8iv24KUoqZugNw0
         z6CtpeqGC89V1HHzvcJrTlbGxTd3VDlkY/0fI9Odv3SopAT125bGXGgDhQvhnl/kJ5zY
         7dPAC+xglh3yNugj3vUcv6oS5FPQqoqZy7J5iXPK0R1i+FD55ZJlLo3Cg2zLvFE1Vojs
         yCQjF/v8Esu67yyKZ84QDw1FVegKhYrRmrc3ScMWxIGf7oe67a0To23Ir9ffr6JrMPtt
         fD1w==
X-Gm-Message-State: ANhLgQ0eZQF5Hpnow7Bfm4re614SnmXVn8xWTKZaGjrZE6iYWMTpZ0Qz
        96rPiRrGOcWdHpOPQFFqeOoA2UMHipCgoQ9oROg=
X-Google-Smtp-Source: ADFU+vtSGIIucNPepkbMWFbunL7u1hOTIHaALvZtRIrmIYkPpiOVOqpuXNKfVvgJhMUmDUO6+pBi+ij2RHNHAoahE5Y=
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr13887116ljc.42.1584975735908;
 Mon, 23 Mar 2020 08:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <F7B49142-FD11-4512-B2D4-0840556FC0D3@holtmann.org> <20200321165551.11928-1-smarter@ubuntu.com>
In-Reply-To: <20200321165551.11928-1-smarter@ubuntu.com>
From:   Guillaume Martres <smarter@ubuntu.com>
Date:   Mon, 23 Mar 2020 16:01:39 +0100
Message-ID: <CAMM3rS01a6UH=atXGUL6gqAvS9Mit4hqhzhBrEtVX7-nWP92Pg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
To:     sathish.narasimman@intel.com, marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, 21 Mar 2020 at 17:55, Guillaume Martres <smarter@ubuntu.com> wrote:
> Since then, I was made aware of the existence of this patchset, after applying
> this patch (and [3] which apparently only exists as v5 and not v6), my
> headphones stopped sending zero-filled packets, but:
> - the recorded audio quality is again extremely bad and robotic.
> - when audio is being played, the headphones do not emit any sound.

I figured out what the problem was: pulseaudio assumes an MTU of 48
but with this
patch it now ends up being 60, I've left a comment on the pulseaudio MR [1].
After fixing this, audio input and output seem to be working correctly, however
from time to time pulseaudio fails to decode an mSBC packet, but I don't know
whose fault that is.

[1]: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/254#note_444249

On Sat, 21 Mar 2020 at 17:55, Guillaume Martres <smarter@ubuntu.com> wrote:
>
> From: Guillaume Martres <smarter3@gmail.com>
>
> Hi Sathish, Marcel,
>
> > I would really prefer to have some Tested-by lines from people that can verify that this patch works.
>
> Here's my experience: a recent pulseaudio MR [1] added support for mSBC. When I
> tried it using my laptop (Intel AX200) and headphones (Bose Headphone 700), the
> voice quality was extremely bad. I eventually realized that this could be fixed
> by ignoring all zero-filled packets sent by the headphones when decoding
> mSBC [2], after that everything worked fine.
>
> Since then, I was made aware of the existence of this patchset, after applying
> this patch (and [3] which apparently only exists as v5 and not v6), my
> headphones stopped sending zero-filled packets, but:
> - the recorded audio quality is again extremely bad and robotic.
> - when audio is being played, the headphones do not emit any sound.
>
> Note that I applied this patchset on top of the current Ubuntu 20.04 kernel [4],
> let me know if it's worth retesting on top of the mainline kernel, or if there
> is something else I could try.
>
> Hope this helps,
> Guillaume
>
>
> [1]: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/254
> [2]: https://gitlab.freedesktop.org/smarter/pulseaudio/-/commit/bb716b03002841e1092b4200935566d5c1a951fe
> [3]: https://www.spinics.net/lists/linux-bluetooth/msg82149.html
> [4]: https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/focal/commit/?h=Ubuntu-5.4.0-18.22&id=93dfa5b8e12fed29933f3451db44d88c0e4b5aed
