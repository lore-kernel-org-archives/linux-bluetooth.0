Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45AC4952.6060001@xmission.com>
Date: Mon, 15 Jan 2007 20:41:06 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <D8CE9CFA707C894180BAC8CDD154F8460AD538BE@msiexch01.marvell.com>
	<Pine.LNX.4.64.0701152257480.8201@cherokee.spacecom.si>
In-Reply-To: <Pine.LNX.4.64.0701152257480.8201@cherokee.spacecom.si>
Subject: Re: [Bluez-devel] a2dpd xmms and hbh-ds970
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

Mitja

> I recently got myslef a HBH-DS970 headset and yesterday I tryed it with =

> latest CVS version of plugz on FC6. It works great with VLC, but not with =

> xmms or a2play. With xmms it is really sped up, I tryed setting it to =

> lower frequency but it did not solve the issue, with a2play it is choppy =

> and just a little bit faster than it should be. I tryed it with Level 1 =

> BC4-external and Anycom USB-250 with latest firmware and the resoults are =

> the same, it should be some issue with headset. Do you perhaps have =

> any idea, where should I look, to fix it for xmms, as it is strange that =

> in VLC the sound of mp3s and movies is perfect? Oh and AVRCP in xmms =

> works.

it sounds like a sample rate conversion issue. maybe xmms is expecting
the plugin to handle a rate it can't really do. Fr=E9d=E9ric might have more
ideas.

brad

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
