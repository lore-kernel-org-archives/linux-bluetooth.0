Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09E5C33CAA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 05:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6C324125
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 05:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgAWFwg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 00:52:36 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46428 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAWFwf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 00:52:35 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7BCC6CECFB;
        Thu, 23 Jan 2020 07:01:53 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com>
Date:   Thu, 23 Jan 2020 06:52:33 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DFE9B731-5CB8-4FDA-8E89-1D5A51EAFB67@holtmann.org>
References: <20200120202708.111383-1-alainm@chromium.org>
 <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
 <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com>
 <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
 <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> Thanks for your patience.  After further research dynamic_debug is not
> available on retail chromium os user systems for a variety of reasons,
> some of which you can find in this trail:
> https://bugs.chromium.org/p/chromium/issues/detail?id=188825.
> 
> Given we need to be able to diagnose things in the field, this is not
> a good option for this.
> 
> I hope this helps explain or justify the need for this interface.

the reasoning from Kees is 6 years old. Are his issues still valid?

So I have been looking into pushing bt_{info,warn,err} into the btmon traces. That is why we have bt_dev_* etc. error macro and have changed a lot of code to use them. This will hopefully allow us to have errors and warnings directly in the btmon traces. For bluetoothd errors and warnings this already works btw.

I don’t believe that I want to duplicate the dynamic_debug functionality and push even more info into dmesg ring buffer that then needs to be collected and aligned with btmon traces. The big advantage is if you get a btmon trace and that has the actual message right in it at the right place with the right timestamp.

If we push bt_{info,warn,err} into btmon, it might be simpler to do the same for BT_DBG, but it will of course require extra work since our BT_DBG statements are meant to be compiled out if dynamic_debug is disabled.

Regards

Marcel

