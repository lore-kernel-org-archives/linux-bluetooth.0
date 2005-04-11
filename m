Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM non-blocking support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <000901c53e1a$d8e07e30$0201a8c0@NBVICTOR>
References: <42582BE5.2050407@xmission.com>
	 <000901c53e1a$d8e07e30$0201a8c0@NBVICTOR>
Content-Type: text/plain
Message-Id: <1113224195.9655.37.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Apr 2005 14:56:35 +0200

Hi Victor,

> This was already discussed a year ago:
> question:
> http://sourceforge.net/mailarchive/message.php?msg_id=8643791
> reply:
> http://sourceforge.net/mailarchive/message.php?msg_id=8643793
> 
> I have exactly the same problem, I guess.
> 
> Instead of EINPROGRESS non-blocking connect() returns EAGAIN (Resource 
> temporarily unavailable). The rest seem to be OK (see the source). Select 
> waits till the connection is established or an error occurs (at least as it 
> looks from hcidump log).

I just checked the code and the problem is the bt_sock_wait_state()
function. In the case of O_NONBLOCK we give it a timeout of 0 and this
means that it will exit with EAGAIN if sk->sk_state != state. This
actually means that also L2CAP is not working correct in the non
blocking case. How do we should fix this? The easiest way seems to add
another check to bt_sock_wait_state() before entering the while loop:

	if (!timeo && sk->sk_state != state)
		return -EINPROGRESS;

Another way is to add a flags parameter to this function or deal with it
in the L2CAP/RFCOMM connect functions.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
