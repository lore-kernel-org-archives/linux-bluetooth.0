Return-Path: <SRS0=nRr/=NV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A1C43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Nov 2018 18:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2409E20840
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Nov 2018 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUC0vWF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2409E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeKKDtf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:49:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46678 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeKKDtf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Nov 2018 22:49:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so3799780otm.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Nov 2018 10:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLCUksrBKxZCNojQpcNq2IuGNs/ODqtty94ersFz3vs=;
        b=RUC0vWF4+B8mtBlTYt0SviDxQqDL9qUk7Swk4Bpi1nxKupwd9+gcdP59t7HG5Hp+El
         5auYkKGC8KP/xXKwYDRg2TFd88hHHwuFiWPocCafRuhSHt3Htunhdhc6fdE0e/lbpaY1
         DITf1XpirspX53WTqJbIjnW9DgKJ1OOBJQWSoDSeligoz9S51oDqjxuXIKHxm/rt02d5
         sV+g9AeelA9zbEPkahLLRovoMbbXle8r6B/8wJeoVDqxeN8t6F55Z5QHSZWryrQbCZK4
         wnUTsnNpevrnFR8mqPepevJfOsfOfseHvr5QE2Rt3hyHuMjfzNQ2mfof+aMaaFD1jRId
         5RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLCUksrBKxZCNojQpcNq2IuGNs/ODqtty94ersFz3vs=;
        b=AvPSNQ7BMPyec94xTjo+PX68EvUJqosf4LiQLfDfIfuOm17ShFerfvz/qpknwiz0ox
         NvlhxtjlSJ33vaf3ba0jUTHa0mUcnZ41EK099rtAY39D19TM0CfTtvKeNaYXHtOx1pX+
         ONAFxo5QPUmxdOcAQ2b602Tj4meWHD2UNLsfd4tPcsMGNUiDZY40lLJJZ/pp17/VqKem
         jD6vksBFlYBdXt1CBc7d7TOJo5z+pHOkj6sWfCAF6I6S460YgIQKjcoox2CyUQ3JP6h8
         C/G1luUa7OwqmlsiCYFvAdie8XZ8R7JXG5zC+Vec4+d2ppFHQcink2yaSMymVEj56n6K
         CLvQ==
X-Gm-Message-State: AGRZ1gJSb7qzSdpZPevVlYEUiq4dCGXQDgQLn50DVxTCmdunQc7ZdMry
        jHb3ma/be8rxKldfRAjeXWikb3HrnTUeLUZbm63snWRq
X-Google-Smtp-Source: AJdET5dWQ0O2zsMP7dJOnVoKNu08T9arje2QphotwcOvH3/8wGL4A9qbQavYILcqYVLnpa/F+86aY/ZUFNHBbO7wMKw=
X-Received: by 2002:a9d:2831:: with SMTP id m46mr7728576otb.291.1541873024050;
 Sat, 10 Nov 2018 10:03:44 -0800 (PST)
MIME-Version: 1.0
References: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
 <CABatt_zHbVz+cbb6Vig820W5bdXd+Cd1Jjh02MdqnBiX0WQuEg@mail.gmail.com>
In-Reply-To: <CABatt_zHbVz+cbb6Vig820W5bdXd+Cd1Jjh02MdqnBiX0WQuEg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 10 Nov 2018 20:03:30 +0200
Message-ID: <CABBYNZJ0uT-qX2njVfFan2vVWaEveDR+waOC3FSZrTfpaBkHew@mail.gmail.com>
Subject: Re: Operating central and peripheral roles concurrently
To:     mtownsend1973@gmail.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Martin,
On Fri, Nov 9, 2018 at 7:57 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
>
> On Fri, Nov 9, 2018 at 4:32 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
> >
> > Hi,
> >
> > I see someone has already asked this question not long ago but I am
> > seeing the same problem.  I have an embedded platform running 4.9
> > kernel and Bluez 5.50 and the bluetooth device is the BroadCom
> > BCM4343W which supports bluetooth 4.1.
> >
> > I can run the btgatt-server and example-gatt-server fine and connect
> > to it from my phone using nRF and read the relevant attributes.  This
> > I believe is where my device is in the peripheral role.  If I close
> > the GATT server down I can use gatttool to query the characteristics
> > of another GATT server setup on my PC, I think this is then acting as
> > central role.
> >
> > But if I can't do both at the same time, once the GATT server is
> > running and I try and query the other GATT server, I get
> > root@mach-cw-rnet-ppm-1717:~# gatttool -b 5D:3C:72:B5:23:BE -t random
> > --characteristics
> > connect error: Connection refused (111)
> >
> > I've noticed that if I start bluetoothctl whilst the GATT server is
> > running it looks as if it has connected to my phone
> >
> > root@mach-cw-rnet-ppm-1717:~# bluetoothctl
> > Agent registered
> > [LG K8 (2017)]#
> >
> > Maybe this is expected but it does look like it has made a connection
> > back to the phone and I'm wondering if this is stopping it from acting
> > in the central role?
> >
> > Not really knowing much about the bluetooth stack I was wondering if
> > anyone has any pointers on how to debug this or let me know if I'm
> > doing something wrong?  I'm quite comfortable putting debug code into
> > the kernel and/or bluez5 and recompiling to get more information if
> > required.
> >
> > Any help would be greatly appreciated,
> > Martin.
>
> I turned on DEBUG for a few of the hci_.c files and here's the output
> of the failed connect in case it helps
>
> These occur on connect from gatttool:
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: 00:00:00:00:00:00 ->
> 7b:bd:e7:6a:8a:8d
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 9
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: requesting refresh of dst_addr
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 dst 7b:bd:e7:6a:8a:8d
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d (type 1)
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d
> (type 1) auto_connect 5
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hcon 97310400 orig refcnt 0
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 2
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 10
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200b
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: opcode 0x200b status 0x00
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200b
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 1
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 5
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: opcode 0x200c status 0x00
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
>
>
> Then just before Error: connect error: Connection refused (111) many
> seconds later:
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hcon 97310400 state BT_CONNECT
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d (type 1)
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hcon 97310400
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400 chan 97421c80
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 11
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 1
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 5
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: opcode 0x200c status 0x00
> Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c

Not sure if it is exactly the same problem but you can try checking if
the following like is causing the problem:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_event.c#n5075

So we cannot be both slave and central, or at least that is what the
code suggests, though I think we should drop that line and leave the
controller to fail if that is the case.



-- 
Luiz Augusto von Dentz
