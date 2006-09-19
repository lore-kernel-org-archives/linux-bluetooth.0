Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: joakim@verona.se
Date: Tue, 19 Sep 2006 09:36:21 +0200
Message-ID: <m34pv4ux3e.fsf@kurono.home>
References: <m33bapwl0u.fsf@kurono.home> <450F208F.4080204@xmission.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] a2play and btsco questions
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Brad Midgley <bmidgley@xmission.com> writes:

> joakim
>
>> I'm using my HBH-DS970 headset with a2play, and it works nicely.
>> However, I would also like o use the daemon functionality of the btsco
>> key daemon at the same time, so as to control playback with the
>> headset butons. Is this possible?
>
> well it might be possible for you to hack something together using the
> btsco settings file.
>
> if your headset supports avrcp, you should be able to use the alsa
> plugin and a2dpd daemon to control playback. that would be more flexible.

According to the docs I need a2play to play stereo, since the
HBH-DS970 supports stereo. Has this requirement changed? It would be
much nicer wih a proper alsa device of course.

>
> brad
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

-- 
Joakim Verona
http://www.verona.se


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
