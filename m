Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447C1C70.1030309@palmsource.com>
Date: Tue, 30 May 2006 12:20:32 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>	<4464C195.1020403@xmission.com>
	<446B54AF.5040302@palmsource.com> <447A9C7B.2040301@xmission.com>
In-Reply-To: <447A9C7B.2040301@xmission.com>
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
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

Hi brad,

>>>>    * How to select whether the application will output on a2dp or
>>>>speaker? Should this be application related or system related?
>>>>        =

>>>>
>
>Ideally it's a system function, but I'm not seeing a way to pull that off.
>  =

>
gstreamer makes it easy to write applications, but application writer =

can choose whatever sink he wants. We cant rely on application being =

a2dp aware.
To provide system level functionnality, a good place is inside the sound =

daemon like esd. esd already does the mixing and ipc stuff.
The main drawback is that this would restrict usage to gnome apps.

I just saw a media system selector (gstreamer-properties) but I haven't =

figured its role. Is that a sort of default gstreamer audio sink?

>gstreamer has no ipc equivalent to the alsa dmix, so a pure gst
>implementation will not mix multiple apps down to one stream.
>  =

>
I've played a bit with dmix but did not have it working. It seems to =

only redirect sound to hardware sound cards. gonna ask on alsa mailing list.

>that is unless you help write the ipc mixer for gst :)
>  =

>
The only sort of ipc I know that would suit would be ip sockets... We =

will end up writing a sound server like esd and we would still need to =

write a plugin and a gstreamer sink.

gstreamer provides a tcpserver sink and source but it does not work the =

way i want it to. The server will block until a client connect. Multiple =

client are not allowed.

However, mixing might be a fake problem. Maybe we should first figure =

what applications uses alsa directly. All the popular apps (xmms/totem) =

seems esd and arts aware.

Fr=E9d=E9ric



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
