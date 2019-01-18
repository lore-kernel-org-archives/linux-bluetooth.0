Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79998C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 08:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ADA20855
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 08:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IIbDQfTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfARIEg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:04:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38450 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfARIEg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 03:04:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so10869781lja.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jan 2019 00:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NhT2eWhr5S5rkCErIdiQfluflXMoVDjp27+mkZozEo=;
        b=IIbDQfTRvvkn/vL97q3tKPaKDWGAvwWeBCn0/HFOvAXa5QGfKITAB7HuqR/eGKkMh4
         L2apHKsxOW2Nw3T5Ot3LdFmZIm8hjBllsghGNhdG+yzYnWLbKDBxb6QEW9qH8NUPsMAQ
         rHXih1sbOr9sF8dTnuQH15SXOavJgCdnMD4VGBSlLIeRnoV5iWjwBTvg8dy0I/7ZozQj
         7dYwTw0rNcP75NzwaArYgGGwqpOP3RaCYggIPmjaUfJiPw3RPtFO4qEjf7brAAMLuojH
         oUZJ1QUouZxfKB2WdIj/zjhvffrWO28OhxdjqgAimGGE5RTr6TxAq72iFLRiQ/76QDnZ
         Ue2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NhT2eWhr5S5rkCErIdiQfluflXMoVDjp27+mkZozEo=;
        b=kH9GxqlcXO3x5KAcsAmoBjTFiGwjQoYjgDbOQdSCDOu0dDu4HHA8ID4VPhDSk4sa5Z
         zcLz/LAqGXwo+tH3sqWMGlEDONrJFmzlg5AlM2Rquto3tpfoBuP5Vsh/THPdyTKcpsbJ
         ZVb9ZIkidL2nu2wTuoposgZ7xPy1JJ/VGx8NjMa8CysZ6d6nU+uSl/bute7mBcPhYwhq
         Izb9+APb/MwCMN9T6DMks5Smqnk0yS56EuvjdZhRRT2M7yiGiR+sh46tXA/T77+ur48u
         jnR/WxkrsKOYHwhfClOiHGjxXrUlE9W4YkEUWRXwK/GpIr4OypF7fkGKg+OXFeIwLcze
         ZbNA==
X-Gm-Message-State: AJcUukfFPcWYjfECQ6vIl8tIfLEHJ9QqktlUqzznpe3OE83ymZAH9Ar2
        KLD4xgo9zitYN3eIsdIy/VNOa0cSr0A0xs9PtihDMA==
X-Google-Smtp-Source: ALg8bN5FfzZGQIw/vaJdrOUfEL+LL33zljUNnbHdj/rE8jjz+nUNJ7D0BsxpWO8A5p41AG3TK3+iEur4i8PoxaEh0i4=
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr11168097ljd.26.1547798674458;
 Fri, 18 Jan 2019 00:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20190118034652.4018-1-inga.stotland@intel.com>
In-Reply-To: <20190118034652.4018-1-inga.stotland@intel.com>
From:   "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date:   Fri, 18 Jan 2019 05:04:23 -0300
Message-ID: <CACumGOLC+b1WsfSqgXLRBQbeZ0vFOx6bpLAFjrpYBXvrQ5oxig@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Add D-Bus policy for Bluetooth mesh daemon
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, "Gix, Brian" <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Fri, Jan 18, 2019 at 12:47 AM Inga Stotland <inga.stotland@intel.com> wrote:
>
> This adds new D-Bus policy file btmesh.conf
> ---
>  Makefile.mesh    |  6 ++++++
>  mesh/btmesh.conf | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 mesh/btmesh.conf
>
> diff --git a/Makefile.mesh b/Makefile.mesh
> index ea6c5e939..e15718116 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -1,5 +1,9 @@
>  if MESH
>
> +if DATAFILES
> +dbus_DATA += mesh/btmesh.conf
> +endif
> +
>  mesh_sources = mesh/mesh.h mesh/mesh.c \
>                                 mesh/net_keys.h mesh/net_keys.c \
>                                 mesh/mesh-io.h mesh/mesh-io.c \
> @@ -27,4 +31,6 @@ libexec_PROGRAMS += mesh/meshd
>  mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
>  mesh_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
>  mesh_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
> +
> +EXTRA_DIST += mesh/btmesh.conf
>  endif
> diff --git a/mesh/btmesh.conf b/mesh/btmesh.conf
> new file mode 100644
> index 000000000..f05545065
> --- /dev/null
> +++ b/mesh/btmesh.conf
> @@ -0,0 +1,24 @@
> +<!-- This configuration file specifies the required security policies
> +     for Bluetooth Mesh daemon to work. -->
> +
> +<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
> + "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
> +<busconfig>
> +
> +  <!-- ../system.conf have denied everything, so we just punch some holes -->
> +
> +  <policy user="root">
> +    <allow own="org.bluez.mesh"/>
> +    <allow send_destination="org.bluez.mesh"/>
> +    <allow send_interface="org.bluez.mesh.Application1"/>
> +    <allow send_interface="org.bluez.mesh.Element1"/>
> +    <allow send_interface="org.bluez.mesh.ProvisionAgent1"/>
> +    <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
> +    <allow send_interface="org.freedesktop.DBus.Properties"/>
> +  </policy>
> +
> +  <policy context="default">
> +    <allow send_destination="org.bluez.mesh"/>
> +  </policy>
> +
> +</busconfig>
> --
> 2.17.2

Any plans to put together a btmesh.service file for systemd as well?
