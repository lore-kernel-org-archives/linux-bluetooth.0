Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D06E28.1000909@palmsource.com>
Date: Wed, 02 Aug 2006 11:19:36 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Sonorix Headset works with modification + sbc
	questions
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,

I've got a Sonorix (openbrain?) Headset OBH-100.
As it is a bluetooth.org certified A2DP device, it should have worked =

flawlessly at 44100hz. Maker says a failsafe value is 32000hz bitpool 44.
It had to patch a little bit to make it work :

At 44100 hz, sbc bitpool of 32, music is recognizable but too slow, and =

full of gaps.
At 32000 hz, sbc bitpool of 32, music is good, but 32000hz really loses =

quality. However, all my headsets have worked, but the audio player must =

support the conversion.
At any rate sbc bitpool of 44, music is recognizable but ways ways too =

slow, and full of gaps.

My question is : Are there restriction on using sbc encoder with bitpool =

values other than defaults?

Does anyone know if this formula is right to calculate packet length to =

give to sbc encoder? Should I take bitpool into account?

        /// 16 bits * 2 channels * 16 blocks * 8 subbands =3D 4096bits =3D =
512 o/
        codesize=3Da2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channels*2;


Thank you,

Fr=E9d=E9ric


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
