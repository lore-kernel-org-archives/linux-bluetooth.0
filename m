Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD5BC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 21:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B072C61477
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 21:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhD3VoY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhD3VoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 17:44:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B880AC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 14:43:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h7so8756024plt.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WOkdBRoxsu/zmPXmrE859+Pr1C8EhGnSrf6dI6ymzwo=;
        b=D0Fnos2dG5ZMvkG5MucCgYIVxAP+SCmx/Tldm7NlY9dNtSt4byvY0Auy6xUtlc/Jv4
         Tu/aYijI6980OfGaoYOeluRaC4xF+bWYHhhqby5xXnnD06WkmuK002PHKX8D42VYNC6A
         eiKJC50ZxXHqDxsTSlcJH2yvLhXvN8xuW/+TBGgUBTBQM7ksximuosK9zI+BzjwKyvIH
         3bjGS0rfCsTndSJpZJUHP02o3eDYAdXy92MmbyQmK6CbOshlgS09ck+Z4FEaSyMVrCnP
         3bizjl0vWsX8JhfsRttnsTZsb0S/xQGcLBChtu+4v3wau0pNJMBaLLgghD3gNlxUgM1W
         enSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WOkdBRoxsu/zmPXmrE859+Pr1C8EhGnSrf6dI6ymzwo=;
        b=b6lC3vIK7AWOfUEXAUs83oVjcRHBw3ZJ/CwoCkWi9z76q22+VUYRy8Vq3emzJ8qOGD
         9Xv129XSo0BCQ4Tr3iq0Pl0HGw8RzAq3HaRu37CrITxF5UmVPlGPhec+CDfxsuCmeoQh
         hRoh6hiZcJemIzC2vnVmfrRdamPFRz5p3YVx+9fABDdsieuWiNwB/oDqGHb1xX2J23Ro
         6/IYXSqTOFrPJL3xrJFm8zkGwB1I+JyrQMx0FMNXxPTqOoaoxMMMEyKzfh36leVIH02u
         ajd+doJIyh4rRtPZwj+Q9XmdhL3kVQML9H90p1h1lgVlGQ1WqejM62bX6+YYzpe8evKC
         bTPA==
X-Gm-Message-State: AOAM530p3Li5rWIhClW4X3OXrhmZfNWupfVZNI57+X3KIli2AtkNcuWC
        BElGVIs8P9EJQRUXgHjL5tc=
X-Google-Smtp-Source: ABdhPJwV+2IYd312cqgy9hAfP+Y9g5nVBf8QPZWusqL3jsla9urrIbdedIOAj0Wtvp9P7x3kGFewSw==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr16835800pjx.164.1619819011141;
        Fri, 30 Apr 2021 14:43:31 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id w124sm3018628pfb.73.2021.04.30.14.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:43:30 -0700 (PDT)
Message-ID: <87c5b74558d3062f301dbfa28b93cdbfbe310dd2.camel@gmail.com>
Subject: Re: [BlueZ v2] monitor: Update manpage
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Fri, 30 Apr 2021 14:43:29 -0700
In-Reply-To: <CABBYNZJJHLZdhOFHrTHV7XN7++t4XKq3yHxS2wsi2bJ2AkRnVw@mail.gmail.com>
References: <20210428062214.335567-1-hj.tedd.an@gmail.com>
         <CABBYNZJJHLZdhOFHrTHV7XN7++t4XKq3yHxS2wsi2bJ2AkRnVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, 2021-04-29 at 20:51 -0700, Luiz Augusto von Dentz wrote:
> Hi Tedd,
> 
> On Tue, Apr 27, 2021 at 11:24 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
> > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> > 
> > This patch updates the manpage for btmon written in rst format.
> > ---
> >  Makefile.am       |  26 ++++---
> >  Makefile.tools    |   4 ++
> >  configure.ac      |   4 ++
> >  doc/btmon.txt     |  35 ----------
> >  monitor/btmon.rst | 172 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> I do wonder why you change the location from doc to monitor, I think
> we actually should keep all the documentation under doc and perhaps
> even have a dedicated make target for those since we would likely want
> to generate all the manpages from rst which may be time consuming so
> people not interested on it can just skip it.

I converted all manpages in the tree to .rst and ready to submit.
Can I combine all in this series or wait for this to merge first?

