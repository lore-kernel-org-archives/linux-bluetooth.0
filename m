Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Hans Bausewein <hans@comerwell.xs4all.nl>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcom Corporation (Firmware 105.105.074) USB dongle
Message-ID: <20041030152320.GA9566@comerwell.xs4all.nl>
References: <20041030094327.GA8724@comerwell.xs4all.nl> <1099136877.6912.41.camel@pegasus> <20041030124433.GA9232@comerwell.xs4all.nl> <1099143692.10448.14.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099143692.10448.14.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 30 Oct 2004 17:23:21 +0200

On Sat, Oct 30, 2004 at 03:41:32PM +0200, Marcel Holtmann wrote:
> 
> any additional information about this dongle? Link to a website or so?

Made by Widcomm, inc.

Bluetooth v1.2 Compliant  

I've searched the manual (pdf) for 'http' and 'ftp' with no results.

> > > The CSR based dongles actually make less problems. If you don't need it
> > > anymore, you can donate it to me, because I really need these kind of
> > > dongles for testing.
> > 
> > i'll keep it in mind
> > 
> > Kernel 2.6.10rc1 + patch is compiling now...
> 
> Does it work? If yes, send in the output from "hciconfig -a".

No, down, no m

hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN 
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1 
        Link policy: 
        Link mode: SLAVE ACCEPT 

p2:/var/log# hciconfig dev hci0 up
Can't init device hci0. Device or resource busy(16)

Hans


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
