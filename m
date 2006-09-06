Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 6 Sep 2006 19:35:30 +0200
References: <200609032015.51210.cijoml@volny.cz>
	<200609052056.45443.cijoml@volny.cz>
	<1157482833.5963.29.camel@localhost>
In-Reply-To: <1157482833.5963.29.camel@localhost>
MIME-Version: 1.0
Message-Id: <200609061935.30152.cijoml@volny.cz>
Subject: Re: [Bluez-users]
	=?iso-8859-2?q?bluez_utils_debian=09package=09doesn?=
	=?iso-8859-2?q?=27t=09autoswith=09dongle_on=3F?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

I downloaded:

cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez co -P utils

but I am unable compile it:

if =

gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/include/dbus-1.0 -I/u=
sr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY=
_SOURCE=3D2 -MT =

dbus-sdp.o -MD -MP -MF ".deps/dbus-sdp.Tpo" -c -o dbus-sdp.o dbus-sdp.c; \
        then mv -f ".deps/dbus-sdp.Tpo" ".deps/dbus-sdp.Po"; else =

rm -f ".deps/dbus-sdp.Tpo"; exit 1; fi
dbus-sdp.c: In function `search_process_cb':
dbus-sdp.c:467: warning: implicit declaration of function `sdp_process'
dbus-sdp.c: In function `connect_request':
dbus-sdp.c:812: error: `SDP_NON_BLOCKING' undeclared (first use in this =

function)
dbus-sdp.c:812: error: (Each undeclared identifier is reported only once
dbus-sdp.c:812: error: for each function it appears in.)
dbus-sdp.c: In function `remote_svc_rec_conn_cb':
dbus-sdp.c:838: warning: implicit declaration of function `sdp_set_notify'
dbus-sdp.c:851: warning: implicit declaration of function =

`sdp_service_attr_async'
dbus-sdp.c: In function `remote_svc_handles_conn_cb':
dbus-sdp.c:906: warning: implicit declaration of function =

`sdp_service_search_attr_async'
dbus-sdp.c: In function `get_identifiers_conn_cb':
dbus-sdp.c:965: warning: implicit declaration of function =

`sdp_service_search_async'
make[2]: *** [dbus-sdp.o] Error 1
make[2]: Leaving directory `/usr/src/bluez-cvs/utils/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/bluez-cvs/utils'
make: *** [all] Error 2


Michal

Dne =FAter=FD 05 z=E1=F8=ED 2006 21:00 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > > > > > I just upgraded to 3.4 (my own compilation), but still the same=
 -
> > > > > > mouse's sensor switches off after 1 minute. Can you verify with
> > > > > > your mouse? I think you have the same (Microsoft Intellimouse
> > > > > > Explorer for Bluetooth 1st generation).
> > > > >
> > > > > I have no idea what you are talking about. First you spoke about
> > > > > the dongle not autoinit and now it is about the mouse.
> > > >
> > > > Eh sorry this should go to different thread I have created and Pavel
> > > > answered - see down here.
> > > >
> > > > But same problem with dongle autoinit with 3.4 - it doesn't go up
> > > > when hid2hci is called, so I have to call it manually hciconfig hci0
> > > > up.
> > >
> > > can you test the CVS version. It is almost the 3.5 release. Only some
> > > small cosmetic changes are missing. For me this is actually working.
> >
> > this means autoup or sensor problem?
>
> for the autoinit feature. Make sure it is set in hcid.conf and check
> your syslog for error messages.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
