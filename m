Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <320075ff04102014276d37a74a@mail.gmail.com>
From: Nigel Magnay <nigel.magnay@gmail.com>
Reply-To: Nigel Magnay <nigel.magnay@gmail.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Sharing / redirecting a serial port
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
Date: Wed, 20 Oct 2004 22:27:46 +0100

I have got the BlueZ stuff running nicely, and I can use the rfcomm
tools to connect a serial port over bluetooth and stuff, but I can't
figure out how I would do the following.

I have a serial GPS connected to linuxbox on /dev/ttyS0 which has a
bluetooth adapter.
I would like to listen for bluetooth serial connections, and when they
connect, pipe the output to it. In most instances the connecting
device will be a bluetooth iPAQ.

I can't figure out how I can do this from existing tools - is it possible?


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
