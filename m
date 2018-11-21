Return-Path: <SRS0=IL+U=OA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D9C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 11:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B5320685
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 11:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfqNarzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B5320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeKUWEJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:04:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33874 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbeKUWEJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Nov 2018 17:04:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so4651133otk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Nov 2018 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfuTWI/Rl2ltBO6OYJn+fPkq0PiZDp7fioJKL8lL1I4=;
        b=qfqNarzGN5z5tNYp8nTQyUa8pK8oiacq5hVj4pqmJLlB13XoyUL78ljqBdPgkhDMER
         tC/Zw5P/FVEXjLZo/OKduTfiRRhGTrRLW2TRYunMLEioDBck+q5cKwj+BrDZ84nSgKFx
         IilYFP0DG3B4wtDuq+AW0utYGJfjYrDmrJxHL5qHxz0DtzjNxP8SiTYxltNPg/ULtokA
         BOZ7fHH4W05ulIr9di5+LetmzkoC2iFnqZLZmbl3q6zy+Z04xw2tjmfkUdu22qd8bPC0
         qOG97EVYIPjQazlAMjhH4vx9lrmRhwoPLL7M/n5PHprgya7LykYR7MJ4F6MVWGKWVtDZ
         exXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfuTWI/Rl2ltBO6OYJn+fPkq0PiZDp7fioJKL8lL1I4=;
        b=gmdW3KDfLH+gFPjNHINPwFxKMXWqe3RZjH8Jc9ffokQqGMPK1gzVW9SW/lAzIyb6Vm
         O6Clun85X/aFRr0Upg5yg0Y/i6cQ02lLeO2j9X4KFxvvDlXQs8cV39RI7k85CzHHNFZu
         YvtWjtSBkjb+ce8CnN6/RJfOAFUbccalX3Ko0taT8dfny0K2ATNsPMg/1fWhoYMJNEoI
         ZMsvHeYUEjMMfbAkI8lFdR3EAsQw5ObanspSjkf7nLoE1Bhzr/hqYjcsBBb1xKaIXrPM
         Hl6RHslrBgNQXEvmJeEV5TEQ1vDd34eFnA9AukZpv7vwUiIQij3i2w1GjgJvlXIHOusk
         Z/hg==
X-Gm-Message-State: AA+aEWbI9QKizPifryFIEAHuTi3cp8x2JkjWhNy3fTvptisdHl2fOfMN
        4gvgogesA/2970XTjm28AbXFCZDTYGv0SvMmbwxLFQ==
X-Google-Smtp-Source: AFSGD/XQax34q3q1puMFPNGhs36gIZ5N5bwZwiLZoa3uhF8IIp/cFvv15cI5GUzPIYw0IHm6RBWT+9XLJqxXk087KWc=
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr3336939otp.254.1542799806588;
 Wed, 21 Nov 2018 03:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20181118160802.11087-1-jengelh@inai.de> <20181118160802.11087-2-jengelh@inai.de>
In-Reply-To: <20181118160802.11087-2-jengelh@inai.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Nov 2018 13:29:54 +0200
Message-ID: <CABBYNZ+pLp5W0_sNC4ih_KuW2WmX5drBL2bPX4rG4fHQ4kyecg@mail.gmail.com>
Subject: Re: [PATCH 1/8] build: rename libexecdir to pkglibexecdir
To:     jengelh@inai.de
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jan,
On Sun, Nov 18, 2018 at 6:17 PM Jan Engelhardt <jengelh@inai.de> wrote:
>
> When files are to be placed not in libexecdir but a subdirectory of
> it, automake has a variable name reserved for exactly that purpose
> (and a default value, which Makefile.am will override), called
> pkglibexecdir. Let's use it.
> ---
>  Makefile.am                       | 4 ++--
>  obexd/src/obex.service.in         | 2 +-
>  src/bluetooth.service.in          | 2 +-
>  tools/bluetooth-logger.service.in | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 0ccf393c6..eee70b88b 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -19,7 +19,7 @@ CLEANFILES =
>
>  EXTRA_DIST =
>
> -libexecdir = @libexecdir@/bluetooth
> +pkglibexecdir = @libexecdir@/bluetooth
>
>  libexec_PROGRAMS =
>
> @@ -489,7 +489,7 @@ MAINTAINERCLEANFILES = Makefile.in \
>         ltmain.sh depcomp compile missing install-sh mkinstalldirs test-driver
>
>  SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> -               $(SED) -e 's,@libexecdir\@,$(libexecdir),g' \
> +               $(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
>                 < $< > $@
>
>  %.service: %.service.in Makefile
> diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
> index bca3aef66..fc0dce993 100644
> --- a/obexd/src/obex.service.in
> +++ b/obexd/src/obex.service.in
> @@ -4,7 +4,7 @@ Description=Bluetooth OBEX service
>  [Service]
>  Type=dbus
>  BusName=org.bluez.obex
> -ExecStart=@libexecdir@/obexd
> +ExecStart=@pkglibexecdir@/obexd
>
>  [Install]
>  Alias=dbus-org.bluez.obex.service
> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
> index f799f65f0..f9faaa452 100644
> --- a/src/bluetooth.service.in
> +++ b/src/bluetooth.service.in
> @@ -6,7 +6,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
>  [Service]
>  Type=dbus
>  BusName=org.bluez
> -ExecStart=@libexecdir@/bluetoothd
> +ExecStart=@pkglibexecdir@/bluetoothd
>  NotifyAccess=main
>  #WatchdogSec=10
>  #Restart=on-failure
> diff --git a/tools/bluetooth-logger.service.in b/tools/bluetooth-logger.service.in
> index 026a2f130..009002731 100644
> --- a/tools/bluetooth-logger.service.in
> +++ b/tools/bluetooth-logger.service.in
> @@ -4,7 +4,7 @@ ConditionPathIsDirectory=/sys/class/bluetooth
>
>  [Service]
>  Type=simple
> -ExecStart=@libexecdir@/btmon-logger -p -b /var/log/bluetooth/hci.log
> +ExecStart=@pkglibexecdir@/btmon-logger -p -b /var/log/bluetooth/hci.log
>  NotifyAccess=main
>  CapabilityBoundingSet=CAP_NET_RAW
>  LimitNPROC=1
> --
> 2.19.1

Applied this one, 2/8 doesn't applies so you need to do a rebase and
send a v2 before we continue.

-- 
Luiz Augusto von Dentz
