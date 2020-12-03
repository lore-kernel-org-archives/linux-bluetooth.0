Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD9C63777
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FB520E8F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbgLCNX6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:23:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47258 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387961AbgLCNX5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 08:23:57 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1BCC4CECFC;
        Thu,  3 Dec 2020 14:30:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: Add workaround for remote-wakeup
 issues with some fake CSR controllers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55f5b125-eef1-a957-7b40-1f01ea571f2c@redhat.com>
Date:   Thu, 3 Dec 2020 14:23:15 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <648C3740-0EB5-4EDD-A340-4B2ADE023958@holtmann.org>
References: <20201123101308.7291-1-hdegoede@redhat.com>
 <20201123101308.7291-3-hdegoede@redhat.com>
 <55f5b125-eef1-a957-7b40-1f01ea571f2c@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

>> With the recent btusb change to detect and deal with more fake CSR
>> controllers, I decided to see if one of the fakes which I have
>> lying around would now work.
>> 
>> After much experimentation I came to the conclusion that it works, if I
>> have autosuspend enabled initially and then disable it after the device
>> has suspended at least once. Yes this is very weird, but I've tried many
>> things, like manually clearing the remote-wakeup feature. Doing a
>> runtime-resume + runtime suspend is the only way to get the receiver
>> to actually report received data (and/or pairing info) through its
>> bulk rx endpoint.
>> 
>> But the funkyness of the bulk-endpoint does not stop there, I mainly
>> found out about this problem, because with autosuspend enabled
>> (which usually ensures the suspend at least once condition is met),
>> the receiver stops reporting received data through its bulk rx endpoint
>> as soon as autosuspend kicks in. So I initially just disabled
>> autosuspend, but then the receiver does not work at all.
>> 
>> This was with a fake CSR receiver with a bcdDevice value of 0x8891,
>> a lmp_subver of 0x0x1012, a hci_rev of 0x0810 and a hci_ver of
>> BLUETOOTH_VER_4_0.
> 
> I just realized that I should have opened this one and add the
> chipmarkings to the commit msg here too. So I've just opened it
> and took a look.
> 
> This one has a Barrot 8041a02 chip and searching for 8041a92 shows that
> the internet is full of reports of how crappy it is.
> 
> I guess this patch probably will get some review remarks anyways,
> but let me know if you want a v3 with just the chip added to the
> commit msg.

yes please. The more info we add the better.

Regards

Marcel

