Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79347C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 15:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiCNPZY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbiCNPZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 11:25:23 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B05F6354
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 08:24:13 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 373DBCECC5;
        Mon, 14 Mar 2022 16:24:13 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: fix incorrect nonblock bitmask in
 bt_sock_wait_ready()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACB127+s8mj2-Hkt4yZXRZ_cQ9CbAK0r3y709-8Cb3awpVJm9Q@mail.gmail.com>
Date:   Mon, 14 Mar 2022 16:24:12 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CA26CE39-DBDE-4DC6-80C1-F091968DC4D3@holtmann.org>
References: <20220224100641.2449550-1-gavin@matician.com>
 <71D25C8F-67D1-4EC0-9160-5F61C832F0AF@holtmann.org>
 <CACB127+s8mj2-Hkt4yZXRZ_cQ9CbAK0r3y709-8Cb3awpVJm9Q@mail.gmail.com>
To:     Gavin Li <gavin@matician.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gavin,

>>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>>> index ee319779781e6..69374321130e4 100644
>>> --- a/net/bluetooth/af_bluetooth.c
>>> +++ b/net/bluetooth/af_bluetooth.c
>>> @@ -568,7 +568,7 @@ int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
>>> EXPORT_SYMBOL(bt_sock_wait_state);
>>> 
>>> /* This function expects the sk lock to be held when called */
>>> -int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
>>> +int bt_sock_wait_ready(struct sock *sk, unsigned int flags)
>> 
>> can we then also do s/flags/msg_flags/ then.
> I prefer keeping it as flags because all other net code also uses
> flags, msg_flags only appears
> in msg->msg_flags.

while that might be true, I find it a lot clearer if the variable is msg_flags.

>>> @@ -576,7 +576,7 @@ int bt_sock_wait_ready(struct sock *sk, unsigned long flags)
>>> 
>>>      BT_DBG("sk %p", sk);
>>> 
>>> -     timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
>>> +     timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
>> 
>> Since sock_sndtimeo() is taking a bool. This might be better !!(flags & MSG_DONTWAIT).
> It appears to be well-known in the net code that sock_sndtimeo takes a
> bool, since no other
> uses of it do the "!!" conversion.
> 
> Let me know what you think. I can make the changes if needed but I was
> just trying my best
> to match the currently existing convention.

And other code in the kernel makes sure to clearly turn something into a bool. You get 0x00 and 0x40.

Regards

Marcel