> >  5 files changed, 197 insertions(+), 44 deletions(-)
> >  delete mode 100644 doc/btmon.txt
> >  create mode 100644 monitor/btmon.rst
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index f98243f72..759110cbd 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -60,6 +60,11 @@ else
> >  build_plugindir = $(plugindir)
> >  endif
> > 
> > +if MANPAGES
> > +man_MANS =
> > +endif
> > +
> > +manual_pages = monitor/btmon.1
> > 
> >  plugin_LTLIBRARIES =
> > 
> > @@ -579,13 +584,7 @@ if LIBRARY
> >  pkgconfig_DATA = lib/bluez.pc
> >  endif
> > 
> > -manual_pages = doc/btmon.1
> > -
> > -if MANPAGES
> > -dist_noinst_MANS += $(manual_pages)
> > -endif
> > -
> > -EXTRA_DIST += $(manual_pages:.1=.txt)
> > +EXTRA_DIST += $(manual_pages:.1=.rst)
> > 
> >  DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
> >                                                 --enable-health \
> > @@ -607,11 +606,20 @@ SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> >                 $(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
> >                 < $< > $@
> > 
> > +if RUN_RST2MAN
> > +RST2MAN_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> > +                       $(RST2MAN) --strict --no-raw \
> > +                       --no-generator --no-datestamp $< $@
> > +else
> > +RST2MAN_PROCESS = $(AM_V_GEN)test -f $@ || \
> > +               { echo "Generated manual page $@ does not exist"; false; }
> > +endif
> > +
> >  %.service: %.service.in Makefile
> >         $(SED_PROCESS)
> > 
> > -%.1: %.txt
> > -       $(AM_V_GEN)a2x --doctype manpage --format manpage $(srcdir)/$<
> > +%.1: %.rst Makefile
> > +       $(RST2MAN_PROCESS)
> > 
> >  src/builtin.h: src/genbuiltin $(builtin_sources)
> >         $(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
> > diff --git a/Makefile.tools b/Makefile.tools
> > index 57e858290..9b452aa74 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -49,6 +49,10 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
> >                                 monitor/tty.h
> >  monitor_btmon_LDADD = lib/libbluetooth-internal.la \
> >                                 src/libshared-mainloop.la $(UDEV_LIBS) -ldl
> > +
> > +if MANPAGES
> > +man_MANS += monitor/btmon.1
> > +endif
> >  endif
> > 
> >  if LOGGER
> > diff --git a/configure.ac b/configure.ac
> > index dbd98c9ad..d7e4766e4 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -326,7 +326,11 @@ AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" != "no")
> >  AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
> >                         [enable building of manual pages]),
> >                                         [enable_manpages=${enableval}])
> > +if (test "${enable_manpages}" != "no"); then
> > +       AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
> > +fi
> >  AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
> > +AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" = "yes" && test "${RST2MAN}" != "no")
> > 
> >  AC_ARG_ENABLE(testing, AC_HELP_STRING([--enable-testing],
> >                         [enable testing tools]),
> > diff --git a/doc/btmon.txt b/doc/btmon.txt
> > deleted file mode 100644
> > index 7a7fc537b..000000000
> > --- a/doc/btmon.txt
> > +++ /dev/null
> > @@ -1,35 +0,0 @@
> > -BTMON(1)
> > -========
> > -:doctype: manpage
> > -
> > -
> > -NAME
> > -----
> > -btmon - Bluetooth monitor
> > -
> > -
> > -SYNOPSIS
> > ---------
> > -*btmon* ['OPTIONS']
> > -
> > -
> > -DESCRIPTION
> > ------------
> > -The btmon(1) command provides access to the Bluetooth subsystem monitor
> > -infrastructure for reading HCI traces.
> > -
> > -
> > -AUTHOR
> > -------
> > -btmon was originally written by Marcel Holtmann.
> > -
> > -
> > -RESOURCES
> > ----------
> > -See <http://www.bluez.org/>
> > -
> > -
> > -COPYING
> > --------
> > -Free use of this software is granted under ther terms of the GNU Lesser
> > -General Public Licenses (LGPL).
> > diff --git a/monitor/btmon.rst b/monitor/btmon.rst
> > new file mode 100644
> > index 000000000..29d275eb3
> > --- /dev/null
> > +++ b/monitor/btmon.rst
> > @@ -0,0 +1,172 @@
> > +=====
> > +btmon
> > +=====
> > +
> > +-----------------
> > +Bluetooth monitor
> > +-----------------
> > +
> > +:Authors: - Marcel Holtmann <marcel@holtmann.org>
> > +          - Tedd Ho-Jeong An <tedd.an@intel.com>
> > +:Copyright: Free use of this software is granted under ther terms of the GNU
> > +            Lesser General Public Licenses (LGPL).
> > +:Version: BlueZ
> > +:Date: April 2021
> > +:Manual section: 1
> > +:Manual group: Linux System Administration
> > +
> > +SYNOPSYS
> > +========
> > +
> > +**btmon** [*OPTIONS* ...]
> > +
> > +DESCRIPTION
> > +===========
> > +
> > +The  btmon(1) command  provides  access  to the Bluetooth subsystem monitor
> > +infrastructure for reading HCI traces.
> > +
> > +OPTIONS
> > +=======
> > +
> > +-r FILE, --read FILE        Read traces in btsnoop format from *FILE*.
> > +-w FILE, --write FILE       Save traces in btsnoop format to *FILE*.
> > +-a FILE, --analyze FILE     Analyze traces in btsnoop format from *FILE*.
> > +                            It displays the devices found in the *FILE* with
> > +                            its packets by type.
> > +-s SOCKET, --server SOCKET  Start monitor server socket.
> > +-p PRIORITY, --priority PRIORITY  Show only priority or lower for user log.
> > +
> > +.. list-table::
> > +   :header-rows: 1
> > +   :widths: auto
> > +   :stub-columns: 1
> > +
> > +   * - *PRIORITY*
> > +     - NAME
> > +
> > +   * - **3**
> > +     - Error
> > +
> > +   * - **4**
> > +     - Warning
> > +
> > +   * - **6**
> > +     - Information (Default)
> > +
> > +   * - **7**
> > +     - Debug. **debug** can be used.
> > +
> > +-i NUM, --index NUM         Show only specified controller. *hciNUM* is also
> > +                            acceptable. This is useful to capture the traces
> > +                            from the specific controller when the multiple
> > +                            controllers are presented.
> > +
> > +-d TTY, --tty TTY           Read data from *TTY*.
> > +
> > +-B SPEED, --rate SPEED      Set TTY speed. The default *SPEED* is 115300
> > +
> > +-V COMPID, --vendor COMPID  Set the default company identifier. The *COMPID* is
> > +                            a unique number assigned by the Bluetooth SIG to
> > +                            a member company and can be found/searched from the
> > +                            Bluetooth SIG webpage.
> > +
> > +                            For example, Intel is 2 and Realtek is 93.
> > +
> > +-M, --mgmt                  Open channel for mgmt events.
> > +
> > +-t, --time                  Show a time instead of time offset.
> > +
> > +-T, --date                  Show a time and date information instead of
> > +                            time offset.
> > +
> > +-S, --sco                   Dump SCO traffic in raw hex format.
> > +
> > +-A, --a2dp                  Dump A2DP stream traffic in a raw hex format.
> > +
> > +-E IP, --ellisys IP         Send Ellisys HCI Injection.
> > +
> > +-P, --no-pager              Disable pager usage while reading the log file.
> > +
> > +-J OPTIONS, --jlink OPTIONS     Read data from RTT.  Each options are comma(,)
> > +                                seprated without spaces.
> > +
> > +.. list-table::
> > +   :header-rows: 1
> > +   :widths: auto
> > +   :stub-columns: 1
> > +
> > +   * - *OPTIONS*
> > +     - Description
> > +
> > +   * - **DEVICE**
> > +     - Required. Set the target device.
> > +
> > +   * - **SERIALNO**
> > +     - (Optional) Set the USB serial number. Default is **0**.
> > +
> > +   * - **INTERFACE**
> > +     - (Optional) Target interface. Default is **swd**.
> > +
> > +   * - **SPEED**
> > +     - (Optional) Set target interface speed in kHz. Default is **1000**.
> > +
> > +-R OPTIONS, --rtt OPTIONS   RTT control block parameters. Each options are
> > +                            comma(,) seprated without spaces.
> > +
> > +.. list-table::
> > +   :header-rows: 1
> > +   :widths: auto
> > +   :stub-columns: 1
> > +
> > +   * - *OPTIONS*
> > +     - Description
> > +
> > +   * - **ADDRESS**
> > +     - (Optional) Address of RTT buffer. Default is **0x00**
> > +
> > +   * - **AREA**
> > +     - (Optional) Size of range to search in RTT buffer. Default is **0**
> > +
> > +   * - **NAME**
> > +     - (Optional) Buffer name. Default is **btmonitor**
> > +
> > +-C WIDTH, --columns WIDTH   Output width if not a terminal
> > +
> > +-c MODE, --color MODE       Set output color. The possible *MODE* values are:
> > +                            **auto|always|never**.
> > +
> > +                            Default value is **auto**
> > +
> > +-v, --version               Show version
> > +
> > +-h, --help                  Show help options
> > +
> > +EXAMPLES
> > +========
> > +
> > +Capture the traces from hci0 to hcidump.log file
> > +------------------------------------------------
> > +
> > +.. code-block:: bash
> > +
> > +   $ btmon -i hci0 -w hcidump.log
> > +
> > +Open the trace file
> > +-------------------
> > +
> > +.. code-block:: bash
> > +
> > +   $ btmon -r hcidump.log
> > +
> > +
> > +RESOURCES
> > +=========
> > +
> > +http://www.bluez.org
> > +
> > +REPORTING BUGS
> > +==============
> > +
> > +linux-bluetooth@vger.kernel.org
> > +
> > --
> > 2.25.1
> > 
> 
> 

