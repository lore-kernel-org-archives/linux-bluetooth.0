Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <447C7330.9000303@xmission.com>
References: <447C6278.1040707@palmsource.com>
	<447C6598.6050107@xmission.com> <447C69D4.9020504@palmsource.com>
	<447C7330.9000303@xmission.com>
Date: Tue, 30 May 2006 18:33:32 +0200
Message-Id: <1149006812.11251.31.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] A2DP Profile Certification
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

Hi Brad,

> > We must be very careful here : The ICS says the Source must accept 
> > connection establishment, this is different from the sink role because 
> > the source will accept the connection and then send its audio stream!
> 
> ok. yes, we're missing a lot of stuff here that we need to handle.
> 
> we need to use "sdptool add A2SRC" to advertise the source. we need to
> listen for new connections and keep listening on the control connection
> during playback (maybe in another thread)
> 
> the alsa plugin can't just block audio writes when the stream is
> stopped. most alsa clients do not have a separate transmission thread,
> so the ui will lock up. the way to handle it is to use dbus to tell the
> audio app to pause if possible.
> 
> there is a lot of overlap with avrcp here, so we should make it easy to
> work that in too.

it might be a good idea to integrate everything into a deamon and only
have a stupid ALSA plugin that sends us the PCM data.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
