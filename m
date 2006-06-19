Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44965944.6090908@palmsource.com>
Date: Mon, 19 Jun 2006 09:59:00 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C6278.1040707@palmsource.com>
	<447C6598.6050107@xmission.com>	<447C69D4.9020504@palmsource.com>
	<447C7330.9000303@xmission.com> <44963723.4040807@xmission.com>
In-Reply-To: <44963723.4040807@xmission.com>
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

Hi brad,

>I put code in a2play so it will listen on the control link for
>suspend/resume from a2dp headset (*if* you use -p for pthreads). This
>should be a decent model for getting it into the alsa plugin if you want
>to look at that.
>  =

>
I will have a look by the end of the week.

>This is how we find out a combo headset is taking a voice call.
>  =

>
I noticed that my headset stopped streaming when pressing the main =

button and didn't get back playing after pressing the button again.
Is that what you mean?

>Frankly it may be messy getting those signals to the media player. It
>would be easier to make the alsa plugin just throw away audio it gets
>while the set wants things suspended.
>  =

>
Yes for sure, and it's not bad IMHO, you would not like your speaker do =

some sound if you answer a phone call!

>We're still missing something here... we don't listen for new control
>connections from the set. You could look at a2recv.c for code that will
>listen for new connections. This will be more complicated since you may
>want to use dbus to start up the media player in response.
>  =

>
I was wondering how to generate such connections? Simply switch on the =

headset? Any ideas?

Fr=E9d=E9ric.



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
