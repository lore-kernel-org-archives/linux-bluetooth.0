Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <432beae0705191357n534590aja80712dfdb4be85a@mail.gmail.com>
Date: Sat, 19 May 2007 13:57:19 -0700
From: "Justin Patrin" <papercrane@gmail.com>
To: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF4D6@mplex01.mpl.access-company.com>
MIME-Version: 1.0
References: <432beae0705121846x7b181d3fm180205dfa783e975@mail.gmail.com>
	<432beae0705121900q237f835ahf6d2ac63c619415@mail.gmail.com>
	<CE5216C10C83944D9FD37B65CD33F3970CF4D3@mplex01.mpl.access-company.com>
	<432beae0705122315rf180f5cj9c8a84a451f7cd04@mail.gmail.com>
	<CE5216C10C83944D9FD37B65CD33F3970CF4D6@mplex01.mpl.access-company.com>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RE : RE : Problems connecting to a bluetooth
	headset
Reply-To: papercrane@reversefold.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

On 5/13/07, Frederic Dalleau <Frederic.Dalleau@access-company.com> wrote:
>
> > A2DPD[22:57:28.786]: a2dp_state_machine: (errno=111:Connection
> > refused)CTL connection failed
>
> Make your device discoverable and pairable, you should be asked pairing.

Yes, I tried that, as I mentioned previously. Nothing happened.

> Or install bluez-gnome
>

I got bluez-gnome installed and lo and behold...pairing worked. It
looks like bluez doesn't support the default pin any more and requires
a (dbus?) listener to do the pin entry, meaning that bluez-gnome works
but nothing else does.

>
> > I've also tried to run vlc and got timeouts. I ran vlc with:
>
> Not a real problem, what does another player says?
> xmms mplayer amarok mpg123
>
>

vlc plays fine through a2dpd now that I've paired. I've also gotten
mpg321 piped to aplay [2] to work, however this isn't a great
solution. mpd refuses to play through a2dpd despite all of my attempts
to make it work. It looks like mpd simply doesn't do alsa well...I'm
trying to debug it with the mpd developers.

Aside from that I found the sound quality horrible.... Playing on my
MacBook Pro [1] with some utulities which I think are derived from
older code from this project, the sound quality is pretty good but
when I used mpg321 and aplay on my Zaurus (arm) with a2dpd the sound
was very crunchy for lack of a better word. Cymbals especially were
very nasty sounding.

[1] http://david.connolly.name/blog/hub/mac/2007/02/23/Stereo-Bluetooth-Profile-A2DP-on-Mac-OS-X-Tiger.html?page=comments

[2] mpg321 -s file.mp3 | aplay -c 2 -r 44100 -f S16_LE -D a2dpd -

-- 
Justin Patrin

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
