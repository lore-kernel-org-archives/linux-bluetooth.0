Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Ambicom BT-2000CF doesn't want to work with	kernel 2.6.11.8
Message-ID: <20050524092523.GA18974@adamis.de>
References: <4291146C.4000603@rjmx.net> <200505230949.01287.pavouk@pavouk.org> <1116843358.30044.47.camel@pegasus> <429286B4.3030208@rjmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <429286B4.3030208@rjmx.net>
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
Date: Tue, 24 May 2005 11:25:23 +0200

Hi Ron,

On 23.05.05 21:43:16, Ron Murray wrote:
...
> >>I don't know, if it is exactly your problem, but some bluetooth
> >>PCMCIA (CF) cards have problems with kernel 2.6. Specially
> >>New SOCKET or Billionton card.
> >>There exists patch for kernel 2.6.11, which resolve problems with
> >>these cards. Look at this page for instruction:
> >>http://www.summet.com/x31/socket.html
> >>
> >>Find in archive mail with subject "Billionton(?) CF card - success".
...
>    Anyway, thanks for the help, folks, but it still doesn't work.=20
> Doesn't seem to have made any difference as far as I can see. If=20
> nobody's got any more ideas, I'll trace the bt950 driver through and=20
> compare it to the current one. Perhaps that'll give me a handle on=20
> what's happening.

don't know if this can help you, but when I made the patch mentioned
above (to get my Socket CF bluetooth card working - it worked under 2.4
but not 2.6, like yours) I compared the serial_cs modules in both kernel
versions and found that in 2.6, some code is missing which was present
in 2.4, especially everything regarding high-speed UART chips. Don't know
why all this was removed though...
Because of the missing init code the UART chip didn't get initialized
with the baud rate which hciattach supplied to the serial driver.

Regards

Mathias




--=20
Nichts auf der Welt ist so gerecht verteilt wie der Verstand.
Denn jedermann ist =FCberzeugt, da=DF er genug davon habe.
(Rene Descartes, frz. Mathematiker u. Philosoph, 1596-1650)


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
