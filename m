Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] business card transfer problem
From: Stephen Crane <steve.crane@rococosoft.com>
To: franz keuner <franz_keuner@gmx.net>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1269.1082534936@www62.gmx.net>
References: <1269.1082534936@www62.gmx.net>
Content-Type: text/plain
Message-Id: <1082560496.29569.219.camel@baroque.rococosoft.com>
Mime-Version: 1.0
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
Date: Wed, 21 Apr 2004 16:14:57 +0100

Just try it and then run "hciconfig hci0 class" again! It will tell you
if you get it right!

hciconfig hci0 class 0x100104
hciconfig hci0 class
hci0:   Type: USB
        BD Address: 00:80:98:24:4E:8A ACL MTU: 192:8  SCO MTU: 64:8
        Class: 0x100104
        Service Classes: Object Transfer
        Device Class: Computer, Desktop workstation

On Wed, 2004-04-21 at 09:08, franz keuner wrote:
> hi steve,
> 
> thanks for your quick answer. 
> that's the answer of my linux computer to hciconfig hci0 class
> 
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 192:8  SCO MTU: 64:8
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
> 
> i don't know what i have to change exactly here...
> 
> i read the bluetooth assigned numbers document. would i have to enter 
> 
> hciconfig hci0 class 0x100104
> 
> to make the right changes class? (the 1st hex number representing obex file
> transfer and the rest represting a desktop computer)
> 
> and if that's right, is the pda in contrast to the phone ignoring this
> mistake because it's possible to receive businesscards from the pda?
> 
> regards,
> 
> franz
> 
> > Hi Franz,
> > Make sure you have the correct class-of-device setting on the Linux box.
> > (See hciconfig(8).) Phones and PDAs often don't even bother doing an SDP
> > search if the device-class obtained by device discovery doesn't contain
> > the correct hint bits.
> > 
> > Cheers,
> > Steve
> > 
> > On Tue, 2004-04-20 at 09:56, franz keuner wrote:
> > > hi marcel,
> > > 
> > > for quite a while i had no questions concerning bluez and my Sony
> > Ericsson
> > > P900 ;-)
> > > with your help i made a lot of progress.
> > > 
> > > now i'm trying to send and receive businesscards (version2.1) between
> > the
> > > linux computer with bluez and the mobile phone.
> > > 
> > > i installed the openobex package for suse 9.0 and the openobex
> > applications.
> > > 
> > > i can send a businesscard from the linux computer to the mobile phone
> > using
> > > the obextest tool from the applications package.
> > > 
> > > but if i try to receive a businesscard from the mobile phone on the
> > linux
> > > computer with the opd program the phone reports a failure trying to
> > transfer
> > > the businesscard to the linux computer.
> > > 
> > > but it works if i try to send the same businesscard from the phone to a
> > pda.
> > > the pda receives the businesscard correctly.
> > > 
> > > and if try to receive the businesscard from the pda on the linux
> > computer
> > > with the opd program this is also working.
> > > 
> > > i'm sure i'm listening on the right channels. maybe the problem is that
> > the
> > > phone can't communicate with the opd program waiting for a connection...
> > > 
> > > do you have any ideas or hints?
> > > 
> > > regards,
> > > 
> > > franz
> > > 
> > > hcidump shows the following trying to the send from the phone to the
> > linux
> > > computer:
> > > 
> > > hcidump r
> > > HCIDump - HCI packet analyzer ver 1.5
> > > device: hci0 snap_len: 1028 filter: 0xffffffff
> > > > HCI Event: Connect Request(0x04) plen 10
> > > < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> > > > HCI Event: Command Status(0x0f) plen 4
> > > > HCI Event: Connect Complete(0x03) plen 11
> > > < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> > > > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> > > > HCI Event: Command Complete(0x0e) plen 6
> > > < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
