Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0607140911530.19575@ysf-zvav.gfns.pu>
References: <Pine.LNX.4.64.0607132135350.4704@ybpnyubfg.ybpnyqbznva>
	<1152820951.4838.76.camel@localhost>
	<Pine.LNX.4.64.0607132205380.4704@ybpnyubfg.ybpnyqbznva>
	<1152824695.4838.81.camel@localhost>
	<Pine.LNX.4.64.0607140608250.3992@ybpnyubfg.ybpnyqbznva>
	<20060714064703.GA19807@suse.de>
	<Pine.LNX.4.64.0607140911530.19575@ysf-zvav.gfns.pu>
Date: Fri, 14 Jul 2006 09:27:44 +0200
Message-Id: <1152862064.13430.9.camel@localhost>
Mime-Version: 1.0
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

Hi Andreas,

> >SS: On Fri, Jul 14, 2006 at 06:12:41AM +0200, Andreas Fehr wrote:
> >SS: > On Thursday, 13. July 2006, 23:04, Marcel Holtmann (as MH) wrote:
> >SS: > 
> >SS: > >MH: > >MH: > I've still a problem with pairing my phone with my 
> >SS: > >MH: > >MH: > bluetooth dongle. My phone asks me if I want a serial port 
> >SS: > >MH: > >MH: > connection with computer. As soon as I accept this, the 
> >SS: > >MH: > >MH: > dialog to enter the pin shows but disappears within about 
> >SS: > >MH: > >MH: > 1 second. Far to few time to enter any pin.
> >SS: > >MH: > >MH: > 
> >SS: > >MH: > >MH: > Is there a way to set some other timeout for pairing?
> >SS: 
> >SS: How did you configure the PIN on your machine?
> >SS: Do you have a passkey agent?
> 
> No, I use passkey in hcid.conf

and this is only used for incoming connections. It is not the default
PIN for outgoing connection.

> >SS: > And again, vmware with USB and the same bluetooth dongle does 
> >SS: > work and the old driver 2.x did work to.
> >SS: 
> >SS: Do you know, that the PIN handling changed with BlueZ 3.0?
> 
> I figured it out reading hcid.conf. Would be better to have something in 
> the README or the ChangeLog or somewhere else. Is there some 
> documentation I missed? I grepped for pin and pin_helper (to find some 
> replacement for the old pin_helper).

This was in the announcement of the BlueZ 3.0 series.

> >SS: Short:
> >SS: - pin is no longer in /etc/bluetooth/pin. Now is in 
> >SS:   /etc/bluetooth/hcid.conf.
> >SS: - set "security auto;" and "passkey "yourpin";" in 
> >SS:   /etc/bluetooth/hcid.conf and try again.
> 
> See my answer above.
> 
> I tried both, security auto and security user (with kill and restart of 
> hcid in between).

Leave it to "auto". It makes no sense to tune this parameter.

> >SS: I guess you do not see a timeout, but an rejection, since hcid has 
> >SS: no PIN and no passkey-agent, so it already knows, that it cannot 
> >SS: authenticate the phone and rejects it right away.
> 
> Why would hcid try to connect if there is no pin or passkey-agent? My 
> phone gets connected.

I don't see a PIN code or Link Key request in your hcidump. This is the
strange thing.

2006-07-13 21:40:06.703037 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3 
2006-07-13 21:40:06.704014 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
2006-07-13 21:40:06.706011 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
2006-07-13 21:40:06.708012 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 2
2006-07-13 21:40:06.718010 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1

**************** press accept on the phone
**************** and try to enter pin here

2006-07-13 21:40:07.798989 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 6 pf 1 ilen 0 fcs 0x32 

We send the SABM and then phone should answer with an UA. Are you sure
that channel 3 is the correct one?

What command are you using for the connection.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
