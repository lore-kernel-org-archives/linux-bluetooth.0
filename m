Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <004101c3a3b4$81f42dd0$dc01a8c0@alan>
From: "Alan Huang" <alanh@tuks.co.za>
To: <bluez-devel@lists.sourceforge.net>
References: <200311050945.34166.sybren@thirdtower.com>
Subject: Re: [Bluez-devel] rfcomm patch
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 5 Nov 2003 17:50:16 +0200

Hi,
  Regarding this topic that rfcomm doesn't flush. I just want to ask that,
I'm using an USB Bluetooth dongle that's connected to another Bluetooth
device using the rfcomm program. This other Bluetooth device is connected to
a Windows PC's COM1 port (RS-232) and connected/displayed by
hyperterminal... For some unknown reason, what ever the hyperterminal sends
on the Windows side can be shown
"cat /dev/rfcomm0". But what ever the USB Bluetooth dongle sends (using
"echo hello > /dev/rfcomm0") it can't be shown on the Windows
hyperterminal...

On my Windows side, I have a embedded Bluetooth module (CSR's BC02) and the
signal is connected to a MAX chip converting betweeen BC02's 3.3V and
RS232's logic level.

Regards,

Alan

----- Original Message -----
From: "Sybren Stuvel" <sybren@thirdtower.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, November 05, 2003 10:45 AM
Subject: [Bluez-devel] rfcomm patch


Hi there,

I've been working with bluetooth for a few months now, trying to let BlueZ
(on
my PC) talk to Affix (on my Zaurus). One difficulty is that rfcom doesn't
flush it's stdout when a new (incoming and/or outgoing) connection has been
made.

With the attached patch, scripts can use rfcomm to connect via bluetooth and
fork() the process in order to start using the connection (ie. by running
pppd over it).

Greetings,
Sybren Stuvel
--
(o_   Q: God, root, what is difference?
//\   A: God can change the byte order on the CPU, root can't.
V_/_






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
