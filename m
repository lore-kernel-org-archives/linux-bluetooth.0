Return-Path: <cyrus@holtmann.org>
From: iemai@softhome.net
To: bluez-devel@lists.sourceforge.net
Date: Tue, 29 Jan 2008 13:48:11 -0700
Mime-Version: 1.0
Message-ID: <courier.479F910B.00002E18@softhome.net>
Subject: [Bluez-devel] PS3Remote patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi! I'tried the patches on last cvs checkout and compiled libs and utils, 
but after restarting bluetooth services and pressing the remote buttons 
nothing happens.
The remote is paired and works with some python script from 
http://tinyurl.com/36kfdz (Thanks Jonas Borgstrom).
In /proc/bus/input/devices i have:
I: Bus=0005 Vendor=054c Product=0306 Version=0100
N: Name="Sony Computer Entertainment Inc BD Remote Control"
P: Phys=XX:XX:XX:XX:XX:XX
S: Sysfs=/class/input/input6
U: Uniq=YY:YY:YY:YY:YY:YY
H: Handlers=event6
B: EV=1
I tried also cat /dev/input/event6 but nothing happens. 

Can someone help me understand it? Am I missing something?
Thanks. 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
