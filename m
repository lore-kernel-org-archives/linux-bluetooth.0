Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1307C04AAA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FE12087F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 09:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFJA2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 05:00:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57317 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfEFJA2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 05:00:28 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1DC85CEE9A;
        Mon,  6 May 2019 11:08:41 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] v7 Add support for LE ping feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6AFF54953E047B42BC60A96154D42C5CD16F45@BGSMSX101.gar.corp.intel.com>
Date:   Mon, 6 May 2019 11:00:26 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <09C2920E-805F-4DB2-8C2D-C338650604AD@holtmann.org>
References: <1556597465-21783-1-git-send-email-spoorthix.k@intel.com>
 <E76A1D30-87DF-4A83-B9AD-C7DCC193EB6C@holtmann.org>
 <6AFF54953E047B42BC60A96154D42C5CD16F45@BGSMSX101.gar.corp.intel.com>
To:     "K, SpoorthiX" <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

> 	Thanks for your valuable comments.
> 	I have removed the extra lines wherever mentioned in my latest patch sent few minutes back.
> 	But I clearly did not understand the comment 
> 	---> On hci_conn creation the hcon->auth_payload_time needs to be set to DEFAULT_AUTH_PAYLOAD_TIMEOUT as well.
> 	Could you please explain why this needs to be set after connection as it is sent as a command parameter  "hdev->auth_payload_timeout" is nothing but “DEFAULT_AUTH_PAYLOAD_TIMEOUT"

when you initialize the hci_conn structure you have to fill it with the correct default values. The auth payload is not 0x0000 in this case since the controller will already have one that it uses as default. The specification clearly states that Authenticated_Payload_Timeout Default = 0x0BB8 (30 s). This means that one encryption has been activated the LE Ping procedure is active with the default 30s no matter if you send the HCI Write Authenticated Payload Timeout command or not.

Regards

Marcel

