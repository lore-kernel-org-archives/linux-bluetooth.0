Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv4 0/2] Fix kernel crash in rfcomm/l2cap
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1288780365-32099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1288780365-32099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Nov 2010 14:36:36 +0900
Message-ID: <1289367396.9615.238.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Yet another version of patches fixing kernel crash in RFCOMM / L2CAP.
> *v4: taken Gustavo comments about timer HZ -> HZ/5
> 
> Do not delete l2cap channel and socket sk when sk is owned by user.
> To delete l2cap channel standard timer is used.
> 
> lock_sock and release_sock do not hold a normal spinlock directly but 
> instead hold the owner field. This means bh_lock_sock can still execute
> even if the socket is "locked". More info can be found here:
> http://www.linuxfoundation.org/collaborate/workgroups/networking/socketlocks
> 
> When sending following sequence:
> ...
> No.     Time        Source                Destination           Protocol Info
>     89 1.951202            RFCOMM   Rcvd DISC DLCI=20
>     90 1.951324            RFCOMM   Sent UA DLCI=20
>     91 1.959381            HCI_EVT   Number of Completed Packets
>     92 1.966461            RFCOMM   Rcvd DISC DLCI=0
>     93 1.966492            L2CAP    Rcvd Disconnect Request
>     94 1.972595            L2CAP    Sent Disconnect Response
> 
> ...
> 
> krfcommd kernel thread is preempted with l2cap tasklet which remove l2cap_conn
> (L2CAP connection handler structure). Then rfcomm thread tries to send RFCOMM
> UA which is reply to RFCOMM DISC and when de-referencing l2cap_conn crash
> happens.

so I assume you have tested this extensively with various RFCOMM corner
cases like incoming RFCOMM. Since a lot of profiles require proper
disconnects and we have to ensure that our reference counting is
correct.

Other then that it seems fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


