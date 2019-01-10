Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5E3C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 21:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B747A213F2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 21:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfAJVKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:10:19 -0500
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:60604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727846AbfAJVKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 16:10:18 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 16:10:17 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id AD11D18075DCB
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 21:02:14 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 760481807660E;
        Thu, 10 Jan 2019 21:02:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rice03_1320f539e6347
X-Filterd-Recvd-Size: 3902
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Jan 2019 21:02:11 +0000 (UTC)
Message-ID: <8616937378cec9330c27a3b08c24ab15ebb42ecf.camel@perches.com>
Subject: Re: [PATCH 1/2] Bluetooth: check message types in l2cap_get_conf_opt
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Date:   Thu, 10 Jan 2019 13:02:09 -0800
In-Reply-To: <20190110062833.GA15047@kroah.com>
References: <20190110062833.GA15047@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2019-01-10 at 07:28 +0100, Greg Kroah-Hartman wrote:
> l2cap_get_conf_opt can handle a "default" message type, but it needs to
> be verified that it really is the correct type (CONF_EFS or CONF_RFC)
> before passing it back to the caller.  To do this we need to check the
> return value of this call now and handle the error correctly up the
> stack.
[]
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
[]
> @@ -3324,7 +3328,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>  	void *endptr = data + data_size;
>  	void *req = chan->conf_req;
>  	int len = chan->conf_len;
> -	int type, hint, olen;
> +	int type, hint, olen, err;

err doesn't seem the right name for any of these as the
return is now negative only when there is an error.

Maybe opt_len instead.

>  	unsigned long val;
>  	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
>  	struct l2cap_conf_efs efs;
> @@ -3336,7 +3340,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>  	BT_DBG("chan %p", chan);
>  
>  	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
> +		err = l2cap_get_conf_opt(&req, &type, &olen, &val);
> +		if (err < 0)
> +			return err;
> +		len -= err;

especially as you subtract the positive return not
an error value.

>  
>  		hint  = type & L2CAP_CONF_HINT;
>  		type &= L2CAP_CONF_MASK;
> @@ -3539,7 +3546,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
>  	struct l2cap_conf_req *req = data;
>  	void *ptr = req->data;
>  	void *endptr = data + size;
> -	int type, olen;
> +	int type, olen, err;
>  	unsigned long val;
>  	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
>  	struct l2cap_conf_efs efs;
> @@ -3547,7 +3554,10 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
>  	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
>  
>  	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> +		err = l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> +		if (err < 0)
> +			return err;
> +		len -= err;
>  
>  		switch (type) {
>  		case L2CAP_CONF_MTU:
> @@ -3707,7 +3717,7 @@ void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
>  
>  static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
>  {
> -	int type, olen;
> +	int type, olen, err;
>  	unsigned long val;
>  	/* Use sane default values in case a misbehaving remote device
>  	 * did not send an RFC or extended window size option.
> @@ -3727,7 +3737,10 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
>  		return;
>  
>  	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> +		err = l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> +		if (err < 0)
> +			return;
> +		len -= err;
>  
>  		switch (type) {
>  		case L2CAP_CONF_RFC:

