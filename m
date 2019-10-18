Return-Path: <SRS0=NsPc=YL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A807CA9EA0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 09:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ABF21897
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 09:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=einfach.org header.i=@einfach.org header.b="hBkepavB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfJRJVm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:21:42 -0400
Received: from postler.einfach.org ([5.9.2.179]:42409 "EHLO
        postler.einfach.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfJRJVm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Oct 2019 05:21:42 -0400
Received: from [192.168.5.9] (unknown [83.55.204.182])
        by postler.einfach.org (Postfix) with ESMTPSA id 00B9864B;
        Fri, 18 Oct 2019 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=einfach.org; s=mail;
        t=1571390499; bh=rAtmAyHnZzF4fWadlqqVZYNZ47rbujKn/uJEf7Fdkzo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hBkepavBqWJVCehpgigfA9YzgEWo5fHeevGwuUUMNPDGR7eZUH7d2jiWqFl9kHfj3
         uUFohnXBn7lO2l79FPbKbohaW5mQCIIwIlbhoNiB2j+64opP3OTbCrzSU7OHGlt796
         j42kbl6Wzp8IF7ImXs27dG6MQQDXBM/TuGOBCSP8=
Subject: Re: bluetoothd: Please don't filter UUIDs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <a04053d3-6165-5dfa-932c-5a93d2bd1358@einfach.org>
 <CABBYNZLK_rzAf5aPzJHShEVvXSvndZFh5TjyjaaFzAPw_sHoTA@mail.gmail.com>
 <12b16466-3633-75ff-bf84-9cef44a2358c@einfach.org>
 <CABBYNZKUmctzTRxix9P-FBK=15v01tkHWMCirFefStpCS2ukBQ@mail.gmail.com>
From:   Bruno Randolf <br1@einfach.org>
Openpgp: preference=signencrypt
Autocrypt: addr=br1@einfach.org; prefer-encrypt=mutual; keydata=
 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
 kcSK3qeB7qKuAXopxt5uEFNOKZeKF/UQlKrr
Message-ID: <335aee58-02f5-b654-4289-9be34ec8eef0@einfach.org>
Date:   Fri, 18 Oct 2019 10:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZKUmctzTRxix9P-FBK=15v01tkHWMCirFefStpCS2ukBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11 (postler.einfach.org [0.0.0.0]); Fri, 18 Oct 2019 09:21:39 +0000 (UTC)
X-Virus-Scanned: clamav-milter 0.98.7 at bced1da0f74a
X-Virus-Status: Clean
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi!

On 09/10/2019 14:34, Luiz Augusto von Dentz wrote:
> There are runtime switches to disable plugins i.e.: bluetoothd -P
> battery and we can add build time switches as well, btw patches are
> welcome if you want to disable battery plugin.

That option to disable the plugin is good enough for me at the moment.
Sorry for not having found it on my own.

Regards,
bruno

