Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Error in rfcomm command
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A081D2.4060503@gmx.net>
References: <41A081D2.4060503@gmx.net>
Content-Type: text/plain
Message-Id: <1101056392.7250.23.camel@pegasus>
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
Date: Sun, 21 Nov 2004 17:59:52 +0100

Hi Dieter,

> 1. rfcomm connect
> 
> If I want to connect to a device wich has an entry in rfcomm.conf with 
> "rfcomm connect rfcomm0" I get the message "Can't find a config entry 
> for rfcomm0"! I think it's an error in function "cmd_connect" 
> (./bluez-utils-2.11/rfcomm/main.c):
> 
> static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, 
> char **argv)
> {
> 	struct sockaddr_rc laddr, raddr;
> ...
> 	
> 	if (argc < 2) {
> 		if (rfcomm_read_config(rfcomm_config_file) < 0) {
> 			perror("Can't open RFCOMM config file");
> 			return;
> 		}
> 
> 		raddr.rc_family = AF_BLUETOOTH;
> 		bacpy(&raddr.rc_bdaddr, &rfcomm_opts[dev].bdaddr);
> 		raddr.rc_channel = rfcomm_opts[dev].channel;
> 		
> // wrong:	if (bacmp(&req.dst, BDADDR_ANY) == 0) {
> // must be:
> 		if (bacmp(&raddr.rc_bdaddr, BDADDR_ANY) == 0) {
> 			fprintf(stderr, "Can't find a config entry for rfcomm%d\n", dev);
> 
> 			return;
> 		}
> 	} else {
> 		raddr.rc_family = AF_BLUETOOTH;
> ...

it thought I tested this and it always worked for me. However you are
right and it is fixed in CVS now. Next time send a unified diff, because
it is easier to read.

> 2. rfcomm bind
> 
> If I execute "rfcomm bind rfcomm0" prior to "rfcomm connect rfcomm0" I 
> get the message "Can't connect RFCOMM socket: Host is down"!
> After a "rfcomm release rfcomm0" and a repeated "rfcomm connect rfcomm0" 
> the connection will establish.

I don't know why it shows "Host is down", but you can't connect and bind
the same RFCOMM TTY at the same time. If you binded it, then you should
open the TTY to get the connection.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
