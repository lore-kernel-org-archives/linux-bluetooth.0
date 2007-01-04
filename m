Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <459D3730.6080504@gmx.de>
Date: Thu, 04 Jan 2007 18:19:44 +0100
From: Siegbert Baude <siegbert.baude@gmx.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <459D10F6.8090509@uni-ulm.de> <459D26CF.5030709@palmsource.com>
In-Reply-To: <459D26CF.5030709@palmsource.com>
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

Hi Fr=E9d=E9ric,

Fr=E9d=E9ric DALLEAU schrieb:
> page 53 says join[sb] is nrof_subbands-1 bits wide =3D> wich is 7 bits.

Oh, my blindness. Thanks a *lot* for the hint, maybe I didn't read it =

carefully enough, because the decoding code sample I looked first at, =

was evaluating nrof_subbands instead of nrof_subbands-1.

> The 8th bit is the RFA which is 0.
> 0xBC =3D 10111100, The first 7 bits are the join table, the last bit is =

> the rfa.
> Then 87 is already the scale factors.

Yep, now it makes sense.
BTW, is this the right list to ask SBC-specific questions? I have some =

more general questions, e.g. I don't quite understand the rationale =

behind the codec definition: If you choose joint mode for encoding, it =

happens that the encoder does not use joint mode for all subbands. But =

why? Saving bits? If anybody has a pointer to some documentation for =

SBC, which explains the design decisions I would be really happy.


Ciao
Siegbert

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
