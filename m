Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD87C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 12:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7DD208B6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 12:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgL1MnI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 07:43:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:32866 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgL1MnI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 07:43:08 -0500
Received: from mac-pro.holtmann.net (p4ff9f924.dip0.t-ipconnect.de [79.249.249.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id C239ECECEC;
        Mon, 28 Dec 2020 13:49:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: Default to HW mSBC on capable controllers ?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZK1kRCvhXnoMbskTYdoFUCOTSAdfUVqv3yftfp_G3NxFA@mail.gmail.com>
Date:   Mon, 28 Dec 2020 13:42:26 +0100
Cc:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A9EA687A-E9BB-44B7-82EA-DE8F83D142D4@holtmann.org>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <20201221210707.evrdeyiki45pivux@pali>
 <26db80417b43d919b6e33a4ee56c0e44a2f42a5c.camel@infinera.com>
 <20201223155624.uzbxfxtowenjrwm2@pali>
 <CABBYNZK1kRCvhXnoMbskTYdoFUCOTSAdfUVqv3yftfp_G3NxFA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>>> There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC
>>>> 
>>>> No, it does not mean mSBC.
>>>> 
>>> 
>>> I forgot, if BTUSB_WIDEBAND_SPEECH does not mean capable of HW mSBC, what does it mean?
>> 
>> BTUSB_WIDEBAND_SPEECH flag is just for usb bluetooth adapters. Not for
>> UART or SDIO bluetooth adapters.
>> 
>> It is a hint set for some bluetooth adapters which are on kernel
>> whitelist that wideband speech support is possible for them.
> 
> Actually it is meant indicate to application that BT_PKT_STATUS can be
> used which enables the implementation of PLC (Packet Loss
> Concealment), Ive been advocating to change it or just remove it
> entirely and move it to be queried with BT_PKT_STATUS.

after we fixed the bug with the SCO packet flags, we might not even need this anymore at all and just enable the error reporting unconditionally.

On a side note, I insisted on calling this WIDEBAND_SPEECH option since we should be hiding details behind a single flag and not spread multiple flags for things that need to be combined into one logical feature anyway.

Regards

Marcel

