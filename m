Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <66d811d805041409171713ddba@mail.gmail.com>
From: Mike Zhou <netdream1981@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth-alsa no sound
In-Reply-To: <425E7AC3.7090303@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <66d811d805041312521f5d6cf4@mail.gmail.com>
	 <425E18B1.106@xmission.com>
	 <66d811d805041406024fffcfe8@mail.gmail.com>
	 <66d811d805041406467ea8f9c1@mail.gmail.com>
	 <425E7AC3.7090303@xmission.com>
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
Date: Thu, 14 Apr 2005 17:17:46 +0100

Dear Brad
I have reinstalled it and everything is correct. Now I can play and
record from the headset! Thank you very much!!!

Regards!

Mike



On 4/14/05, Brad Midgley <bmidgley@xmission.com> wrote:
> Mike
>=20
> Yes, try it from cvs so we're at least working on the same version if it
> needs fixes.
>=20
> Brad
>=20
> Mike Zhou wrote:
> >  Dear  Brad:
> > I guess that I got this error because the test2.wav is not 8000Hz.
> > When I use "strace aplay --verbose -Dplughw:1,0 test0.wav", the error
> > is removed. But I still can not hear anything. Do you think I should
> > reinstall the bluetooth-alsa with CVS version?
> > Thanks a lot!
> >
> > Regards!
> >
> > Mike
> >
> >
> > On 4/14/05, Mike Zhou <netdream1981@gmail.com> wrote:
> >
> >>Dear  Brad:
> >>Thanks for your help. I think the bluetooth-alsa may be work
> >>correctly. But when I use strace aplay --verbose -D hw:1,0 test2.wav,
> >>I got this error at the end:
> >>
> >>ioctl(4, 0x400c4150, 0xbffff910)        =3D -1 EIO (Input/output error)
> >>write(2, "aplay: pcm_write:1146: ", 23aplay: pcm_write:1146: ) =3D 23
> >>write(2, "write error: Input/output error", 31write error:
> >>Input/output error) =3D 31
> >>write(2, "\n", 1
> >>)                       =3D 1
> >>exit_group(1)                           =3D ?
> >>
> >>Do you think I should reinstall the bluetooth-alsa with CVS version?
> >>Thanks a lot!
> >>
> >>Regards!
> >>
> >>Mike
> >
> >
> >
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users=
.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3Dclick
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
