Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D03C33CB7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 19:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38CF2077B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 19:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPWR+tQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgAPTvP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:51:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37165 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbgAPTvO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 14:51:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id z64so20008732oia.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 11:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yU2E9X8C5YouRJ2xkdhmu7WHbncRvW+8QsnOztoo+bw=;
        b=GPWR+tQhzaHI4PTZbuVdUlKGHOqf+iFMY8MJOdsB+lq3wyZ7Bm+iMeyNLzsRk38nfU
         Z6itl9KIknNOieAmM6gndZRkap6POYEIWEM2MtVs6NibWbFyWm+UsrNHNWiK9kUVhtBC
         3DfhgbEUddJePG3dQF/ml3kLJMHGDnuCxhqm837WckJl/xz54hjefm7jdAfi+P0PWZo1
         UGDNxYpybwjN+GV/XqswHq/c4kVa+XOjTQ/gVmpBZnWKPGCgQLIRU/LBFhrdXwWFXi9I
         isJJIlzzxYgsicGzZa2/PiIt7XRcSGA3uX9QULsdKLh7uxU79w1qltaso6NkFNDyTK6u
         Do7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yU2E9X8C5YouRJ2xkdhmu7WHbncRvW+8QsnOztoo+bw=;
        b=MrDmiQmz3YumuDuoBTyC4IqUoEWijviBXq8be+Ae91gJbE+KkTLn7lCGMEGS1c2qkD
         2nAyn8gv/kUf+8fUNlvtXO8+tyosQU0R+Y8z4CNF3KYQMZQ6vDqyvmfis/KrLylTOc5j
         Wpznilpy6YRFuGRkjN8DygBkvxx+ezAPqcDNsf+G7UKhl2cBb3Zg8h7ThkZApdWv+ENz
         9/8JwzVJrGeKrobNmwOYlzqzTvww75en6PRnCWgNWLMJ2OqFbM77T+2iTW2s43migRmJ
         WmOc6pdrmw/bVyf2aFMe6nheu/IdRGbt9ww43nhS6SPuKdzzHOiBqz89ACuvag4HrkEk
         V5Hg==
X-Gm-Message-State: APjAAAVUnRFZZemxGGqqP7uBA3mpRq2bV+dXOJjOtkiQyekdbySsFLIQ
        zRyzDsH2xoIqFT1kMUxrAvElmZeZvSwKGCNbUIo=
X-Google-Smtp-Source: APXvYqxkFU5dfkLHFMGGfhkcZaOj5JdvoowykXi2pWEHs6pwR4SP0JtgHXe0Q7XLrH2p70O2zbbMbGNdYCxqCSRcanc=
X-Received: by 2002:aca:d610:: with SMTP id n16mr630073oig.108.1579204272545;
 Thu, 16 Jan 2020 11:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20200108003342.15458-1-luiz.dentz@gmail.com> <CALevQMYNAwKnuC669wmL1Y9Ft_HG4UQMZuGr8Dge8HSSf3skZw@mail.gmail.com>
In-Reply-To: <CALevQMYNAwKnuC669wmL1Y9Ft_HG4UQMZuGr8Dge8HSSf3skZw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 16 Jan 2020 11:51:00 -0800
Message-ID: <CABBYNZKp1DDzCqRF2XjmN5eROYiJg1LSE7MLV+sMMxNthDz8OQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/22] Userspace Bluetooth 5.2 initial support
To:     =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?= 
        <grzegorz.kolodziejczyk@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Grzegorz,

On Thu, Jan 16, 2020 at 3:54 AM Grzegorz Ko=C5=82odziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
>
> Hi Luiz,
>
> I wasn't able to test it - it has to be rebased.

There are some changes needed with the way the kernel end up being
merged so I will have to update this set anyway.

