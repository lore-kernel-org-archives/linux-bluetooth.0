Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7378FC47082
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55190613F1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhFCOrQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:47:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40604 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOrP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 10:47:15 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 22BCECED1F;
        Thu,  3 Jun 2021 16:53:27 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: SC bit in SMP Security Request (BLE)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAO1O6seA_k_Fsm=VJvx30kui2tNeJd8tN-a=uXNQnPk9xy6jZQ@mail.gmail.com>
Date:   Thu, 3 Jun 2021 16:45:28 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <479AD5B3-D4E3-4401-A981-27708267FB32@holtmann.org>
References: <CAO1O6seA_k_Fsm=VJvx30kui2tNeJd8tN-a=uXNQnPk9xy6jZQ@mail.gmail.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

> I'm looking into how to a BLE slave should ask the master to initiate
> encryption, if an LTK exists, but the master has not yet started
> encryption on its own.
> 
> Per the spec, the SMP "Security Request" packet should be sent. What
> I'm wondering about is how the "sc" bit in that packet should be set.
> I think the spec isn't clear here.
> 
> Assume the local device supports SC but the LTK stored was not created
> using SC, should we set the "sc" bit to 1 or 0?
> 
> In SMP specification, section 2.4.6 "Security Request":
> 
> "After receiving a Security Request, the master shall first check whether it has
> the required security information to enable encryption; see Section 2.4.4.2. If
> this information is missing or does not meet the security properties requested
> by the slave, then the master shall initiate the pairing procedure."
> 
> What I'm wondering is if this "sc" bit is considered part of the
> "security properties requested" or not. It is part of the
> "authentication requirements" field which is a bit field that
> "indicates the requested security properties", but according to the
> SMP specification, section 3.6.7 "Security Request":
> 
> "The SC field is a 1 bit flag. If LE Secure Connections pairing is supported by
> the device, then the SC field shall be set to 1, otherwise it shall be
> set to 0. If
> both devices support LE Secure Connections pairing, then LE Secure
> Connections pairing shall be used, otherwise LE Legacy pairing shall be
> used."
> 
> In my opinion, that indicates that the "sc" bit should not be treated
> as part of the "security properties requested" but rather simply
> indicates if SC are supported or not, since the spec does not allow us
> to set it to 0 if we support SC as I see it, for example in the case
> we have a LTK generated using the legacy way and want to use that key.
> Another possible interpretation would be that it's part of "security
> properties requested" but it's impossible to ask for a non-SC level if
> we support SC, i.e. basically the slave cannot request the master to
> start encryption with the legacy-generated LTK we already have.
> 
> Consider the case when the remote device doesn't support SC (but is at
> least Core 4.2-compliant and hence understands the protocol) and
> interprets the spec in the way that the "sc" bit is part of the
> "security properties requested", but we (slave) set the "sc" bit to 1
> since we support SC. Then this would trigger a re-pairing all the time
> the slave wants to start encryption using the LTK we already have.
> 
> Note that a firmware update (at either device) could enable support
> for SC, if it wasn't supported before. We don't want a re-pairing
> being forced just because of a firmware update, right?
> 
> When I read the BlueZ implementation at
> https://github.com/bluez/bluetooth-next/blob/9d31d2338950293ec19d9b095fbaa9030899dcb4/net/bluetooth/smp.c#L2308,
> it seems the BlueZ developers' interpretation is that the "sc" bit is
> part of the "security properties requested".
> 
> At the same time, at
> https://github.com/bluez/bluetooth-next/blob/9d31d2338950293ec19d9b095fbaa9030899dcb4/net/bluetooth/smp.c#L2398
> we have that the "sc" bit is set according to if SC is supported or
> not (not depending on the requested security level), when sending a
> Security Request.
> 
> So it seems the BlueZ developers use the interpretation where it it
> both indicates if SC is supported, but at the same time also is part
> of the "security properties requested".
> 
> I'm also a bit skeptical to build_pairing_cmd. Should the authReq more
> or less just be copied from the Security Request to the Pairing
> Request? Why not just always request for the highest security possible
> in the Pairing Request? If the slave wants lower security it can say
> so in the pairing response. Otherwise we could get in a situation
> where we previously have an LTK without mitm security, and we send a
> security request with mitm=0 in order to use this, but the master
> device has removed the bond, and hence sends a pairing request with
> mitm=0 instead of mitm=1, even though mitm would be preferred, if
> possible.
> 
> So my question is simply, if I want to enable encryption to provide
> integrity and confidentiality (GAP 10.6 Encryption Procedure) at a
> peripheral, using the key I already have, or if the master deleted the
> key create a new bond with the best possible security properties, what
> should I set the "sc" and "mitm" bits to in the Security Request that
> I send, in case the local device supports both SC and MITM, but the
> LTK that is stored wasn't generated using SC and/or MITM?
> 
> Let me know if my concerns make sense or if I have totally missed
> something in the specification or so.

I have read this email a few times now and I am still confused on what you are asking. Can you show us a btmon trace of what is going on and how this works right now.

Regards

Marcel

