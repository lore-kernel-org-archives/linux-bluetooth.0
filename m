Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] RE: Logitech multimedia keys off by one
References: <406C1E19.7090003@ntlworld.com> <200404021856.17235.cijoml@volny.cz> <1080927108.2836.92.camel@pegasus>
In-Reply-To: <1080927108.2836.92.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404030225.33425.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 3 Apr 2004 02:25:33 +0200

Dne p=E1 2. dubna 2004 19:31 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > > the libs2 and utils2 are the next generation and they are completely
> > > independent from the current version. Actually with bluez-libs-2.6 it
> > > should be possible to port the bthid to use the old library. I fixed
> > > some internal stuff and this should make it possible to get the HID
> > > descriptor from a device.
> >
> > GREAT! Marcel pls do it as soon as possible! :)*****
>
> no time for it right now, sorry.
>
> > > At the moment I am also thinking of moving pand and dund into the uti=
ls
> > > package to lower my maintenance overhead.
> >
> > It is a good choice.
>
> In the past there were objections against it and at the moment I haven't
> made any decision. Please comment it with pro and cons.


+easier maintance
+all in one included - easier for novice users when they tries find out how=
=20
get their devices to work
+less work with packaging new versions
+less asks in mailing list saying something like: "What should I download t=
o=20
get this work?"

=2Dprobably longer patches
=2Dreleasing new versions will be possibly more frequental

Michal


>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
