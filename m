Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Geoff Shang <gshang@pacific.net.au>
To: David West <dwest@cs.usyd.edu.au>
cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Connecting from pocket PC iPaq to linux box using
 LAN access profile (DUND)
In-Reply-To: <000301c421f7$4be564e0$0c0a4e81@chimpsky>
Message-ID: <Pine.LNX.4.44.0404150023340.1728-100000@data.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 15 Apr 2004 00:26:25 +1000

On Wed, 14 Apr 2004, David West wrote:

> In my /etc/ppp/peers/dun file, I've given the IP addresses as the ip
> address of eth0 on my linux box, and the IP address I want my iPaq to
> have, is this correct?

No.  Each interface your computer has needs its own address, so using your
eth0 value is no appropriate here.   Use some other address and make sure
it will route properly.

Disclaimer: I've not yet set this up either, but I plan to soon.

Geoff.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
