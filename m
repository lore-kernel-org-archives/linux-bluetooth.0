Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3F65E012.6060009@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Chris Sterling <chris.sterling@blackbearconsulting.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btuart_cs module freezes Zaurus SL5000D after 30
    seconds
References: <1063600741.9649.7.camel@dev.blackbear.com>
In-Reply-To: <1063600741.9649.7.camel@dev.blackbear.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 15 Sep 2003 16:51:46 +0100

Chris Sterling wrote:
> btuart_cs: Unknown HCI packet with type 0xc0 received.
> btuart_cs: Unknown HCI packet with type 0x00 received.
> btuart_cs: Unknown HCI packet with type 0x41 received.
> btuart_cs: Unknown HCI packet with type 0x00 received.
[...]

Looks like your Bluetooth module uses the CSR chip set and is in BCSP
mode. BlueZ hasn't been told this so it's trying to talk to it in H4
mode.

Tell BlueZ to use BCSP and everything should spring in to life (I think
you just pass the bcsp option into hciattach).

	- Steven
-- 



**********************************************************************
The information transmitted is intended only for the person or
entity to which it is addressed and may contain confidential 
and/or privileged material. 
Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by 
persons or entities other than the intended recipient is 
prohibited.  
If you received this in error, please contact the sender and 
delete the material from any computer.
**********************************************************************



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
