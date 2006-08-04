Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D30F07.4050509@palmsource.com>
Date: Fri, 04 Aug 2006 11:10:31 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>	<44D0350A.8090904@xmission.com>	<3837d8b10608020729i5bab5ea6vbc18b0ad502b11de@mail.gmail.com>	<44D17895.6050001@xmission.com>	<3837d8b10608030747v551aa4a7t719aa57aa5ffc986@mail.gmail.com>
	<44D24BD3.4010404@xmission.com>
In-Reply-To: <44D24BD3.4010404@xmission.com>
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

Hi all,
I've been thinking this morning about the plans and here are my thought :

Brad Midgley a =E9crit :

>keith
>
>  =

>
>>I took you suggestion and this corrected the problem.  Attached is a patc=
h.
>>    =

>>
>thanks for taking the time to see this was the right workaround. i
>merged it.
>  =

>
I did something similar in a2dpd. Some headsets try to be initiator when =

they receive a connection (the sonorix does this)
The best way of handling this is to reject the frame.
Will submit patch later in the day.

>>Just as a side note (maybe this deserves a new thread).   I'm been
>>looking a lot through the archives, but I am still wondering what is the
>>current state of progress in the bluetooth-alsa project?  What work
>>still need to be done?   I have interest in furthering the project and
>>more notably, my employer also has interest.   We are working on support
>>for embedded arm platform and are looking for integration possible with
>>gstreamer as most of our audio framework will use gstreamer. =

>>    =

>>
>
>alsa is great for the desktop but elsewhere it's problematic. embedded
>platforms shouldn't have to spend 1MB of ram and flash for a layer that
>could be factored out. i'd like to see proper gstreamer plugins (i
>started them from a template but didn't put them up yet). this is also a
>win for headsets that have an mp3 decoder--using gstreamer the a2dp
>source would just send the mp3 as-is and can save on batteries *and*
>avoid the fidelity problems with reencoding.
>
>this was in another thread. the only comment was that the name "wavez"
>is already in use... i think that's ok for a small side project like
>ours. this is where we should be headed.
>
>- minimal update to btsco documents to bring in line
>- make a btsco snapshot release .43
>- use new wavez sourceforge project for alsa (both sco and a2dp)
>plugins, for a2play test code and eventually gstreamer plugins
>- create wavez as a cvs project (was tempted by svn but there's a
>learning curve for everyone)
>- leave out libsbc from the new project so we cleanly use the standalone
>library
>- eventually remove pieces from bluetooth-alsa's btsco project (alsa
>plugins etc) to leave it mostly as it originally was, just the kernel
>sco audio
>- obviously refactor the documentation, simplifying btsco and updating wav=
ez
>
>brad
>  =

>
The a2dpd allow you to use whatever framework you need, since it's a =

socket connection, minor fixes would allow to send mp3. However, the use =

of alsa do not seems to me as such a big problem, moreover we still need =

some kind of hardware abstraction. A gstreamer plugin is still a great =

improvement  : an application could either load alsa or gstreamer. Have =

anyone measured the cost of integrating gstreamer instead of alsa?

Now for the plans be careful : I'm biaised toward a2dp and alsa.

I agree that documents needs to be written but as lots of things have =

changed again. But we should think about features we miss before.

A new release would be cool, specially if a2dpd is enabled by default =

:D. We should also try to simplify setup and usage. Things like writing =

the .asoundrc can be automated. We can also create start/stop scripts =

for a2dpd in /etc/init.d and we should provide screenshots of =

parameterizing applications. I thought about automatically starting the =

daemon when a plugin is loaded + ending daemon on timeout but this will =

disallow the use of avrcp. What bout automaticaly start daemon but do =

not end daemon after that!

IMHO changing the name of the project can be harmfull. All existing =

referencing will be lost and knowledge like the current mailing list =

will have to be moved. wavez do not indicate anything related to =

bluetooth neither sound.

About toys projects, they should be kept in: I loved what Andrew did by =

playing with these projects. The difference should be between what is =

installed and what is not installed. (bin_PROGRAMS vs noinst_PROGRAMS). =

However, installed projects should be bulletproof.

Also, we should keep libsbc for now  but we need to make sure we can =

build a2dp without installing libsbc first. This IS possible and should =

be done. Alsa, and bluetooth are already setup everywhere. but sbc =

really isn't. It would be better to have a one step setup project.


About bugs and features we miss before being really strong :
- A2DP acceptor role
- alsa mmap problem
- manages phone calls and a2dp at a time
- allow alsa to discover ctl and pcm plugins


About features for future:
- A2DP SINK for pc computer? So that when you go home you can listen =

music with your home sound system.
- The same for SCO : answering your mobile phone with pc speakers would =

be fun. Specially in open space :D
- I would also love to see SCO in a2dpd. The work of fabien will =

certainly be easy to integrate. The config file now make this possible =

(what about rereading the config file periodically to face changes)
- Some user interface to select between possible outputs (changing =

config file).
- Handling a wider variety of frame rates and channels numbers.
- Handling of mp3

You read me till the end, bravo!

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
