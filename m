Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D1B9EA.60706@access-company.com>
Date: Tue, 13 Feb 2007 14:15:22 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>	<CE5216C10C83944D9FD37B65CD33F3970CF471@mplex01.mpl.access-company.com>
	<9da483cb0702130227i2bf3c015jacfa68577b36fe1a@mail.gmail.com>
In-Reply-To: <9da483cb0702130227i2bf3c015jacfa68577b36fe1a@mail.gmail.com>
Subject: Re: [Bluez-devel] RE : Successes and failures with
	btsco/bluez	respectively
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


I just updated the daemon from plugz as traces were disabled at compile 
time in release! Please use this one now to give us traces.


>> Which version? Can you try 1.2.10?
>>     
> Specifically 1.2.10-cvs, as of about 2 months ago from their cvs servers.
> This does work perfectly well with btsco-0.5's a2dpd-daemon/a2dpd pcm.
> I can try the release tarball if you'd like.
>   
Just retried 1.2.10 tarball released from site with latest plugin. Also 
ubuntu xmms (also stated as 1.2.10 don't work)
Note the tarball do not build first time, I had to remove the static 
keyword at the file/line mentionned.

> With the newest a2dpd, this mplayer always outputs, either plugin, but
> video is another story. Audio works fine, video lags sloooowly.
Mplayer video is slow with older plugin. The newer have corrected this 
but the sound is broken with video (it's ok for music only). I'm looking.
The same : i got the tarball on the site.
> Well, I was in the process of doing this, and now, neither version of
> a2dpd wish to connect with my headset at all. It just sits at
> 'connecting' ... nomatter what im trying. vlc/mplayer/xmms, new/old,
> a2play/pcm.a2dpd, it is refusing to connect anymore... I even rebooted
> to no avail.. did i somehow wear out my headset?!?
>   
Probably pairing. Sometimes I have these and I can't reconnect at all. I 
usually do the following sudo rm -rf /var/lib/bluetooth. Then I pair the 
device again.




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
