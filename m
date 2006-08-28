Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-Id: <44F33232.8030505@arcor.de>
Date: Mon, 28 Aug 2006 20:13:06 +0200
From: Simon Siemens <Simon.Siemens@arcor.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Asynchronous inquiry
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

Is there a way, to do an asynchronous inquiry. I only know the
hci_inquiry function, which gives you a complete list of the found
devices. For two projects (a GUI and a research project) I would like to
present each device as soon as it has been found. Is it possible to have
some kind of notification each time a device sends the inquiry response
message? (Something like multi-processing / multi-threading)?

Currently I work with a maximum response count of 1 in hci_inquiry, but
this is not helpful in any case.

Thanks for your help,

Simon

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
