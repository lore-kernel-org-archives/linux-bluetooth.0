Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1EFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4EA206A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591967616;
	bh=fBpxUt7Rb+PkHN6rHIz7FZn4p/kBn/nnTDFiCe2UU6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DQHM5eBaZ4nVHSgg146dp1BCpxyz5AEicL09rsQ1UukGIHO+cO0bFEJgX13d+S2TV
	 VK4wGznSRem90Rp98Sfsiaf6RO6LAOyStI8NC2GZRxJjhK3dUnAI0XCiCn0QQRc6LT
	 0+4BrkEVTwmINAJjJWSWGubW3WKsZRjjGCq6EJ7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFLNNg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLNNg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 09:13:36 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60418206A4;
        Fri, 12 Jun 2020 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591967615;
        bh=fBpxUt7Rb+PkHN6rHIz7FZn4p/kBn/nnTDFiCe2UU6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mew7uM/jRd2an3dka8uEPxtVBhsRy7sxxMQj3eqWWQd8qqKZioXbByB77eRpnydXK
         VXPPkyh5ZcaefFBnyOjv0W4rSG0uPx1mDhLRbPKoP3VDN01Hg/ciYkvBPHfxUHEAXK
         m3X5yzkeyjhsX+RAxnP3tIfnFhVY+E0qhnm09+Os=
Received: by pali.im (Postfix)
        id B0ED7582; Fri, 12 Jun 2020 15:13:33 +0200 (CEST)
Date:   Fri, 12 Jun 2020 15:13:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH] sap: Improve error messages
Message-ID: <20200612131333.jrrv3bue7kagyd7k@pali>
References: <20200604232433.4951-1-pali@kernel.org>
 <CABBYNZ+J-4a1Vvk=8VGLkFzVub_P7bwjaskdeW7pXsePzAu58A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+J-4a1Vvk=8VGLkFzVub_P7bwjaskdeW7pXsePzAu58A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 05 June 2020 00:14:12 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Thu, Jun 4, 2020 at 4:27 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > When bluetoohd daemon is starting, it prints following error messages:
> >
> > bluetoothd[19117]: profiles/sap/server.c:sap_server_register() Sap driver initialization failed.
> > bluetoothd[19117]: sap-server: Operation not permitted (1)
> >
> > Initialization is failing because sap server is enabled only when
> > bluetoothd daemon is started with --experimental option.
> >
> > And "Operation not permitted" is result of returning error code -1.
> >
> > This patch improves error messages. When --experimental option is not used
> > then bluetoothd prints more explaining error message. And in case function
> > sap_init() fails then -EOPNOTSUPP "Operation not supported" is returned
> > instead of -EPERM (-1).
> > ---
> >  profiles/sap/server.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/profiles/sap/server.c b/profiles/sap/server.c
> > index 5de682a33..99ff80297 100644
> > --- a/profiles/sap/server.c
> > +++ b/profiles/sap/server.c
> > @@ -1353,9 +1353,14 @@ int sap_server_register(struct btd_adapter *adapter)
> >         GIOChannel *io;
> >         struct sap_server *server;
> >
> > +       if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
> > +               error("Sap driver is disabled without --experimental option");
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> >         if (sap_init() < 0) {
> >                 error("Sap driver initialization failed.");
> > -               return -1;
> > +               return -EOPNOTSUPP;
> >         }
> >
> >         record = create_sap_record(SAP_SERVER_CHANNEL);
> > --
> > 2.20.1
> 
> We might as well introduce a experimental flag for the plugin so it
> just don't load it if experimental flag is disabled.

Probably yet. But returning -1 (-EPERM) should be also fixed.
