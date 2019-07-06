Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D4C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0195214AF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 10:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0x/hB+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGFKMn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:12:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33436 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfGFKMn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 06:12:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so11456976ljg.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jul 2019 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJfTz4dHdknYsWh4jMpsE+k7rWLq7xLvyt8B6tmARmM=;
        b=m0x/hB+0vRsJxFfQt8SACrtrBPk0gvgcjMPcEHgffmNqQzCpLBW3UdLPRZBXoMjush
         PTGINj9EQgZ8yvqyJEVmQp4/4/6Aha/blFfsKJPw3IV5Fx7/AqGmJ3uBo3Lmddl5K2ka
         yaPqJRofENmRKueYxND25Bt9VxhmCc5CSCGbysQfkwrE7GRn3G2/ljEfJo6sZLHuZcVf
         wcDHoo46r99CXAuxZqAwOaCGG8yqKkn+PhtmjvBaHsIp7Cj+TuOzfu+1BchgdJVF8DZk
         6CyrWQxFjPV9O22NJhEtR3SFAEsmQY7kTAARabTS3YvcyY7UULwQb8mBwitIqaTzp9Vw
         1LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJfTz4dHdknYsWh4jMpsE+k7rWLq7xLvyt8B6tmARmM=;
        b=oCMXQMJENXqk/PpBPUPQ8+oPYkursvnXIL59GYWs6IDZcCc6bGZSyvto1ULgRncRWT
         puZYxfOpGXX82wdUOXKn1nY91dhi0f2+tEVd27ux0RXCnsaake3ijCdKKZubMrzJ8NTR
         oVbxZZdX/oNJiFCNGd7AJNqY2nH/NRGM6+f6AjjfYEiRuY3TMjyl0aB234A1qZNH458b
         t/s8TqvsVayusXs9KSpzudBgtE4UImYne50KrFP6ow6ChV8lUUfBvye8b4fbOUI57IJU
         lDBdA3Hf18jqbEgQlgTOFaK3mDO2L9qnncUAAywd8KaenjR8yCvIywmZyVBhpcNkytda
         snuQ==
X-Gm-Message-State: APjAAAU/f7JUQ9FN8lhNTUUUpDreHfDCkJtgtOXe4lGb/WgJwa4VQ/br
        7KVxHX4wfu1ED4b6Vq7CTkI=
X-Google-Smtp-Source: APXvYqwUZPAqLuQibOCPWFTr7WAeWeECgqzMX4A+jXVLZ2uCepxguqup95mN5qpcCTiRf6wuq14Ilg==
X-Received: by 2002:a2e:85d4:: with SMTP id h20mr4631005ljj.142.1562407960926;
        Sat, 06 Jul 2019 03:12:40 -0700 (PDT)
Received: from ubuntu-18-04-beta2 (85-76-47-224-nat.elisa-mobile.fi. [85.76.47.224])
        by smtp.gmail.com with ESMTPSA id b6sm1956433lfa.54.2019.07.06.03.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Jul 2019 03:12:40 -0700 (PDT)
Date:   Sat, 6 Jul 2019 10:07:03 +0000
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check state in l2cap_disconnect_rsp
Message-ID: <20190706100703.GB4223@ubuntu-18-04-beta2>
References: <20190521100722.GA15063@makarhum-Latitude-E5440>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521100722.GA15063@makarhum-Latitude-E5440>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, May 21, 2019 at 01:07:22PM +0300, Matias Karhumaa wrote:
Hi Marcel and Johan,

