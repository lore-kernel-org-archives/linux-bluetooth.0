Return-Path: <SRS0=P4FJ=4D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A93C7114D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Feb 2020 18:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002702083B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Feb 2020 18:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="LKxUN/hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgBOS1I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Feb 2020 13:27:08 -0500
Received: from hoster906.com ([192.252.156.27]:51986 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgBOS1I (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Feb 2020 13:27:08 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Feb 2020 13:27:07 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=to:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=dkim; bh=SczR5boP5q313A2eeaqYX6vkL
        Kl8DsseGursjaTbMUY=; b=LKxUN/hi1rjxiXf3yXusz0Tl87+sof6CUW+1vnktH
        R+v1fSTFd/r0JZp/zUSVJSwkKCaH6d3k1wtp9hjDK9sY0+/x6Ui1tcxtLuMHtfD1
        AAY7Y01NiVdLWJ1166zC2FAB3q1F3dI3ovKvuSXtTik6SX8CQmy29yFB9zwqruNY
        MM=
Received: (qmail 15385 invoked by uid 503); 15 Feb 2020 18:20:27 -0000
Received: from unknown (HELO ?192.168.254.100?) (pop-before-smtp@162.39.210.60)
  by hoster906.com with ESMTPA; 15 Feb 2020 18:20:27 -0000
To:     linux-bluetooth@vger.kernel.org
From:   "Michael N. Moran" <mike@mnmoran.org>
Subject: mesh: Send mesh model message to group address
Message-ID: <848c1b0b-83c6-41a3-fc66-1359fa9a72bb@mnmoran.org>
Date:   Sat, 15 Feb 2020 13:20:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm new to the mailing list, so please be patient.

I've been using meshctl to provision/configure a group of 
mesh nodes.

There does not seem to be a mechanism in meshctl to send 
model messages to group addresses or virtual addresses.

As an example, consider the simple OnOff model. I can 
configure the subscription for an OnOff model with a group 
address. However, the meshctl onoff command will not work 
with a group address set for the onoff target.

I have modified the cmd_set() function in onoff-model.c by 
removing the node_find_by_addr(target) check and this works 
fine. Obviously, that only works for the OnOff model. I'd 
happily submit a patch for that model, but that doesn't seem 
to be a very good general solution.

So is meshctl the right (only) tool to use on Linux?
Is there a newer tool that is planned or under development?

regards,
mike
