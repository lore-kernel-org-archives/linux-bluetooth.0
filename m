Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm connect error Too many links(31)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060118123739.GA39259@rucus.ru.ac.za>
References: <20060118123739.GA39259@rucus.ru.ac.za>
Content-Type: text/plain
Message-Id: <1137588481.21191.5.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 18 Jan 2006 13:48:01 +0100

Hi David,

> I am trying to write a program that forwards one rfcomm connection to
> another connection, but each time I try make a 2nd connection out I get a
> "Too many links(31)" error. Attached is my code but here is some simple
> "psedo code" of it:
> 
> rcsocklisten = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)
> bind(rcsocklisten, (struct sockaddr *) &loc_addr, sizeof(loc_addr)
> listen(rcsocklisten, 4)
> rcsockin = accept(rcsocklisten, (struct sockaddr *)&rem_addr, &opt)
> rcsockout = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)
> bind(rcsockout, (struct sockaddr *) &addr, sizeof(addr)
> connect(rcsockout, (struct sockaddr *)&addr, sizeof(addr)
> --ERROR here--
> 
> hcidump -V -x shows the following:
> 
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:80:C8:26:FD:6D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x09 handle 0 bdaddr 00:80:C8:26:FD:6D type ACL encrypt 0x00
>     Error: Connection Limit Exceeded
> 
> The "Connection Limit Exceeded" is worry and confusing me as I have run
> mutiple rfcomm connections through this chip before.

but maybe not multiple ACL connections and this is what you need in your
case. So you need at least a CSR chip with HCI 18.x firmware or you
might wanna simply use another dongle. One for the incoming data and one
for the outgoing data.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
