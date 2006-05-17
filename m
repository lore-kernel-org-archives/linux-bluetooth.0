Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <446B6019.9030806@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com> <4464C195.1020403@xmission.com> <446B54AF.5040302@palmsource.com>
In-Reply-To: <446B54AF.5040302@palmsource.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 17 May 2006 10:40:41 -0700

Frédéric

> How about a daemon that uses gstreamer with one or more ipc gstreamer
>  source, a mixmatrix, volume control (if not done by mixmatrix),
> (alsa sink or (sbcfilter and a2dp sink)) to finish... An alsa plugin
> and/or a gstreamer ipc plugin would just send ipc to the daemon.

I will ask on the gstreamer list. When reading the gstreamer docs it
seems like the "sky's the limit." I wish I could understand the
limitations better.

> Why not sharing code between a2play and alsa-plugin? There are some
> variables that are shared among instances (bufe,lenbufe,tsend,...)
> why are they globals? There is a snd_pcm_a2dp_t structure that would
> (IMHO) embed them very well. Is this alsa related limitation? This
> forbid using multiple headsets at a time...

Marcel wanted to leave this stuff out of bluez for now but avrcp/a2dp
signaling would best fit there if they are to be shared.

alsa-plugin is a little messier than our typical bluetooth-alsa
component. yes, a bunch of those should not be global variables and some
further cleanup is in line. An even bigger problem is we essentially
ignore the return value from write(). I want to figure out how things
can fail there and what we should do to recover.

> Now that cvs works, how to propose patches? on the list? By creating
> a sf developper account?

please submit patches here to the list for now.

brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
