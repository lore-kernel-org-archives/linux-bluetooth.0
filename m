Return-Path: <bluez-users-admin@lists.sourceforge.net>
Date: Tue, 12 Oct 2004 14:37:16 -0400 (EDT)
From: "Jay W. Summet" <summetj@cc.gatech.edu>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0410121425040.24690@gaia3.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Socket CF adaptor, limited to 2-3KB/sec RFCOMM PPP connection?
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

Hello,

I am using a Socket Compact Flash Bluetooth adaptor, (dtl1_cs module),
Revision F (8510-00159 F) and am able to successfully connect to my
Sony Ericsson T610 GSM phone over a RFCOMM interface with PPPD.

I'm running a generic Kernel.org 2.6.7 kernel on a Mandrake 10.0
distribution. All of my user space tools came with the Mandrake 10.0
distro, hcitool reports version 2.11, hcidump reports version 1.11.

However, when I connect to my GPRS data provider, I only get 2.1 to 2.5
KBytes/second of transfer. If I use IrDA instead of bluetooth, I can
obtain the typical 5.1 to 5.6 KBytes/second transfer that I am expecting
from GPRS.

My ppp "peers" configuration script is setting the /dev/rfcomm0 tty to
115200, and a friend is using the same scripts, configuration, and phone
with a USB bluetooth adaptor and getting the 5.1 to 5.6 KBytes/second
transfer.

I believe the problem is either with the phone (unlikely) or the Socket CF
card and/or software link to it.

Has anybody else had experience with this issue? Any configuration
settings for debugging I should turn on? (/var/log/messages doesn't show
anything out of the ordinary happening) As I said, everything operates
correctly, it just never gets above 2-2.5KB/second of bandwidth with the
bluetooth link, while it peeks out at 5.6KB/sec on an IrDA link.

Thanks,
Jay



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
