Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4881EC47257
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3C0208E4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgEFQod convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 12:44:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56848 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgEFQod (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 12:44:33 -0400
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 146FACED08;
        Wed,  6 May 2020 18:54:13 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] build: Add option to disable battery profile
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZK2SwcOO0jdpvtcdyjHFzw=WNocRU-a37hRsK3=yJ+d3Q@mail.gmail.com>
Date:   Wed, 6 May 2020 18:44:31 +0200
Cc:     Bastien Nocera <hadess@hadess.net>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B3B212AD-28EF-4A18-BA4C-D05765B36BAA@holtmann.org>
References: <20200501215352.23858-1-sonnysasaka@chromium.org>
 <4A9E7F0B-4AB8-4330-BB2B-1A0EAA4EFDE8@holtmann.org>
 <a4650a5e465c23915d951b296ca86de9f2d91b44.camel@hadess.net>
 <CABBYNZK2SwcOO0jdpvtcdyjHFzw=WNocRU-a37hRsK3=yJ+d3Q@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> I have a little bit concern splitting this since battery service and
>>> HoG are kinda connected. Wouldn’t it be better we have a cleaner
>>> interface. Maybe we should actually integrate cleanly with
>>> /dev/upower or similar.
>> 
>> Wat?
> 
> I guess Marcel was refering to something like uhid though Im not sure
> that exists, or does it? That said one alternative would make uhid
> integrate the battery status, but I guess devices can also expose this
> over hid directly so I wonder if we can translate the Battery Service
> status to hid power strength that way we don't need any communication
> over D-Bus.

I thought we had created a /dev/upower to create battery information. Maybe it was just /dev/uleds and the other one was left up in the air.

Regards

Marcel

