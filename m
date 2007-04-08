Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2b1fa7660704080119s2275a60dm40655cbf9d6b3ba7@mail.gmail.com>
Date: Sun, 8 Apr 2007 20:19:33 +1200
From: "Thomas Kear" <thomas.kear@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0704071440m7b05678fs5c3bea4d2cf28a4c@mail.gmail.com>
MIME-Version: 1.0
References: <57c68ddc0704071440m7b05678fs5c3bea4d2cf28a4c@mail.gmail.com>
Subject: Re: [Bluez-users] using class 1 dongle
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

The "100 metre" range depends on both devices being class 1.  If you
have a class 1 device talking to a class 2 (10m) device, your maximum
range may be higher than 10 metres due to the increased transmit power
and recieve sensitivity, but won't be anything like 100m.

Unlike 802.11 there is no user-adjustable transmit power either,
you're stuck with the dongle figuring that out for you.

If your phone is class1 (a few are, but 99.5% are class2) then you
genuinely have an issue, which could be as simple as a wall in the way
which is blocking the signal, or as difficult as your neighbour having
a leaking microwave oven.

On 08/04/07, siddhant tewari <siddhant.tewari@gmail.com> wrote:
> hi,
>    I am using class 1 dongle which says it has 100 mt range , but to my
> surprise using this dongle i cannot search my mobile phone which are even
> around 30 - 40 mts.
>
> Are there any special commands which should be issued to the microprocessor
> in the dongle so that its full range can be exploited.
>
> and
>
> Are there any set of instruction by which i can verify the range of the
> dongle.
>
> Also can anyone tell me about the class 1 dongle they use , their experience
> and the range to which their dongle can detect devices.
>
> regards
> siddhant
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>


-- 
Thomas Kear
thomas.kear@gmail.com
+6421996496

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
