Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Jul 2006 09:39:47 +0200 (CEST)
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1152862064.13430.9.camel@localhost>
Message-ID: <Pine.LNX.4.64.0607140931090.19685@ysf-zvav.gfns.pu>
References: <Pine.LNX.4.64.0607132135350.4704@ybpnyubfg.ybpnyqbznva>
	<1152820951.4838.76.camel@localhost>
	<Pine.LNX.4.64.0607132205380.4704@ybpnyubfg.ybpnyqbznva>
	<1152824695.4838.81.camel@localhost>
	<Pine.LNX.4.64.0607140608250.3992@ybpnyubfg.ybpnyqbznva>
	<20060714064703.GA19807@suse.de>
	<Pine.LNX.4.64.0607140911530.19575@ysf-zvav.gfns.pu>
	<1152862064.13430.9.camel@localhost>
MIME-Version: 1.0
Subject: Re: [Bluez-users] rfcomm pairing and timeout
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

On Friday, 14. July 2006, 09:27, Marcel Holtmann (as MH) wrote:
>MH: > >SS: On Fri, Jul 14, 2006 at 06:12:41AM +0200, Andreas Fehr wrote:
>MH: > >SS: > On Thursday, 13. July 2006, 23:04, Marcel Holtmann (as MH) wrote:
>MH: > >SS: > 
>MH: > >SS: > >MH: > >MH: > I've still a problem with pairing my phone with my 
>MH: > >SS: > >MH: > >MH: > bluetooth dongle. My phone asks me if I want a serial port 
>MH: > >SS: > >MH: > >MH: > connection with computer. As soon as I accept this, the 
>MH: > >SS: > >MH: > >MH: > dialog to enter the pin shows but disappears within about 
>MH: > >SS: > >MH: > >MH: > 1 second. Far to few time to enter any pin.
>MH: > >SS: > >MH: > >MH: > 
>MH: > >SS: > >MH: > >MH: > Is there a way to set some other timeout for pairing?
>MH: > >SS: 
>MH: > >SS: How did you configure the PIN on your machine?
>MH: > >SS: Do you have a passkey agent?
>MH: > 
>MH: > No, I use passkey in hcid.conf
>MH: 
>MH: and this is only used for incoming connections. It is not the 
>MH: default PIN for outgoing connection.

Ok, I'll remove this, as I don't want incoming connections.


>MH: > >SS: > And again, vmware with USB and the same bluetooth dongle 
>MH: > >SS: > does work and the old driver 2.x did work to.
>MH: > >SS: 
>MH: > >SS: Do you know, that the PIN handling changed with BlueZ 3.0?
>MH: > 
>MH: > I figured it out reading hcid.conf. Would be better to have 
>MH: > something in the README or the ChangeLog or somewhere else. Is 
>MH: > there some documentation I missed? I grepped for pin and 
>MH: > pin_helper (to find some replacement for the old pin_helper).
>MH: 
>MH: This was in the announcement of the BlueZ 3.0 series.

Well... I didn't use the 3.0 version, blame me for not being up to date 
with each version :-)


>MH: > >SS: I guess you do not see a timeout, but an rejection, since 
>MH: > >SS: hcid has no PIN and no passkey-agent, so it already knows, 
>MH: > >SS: that it cannot authenticate the phone and rejects it right 
>MH: > >SS: away.
>MH: > 
>MH: > Why would hcid try to connect if there is no pin or 
>MH: > passkey-agent? My phone gets connected.
>MH: 
>MH: I don't see a PIN code or Link Key request in your hcidump. This is 
>MH: the strange thing.

Should this come from the computer or the phone?


>MH: 2006-07-13 21:40:06.703037 < ACL data: handle 2 flags 0x02 dlen 8
>MH:     L2CAP(d): cid 0x0040 len 4 [psm 3]
>MH:       RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3 
>MH: 2006-07-13 21:40:06.704014 > HCI Event: Number of Completed Packets (0x13) plen 5
>MH:     handle 2 packets 1
>MH: 2006-07-13 21:40:06.706011 > HCI Event: Number of Completed Packets (0x13) plen 5
>MH:     handle 2 packets 1
>MH: 2006-07-13 21:40:06.708012 > HCI Event: Number of Completed Packets (0x13) plen 5
>MH:     handle 2 packets 2
>MH: 2006-07-13 21:40:06.718010 > HCI Event: Number of Completed Packets (0x13) plen 5
>MH:     handle 2 packets 1
>MH: 
>MH: **************** press accept on the phone
>MH: **************** and try to enter pin here
>MH: 
>MH: 2006-07-13 21:40:07.798989 < ACL data: handle 2 flags 0x02 dlen 8
>MH:     L2CAP(d): cid 0x0040 len 4 [psm 3]
>MH:       RFCOMM(s): DISC: cr 1 dlci 6 pf 1 ilen 0 fcs 0x32 
>MH: 
>MH: We send the SABM and then phone should answer with an UA. Are you sure
>MH: that channel 3 is the correct one?

Well, it did work with the old version of bluez. And my phone asks me to 
accept a serial connection. So this seems ok for me. Unless there is a 
change in the definition between bluez-2.x and bluez-3.x, it still 
should work.

I'll downgrade to a version 2.x, but this wont happen till this evening. 
What is the last version of the 2.x series, 2.25 or 2.26? Just to make 
sure, that the rest of the system still works as expected.


>MH: What command are you using for the connection.

I start minicom with /dev/rfcomm0 I guess, minicom only opens the port.

Thanks,
Andreas


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
