Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0802100246s6a242747w2f69a128b36a109e@mail.gmail.com>
Date: Sun, 10 Feb 2008 11:46:16 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] sendto does not compile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I get the following errors

main.c:355: error: 'marshal_VOID__STRING_STRING_UINT64' undeclared
(first use in this function)
main.c:355: error: (Each undeclared identifier is reported only once
main.c:355: error: for each function it appears in.)
main.c:359: error: 'marshal_VOID__UINT64' undeclared (first use in
this function)

Jaap

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
