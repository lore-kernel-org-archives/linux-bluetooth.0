Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A173AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 07:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E3D20759
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 07:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEUHCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 03:02:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57248 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgEUHCK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 03:02:10 -0400
Received: from [192.168.1.91] (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id ECFD7CED11;
        Thu, 21 May 2020 09:11:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] device: Add device type property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOxioN=zqg59Kmc4rSEaceDuHd9PnS1-iHLkdN2DrUF_y=-40Q@mail.gmail.com>
Date:   Thu, 21 May 2020 09:01:39 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Eric Caruso <ejcaruso@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <EB4FAB97-6425-419D-89B8-D31A7D553BB8@holtmann.org>
References: <20200401221320.12105-1-sonnysasaka@chromium.org>
 <6A574E50-BBF3-4967-9C93-6F4B6DAFB47D@holtmann.org>
 <CAO271m=Rqq7QS6R362xLQWjbo6_ZLYPo-ttvevJmjqJ73HbAVQ@mail.gmail.com>
 <68C2E4A8-29E0-44D8-9D2F-F4E2354DE419@holtmann.org>
 <CAOxioNkw8g90tVwQjqgdpX38__f17JHHTTsqBZwCjEkjME0Zyg@mail.gmail.com>
 <6C21A2C1-6224-4FB6-B483-27B1C89864BE@holtmann.org>
 <CAOxioN=zqg59Kmc4rSEaceDuHd9PnS1-iHLkdN2DrUF_y=-40Q@mail.gmail.com>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> I am okay with Types = ["le", "bredr"]. However, I don't understand
> why a user should be able to change the Type, since this property
> describes the fact about a peer device, not a local adapter. What does
> it mean by a user changing the type of a peer device? Also, I don't
> understand why HS needs to be considered in that property, since I see
> org.bluez.Device1 objects as discovered devices either through Inquiry
> (in which case it'd be "bredr") or Advertisement (in which case it'd
> be "le"), or both. HS seems to be one of remote features rather than a
> type. Also the HS information is also not readily available in the
> struct btd_device, or even src/device.c, which suggests that it has
> been treated differently.

you are correct. I was thinking about the local role. My bad.

Regards

Marcel

