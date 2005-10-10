Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <434A0EDC.3020902@cefriel.it>
From: Luca Pizzamiglio <pizzamiglio@cefriel.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] full duplex SCO communication for head set profile
References: <loom.20051008T232205-496@post.gmane.org>
In-Reply-To: <loom.20051008T232205-496@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 10 Oct 2005 08:49:00 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Adam. I suppose that problem is size field of write syscall.
count field of write() or len field of send() must be less or equal of
sco MTU.
if MTU is 64, you can't send a 1024 byte buffer, but you must write 64
byte buffer for 16 times.

Cheers,
Pizza

Adam Ritter wrote:
> Hi!
> 
> I try to use my computer as a headset for a mobile phone. The computer makes an
> rfcomm connection and when the mobile makes an SCO connection to the computer,
> it accepts it. The computer can read data from the SCO socket, but when it
> writes to that socket, the write fails with error ,,Invalid argument''.  Do you
> have any ideas what I should do to transfer sound from the computer to the
> mobile with that profile?
> 
> Adam
> 
> 
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:02:72:B2:F6:72 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:1362628 acl:313 sco:26537 events:543 errors:0
>         TX bytes:5706 acl:238 sco:0 commands:203 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'BlueZ (0)'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> bash-2.05b# hciconfig hci0 voice
> hci0:   Type: USB
>         BD Address: 00:02:72:B2:F6:72 ACL MTU: 192:8 SCO MTU: 64:8
>         Voice setting: 0x0060 (Default Condition)
>         Input Coding: Linear
>         Input Data Format: 2's complement
>         Input Sample Size: 16 bit
>         # of bits padding at MSB: 0
>         Air Coding Format: CVSD
> 


- --
- -------------------------------------------
Luca Pizzamiglio
CEFRIEL - Embedded Systems Design Unit
Via Fucini, 2 - 20133 MILANO (ITALY)
Phone:		+39 02 23954 343
e-mail:		pizzamiglio@cefriel.it
ICQ:		5046978
- -------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDSg7cAoUy56ORfbERAiCFAKCpmDdz+jFFWHwnEVuxNJsxGlrNhwCfX3Dh
3GJUXRFQmNb6D1wGz87+Yio=
=c/uV
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
