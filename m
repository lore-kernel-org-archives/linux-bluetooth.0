Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <459D10F6.8090509@uni-ulm.de>
Date: Thu, 04 Jan 2007 15:36:38 +0100
From: Siegbert Baude <siegbert.baude@uni-ulm.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] SBC codec, joint stereo mode
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I have a question with regard to joint stereo mode in SBC. According to
the A2DP spec. p. 53, sec. 12.4 "Syntax" in the frame_header there is
one bit RFA after the join[sb] bits. In the example implementations of
the SBC codec I got (one from TI, one from iAnywhere AV SDK, one from
the ALSA-Bluetooth project), this bit is however never accounted for.
Also in the sbc_test_14.sbc example you can download from bluetooth.org,
I find at offset 04FB the beginning of the frame as 9C7F797BBC87, where
the first bit of "87" should be this RFA bit (as this example uses 8
subbands). P. 11, sec. 1.3.2.1 "RFA" however says, RFA bits should be
set to zero, which is not the case for "87".

So is this RFA bit actually used or not?

Ciao
Siegbert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
