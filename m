Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100802080628p20a0a214ua8d451b03edb509@mail.gmail.com>
Date: Fri, 8 Feb 2008 11:28:53 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <682955.71764.qm@web94001.mail.in2.yahoo.com>
MIME-Version: 1.0
References: <682955.71764.qm@web94001.mail.in2.yahoo.com>
Subject: Re: [Bluez-devel] problem in audio service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

>>From the debug log what I can assume is that your device is not
responding to a sco connect request,
normally this happens when your device is off or not accepting connections.

ps: Make sure the device is in pairing state.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
