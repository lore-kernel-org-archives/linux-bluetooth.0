Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E082CC10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B838E218D3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 08:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfDXImc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:42:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34346 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfDXImc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 04:42:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id j6so83902qtq.1;
        Wed, 24 Apr 2019 01:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPq8gWl/GY7Jv4mdzMNqpJmrD82eCxkovWfUDogoYPc=;
        b=W83V5yqOEZDot2Jsh6HV8CAgy1VTGZTtr9LlNfPUwKvGkP9ELwcZCidwI+o2i3r95L
         xHzTrZ28UXTMZgfQgFRpBPJFfmhMTmN+Gi97lbvre+uHxoq6TzRHCAp//HkfXWTp6lgj
         lBdXe1iQkuGaTHgKWWE31rRnhV7Okv0k7rKF9pnFL7IvqxWjjwijl3yrnZ3g83kd/LzB
         KnibUmP5gs6A0U/QOQfP1Agtto5hSZlsqptKWDyAQ9r2Hisg/TekJFBkrEvyjpEoF6Cx
         Ketd1nYRUf455xbrLkRJY8QFm6IRblZZ4udbdGdoIHpeCup6i+IOsbUDRiqY5ac0S0N1
         oMPw==
X-Gm-Message-State: APjAAAVBVzqHAkvdaquI6R4Or+Yqx7CjwOkfXIKG3pLJcAHaY7ZR9I2A
        q2/z5mN6gLsDJ94th7bqIVmn0RcKaAqL5k0sVYo=
X-Google-Smtp-Source: APXvYqzL1A1U4+G9eLqf293bqtoFV6UEae33K2glSkiCS8PBNQ9kayi9RFDx2LP0dm4qhRGafxIF4SqTc20eWd6bPB0=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr24849313qto.343.1556095350573;
 Wed, 24 Apr 2019 01:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190423151143.464992-1-arnd@arndb.de> <20190423.193735.412590692063607790.davem@davemloft.net>
In-Reply-To: <20190423.193735.412590692063607790.davem@davemloft.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Apr 2019 10:42:14 +0200
Message-ID: <CAK8P3a1ViEZmK-+rpYgpFkJHs+7XoNCTuK1iHcgSrZXaOJedLQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] isdn: deprecate non-mISDN drivers
To:     David Miller <davem@davemloft.net>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        Networking <netdev@vger.kernel.org>,
        isdn4linux@listserv.isdn4linux.de, Paul Bolle <pebolle@tiscali.nl>,
        Holger Schurig <holgerschurig@googlemail.com>,
        Tilman Schmidt <tilman@imap.cc>,
        Al Viro <viro@zeniv.linux.org.uk>,
        gigaset307x-common@lists.sourceforge.net,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 24, 2019 at 4:37 AM David Miller <davem@davemloft.net> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 23 Apr 2019 17:11:32 +0200
>
> > When isdn4linux came up in the context of another patch series, I
> > remembered that we had discussed removing it a while ago.
>
> This seems long overdue to me.
>
> Could you please respin against net-next and I'll just apply this?

Ok. I'll send a pull request then, which should make it easier to deal with
the file removals, as I'm never sure whether 'git format-patch -D' patches
make it across the list correctly, at least I had problems applying them
in the past.

I added a few fixups as in the diff below in the meantime, to deal
with build regressions from the last patch. In particular, the BT_CMTP
(CIP) code also needs to be moved into staging along with the CAPI
core. From what I can find, this was originally used for dial-up
internet connections with 'Bluefritz' ISDN hardware, but it stopped
working many years ago and is no longer useful with after the
public network shutdown either.

     Arnd


diff --git a/drivers/staging/isdn/Kconfig b/drivers/staging/isdn/Kconfig
index 77e1b80af716..29d13fcd9e2b 100644
--- a/drivers/staging/isdn/Kconfig
+++ b/drivers/staging/isdn/Kconfig
@@ -1,5 +1,6 @@
 menuconfig ISDN_CAPI
  tristate "CAPI 2.0 subsystem"
+ depends on NET && NETDEVICES
  help
    This provides CAPI (the Common ISDN Application Programming
    Interface) Version 2.0, a standard making it easy for programs to