> Because of both sides doing L2CAP disconnection at the same time, it
> was possible to receive L2CAP Disconnection Response with CID that was
> already freed. That caused problems if CID was already reused and L2CAP
> Connection Request with same CID was sent out. Before this patch kernel
> deleted channel context regardless of the state of the channel.
> 
> Example where leftover Disconnection Response (frame #402) causes local
> device to delete L2CAP channel which was not yet connected. This in
> turn confuses remote device's stack because same CID is re-used without
> properly disconnecting.
> 
> Btmon capture before patch:
> ** snip **
> > ACL Data RX: Handle 43 flags 0x02 dlen 8                #394 [hci1] 10.748949
>       Channel: 65 len 4 [PSM 3 mode 0] {chan 2}
>       RFCOMM: Disconnect (DISC) (0x43)
>          Address: 0x03 cr 1 dlci 0x00
>          Control: 0x53 poll/final 1
>          Length: 0
>          FCS: 0xfd
> < ACL Data TX: Handle 43 flags 0x00 dlen 8                #395 [hci1] 10.749062
>       Channel: 65 len 4 [PSM 3 mode 0] {chan 2}
>       RFCOMM: Unnumbered Ack (UA) (0x63)
>          Address: 0x03 cr 1 dlci 0x00
>          Control: 0x73 poll/final 1
>          Length: 0
>          FCS: 0xd7
> < ACL Data TX: Handle 43 flags 0x00 dlen 12               #396 [hci1] 10.749073
>       L2CAP: Disconnection Request (0x06) ident 17 len 4
>         Destination CID: 65
>         Source CID: 65
> > HCI Event: Number of Completed Packets (0x13) plen 5    #397 [hci1] 10.752391
>         Num handles: 1
>         Handle: 43
>         Count: 1
> > HCI Event: Number of Completed Packets (0x13) plen 5    #398 [hci1] 10.753394
>         Num handles: 1
>         Handle: 43
>         Count: 1
> > ACL Data RX: Handle 43 flags 0x02 dlen 12               #399 [hci1] 10.756499
>       L2CAP: Disconnection Request (0x06) ident 26 len 4
>         Destination CID: 65
>         Source CID: 65
> < ACL Data TX: Handle 43 flags 0x00 dlen 12               #400 [hci1] 10.756548
>       L2CAP: Disconnection Response (0x07) ident 26 len 4
>         Destination CID: 65
>         Source CID: 65
> < ACL Data TX: Handle 43 flags 0x00 dlen 12               #401 [hci1] 10.757459
>       L2CAP: Connection Request (0x02) ident 18 len 4
>         PSM: 1 (0x0001)
>         Source CID: 65
> > ACL Data RX: Handle 43 flags 0x02 dlen 12               #402 [hci1] 10.759148
>       L2CAP: Disconnection Response (0x07) ident 17 len 4
>         Destination CID: 65
>         Source CID: 65
> = bluetoothd: 00:1E:AB:4C:56:54: error updating services: Input/o..   10.759447
> > HCI Event: Number of Completed Packets (0x13) plen 5    #403 [hci1] 10.759386
>         Num handles: 1
>         Handle: 43
>         Count: 1
> > ACL Data RX: Handle 43 flags 0x02 dlen 12               #404 [hci1] 10.760397
>       L2CAP: Connection Request (0x02) ident 27 len 4
>         PSM: 3 (0x0003)
>         Source CID: 65
> < ACL Data TX: Handle 43 flags 0x00 dlen 16               #405 [hci1] 10.760441
>       L2CAP: Connection Response (0x03) ident 27 len 8
>         Destination CID: 65
>         Source CID: 65
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> < ACL Data TX: Handle 43 flags 0x00 dlen 27               #406 [hci1] 10.760449
>       L2CAP: Configure Request (0x04) ident 19 len 19
>         Destination CID: 65
>         Flags: 0x0000
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 1013
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
> > HCI Event: Number of Completed Packets (0x13) plen 5    #407 [hci1] 10.761399
>         Num handles: 1
>         Handle: 43
>         Count: 1
> > ACL Data RX: Handle 43 flags 0x02 dlen 16               #408 [hci1] 10.762942
>       L2CAP: Connection Response (0x03) ident 18 len 8
>         Destination CID: 66
>         Source CID: 65
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> *snip*
> 
> Similar case after the patch:
> *snip*
> > ACL Data RX: Handle 43 flags 0x02 dlen 8            #22702 [hci0] 1664.411056
>       Channel: 65 len 4 [PSM 3 mode 0] {chan 3}
>       RFCOMM: Disconnect (DISC) (0x43)
>          Address: 0x03 cr 1 dlci 0x00
>          Control: 0x53 poll/final 1
>          Length: 0
>          FCS: 0xfd
> < ACL Data TX: Handle 43 flags 0x00 dlen 8            #22703 [hci0] 1664.411136
>       Channel: 65 len 4 [PSM 3 mode 0] {chan 3}
>       RFCOMM: Unnumbered Ack (UA) (0x63)
>          Address: 0x03 cr 1 dlci 0x00
>          Control: 0x73 poll/final 1
>          Length: 0
>          FCS: 0xd7
> < ACL Data TX: Handle 43 flags 0x00 dlen 12           #22704 [hci0] 1664.411143
>       L2CAP: Disconnection Request (0x06) ident 11 len 4
>         Destination CID: 65
>         Source CID: 65
> > HCI Event: Number of Completed Pac.. (0x13) plen 5  #22705 [hci0] 1664.414009
>         Num handles: 1
>         Handle: 43
>         Count: 1
> > HCI Event: Number of Completed Pac.. (0x13) plen 5  #22706 [hci0] 1664.415007
>         Num handles: 1
>         Handle: 43
>         Count: 1
> > ACL Data RX: Handle 43 flags 0x02 dlen 12           #22707 [hci0] 1664.418674
>       L2CAP: Disconnection Request (0x06) ident 17 len 4
>         Destination CID: 65
>         Source CID: 65
> < ACL Data TX: Handle 43 flags 0x00 dlen 12           #22708 [hci0] 1664.418762
>       L2CAP: Disconnection Response (0x07) ident 17 len 4
>         Destination CID: 65
>         Source CID: 65
> < ACL Data TX: Handle 43 flags 0x00 dlen 12           #22709 [hci0] 1664.421073
>       L2CAP: Connection Request (0x02) ident 12 len 4
>         PSM: 1 (0x0001)
>         Source CID: 65
> > ACL Data RX: Handle 43 flags 0x02 dlen 12           #22710 [hci0] 1664.421371
>       L2CAP: Disconnection Response (0x07) ident 11 len 4
>         Destination CID: 65
>         Source CID: 65
> > HCI Event: Number of Completed Pac.. (0x13) plen 5  #22711 [hci0] 1664.424082
>         Num handles: 1
>         Handle: 43
>         Count: 1
> > HCI Event: Number of Completed Pac.. (0x13) plen 5  #22712 [hci0] 1664.425040
>         Num handles: 1
>         Handle: 43
>         Count: 1
> > ACL Data RX: Handle 43 flags 0x02 dlen 12           #22713 [hci0] 1664.426103
>       L2CAP: Connection Request (0x02) ident 18 len 4
>         PSM: 3 (0x0003)
>         Source CID: 65
> < ACL Data TX: Handle 43 flags 0x00 dlen 16           #22714 [hci0] 1664.426186
>       L2CAP: Connection Response (0x03) ident 18 len 8
>         Destination CID: 66
>         Source CID: 65
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> < ACL Data TX: Handle 43 flags 0x00 dlen 27           #22715 [hci0] 1664.426196
>       L2CAP: Configure Request (0x04) ident 13 len 19
>         Destination CID: 65
>         Flags: 0x0000
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 1013
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
> > ACL Data RX: Handle 43 flags 0x02 dlen 16           #22716 [hci0] 1664.428804
>       L2CAP: Connection Response (0x03) ident 12 len 8
>         Destination CID: 66
>         Source CID: 65
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> *snip*
> 
> Fix is to check that channel is in state BT_DISCONN before deleting the
> channel.
> 
> This bug was found while fuzzing Bluez's OBEX implementation using
> Synopsys Defensics.
> 
> Reported-by: Matti Kamunen <matti.kamunen@synopsys.com>
> Reported-by: Ari Timonen <ari.timonen@synopsys.com>
> Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b53acd6..25e8859 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4371,6 +4371,12 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
>  
>  	l2cap_chan_lock(chan);
>  
> +	if (chan->state != BT_DISCONN) {
> +		l2cap_chan_unlock(chan);
> +		mutex_unlock(&conn->chan_lock);
> +		return 0;
> +	}
> +
>  	l2cap_chan_hold(chan);
>  	l2cap_chan_del(chan, 0);
>  
> -- 
> 2.7.4
>

Do you have any comments on this patch? This fixes real problem which may cause
very strange symptoms if happening in production.

Best regards,
Matias Karhumaa
