Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353D6C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 06:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066262173B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 06:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547101720;
	bh=IbBAP5tQr/AKDsuD+OPBlhsO0wVsjH1xEzAmmbFRLRE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0yeJvX5IwvZ1ktrPnzziEwHr9R0ZrZ6Q+hQtzVoZh7C0JVxWXUONICrrO6k0x+RwQ
	 O8o76dpwmFz+gI0pUyqymBAyi1+93ZvP44ZBZFlrBGRVZb6YrOsvMoZmIbT95o7mji
	 gMIUtQwSOkHQ11qVNRaH3XpkoT6M7/EdUraLClIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfAJG2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfAJG2h (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 01:28:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 088CA206B7;
        Thu, 10 Jan 2019 06:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547101715;
        bh=IbBAP5tQr/AKDsuD+OPBlhsO0wVsjH1xEzAmmbFRLRE=;
        h=Date:From:To:Cc:Subject:From;
        b=s/yNM6nTtDaF0EAfi4cN8E410WWe6mf3MQJXTAUh2RppmJ4qF512GFdd+s8NuNEzT
         GiuqP+BhyZm7+m9YKXZZn9B/bMTiiGx9XJ4YKW4XGdMnzt1rbHcl2xJqVwr3LpvjRi
         2k2h8g1gBUFOtXq2aNni0dsTcmIV/eueBvM3RiFw=
Date:   Thu, 10 Jan 2019 07:28:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: check message types in l2cap_get_conf_opt
Message-ID: <20190110062833.GA15047@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

l2cap_get_conf_opt can handle a "default" message type, but it needs to
be verified that it really is the correct type (CONF_EFS or CONF_RFC)
before passing it back to the caller.  To do this we need to check the
return value of this call now and handle the error correctly up the
stack.

Based on a patch from Ran Menscher.

Reported-by: Ran Menscher <ran.menscher@karambasecurity.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/l2cap_core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2a7fb517d460..93daf94565cf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2980,6 +2980,10 @@ static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
 		break;
 
 	default:
+		/* Only CONF_EFS and CONF_RFC are allowed here */
+		if ((opt->type != L2CAP_CONF_EFS) &&
+		    (opt->type != L2CAP_CONF_RFC))
+			return -EPROTO;
 		*val = (unsigned long) opt->val;
 		break;
 	}
@@ -3324,7 +3328,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	void *endptr = data + data_size;
 	void *req = chan->conf_req;
 	int len = chan->conf_len;
-	int type, hint, olen;
+	int type, hint, olen, err;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
@@ -3336,7 +3340,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	BT_DBG("chan %p", chan);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
+		err = l2cap_get_conf_opt(&req, &type, &olen, &val);
+		if (err < 0)
+			return err;
+		len -= err;
 
 		hint  = type & L2CAP_CONF_HINT;
 		type &= L2CAP_CONF_MASK;
@@ -3539,7 +3546,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	struct l2cap_conf_req *req = data;
 	void *ptr = req->data;
 	void *endptr = data + size;
-	int type, olen;
+	int type, olen, err;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
@@ -3547,7 +3554,10 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		err = l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		if (err < 0)
+			return err;
+		len -= err;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -3707,7 +3717,7 @@ void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
 
 static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 {
-	int type, olen;
+	int type, olen, err;
 	unsigned long val;
 	/* Use sane default values in case a misbehaving remote device
 	 * did not send an RFC or extended window size option.
@@ -3727,7 +3737,10 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		return;
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		err = l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		if (err < 0)
+			return;
+		len -= err;
 
 		switch (type) {
 		case L2CAP_CONF_RFC:
-- 
2.20.1

