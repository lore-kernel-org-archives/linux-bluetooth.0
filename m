Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Simone Gotti <simone.gotti@email.it>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Pocket PC 2003 and Linux
Cc: Detlef Grittner <detlef.grittner@t-online.de>
References: <412C5482.3010909@t-online.de>
In-Reply-To: <412C5482.3010909@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408251202.48482.simone.gotti@email.it>
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
Date: Wed, 25 Aug 2004 12:02:47 +0000

On Wednesday 25 August 2004 08:57, Detlef Grittner wrote:
> I have a working connection between a Linux box with SuSE 9.1 (Sitecom
> Bluetooth dongle) and a Pocket PC 2003 HP 5550.
> Ping and so on is no problem.
>
> But I found no way to transfer files from the Pocket PC to the Linux box.
> The other way round works: I can send any file from my Linux box to the
> Pocket PC via OBEX push.
> I have tried to start the obex demon with:
> opd --mode OBEX --channel 10 --daemonize --path /tmp --sdp
> Although the Pocket PC finds the Linux box, it says there are no known
> services on it.
> I have tried kbluetoothd as well and now the Pocket PC claims there is a
> kbtserialchat service on my Linux box. But I have no idea what I can do
> with it on my Pocket PC.
> I was able to establish a PAN network. But again, although the Pocket PC
> claims it is working, I have no idea how to use it.
>
> What I want to do is a obex push from the Pocket PC to the Linux box.
> Any ideas what am I missing?

I can answer you for the kde-bluetooth's kbluetoothd

To look if it has registered the OBEX PUSH sdp entry you can use the graphical 
interface (right click on the kbluetoothd tray icon -> configuration details 
-> configure services and look if the kbtobexsrv is registered and active.

You can do the same thing typing in a shell:
 sdptool browse FF:FF:FF:00:00:00

If the Obex Push is registered you'll get something like this:

Service Name: Obex Push Server
Service Description: KDE OBEX Object Push Service
Service RecHandle: 0x804f9a8
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100


Bye!
-- 
Simone Gotti
<simone.gotti@email.it>
http://kde-bluetooth.sf.net


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
