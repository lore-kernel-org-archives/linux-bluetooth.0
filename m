Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221F6C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 11:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53D520663
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 11:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="lDQeODEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgAPLyr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:54:47 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:43080 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgAPLyr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 06:54:47 -0500
Received: by mail-il1-f172.google.com with SMTP id v69so17859606ili.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 03:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gH2jCOn/DCwV6VUZi3XYE6rZ7ODi7hpgRfWOJbdy0D4=;
        b=lDQeODErxHVYs2xQUpglvaT+dd08x2WlAR4yDLyqV5xZ/5KK0fZ5lp4tOM5IqRXoC5
         /+XgbcbVbC98miLVd/ePci/twhbEVmKIsY6K13tfwbeFr0Au/mh30YVfpqos75s9W1Iw
         VWpLvrIzqD4M7CwcUPKMLFHlOgVAcN747Q7ih28vZ7mbqp1TZunVesyqXWHfF+XoK+Yg
         gpxIS/JmzunpswZCJ6+0kmoR7TH43XID2kP4xTrbAXuzIJZI+TsJ/vnnHjvxjcBSHK/T
         5mrnAGIfNkWnzd0ogT9AALC3Q+u6VEW1fHQqH9EJybgEO3ZkYrY935B5G6AQ5WpxeSWL
         S9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gH2jCOn/DCwV6VUZi3XYE6rZ7ODi7hpgRfWOJbdy0D4=;
        b=sS2SFfJRftlzBGaH5V7/qFVjr1lYk1CgivBmSGba7s5xvzJaxRr0DMAYB94Skt0WNG
         v7kaPX7/yVN2fNNCLMXiHlrbu0qOmyE1gYSk22cPzE3isN/uo2/QJKiVw5QivMZiKCuL
         1LgfOLaX2rOJtHWkVIo0l4M57g0IgKU2iP+YXFxI7LpmF+PN1pLrui1NhiepzY5CwmDw
         Cz8mnprNh5fmtMRAQ9ppBpX0YRoVWHGHU5Tt4Zx/JYVGWFJmnr5ZTjOYUvWmJSP7Gx3E
         BywjR2/51lzLCRCU0HEwErPgtpLhSliv9sTDHMO44D5hmQAORiifA6L93bMhRTiZWPOc
         ryTA==
X-Gm-Message-State: APjAAAW4aBR9NqBHhrWfjzcxM1p1fYepBvHW7iK4InARU5a1rg7pjVmN
        Qfwt2NvjGRqKkK0XhMZjI8mvZIvuF8yrYjs/1t8SIVmb8nM=
X-Google-Smtp-Source: APXvYqxhqJfhlZZVd3c5/nPa8EcmkfKv99lNcsQzNjxYCQ9O6GNM++qnFU8Lcq8BaZwZQptKu1zYllw+YHBbkZ5nybk=
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr2964216ils.248.1579175686397;
 Thu, 16 Jan 2020 03:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
From:   =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?= 
        <grzegorz.kolodziejczyk@codecoup.pl>
Date:   Thu, 16 Jan 2020 12:54:35 +0100
Message-ID: <CALevQMYNAwKnuC669wmL1Y9Ft_HG4UQMZuGr8Dge8HSSf3skZw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/22] Userspace Bluetooth 5.2 initial support
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I wasn't able to test it - it has to be rebased.

Regards,
Grzegorz


