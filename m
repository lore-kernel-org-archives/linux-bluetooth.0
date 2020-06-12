Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9C8206A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591967526;
	bh=2SniKmem3t1PrBIuVvTwYSgKON/luF2t8OGhKL43Fz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T0E+VpYY+BV8LdDULYANNPPHJ+akfQpAi90KTccElJVHaSPgcUTFWxN4YOzJ70sZF
	 jMVpfKDuPy2ArEASrtviIl0aUQEvTiwv4enxFRD2T9Vqnuzm3uCCA49FXk10CtyC0y
	 gKDX0MZXnBZ4jQCjv+IHCb5xJkNY89gJpJmZ/RPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFLNMG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgFLNMF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 09:12:05 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FA7206A4;
        Fri, 12 Jun 2020 13:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591967525;
        bh=2SniKmem3t1PrBIuVvTwYSgKON/luF2t8OGhKL43Fz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vqfKmkdfwjU7sZ43eyiHPfbOjR3KuRicwpvl7u/QsMMmf4dYJ7Qpfr8JvhWFvTRDc
         QFHfKVKtFJ9eTNakYRGSb2rFuR4OXMhTvll5WbcdWdi6h/f56Ku0jy7o/yqB06qT54
         Mb9KSWqsEooCCAwImXcKN1W1Yz/vbR5p5Ibzk2mQ=
Received: by pali.im (Postfix)
        id 56835582; Fri, 12 Jun 2020 15:12:03 +0200 (CEST)
Date:   Fri, 12 Jun 2020 15:12:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH] btio: Fix registering Object Push, File Transfer and
 other L2CAP profiles
Message-ID: <20200612131203.xip2kaoyeoh4osuj@pali>
References: <20200604231541.4170-1-pali@kernel.org>
 <CABBYNZ+3QO8C_h15=6AgVYSY=Ki-eq=Mg2_mv_cp7QjkTHVpuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+3QO8C_h15=6AgVYSY=Ki-eq=Mg2_mv_cp7QjkTHVpuw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 05 June 2020 00:11:54 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Thu, Jun 4, 2020 at 4:18 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > When bluetoothd daemon is starting, it prints following error messages:
> >
> > bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Message Notification: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> > bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Message Access: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> > bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Phone Book Access: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> > bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for File Transfer: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> > bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Object Push: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> >
> > Result is that Object Push and File Transfer profiles do not work at all.
> >
> > Debugging set_l2opts() function showed me that src/profile.c calls it with
> > L2CAP mode 0x01 (L2CAP_MODE_RETRANS). But kernel bluetooth code in function
> > l2cap_sock_setsockopt_old() for L2CAP_OPTIONS option disallows to set L2CAP
> > method to 0x01 (L2CAP_MODE_RETRANS) and just returns -EINVAL (22).
> >
> > These bluetooth profiles have in src/profile.c file defined L2CAP mode to
> > BT_IO_MODE_ERTM and not to RETRANS. So it means that BT_IO_MODE_ERTM value
> > defined in 'enum BtIOMode' must be incorrect.
> >
> > Digging into git history, it appears that 'enum BtIOMode' was broken in
> > commit f2418bf97d ("btio: Add mode to for Enhanced Credit Mode") which
> > basically broke all those Object Push, File Transfer, Phone Book Access,
> > Message Access and Message Notification L2CAP profiles. That commit removed
> > some values from 'enum BtIOMode' and therefore broke all bluetooth code
> > which uses 'enum BtIOMode' for communication with kernel.
> >
> > This patch fixes 'enum BtIOMode' by reverting back BT_IO_MODE_RETRANS and
> > BT_IO_MODE_FLOWCTL modes, so BT_IO_MODE_ERTM has again correct value 0x03.
> >
> > After applying this patch, Object Push and File Transfer profiles work
> > again.
> >
> > Fixes: f2418bf97d ("btio: Add mode to for Enhanced Credit Mode")
> > ---
> >
> > Hello Luiz, could you please review this patch? As that problematic commit
> > f2418bf97d was introduced by you.
> >
> > I'm curious why nobody else reported this issue about broken Object Push
> > and File Transfer profile as it should print those error messages... Or
> > maybe error message is visible only in debug build and nobody is using
> > Bluetooth File Transfer anymore?
> 
> Looks like you are right but, see bellow.
> 
> > ---
> >  btio/btio.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/btio/btio.h b/btio/btio.h
> > index 23e0ef72b..0d183e3ce 100644
> > --- a/btio/btio.h
> > +++ b/btio/btio.h
> > @@ -68,6 +68,8 @@ typedef enum {
> >
> >  typedef enum {
> >         BT_IO_MODE_BASIC = 0,
> > +       BT_IO_MODE_RETRANS,
> > +       BT_IO_MODE_FLOWCTL,
> >         BT_IO_MODE_ERTM,
> >         BT_IO_MODE_STREAMING,
> >         BT_IO_MODE_LE_FLOWCTL,
> > --
> > 2.20.1
> 
> These modes were never supported by the kernel thus why Ive dropped
> them, so might want to translate them to the old L2CAP modes when
> set_l2opts is called.

Hello Luiz! In commit 81629d982c672e4b3288c4499f9912f60f7040e9 ("btio:
Fix not translation mode to L2CAP mode") you have introduced following
code:

+		l2o.mode = mode_l2mode(mode);
+		if (l2o.mode == UINT8_MAX) {
+			ERROR_FAILED(err, "Unsupported mode", errno);
+			return FALSE;
+		}

But function mode_l2mode() does not set errno when it fails. Therefore
it reports bogus error number (probably zero).

So probably you want to use EINVAL (or some other constant):

+			ERROR_FAILED(err, "Unsupported mode", EINVAL);
