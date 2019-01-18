Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51D4C43612
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 13:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5852086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 13:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfARNKp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:10:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47789 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfARNKm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 08:10:42 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id BE1ADCF2C5;
        Fri, 18 Jan 2019 14:18:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: Check L2CAP option sizes returned from
 l2cap_get_conf_opt
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190118121931.GA4793@kroah.com>
Date:   Fri, 18 Jan 2019 14:10:41 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BA6F57B6-A70D-46C2-A1F9-0727E3BE7304@holtmann.org>
References: <20190118115620.7562-1-marcel@holtmann.org>
 <20190118121931.GA4793@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Greg,

>> When doing option parsing for standard type values of 1, 2 or 4 octets,
>> the value is converted directly into a variable instead of a pointer. To
>> avoid being tricked into being a pointer, check that for these option
>> types that sizes actually match. In L2CAP every option is fixed size and
>> thus it is prudent anyway to ensure that the remote side sends us the
>> right option size along with option paramters.
>> 
>> If the option size is not matching the option type, then that option is
>> silently ignored. It is a protocol violation and instead of trying to
>> give the remote attacker any further hints just pretend that option is
>> not present and proceed with the default values. Implementation
>> following the specification and its qualification procedures will always
>> use the correct size and thus not being impacted here.
>> 
>> To keep the code readable and consistent accross all options, a few
>> cosmetic changes were also required.
> 
> Ah, that's a much nicer patch than mine, I like it.  As long as the code
> for handling things when an option is not set properly works ok (which
> I'm guessing it is as that would have been found out long ago), this
> makes everything much simpler.

we treat it as the option would not be present and that is allowed since Bluetooth 1.0b and works just fine.

Regards

Marcel

