Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51887C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 22:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286B061220
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 22:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhD3Wmk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 18:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhD3Wmk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 18:42:40 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F2C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 15:41:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t94so31871154ybi.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WoB2k0k/b4jpb4nLYdFXqS2qOApFhT4BhwPMePiNdE=;
        b=KqpGOwgZ3XLUWwr5sVWbLCl4wjvzMXNK4nVyQJkyeb+oaILmIkVwa/OwZlXkUNoR+x
         WsevydFrovAP1Pa966YcxEyE2sSwVCT+MPj/ZTM8D6jhi//z87BuWzOZJviYelHQEpJM
         0yrq53P6Es5IJBM9LH+sOLB/QcPwexGwpN3xKNLryBbI0xSKS1Lpj8xofFUx6ttZdO1Y
         xqvtg3TcA55pNElE7kHbvhGl2EZBxhxULXQuDQ44cV/ZOg3BxkeqGJlcNp1ol74glaQA
         J1EMLAdreacSiLglvJM33uW2IxgjaNpJUMhTyzj7TiI3WN+EDy98Kc+ZD84SXeitLHgy
         VdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WoB2k0k/b4jpb4nLYdFXqS2qOApFhT4BhwPMePiNdE=;
        b=Vjlqi7BNPrDGipfb6LAra5CC/u1NGE7HQzGjeL1B6225wXBL5Aejd0WtiCCAaDBWv7
         C6ZT6WKU59xhZ8YPexqwf3vMKGtBCjuqAF2gPeB8c+5EzdS1e1MCllhZ5q1hZTokEqc9
         1wWO5Lyj71OqalL+1jkg/UAktH/02g5bXp91MPY0G/O8eCIjNR5v8gmriZRuXCQuKI3Q
         1mFYNq1m3rCJyY8rdUi4qYV13Wr8l87403dbOyjXlyh7aBTtyOYlBEUB5qPa/B1eh7g8
         CNfrZ1SVaYSfXhhuvOGLCSd564uuYnQngY6l5tlpHQKSXrySXuO5B06Fl4AICPerb++3
         0t0w==
X-Gm-Message-State: AOAM5327dQok8E5AOnA2j6ThiIpQRtpCFXBTl4nGCtxTIwr3PzjoCLrT
        yfzixDlfRS1QBeJ/eZ4SVUzR33DUW2vkNiwuOBo=
X-Google-Smtp-Source: ABdhPJzS3yz78zIM40kYxoDgkq75ks8ipkSt5XpZV5G+b5hd6lQyu0v+Lowv1EBmVyVRWbHkLVBU5pn1Ud3gnK4yMiw=
X-Received: by 2002:a25:7482:: with SMTP id p124mr9271159ybc.264.1619822509365;
 Fri, 30 Apr 2021 15:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210428062214.335567-1-hj.tedd.an@gmail.com> <CABBYNZJJHLZdhOFHrTHV7XN7++t4XKq3yHxS2wsi2bJ2AkRnVw@mail.gmail.com>
 <87c5b74558d3062f301dbfa28b93cdbfbe310dd2.camel@gmail.com>
In-Reply-To: <87c5b74558d3062f301dbfa28b93cdbfbe310dd2.camel@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Apr 2021 15:41:38 -0700
Message-ID: <CABBYNZKYDBQFqf8uVeXZNg-OVBks96fqRMk+8S+029Y26dSiow@mail.gmail.com>
Subject: Re: [BlueZ v2] monitor: Update manpage
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Apr 30, 2021 at 2:43 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> Hi Luiz,
>
> On Thu, 2021-04-29 at 20:51 -0700, Luiz Augusto von Dentz wrote:
> > Hi Tedd,
> >
> > On Tue, Apr 27, 2021 at 11:24 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
> > > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> > >
> > > This patch updates the manpage for btmon written in rst format.
> > > ---
> > >  Makefile.am       |  26 ++++---
> > >  Makefile.tools    |   4 ++
> > >  configure.ac      |   4 ++
> > >  doc/btmon.txt     |  35 ----------
> > >  monitor/btmon.rst | 172 ++++++++++++++++++++++++++++++++++++++++++++++
> >
> > I do wonder why you change the location from doc to monitor, I think
> > we actually should keep all the documentation under doc and perhaps
> > even have a dedicated make target for those since we would likely want
> > to generate all the manpages from rst which may be time consuming so
> > people not interested on it can just skip it.
>
> I converted all manpages in the tree to .rst and ready to submit.
> Can I combine all in this series or wait for this to merge first?

