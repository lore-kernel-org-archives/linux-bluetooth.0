Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43A81C25.3070106@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Info a2play
References: <5307d89f0512200011i7a6784dfie08a56569a90381d@mail.gmail.com>
In-Reply-To: <5307d89f0512200011i7a6784dfie08a56569a90381d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 20 Dec 2005 07:58:45 -0700

Patrick

> I saw on a website "LiveJournal" that it is possible to
> use beep-media-player to stream your mp3 to a bluetooth stereo headset
> with a2play.
> The syntax is like this:
> 
>                        beep-media-player | sox -c 2 -t raw -r 44100 -w
> -s - -t au - | ./a2play <http://bluetooth-alsa.sourceforge.net/> -p
> 00:0D:44:2A:14:66
> <http://www.shopping.hp.com/webapp/shopping/product_detail.do?product_code=FA303A%23AC3>
> 
> with this in the .asoundrc
>                       
> 
>           pcm.stdout {
>                      type file
>                      slave.pcm null
>                      file /dev/stdout
> 
>                    }

it is an interesting way to get an alsa client to work. if it works out,
we should document it ourselves.

> 
> 
> When I do this I get an error:
> 
>       couldn't open 00:08:E0:09:75:6F
>  
> What does the option "-p" with a2play means?

it's to use pthreads and the rtc to get finer control of packet timing.
it's a new feature.

> If I do this without the "-p" option I get the following error:
> 
>               out of sync (0x2e)
>               couldn't read header on -

it seems that the audio format isn't coming out right, but it's probably
because a2play is old.

> 
> When I do this:
> 
>             mpg123 --au - file.mp3 | sbc/sbcenc - | ./a2play
> 00:08:E0:09:75:6F
> Then It works with my headset. But the music is interrupted sometimes.
> How does it come?

are you running an old version of a2play? we haven't had to pipe the
encoder in the chain for a long time. run a2play with no options and if
it doesn't show -p as a valid option you need to get the current one
from cvs.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
