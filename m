Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFD9C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 06:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE821738
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 06:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547101763;
	bh=lYWmmcoXXeN1EcA6kRer3NaCPJLc9vJUzQ2qWlTrUNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JXsJmPu/+2k5/44NNKnmUpkiMEVFs0Hp+hua+Aar4nlUsCHczH//iR06ZpIotTxx9
	 PvpYNSmth+ZVjjVuiwS4xHduCQwRrbwqfJYF+JS+Negr14gKGP9Hjcf+G1PFbjSC6E
	 Q+CAoVYPAOSI/Ae+yyAqyFeBfsEuOPAblWP8gf1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfAJG3U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfAJG3U (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 01:29:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922C1206B7;
        Thu, 10 Jan 2019 06:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547101760;
        bh=lYWmmcoXXeN1EcA6kRer3NaCPJLc9vJUzQ2qWlTrUNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDcz399e5lZdcBFZgMor1qdei2nWBzFu0b4Da2b381H88DmvZd7UkOTk1YeJBssDC
         exef7bwMji2LFTeHzg91VirbxKTWap9E9nwkeaqpF3JI0r0ZuycNtc9A5MkKlLgYo/
         0TI/AjNOc6gAve2y20jSFY0Q+PbRaLxSkkWaGMXU=
Date:   Thu, 10 Jan 2019 07:29:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        Ran Menscher <ran.menscher@karambasecurity.com>
Subject: [PATCH 2/2] Bluetooth: check the buffer size for some messages
 before parsing
Message-ID: <20190110062917.GB15047@kroah.com>
References: <20190110062833.GA15047@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110062833.GA15047@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The L2CAP_CONF_EFS and L2CAP_CONF_RFC messages can be sent from
userspace so their structure sizes need to be checked before parsing
them.

Based on a patch from Ran Menscher.

Reported-by: Ran Menscher <ran.menscher@karambasecurity.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/l2cap_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 93daf94565cf..55e48e6efc2b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3361,7 +3361,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;
 
 		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
+			if ((olen == sizeof(rfc)) &&
+			    (endptr - ptr >= L2CAP_CONF_OPT_SIZE + sizeof(rfc)))
 				memcpy(&rfc, (void *) val, olen);
 			break;
 
@@ -3371,7 +3372,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;
 
 		case L2CAP_CONF_EFS:
-			if (olen == sizeof(efs)) {
+			if ((olen == sizeof(efs)) &&
+			    (endptr - ptr >= L2CAP_CONF_OPT_SIZE + sizeof(efs))) {
 				remote_efs = 1;
 				memcpy(&efs, (void *) val, olen);
 			}
@@ -3576,7 +3578,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			break;
 
 		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
+			if ((olen == sizeof(rfc)) &&
+			    (endptr - ptr >= L2CAP_CONF_OPT_SIZE + sizeof(rfc)))
 				memcpy(&rfc, (void *)val, olen);
 
 			if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state) &&
@@ -3596,7 +3599,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			break;
 
 		case L2CAP_CONF_EFS:
-			if (olen == sizeof(efs)) {
+			if ((olen == sizeof(efs)) &&
+			    (endptr - ptr >= L2CAP_CONF_OPT_SIZE + sizeof(efs))) {
 				memcpy(&efs, (void *)val, olen);
 
 				if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
-- 
2.20.1

