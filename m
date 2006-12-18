Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061218023808.6ca4c27e@zippo01>
References: <20061218023808.6ca4c27e@zippo01>
Date: Mon, 18 Dec 2006 10:38:52 +0100
Message-Id: <1166434732.6557.58.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BLUETOOTH ERRER: call_passkey_agent
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> I'm having issues using rfcomm i and getting
> 
> Can't connect RFCOMM channel: Connection refused
> 
> i have bluex-pin and bluepin installed, both simply return PIN:0000 and
> have tried both, also just using passkey "0000" but am lost. here is the
> output i have to work with:
> 
> using:
> bluez-utils 3.7
> bluez-libs 3.7
> linux-2.6.18.2
> I have severl other bluetooth items working a mouse and keyboard.
> All modules are loaded that should be loaded
> $ lsmod
> rfcomm                 36776  0 
> snd_bt_sco             14220  0
> bnep                   13568  0 
> bfusb                  11844  0
> hci_usb                17116  4
> crc32                   4672  1 bnep
> hidp                   14080  2 
> l2cap                  21760  15 rfcomm,bnep,hidp
> 
> $ hcitool scan
> Scanning ...
> 00:16:8F:41:47:FE       Motorola H700
> 
> $ l2ping 00:16:8F:41:47:FE
> Ping: 00:16:8F:41:47:FE from 00:07:61:19:61:FD (data size 44) ...
> 4 bytes from 00:16:8F:41:47:FE id 0 time 28.96ms
> 4 bytes from 00:16:8F:41:47:FE id 1 time 48.53ms
> 2 sent, 2 received, 0% loss
> 
> $ rfcomm connect 0 00:16:8F:41:47:FE 1
> Can't connect RFCOMM socket: Connection refused
> 
> $ btsco -v 00:16:8F:41:47:FE
> btsco v0.42
> Device is 1:0
> Voice setting: 0x0060
> Can't connect RFCOMM channel: Connection refused
> 
> SYSLOG output
> Dec 18 02:18:51 zippo01 hcid[22383]: pin_code_request
> (sba=00:07:61:19:61:FD, dba=00:16:8F:41:47:FE)
> Dec 18 02:18:51 zippo01 hcid[22383]: call_passkey_agent(): no agent
> registered

I think this error is quite clear. You have to register a passkey agent
first. So you can either use the passkey-agent.c example code from the
bluez-utils source or you install bluez-gnome and use its graphical
passkey agent.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
