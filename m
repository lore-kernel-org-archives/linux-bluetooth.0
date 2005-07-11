Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: diNovo/MX900 problem with hidd
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42D12BA1.7040406@phealy.com>
References: <42CF0E8E.4040602@phealy.com>
	 <loom.20050709T112217-147@post.gmane.org> <42CFD081.90800@phealy.com>
	 <42D0329D.7090500@phealy.com> <1120941001.18553.125.camel@pegasus>
	 <42D04E35.7060109@phealy.com> <1120982405.18553.133.camel@pegasus>
	 <42D12BA1.7040406@phealy.com>
Content-Type: text/plain
Message-Id: <1121102507.5934.5.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 11 Jul 2005 19:21:47 +0200

Hi Patrick,

> Sorry, I wasn't clear. I can make a connection, once, for a short time. 
> After I've done so, the connection gets "lost"; it doesn't work until I 
> pull the batteries on the device and reconnect with hidd --search. Could 
> you possibly direct me somewhere to an exact set of steps to try so that 
> I can try exactly what you know should work?

do you have a "hidd --server" running as root? Provide "hcidump -X -V"
output for your problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
