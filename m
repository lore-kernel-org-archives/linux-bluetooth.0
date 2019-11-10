Return-Path: <SRS0=jXj2=ZC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1252C43331
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Nov 2019 21:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994120842
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Nov 2019 21:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKJVGQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:06:16 -0500
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:40438 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfKJVGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Nov 2019 16:06:16 -0500
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Nov 2019 16:06:14 EST
Received: from atl4mhob19.registeredsite.com (atl4mhob19.registeredsite.com [209.17.115.112])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id xAAKxrdm007457
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Nov 2019 15:59:53 -0500
Received: from mailpod.hostingplatform.com (atl4qobmail01pod5.registeredsite.com [10.30.71.94])
        by atl4mhob19.registeredsite.com (8.14.4/8.14.4) with ESMTP id xAAKxp6Y022774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Nov 2019 15:59:51 -0500
Received: (qmail 119463 invoked by uid 0); 10 Nov 2019 20:59:51 -0000
X-TCPREMOTEIP: 65.41.18.216
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@65.41.18.216)
  by 0 with ESMTPA; 10 Nov 2019 20:59:50 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id EDB221540536;
        Sun, 10 Nov 2019 15:59:49 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CpjagrvFws7W; Sun, 10 Nov 2019 15:59:43 -0500 (EST)
Received: from nm-ws (unknown [192.168.2.3])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTPS id 39EE91540445;
        Sun, 10 Nov 2019 15:59:43 -0500 (EST)
Message-ID: <a843f597a101bf6e74521d033b7af3ff19455adc.camel@ewol.com>
Subject: Re: BlueZ/mesh: RX not working after daemon restart (with
 workaround)
From:   Steve Brown <sbrown@ewol.com>
To:     Aurelien Jarno <aurelien@aurel32.net>,
        linux-bluetooth@vger.kernel.org
Date:   Sun, 10 Nov 2019 13:59:41 -0700
In-Reply-To: <20191110200848.GA28864@aurel32.net>
References: <20191110200848.GA28864@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, 2019-11-10 at 21:08 +0100, Aurelien Jarno wrote:
> Hi all,
> 
> On my system (Raspberry PI 3), the RX path doesn't work anymore
> following a restart of the bluetooth-meshd daemon. I have tracked
> down
> that to the fact that the receive callbacks are setup before the HCI
> is
> fully initialized. Said otherwise, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS
> is
> called before BT_HCI_CMD_RESET and the callback calling
> BT_HCI_CMD_LE_SET_SCAN_ENABLE is not called. This timing dependent
> and
> probably not reproducible on all hardware.
> 
> I have workarounded the issue by adding a small delay between the HCI
> initialization and the call to node_attach_io_all():
> 
> diff --git a/mesh/mesh.c b/mesh/mesh.c
> index 9b2b2073b..1c06060f9 100644
> --- a/mesh/mesh.c
> +++ b/mesh/mesh.c
> @@ -167,6 +167,10 @@ bool mesh_init(const char *config_dir, enum
> mesh_io_type type, void *opts)
>  	mesh_io_get_caps(mesh.io, &caps);
>  	mesh.max_filters = caps.max_num_filters;
>  
> +	for (int i = 0 ; i < 100 ; i++) {
> +		l_main_iterate(10);
> +	}
> +
>  	node_attach_io_all(mesh.io);
>  
>  	return true;
> 
> I guess there is a better way to do that by waiting for the HCI to be
> fully initialized before calling node_attach_io_all() or by using a
> callback instead. However I do not know the codebase good enough to
> fix
> that properly.
> 
> Aurelien
> 
I've experienced something similar on my rpi3. I found that on restart,
discover-unprovisioned stopped working.

In my case, it appears that meshd assumes that if there are existing
nodes, scanning has been enabled. Thus, calls from mesh-cfgclient to
discover additional unprovisioned nodes do not need another hci scan
enable at mesh/mesh-io-generic.c:736.

If meshd is restarted with preexisting nodes, scanning is still assumed
to already be enabled, but it's not. This breaks discover-unprovisioned 
for me.

I suspect this is a symptom of a deeper problem where mesh/mesh-config-
json.c:load_node doesn't completely reestablish the node state that
existed when the node was originally added.

Steve






