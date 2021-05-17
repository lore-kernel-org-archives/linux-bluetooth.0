Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B5C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D5560D07
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 17:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhEQRik (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 13:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhEQRij (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 13:38:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147EC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 10:37:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x188so5449477pfd.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=rHIT7tQCSP/QsqKufAmqx+2Z9RoakSgn8mNAylmQ/T8=;
        b=dqnvSBdlXOSgeuNosHut16NShtPXK2oh2sgvbCVgB7DGkJVj3RB1IqqDawgwF5xQIH
         qeME7vYID3aTERhh2lKMFESopbpKU8wKUv6gw5NkuIeS/YURw2soF0JcEWf4OgGGk5wd
         VMcTBjlpCezymTZm9FxWXKWYLlvwPW7tpP3yTV82zVDGRqw3jZZ6MobYBhuWs1EX6isk
         Cc4XP6oimuTlky6+pld6dhkMMpmzvBwTOv0G8GPWqLpCu9oEy5UEzcthD7FAC5wMneA8
         LfJsRyoKA7K5hQyNFN7iIT35UbV0gG5yJGOtYbv8Jo9cRVHVDQsqzPzq8sQn3K6JxlDS
         pYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rHIT7tQCSP/QsqKufAmqx+2Z9RoakSgn8mNAylmQ/T8=;
        b=mRRji6Wf0Jaqg/IlQs/Qx25nyC2+y8I9qXfd62BZJUetiIWsx95ltaRaL4n2dVS3Ax
         dLDJsFi/alQQ3QEVLbTOhAbtdHI05S0X4RVZRHNS1Bq1imzD2IYdl4Fup3UMv1hlo4yS
         zNDH0VjnOYxahCPY5/PCd82eiBk3QAvBG6uyuN1dyzWIHbBD9MxfHG8ylorb116C8FCU
         H1GHB/j+OcacWZBUFGigeHOGL2jN7CNtl6n8oOR2kl2KJfimj/0JlgJzc77wCPx1ZA9/
         7R56S3oaoULbKFbaCq2lQ3PqYyJI9hbGOlVoO9QXGqSc0HOdpD9pjB1aEFVBcYV3tV4j
         9XJA==
X-Gm-Message-State: AOAM530YkIe3rRZRR4F90z8Bh0gYnqrGxKFnnbG+qUmJqFsB1/o0RCrm
        TuMrQSOWp18tmvZ3DGoQCtw=
X-Google-Smtp-Source: ABdhPJysm+ewGVg8tLoaP41VJn2uu+uLDUaRBDSYReAD5dpsb1Ff42D+IwwEDZskRV4yIKCY6IvdoA==
X-Received: by 2002:a62:d108:0:b029:25d:497e:2dfd with SMTP id z8-20020a62d1080000b029025d497e2dfdmr581966pfg.29.1621273042519;
        Mon, 17 May 2021 10:37:22 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::f604])
        by smtp.gmail.com with ESMTPSA id i24sm10159511pfd.35.2021.05.17.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:37:21 -0700 (PDT)
Message-ID: <af74d77e80e6cba4f46658aa794de9d3b5853abf.camel@gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Add manpage for bluetooth-meshd daemon
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 17 May 2021 10:37:21 -0700
In-Reply-To: <20210517052357.360724-1-inga.stotland@intel.com>
References: <20210517052357.360724-1-inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Sun, 2021-05-16 at 22:23 -0700, Inga Stotland wrote:
> This adds manpage with a brief description of BLuettoth Mesh daemon
> command line options.
> ---
>  Makefile.mesh               |  5 +++
>  configure.ac                |  3 +-
>  mesh/bluetooth-meshd.rst.in | 74 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 mesh/bluetooth-meshd.rst.in
> 
> diff --git a/.gitignore b/.gitignore
> index 9c8393a81..9f57aa193 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -145,6 +145,8 @@ tools/meshctl
>  tools/mesh-cfgclient
>  tools/mesh-cfgtest
>  mesh/bluetooth-meshd
> +mesh/bluetooth-meshd.8
> +mesh/bluetooth-meshd.rst
>  
>  src/bluetoothd.8
>  src/bluetoothd.rst
> diff --git a/Makefile.mesh b/Makefile.mesh
> index 73eaded4a..fc28b0557 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -47,6 +47,11 @@ mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
>  mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la \
>  				mesh/bluetooth-mesh.service
>  
> +if MANPAGES
> +man_MANS += mesh/bluetooth-meshd.8
> +endif
> +manual_pages += mesh/bluetooth-meshd.8
> +
>  CLEANFILES += mesh/bluetooth-mesh.service
>  
>  endif
> diff --git a/configure.ac b/configure.ac
> index 5157da1b5..af700eb13 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -392,6 +392,7 @@ AC_SUBST(CONFIGDIR, "${configdir}")
>  
>  AC_DEFINE_UNQUOTED(MESH_STORAGEDIR, "${storagedir}/mesh",
>  			[Directory for the mesh daemon storage files])
> +AC_SUBST(MESH_STORAGEDIR, "${storagedir}/mesh")
>  
>  AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
>  			[enable BlueZ for Android]),
> @@ -415,4 +416,4 @@ fi
>  AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
>  			[Directory for the Android daemon storage files])
>  
> -AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc)
> +AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc mesh/bluetooth-meshd.rst)
> diff --git a/mesh/bluetooth-meshd.rst.in b/mesh/bluetooth-meshd.rst.in
> new file mode 100644
> index 000000000..06cdb69da
> --- /dev/null
> +++ b/mesh/bluetooth-meshd.rst.in
> @@ -0,0 +1,74 @@
> +===============
> +bluetooth-meshd
> +===============
> +
> +---------------------
> +Bluetooth Mesh daemon
> +---------------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: March 2021
> +:Manual section: 8
> +:Manual group: Linux Connectivity
> +
> +SYNOPSIS
> +========
> +
> +**bluetooth-meshd** [*options* ...]
> +
> +DESCRIPTION
> +===========
> +
> +Daemon for managing Bluetooth Mesh connections on Linux.
> +
> +OPTIONS
> +=======
> +
> +-h, --help
> +    Print bluetooth-meshd options and exit.
> +
> +-n, --nodetach
> +    Enable logging in foreground. Directs log output to the controlling
> +    terminal in addition to syslog.
> +
> +-i <type>, --io <type>
> +    Specifies I/O interface type:
> +
> +    *hci<index>* - Use generic HCI io on interface hci<index>,
> +    or, if no idex is specified, the first available one.
> +
> +    *unit:<fd_path>*- Specifies open file descriptor for
> +    daemon testing.
> +
> +    By default, if no type is specified, uses generic I/O
> +    on the first available HCI interface.
> +
> +-c <file>, --config <file>
> +    Specifies an explicit config file path instead of relying on the
> +    default path(*@CONFIGDIR@/mesh-main.conf*) for the config file.
> +
> +-s <dir_path>, --storage <dir path>
> +    Specifies an explicit storage directory path instead of the default
> +    path(*@MESH_STORAGEDIR@*) for storing mesh node(s) configuration.
> +
> +-d, --debug         Enable debug output.
> +
> +-b, --dbus-debug    Enable D-Bus debug output.
> +
> +FILES
> +=====
> +
> +*@CONFIGDIR@/mesh-main.conf*
> +    Location of the global configuration file containing mesh daemon settings.
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

The patch looks good to me.
However, the CI didn't run because of the other internal issue, and I am looking into it.

Regards,
Tedd


