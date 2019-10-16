Return-Path: <SRS0=8ZYm=YJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5DDFA3728
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFE7222BD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfJPTFS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:05:18 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43393 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJPTFR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 15:05:17 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p578ac27a.dip0.t-ipconnect.de [87.138.194.122])
        by mail.holtmann.org (Postfix) with ESMTPSA id E4488CECDD;
        Wed, 16 Oct 2019 21:14:14 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: Determinate EDR speed
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191011200420.hbrutdclfva2uqpv@pali>
Date:   Wed, 16 Oct 2019 21:05:15 +0200
Cc:     Brian Gix <brian.gix@intel.com>,
        "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2DFEA001-74D0-45AE-BAAE-110E075D0E9E@holtmann.org>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
 <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
 <20191011183502.ao45xlyfabpbadxo@pali>
 <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
 <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
 <20191011200420.hbrutdclfva2uqpv@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>>> Currently bluez API, method Acquire() already inform called application
>>>> what is socket MTU for input and output. So from this information it is
>>>> possible to detect if device supports EDR 3 or not.
>>>> 
>>>> But it is too late to have this information. I need to send SBC
>>>> parameters to bluez first when doing A2DP negotiation, this is early
>>>> steps before Acquire() is called.
>>> 
>>> This seems to be the kind of information which is fixed, for the life of the pairing.
>>> 
>>> What if you assumed the lower speed the first time you connected, determined the
>>> speed during the first streaming, and then either immediately renegotiate (caching the identifying
>>> information
>>> of the SNK), or just cache the information for future connections.
>>> 
>>> Or the reverse, and assume fast, but immediately adjust down if you aren't getting what you hoped for.
>>> 
>>> In any case, this would be a "Device Setup" glitch which you could note as a routine part of pairing in the
>>> documentation.
>> 
>> Or, Stream "Silence" the first time you connect, in order to determine throughput.  It would add 1-2 seconds to
>> your connection time perhaps, but would be less noticable to the user.
> 
> This increase connection time, increase complexity of implementation
> (lot of things can fail) and just complicate lot of things there. Plus
> adds that glitch which is not user friendly.
> 
> Also bluetooth devices, like headsets, probably do not expects that
> somebody is going to do such thing and we can hit other implementation
> problems...
> 
> And moreover it is just big hack and workaround for that problem. Not a
> reasonable solution.
> 
> In btmon I can see it, so kernel already knows that information. Why it
> cannot tell it to userspace and bluetooth daemon to client application?
> 
> Client application (e.g. pulseaudio) should really know if is going to
> talk with bluetooth device with EDR 2 or EDR 3.

actually the kernel doesn’t know either. We start with an allowed packet type mask and then the LC on each side will negotiate the current used packet types. These can change at any time. So if you want to know the current packet type, we would have to poll for it, but there is also no command that can do that.

The only thing that could be done is to limit the allowed packet types when creating the connection. However that again defeats the purpose since A2DP is not the only user of that ACL link.

What might be useful is to start using the flow specification and configure it on an ACL if an L2CAP socket for audio has been created.

Regards

Marcel

