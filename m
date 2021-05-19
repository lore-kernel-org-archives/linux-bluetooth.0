Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE24C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7635F61244
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhESSLF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhESSLF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:11:05 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE4FC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:09:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so12604691oto.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrbQ8xTJ/3+S/Iw+hGklDvGBjoakHMdQImh0TfhWJ9E=;
        b=q/2A9tlwsRDZY9AVyq1n9lApoKMr9vvCkBMri/MESyE6dCP0XDQ0Ze1XBvhfuU9RGS
         QGikAQeYa2qhdrwgtdLKqGBPh4LiqDUnQDSMNauVCPtwUT5Hv2e7z3l6mQwb5KPI2ZoN
         hE0vpe5bvlFBVFnQni/Jve2vqvTeempB79zc6AXDiLzwE8k5E3An4qeiBkzlPPyzzAED
         3EhmDAe4H4osr3KpxQLZ9Nbu60J0LeemNX7epyFZgHfvbJIKgYKY9kYwBTX/ZKeXaIE1
         lyZKT2vFRhrpU16tmXHK4mGAS4E1ZY9l6e1JY+UzODxsxbii6z4azxdIpHqWGiEchr7T
         tSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrbQ8xTJ/3+S/Iw+hGklDvGBjoakHMdQImh0TfhWJ9E=;
        b=HyPFMMbXiGMeoHDzTzkoUZc1N66jDtEZSOmheUejm9TgR20NWYJhxT3Gpk1W4zeFLu
         qVzv0IfaV9+ii/1CdX+UGA8lWxSU92pa70T2SXiNIQ4ZPWijzvj2zwXkQ/mkJ2ZMTVx+
         0zuzYqFRBtZXYo0jPW/WrvuEqbGIGAjwnepc5k/p+k23E7dBqUABivotKMBbI3ACBxYz
         C3/OQD3l7bOsyedqWN739sP1cdjdOg+vjioQNdf7Y3rJMhqlUxtaAPXpsPX30veGlos1
         eTI0/QImpFgvC+T8DyQC0ifV/O1PF6Wh9nkXeGpU6lJxlkxo/0dHc7bzG0iVaPXfWdN5
         FSGQ==
X-Gm-Message-State: AOAM530l4OPSpYc5x4aC/+M6QS43QsGtNTFCPJJsG8gn8YWFU6amhFJW
        SQwinoN9LXNduJm0+Zxx0RW1C4PoHpPbSYEkr+jfJF61
X-Google-Smtp-Source: ABdhPJxNY+dqmqeKKrT+G8fYFTfM5oB8DXebglZZrDgCFOdB0rmwel8pZRQMoIoQsRtAV4jvimrUgk2P6NuB4TDMrBo=
X-Received: by 2002:a25:76d2:: with SMTP id r201mr1220220ybc.432.1621447773735;
 Wed, 19 May 2021 11:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210517052357.360724-1-inga.stotland@intel.com> <af74d77e80e6cba4f46658aa794de9d3b5853abf.camel@gmail.com>