=C5=9Br., 8 sty 2020 o 01:33 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
napisa=C5=82(a):
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This introduces the initial support for Bluetooth 5.2 features:
>
> * ISO channels:
>         + tools/isotest command line tool to run validation tests
>
> * L2CAP Enhanced Credit Based Flow Control Mode
>         + tools/l2test has been update to include the new mode
>
> * Enhanced ATT Bearer:
>         + Client and Server support
>         + Include all new procedures
>         + Automaticlly detects and enables channels
>         + Number of channels configurable via main.conf
>
> * Monitor:
>         + HCI/LL Bluetooth 5.2 command/event decoding
>         + ISO packets decoding
>         + L2CAP Enhanced Credit Based Flow Control Mode decoding
>         + Enhanced ATT packets decoding
>
> * Emulator:
>         + CIS/Unicast emulation support
>         - BIS/Broadcast emulation not yet supported
>
> Kernel changes:
> https://lore.kernel.org/linux-bluetooth/20200107074056.25453-1-luiz.dentz=
@gmail.com/T/#t
>
> Luiz Augusto von Dentz (22):
>   monitor: Add support for decoding ISO related commands
>   monitor: Add decoding of ISO related Link Layer PDUs
>   lib: Add definitions for ISO socket
>   tools: Add isotest tool
>   emulator: Add initial support for BT 5.2
>   monitor: Add support for ISO packets
>   tools/btproxy: Add support for ISO packets
>   monitor: Fix decoding of CIS estabilished event
>   emulator/btdev: Add parameter to CIS Estabilished
>   lib: Add definitions for Enhanced Credits Based Mode
>   btio: Add mode to for Enhanced Credit Mode
>   monitor: Add decoding for L2CAP Enhanced Credit Based PDUs
>   l2test: Add support for L2CAP_ECRED_MODE
>   share/att: Add EATT support
>   shared/gatt-client: Add support for EATT features
>   gatt: Enable EATT bearer support
>   shared/gatt-server: Add support for Read Multiple Variable Length
>   shared/gatt-client: Add support for Read Multiple Variable Length
>   shared/gatt: Add support for Handle Value Multiple Notifications
>   gatt: Add support for Notify Multiple
>   core: Add support for setting the number of GATT bearers
>   monitor: Add support for decoding EATT
>
>  Makefile.tools           |    5 +-
>  attrib/gattrib.c         |    5 +-
>  btio/btio.c              |    2 +-
>  btio/btio.h              |    3 +-
>  emulator/btdev.c         |  293 +++++++++--
>  emulator/btdev.h         |    1 +
>  emulator/hciemu.c        |    3 +
>  emulator/hciemu.h        |    1 +
>  emulator/vhci.c          |    3 +-
>  lib/bluetooth.h          |   14 +
>  lib/iso.h                |   45 ++
>  lib/l2cap.h              |    1 +
>  lib/uuid.h               |    3 +
>  monitor/bt.h             |  385 ++++++++++++++
>  monitor/l2cap.c          |  192 +++++++
>  monitor/ll.c             |  100 ++++
>  monitor/packet.c         |  714 ++++++++++++++++++++++++++
>  monitor/packet.h         |    2 +
>  peripheral/gatt.c        |    2 +-
>  src/device.c             |   18 +-
>  src/gatt-client.c        |   85 ++++
>  src/gatt-database.c      |  125 +++--
>  src/hcid.h               |    1 +
>  src/main.c               |   14 +
>  src/main.conf            |    5 +
>  src/shared/att-types.h   |   25 +-
>  src/shared/att.c         |  780 +++++++++++++++++++----------
>  src/shared/att.h         |   18 +-
>  src/shared/btsnoop.h     |    2 +
>  src/shared/gatt-client.c |  279 +++++++++--
>  src/shared/gatt-client.h |    5 +-
>  src/shared/gatt-server.c |  388 ++++++++++-----
>  src/shared/gatt-server.h |    2 +-
>  tools/btgatt-client.c    |    2 +-
>  tools/btgatt-server.c    |    4 +-
>  tools/btproxy.c          |   20 +-
>  tools/isotest.c          | 1019 ++++++++++++++++++++++++++++++++++++++
>  tools/l2test.c           |    5 +-
>  unit/test-gatt.c         |    4 +-
>  39 files changed, 4046 insertions(+), 529 deletions(-)
>  create mode 100644 lib/iso.h
>  create mode 100644 tools/isotest.c
>
> --
> 2.21.0
>
