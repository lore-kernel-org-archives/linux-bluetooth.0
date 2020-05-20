Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 06:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C562065F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 06:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETGuM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 02:50:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41991 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETGuL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 02:50:11 -0400
Received: from [192.168.1.91] (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D95B9CED03;
        Wed, 20 May 2020 08:59:54 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] device: Add device type property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOxioNkw8g90tVwQjqgdpX38__f17JHHTTsqBZwCjEkjME0Zyg@mail.gmail.com>
Date:   Wed, 20 May 2020 08:49:40 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Eric Caruso <ejcaruso@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6C21A2C1-6224-4FB6-B483-27B1C89864BE@holtmann.org>
References: <20200401221320.12105-1-sonnysasaka@chromium.org>
 <6A574E50-BBF3-4967-9C93-6F4B6DAFB47D@holtmann.org>
 <CAO271m=Rqq7QS6R362xLQWjbo6_ZLYPo-ttvevJmjqJ73HbAVQ@mail.gmail.com>
 <68C2E4A8-29E0-44D8-9D2F-F4E2354DE419@holtmann.org>
 <CAOxioNkw8g90tVwQjqgdpX38__f17JHHTTsqBZwCjEkjME0Zyg@mail.gmail.com>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> After giving it more thought, I would like to propose that this
> additional property corresponds with Device Type as defined in Generic
> Access Profile:
> 
> As stated in Bluetooth Core Specification Version 5.2, Vol 3, Part C
> (Generic Access Profile):
> This profile defines three device types based on the supported Core
> Configurations as defined in [Vol 0] Part B, Section 3.1. The device
> types are shown in Table 1.1:
> * BR/EDR
> * LE only
> * BR/EDR/LE
> 
> Therefore, to be as close to the spec as possible, I propose that the
> property be named GAPDeviceType, and the possible values be "br/edr",
> "le-only", "br/edr/le".
> 
> What do you think? Thanks for reviewing this proposal!

maybe we should do SupportedTypes = [“le”, “bredr”, “hs”] since that also maps to what we expose in MGMT. And then add a Types = [ .. ] property with the same values. I don’t like using GAP in property names and repeating Device is also not needed since we are already in the Device interface. In addition I have a reservation with spec naming in this area since it has changed over time and there is a chance it might change again in future specs when new features come along.

If you know the supported types of the hardware and the selected types, you can easily get to the GAP Device Type from the spec if you actually want to show it. If you wanted to, you could make the Types property writeable as well and users could change their device type via D-Bus.

Regards

Marcel

