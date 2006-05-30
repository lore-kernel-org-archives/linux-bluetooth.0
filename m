Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447C7508.6060200@xmission.com>
Date: Tue, 30 May 2006 10:38:32 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>	<4464C195.1020403@xmission.com>	<446B54AF.5040302@palmsource.com>
	<447A9C7B.2040301@xmission.com> <447C1C70.1030309@palmsource.com>
In-Reply-To: <447C1C70.1030309@palmsource.com>
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

Fr=E9d=E9ric

> gstreamer provides a tcpserver sink and source but it does not work the =

> way i want it to.

yeah too bad... gst folks could recommend the easiest approach to code
up a fix.

> However, mixing might be a fake problem. Maybe we should first figure =

> what applications uses alsa directly. All the popular apps (xmms/totem) =

> seems esd and arts aware.

totem and amarok at least have gstreamer "ports" now, but that might be
mainly to get the best codec the os can provide.

i have not looked at all into having esd/arts working with our alsa
plugin. they may need patching to look for plugins, to open on demand,
and to briefly cache unneeded connections.

brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
