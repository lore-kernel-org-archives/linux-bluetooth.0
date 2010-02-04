Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Do not call rfcomm_session_put() due to
 RFCOMM UA on closed socket.
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1265242716-68978-1-git-send-email-npelly@google.com>
References: <1265242716-68978-1-git-send-email-npelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Feb 2010 16:33:03 -0800
Message-ID: <1265243583.31341.149.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> Processing a RFCOMM UA frame when the socket is closed and we were not the
> RFCOMM initiator would cause rfcomm_session_put() to be called twice during
> rfcomm_process_rx(). This would cause a kernel panic in rfcomm_session_close.
> 
> This could be easily reproduced during disconnect with devices such as
> Motorola H270 that send RFCOMM UA followed quickly by L2CAP disconnect request.
> This hcidump for this looks like:
> 
> 2009-09-21 17:22:37.788895 < ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0041 len 4 [psm 3]
>      RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
> 2009-09-21 17:22:37.906204 > HCI Event: Number of Completed Packets (0x13)
> plen 5
>    handle 1 packets 1
> 2009-09-21 17:22:37.933090 > ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0040 len 4 [psm 3]
>      RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
> 2009-09-21 17:22:38.636764 < ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0041 len 4 [psm 3]
>      RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
> 2009-09-21 17:22:38.744125 > HCI Event: Number of Completed Packets (0x13)
> plen 5
>    handle 1 packets 1
> 2009-09-21 17:22:38.763687 > ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0040 len 4 [psm 3]
>      RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
> 2009-09-21 17:22:38.783554 > ACL data: handle 1 flags 0x02 dlen 12
>    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
> 
> Avoid calling rfcomm_session_put() twice by skipping this call
> in rfcomm_recv_ua() if the socket is closed.

patch has been applied. Thanks.

Regards

Marcel


