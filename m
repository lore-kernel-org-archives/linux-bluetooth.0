Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Zia Syed <zs@comp.rgu.ac.uk>
Reply-To: zs@comp.rgu.ac.uk
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1074894810.6320.16.camel@zs>
Mime-Version: 1.0
Subject: [Bluez-users] PAN and Device Lookup Problem- Still no luck :(
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
Date: Fri, 23 Jan 2004 21:53:30 +0000

Well guys!, after whole day effort, i still couldn't manage to get PAND
and device discovery to work together. I'm using Zaurus SL5500 with
kernel 2.4.18-rmk7-pxa3-embedix. As i said before, stack works fine
until when I connect to NAP, after that I can't do device lookup. Only
after killing the PANU session, i can do the "hcitool scan". Otherwise
it gives me error saying "Inquiry failed: Device or resource busy".

I'm really stuck now as my application which was working till last night
but now with this problem I can't go any further. My application need
both PAN (for fetching web-contents) and device lookup for discovering
nearby devices. 

What do you guys suggest I should do? I've tried installing different
versions of bluez packages (from sf.net and from community.zaurus.com). 

I'm using Socket CF (G Series) Bluetooth card. Is there anyone out there
using the same device settings with Bluez?

Please advice!

Thanks
Zia



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
