Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 13 Jul 2006 13:50:20 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060713125020.GA23616@srcf.ucam.org>
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E85@eumonex01.palmsource.com>
	<20060713105346.GA22651@srcf.ucam.org>
	<44B63E89.1000403@palmsource.com>
Mime-Version: 1.0
In-Reply-To: <44B63E89.1000403@palmsource.com>
Subject: Re: [Bluez-devel] RE : A2DP plugin success with HP
	bluetooth	headphones
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

On Thu, Jul 13, 2006 at 02:37:29PM +0200, Fr=E9d=E9ric DALLEAU wrote:

> Hi, what sort of audio are you sending?

44.1 KHz MP3 - it doesn't seem to be specific to any file. I'm using =

the ALSA plugin with beep-media-player.

> Do you know if it is 48000hz or 44100 hz. I believe it is 48000 that =

> would explain why it is slower. But it should not be that dreadful! What =

> is your cpu also?

It looks like it should be running at 44.1KHz. This is on a 1.2GHz =

Pentium M. A quick play suggests that it hits the "overslept" codepath =

in a2dpd very frequently - should this be the case?

-- =

Matthew Garrett | mjg59@srcf.ucam.org


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
