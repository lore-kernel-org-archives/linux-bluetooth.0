Return-Path: <SRS0=4Twx=DT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50272080A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 16:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRmd2yQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403964AbgJLQny (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403962AbgJLQny (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Oct 2020 12:43:54 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E91C0613D0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 09:43:54 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m22so4988435ots.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4e3SwxtTLY4AeHrQDDsd9T2Vljvm1WRjaXtyZUqDfG8=;
        b=lRmd2yQKA3ljEZ6nyTI/m1BdMqka7UzUtXf2hCJXVyznpYtq3asKzblR9VXsL7jy94
         RtUTvU53Bxlp/jsQgrCHXOfj7876syOSf+wXhjUlW3XatJdSZ3jb6cG/dBT5H5GVjL49
         9daeQFbc4Csnlu4zF+MrqpTIwY5Zlpn2vQ0AOLXjvvrst84UydKyCqTV/QB8XNA0rMAi
         qg0kGMihwIXeuqZkQB7WZ5O5OkDFE3ROBwZsfzQUK+xuCzHDTHcQQoja2SfuIE6W5LvM
         SInWx88/MPsFJpZQdFpgiylLU8SJD1ntkwgCvCCqV9xK/mLz/qycgJM/vcW0R023D82b
         F6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4e3SwxtTLY4AeHrQDDsd9T2Vljvm1WRjaXtyZUqDfG8=;
        b=VRS1JZA1hF7v9q4GeOpArVdBwFdRPJas318QAWUk3nQmPwE6KL9K37Pw+vKDYUZBuf
         vazz/6gkVZFnrZorIOAnNUqPB1rieFr2hCWiM5WSlVgotIqvyl76bndo/jFNWX9Bhlqz
         a+rVdWmFeWav/nrkndEASb67WDfYOPYncwaHhqLorRRNSgZX2ZG/hqQUNjfulsD/hbe2
         K6BDb5geDUad+3aMciUa8MrR+cNM4Mvsqavl5JnecMeVKf1Bx8CDZ7Fn7By2MiIyOaHc
         OpBT1kYKETpgQeAbuBzPDEbCEO/j+rHLzwGLDvaoCtQD3hdsoM5TkLFGrIwmS2bev6do
         watw==
X-Gm-Message-State: AOAM530cYr1XwPaD0IWCEgGd9zVNlJYRhVPWDh3ksZbAwSoh7+qC3Xjz
        oJOk+SZ4QY7LQkqQIFGzT8EtY7VFYMEHH6ReK4c=
X-Google-Smtp-Source: ABdhPJwzqFNBIyUEooVt0ndiL3rdvqkIBx7CMRmyUZL42TP1X79KAsEuFmn4pYji85AEdEdLCofSzIMvDr30moufPrs=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr17934119otq.240.1602521031938;
 Mon, 12 Oct 2020 09:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <333e38b3-da26-e3c6-76fb-1ee1caf90299@tcd.ie>
In-Reply-To: <333e38b3-da26-e3c6-76fb-1ee1caf90299@tcd.ie>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Oct 2020 09:43:39 -0700
Message-ID: <CABBYNZLFV6THotUuzATG0YJFgDh9cFoU575QqLD+Q2+EHoiPTA@mail.gmail.com>
Subject: Re: Bose QC 35 Battery/ANC Support
To:     Peter Mullen <omaolaip@tcd.ie>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

On Sun, Oct 11, 2020 at 1:04 PM Peter Mullen <omaolaip@tcd.ie> wrote:
>
> Hi all,
>
> I've been working on a plugin that adds support for battery level
> reporting and Active Noise Cancelling (ANC) control for the Bose QC 35
> headphones. The patch is nearly ready to go, but because of the
> non-standard way it's implemented I figured it might be necessary to get
> some preliminary feedback on it prior to submission (or to see if it's
> worth submitting).
>
> As a brief overview of device control, the QC35 has a set of additional
> controls operating over rfcomm channel 8 where messages are passed back
> and forth between devices. The messages consist of a 3-byte opcode, a
> 1-byte payload length, and N-bytes of payload. There's some more
> information on the specifics here:
> https://blog.davidventura.com.ar/reverse-engineering-the-bose-qc35-bluetooth-protocol.html
>
> As this is a non-standard "profile", there's no profile UUID assigned to
> it which makes adding a profile somewhat more complicated. My solution
> here was to add a profile under the iPod Accessory Protocol (iAP)
> profile UUID which the QC35 lists, and to then filter out devices in the
> profile probe callback based on manufacturer ID, device class, and
> product ID. This isn't ideal as the probe will be called for any device
> listing the iAP UUID, so suggestions for alternative approaches (if
> necessary) are appreciated.

We could in possibly add pid/vid to btd_profile that way it can be
probed by pid/vid in addition to UUID, that way one can make a driver
that is specific to a vendor or a product.

> For session state control, I've hooked into the AVDTP state-change
> callback. Again, possibly non-standard but this seemed to be the best
> way to trigger the initiatiation/tearing down of the rfcomm connection.

I would recommend hooking to the btd_service state, like for example
the policy plugin is doing.

> For battery level integration, I've basically just wrapped the dbus
> interface from the standard GATT battery profile. This has been working
> fine with my DE; the battery level shows immediately after connection
> and updates as the level drops.

We had some discussion on weather we should continue using a custom
D-Bus interface or just emulate the battery reports over UHID given
that is probably better integrated with the system.

> For ANC integration, I've added a new dbus interface under
> "org.bluez.Anc1". The interface contains a read-only "Range" property,
> which indicates the number of discrete values the ANC can be set to, and
> a read-write property "Level" which gets/sets the level. This interface
> layout was chosen to be device agnostic, so that ANC support could
> potentially be added for more devices in future.

I'd probably add Bose to the name of the interface if it is bose specific.

> Let me know if there are any thoughts on this; I can get the patch ready
> and submitted if desired.
>
> Kind regards,
> Peter
>


-- 
Luiz Augusto von Dentz
