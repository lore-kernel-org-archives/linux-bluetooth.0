Return-Path: <cyrus@holtmann.org>
From: Tim Tisdall <tim.tisdall@flemingcollege.ca>
To: Alexander Holler <holler@ahsoftware.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: l2cap sockets not properly multiplexed on ARM
Date: Wed, 30 Oct 2013 13:15:41 +0000
Message-ID: <D9B9EB3A112B8F489DFFA00A6D5C0FE2032408B0@AD-BR-EX-2.adroot.flemingc.local>
References: <D9B9EB3A112B8F489DFFA00A6D5C0FE20324078F@AD-BR-EX-2.adroot.flemingc.local>
 <5270EC62.6070705@ahsoftware.de>,<5270F19A.4030408@ahsoftware.de>
In-Reply-To: <5270F19A.4030408@ahsoftware.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I knew someone would bring that up.  :)  I can't because python only supports sending 2 arguments to bind for that type of socket, and the result is what i want.  I'm using multiple dongles and need to specify which dongle to use for the connection.  However, before I even put that bind statement in there I still had the very same problem, so you can effectively remove that statement and the underlying system will just bind to whichever dongle it pleases and the same problem exists.  Everything works fine on x86 systems and on the ARM architectures the multiplexing goes south.

Also, I'm checking the return codes of everything and there's no errors occurring.  You can even see with the btmon log that the ACL packets are being addressed to the right connection handles but the data is coming out the wrong sockets.  The problem exists on the other end of the socket; the kernel side.

-Tim
________________________________________
From: Alexander Holler [holler@ahsoftware.de]
Sent: October 30, 2013 7:46 AM
To: Tim Tisdall
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: l2cap sockets not properly multiplexed on ARM

Am 30.10.2013 12:24, schrieb Alexander Holler:
> Am 29.10.2013 21:44, schrieb Tim Tisdall:
>
>> L2CAP sockets
>> -------------
>>
>> socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)
>> bind(bdaddr, 0)  // bind to bluetooth address and PSM 0 (Python
>> doesn't support LE directly,
>>                   // but this is enough for binding to the right device
>
> That looks wrong. Try to bind to ATT_CID (4).
>

And don't forget to check the return code of bind (as well as of
setsockopt and other calls).

Regards,

Alexander Holler

