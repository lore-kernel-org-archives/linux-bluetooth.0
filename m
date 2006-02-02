Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Charles Bueche <charles@bueche.ch>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1138872805.21953.20.camel@bluez.bueche.ch>
Mime-Version: 1.0
Subject: [Bluez-users] udev rules entry for bluetooth mouse
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
Date: Thu, 02 Feb 2006 10:33:25 +0100

Hi,

I would like my new Logitech V270 to exists under /dev/input/v270,
instead of a changing /dev/input/mouseN.

The goal is to be able to use one of the Logitech control utilities,
which need a device to operate on.

% hidd --show
00:07:61:3B:9B:7C Logitech Bluetooth Mouse [046d:b002] connected

% cat /proc/bus/input/devices
...snipp...
I: Bus=0005 Vendor=046d Product=b002 Version=4809
N: Name="Logitech Bluetooth Mouse"
P: Phys=00:10:C6:22:54:AF
H: Handlers=mouse4 event4 
B: EV=f 
B: KEY=ff0000 0 0 0 0 0 0 0 0 
B: REL=103 
B: ABS=300 0 
...snipp...

How does this translate to a udev rule ? My attempts so far are failing.

Charles

-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
