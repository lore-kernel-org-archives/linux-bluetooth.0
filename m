Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562E9C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 12:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08B4208B6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 12:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=litza.de header.i=@litza.de header.b="xPAqkyfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgKCMxP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 07:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgKCMxP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 07:53:15 -0500
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Nov 2020 04:53:14 PST
Received: from mail.jplitza.de (mailgate.jplitza.de [IPv6:2a02:16d0:2004:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C8C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 04:53:14 -0800 (PST)
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ujjwal Sharma <ryzokuken@igalia.com>,
        Andrew Fuller <mactalla.obair@gmail.com>,
        Aleksandar Kostadinov <akostadi@redhat.com>,
        David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, usharma@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=litza.de; s=default;
        t=1604407389; bh=wl27CpQ7tW7cIM6SvpK8wYdh3KilwoW53XT+BdfwIo0=;
        h=To:References:From:Subject:Date:In-Reply-To:From;
        b=xPAqkyfMpMcqtdveudDK3BbOHEtRxOOR7zxGzApA3YmufbyDVwJl/oHrpFwHB8K1/
         0aIWYkDHmQRUnbiWFYSpnp2t3rrMk56L9hvtHUMGTUUdJ3rxlXnXblX40Pujr0uoAI
         SkjqABjrCB10m2Q0H6krwPuMSywFYSc7+KqP5LIw=
References: <20200419234937.4zozkqgpt557m3o6@pali>
 <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
 <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
 <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
 <20200516075340.3z37ejs3fuhctunl@pali>
 <CABBYNZLWsYHeOo3_+hcq4r+gY_0sLBQhftW7My7Y4D1n9o5jxg@mail.gmail.com>
 <20200518165011.jfarrp5mtqoy3mqz@pali>
 <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
 <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
 <aff611bb-4b38-7614-ce61-fc3e7c012615@igalia.com>
 <20200604204343.eor47oe3fbzf6rbv@pali>
From:   Jan-Philipp Litza <janphilipp@litza.de>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
Message-ID: <020e740e-807b-ccda-0036-f307fe453c1a@litza.de>
Date:   Tue, 3 Nov 2020 13:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <20200604204343.eor47oe3fbzf6rbv@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.102.4 at mail.jplitza.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Pali Rohár wrote:
> Have I missed something? setsockopt() solution which I described in
> <20200419234937.4zozkqgpt557m3o6@pali> email is already runtime option.

I think what Luiz meant was that there has to be a module option that
enables the additional kernel code, for example

modprobe bluetooth enable_voice_setup=1

This would enable us interested folk to test the changes, while they
cannot blow up other peoples Bluetooth stack. At least that's the
reasoning that I assume.

The setsockopt() is a runtime option on the application side but doesn't
"protect" the kernel.

Content-wise, I understand Luiz' message as an approval of the general
API you proposed, as long as it is not active by default.

Best regards,
Jan-Philipp
