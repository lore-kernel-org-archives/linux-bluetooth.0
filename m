Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D35F70.7070101@xmission.com>
Date: Fri, 04 Aug 2006 08:53:36 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>	<44D0350A.8090904@xmission.com>	<3837d8b10608020729i5bab5ea6vbc18b0ad502b11de@mail.gmail.com>	<44D17895.6050001@xmission.com>	<3837d8b10608030747v551aa4a7t719aa57aa5ffc986@mail.gmail.com>	<44D24BD3.4010404@xmission.com>
	<44D30F07.4050509@palmsource.com>
In-Reply-To: <44D30F07.4050509@palmsource.com>
Subject: Re: [Bluez-devel] Bluetooth Headset Error
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

Fr=E9d=E9ric

> The a2dpd allow you to use whatever framework you need, since it's a =

> socket connection, minor fixes would allow to send mp3. However, the use =

> of alsa do not seems to me as such a big problem, moreover we still need =

> some kind of hardware abstraction. A gstreamer plugin is still a great =

> improvement  : an application could either load alsa or gstreamer. Have =

> anyone measured the cost of integrating gstreamer instead of alsa?

Fr=E9d=E9ric I thought if anyone had to worry about constraints in embedding
it would be you. If not, then you have the perfect job... embedded linux
hacking without management telling you to optimize, optimize :)

In any case, I thought ALP was already going to use gstreamer, so the
difference is in effect just the size/overhead of alsa?

> A new release would be cool, specially if a2dpd is enabled by default =

> :D. We should also try to simplify setup and usage. Things like writing =

> the .asoundrc can be automated. We can also create start/stop scripts =

> for a2dpd in /etc/init.d and we should provide screenshots of =

> parameterizing applications. I thought about automatically starting the =

> daemon when a plugin is loaded + ending daemon on timeout but this will =

> disallow the use of avrcp. What bout automaticaly start daemon but do =

> not end daemon after that!

choosing the headset should also be easy and not require typing in an
address (and usually not a pin! they're all 0000 or 8888)

> IMHO changing the name of the project can be harmfull. All existing =

> referencing will be lost and knowledge like the current mailing list =

> will have to be moved. wavez do not indicate anything related to =

> bluetooth neither sound.

There are distro people and others using the older code in btsco. I want
to have a new project that does not have to include and build btsco. It
should be maintained independently. I could just do a different cvs
project within bluetooth-alsa maybe.

> About toys projects, they should be kept in: I loved what Andrew did by =

> playing with these projects. The difference should be between what is =

> installed and what is not installed. (bin_PROGRAMS vs noinst_PROGRAMS). =

> However, installed projects should be bulletproof.

ok, yeah, the playground has been great. I was excited to see you picked
up one of the avrcp prototypes from the playground and integrated it.

btw, are you basing on avsnd or avrecv? (ie are you listening for
connections or making them or both)

> Also, we should keep libsbc for now  but we need to make sure we can =

> build a2dp without installing libsbc first. This IS possible and should =

> be done. Alsa, and bluetooth are already setup everywhere. but sbc =

> really isn't. It would be better to have a one step setup project.

I believe libsbc inside btsco is not being built properly for use in
another shared object. We get away with it on intel because they've
worked out a way to relocate code that doesn't work on other
archictectures.

I want to keep the hybrid fixed/floating around somewhere for
experimenting but work mostly on the fixed-only version. The hybrid is
what's in btsco/sbc and the fixed-only is in the separate sbc project.
messy.

> - I would also love to see SCO in a2dpd. The work of fabien will =

> certainly be easy to integrate. The config file now make this possible =

> (what about rereading the config file periodically to face changes)

it would be nice to make it all work together. then rename a2dpd? :)

> You read me till the end, bravo!

sure. it's all good fun.

brad

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
