Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5BEC433E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECD4207BC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594910412;
	bh=ujNWegicnWC2dCz6IXVHu+Nito8lZ9bXxVj1ekSbGOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HhxOHHhvwETdUaS07exneClZbsFCE/h3T3CuDvLLYFdQHCeiyLbYc6/+QBDbeNodE
	 QGwighX6NuvtbDlT6asX8b7M+KQ2/4kZ7rOZPGK+wvekamjOWGqO+vWrg8sE6VIGb9
	 RzM0DWaC+QjQtrLwvvAEf8YBYhq+y5GKzbdYOpuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgGPOkM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgGPOkL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 10:40:11 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83878206F4;
        Thu, 16 Jul 2020 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594910410;
        bh=ujNWegicnWC2dCz6IXVHu+Nito8lZ9bXxVj1ekSbGOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLoncI7YSBYprMk9rNo3VLbjTkx83nzUJtD4g/tPXoelyS0nCOnUoFWCYVYWIojnP
         dBXL0yedre4azI1E8s43qwulZPD2XG1/6AeOB+C3pmtecYqhGAWYCVQUY0R3yhqBq8
         IVDDOAutDNjqBZZVFxJlr8v6a9TviTFpe+6oQOuw=
Received: by pali.im (Postfix)
        id 62016E7A; Thu, 16 Jul 2020 16:40:08 +0200 (CEST)
Date:   Thu, 16 Jul 2020 16:40:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH] sap: Improve error messages
Message-ID: <20200716144008.fcgxcqmqfashnwam@pali>
References: <20200604232433.4951-1-pali@kernel.org>
 <4237143.LvFx2qVVIh@ix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4237143.LvFx2qVVIh@ix>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 15 June 2020 11:48:20 Szymon Janc wrote:
> Hi,
> 
> On Friday, 5 June 2020 01:24:33 CEST Pali Rohár wrote:
> > When bluetoohd daemon is starting, it prints following error messages:
> > 
> > bluetoothd[19117]: profiles/sap/server.c:sap_server_register() Sap driver
> > initialization failed. bluetoothd[19117]: sap-server: Operation not
> > permitted (1)
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
> >  	GIOChannel *io;
> >  	struct sap_server *server;
> > 
> > +	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
> > +		error("Sap driver is disabled without --experimental 
> option");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> 
> Maybe just make sap_init() fail if experimental is not enabled in sap-dummy.c?

I guess this is what is already happening. But failure of sap_init()
means that bluetoothd daemon prints error message that initialization
failed as I wrote in commit message.

Therefore I added another check for experimental flag with printing
different error message which contains information why it failed.

> This driver is usable only for profile qualification tests and nothing more.
> And TBH I'm not sure why distros are enabling SAP in first place...
> 
> >  	if (sap_init() < 0) {
> >  		error("Sap driver initialization failed.");
> > -		return -1;
> > +		return -EOPNOTSUPP;
> >  	}
> > 
> >  	record = create_sap_record(SAP_SERVER_CHANNEL);
> 
> 
> -- 
> pozdrawiam
> Szymon Janc
> 
> 
