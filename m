Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A84FC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C56320823
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547806890;
	bh=5jhxpjRb0OpBqQv0JLCh4dbunGip/g1WdfQmydA+Pe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MU/JDvzaMgU5+m6CKN9ptnioM9ZKh+h2xMH96WCceeF/PaZeWwkAv1U41h60LH1NP
	 5JnJLuh7GqUoSAxv9tbydjUmF+cCaxj8McQ0FzTqeNU24g+YWj+C9uYOfe+JWReKbU
	 wuuR2O9fkrl6dVu/8tRHsx8Hrbc9Th4yUQQAkKOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfARKV1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfARKV1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 05:21:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB8220823;
        Fri, 18 Jan 2019 10:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547806886;
        bh=5jhxpjRb0OpBqQv0JLCh4dbunGip/g1WdfQmydA+Pe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwzOWF6JoX8vNQr532Py9nAzRTHHMadOvRHNp7Gl/K7KT5K1UxRUK1rBKcslF7yPO
         RwhBlu/7K/Sy9r8fAf/KZDwACuF+m9ASnLcUJfHu4o6/mzXEt01s+i+o2ltFEdSwqk
         YbvELA4VWIEbO0W0XcJubO2l3HH76cv53tU1B9yE=
Date:   Fri, 18 Jan 2019 11:21:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        Ran Menscher <ran.menscher@karambasecurity.com>
Subject: Re: [PATCH 2/2] Bluetooth: check the buffer size for some messages
 before parsing
Message-ID: <20190118102123.GB20179@kroah.com>
References: <20190110062833.GA15047@kroah.com>
 <20190110062917.GB15047@kroah.com>
 <39E6B251-4ED3-4C0F-B8A2-0FAAF6E905A6@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39E6B251-4ED3-4C0F-B8A2-0FAAF6E905A6@holtmann.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 18, 2019 at 10:37:25AM +0100, Marcel Holtmann wrote:
> Hi Greg,
> 
> > The L2CAP_CONF_EFS and L2CAP_CONF_RFC messages can be sent from
> > userspace so their structure sizes need to be checked before parsing
> > them.
> 
> this message is confusing me. How can these be send from userspace?

So claimed the original reporter.  You have the information in your
inbox, is it incorrect?

> > 
> > Based on a patch from Ran Menscher.
> > 
> > Reported-by: Ran Menscher <ran.menscher@karambasecurity.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > net/bluetooth/l2cap_core.c | 12 ++++++++----
> > 1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 93daf94565cf..55e48e6efc2b 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3361,7 +3361,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> > 			break;
> > 
> > 		case L2CAP_CONF_RFC:
> > -			if (olen == sizeof(rfc))
> > +			if ((olen == sizeof(rfc)) &&
> > +			    (endptr - ptr >= L2CAP_CONF_OPT_SIZE + sizeof(rfc)))
> > 				memcpy(&rfc, (void *) val, olen);
> 
> We don’t do ((x == y) && (..)) actually. Using (x == y && ..) is plenty.

Ick, ok, whatever, you all trust that your brains can remember C
priority levels, me, I trust ()...

I can fix this up to remove the extra (), but I would like _SOMEONE_ to
at least validate that this resolves the reported issues...

thanks,

greg k-h
