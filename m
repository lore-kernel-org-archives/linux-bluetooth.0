Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71057C0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 11:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FED220827
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQcSmQlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FED220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeKGVCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:02:11 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43092 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGVCL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 16:02:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id j202-v6so13508403oih.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQ8qp3x7H74Rs7vXEbI7KcKBxl6qdOMhB0wf3Sweq5U=;
        b=JQcSmQlIAQLEBghs5JYXCAHdpPJAs6ZYTrRN20626gAS9rLX2NveXCKNXBykIydMvh
         o6XObLoZ/afKMrAoXF8QLmH/RGt/pPbaZf6l9f8nGstesnnsTglPaUwz6LGcce0CPfbN
         bYh2DQngdSlq+xfUOBMyNG0ISd+mm5Q0FEYyliSTMJDYEkanEJVqvpSJTAlUhrNRGHOX
         kB+jHitYp9YCwrtFSh8qIufjZwPHw+BQ2rXlHGgtHB9P1yjnZavZRle22sDsabZwAflw
         yBQGfgZf2IhxrYyxHxye4uw006g3qhl8B2eOVnRzILlSvrYQJF59Ryl2GRVLFsm5d2s/
         cy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQ8qp3x7H74Rs7vXEbI7KcKBxl6qdOMhB0wf3Sweq5U=;
        b=EtLMMMOwJSk9/YqFTTgB3ndfYyqoiCt4U4wmiYs8bbj3OE1U4SLpFUX9br5NnyBTXn
         Aw2gh6V4fEelCKWP5vgvkAPFsAuvW2YSXT2iOR6GReUX0Iv9NtDoS5xW2sE0Noc3txg5
         x4nuIPQZG+kn0mC1RqsV048iBktbesHrLi+VYjEbji1VxpiCa/pP6kJblRRtj0Pq9wTg
         sNC2sqoZaAdjjFOoH5EEDLWc0e4brDO+ohtun1RCGyByg4ehmJAZp2DYIKkayV/YrMgJ
         yRTK925QOLWOym/bzkgOEu/5XutZXhbsRKEt8bGTNeLgliBpcg9Dzz+WzIFWiZ5flgA+
         sUbw==
X-Gm-Message-State: AGRZ1gImrZ0LbCbxiAghbEXuHumThqwzXL8+8k+7LPXaGQ5roQEZEWvg
        ccgeW3MaAYjOyBspnkZz3s+kenmX/EifNxNnSvg=
X-Google-Smtp-Source: AJdET5eZ0YuNe17bmSoOonRovM6f78Ge/CPImrNwmibaZInS8y0DHRzoXZ194RxXQ3mDpchkrGN1dL+7xJx+/0M0fjk=
X-Received: by 2002:a54:409a:: with SMTP id i26-v6mr682997oii.251.1541590333310;
 Wed, 07 Nov 2018 03:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20181106110717.8817-1-teg@jklm.no>
In-Reply-To: <20181106110717.8817-1-teg@jklm.no>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Nov 2018 13:32:00 +0200
Message-ID: <CABBYNZJYNqJnYk-0ApMBHEGhocbwxnqGA4J_=FE1g-cqb_scgQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth.conf: remove deprecated at_console statement
To:     teg@jklm.no
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tom,
On Tue, Nov 6, 2018 at 1:10 PM Tom Gundersen <teg@jklm.no> wrote:
>
> As described in [0], this likely did not have the intended effect, so
> simply remove it. The change in behavior is that up until this patch
> it would be possible for root, lp, and any non-system user to potentially
> gain access to bluez' dbus interface. Now this is extended to also allow
> any system user.
>
> [0]: <https://www.spinics.net/lists/linux-bluetooth/msg75267.html>
>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> CC: David Herrmann <dh.herrmann@gmail.com>
> ---
>  src/bluetooth.conf | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> index b67a954a2..8a1e25801 100644
> --- a/src/bluetooth.conf
> +++ b/src/bluetooth.conf
> @@ -22,18 +22,8 @@
>      <allow send_interface="org.mpris.MediaPlayer2.Player"/>
>    </policy>
>
> -  <policy at_console="true">
> -    <allow send_destination="org.bluez"/>
> -  </policy>
> -
> -  <!-- allow users of lp group (printing subsystem) to
> -       communicate with bluetoothd -->
> -  <policy group="lp">
> -    <allow send_destination="org.bluez"/>
> -  </policy>
> -
>    <policy context="default">
> -    <deny send_destination="org.bluez"/>
> +    <allow send_destination="org.bluez"/>
>    </policy>
>
>  </busconfig>
> --
> 2.19.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
