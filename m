Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB0C4743C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 22:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EEAE61009
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 22:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFDWS5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 18:18:57 -0400
Received: from rcloudmail.hostconnection.net ([38.96.19.98]:60665 "EHLO
        rcloudmail.hostconnection.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhFDWS4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 18:18:56 -0400
X-SmarterMail-Authenticated-As: jay.foster@systech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=systech.com; s=key;
        h=Content-Language:Content-Transfer-Encoding:Content-Type
          :In-Reply-To:MIME-Version:User-Agent:Date:Message-ID:Organization
          :From:References:Cc:To:Subject:Reply-To:Received;
        bh=pcYtAUYeodJdboycZjWkgW5N1uQ7326a6fGDGP2wKnI=;
        b=An70fACvnM+kh47+hXwec+wdjn3HIL6pAnRo0tYWq42m7KFQ/bH1YO5vXnn0n7i4o
          LrYqreGDXyT3PqJWlMl2Rum9kJzO3ejJHYxGJlMsKAXWt0JHLs2H2N8lx4FycU7Lk
          Rn+RFIdP5h+XjbYo+E4z3qXn7ZOK76bzly1FPuMB4=
Received: from [172.16.4.182] (wsip-70-167-11-34.sd.sd.cox.net [70.167.11.34]) by rcloudmail.hostconnection.net with SMTP
        (version=Tls12
        cipher=Aes256 bits=256);
   Fri, 4 Jun 2021 15:17:01 -0700
Reply-To: jay@systech.com
Subject: Re: Bluez Socket File Descriptor Leak
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <749228e2-4d49-83ef-06f0-2db0532beb93@systech.com>
 <CABBYNZJeEV-4-fhGAwzqu0e+J3DN9Bm8pDk1s29myUdRF29jUQ@mail.gmail.com>
From:   Jay Foster <jay@systech.com>
Organization: Systech Corporation
Message-ID: <22ada41a-d85b-1cbb-a05c-68bb754edcf0@systech.com>
Date:   Fri, 4 Jun 2021 15:16:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZJeEV-4-fhGAwzqu0e+J3DN9Bm8pDk1s29myUdRF29jUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Exim-Id: 22ada41a-d85b-1cbb-a05c-68bb754edcf0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 6/4/2021 2:39 PM, Luiz Augusto von Dentz wrote:
> Hi Jay,
>
> On Fri, Jun 4, 2021 at 12:14 PM Jay Foster <jay@systech.com> wrote:
>> I am experiencing an odd problem with PAN networking.  I have PAN
>> networking setup in NAP role.  Another machine makes a BNEP connection
>> and performs network activity, then disconnects the BNEP connection.
>> This repeats periodically.  This works just fine, except after a while,
>> the BNEP connection fails with the following in the log.
>>
>> May  4 13:08:02 (none) daemon.debug bluetoothd[1373]:
>> profiles/network/server.c:confirm_event() BNEP: incoming connect from
>> B8:27:EB:E5:35:9B
>> May  4 13:08:03 (none) daemon.err bluetoothd[1373]: Can't add bnep0 to
>> the bridge br1: Too many open files(24)
>>
>> ls /proc/`pidof bluetoothd`/fd shows about 1000 open file descriptors
>> (sockets mostly).  This looks like some kind of resource (file
>> descriptor) leak.
>>
>> Has anyone experienced this before?  I don't know if it is in the
>> bluetoothd application or one if the libraries (glib2, dbus) it links
>> with.  Happens with bluez 5.19 and 5.52.
> That looks like the fd are not released (via close) after they are
> attached to the bridge, you could in theory increase the number of fd
> a process can have in the meantime but we will need to fix this
> problem at some point so please have a issue created in github:
>
> https://github.com/bluez/bluez/
>
Using strace attached to bluetoothd during a BNEP disconnect/reconnect 
sequence, it looks like the socket that the previous BNEP connection was 
accepted on is not closed.  bluetoothd accepts the new connection on a 
new socket (fd count goes up by one) but never closes the previous 
connection socket.  This is unrelated to the bridge.  That just happens 
to be the first function that tries to create a socket after the fd 
limit is reached.
Increasing the fd limits for the process is not an option (It will 
eventually fail).  This is on a resource limited embedded system.



