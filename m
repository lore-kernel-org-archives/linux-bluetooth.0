Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket CF adaptor, limited to 2-3KB/sec RFCOMM
	PPP connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Jay W. Summet" <summetj@cc.gatech.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0410141051300.8280@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0410121425040.24690@gaia3.cc.gatech.edu>
	 <1097752969.4640.40.camel@notepaq>
	 <Pine.GSO.4.58.0410141051300.8280@gaia3.cc.gatech.edu>
Content-Type: text/plain
Message-Id: <1097929292.4911.37.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 16 Oct 2004 14:21:33 +0200

Hi Jay,

> I have a Socket Compact Flash bluetooth adaptor, which uses the dtl1_cs
> kernel module. I have it configured, and everything works, but
> I am getting very slow GPRS speeds with my Sony Ericsson T610 telephone.
> 
> I first noticed it with my GPRS data transfer when I only got 1.9 to 2.2 KB
> per second of throughput on downloads. When I use IrDA to connect to
> my phone instead of bluetooth, I get the expected 5.0 to 5.6 KB per second
> of throughput.
> 
> I borrowed a friend's USB bluetooth adaptor (DBT-120 D-Link) and am able
> to get the 5.0 to 5.6 KB/sec GPRS transfer while the Socket Compact Flash
> (CF) adaptor got 2.0KB/sec. (Tested in the same location, with excellent
> cellular signal strength, at the same time of day.)
> 
> I also tested both devices using the obextool to "push" an 84 KB jpeg
> image to my telephone. I believe that this transfer was speed limited by
> the phone's internal (flash?) memory, as with both the Socket CF and
> D-Link USB adaptor I got about the same speeds, in the 24-30 second range
> (best case, in a few cases I got much worth throughput). [That's about
> 3.4KB/Sec, slower than the GPRS throughput (below) I was getting with the
> USB adaptor or IrDA, even when I was using the USB adaptor for the obex
> push.]

what I assume is that the link manager on the Socket card is not doing a
good job, because it should select a different packet type automaticly
to get the best troughput as possible. However this card is very old and
maybe you should simply ask Socket to get one of there newer cards with
a CSR chip. There are some problems with a 2.6 kernel to get the serial
part of them working, but maybe these are solved now. I don't have one
of these newer cards, because I stopped spending money for buying them.
People of companies have to donate them to me.

In general it is a bad idea to play with the packet types from the HCI
level, because the link manager knows best what type to select. In your
case you may wanna change them with hciconfig and see if it helps.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
