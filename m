Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <christian.hoene@gmx.net>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Mon, 17 Nov 2008 16:57:48 +0100
Message-ID: <000801c948cd$41364120$c3a2c360$@hoene@gmx.net>
MIME-Version: 1.0
Subject: [Bluez-devel] Bug in SBC
Reply-To: hoene@uni-tuebingen.de,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

Let me forward some comments from Frans de Bont, the inventor of SBC. He
found a bug in the encoder but is not allowed to change the BlueZ
implementation. Thus, I forward you his error description because these
weeks I hardly have any time to look at the source code myself and - I have
to admit - I am getting older and coding lazy.

With best regards,
 
 Christian Hoene

PS:
Here Frans comments:

I also have taken a quick look into the filtering part of the encoder. It
seems that this code does not behave as the reference code. Unfortunately, I
cannot disclose this part of the reference source code. However, if someone
wants to correct this, the flow chart in the MPEG-1 Audio standard could be
taken as an example with slightly difference parameters, i.e. subbands=32
and filterlength=512.

You can find the referred flow chart in Figure C.4 on page 78 (in my version
of the ISO/IEC 11172-3 standard). Please note that the decoder flow charts
in A2DP have been derived from Figure A.2 on page 39.

You can find ... public version on:
http://www.mp3-tech.org/programmer/docs/iso11172-3.zip

For the encoder filterbank, you can find this in annex_c.doc, page 13,
FIGURE 3-C.2, "Layer I, II encoder flow chart".
The decoder filterbank is shown in annex_ab.doc, page 2, Figure 3-A.3,
"Layer III decoder flow chart".

BTW, I noticed that earlier versions of the Bluez SBC codec are indeed based
on the MPEG-1 flow charts. Probably the conversion from floating-point to
fixed-point has introduced the quality degradation.

Best regards,
Frans



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
