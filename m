Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 8250.c kernel patch for Socket CF bluetooth card
Message-ID: <20050820220413.GA29166@adamis.de>
References: <1124468372.2968.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1124468372.2968.76.camel@localhost.localdomain>
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
Date: Sun, 21 Aug 2005 00:04:13 +0200

On 19.08.05 17:19:32, Kevin Page wrote:
> Firstly, I can confirm that the patch to 8250.c (posted to this list by
> Mathias Adam on 2005-03-05) applies cleanly to 2.6.12 (Fedora patched
> kernel 2.6.12-1.1398_FC4), and that with this patch my Socket
> CompactFlash bluetooth card works again (without it I get the "BCSP
> timed out" error on hciattach).

great  :-)

> Secondly, does anyone know if this patch has already been pushed
> upstream to the kernel?

I have sent it to someone which was mentioned as the maintainer of this
kernel code some time ago, but didn't get an answer...
What else could I/one do to get this into the standard kernel? I don't
know much about linux kernel development processes though...
At least I got notes from a number of people who used this patch
successfully so I think it would be very useful to put it into the
kernel.

Regards,
Mathias


--=20
Der Jammer der Menschen ist, da=DF die Narren so sicher sind und die
Klugen so voller Zweifel. (Bertrand Russel)


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
