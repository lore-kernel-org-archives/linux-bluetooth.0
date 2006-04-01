Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Geoff Shang <geoff@hitsandpieces.net>
To: Linux for blind general discussion <blinux-list@redhat.com>
Cc: general@lists.humbug.org.au, bluez-users@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0603181246420.738@data.home>
Message-ID: <Pine.LNX.4.64.0604020439250.738@data.home>
References: <Pine.LNX.4.64.0603181246420.738@data.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] Solved (was Re: Bluetooth: pand: Connection failed. File exists(17))
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
Date: Sun, 2 Apr 2006 04:45:27 +1000 (EST)

Geoff Shang wrote:

> When I try to connect from the panu, I get the following:
>
> Mar 10 18:35:46 data pand[16077]: Connection failed. File exists(17)

This was a case of brain failure on my part.  I failed to understand that 
pand merely instructs the kernel and the hardware, rather than actually 
maintain the connections.  This is unlike PPPd, for example.  So a PAN 
connection will remain even if PANd is shut down.

The reason why I was getting the error is that I was trying to create a 
connection that already existed.  I was able to verify this with "pand -l".

I admit that the somewhat unhelpful error message had me chasing red 
herrings for awhile.

Thanks to those of you who, through your suggestions, nudged me in the 
right direction.

Geoff.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
