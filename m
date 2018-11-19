Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BFCC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 13:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8FA2086A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 13:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8FA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeKSXu4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:50:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34542 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbeKSXu4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 18:50:56 -0500
Received: from marcel-macbook.fritz.box (p4FEFC1D6.dip0.t-ipconnect.de [79.239.193.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9078ACF2AF;
        Mon, 19 Nov 2018 14:34:49 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH BlueZ] core: Catch SIGPIPE
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+Nkbb2vUXVD6FY4+_ZJEqjgfXh=ONn7JYD9nyrx4E50Q@mail.gmail.com>
Date:   Mon, 19 Nov 2018 14:27:17 +0100
Cc:     gbenhaim@augury.com,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <7CA37768-A9C6-4241-82FD-51682EB50133@holtmann.org>
References: <20181117060024.10390-1-gbenhaim@augury.com>
 <CAHotPr82XDc9tE_76iknhQtbTjEMzXdQa4HpUy7asTZvwjG5ZQ@mail.gmail.com>
 <CAHotPr9dh7Nz6St10D9LvEUDGrcM29_8CdGivanrw0qzVPb28Q@mail.gmail.com>
 <CABBYNZ+Nkbb2vUXVD6FY4+_ZJEqjgfXh=ONn7JYD9nyrx4E50Q@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> i don't think it works at all... bluetoothd is still exiting with SIGPIPE.
>> i'm a bit lost with fixing this, I tried few methods that were
>> suggested here and the only one that actually worked is to ignore the
>> signal.
>> 
>> please advise how do you want to proceed with this..
> 
> We might be better of switching to socketpair instead of pipe2 then,
> not only we can fix this problem using MSG_NOSIGNAL but also use
> sendmsg and setting auxiliary data which can be used to set things
> like the offset.

I agree, lets switch to socketpair. I have read up on handling SIGPIPE via signalfd and other means and it is just complicated.

Also we should include MSG_NOSIGNAL in all of our code and even switch the simple read/write to it.

Regards

Marcel

