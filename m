Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9da483cb0702131425w3ee6ec64vdddafdbbbc6fac32@mail.gmail.com>
Date: Tue, 13 Feb 2007 15:25:29 -0700
From: "Mike Hodson" <mystica@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45D1B9EA.60706@access-company.com>
MIME-Version: 1.0
References: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>
	<CE5216C10C83944D9FD37B65CD33F3970CF471@mplex01.mpl.access-company.com>
	<9da483cb0702130227i2bf3c015jacfa68577b36fe1a@mail.gmail.com>
	<45D1B9EA.60706@access-company.com>
Subject: Re: [Bluez-devel] RE : Successes and failures with btsco/bluez
	respectively
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

On 2/13/07, Fr=E9d=E9ric DALLEAU <frederic.dalleau@access-company.com> wrot=
e:
>
> I just updated the daemon from plugz as traces were disabled at compile
> time in release! Please use this one now to give us traces.

Ok. I'll muck with this in a little while. :)

> Just retried 1.2.10 tarball released from site with latest plugin. Also
> ubuntu xmms (also stated as 1.2.10 don't work)
> Note the tarball do not build first time, I had to remove the static
> keyword at the file/line mentionned.


> Mplayer video is slow with older plugin. The newer have corrected this
> but the sound is broken with video (it's ok for music only). I'm looking.
> The same : i got the tarball on the site.
Yes, I did notice that music itself was just fine.

> >
> Probably pairing. Sometimes I have these and I can't reconnect at all. I
> usually do the following sudo rm -rf /var/lib/bluetooth. Then I pair the
> device again.

One specific question with regards to pairing:
Which daemons / gnome panel plugins / apps need to be running at the
time of pairing, and what is the most successful way to do this?  I
was only able to get a connection at all when i had the
bluetooth-applet running in my notification area.  However, this
applet (v0.6) seems to crash a lot, especially last night when I was
trying unsuccessfully to connect my headset.

Mike

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
