Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jason Van Patten <jvp@lateapex.net>
Message-Id: <200309131519.h8DFJqD07132@localhost.lateapex.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
To: bluez-users@lists.sourceforge.net
Reply-To: jvp@lateapex.net
In-Reply-To: <1063441693.19165.31.camel@h9n1fls20o980.bredband.comhem.se> from "Fredrik Noring" at Sep 13, 2003 10:28:13 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sat, 13 Sep 2003 11:19:52 -0400 (EDT)

At Sat Sep 13 04:28:13 2003, Fredrik Noring wrote:
> I don't know if it's possible to get jpilot or gnome-pilot running with
> Bluetooth, but pilot-xfer works atleast:
> 
>      1) Make your Palm able to connect to the computer using 
>         PPP over Bluetooth. (This is somewhat complicated - search for
>         "linux bluetooth ppp tungsten" or similar to get some howtos.)
> 
>      2) Run "pilot-xfer -p net:any -s ." etc. 

Thanks for the pointer, that seems to have done the trick.  Jpilot will use
net:any as a device to sync the Palm after the PPP-over-BT is configured.

It's a few extra steps than I wanted to take, but oh well.  It works.

Thanks!

jas
-- 
Jason Van Patten
AOL IM: Jason VP 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
