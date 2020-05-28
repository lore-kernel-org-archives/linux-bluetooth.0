Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DA1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291B5208DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 08:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgE1IWw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 04:22:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47934 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgE1IWw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 04:22:52 -0400
Received: from marcel-macpro.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3EDE8CECB0;
        Thu, 28 May 2020 10:32:37 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/4] Bluetooth: Fix assuming EIR flags can result in SSP
 authentication
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_XztiDRfQEtioALNmO9smLm-qTW56hxkw8-ZH-Aw2cH1g@mail.gmail.com>
Date:   Thu, 28 May 2020 10:22:50 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6F17F57F-8AF4-4539-8564-C3F13BC6FBF5@holtmann.org>
References: <20200519202519.219335-1-luiz.dentz@gmail.com>
 <20200519202519.219335-2-luiz.dentz@gmail.com>
 <C478BA49-0BBF-4323-AC3A-30442F65D346@holtmann.org>
 <CALWDO_UEPaAGyLFG93JzT41P=yGePB-N2Pbh5hioLBOXdh2YBw@mail.gmail.com>
 <23C4DB2B-4C5E-45E7-A777-6F26A675EB92@holtmann.org>
 <CALWDO_XztiDRfQEtioALNmO9smLm-qTW56hxkw8-ZH-Aw2cH1g@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> Starting with the 2.1 specification, it is my interpretation that it
>>> is not valid to support EIR but not SSP.  I understand that SSP may be
>>> disabled from BlueZ's point of view, but this doesn't seem to be a
>>> legitimate/qualifiable configuration.  Should we instead fail the
>>> legacy pairing if EIR was received as an invalid condition?
>> 
>> I know that using EIR requires to also use SSP. However this is just a precaution in case the other device is an attacked and tries to trick us.
>> 
>> You might get an inquiry result and not extended inquiry result, but you are still talking to a SSP device. This has to do with the fact that the reception of EIR is not guaranteed. In case of radio interference you might miss one and only get an ordinary inquiry result.
>> 
>> If we indeed received an EIR and then get legacy pairing request, we could try to reject the pairing. However keep in mind that our inquiry cache is time limited and we through outdated information away. This might cause some race condition. So I rather read the remote host features to ensure we know the actual host features of the remote device.
> 
> You are correct, the EIR response is not a guaranteed thing.  For this
> reason, the host should try to resolve the name of the device before
> initiating bonding where a Remote Host Supported Feature Notification
> Event is generated to signal the remote side's support of SSP.  As you
> allude to, a remote spoofing a legitimate SSP device may always just
> jam and downgrade to not SSP, but if you have any signals that SSP is
> supported by the device, it may be a good defensive posture.

trying to resolve the name before connected is a waste of time. Resolving the name after connecting will not give you that event. You should just read the remote features.

> Receiving an EIR response or a Remote Host Supported Feature Event
> with the SSP bit set is a good indication that the device supports SSP
> and you should expect SSP to take place.  Again, it is not a valid
> configuration to have EIR enabled but not SSP per my interpretation of
> the 2.1 specification.

If you have an idea on how to tighten this and fail, please send a patch. It is just that our inquiry cache was never designed for that. It was just to speed up the connection process.

Regards

Marcel

