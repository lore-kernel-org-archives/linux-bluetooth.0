Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100803231814g1ef3e4fau2628b6628b2a99a@mail.gmail.com>
Date: Sun, 23 Mar 2008 22:14:22 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <18623356.28091206316878777.JavaMail.coremail@bj126app33.126.com>
MIME-Version: 1.0
References: <mailman.2498.1206236636.3062.bluez-devel@lists.sourceforge.net>
	<18623356.28091206316878777.JavaMail.coremail@bj126app33.126.com>
Subject: Re: [Bluez-devel] Jitters in A2DP
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

Hi there,

Jitters are normally handled in sink side, what is done in source side
is try to sent the packets at a constant pace, there is some headsets
like freepulse from logitech that specially requires it.
There is no point to store audio data in sbc format if you have to decode
it, but if you talking about sbcdec tool to locally decode and playback
the file so you probably found a bug. Please provide more detail about
your headset or the file, because I never saw any jitter while decoding
using sbcdec tool or even while playing with gstreamer elements diretly.

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