In-Reply-To: <af74d77e80e6cba4f46658aa794de9d3b5853abf.camel@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 May 2021 11:09:23 -0700
Message-ID: <CABBYNZK-uae8UKOVD1BShSkqyvVHBoS+6Uc+8kLEmkPThFvktw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Add manpage for bluetooth-meshd daemon
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     Inga Stotland <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Tue, May 18, 2021 at 1:23 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> Hi Inga,
>
> On Sun, 2021-05-16 at 22:23 -0700, Inga Stotland wrote:
> > This adds manpage with a brief description of BLuettoth Mesh daemon
> > command line options.
> > ---
> >  Makefile.mesh               |  5 +++
> >  configure.ac                |  3 +-
> >  mesh/bluetooth-meshd.rst.in | 74 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 83 insertions(+), 1 deletion(-)
> >  create mode 100644 mesh/bluetooth-meshd.rst.in
> >
> > diff --git a/.gitignore b/.gitignore
> > index 9c8393a81..9f57aa193 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -145,6 +145,8 @@ tools/meshctl
> >  tools/mesh-cfgclient
> >  tools/mesh-cfgtest
> >  mesh/bluetooth-meshd
> > +mesh/bluetooth-meshd.8
> > +mesh/bluetooth-meshd.rst
> >
> >  src/bluetoothd.8
> >  src/bluetoothd.rst
> > diff --git a/Makefile.mesh b/Makefile.mesh
> > index 73eaded4a..fc28b0557 100644
> > --- a/Makefile.mesh
> > +++ b/Makefile.mesh
> > @@ -47,6 +47,11 @@ mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
> >  mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la \
> >                               mesh/bluetooth-mesh.service
> >
> > +if MANPAGES
> > +man_MANS += mesh/bluetooth-meshd.8
> > +endif
> > +manual_pages += mesh/bluetooth-meshd.8
> > +
> >  CLEANFILES += mesh/bluetooth-mesh.service
> >
> >  endif
> > diff --git a/configure.ac b/configure.ac
> > index 5157da1b5..af700eb13 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -392,6 +392,7 @@ AC_SUBST(CONFIGDIR, "${configdir}")
> >
> >  AC_DEFINE_UNQUOTED(MESH_STORAGEDIR, "${storagedir}/mesh",
> >                       [Directory for the mesh daemon storage files])
> > +AC_SUBST(MESH_STORAGEDIR, "${storagedir}/mesh")
> >
> >  AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
> >                       [enable BlueZ for Android]),
> > @@ -415,4 +416,4 @@ fi
> >  AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
> >                       [Directory for the Android daemon storage files])
> >
> > -AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc)
> > +AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc mesh/bluetooth-meshd.rst)
> > diff --git a/mesh/bluetooth-meshd.rst.in b/mesh/bluetooth-meshd.rst.in
> > new file mode 100644
> > index 000000000..06cdb69da
> > --- /dev/null
> > +++ b/mesh/bluetooth-meshd.rst.in
> > @@ -0,0 +1,74 @@
> > +===============
> > +bluetooth-meshd
> > +===============
> > +
> > +---------------------
> > +Bluetooth Mesh daemon
> > +---------------------
> > +
> > +:Version: BlueZ
> > +:Copyright: Free use of this software is granted under ther terms of the GNU
> > +            Lesser General Public Licenses (LGPL).
> > +:Date: March 2021
> > +:Manual section: 8
> > +:Manual group: Linux Connectivity
> > +
> > +SYNOPSIS
> > +========
> > +
> > +**bluetooth-meshd** [*options* ...]
> > +
> > +DESCRIPTION
> > +===========
> > +
> > +Daemon for managing Bluetooth Mesh connections on Linux.
> > +
> > +OPTIONS
> > +=======
> > +
> > +-h, --help
> > +    Print bluetooth-meshd options and exit.
> > +
> > +-n, --nodetach
> > +    Enable logging in foreground. Directs log output to the controlling
> > +    terminal in addition to syslog.
> > +
> > +-i <type>, --io <type>
> > +    Specifies I/O interface type:
> > +
> > +    *hci<index>* - Use generic HCI io on interface hci<index>,
> > +    or, if no idex is specified, the first available one.
> > +
> > +    *unit:<fd_path>*- Specifies open file descriptor for
> > +    daemon testing.
> > +
> > +    By default, if no type is specified, uses generic I/O
> > +    on the first available HCI interface.
> > +
> > +-c <file>, --config <file>
> > +    Specifies an explicit config file path instead of relying on the
> > +    default path(*@CONFIGDIR@/mesh-main.conf*) for the config file.
> > +
> > +-s <dir_path>, --storage <dir path>
> > +    Specifies an explicit storage directory path instead of the default
> > +    path(*@MESH_STORAGEDIR@*) for storing mesh node(s) configuration.
> > +
> > +-d, --debug         Enable debug output.
> > +
> > +-b, --dbus-debug    Enable D-Bus debug output.
> > +
> > +FILES
> > +=====
> > +
> > +*@CONFIGDIR@/mesh-main.conf*
> > +    Location of the global configuration file containing mesh daemon settings.
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
>
> The patch looks good to me.
> However, the CI didn't run because of the other internal issue, and I am looking into it.
>
> Regards,
> Tedd

Applied, thanks.

-- 
Luiz Augusto von Dentz