@@ -23,6 +24,7 @@ source "drivers/staging/isdn/gigaset/Kconfig"

 source "drivers/staging/isdn/hysdn/Kconfig"

+source "drivers/staging/isdn/cmtp/Kconfig"

 endif # ISDN_CAPI

diff --git a/drivers/staging/isdn/Makefile b/drivers/staging/isdn/Makefile
index c5e8b8004f65..a74e9163f3c8 100644
--- a/drivers/staging/isdn/Makefile
+++ b/drivers/staging/isdn/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_ISDN_CAPI) += capi/
 obj-$(CONFIG_CAPI_AVM) += avm/
 obj-$(CONFIG_HYSDN) += hysdn/
 obj-$(CONFIG_ISDN_DRV_GIGASET) += gigaset/
+obj-$(CONFIG_BT_CMTP) += cmtp/
diff --git a/net/bluetooth/cmtp/Kconfig b/drivers/staging/isdn/cmtp/Kconfig
similarity index 88%
rename from net/bluetooth/cmtp/Kconfig
rename to drivers/staging/isdn/cmtp/Kconfig
index 939da0fbdd88..1772ca952720 100644
--- a/net/bluetooth/cmtp/Kconfig
+++ b/drivers/staging/isdn/cmtp/Kconfig
@@ -1,6 +1,6 @@
 config BT_CMTP
  tristate "CMTP protocol support"
- depends on BT_BREDR && ISDN_CAPI
+ depends on BT && BT_BREDR && ISDN_CAPI
  help
    CMTP (CAPI Message Transport Protocol) is a transport layer
    for CAPI messages.  CMTP is required for the Bluetooth Common
diff --git a/net/bluetooth/cmtp/Makefile b/drivers/staging/isdn/cmtp/Makefile
similarity index 59%
rename from net/bluetooth/cmtp/Makefile
rename to drivers/staging/isdn/cmtp/Makefile
index 890a9a5a6861..23258b46753c 100644
--- a/net/bluetooth/cmtp/Makefile
+++ b/drivers/staging/isdn/cmtp/Makefile
@@ -5,3 +5,5 @@
 obj-$(CONFIG_BT_CMTP) += cmtp.o

 cmtp-objs := core.o sock.o capi.o
+
+ccflags-y += -I$(srctree)/$(src)/../include -I$(srctree)/$(src)/../include/uapi
diff --git a/net/bluetooth/cmtp/capi.c b/drivers/staging/isdn/cmtp/capi.c
similarity index 100%
rename from net/bluetooth/cmtp/capi.c
rename to drivers/staging/isdn/cmtp/capi.c
diff --git a/net/bluetooth/cmtp/cmtp.h b/drivers/staging/isdn/cmtp/cmtp.h
similarity index 100%
rename from net/bluetooth/cmtp/cmtp.h
rename to drivers/staging/isdn/cmtp/cmtp.h
diff --git a/net/bluetooth/cmtp/core.c b/drivers/staging/isdn/cmtp/core.c
similarity index 100%
rename from net/bluetooth/cmtp/core.c
rename to drivers/staging/isdn/cmtp/core.c
diff --git a/net/bluetooth/cmtp/sock.c b/drivers/staging/isdn/cmtp/sock.c
similarity index 100%
rename from net/bluetooth/cmtp/sock.c
rename to drivers/staging/isdn/cmtp/sock.c
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index db82a40875e8..f3bfd9ec5e32 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -55,8 +55,6 @@ source "net/bluetooth/rfcomm/Kconfig"

 source "net/bluetooth/bnep/Kconfig"

-source "net/bluetooth/cmtp/Kconfig"
-
 source "net/bluetooth/hidp/Kconfig"

 config BT_HS
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index fda41c0b4781..7fdd758f0395 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -6,7 +6,6 @@
 obj-$(CONFIG_BT) += bluetooth.o
 obj-$(CONFIG_BT_RFCOMM) += rfcomm/
 obj-$(CONFIG_BT_BNEP) += bnep/
-obj-$(CONFIG_BT_CMTP) += cmtp/
 obj-$(CONFIG_BT_HIDP) += hidp/
 obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
