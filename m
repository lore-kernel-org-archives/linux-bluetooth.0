Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44963723.4040807@xmission.com>
Date: Sun, 18 Jun 2006 23:33:23 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C6278.1040707@palmsource.com> <447C6598.6050107@xmission.com>
	<447C69D4.9020504@palmsource.com> <447C7330.9000303@xmission.com>
In-Reply-To: <447C7330.9000303@xmission.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric,

>> We must be very careful here : The ICS says the Source must accept =

>> connection establishment, this is different from the sink role because =

>> the source will accept the connection and then send its audio stream!
> =

> ok. yes, we're missing a lot of stuff here that we need to handle.

I put code in a2play so it will listen on the control link for
suspend/resume from a2dp headset (*if* you use -p for pthreads). This
should be a decent model for getting it into the alsa plugin if you want
to look at that.

This is how we find out a combo headset is taking a voice call.

Frankly it may be messy getting those signals to the media player. It
would be easier to make the alsa plugin just throw away audio it gets
while the set wants things suspended.

We're still missing something here... we don't listen for new control
connections from the set. You could look at a2recv.c for code that will
listen for new connections. This will be more complicated since you may
want to use dbus to start up the media player in response.

Brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
