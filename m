Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdpd deamon fails to start.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: bluez-devel@lists.sf.net
In-Reply-To: <4391A0A9.5090706@ncoretech.com>
References: <4391A0A9.5090706@ncoretech.com>
Content-Type: text/plain
Message-Id: <1133617090.31106.41.camel@blade>
Mime-Version: 1.0
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
Date: Sat, 03 Dec 2005 14:38:10 +0100

Hi Zaheer,

> I have installed the bluez utilities on my embedded linux system.
> However when I start "sdpd" I get the following error.
> 
> Jan 31 03:32:31 Simputer daemon.info hcid[1298]: Bluetooth HCI daemon
> Jan 31 03:32:31 Simputer daemon.info hcid[1298]: HCI dev 0 up
> Jan 31 03:32:31 Simputer daemon.info hcid[1298]: Starting security manager 0
> Jan 31 03:32:33 Simputer daemon.err sdpd[1369]: init_server: binding 
> UNIX socket: No such file or directory
> Jan 31 03:32:33 Simputer daemon.err sdpd[1369]: main: Server 
> initialization failed

it wants to create a Unix domain socket at /var/run/sdp and it must have
permissions for that.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
