Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B11FC47093
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 00:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8548611AB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 00:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhEaAbV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 May 2021 20:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhEaAbU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 May 2021 20:31:20 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E48C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 May 2021 17:29:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 207so4086667ybd.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 May 2021 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7+Z6tg6y/PQcmK6IpNtYDzXHZkFuCBJ+ODz8w4VB9k=;
        b=vU4WaiIWWe+dnpxVRXARbmbDAHTWTAjNa5ibsYQ06yAsZ11CDiqcsFVe+ZnGgNpldB
         2Pjv+CYtygYiTvZMGTQ1NDQCNPLJNanyoYoEgL10UQR+/hDCZBTXKAkLXXiUu6Xl2iyd
         OpMbE6ZAOVGfkzX9UyLoNKJcgg1uMKQSR3qRjkaD/A8B2IRkDEWpq+yt+F01NlaN69Oi
         kW+PS4BUNdIE8SiEadIb3jX2JpvwUH1FuLuMPLG2eFpJDYsgXyikP5MyhN0KJqAVZEdn
         tCly2nUsi7aqo2JcoFPUjRCN1EoKi+ZO8XhtgeOjV+bIxEiTM5ltnglloUTn6hKc9e5Z
         OWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7+Z6tg6y/PQcmK6IpNtYDzXHZkFuCBJ+ODz8w4VB9k=;
        b=GfAUzc+PBb0JqZdBe3m/97X9AgPFiRwY4WFCdzScgSHG/LdXSRP0isTL4VKIQ9S331
         CDvqwvDjHuZ0du/Qr50b4BeUnxDq+4t/a64uL3L3wXhsYqSaZcfj8s5/w1voeQO+82hc
         j+LgHLOeyT7+o30hpc7zXl1hQ9bVTMCJ4UqXhmIGMxd3lHv2irMtezHGNoX8Gk1dhe7T
         jD5GYEN/SwkMv+OJ7XsjJD8aEWDV3r+2Hj8K0fZFjEacY+9CLqdTNshzoLKzgr2rgkcc
         AMP3SylK0SocvZvOvuKlH/mtHmcXhrE3Y1WHxl0wcZBm8TFCxgXpjj5GebE6MUdsLEKY
         jHtg==
X-Gm-Message-State: AOAM5322r0+17GpvWCNVv19ecKnGAuxzjPBttourcGjvQQm2/y1eAyl6
        3xuZMaZCPYVtKdhhLl1xpWSt9wmdmdeY9hrnO2IHLQk2yeI=
X-Google-Smtp-Source: ABdhPJyBLz/9Fmn4dRGQS8aGmosl2kUWSt+22iZ+uxqQ6VCIoHdfvJktmH+Drys3CPW/i4re8k6NnhaqBjFocVuUz/A=
X-Received: by 2002:a25:a466:: with SMTP id f93mr26760901ybi.264.1622420978361;
 Sun, 30 May 2021 17:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <42d9c52a-bcc9-13e6-9b1d-d9a94ff2889f@panix.com>
In-Reply-To: <42d9c52a-bcc9-13e6-9b1d-d9a94ff2889f@panix.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 30 May 2021 17:29:25 -0700
Message-ID: <CABBYNZKqK6wEyrAL9y7+mPSWKr5CG=NnSEJK67Tt9ogimYA-zw@mail.gmail.com>
Subject: Re: Commit 9b16bfbf41 ("Bluetooth: btintel: Move operational checks
 after version check") causing BT FW loading problems
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "An, Tedd" <tedd.an@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenny,

On Fri, May 28, 2021 at 5:53 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> My BT device is (apparently a Jefferson Peak device):
>
> >> Bus 003 Device 003: ID 8087:0026 Intel Corp.
>
> With this commit in place, loading the BT firmware after a cold start fails
> attempting to load the wrong(?) firmware:
>
> ----
> Bluetooth: hci0: Firmware revision 0.0 build 118 week 15 2021
> bluetooth hci0: Direct firmware load for intel/ibt-19-16-0.sfi failed with error -2
> Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-19-16-0.sfi (-2)
> ----
>
> ... and a "git log" in the linux-firmware repo shows this file "ibt-19-16-0.sfi"
> never existed. Before this commit it was trying to load:
>
> ----
> Bluetooth: hci0: Bootloader revision 0.4 build 0 week 11 2017
> Bluetooth: hci0: Device revision is 2
> Bluetooth: hci0: Secure boot is enabled
> Bluetooth: hci0: OTP lock is enabled
> Bluetooth: hci0: API lock is enabled
> Bluetooth: hci0: Debug lock is disabled
> Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> Bluetooth: hci0: Found device firmware: intel/ibt-19-32-4.sfi
> Bluetooth: hci0: Waiting for firmware download to complete
> Bluetooth: hci0: Firmware loaded in 1642369 usecs
> Bluetooth: hci0: Waiting for device to boot
> Bluetooth: hci0: Device booted in 17881 usecs
> Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-32-4.ddc
> Bluetooth: hci0: Applying Intel DDC parameters completed
> Bluetooth: hci0: Firmware revision 0.0 build 121 week 7 2021
> Bluetooth: hci0: MSFT filter_enable is already on
> ----
>
> Let me know if anyone needs more info.

What exact kernel version are you testing this? Is it with Linus tree
or bluetooth-next? In case of the former you will probably need the
following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=183dce5a7fd3040ced6a220b0aa536c926f10cd9

>
>         -Kenny
>
> --
> Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA



-- 
Luiz Augusto von Dentz
