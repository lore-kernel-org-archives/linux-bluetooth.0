Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <5307d89f0512201320g34b2d793p178bbd501d473e95@mail.gmail.com>
From: Patrick Libert <patrick.libert@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <5307d89f0512200011i7a6784dfie08a56569a90381d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5307d89f0512200011i7a6784dfie08a56569a90381d@mail.gmail.com>
Subject: [Bluez-users] Re: Info a2play
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
Date: Tue, 20 Dec 2005 22:20:06 +0100

I got it now fixed, I used an old version of a2play.

The following syntax works perfectly now!
beep-media-player | sox -c 2 -t raw -r 44100 -w -s - -t au - |
./a2play -p  00:0D:44:2A:14:66

But there is still one problem: the music gets interrupted very often.
I now used the -p option but that still doesn't help.
On Windows XP and my cellphone, it works perfectly.

Kind regards,

patrick


On 12/20/05, Patrick Libert <patrick.libert@gmail.com> wrote:
> Hello Bluez-Users
>
> I saw on a website "LiveJournal" that it is possible to use beep-media-pl=
ayer to stream your mp3 to a bluetooth stereo headset with a2play.
> The syntax is like this:
>
>                        beep-media-player | sox -c 2 -t raw -r 44100 -w -s=
 - -t au - | ./a2play -p  00:0D:44:2A:14:66
>
> with this in the .asoundrc
>
>           pcm.stdout {
>                      type file
>                      slave.pcm null
>                      file /dev/stdout
>
>                    }
>
>
> When I do this I get an error:
>
>       couldn't open 00:08:E0:09:75:6F
>
> What does the option "-p" with a2play means?
> If I do this without the "-p" option I get the following error:
>
>               out of sync (0x2e)
>               couldn't read header on -
>
> When I do this:
>
>             mpg123 --au - file.mp3 | sbc/sbcenc - | ./a2play 00:08:E0:09:=
75:6F
> Then It works with my headset. But the music is interrupted sometimes. Ho=
w does it come?
>
> I really appriciate if someone could help me.
>
> Kind regards,
>
> Patrick Libert
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
