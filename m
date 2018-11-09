Return-Path: <SRS0=dX+b=NU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF68C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Nov 2018 17:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E153A20818
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Nov 2018 17:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/3WySBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E153A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeKJDhK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:37:10 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38785 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeKJDhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Nov 2018 22:37:10 -0500
Received: by mail-io1-f65.google.com with SMTP id q18-v6so1875629iod.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Nov 2018 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=s/SwKR/EK9JrZCrzOEqxyxeaHQxK3+rDhd+NmDnZ5h8=;
        b=Q/3WySBw4rSkp75qRwIrEJFdGKbr96rbS6LNb6bjTgAwbWgeiQyjFF3/FmKtprVI5p
         7KPSkmNmlC+zqBnS81ijTlTw5ve12r80aVUWtcg0wTxcIiW7g1I0A4xSR/v2TsFeK4kD
         G780ygrC2pnlWWTOZwWIivQLRwSQVMkV+hJMgCjjHVkhcLViyamMJ2ltCTLuRqPjT9S9
         obvdRv+AVMVUyuHs8wH8egGizmDpzzPqv7UtURcshHlzAuFrjvtTJ7qSYhqm9vJ1G49W
         e+7Aaezj/ZKUUaLe3N+ioRmi3QsRMz5qcfoCJ6vkWqfWTkChM1+JmUMJvZ1L+5uP8TRO
         TRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=s/SwKR/EK9JrZCrzOEqxyxeaHQxK3+rDhd+NmDnZ5h8=;
        b=dI6vKe1/3OgSd2j+3iiuajGgL+fz87Ip6qjIUKDmLfFNq7J1M29OsAxj5v1811ibjR
         X6PqMB8p0IMoN9ZL9LZRDU2ttC/q5Agn3yspP60Eha+kit9McCBcfbMy7LXRLydMn7Ys
         9KFdtKK6Tfw0UMmTS5P9IKh4+xZNLtLDqXm5fmtu6Ywqr1KuKc2T1l2EHMgVkdjO9I4E
         sXQMKePzznbg6whNWvfr8FAkvOe6Z6MpjIHT2lMO5+T5+/Y1vRF7Ai92qfwna/yV/W2q
         yZwrNlaCda1uX/OpnuqDAy20xi4Br0P9F+lQLJMD6admlgpnW+8jkW5nHJmTipxDwGL5
         3lkw==
X-Gm-Message-State: AGRZ1gJLtx162bI6aJOtjH2cuJQdToSBpodQJaoIWbLnLYEuNVovZTwZ
        ekVMQbPZZImx9HQ1k7ZvsXaCoXrh+bMviKF5nUGJhoGG
X-Google-Smtp-Source: AJdET5e7LHa0Cri0FOOynpSsPfRh1HJLvub7OL3qSWJurVqNsRzFT43M4eyLQBKW57v1frTI4QfQdH6/V9quFwdgOfg=
X-Received: by 2002:a6b:8d44:: with SMTP id p65-v6mr7317001iod.222.1541786130623;
 Fri, 09 Nov 2018 09:55:30 -0800 (PST)
MIME-Version: 1.0
References: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
In-Reply-To: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Fri, 9 Nov 2018 17:55:19 +0000
Message-ID: <CABatt_zHbVz+cbb6Vig820W5bdXd+Cd1Jjh02MdqnBiX0WQuEg@mail.gmail.com>
Subject: Re: Operating central and peripheral roles concurrently
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Nov 9, 2018 at 4:32 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
>
> Hi,
>
> I see someone has already asked this question not long ago but I am
> seeing the same problem.  I have an embedded platform running 4.9
> kernel and Bluez 5.50 and the bluetooth device is the BroadCom
> BCM4343W which supports bluetooth 4.1.
>
> I can run the btgatt-server and example-gatt-server fine and connect
> to it from my phone using nRF and read the relevant attributes.  This
> I believe is where my device is in the peripheral role.  If I close
> the GATT server down I can use gatttool to query the characteristics
> of another GATT server setup on my PC, I think this is then acting as
> central role.
>
> But if I can't do both at the same time, once the GATT server is
> running and I try and query the other GATT server, I get
> root@mach-cw-rnet-ppm-1717:~# gatttool -b 5D:3C:72:B5:23:BE -t random
> --characteristics
> connect error: Connection refused (111)
>
> I've noticed that if I start bluetoothctl whilst the GATT server is
> running it looks as if it has connected to my phone
>
> root@mach-cw-rnet-ppm-1717:~# bluetoothctl
> Agent registered
> [LG K8 (2017)]#
>
> Maybe this is expected but it does look like it has made a connection
> back to the phone and I'm wondering if this is stopping it from acting
> in the central role?
>
> Not really knowing much about the bluetooth stack I was wondering if
> anyone has any pointers on how to debug this or let me know if I'm
> doing something wrong?  I'm quite comfortable putting debug code into
> the kernel and/or bluez5 and recompiling to get more information if
> required.
>
> Any help would be greatly appreciated,
> Martin.

I turned on DEBUG for a few of the hci_.c files and here's the output
of the failed connect in case it helps

These occur on connect from gatttool:
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: 00:00:00:00:00:00 ->
7b:bd:e7:6a:8a:8d
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 9
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: requesting refresh of dst_addr
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 dst 7b:bd:e7:6a:8a:8d
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d (type 1)
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d
(type 1) auto_connect 5
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hcon 97310400 orig refcnt 0
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 2
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 10
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200b
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: opcode 0x200b status 0x00
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200b
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 1
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 5
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: opcode 0x200c status 0x00
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet


Then just before Error: connect error: Connection refused (111) many
seconds later:
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hcon 97310400 state BT_CONNECT
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d (type 1)
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hcon 97310400
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400 chan 97421c80
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 11
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 1
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 5
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: opcode 0x200c status 0x00
Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c

Regards, Martin.
