Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C870AC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 05:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D7820870
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 05:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547184750;
	bh=R1EsEh842il6A8FDQcPwpUpbpasEfVxm5rxXur9h5C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X0I1xc4HTB1SvIWdYUE4XJbR7EyhMlRlx7xpjcMWu1r0Ht+VHWFOoR5hC3nNYwojF
	 fZBv8CKbDchMz+6RcUoO0Du0Z6xwF+tBGXnKQKVWUVapJaLVdqagumOVcn9f4BvfdF
	 +1WoMmX98tXp3qijJzommfZn7PFrjE5pct6qrQm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfAKFc2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfAKFc2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 00:32:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC0220870;
        Fri, 11 Jan 2019 05:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547184747;
        bh=R1EsEh842il6A8FDQcPwpUpbpasEfVxm5rxXur9h5C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhCnhVg4fzB69N1GVnFese/1fDYSghIyERYe1UZOo6MNuEWUa7qmD4On5VA22lJGG
         91kjVTXbJ1Wa1ct4MlvL31ry9BSP9BkQLc1aEpU5OAVYWr5/AlG40KKj0iNHWhix7E
         jTK+zIk3oHLRvimbmLI+IIx9R3f3mfn6h9VCbhYA=
Date:   Fri, 11 Jan 2019 06:32:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: check message types in l2cap_get_conf_opt
Message-ID: <20190111053223.GA24338@kroah.com>
References: <20190110062833.GA15047@kroah.com>
 <8616937378cec9330c27a3b08c24ab15ebb42ecf.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8616937378cec9330c27a3b08c24ab15ebb42ecf.camel@perches.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jan 10, 2019 at 01:02:09PM -0800, Joe Perches wrote:
> On Thu, 2019-01-10 at 07:28 +0100, Greg Kroah-Hartman wrote:
> > l2cap_get_conf_opt can handle a "default" message type, but it needs to
> > be verified that it really is the correct type (CONF_EFS or CONF_RFC)
> > before passing it back to the caller.  To do this we need to check the
> > return value of this call now and handle the error correctly up the
> > stack.
> []
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> []
> > @@ -3324,7 +3328,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> >  	void *endptr = data + data_size;
> >  	void *req = chan->conf_req;
> >  	int len = chan->conf_len;
> > -	int type, hint, olen;
> > +	int type, hint, olen, err;
> 
> err doesn't seem the right name for any of these as the
> return is now negative only when there is an error.
> 
> Maybe opt_len instead.

I was copying the style that was used in the rest of the file.  If the
maintainers want me to use a different name, I'll be glad to do so.  My
personal preference is just 'ret'.

> >  	unsigned long val;
> >  	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> >  	struct l2cap_conf_efs efs;
> > @@ -3336,7 +3340,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> >  	BT_DBG("chan %p", chan);
> >  
> >  	while (len >= L2CAP_CONF_OPT_SIZE) {
> > -		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
> > +		err = l2cap_get_conf_opt(&req, &type, &olen, &val);
> > +		if (err < 0)
> > +			return err;
> > +		len -= err;
> 
> especially as you subtract the positive return not
> an error value.

True, 'ret' would be nicer, but again, I was trying to follow the file's
style.

thanks,

greg k-h
