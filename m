Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D70C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3594207D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 15:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=espindo.la header.i=@espindo.la header.b="si38c2Dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgESP6Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 11:58:16 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:59463 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbgESP6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 11:58:16 -0400
Date:   Tue, 19 May 2020 15:58:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la;
        s=protonmail; t=1589903894;
        bh=kDEyaBIqOTt93NkmHd22/XV+TJrF7EBG0Zegjpmid7c=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=si38c2DkkPwB4NzxfIsvAKnr/GPBjyI3z2bdweB4PGN4DDY1U/8EAMmKGNrxl0nea
         JiWyHM1gA6Xbt7WOZrDkxXGTudNtz7tlfe1fctITKjc1b0Gv7+NcLTE60NhIED43sN
         2EcJFmrNl1tvspzLpQpB7+87ylOVHj9fggovLObY=
To:     linux-bluetooth@vger.kernel.org
From:   Rafael Avila de Espindola <rafael@espindo.la>
Cc:     luiz.dentz@gmail.com
Reply-To: Rafael Avila de Espindola <rafael@espindo.la>
Subject: Re: [PATCH] Mention disabling SELinux in HACKING
Message-ID: <87pnazudbo.fsf@espindo.la>
In-Reply-To: <20200512023609.43163-1-rafael@espindo.la>
References: <20200512023609.43163-1-rafael@espindo.la>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

So, is this OK?

Cheers,
Rafael

Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la> writes:

> Running bluetoothd from the build directory I noticed that as soon as
> a bluetooth audio device was connect, bluetoothd would be disconnected
> from dbus and print
>
> Disconnected from D-Bus. Exiting.
>
> Luiz Augusto von Dentz suggested trying with SELinux disabled and that
> solved the problem.
>
> This patch just documents how to disable SELinux before running
> bluetoothd from the build directory. I would love to say more about
> why that is needed, but could not find anything on the audit log.
> ---
>  HACKING | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/HACKING b/HACKING
> index e10986fcb..29b136b34 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -76,6 +76,9 @@ automatically includes this option.
>    Copy configuration file which specifies the required security policies
>      # sudo cp ./src/bluetooth.conf /etc/dbus-1/system.d/
> =20
> +  Disable SELinux
> +    # sudo setenforce 0
> +
>    Run daemon in foreground with debugging
>      # sudo ./src/bluetoothd -n -d -f ./src/main.conf
> =20
> --=20
> 2.26.2

