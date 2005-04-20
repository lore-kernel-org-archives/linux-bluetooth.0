Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4266587D.9030806@nokia.com>
From: =?ISO-8859-1?Q?Timo_Ter=E4s?= <ext-timo.teras@nokia.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] RFCOMM does not call tty_hangup() when
 DCD is de-asserted
References: <42663B80.6070309@nokia.com> <1114000772.2469.168.camel@pegasus>
In-Reply-To: <1114000772.2469.168.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 20 Apr 2005 16:26:21 +0300

Hi Marcel,

ext Marcel Holtmann wrote:
> from my part this patch looks fine, but I don't like the modem emulatio=
n
> part of RFCOMM in general. For me it is only a stream. Nothing less and
> nothing more. So if this patch is useful I am going to apply it.

PPP relies on this behaviour to detect when remote side has hang up the
call. So PPP will be broken without this patch.

>>+	if ((dev->modem_status & TIOCM_CD) &&
>>+	    !(v24_sig & RFCOMM_V24_DV)) {
>=20
> You must comply with the coding style here. So change it into
>=20
> 	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV)) {

Fixed. I also added check for CLOCAL being unset. If it is set modem cont=
rol
lines should be ignored (also the uart code check for this).

Cheers,
   Timo

Signed-off-by: Timo Ter=E4s <ext-timo.teras@nokia.com>

=3D=3D=3D=3D=3D net/bluetooth/rfcomm/tty.c 1.36 vs edited =3D=3D=3D=3D=3D
--- 1.36/net/bluetooth/rfcomm/tty.c     2005-04-13 15:55:20 +03:00
+++ edited/net/bluetooth/rfcomm/tty.c   2005-04-20 15:56:31 +03:00
@@ -531,6 +531,11 @@ static void rfcomm_dev_modem_status(stru

         BT_DBG("dlc %p dev %p v24_sig 0x%02x", dlc, dev, v24_sig);

+       if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV))=
 {
+               if (dev->tty && !C_CLOCAL(dev->tty))
+                       tty_hangup(dev->tty);
+       }
+
         dev->modem_status =3D
                 ((v24_sig & RFCOMM_V24_RTC) ? (TIOCM_DSR | TIOCM_DTR) : =
0) |
                 ((v24_sig & RFCOMM_V24_RTR) ? (TIOCM_RTS | TIOCM_CTS) : =
0) |


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