Have you added a make target for those? I really don't mind having the
manpages generated within the same location of the binary, although I
think it would be more organized to have it in one place, but a make
target would probably be a good practice.

> > >  5 files changed, 197 insertions(+), 44 deletions(-)
> > >  delete mode 100644 doc/btmon.txt
> > >  create mode 100644 monitor/btmon.rst
> > >
> > > diff --git a/Makefile.am b/Makefile.am
> > > index f98243f72..759110cbd 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -60,6 +60,11 @@ else
> > >  build_plugindir = $(plugindir)
> > >  endif
> > >
> > > +if MANPAGES
> > > +man_MANS =
> > > +endif
> > > +
> > > +manual_pages = monitor/btmon.1
> > >
> > >  plugin_LTLIBRARIES =
> > >
> > > @@ -579,13 +584,7 @@ if LIBRARY
> > >  pkgconfig_DATA = lib/bluez.pc
> > >  endif
> > >
> > > -manual_pages = doc/btmon.1
> > > -
> > > -if MANPAGES
> > > -dist_noinst_MANS += $(manual_pages)
> > > -endif
> > > -
> > > -EXTRA_DIST += $(manual_pages:.1=.txt)
> > > +EXTRA_DIST += $(manual_pages:.1=.rst)
> > >
> > >  DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
> > >                                                 --enable-health \
> > > @@ -607,11 +606,20 @@ SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> > >                 $(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
> > >                 < $< > $@
> > >
> > > +if RUN_RST2MAN
> > > +RST2MAN_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> > > +                       $(RST2MAN) --strict --no-raw \
> > > +                       --no-generator --no-datestamp $< $@
> > > +else
> > > +RST2MAN_PROCESS = $(AM_V_GEN)test -f $@ || \
> > > +               { echo "Generated manual page $@ does not exist"; false; }
> > > +endif
> > > +
> > >  %.service: %.service.in Makefile
> > >         $(SED_PROCESS)
> > >
> > > -%.1: %.txt
> > > -       $(AM_V_GEN)a2x --doctype manpage --format manpage $(srcdir)/$<
> > > +%.1: %.rst Makefile
> > > +       $(RST2MAN_PROCESS)
> > >
> > >  src/builtin.h: src/genbuiltin $(builtin_sources)
> > >         $(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
> > > diff --git a/Makefile.tools b/Makefile.tools
> > > index 57e858290..9b452aa74 100644
> > > --- a/Makefile.tools
> > > +++ b/Makefile.tools
> > > @@ -49,6 +49,10 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
> > >                                 monitor/tty.h
> > >  monitor_btmon_LDADD = lib/libbluetooth-internal.la \
> > >                                 src/libshared-mainloop.la $(UDEV_LIBS) -ldl
> > > +
> > > +if MANPAGES
> > > +man_MANS += monitor/btmon.1
> > > +endif
> > >  endif
> > >
> > >  if LOGGER
> > > diff --git a/configure.ac b/configure.ac
> > > index dbd98c9ad..d7e4766e4 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -326,7 +326,11 @@ AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" != "no")
> > >  AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
> > >                         [enable building of manual pages]),
> > >                                         [enable_manpages=${enableval}])
> > > +if (test "${enable_manpages}" != "no"); then
> > > +       AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
> > > +fi
> > >  AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
> > > +AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" = "yes" && test "${RST2MAN}" != "no")
> > >
> > >  AC_ARG_ENABLE(testing, AC_HELP_STRING([--enable-testing],
> > >                         [enable testing tools]),
> > > diff --git a/doc/btmon.txt b/doc/btmon.txt
> > > deleted file mode 100644
> > > index 7a7fc537b..000000000
> > > --- a/doc/btmon.txt
> > > +++ /dev/null
> > > @@ -1,35 +0,0 @@
> > > -BTMON(1)
> > > -========
> > > -:doctype: manpage
> > > -
> > > -
> > > -NAME
> > > -----
> > > -btmon - Bluetooth monitor
> > > -
> > > -
> > > -SYNOPSIS
> > > ---------
> > > -*btmon* ['OPTIONS']
> > > -
> > > -
> > > -DESCRIPTION
> > > ------------
> > > -The btmon(1) command provides access to the Bluetooth subsystem monitor
> > > -infrastructure for reading HCI traces.
> > > -
> > > -
> > > -AUTHOR
> > > -------
> > > -btmon was originally written by Marcel Holtmann.
> > > -
> > > -
> > > -RESOURCES
> > > ----------
> > > -See <http://www.bluez.org/>
> > > -
> > > -
> > > -COPYING
> > > --------
> > > -Free use of this software is granted under ther terms of the GNU Lesser
> > > -General Public Licenses (LGPL).
> > > diff --git a/monitor/btmon.rst b/monitor/btmon.rst
> > > new file mode 100644
> > > index 000000000..29d275eb3
> > > --- /dev/null
> > > +++ b/monitor/btmon.rst
> > > @@ -0,0 +1,172 @@
> > > +=====
> > > +btmon
> > > +=====
> > > +
> > > +-----------------
> > > +Bluetooth monitor
> > > +-----------------
> > > +
> > > +:Authors: - Marcel Holtmann <marcel@holtmann.org>
> > > +          - Tedd Ho-Jeong An <tedd.an@intel.com>
> > > +:Copyright: Free use of this software is granted under ther terms of the GNU
> > > +            Lesser General Public Licenses (LGPL).
> > > +:Version: BlueZ
> > > +:Date: April 2021
> > > +:Manual section: 1
> > > +:Manual group: Linux System Administration
> > > +
> > > +SYNOPSYS
> > > +========
> > > +
> > > +**btmon** [*OPTIONS* ...]
> > > +
> > > +DESCRIPTION
> > > +===========
> > > +
> > > +The  btmon(1) command  provides  access  to the Bluetooth subsystem monitor
> > > +infrastructure for reading HCI traces.
> > > +
> > > +OPTIONS
> > > +=======
> > > +
> > > +-r FILE, --read FILE        Read traces in btsnoop format from *FILE*.
> > > +-w FILE, --write FILE       Save traces in btsnoop format to *FILE*.
> > > +-a FILE, --analyze FILE     Analyze traces in btsnoop format from *FILE*.
> > > +                            It displays the devices found in the *FILE* with
> > > +                            its packets by type.
> > > +-s SOCKET, --server SOCKET  Start monitor server socket.
> > > +-p PRIORITY, --priority PRIORITY  Show only priority or lower for user log.
> > > +
> > > +.. list-table::
> > > +   :header-rows: 1
> > > +   :widths: auto
> > > +   :stub-columns: 1
> > > +
> > > +   * - *PRIORITY*
> > > +     - NAME
> > > +
> > > +   * - **3**
> > > +     - Error
> > > +
> > > +   * - **4**
> > > +     - Warning
> > > +
> > > +   * - **6**
> > > +     - Information (Default)
> > > +
> > > +   * - **7**
> > > +     - Debug. **debug** can be used.
> > > +
> > > +-i NUM, --index NUM         Show only specified controller. *hciNUM* is also
> > > +                            acceptable. This is useful to capture the traces
> > > +                            from the specific controller when the multiple
> > > +                            controllers are presented.
> > > +
> > > +-d TTY, --tty TTY           Read data from *TTY*.
> > > +
> > > +-B SPEED, --rate SPEED      Set TTY speed. The default *SPEED* is 115300
> > > +
> > > +-V COMPID, --vendor COMPID  Set the default company identifier. The *COMPID* is
> > > +                            a unique number assigned by the Bluetooth SIG to
> > > +                            a member company and can be found/searched from the
> > > +                            Bluetooth SIG webpage.
> > > +
> > > +                            For example, Intel is 2 and Realtek is 93.
> > > +
> > > +-M, --mgmt                  Open channel for mgmt events.
> > > +
> > > +-t, --time                  Show a time instead of time offset.
> > > +
> > > +-T, --date                  Show a time and date information instead of
> > > +                            time offset.
> > > +
> > > +-S, --sco                   Dump SCO traffic in raw hex format.
> > > +
> > > +-A, --a2dp                  Dump A2DP stream traffic in a raw hex format.
> > > +
> > > +-E IP, --ellisys IP         Send Ellisys HCI Injection.
> > > +
> > > +-P, --no-pager              Disable pager usage while reading the log file.
> > > +
> > > +-J OPTIONS, --jlink OPTIONS     Read data from RTT.  Each options are comma(,)
> > > +                                seprated without spaces.
> > > +
> > > +.. list-table::
> > > +   :header-rows: 1
> > > +   :widths: auto
> > > +   :stub-columns: 1
> > > +
> > > +   * - *OPTIONS*
> > > +     - Description
> > > +
> > > +   * - **DEVICE**
> > > +     - Required. Set the target device.
> > > +
> > > +   * - **SERIALNO**
> > > +     - (Optional) Set the USB serial number. Default is **0**.
> > > +
> > > +   * - **INTERFACE**
> > > +     - (Optional) Target interface. Default is **swd**.
> > > +
> > > +   * - **SPEED**
> > > +     - (Optional) Set target interface speed in kHz. Default is **1000**.
> > > +
> > > +-R OPTIONS, --rtt OPTIONS   RTT control block parameters. Each options are
> > > +                            comma(,) seprated without spaces.
> > > +
> > > +.. list-table::
> > > +   :header-rows: 1
> > > +   :widths: auto
> > > +   :stub-columns: 1
> > > +
> > > +   * - *OPTIONS*
> > > +     - Description
> > > +
> > > +   * - **ADDRESS**
> > > +     - (Optional) Address of RTT buffer. Default is **0x00**
> > > +
> > > +   * - **AREA**
> > > +     - (Optional) Size of range to search in RTT buffer. Default is **0**
> > > +
> > > +   * - **NAME**
> > > +     - (Optional) Buffer name. Default is **btmonitor**
> > > +
> > > +-C WIDTH, --columns WIDTH   Output width if not a terminal
> > > +
> > > +-c MODE, --color MODE       Set output color. The possible *MODE* values are:
> > > +                            **auto|always|never**.
> > > +
> > > +                            Default value is **auto**
> > > +
> > > +-v, --version               Show version
> > > +
> > > +-h, --help                  Show help options
> > > +
> > > +EXAMPLES
> > > +========
> > > +
> > > +Capture the traces from hci0 to hcidump.log file
> > > +------------------------------------------------
> > > +
> > > +.. code-block:: bash
> > > +
> > > +   $ btmon -i hci0 -w hcidump.log
> > > +
> > > +Open the trace file
> > > +-------------------
> > > +
> > > +.. code-block:: bash
> > > +
> > > +   $ btmon -r hcidump.log
> > > +
> > > +
> > > +RESOURCES
> > > +=========
> > > +
> > > +http://www.bluez.org
> > > +
> > > +REPORTING BUGS
> > > +==============
> > > +
> > > +linux-bluetooth@vger.kernel.org
> > > +
> > > --
> > > 2.25.1
> > >
> >
> >
>


-- 
Luiz Augusto von Dentz
