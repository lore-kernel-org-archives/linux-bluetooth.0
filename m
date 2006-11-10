Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4553E166.2020503@xmission.com>
Date: Thu, 09 Nov 2006 19:18:14 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4552C81E.6020401@xmission.com> <45539A26.5080404@free.fr>
In-Reply-To: <45539A26.5080404@free.fr>
Subject: Re: [Bluez-devel] work-in-progress bluetooth audio architecture
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

Fabien

> For now i see no reason to merge sco and a2dp daemons into a single
> entity (however i have a set of reasons *not to merge them* :-)

This is what we came up when brainstorming with a group including Marcel
and Nokia developers a couple of weeks ago in Helsinki. We didn't turn
over every use case but it felt like a good approach. The next stage is
to elaborate use cases.

The idea is that the application should just open a default audio device
and the routing smarts are handled by the audio plugin (alsa/gst) in
combination with the daemon. You could just as easily have asked why the
wired audio should be involved, but it's the same argument. The user
should never have to open up preferences and change the audio device
setting in an audio client.

We should be able to tell the difference between an open that needs to
read and write audio (typically for sco) from an open that only writes
(typically for a2dp). If not, we can file a bug. Similar to apps that
won't let the user choose the headset alsa device--it's a bug in the app.

The gui that communicates over dbus will take care of initiating
connect/disconnect and advanced routing, such as enabling both a2dp and
wired output simultaneously.

Which cases are you worried will be trouble?

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
