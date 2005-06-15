Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050615212834.90743.qmail@web50702.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] Problem with dund and LG 325 phone.
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1117143784.12036.78.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Wed, 15 Jun 2005 14:28:34 -0700 (PDT)



--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Eric,
> 
> > I have an LG PM-325 which I am trying to get DUN
> working with. It works under
> > Windows, but I want to use linux.
> > 
> > I think the two devices are paired since I can do
> l2ping and get responses,
> > but I still seem to be a few steps away from being
> able to do DUN.
> > 
> > When I type this, I expect to get a success
> message back, right? Instead I get 
> > nothing:
> > 
> > [root@a122077 root]# dund -c 08:00:37:13:A1:C7 -n
> > dund[5586]: Bluetooth DUN daemon
> > dund[5586]: Searching for LAP on 08:00:37:13:A1:C7
> > [root@a122077 root]#
> > 
> > I don't have to do anything with rfcomm before
> this, right? I also don't need 
> > to run pand, right, since my device only supports
> DUN.
> > 
> > When I try to do a pppd call command, I get this
> in syslog:
> > May 26 14:43:02 a122077 kernel: PPP generic driver
> version 2.4.2
> > May 26 14:43:02 a122077 pppd[5708]: pppd 2.4.3
> started by root, uid 0
> > May 26 14:43:03 a122077 hcid[3602]:
> link_key_request (sba=00:10:60:AA:5C:CE, 
> > dba=08:00:37:13:A1:C7)
> > May 26 14:43:03 a122077 pppd[5708]: Failed to open
> /dev/rfcomm0: Connection 
> > refused
> > May 26 14:43:03 a122077 pppd[5708]: Exit.
> > 
> > which isn't surprising.
> 
> using dund for Dialup-Networking is the wrong way.
> The dund is for LAN
> access using PPP. And yes, I know that the name is
> confusing.
> 
> What you need is to find the RFCOMM channel number
> for Dialup-Networking
> with the help of
> 
> 	sdptool search --bdaddr <bdaddr> dun
> 
> and then you bind a RFCOMM TTY port to that channel
> with
> 
> 	rfcomm bind 0 <bdaddr> <channel>
> 
> After that you can use any dialer (for example
> wvdial) to setup your
> dialup connection through /dev/rfcomm0.
> 
> Regards
> 
> Marcel
> 

This is the result of me doing that.  I wanted to also
use btcid, if I bind to channel 4 or 5, should I be
able to use btcid on /dev/rfcomm0 when I am not using
dialup?  Otherwise, to use dialup, do I tell
rfcomm.conf to bind to port 4 or 5?  I had been
getting connection refused errors.

sdptool search --bdaddr 08:00:37:12:C4:B1 dun
Searching for dun on 08:00:37:12:C4:B1 ...
Service Name: Dialup Networking
Service RecHandle: 0x10003
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Service Name: LG LX325 DUP Service
Service RecHandle: 0x10004
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100






		
__________________________________ 
Discover Yahoo! 
Use Yahoo! to plan a weekend, have fun online and more. Check it out! 
http://discover.yahoo.com/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
