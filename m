Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Ambicom BT-2000CF doesn't want to work with
	kernel 2.6.11.8
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
Cc: Ron Murray <rjmx@rjmx.net>
In-Reply-To: <200505230949.01287.pavouk@pavouk.org>
References: <4291146C.4000603@rjmx.net>
	 <200505230949.01287.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1116843358.30044.47.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 23 May 2005 12:15:58 +0200

Hi Pavel,

> I don't know, if it is exactly your problem, but some bluetooth
> PCMCIA (CF) cards have problems with kernel 2.6. Specially
> New SOCKET or Billionton card.
> There exists patch for kernel 2.6.11, which resolve problems with
> these cards. Look at this page for instruction:
> http://www.summet.com/x31/socket.html
> 
> Find in archive mail with subject "Billionton(?) CF card - success".

Pavel Machek posted the commands to get the Billionton card working to
the LKML. I verified it and maybe the same will work the Ambicom.

And depending on if it is a 2000C or 2000E it has a CSR or an Ericsson
chip inside. Guess who is who.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
