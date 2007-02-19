Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D9E0ED.8090700@yahoo.com.au>
Date: Mon, 19 Feb 2007 18:39:57 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] hid2hci fails: broken pipe
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

My Digitus DN-3008 arrived in the post today, so I tried it out.  I
managed to get it to the same level of workingness as my DBT-120, i.e.,
I can use my bluetooth mighty mouse with the thing, if I first run
"hidd" manually.  The next step is to switch it into HID mode with
hid2hci.  But this is failing with the error message:

aeon:~# hid2hci -1
Switching device 0a12:0001 to HID mode failed (Broken pipe)

Can anyone suggest why this isn't working?  What pipe?  What's it
talking to a pipe for in the first place?

I also tried disabling bluez completely and rebooting, in case some
daemon was lurking around somewhere preventing the device from being
switched out from underneath it.  But that didn't help.

This is under Debian etch.  hid2hci --version doesn't seem to be
accepted, so I can't say what version it is, but bluez-utils is version
3.7-1.

Thanks for any help,
Mat

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
