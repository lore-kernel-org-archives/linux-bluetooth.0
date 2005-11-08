Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Message-Id: <20051108201719.07A04A933@innerdot.com>
From: jims@innerdot.com (Jim Spring)
Subject: [Bluez-users] bluez and a Macally BTMicro mouse (2.6.14 kernel)
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
Date: Tue,  8 Nov 2005 12:17:19 -0800 (PST)


I've been scouring around to see if there is a solution or any
additional information regarding the problem, but I am at a 
serious loss.

I've got running on a thinkpad T43 w/ the 2.6.14 kernel.  The
bluetooth adapter is a Zoom USB BT adapter.  I am able to use
hcitool to scan for the mouse and it responds to ings using l2ping.
However, I can't for the life of me figure out how to actually
connect the device for use.  When I attempt to use:

    rfcomm listen 0

I get a "Connection refused message" and the following shows up
on hcidump:

< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 2 status 0
      Connection refused - PSM not supported
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4

I've looked and looked and have not seen a satisfactory (or even
remotey useful) piece of information as to what "Connection refused 
- PSM not supported" means.  Can anyone shed any light on this?  Is
there tweaking needed to the hcid.conf file?  Or what?

>From messages I have seen, this particular mouse works with FreeBSD
and I've had no problems with it under OS X.  Just getting it to
work with my linux system has not been successul.

If there is additional information I can provide, I can get that too.

Thanks
-Jim Spring


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
