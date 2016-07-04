Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] af_bluetooth: Fix recvmsg return value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1467043273-3781-1-git-send-email-denkenz@gmail.com>
Date: Mon, 4 Jul 2016 20:10:05 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C75115E8-98E8-4CFF-9DB1-7AED652E27CF@holtmann.org>
References: <1467043273-3781-1-git-send-email-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

> If recvmsg is called with a destination buffer that is too small to
> receive the contents of skb in its entirety, the return value from
> recvmsg was inconsistent with common SOCK_SEQPACKET or SOCK_DGRAM
> semantics.
> 
> If destination buffer provided by userspace is too small (e.g. len <
> copied), then MSG_TRUNC flag is set and copied is returned.  Instead, it
> should return the length of the message, which is consistent with how
> other datagram based sockets act.  Quoting 'man recv':
> 
> "All  three calls return the length of the message on successful comple‐
> tion.  If a message is too long to fit in the supplied  buffer,  excess
> bytes  may  be discarded depending on the type of socket the message is
> received from."
> 
> and
> 
> "MSG_TRUNC (since Linux 2.2)
> 
>    For   raw   (AF_PACKET),   Internet   datagram   (since    Linux
>    2.4.27/2.6.8),  netlink  (since Linux 2.6.22), and UNIX datagram
>    (since Linux 3.4) sockets: return the real length of the packet
>    or datagram, even when it was longer than the passed buffer."
> 
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
> ---
> net/bluetooth/af_bluetooth.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

