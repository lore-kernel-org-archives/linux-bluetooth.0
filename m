Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B05BC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 05:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0577D20663
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 05:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCRFZb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 01:25:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56511 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRFZb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 01:25:31 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1991ECECF0;
        Wed, 18 Mar 2020 06:35:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [Bluez PATCH v1] input: disconnect intr channel before ctrl
 channel
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+=wMNuvjJ5VK2zpd6euqeEZ8JXbd67RmPgxDfdCgce9w@mail.gmail.com>
Date:   Wed, 18 Mar 2020 06:24:59 +0100
Cc:     Archie Pusaka <apusaka@google.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <14E46BF4-0688-4A0B-AE84-46C4426C5E9A@holtmann.org>
References: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
 <CABBYNZL1D44M4z2c+4zbjLgZ=PMHsTwy1VpYZpsJbpFJ9POZug@mail.gmail.com>
 <CAJQfnxEFM81DSvZb+ULG7+nwQuy-GWj26GWn4OP+Bp--24N1CQ@mail.gmail.com>
 <CABBYNZ+=wMNuvjJ5VK2zpd6euqeEZ8JXbd67RmPgxDfdCgce9w@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> Luckily you asked, because I found out that actually the patch didn't
>> wait for the disconnection response for any case. It does delay the
>> disconnection of the ctrl channel slightly though, but that doesn't
>> guarantee a proper order of disconnection. Therefore, as of now, this
>> patch is not fixing anything.
>> 
>> Digging more into this matter, I found out by removing this condition
>> (sk->sk_shutdown == SHUTDOWN_MASK) in [1], it makes intr_watch_cb()
>> called after truly receiving the interrupt disconnection response.
>> However, I haven't checked whether removal of such condition will
>> break other things.
>> Do you have any suggestions?
> 
> I see, we shutdown the socket immediately since the socket API itself
> don't seem to have a concept of disconnect syscall not sure if other
> values could be passed to shutdown second parameter to indicate we
> want to actually wait it to be disconnected.

in a blocking synchronous system call world we have SO_LINGER for that. In the world of asynchronous IO handling (what we do), we need to check what is the right way of handling this.

Regards

Marcel

