Return-Path: <SRS0=tmcz=3Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90350C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E532214D8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 16:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgA0Qyt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:54:49 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54434 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0Qyt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 11:54:49 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 56CEBCECD4;
        Mon, 27 Jan 2020 18:04:07 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D61B5AA9-A509-4253-95D7-F6401C832081@holtmann.org>
Date:   Mon, 27 Jan 2020 17:54:46 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <38D30EF6-1651-4EA7-A9E2-05885C5DDFB6@holtmann.org>
References: <20200120202708.111383-1-alainm@chromium.org>
 <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
 <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com>
 <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
 <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com>
 <DFE9B731-5CB8-4FDA-8E89-1D5A51EAFB67@holtmann.org>
 <CALWDO_V=Q0725MhnA3hMnvL+hDbGVCa-RCT4d4NCysMo0Fvh7g@mail.gmail.com>
 <F6319DB4-FE70-45C8-A61D-D965CB659C9E@holtmann.org>
 <CALWDO_Vqboxt4JfV9yGVd5Jv5jZ-vwtOghh4tffpQpQzHuq6NQ@mail.gmail.com>
 <D61B5AA9-A509-4253-95D7-F6401C832081@holtmann.org>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>> From a high level, this looks good for me although I agree, this is an
>> order of magnitude bigger in terms of scope.  Can you suggest perhaps
>> an interactive way to deliver this over a period of time, perhaps
>> prioritizing the BT_DEBUG kernel messages first? :)
> 
> I am always in favor of increasing the ability to debug things, but we need to do this in a clean fashion and not some short term hacks (since they will come back and haunt us). I like to get some review on my idea first.
> 
> What we could do is work on the BT_DBG etc infrastructure to allow switching when dynamic_debug is not available. Then you would use some debugfs toggle in /sys/kernel/debug/bluetooth since that is no stable API for us (and of course the clear understanding that this toggle is temporary).

I just posted a patch to allow a short term solution. It is similar to the patch you pointed me to with the difference that it is a debugfs entry and limited to the case when dynamic debug is disabled. Is this something that would work until we get a more complete solution worked out and tested?

Regards

Marcel

