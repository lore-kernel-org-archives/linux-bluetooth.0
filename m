Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to use BT headset as microphone and the
	souncard as output
From: Tony Clark <tclark@bredband.net>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42BF39A6.2020305@lesagepono.be>
References: <42BB64FE.4070002@lesagepono.be>
	 <42BF39A6.2020305@lesagepono.be>
Content-Type: text/plain; charset=utf-8
Message-Id: <1119846705.31327.2.camel@power>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 27 Jun 2005 06:31:45 +0200

On Sun, 2005-06-26 at 23:26 +0000, Laurent Lesage wrote:
> Well, I have part of the answer. I just used " cat /dev/dsp1 > /dev/dsp=
" =

> to re-route from the BT headset to the sound card. It works but there i=
s =

> a delay of around one second : this is annoying if it has to be used fo=
r =

> a conference or training.
> =

> What is this delay due to?
> =

> Any idea appreciated :-)
> =

> Laurent
> =

> Laurent Lesage a =C3=A9crit :
I think from memory the best you will get it down to is around .5sec.  A
BT mic is probably not want for doing presentations, a normal wireless
mic should be much better.

tony



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
