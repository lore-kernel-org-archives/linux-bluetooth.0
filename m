Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <495ce9180602080745y146974c4t@mail.gmail.com>
From: Mario Temporary <mario.temporary@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] btsco with an HP embedded bluetooth adapter
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 8 Feb 2006 16:45:49 +0100

Hi all,
I'm trying to use my plantronics Voyager 510 with the embedded
Bluetooth adapter of my HP Pavillion notebook.
I'm using btsco 0.41 e it seems to work with my external USB D-Link
DBT-120 adapter.

With the internal BT adapter I can record my voice but I'm not able to
ear anything (only noise...).
I've read the following on the project page:
-----------------
Output from hciconfig hci0 revision (Run hciconfig as root)
    * If it prints "SCO mapping: HCI" then your adapter should work.
    * If it prints "SCO mapping: PCM" then you might permanently
change the setting using a command like "pskey mapsco 0" using
bluez-utils-cvs but this is at your own risk.
    * If it doesn't print either of those, you probably need a
different bluetooth adapter (preferably "CSR" based)
-----------------
This is the (censored) output on my (internal adapter):
root@legolas:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:C6:XX:XX:XX ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 2.105 / 97

Is this the problem? Should I forget the idea to use it? :(

Thanks,
Mario


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
