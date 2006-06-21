Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <449978BC.8020202@palmsource.com>
Date: Wed, 21 Jun 2006 18:50:04 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C6278.1040707@palmsource.com>	<447C6598.6050107@xmission.com>	<447C69D4.9020504@palmsource.com>	<447C7330.9000303@xmission.com>
	<44963723.4040807@xmission.com> <44965944.6090908@palmsource.com>
In-Reply-To: <44965944.6090908@palmsource.com>
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

I've been looking at what you did in a2play.

>>I put code in a2play so it will listen on the control link for
>>suspend/resume from a2dp headset (*if* you use -p for pthreads). This
>>should be a decent model for getting it into the alsa plugin if you want
>>to look at that.
>>    =

>>
>I will have a look by the end of the week.
>  =

>

I used -p options but I have some problems :
When reading /dev/rtc, I always read 0x8C0 and I only get 50 read per =

sec. If you strip the low byte, it's 8 ticks but the sbc data is 23 ms =

long (190 ticks). So decreasing the tick count to 0 nefore sending data =

takes nearly one second and I have intermittent sound. I fixed it by =

commenting out the "while(ticks <=3D 0)" line, I also tried smaller rtc =

frequency without success. Why not use gettimeofday?

>>This is how we find out a combo headset is taking a voice call.
>>
> noticed that my headset stopped streaming when pressing the main =

>button and didn't get back playing after pressing the button again.
>Is that what you mean?
>  =

>
I don't receive control commands when doing this. What model do you use?

>>We're still missing something here... we don't listen for new control
>>connections from the set. You could look at a2recv.c for code that will
>>listen for new connections. This will be more complicated since you may
>>want to use dbus to start up the media player in response.
>>    =

>>
>I was wondering how to generate such connections? Simply switch on the =

>headset? Any ideas?
>  =

>
Last but not least, I receive the frame sent by the headset but it is a =

2 byte "0x00 0x01". Is does not look like a stream_cmd. And only one of =

my heasets sends data.

plus the weather is bad, sad day...

Fr=E9d=E9ric.



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
