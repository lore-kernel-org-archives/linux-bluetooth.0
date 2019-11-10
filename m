Return-Path: <SRS0=jXj2=ZC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA0AC43331
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Nov 2019 21:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC0520854
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Nov 2019 21:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKJVjy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:39:54 -0500
Received: from hall.aurel32.net ([195.154.113.88]:47848 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfKJVjy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Nov 2019 16:39:54 -0500
Received: from aurel32 by hall.aurel32.net with local (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iTuw5-00062d-F2; Sun, 10 Nov 2019 22:39:53 +0100
Date:   Sun, 10 Nov 2019 22:39:53 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Steve Brown <sbrown@ewol.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ/mesh: RX not working after daemon restart (with workaround)
Message-ID: <20191110213953.GX30475@aurel32.net>
References: <20191110200848.GA28864@aurel32.net>
 <a843f597a101bf6e74521d033b7af3ff19455adc.camel@ewol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a843f597a101bf6e74521d033b7af3ff19455adc.camel@ewol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 2019-11-10 13:59, Steve Brown wrote:
> On Sun, 2019-11-10 at 21:08 +0100, Aurelien Jarno wrote:
> > Hi all,
> > 
> > On my system (Raspberry PI 3), the RX path doesn't work anymore
> > following a restart of the bluetooth-meshd daemon. I have tracked
> > down
> > that to the fact that the receive callbacks are setup before the HCI
> > is
> > fully initialized. Said otherwise, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS
> > is
> > called before BT_HCI_CMD_RESET and the callback calling
> > BT_HCI_CMD_LE_SET_SCAN_ENABLE is not called. This timing dependent
> > and
> > probably not reproducible on all hardware.
> > 
> > I have workarounded the issue by adding a small delay between the HCI
> > initialization and the call to node_attach_io_all():
> > 
> > diff --git a/mesh/mesh.c b/mesh/mesh.c
> > index 9b2b2073b..1c06060f9 100644
> > --- a/mesh/mesh.c
> > +++ b/mesh/mesh.c
> > @@ -167,6 +167,10 @@ bool mesh_init(const char *config_dir, enum
> > mesh_io_type type, void *opts)
> >  	mesh_io_get_caps(mesh.io, &caps);
> >  	mesh.max_filters = caps.max_num_filters;
> >  
> > +	for (int i = 0 ; i < 100 ; i++) {
> > +		l_main_iterate(10);
> > +	}
> > +
> >  	node_attach_io_all(mesh.io);
> >  
> >  	return true;
> > 
> > I guess there is a better way to do that by waiting for the HCI to be
> > fully initialized before calling node_attach_io_all() or by using a
> > callback instead. However I do not know the codebase good enough to
> > fix
> > that properly.
> > 
> > Aurelien
> > 
> I've experienced something similar on my rpi3. I found that on restart,
> discover-unprovisioned stopped working.

In my case I also observe the same.

> In my case, it appears that meshd assumes that if there are existing
> nodes, scanning has been enabled. Thus, calls from mesh-cfgclient to
> discover additional unprovisioned nodes do not need another hci scan
> enable at mesh/mesh-io-generic.c:736.
> 
> If meshd is restarted with preexisting nodes, scanning is still assumed
> to already be enabled, but it's not. This breaks discover-unprovisioned 
> for me.

Yes, I think this is exactly my problem. If there are existing nodes,
recv_register is called before the HCI is configured and pvt->rx_regs is
filled at mesh/mesh-io-generic.c:738. This means that later scanning is
assumed to be enabled. However the call to bt_hci_send with
BT_HCI_CMD_LE_SET_SCAN_PARAMETERS fails as the HCI is not yet
initialized and the callback set_recv_scan_enable() supposed to enable
scanning is not called.

So when loading a node, scanning is assumed to be enabled, but it is
not practice.

I believe my workaround should work on your system (maybe after
adjusting the number of iterations of the loop).

Aurelien
 
-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
