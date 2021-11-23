Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Nov 2021 13:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhKWN1O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:27:14 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40126 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhKWN1M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 08:27:12 -0500
Received: from smtpclient.apple (unknown [37.85.159.153])
        by mail.holtmann.org (Postfix) with ESMTPSA id 724F6CED08;
        Tue, 23 Nov 2021 14:24:02 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2] uhid: Remove local copy of uhid header
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <189034533844f15d220ece574427956c42a4b16e.camel@hadess.net>
Date:   Tue, 23 Nov 2021 14:24:00 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <93A5D079-D324-4B31-95F4-F4EA3C64CFA6@holtmann.org>
References: <20211122211707.2219208-1-luiz.dentz@gmail.com>
 <45caaa82b56528fed03e534103f55f2ebbdc3885.camel@hadess.net>
 <CABBYNZJgpB8Y9gc92BupiBBkjyPf5SNkOBpp6B1qtYktxmAb_g@mail.gmail.com>
 <189034533844f15d220ece574427956c42a4b16e.camel@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Batien,

>>>> uhid.h is part of kernel uapi nowadays so it can be included
>>>> directly from linux/uhid.h so this removes the local copy to use
>>>> it
>>>> instead.
>>> 
>>> This will cause the same problems that importing those headers into
>>> the
>>> repository was supposed to solve. If you remove those headers, then
>>> older distributions will be stuck on old kernel headers, and bluez
>>> compilations will regularly fail when it uses new structs, struct
>>> members, functions, or constants that are in the upstream uapi
>>> headers
>>> but not yet propagated to the user's distribution.
>> 
>> I'm not following you on this, the distros don't have uapi headers
>> that match their kernel release? Afaik being a kernel uapi means
>> these
>> APIs are considered stable and I suspect they haven't been changed in
>> a while, you are right that this introduces a kernel dependency if we
>> were to use new members but I still think this is better than having
>> copies that at some point goes out of sync, specially when nothing
>> indicates that things like input_event was not accepted by the
>> kernel.
> 
> Let's say you want to use a KEY_* definition that was recently added to
> the kernel, what would you do?
> 
>>> Strong NAK on this one and the uinput header change too.
>> 
>> I didn't introduce the usage of any new symbols, so the only new
>> requirement is that linux/uinput.h and linux/uhid.h headers exist, I
>> could however rollback if we have another way to check if those
>> headers exists use then otherwise we can keep using copies, perhaps
>> move then under linux/ directory, anyway it is not like we don't have
>> kernel dependencies already and we actually have been debating on
>> having the bluetooth socket definitions as part of the uapi instead
>> of
>> libbluetooth, so we will need to sort out how we can update the
>> userspace parts with new kernel interface without breaking the build
>> on systems that don't actually ship with e.g. linux/bluetooth.h.
> 
> You're talking about the state of things now, I'm talking about the
> compilation failures once you rely on a slightly newer header that
> isn't shipped with a distribution.
> 
> But if you're willing to react to the compilation failure in the
> future, I can't really stand in your way. It just seems weird to do
> this now just to undo it the moment you'll need a slightly newer kernel
> header.

if I can’t build the tarballs on 5.10.0-7-powerpc, then they don’t get released.

Regards

Marcel

