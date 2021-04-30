Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5575FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 03:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7F7611CB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 03:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhD3DwQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Apr 2021 23:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3DwQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Apr 2021 23:52:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C3C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Apr 2021 20:51:28 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id b131so5898672ybg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Apr 2021 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vmpr6p3YvbS0aLt+4y8R4KUObnOtryNiUR9DJEiMtBs=;
        b=Fj+fun5Df6e+C+M4ml2Mw5fAiyIFPXhInheuOvFpiemKnMqm8m7sIhZNVBko3GPYze
         rawwKkERuyW1KHOl5ofgBtln6nyJgZd34jbWoPOAauzcF/wleR/SZzyb1qltvU1dJSEh
         nu0DcKCgW8enmBDj8+DIcqe52Q1lMVwCbOASww1GhYll4q6kRJHOBZy05mr01LLpNxMc
         kw9AVXTtfrTVVB9QqGjwHxdljYLqEy80E1rIf0Op4CZU8k8JIt3MWlc6k5cEN+Fg4HUl
         VQF79D/kbhvZ5o7x64kJOiRXkdFbhrhKTQe4VQXqJ16+wMzqFygXIePzhQmFHns2oW9K
         kfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vmpr6p3YvbS0aLt+4y8R4KUObnOtryNiUR9DJEiMtBs=;
        b=eFQW43XCmaUrNaqEDRC0kFU12Bjknt5POj6LA+vvP88gfqanOrovdqgjbTJw5AilWa
         MO1mCkWpO+VUL6YNt6nxKSZ+q3ht0pG43GVPRmFdU/CwPZL3fOq2H5/YYBrqLi+TJDb3
         YfXidWUzAfqGrL5cqqt9DPJeubuiXC6af7hXVtknxa/sAD9RFKY2qayTKAKQKu57lOAG
         xI6IdlHu4+YsnR6Bh0bCbqCqV3t+oo1MI7tgCrZxl6iLaAkyrJsMGieQ2/teQIB43R47
         5BaS7bLJalZsJkViNdM14QMN2SScYxOktVpb2LEyMXWH8x0Zc9WOcEvnmtBKgjGUXi5Q
         h65w==
X-Gm-Message-State: AOAM531R16/OfwpgEJWLTUkT5cs4GeMTwJdiBWLrArEAuP0WgRWYllHO
        mJ5jvWuRMGFRUb2kxOFA3Z/wBYrkQ1utWt20rCI=
X-Google-Smtp-Source: ABdhPJzJu9ckAdCdpyBi7dVl9MtTwXA+z+ZRb1FjIpsa0lLEhW3ZHE64Iqomi0K5cGcZX1ZMnycFDeE9iQLym48wFGM=
X-Received: by 2002:a25:c84:: with SMTP id 126mr4271875ybm.282.1619754687186;
 Thu, 29 Apr 2021 20:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210428062214.335567-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210428062214.335567-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Apr 2021 20:51:15 -0700
Message-ID: <CABBYNZJJHLZdhOFHrTHV7XN7++t4XKq3yHxS2wsi2bJ2AkRnVw@mail.gmail.com>
Subject: Re: [BlueZ v2] monitor: Update manpage
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Apr 27, 2021 at 11:24 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch updates the manpage for btmon written in rst format.
> ---
>  Makefile.am       |  26 ++++---
>  Makefile.tools    |   4 ++
>  configure.ac      |   4 ++
>  doc/btmon.txt     |  35 ----------
>  monitor/btmon.rst | 172 ++++++++++++++++++++++++++++++++++++++++++++++

I do wonder why you change the location from doc to monitor, I think
we actually should keep all the documentation under doc and perhaps
even have a dedicated make target for those since we would likely want
to generate all the manpages from rst which may be time consuming so
people not interested on it can just skip it.

