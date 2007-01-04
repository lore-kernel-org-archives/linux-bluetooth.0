Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <459D26CF.5030709@palmsource.com>
Date: Thu, 04 Jan 2007 17:09:51 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <459D10F6.8090509@uni-ulm.de>
In-Reply-To: <459D10F6.8090509@uni-ulm.de>
Subject: Re: [Bluez-devel] SBC codec, joint stereo mode
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

Hi,

page 53 says join[sb] is nrof_subbands-1 bits wide =3D> wich is 7 bits. =

The 8th bit is the RFA which is 0.
0xBC =3D 10111100, The first 7 bits are the join table, the last bit is =

the rfa.
Then 87 is already the scale factors.

Frederic

Siegbert Baude a =E9crit :
> Hi,
>
> I have a question with regard to joint stereo mode in SBC. According to
> the A2DP spec. p. 53, sec. 12.4 "Syntax" in the frame_header there is
> one bit RFA after the join[sb] bits. In the example implementations of
> the SBC codec I got (one from TI, one from iAnywhere AV SDK, one from
> the ALSA-Bluetooth project), this bit is however never accounted for.
> Also in the sbc_test_14.sbc example you can download from bluetooth.org,
> I find at offset 04FB the beginning of the frame as 9C7F797BBC87, where
> the first bit of "87" should be this RFA bit (as this example uses 8
> subbands). P. 11, sec. 1.3.2.1 "RFA" however says, RFA bits should be
> set to zero, which is not the case for "87".
>
> So is this RFA bit actually used or not?
>
> Ciao
> Siegbert
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   =



-- =

Frederic

Without the wind, the grass does not move.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
