Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C386EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 06:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHIGoD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHIGoD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 02:44:03 -0400
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C610CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 23:43:59 -0700 (PDT)
Received: from [IPV6:2a01:c22:b5df:9800:8597:99d3:3096:e702] (dynamic-2a01-0c22-b5df-9800-8597-99d3-3096-e702.c22.pool.telefonica.de [IPv6:2a01:c22:b5df:9800:8597:99d3:3096:e702])
        by mail.svario.it (Postfix) with ESMTPSA id 47B89DA0C6;
        Wed,  9 Aug 2023 08:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691563436; bh=Q+m32Am3zFIle5Jhn+E9QVwBdjeqaTap7kM8gvMBmvk=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=d9nLMDgYSKgUSNNmwFk6HF/llep8nIWB5gIIQo6ZJDdfFncT8KTsWUIxmYoPhpWTq
         1FMR8P6jerUoGva0D1BF6THKsQJs+6JnOe/m4ELpwjNDDJT3rcq/Va1Sze7rlr0/ao
         K2dRJPWAxj3T5rgtaVrzTlBartzreCjAWtoDHK53bdunYa+4co2HLmM+2oDJBTpPbI
         q73bLe7D2+8xmTdIHd9GRQhE4yewHeqBsSf3q2FnVVl9rnhNwvtFhRYog2ATAyXnu1
         orjp6jCKqRB7v9j9PQj0IJ8E63+EcXXARuSf7xFKOt9B90SIta0joDZ71Tyi3E5zT1
         Ub054EP3ZPmsw==
Message-ID: <c479a8ec-a134-c209-6bd6-92feaa670c22@svario.it>
Date:   Wed, 9 Aug 2023 08:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org
References: <20230808200022.2001329-1-gioele@svario.it>
 <a22d3ca8-2ec8-4968-801e-2bbc3b8e4d09@molgen.mpg.de>
From:   Gioele Barabucci <gioele@svario.it>
Subject: Re: [PATCH BlueZ v2] configure.ac: Install D-Bus policy in
 /usr/share, not /etc
In-Reply-To: <a22d3ca8-2ec8-4968-801e-2bbc3b8e4d09@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 09/08/23 08:02, Paul Menzel wrote:
> Am 08.08.23 um 22:00 schrieb Gioele Barabucci:
>>  From https://bugs.debian.org/1006631:
>>
>>> dbus supports policy files in both `/usr/share/dbus-1/system.d` and
>>> `/etc/dbus-1/systemd`. [The] recently released dbus 1.14.0, officially
>>> deprecates installing packages' default policies into
>>> `/etc/dbus-1/systemd`, instead reserving it for the sysadmin.
>>> This is the same idea as the difference between `/usr/lib/udev/rules.d`
>>> and `/etc/udev/rules.d`.
>> ---
>> v2: bump D-Bus min version, derive DBUS_CONFDIR from datadir
> 
> It’d be great if you mentioned the D-Bus version bump explicitly in the 
> commit message, and the years of the release (2012 and 2015).

Sure. V3 is on its way.

> (Maybe even make it a separate commit.)

No problem. I sent everything in one patch because I read

> 3) Split your patch according to the top-level directories. E.g.: if 
> you added a feature that touches files under 'include/', 'src/' and
> 'drivers/' directories, split in three separated patches, taking care
> not to break compilation.
in HACKING as "don't split too much, we prefer one patch per directory", 
but I now understand that it actually means "touch at most one directory 
per commit".

Regards,

-- 
Gioele Barabucci
