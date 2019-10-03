Return-Path: <SRS0=QFCk=X4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B9FC10F14
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B4220700
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Oct 2019 12:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=einfach.org header.i=@einfach.org header.b="PcxPOwVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfJCMNI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:13:08 -0400
Received: from postler.einfach.org ([5.9.2.179]:38249 "EHLO
        postler.einfach.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfJCMNI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Oct 2019 08:13:08 -0400
Received: from [192.168.5.9] (unknown [83.55.205.201])
        by postler.einfach.org (Postfix) with ESMTPSA id E0A989C3;
        Thu,  3 Oct 2019 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=einfach.org; s=mail;
        t=1570104785; bh=NNZhYn4aQWkgfeiO2D+K7BP48MsHEb8FoVLtxcu6JF0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=PcxPOwVjTPT16YGoYlGdJ2ypZjX4avVcU6dgr5z41CR+IC6kKEzv192csEanu2H+N
         TOj8OhKI1JgKJ6WDQwZesWEp0MD6nvmdcXHG6fYY8aiNa1suFZKUgNu6txYx0xTZLR
         lcVIxKrFlnR4jAmxAc1h1qmQVr0he2QPJ15848qY=
Subject: Re: Battery readouts on dbus for GATT battery service
To:     Pavel Nikulin <pavel@noa-labs.com>, linux-bluetooth@vger.kernel.org
References: <CAG-pW8Gjp=adimXCkKEgZPvUkRV51zb1CwZaw6FrjVxOUwQdmQ@mail.gmail.com>
From:   Bruno Randolf <br1@einfach.org>
Openpgp: preference=signencrypt
Autocrypt: addr=br1@einfach.org; prefer-encrypt=mutual; keydata=
 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
 kcSK3qeB7qKuAXopxt5uEFNOKZeKF/UQlKrr
Message-ID: <2849967c-1d8a-1de1-f019-f82331e6568f@einfach.org>
Date:   Thu, 3 Oct 2019 13:13:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAG-pW8Gjp=adimXCkKEgZPvUkRV51zb1CwZaw6FrjVxOUwQdmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11 (postler.einfach.org [0.0.0.0]); Thu, 03 Oct 2019 12:13:05 +0000 (UTC)
X-Virus-Scanned: clamav-milter 0.98.7 at bced1da0f74a
X-Virus-Status: Clean
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 03/10/2019 13:07, Pavel Nikulin wrote:
> Hello,
> 
> I have a bt 4.2 mouse that has a battery service, but no battery
> attribute visible in Bluez, Rapoo m550 using YiChip 1201.
> 
> Is it even hypothetically possible that a device can have a battery
> service, but no battery attribute?

bluez filters it out. This is exactly what I am seeing.

Reference to my post just two days ago:
https://www.spinics.net/lists/linux-bluetooth/msg81438.html

Greetings,
bruno
