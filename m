Return-Path: <SRS0=MLMp=NW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930F0C43441
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Nov 2018 10:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE8420854
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Nov 2018 10:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE8420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeKKTzR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Nov 2018 14:55:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55379 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeKKTzR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Nov 2018 14:55:17 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id DB918CF359;
        Sun, 11 Nov 2018 11:14:37 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ] doc: Initial Bluetooth Mesh API
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c2485caca3145e8aaaa1a8396b294b46a55b97e3.camel@intel.com>
Date:   Sun, 11 Nov 2018 11:07:08 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Brian Gix <brian.gix@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DFAA7E3E-A9CB-40DD-A959-FA23DE8B41F5@holtmann.org>
References: <20181107004950.9153-1-inga.stotland@intel.com>
 <4DBB63ED-41C4-4F27-B2BC-1ADB090B1656@gmail.com>
 <c2485caca3145e8aaaa1a8396b294b46a55b97e3.camel@intel.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

>> At first glance this looks quite good to me, just some cosmetic
>> comments:
>> 
>>> On 7 Nov 2018, at 2.49, Inga Stotland <inga.stotland@intel.com>
>>> wrote:
>>> +Service	org.bluez.mesh1
>> 
>> I don’t think we’ve had the habit of versioning well-known bus names
>> so far. Or did you see this somewhere? So I’d just leave away the
>> version here.
>> 
> 
> From D-Bus Api Design Guidelines: (
> https://dbus.freedesktop.org/doc/dbus-api-design.html#api-versioning):
> 
> "In summary, version numbers should be included in all service names,
> interface names and object paths:
> 
>    com.example.MyService1
> 
>    com.example.MyService1.InterestingInterface
> 
>    com.example.MyService1.OtherInterface
> 
>    /com/example/MyService1/Manager
> 
>    /com/example/MyService1/OtherObject
> "
> 
> I chose to do the name versioning based on the official guidelines.
> However, if we want to preserve the historical bluez approach, I don't
> mind changing it.

so a long time ago, I looked at this and considered it pointless. It a total bloat that serves no practical purpose. Versioning the interface names makes sense since it allows to upgrade an interface and remove method or change its behavior if that would ever be really needed.

Reality is that we will never write a second daemon for version 2 and that is what versioning essentially implies here. Everything is versioned in a manor that service1 and service2 are totally independent. However what is the point in a technology like Bluetooth. 90% of the methods, properties and behaviors will not change. So we are duplicating everything for 10% or less optimization. That just makes no sense.

>>> +			PossibleErrors:
>>> +				org.bluez.mesh1.Error.Failed,
>>> +				org.bluez.mesh1.Error.Canceled,
>>> +				org.bluez.mesh1.Error.InvalidArguments
>>> +				org.bluez.mesh1.Error.Timeout
>> 
>> We’ve never versioned errors either, or did you see this done
>> somewhere? So just leave it out from here.
> 
> So you can see a number of services following the above mentioned D-Bus 
> API Guidelines by running d-feet: e..g., org.freedesktop.GeoClue2 or
> org.freedesktop.UDisks2 or org.fedoraprojectFirewallD1

Blindly following some recommendations is dangerous and that is what is happening here. It is blindly following or the project is implement in a memory eating language like Python in the first place.

Regards

Marcel

