Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050821215602.GA19979@externe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] Rescuing a WML C09 AHR by SPI
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
Date: Sun, 21 Aug 2005 17:56:02 -0400

Hello

I have a problem with a WML C09 AHR bluetooth module purchased from
Segor Germany.

The problem is similar to:
http://www.handhelds.org/hypermail/familiar/132/13253.html

I had a kernel panic while issuing commands to the module (I'm working
on some MMC stuff hooked to the same serial port, but to
DSR/DRT/RI/DCD lines and my stuff is not that stable)

Result: I could only write 1f9 0001 - I couldn't do the 191 part.

I tried the recommanded rescue mode from CSR forums:
http://66.102.9.104/search?q=3Dcache:XnYWRYWUhSsJ:www.csr.com/ubb/Forum2/=
HTML/000185.html+pskey+csr+but&hl=3Dfr&client=3Dfirefox-a

Unfortunately, it didn't work. I would like to try to rescue the chip
via its SPI port since it is easily accessible.

My problem is I don't know how to do that (any link is appreciated) on
both the hardware side and the software side (!)

Maybe someone can help?

If that's not possible, any suggestion to purchase a new bluetooth
module (ideally with UART/USB/PCM/SPI ports and an integrated antenna)

Guylhem

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
