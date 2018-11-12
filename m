Return-Path: <SRS0=dtqE=NX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D2DC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C42223D0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Nov 2018 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYP/N9FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C42223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeKLXpx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:45:53 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:33209 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeKLXpx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Nov 2018 18:45:53 -0500
Received: by mail-it1-f174.google.com with SMTP id p11-v6so10787488itf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Nov 2018 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Yu8yEKQ5qhnjUwRlF8D3fUiYCVJaUit0Bdo4AfGWOU=;
        b=cYP/N9FCBA/S4UCBWYtsB5zr7Mk0nfFDroEolb082Vw/uk/3wtu92SpCiuGyFGMm1i
         oozvjcpHL2qXJV+HqMamS3rNLX1kRw7RaKkKwOFN5yh5PpSd/tvE5UJwWB6DdKRkkufA
         +bAN9KoKgLmkYQnU9KkAUGYWPC/fJJOd+vKN4CBgloGI9XoB6eOu6688kSeskpBSj+7y
         38fD90umz7woWucj9HQZDD40vSqsH5sRJpAXCFTAKackhKwLnx9f0NbNm6HCSU34g1WD
         d8v2228qwpXcVqTDJZWJ/1bj8+6Id0wxt5+Oig8UD7sf5P9BFsMJCWA/5GgE81ZNL7Ja
         OnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Yu8yEKQ5qhnjUwRlF8D3fUiYCVJaUit0Bdo4AfGWOU=;
        b=HmlBuGkA5UngMOkPkVWEbmyuKMfOiKh33vpTnmc8UfUXuJiV87yW3NUrH957aG1dUe
         x073DKPK32TJkRZzPPaG4hD6/ICU4Mi1JK3jdgMVigrDm+zFgtL8NRiKyxqE/tfqI+8d
         hmsVYMOwpztaXugjiQkjEwHjVADlvjYNterOpJd08u3iXSMJQLny98FtqXE085N49Ng5
         5Je/eGBOl17L1yoa3PzoV5G38YqADI5tgVvStsVEM41Op92q+7kgK3/VyjKmxYBrHNha
         OYMP4+FqtHut+n3R+9H9mNuvKe6h5EtLSqccMoCYvCbdfemjhVbP78olDcNEyEJ/2KOu
         +oVQ==
X-Gm-Message-State: AGRZ1gI/4+g7ZcW+u/CV83hQwBGhhaRNB3J+mzTVPa+SjU4x4bvrHXzV
        0F03iE+xEhhisBUFKgfLApS6121e6745C71+dVPHVZMr
X-Google-Smtp-Source: AJdET5eF1fq1Ez6x4ugkJ5LCXBMbOf7HEsbHCsQYFdQNtCQeHHqFZogAwzBnresDeSC1cWCUxL9EN1iAax1RHWCF6Wo=
X-Received: by 2002:a05:660c:ad2:: with SMTP id k18mr3989176itl.116.1542030749519;
 Mon, 12 Nov 2018 05:52:29 -0800 (PST)
MIME-Version: 1.0
References: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
 <CABatt_zHbVz+cbb6Vig820W5bdXd+Cd1Jjh02MdqnBiX0WQuEg@mail.gmail.com>
 <CABBYNZJ0uT-qX2njVfFan2vVWaEveDR+waOC3FSZrTfpaBkHew@mail.gmail.com> <CABatt_wSMSiW+Fmi5cccAnejMbAAHdNWb-jW0qLcijtdWETHzw@mail.gmail.com>