> Regards,
> Grzegorz
>
>
> =C5=9Br., 8 sty 2020 o 01:33 Luiz Augusto von Dentz <luiz.dentz@gmail.com=
>
> napisa=C5=82(a):
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This introduces the initial support for Bluetooth 5.2 features:
> >
> > * ISO channels:
> >         + tools/isotest command line tool to run validation tests
> >
> > * L2CAP Enhanced Credit Based Flow Control Mode
> >         + tools/l2test has been update to include the new mode
> >
> > * Enhanced ATT Bearer:
> >         + Client and Server support
> >         + Include all new procedures
> >         + Automaticlly detects and enables channels
> >         + Number of channels configurable via main.conf
> >
> > * Monitor:
> >         + HCI/LL Bluetooth 5.2 command/event decoding
> >         + ISO packets decoding
> >         + L2CAP Enhanced Credit Based Flow Control Mode decoding
> >         + Enhanced ATT packets decoding
> >
> > * Emulator:
> >         + CIS/Unicast emulation support
> >         - BIS/Broadcast emulation not yet supported
> >
> > Kernel changes:
> > https://lore.kernel.org/linux-bluetooth/20200107074056.25453-1-luiz.den=
tz@gmail.com/T/#t
> >
> > Luiz Augusto von Dentz (22):
> >   monitor: Add support for decoding ISO related commands
> >   monitor: Add decoding of ISO related Link Layer PDUs
> >   lib: Add definitions for ISO socket
> >   tools: Add isotest tool
> >   emulator: Add initial support for BT 5.2
> >   monitor: Add support for ISO packets
> >   tools/btproxy: Add support for ISO packets
> >   monitor: Fix decoding of CIS estabilished event
> >   emulator/btdev: Add parameter to CIS Estabilished
> >   lib: Add definitions for Enhanced Credits Based Mode
> >   btio: Add mode to for Enhanced Credit Mode
> >   monitor: Add decoding for L2CAP Enhanced Credit Based PDUs
> >   l2test: Add support for L2CAP_ECRED_MODE
> >   share/att: Add EATT support
> >   shared/gatt-client: Add support for EATT features
> >   gatt: Enable EATT bearer support
> >   shared/gatt-server: Add support for Read Multiple Variable Length
> >   shared/gatt-client: Add support for Read Multiple Variable Length
> >   shared/gatt: Add support for Handle Value Multiple Notifications
> >   gatt: Add support for Notify Multiple
> >   core: Add support for setting the number of GATT bearers
> >   monitor: Add support for decoding EATT
> >
> >  Makefile.tools           |    5 +-
> >  attrib/gattrib.c         |    5 +-
> >  btio/btio.c              |    2 +-
> >  btio/btio.h              |    3 +-
> >  emulator/btdev.c         |  293 +++++++++--
> >  emulator/btdev.h         |    1 +
> >  emulator/hciemu.c        |    3 +
> >  emulator/hciemu.h        |    1 +
> >  emulator/vhci.c          |    3 +-
> >  lib/bluetooth.h          |   14 +
> >  lib/iso.h                |   45 ++
> >  lib/l2cap.h              |    1 +
> >  lib/uuid.h               |    3 +
> >  monitor/bt.h             |  385 ++++++++++++++
> >  monitor/l2cap.c          |  192 +++++++
> >  monitor/ll.c             |  100 ++++
> >  monitor/packet.c         |  714 ++++++++++++++++++++++++++
> >  monitor/packet.h         |    2 +
> >  peripheral/gatt.c        |    2 +-
> >  src/device.c             |   18 +-
> >  src/gatt-client.c        |   85 ++++
> >  src/gatt-database.c      |  125 +++--
> >  src/hcid.h               |    1 +
> >  src/main.c               |   14 +
> >  src/main.conf            |    5 +
> >  src/shared/att-types.h   |   25 +-
> >  src/shared/att.c         |  780 +++++++++++++++++++----------
> >  src/shared/att.h         |   18 +-
> >  src/shared/btsnoop.h     |    2 +
> >  src/shared/gatt-client.c |  279 +++++++++--
> >  src/shared/gatt-client.h |    5 +-
> >  src/shared/gatt-server.c |  388 ++++++++++-----
> >  src/shared/gatt-server.h |    2 +-
> >  tools/btgatt-client.c    |    2 +-
> >  tools/btgatt-server.c    |    4 +-
> >  tools/btproxy.c          |   20 +-
> >  tools/isotest.c          | 1019 ++++++++++++++++++++++++++++++++++++++
> >  tools/l2test.c           |    5 +-
> >  unit/test-gatt.c         |    4 +-
> >  39 files changed, 4046 insertions(+), 529 deletions(-)
> >  create mode 100644 lib/iso.h
> >  create mode 100644 tools/isotest.c
> >
> > --
> > 2.21.0
> >



--=20
Luiz Augusto von Dentz
