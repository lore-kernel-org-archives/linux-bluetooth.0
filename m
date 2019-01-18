Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C1C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9782087E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 08:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfARIu5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:50:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52237 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfARIu5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 03:50:57 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id A029BCF2C3;
        Fri, 18 Jan 2019 09:58:41 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ] mesh: Add D-Bus policy for Bluetooth mesh daemon
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190118034652.4018-1-inga.stotland@intel.com>
Date:   Fri, 18 Jan 2019 09:50:55 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Brian Gix <brian.gix@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <437FB2B8-80F7-4DE1-86E8-880AA307B618@holtmann.org>
References: <20190118034652.4018-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

> This adds new D-Bus policy file btmesh.conf
> ---
> Makefile.mesh    |  6 ++++++
> mesh/btmesh.conf | 24 ++++++++++++++++++++++++
> 2 files changed, 30 insertions(+)
> create mode 100644 mesh/btmesh.conf
> 
> diff --git a/Makefile.mesh b/Makefile.mesh
> index ea6c5e939..e15718116 100644
> --- a/Makefile.mesh
> +++ b/Makefile.mesh
> @@ -1,5 +1,9 @@
> if MESH
> 
> +if DATAFILES
> +dbus_DATA += mesh/btmesh.conf
> +endif
> +

I prefer this is named bluetooth-mesh.conf.

And for the daemon binary name this might be better as bluetoothd-mesh instead of just meshd.

> mesh_sources = mesh/mesh.h mesh/mesh.c \
> 				mesh/net_keys.h mesh/net_keys.c \
> 				mesh/mesh-io.h mesh/mesh-io.c \
> @@ -27,4 +31,6 @@ libexec_PROGRAMS += mesh/meshd
> mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
> mesh_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
> mesh_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
> +
> +EXTRA_DIST += mesh/btmesh.conf
> endif
> diff --git a/mesh/btmesh.conf b/mesh/btmesh.conf
> new file mode 100644
> index 000000000..f05545065
> --- /dev/null
> +++ b/mesh/btmesh.conf
> @@ -0,0 +1,24 @@
> +<!-- This configuration file specifies the required security policies
> +     for Bluetooth Mesh daemon to work. —>

Lower case “mesh” here.

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
> +    <allow send_interface="org.freedesktop.DBus.Properties”/>

Do you need the last two?

> +  </policy>
> +
> +  <policy context="default">
> +    <allow send_destination="org.bluez.mesh"/>
> +  </policy>
> +
> +</busconfig>

Regards

Marcel

