Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447A9C7B.2040301@xmission.com>
Date: Mon, 29 May 2006 00:02:19 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>
	<4464C195.1020403@xmission.com> <446B54AF.5040302@palmsource.com>
In-Reply-To: <446B54AF.5040302@palmsource.com>
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

I've been discussing this over at the gstreamer list and I have some
more info.

>>>     * How to select whether the application will output on a2dp or
>>> speaker? Should this be application related or system related?

Ideally it's a system function, but I'm not seeing a way to pull that off.

> How about a daemon that uses gstreamer with one or more ipc gstreamer
> source, a mixmatrix, volume control (if not done by mixmatrix), (alsa
> sink or (sbcfilter and a2dp sink)) to finish...
> An alsa plugin and/or a gstreamer ipc plugin would just send ipc to the
> daemon.

gstreamer has no ipc equivalent to the alsa dmix, so a pure gst
implementation will not mix multiple apps down to one stream.

that is unless you help write the ipc mixer for gst :)

sadly, gst would really be a great implementation (moving the encoder
into a hotpluggable module, allowing for late binding on choosing the
encoder, possibly a way to redirect a stream in progress to the set) but
the lack of a way to mix multiple apps is not great.

Brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