In-Reply-To: <CABatt_wSMSiW+Fmi5cccAnejMbAAHdNWb-jW0qLcijtdWETHzw@mail.gmail.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Mon, 12 Nov 2018 13:52:17 +0000
Message-ID: <CABatt_yhozRuFjtSsmvHJNyFoFR7tstfuZp9jPdcZpxuCx7z=A@mail.gmail.com>
Subject: Re: Operating central and peripheral roles concurrently
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Sat, Nov 10, 2018 at 6:29 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
>
> Hi,
> On Sat, Nov 10, 2018 at 6:03 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Martin,
> > On Fri, Nov 9, 2018 at 7:57 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
> > >
> > > On Fri, Nov 9, 2018 at 4:32 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I see someone has already asked this question not long ago but I am
> > > > seeing the same problem.  I have an embedded platform running 4.9
> > > > kernel and Bluez 5.50 and the bluetooth device is the BroadCom
> > > > BCM4343W which supports bluetooth 4.1.
> > > >
> > > > I can run the btgatt-server and example-gatt-server fine and connect
> > > > to it from my phone using nRF and read the relevant attributes.  This
> > > > I believe is where my device is in the peripheral role.  If I close
> > > > the GATT server down I can use gatttool to query the characteristics
> > > > of another GATT server setup on my PC, I think this is then acting as
> > > > central role.
> > > >
> > > > But if I can't do both at the same time, once the GATT server is
> > > > running and I try and query the other GATT server, I get
> > > > root@mach-cw-rnet-ppm-1717:~# gatttool -b 5D:3C:72:B5:23:BE -t random
> > > > --characteristics
> > > > connect error: Connection refused (111)
> > > >
> > > > I've noticed that if I start bluetoothctl whilst the GATT server is
> > > > running it looks as if it has connected to my phone
> > > >
> > > > root@mach-cw-rnet-ppm-1717:~# bluetoothctl
> > > > Agent registered
> > > > [LG K8 (2017)]#
> > > >
> > > > Maybe this is expected but it does look like it has made a connection
> > > > back to the phone and I'm wondering if this is stopping it from acting
> > > > in the central role?
> > > >
> > > > Not really knowing much about the bluetooth stack I was wondering if
> > > > anyone has any pointers on how to debug this or let me know if I'm
> > > > doing something wrong?  I'm quite comfortable putting debug code into
> > > > the kernel and/or bluez5 and recompiling to get more information if
> > > > required.
> > > >
> > > > Any help would be greatly appreciated,
> > > > Martin.
> > >
> > > I turned on DEBUG for a few of the hci_.c files and here's the output
> > > of the failed connect in case it helps
> > >
> > > These occur on connect from gatttool:
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: 00:00:00:00:00:00 ->
> > > 7b:bd:e7:6a:8a:8d
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 9
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: requesting refresh of dst_addr
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 dst 7b:bd:e7:6a:8a:8d
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d (type 1)
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d
> > > (type 1) auto_connect 5
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hcon 97310400 orig refcnt 0
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 2
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 10
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200b
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: opcode 0x200b status 0x00
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200b
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 1
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 5
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: opcode 0x200c status 0x00
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0
> > > Nov 09 08:03:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> > >
> > >
> > > Then just before Error: connect error: Connection refused (111) many
> > > seconds later:
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hcon 97310400 state BT_CONNECT
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: addr 7b:bd:e7:6a:8a:8d (type 1)
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hcon 97310400
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 hcon 97310400 chan 97421c80
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 11
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 cmd_cnt 1 cmd queued 1
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 type 1 len 5
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 orig refcnt 10
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: opcode 0x200c status 0x00
> > > Nov 09 08:03:41 mach-cw-rnet-ppm-1717 kernel: hci0 opcode 0x200c
> >
> > Not sure if it is exactly the same problem but you can try checking if
> > the following like is causing the problem:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_event.c#n5075
> >
> > So we cannot be both slave and central, or at least that is what the
> > code suggests, though I think we should drop that line and leave the
> > controller to fail if that is the case.
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks for replying, just to confirm that this maybe the code to take a look at
>
> /* Most controller will fail if we try to create new connections
> * while we have an existing one in slave role.
> */
> if (hdev->conn_hash.le_num_slave > 0)
> return NULL;
>
> If so, I'll put some debug code around it and try disabling it to see
> if it makes a difference.
>
> Regards, Martin.

I commented out those lines and put a debug print in to see if the
function was called and the function was only called when I initiated
a lescan to get the address of the GATT server I wanted to connect to
Nov 09 07:57:00 mach-cw-rnet-ppm-1717 kernel: hci0 Event packet
Nov 09 07:57:00 mach-cw-rnet-ppm-1717 kernel: check_pending_le_conn:
le_num_slave = 1

But when I tried to make the connection this function wasn't called at
all and it still failed even with the "if
(hdev->conn_hash.le_num_slave > 0) return NULL" commented out.

I'm starting to think that the chip doesn't support dual roles.  With
all the debug turned on the first line I see when the connection fails
is
Nov 09 07:56:20 mach-cw-rnet-ppm-1717 kernel: hci_conn_timeout: hcon
972b0400 state BT_CONNECT
which seems to suggest it's timed out waiting from some response from
the HCI firmware on the bluetooth device? or am I wrong with this
assumption?

Where in the code could I put some debug to see that the connection
request is being passed to the HCI firmware layer?

any help greatly appreciated.
