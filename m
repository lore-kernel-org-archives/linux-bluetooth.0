Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD7CC001B0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 20:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjHHU3E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjHHU2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 16:28:52 -0400
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A38353D9
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 12:48:13 -0700 (PDT)
Received: from [IPV6:2a01:c23:7187:a500:8597:99d3:3096:e702] (dynamic-2a01-0c23-7187-a500-8597-99d3-3096-e702.c23.pool.telefonica.de [IPv6:2a01:c23:7187:a500:8597:99d3:3096:e702])
        by mail.svario.it (Postfix) with ESMTPSA id ED86DDA013;
        Tue,  8 Aug 2023 21:48:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
        t=1691524090; bh=IMDmY4gPcHj+xIAfIIMl4nxT91oXyj39WyhoZOMSgP4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=O4Khhz4571XPRLc8X4JgpLzYOaaZTJDs3e2dCdgloy9gcY5u1nOXmb6XzAB1WOfqI
         V0GP5DUteBqzyGiXqEKlS2yH7LUmngkjPE6uRCcdFu/ppaZoJP1i/wH3LVuTBq/JqR
         A2FZbCqtvPv8EKHwPwjMKI/tPIZw+QQCp8Gt+Ndal6Wf1QRCkKLwlKd2YgkLL67cL2
         ifc4Sd9ZraXrEOtf2bPw3wjwSSotKzCz6KcyqLvEZ6FRt+4zPS7s9mTDYyjULskSmh
         8l4466HP0CrvLlpnoAPd5Xzwg+m4bPQJhOl36JmNjc+W/l+NqHMpMivzo9kB/9IOaj
         q38STu60nByLQ==
Message-ID: <2ef4482a-a387-76ff-ef2f-061a54ae1b9c@svario.it>
Date:   Tue, 8 Aug 2023 21:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20230808085540.1475435-1-gioele@svario.it>
 <20230808085540.1475435-2-gioele@svario.it>
 <CABBYNZLfUaVzERO+ddHkoE39mObZ+uAm8EF+VXngKyQZ4rJjRA@mail.gmail.com>
Content-Language: en-US
From:   Gioele Barabucci <gioele@svario.it>
Subject: Re: [PATCH BlueZ 1/1] Makefile.am: Install D-Bus policy in
 /usr/share, not /etc
In-Reply-To: <CABBYNZLfUaVzERO+ddHkoE39mObZ+uAm8EF+VXngKyQZ4rJjRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 08/08/23 20:48, Luiz Augusto von Dentz wrote:
> On Tue, Aug 8, 2023 at 11:23 AM Gioele Barabucci <gioele@svario.it> wrote:
>>
>>  From https://bugs.debian.org/1006631:
>>
>>> dbus supports policy files in both `/usr/share/dbus-1/system.d` and
>>> `/etc/dbus-1/systemd`. [The] recently released dbus 1.14.0, officially
>>> deprecates installing packages' default policies into `/etc/dbus-1/systemd`,
>>> instead reserving it for the sysadmin. This is the same idea as the
>>> difference between `/usr/lib/udev/rules.d` and `/etc/udev/rules.d`.
> 
> I'm fine with these changes but we also need to bump dbus dependency
> to 1.14 then since it currently requiring 1.6:
> 
> PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.6, dummy=yes,
>                  AC_MSG_ERROR(D-Bus >= 1.6 is required))

Thanks Luiz for the quick review.

I believe bumping the minimum D-Bus version to 1.10 (released in 2015) 
should be enough:

https://sources.debian.org/src/dbus/1.10.32-0%2Bdeb9u1/NEWS/#L483-L499

I'll send a v2 patch that adds the version bump.

Regards,

-- 
Gioele Barabucci
