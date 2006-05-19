Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] New bluez headset implementation
References: <446CDD43.3050604@free.fr>
In-Reply-To: <446CDD43.3050604@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605191016.45394.denis.kenzior@trolltech.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 19 May 2006 10:16:45 +1000

I would be interested in playing with this as well.

-Denis

On Friday 19 May 2006 06:46, Fabien Chevalier wrote:
> Hello all, i've been spending most of my spare time in the past
> month writing an alternative implementation to btsco for headsets support.
> The starting point was me being frustrated not to be able to use my
> laptop for VoIP because of crappy microphones the manufacturers usually
> put in. So my goal now is to go wireless with bluetooth. :-)
> So here i am. The software i wrote is now mature enough to be shared
> with others.
>
> What i'm looking for now is peer review from experienced bluez
> developpers about it. But that's enough about me, let's talk about the
> software :-)
>
> So What's In ?
>
> What is implemented is the AG side of the headset profile. Both Headset
> initiated connections and access gateway initiated connections are
> supported. It does not support A2DP, as it is another profile, and
> moreover people here are already working on the subject :-)
>
> The spirit that governed the design was the following:
>    - be able to handle voice over IP applications well (this means
> keeping buffering at a minimum for a reduced latency)
>    - make it easy to use for open source VoIp apps developpers (the idea
> is that it should be very easy for the apps to provide some basic
> support for bluetooth headsets with no change to the application itself)
>    - support 100% of bluetooth headset profile (device
> connect/disconnect, headset button push)
>
> The architecture is the following:
>    - 1 daemon, responsible for doing SDP, handling RFCOMM and SCO
> channels, parsing AT commands, sending DBUS signals when things happen.
> The daemon handles application requests (referred to as AG initiated
> connection in HSP spec) or headset connection requests (referred to as
> HS initiated connection in HSP spec)
> The daemon also handles session caching between PCM open/close.
>    - 2 ALSA user space IO plugins (1 control, 1 PCM). Both of them
> communicate with the daemon using unix sockets. The PCM also has an
> instance of the SCO socket, so that it can reads/write data directly to it.
>
> Compared to btsco, it differs in the following way:
>    - it is 100% userspace. No more kernel module.
>    - all parameters are supplied by the application to the alsa pcm
> plugin, that will eventually forward them to the daemon. This will make
> implementation of user friendly MMI much easier (in particular, there
> is no need to lauch the daemon separately with a predefined BD address.
> The gui will thus be able to provide bd address).
>    - it handles only one active headset at a time
>    - it supports HS initiated connections as well
>    - codebase cleaner. It should be possible with minimal pain to
>      support handsfree profile.
>
> Still to be done :
>    1) more testing
>    2) DBUS signalling to tell the world about connected /
> disconnected / button pushed events.
>    3) some kind of switching from headset to an alternate sound device
> in case the headset is unavailable.
>    4) interoperability testing against a variety of devices.
>    5) document the design
>    6) debug kernel sco support (more on that on a separate e-mail)
>
> I'm likely to do 3), 5), however 1 and 2 might be better handled
> by somebody else, and 4 is just everybody's work :-)
>
> Where to get the software:
>    Simple! On my hard disk!!   No i'm kidding... but in fact not
> completely. ;-)
>    I don't wanna start a whole open source project for such a small
> thing. So for now i will send it by private e-mail to developers
> interested in giving it a try. Just reply to this e-mail if you are
> interested.
>
> How to play with the software:
>    - use standard aplay/arecord tools (not very funny)
>    - use xmms (a litte more funny :-) )
>    - use ekiga 2.0.1 (top fun!- however you will need to patch it and
> rebuild it)
>
>
> Fabien
>
>
>
>
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
