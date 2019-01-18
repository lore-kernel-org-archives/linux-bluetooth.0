Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8ABC43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 09:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FF32086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 09:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfARJfc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:35:32 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58497 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfARJfc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 04:35:32 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id C049BCF2C3;
        Fri, 18 Jan 2019 10:43:16 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/2] Bluetooth: check message types in l2cap_get_conf_opt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190110062833.GA15047@kroah.com>
Date:   Fri, 18 Jan 2019 10:35:30 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E3A13BCC-C138-4E76-A379-A32CBB9AFF26@holtmann.org>
References: <20190110062833.GA15047@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Greg,

> l2cap_get_conf_opt can handle a "default" message type, but it needs to
> be verified that it really is the correct type (CONF_EFS or CONF_RFC)
> before passing it back to the caller.  To do this we need to check the
> return value of this call now and handle the error correctly up the
> stack.
> 
> Based on a patch from Ran Menscher.
> 
> Reported-by: Ran Menscher <ran.menscher@karambasecurity.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> net/bluetooth/l2cap_core.c | 25 +++++++++++++++++++------
> 1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 2a7fb517d460..93daf94565cf 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2980,6 +2980,10 @@ static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
> 		break;
> 
> 	default:
> +		/* Only CONF_EFS and CONF_RFC are allowed here */
> +		if ((opt->type != L2CAP_CONF_EFS) &&
> +		    (opt->type != L2CAP_CONF_RFC))
> +			return -EPROTO;

after re-reading that specification, this also includes CONF_QOS since that is a multi-field variable as well. Even if we currently don’t act on that field, we need to accept it being send.

> 		*val = (unsigned long) opt->val;
> 		break;
> 	}
> @@ -3324,7 +3328,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> 	void *endptr = data + data_size;
> 	void *req = chan->conf_req;
> 	int len = chan->conf_len;
> -	int type, hint, olen;
> +	int type, hint, olen, err;
> 	unsigned long val;
> 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> 	struct l2cap_conf_efs efs;
> @@ -3336,7 +3340,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
> 	BT_DBG("chan %p", chan);
> 
> 	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
> +		err = l2cap_get_conf_opt(&req, &type, &olen, &val);
> +		if (err < 0)
> +			return err;
> +		len -= err;

We need to handle not yet known options correctly since otherwise we are breaking forwards compatibility if newer specifications introduce new parameters. So just returning with an error here is not acceptable. It will fail qualification test cases.

Don’t we rather have proper length checks in l2cap_parse_conf_{req,rsp} instead of doing this. I think your second patch is enough.

> 
> 		hint  = type & L2CAP_CONF_HINT;
> 		type &= L2CAP_CONF_MASK;
> @@ -3539,7 +3546,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
> 	struct l2cap_conf_req *req = data;
> 	void *ptr = req->data;
> 	void *endptr = data + size;
> -	int type, olen;
> +	int type, olen, err;
> 	unsigned long val;
> 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> 	struct l2cap_conf_efs efs;
> @@ -3547,7 +3554,10 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
> 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
> 
> 	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> +		err = l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> +		if (err < 0)
> +			return err;
> +		len -= err;
> 
> 		switch (type) {
> 		case L2CAP_CONF_MTU:
> @@ -3707,7 +3717,7 @@ void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
> 
> static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
> {
> -	int type, olen;
> +	int type, olen, err;
> 	unsigned long val;
> 	/* Use sane default values in case a misbehaving remote device
> 	 * did not send an RFC or extended window size option.
> @@ -3727,7 +3737,10 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
> 		return;
> 
> 	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> +		err = l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> +		if (err < 0)
> +			return;
> +		len -= err;
> 
> 		switch (type) {
> 		case L2CAP_CONF_RFC:

Regards

Marcel

