Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Message-ID: <001601c48fa7$38cce900$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-devel] Rfcomm use count
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 31 Aug 2004 15:09:44 -0700

Hi Marcel,

Any suggestions you have regarding the following would be greatly
appreciated.

I have a server program which does the following:

1. Intializes and attaches two modules via serial port (CSR 18.1)
2. Has SPP and OPP servers
3. Does some HCI-level stuff to monitor connections and close =
connections to
misbehaving devices.

The program will initiate rfcomm connections to devices which do not =
allow
role switches.

If I kill the program while several devices are connected (or are in the
process of connecting/disconnecting), sometimes the rfcomm use count is =
left
above 0 (I've seen it as high as 4). Killing the program detaches the
modules (this is verified by hcid's log output). Killing sdpd and hcid
doesn't reduce the use count. No other bluetooth programs are running,
except a kernel thread krfcommd.

Re-starting the program produces the error "Address already in us(98)" =
when
trying to bind the SPP server socket. The only remedy I've found is to
reboot the device.

Could sending an hci_disconnect directly, rather than using close(), be
confusing the stack? I realize this isn't the ideal way of closing
connections... It only gets used if the normal process is taking longer =
than
is desired when a device is forcing the server to be a slave.

The kernel version is 2.4.21-mh10, with various ARM patches (which, as =
far
as I can tell, do not touch any bluetooth related code). I have a very
similar program running on 2.4.18-mh8 and have never noticed this =
problem.

This doesn't seem to be related, but just in case it is: I'm also seeing
"hci_cmd_task: hci0 command tx timeout" errors. I am able to get the =
above
situation to happen without a timeout error.

Thanks,

-Daryl.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