>  5 files changed, 197 insertions(+), 44 deletions(-)
>  delete mode 100644 doc/btmon.txt
>  create mode 100644 monitor/btmon.rst
>
> diff --git a/Makefile.am b/Makefile.am
> index f98243f72..759110cbd 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -60,6 +60,11 @@ else
>  build_plugindir = $(plugindir)
>  endif
>
> +if MANPAGES
> +man_MANS =
> +endif
> +
> +manual_pages = monitor/btmon.1
>
>  plugin_LTLIBRARIES =
>
> @@ -579,13 +584,7 @@ if LIBRARY
>  pkgconfig_DATA = lib/bluez.pc
>  endif
>
> -manual_pages = doc/btmon.1
> -
> -if MANPAGES
> -dist_noinst_MANS += $(manual_pages)
> -endif
> -
> -EXTRA_DIST += $(manual_pages:.1=.txt)
> +EXTRA_DIST += $(manual_pages:.1=.rst)
>
>  DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
>                                                 --enable-health \
> @@ -607,11 +606,20 @@ SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
>                 $(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
>                 < $< > $@
>
> +if RUN_RST2MAN
> +RST2MAN_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> +                       $(RST2MAN) --strict --no-raw \
> +                       --no-generator --no-datestamp $< $@
> +else
> +RST2MAN_PROCESS = $(AM_V_GEN)test -f $@ || \
> +               { echo "Generated manual page $@ does not exist"; false; }
> +endif
> +
>  %.service: %.service.in Makefile
>         $(SED_PROCESS)
>
> -%.1: %.txt
> -       $(AM_V_GEN)a2x --doctype manpage --format manpage $(srcdir)/$<
> +%.1: %.rst Makefile
> +       $(RST2MAN_PROCESS)
>
>  src/builtin.h: src/genbuiltin $(builtin_sources)
>         $(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
> diff --git a/Makefile.tools b/Makefile.tools
> index 57e858290..9b452aa74 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -49,6 +49,10 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
>                                 monitor/tty.h
>  monitor_btmon_LDADD = lib/libbluetooth-internal.la \
>                                 src/libshared-mainloop.la $(UDEV_LIBS) -ldl
> +
> +if MANPAGES
> +man_MANS += monitor/btmon.1
> +endif
>  endif
>
>  if LOGGER
> diff --git a/configure.ac b/configure.ac
> index dbd98c9ad..d7e4766e4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -326,7 +326,11 @@ AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" != "no")
>  AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
>                         [enable building of manual pages]),
>                                         [enable_manpages=${enableval}])
> +if (test "${enable_manpages}" != "no"); then
> +       AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
> +fi
>  AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
> +AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" = "yes" && test "${RST2MAN}" != "no")
>
>  AC_ARG_ENABLE(testing, AC_HELP_STRING([--enable-testing],
>                         [enable testing tools]),
> diff --git a/doc/btmon.txt b/doc/btmon.txt
> deleted file mode 100644
> index 7a7fc537b..000000000
> --- a/doc/btmon.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -BTMON(1)
> -========
> -:doctype: manpage
> -
> -
> -NAME
> -----
> -btmon - Bluetooth monitor
> -
> -
> -SYNOPSIS
> ---------
> -*btmon* ['OPTIONS']
> -
> -
> -DESCRIPTION
> ------------
> -The btmon(1) command provides access to the Bluetooth subsystem monitor
> -infrastructure for reading HCI traces.
> -
> -
> -AUTHOR
> -------
> -btmon was originally written by Marcel Holtmann.
> -
> -
> -RESOURCES
> ----------
> -See <http://www.bluez.org/>
> -
> -
> -COPYING
> --------
> -Free use of this software is granted under ther terms of the GNU Lesser
> -General Public Licenses (LGPL).
> diff --git a/monitor/btmon.rst b/monitor/btmon.rst
> new file mode 100644
> index 000000000..29d275eb3
> --- /dev/null
> +++ b/monitor/btmon.rst
> @@ -0,0 +1,172 @@
> +=====
> +btmon
> +=====
> +
> +-----------------
> +Bluetooth monitor
> +-----------------
> +
> +:Authors: - Marcel Holtmann <marcel@holtmann.org>
> +          - Tedd Ho-Jeong An <tedd.an@intel.com>
> +:Copyright: Free use of this software is granted under ther terms of the GNU
> +            Lesser General Public Licenses (LGPL).
> +:Version: BlueZ
> +:Date: April 2021
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSYS
> +========
> +
> +**btmon** [*OPTIONS* ...]
> +
> +DESCRIPTION
> +===========
> +
> +The  btmon(1) command  provides  access  to the Bluetooth subsystem monitor
> +infrastructure for reading HCI traces.
> +
> +OPTIONS
> +=======
> +
> +-r FILE, --read FILE        Read traces in btsnoop format from *FILE*.
> +-w FILE, --write FILE       Save traces in btsnoop format to *FILE*.
> +-a FILE, --analyze FILE     Analyze traces in btsnoop format from *FILE*.
> +                            It displays the devices found in the *FILE* with
> +                            its packets by type.
> +-s SOCKET, --server SOCKET  Start monitor server socket.
> +-p PRIORITY, --priority PRIORITY  Show only priority or lower for user log.
> +
> +.. list-table::
> +   :header-rows: 1
> +   :widths: auto
> +   :stub-columns: 1
> +
> +   * - *PRIORITY*
> +     - NAME
> +
> +   * - **3**
> +     - Error
> +
> +   * - **4**
> +     - Warning
> +
> +   * - **6**
> +     - Information (Default)
> +
> +   * - **7**
> +     - Debug. **debug** can be used.
> +
> +-i NUM, --index NUM         Show only specified controller. *hciNUM* is also
> +                            acceptable. This is useful to capture the traces
> +                            from the specific controller when the multiple
> +                            controllers are presented.
> +
> +-d TTY, --tty TTY           Read data from *TTY*.
> +
> +-B SPEED, --rate SPEED      Set TTY speed. The default *SPEED* is 115300
> +
> +-V COMPID, --vendor COMPID  Set the default company identifier. The *COMPID* is
> +                            a unique number assigned by the Bluetooth SIG to
> +                            a member company and can be found/searched from the
> +                            Bluetooth SIG webpage.
> +
> +                            For example, Intel is 2 and Realtek is 93.
> +
> +-M, --mgmt                  Open channel for mgmt events.
> +
> +-t, --time                  Show a time instead of time offset.
> +
> +-T, --date                  Show a time and date information instead of
> +                            time offset.
> +
> +-S, --sco                   Dump SCO traffic in raw hex format.
> +
> +-A, --a2dp                  Dump A2DP stream traffic in a raw hex format.
> +
> +-E IP, --ellisys IP         Send Ellisys HCI Injection.
> +
> +-P, --no-pager              Disable pager usage while reading the log file.
> +
> +-J OPTIONS, --jlink OPTIONS     Read data from RTT.  Each options are comma(,)
> +                                seprated without spaces.
> +
> +.. list-table::
> +   :header-rows: 1
> +   :widths: auto
> +   :stub-columns: 1
> +
> +   * - *OPTIONS*
> +     - Description
> +
> +   * - **DEVICE**
> +     - Required. Set the target device.
> +
> +   * - **SERIALNO**
> +     - (Optional) Set the USB serial number. Default is **0**.
> +
> +   * - **INTERFACE**
> +     - (Optional) Target interface. Default is **swd**.
> +
> +   * - **SPEED**
> +     - (Optional) Set target interface speed in kHz. Default is **1000**.
> +
> +-R OPTIONS, --rtt OPTIONS   RTT control block parameters. Each options are
> +                            comma(,) seprated without spaces.
> +
> +.. list-table::
> +   :header-rows: 1
> +   :widths: auto
> +   :stub-columns: 1
> +
> +   * - *OPTIONS*
> +     - Description
> +
> +   * - **ADDRESS**
> +     - (Optional) Address of RTT buffer. Default is **0x00**
> +
> +   * - **AREA**
> +     - (Optional) Size of range to search in RTT buffer. Default is **0**
> +
> +   * - **NAME**
> +     - (Optional) Buffer name. Default is **btmonitor**
> +
> +-C WIDTH, --columns WIDTH   Output width if not a terminal
> +
> +-c MODE, --color MODE       Set output color. The possible *MODE* values are:
> +                            **auto|always|never**.
> +
> +                            Default value is **auto**
> +
> +-v, --version               Show version
> +
> +-h, --help                  Show help options
> +
> +EXAMPLES
> +========
> +
> +Capture the traces from hci0 to hcidump.log file
> +------------------------------------------------
> +
> +.. code-block:: bash
> +
> +   $ btmon -i hci0 -w hcidump.log
> +
> +Open the trace file
> +-------------------
> +
> +.. code-block:: bash
> +
> +   $ btmon -r hcidump.log
> +
> +
> +RESOURCES
> +=========
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +==============
> +
> +linux-bluetooth@vger.kernel.org
> +
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
