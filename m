Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing Palm Vx (TDK Blue5) with Fedora Core 4
	(FC4)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051127210746.GA7517@janeway>
References: <20051127175239.GA3911@janeway> <1133116533.13629.9.camel@blade>
	 <20051127210746.GA7517@janeway>
Content-Type: text/plain
Message-Id: <1133128104.13629.20.camel@blade>
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
Date: Sun, 27 Nov 2005 22:48:24 +0100

Hi Ian,

> > > Any ideas? Rather than post a whole heap of diagnostic info that may
> > > well be useless to you, I throw myself on the mercy of the list to 
> > > suggest what diagnostics I should be supplying.
> > 
> > run "hcidump -X -V" as root while trying to pair.
>  
> This is what I get:
> 
> $ hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.18
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:06:56:01:21:61 class 0x020114 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:06:56:01:21:61 role 0x01
>     Role: Slave
> > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:06:56:01:21:61
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x22 handle 41 bdaddr 00:06:56:01:21:61 type ACL encrypt 0x00
>     Error: LMP Error Transaction Collision
> 
> The "HCI Event: PIN Code Request" comes up when I submit my PIN,
> then the Palm goes away for a few seconds and times out, and then
> several seconds later, I get the "HCI Event: Connect Complete".

make sure that hcid is running as root.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
