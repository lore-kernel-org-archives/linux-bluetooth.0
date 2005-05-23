Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Ambicom BT-2000CF doesn't want to work with kernel 2.6.11.8
Cc: Ron Murray <rjmx@rjmx.net>
References: <4291146C.4000603@rjmx.net>
In-Reply-To: <4291146C.4000603@rjmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505230949.01287.pavouk@pavouk.org>
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
Date: Mon, 23 May 2005 09:49:01 +0200

Hello,

I don't know, if it is exactly your problem, but some bluetooth
PCMCIA (CF) cards have problems with kernel 2.6. Specially
New SOCKET or Billionton card.
There exists patch for kernel 2.6.11, which resolve problems with
these cards. Look at this page for instruction:
http://www.summet.com/x31/socket.html

Find in archive mail with subject "Billionton(?) CF card - success".

>     I'm running Debian sarge on a Sony PCG-505FX laptop, using a
> home-built kernel (currently 2.6.11.8 with current bluez patches). I've

Best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
