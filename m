Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tim Chick <chick@computergeek.freeserve.co.uk>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 17 May 2007 08:51:27 +0100
References: <200705170207.52710.bluez-devel@huitl.de>
	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
In-Reply-To: <d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200705170851.28257.chick@computergeek.freeserve.co.uk>
Subject: Re: [Bluez-devel] headsetd has problems serving two applications at
	a time
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Thursday 17 May 2007 04:42, you wrote:
> Robert
>
> headsetd is written to allow a single application to use the headset
> at one time. it doesn't multiplex the mic or mix to the speaker. one
> of the two apps will fail to get exclusive access. it's basically a
> latency optimization but there's room for something like dmix or a
> sound server like pulse to make it more flexible.
>
> if skype is written such that input and output are separate file
> descriptors obtained through independent open() calls then it will
> also fail, even if they're in the same thread. that may be how it's
> written, especially if they let you choose one device for mic and
> another for speaker.
>
Ah.. I think this is why I could not get the audio to work in both 
directions when I tried sparkle (voip client). I ran out of time to 
investigate it, but this matches up.

Can we not do something magic with the .asoundrc again to split it into 
2 devices essentially? I guess this is the dmix plugin, but I thought 
there was something simpler to just split recording and playback. Or is 
dsnoop needed?

Cheers,
Tim


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
