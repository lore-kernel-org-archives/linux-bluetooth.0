Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8422BC3A59D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 21:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506A8206C1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 21:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydxv64tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfHPVMY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:12:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41110 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVMX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 17:12:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so2913023pls.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:in-reply-to:date:subject:from:to
         :message-id;
        bh=jg3TY6Ppod1XYmpYlM2FSu8pu8e3ChdrZXQNJygjk7g=;
        b=Ydxv64tJRx0x4hoMzzj4WBlvy/DYizR0NhceXoDnFqUNleQau0Hjf5eX0aviGCh56v
         QSrRYkjmyk3kFV8u8uVWvx8ZBKXFEoG5rdLQbzSK2XmR9hmodq2TFN+MKKGifePDdf9Q
         kEZIqi6IU+mPH/MdnMuuQ0Q7RvFYC61qcRhEBpml47sFU8RskBwRcUj1lCYAKruES1Ke
         Mv/wL6JfPBcj6Lxzo36MfFM0VPih74PQVXq0sARBjNNI3R0u7eee07Y17L2gphoDLsfv
         Gf3byomFzKfI/y/87bfL+wNypcFlnADrSs3d+n8Z3wO0PCW3qc3w9cLXzUpurGtGj2g+
         SczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:in-reply-to:date
         :subject:from:to:message-id;
        bh=jg3TY6Ppod1XYmpYlM2FSu8pu8e3ChdrZXQNJygjk7g=;
        b=NJ8C487B1a6t8HUU1q3IdWlgGTah8T+W9EYGOwxN+a78+gJAhyygaWaY5793nyhBXs
         ioit3mVF0oWhxpdtcyNypEtEKbtskAT2UKXLXmSug6FpkXlwadH3owZScOwcbTkj/AiH
         ONW8+l6p9yilVOAJS725ZPX3UhYBUhdb68yif8wLah0PsYugcrHoRS4wf7oCPwDoeSgj
         J9k6kCZHkM46VcRiqQAlZGZll3ZcMkOLOtY3GA+YfEk3whJg3pVMyDHaCCM0SpUV7g0/
         UAVdZ2U2dQjNwkHo4RIb82wDTbNDtxvndx0tPnYGuBSXE4P2xw3iFiyugxrlUx9doYyg
         vjiA==
X-Gm-Message-State: APjAAAVOsgPJwu0KXDLS5pZST5ODrPJ/ZVt8EX08fD0MxM9t92oeWopb
        tHlq7MV9G67Vk+T6hCyVucuMTnc=
X-Google-Smtp-Source: APXvYqzq0uVxsop6O15YswSNx4wFqoCbU91QFjtXikabaJtXTdv2fIfVbKFgHioZRVKWwQqrTdG9nQ==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr10869505plk.180.1565989942791;
        Fri, 16 Aug 2019 14:12:22 -0700 (PDT)
Received: from localhost ([2600:8800:1e00:242:3550:edee:2708:4ad0])
        by smtp.gmail.com with ESMTPSA id v184sm5991213pgd.34.2019.08.16.14.12.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 14:12:22 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <BWBCB7VTY8ZD.2GSGD0H9H00LN@rxps>
Date:   Fri, 16 Aug 2019 14:12:21 -0700
Subject: Fwd: Re: [PATCH BlueZ 1/3] client/main: add help option for
 available args
From:   "Ronan Pigott" <rpigott314@gmail.com>
To:     <linux-bluetooth@vger.kernel.org>
Message-Id: <BWBD3RE9KDV9.PK2ODM7IZII9@rxps>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri Aug 16, 2019 at 2:29 PM Luiz Augusto von Dentz wrote:
> Can you a description of what the changes does, perhaps a sample when
> uses in some command.
>=20
> > +       if (!strcmp(argv[1], "help")) {
> > +               for (opt =3D arg_table; opt && *opt; opt++) {
> > +                       bt_shell_printf("%s\n", *opt);
> > +               }
> > +               bt_shell_noninteractive_quit(EXIT_SUCCESS);
> > +               return FALSE;
> > +       }

I added the help option to parse_argument so that when the argument
value is "help", the result is to print a newline separated list
of the arg_table containing the other valid arguments. Now
the user gets the following output for the following commands:

$ bluetoothctl agent help
on
off
DisplayOnly
DisplayYesNo
KeyboardDisplay
KeyboardOnly
NoInputNoOutput

$ bluetoothctl advertise help
on
off
peripheral
broadcast

Only agent_arguments[] and ad_arguments[] are defined in client/main.c,
so these are effecively the only new commands. The completion script
can parse the output of `bluetoothctl agent help` and `bluetoothctl
advertise help` to complete those arguments.

Additionally, other commands now don't complain that "help" is invalid,
but otherwise have no output at all. However, I don't think there is a
need to make "help" available in more contexts.

Instead for commands that take a device (similar for controller),
I chose to parse the output of `bluetoothctl devices` to take
advantage of zsh's verbosity in completion menus. Now when completing
such commands the user can get more information than is immediately
available in the interactive shell.

e.g. I am presented with a menu with descriptions like so:

$ bluetoothctl connect <TAB>
04:52:C7:0C:D4:A7  -- Bose QuietComfort 35
40:4E:36:D9:8F:28  -- Pixel 2
A4:38:CC:20:5D:E0  -- Pro Controller

This convenient menu was my original motivation for the zsh completions,
as it makes the connect/disconnect commands much more convenient to use.
