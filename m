Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7DBC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A96B20823
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547806794;
	bh=1K2oPG0BNUyuwiLD3OSyY20dNzbqxmELiFdn8hmkQUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F711FR0J2fAgAMyKmxjs5vlQtjQWDfVTwniChJYVprV9uKvPOJY7Ze0etFRd3FYV1
	 InxkQXnm1QiTDJTtBBGR6a02XmmyX9QtTc5Gy+ba7Nny64+SW8mIWp1Ztxyypw0bb1
	 nIF52aymL/SeaaZswMaJQ9scRocAWcuSPc0779/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfARKTv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfARKTv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 05:19:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9985B20823;
        Fri, 18 Jan 2019 10:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547806790;
        bh=1K2oPG0BNUyuwiLD3OSyY20dNzbqxmELiFdn8hmkQUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7fR34IagHLYTk9rGIQoyjfz2+RhjMbZ4KW5LTbD4M5yfJctoZsIuwNmBuzkwgX3u
         V7E84KV7qDdKGoJ+Q10w47NPc4/GcY4WKJG+w7QrXDpMH9vHxXRt0EnJv1UuoIJEds
         6WjOQItyi+HIzUKxDZjmuTUVNHnUraq+B3MIjg3s=
Date:   Fri, 18 Jan 2019 11:19:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: check message types in l2cap_get_conf_opt
Message-ID: <20190118101947.GA20179@kroah.com>
References: <20190110062833.GA15047@kroah.com>
 <E3A13BCC-C138-4E76-A379-A32CBB9AFF26@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E3A13BCC-C138-4E76-A379-A32CBB9AFF26@holtmann.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 18, 2019 at 10:35:30AM +0100, Marcel Holtmann wrote:
> Hi Greg,
> 
> > l2cap_get_conf_opt can handle a "default" message type, but it needs to
> > be verified that it really is the correct type (CONF_EFS or CONF_RFC)
> > before passing it back to the caller.  To do this we need to check the
> > return value of this call now and handle the error correctly up the
> > stack.
> > 
> > Based on a patch from Ran Menscher.
> > 
> > Reported-by: Ran Menscher <ran.menscher@karambasecurity.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > net/bluetooth/l2cap_core.c | 25 +++++++++++++++++++------
> > 1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 2a7fb517d460..93daf94565cf 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -2980,6 +2980,10 @@ static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
> > 		break;
> > 
> > 	default:
> > +		/* Only CONF_EFS and CONF_RFC are allowed here */
> > +		if ((opt->type != L2CAP_CONF_EFS) &&
> > +		    (opt->type != L2CAP_CONF_RFC))
> > +			return -EPROTO;
> 
> after re-reading that specification, this also includes CONF_QOS since that is a multi-field variable as well. Even if we currently don’t act on that field, we need to accept it being send.

/me hands you some \n characters...

Ok, will fix up.

> > 		*val = (unsigned long) opt->val;
> > 		break;
> > 	}
> > @@ -3324,7 +3328,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> > 	void *endptr = data + data_size;
> > 	void *req = chan->conf_req;
> > 	int len = chan->conf_len;
> > -	int type, hint, olen;
> > +	int type, hint, olen, err;
> > 	unsigned long val;
> > 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> > 	struct l2cap_conf_efs efs;
> > @@ -3336,7 +3340,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> > 	BT_DBG("chan %p", chan);
> > 
> > 	while (len >= L2CAP_CONF_OPT_SIZE) {
> > -		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
> > +		err = l2cap_get_conf_opt(&req, &type, &olen, &val);
> > +		if (err < 0)
> > +			return err;
> > +		len -= err;
> 
> We need to handle not yet known options correctly since otherwise we are breaking forwards compatibility if newer specifications introduce new parameters. So just returning with an error here is not acceptable. It will fail qualification test cases.

So what should we do here?  We can't keep going as the size is
incorrect.

> Don’t we rather have proper length checks in l2cap_parse_conf_{req,rsp} instead of doing this. I think your second patch is enough.

It is?  Ok, if that's all that is needed, that's fine with me.  I was
just taking the patch from the original submitter, I don't understand
the bluetooth protocol at all :)

thanks,

greg k-h
