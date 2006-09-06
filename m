Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 6 Sep 2006 20:27:01 +0200
References: <200609032015.51210.cijoml@volny.cz>
	<200609061935.30152.cijoml@volny.cz>
	<d23110170609061046y6b01f1efm817ef081c302f362@mail.gmail.com>
In-Reply-To: <d23110170609061046y6b01f1efm817ef081c302f362@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200609062027.01611.cijoml@volny.cz>
Subject: Re: [Bluez-users] bluez utils debian package doesn't autoswith
	dongle on?
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

at least with version 3.5 --enable-all in utils doesn't compile hid2hci

checking other things

Michal

Dne st=F8eda 06 z=E1=F8=ED 2006 19:46 Ulisses Furquim napsal(a):
> Hi,
>
> On 9/6/06, CIJOML <cijoml@volny.cz> wrote:
> > cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez co -P utils
> >
> > but I am unable compile it:
> >
> > if
> > gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/include/dbus-1.0
> > -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2
> > -D_FORTIFY_SOURCE=3D2 -MT dbus-sdp.o -MD -MP -MF ".deps/dbus-sdp.Tpo" -=
c -o
> > dbus-sdp.o dbus-sdp.c; \ then mv -f ".deps/dbus-sdp.Tpo"
> > ".deps/dbus-sdp.Po"; else rm -f ".deps/dbus-sdp.Tpo"; exit 1; fi
> > dbus-sdp.c: In function `search_process_cb':
> > dbus-sdp.c:467: warning: implicit declaration of function `sdp_process'
> > dbus-sdp.c: In function `connect_request':
> > dbus-sdp.c:812: error: `SDP_NON_BLOCKING' undeclared (first use in this
> > function)
> > dbus-sdp.c:812: error: (Each undeclared identifier is reported only once
> > dbus-sdp.c:812: error: for each function it appears in.)
> > dbus-sdp.c: In function `remote_svc_rec_conn_cb':
> > dbus-sdp.c:838: warning: implicit declaration of function
> > `sdp_set_notify' dbus-sdp.c:851: warning: implicit declaration of
> > function
> > `sdp_service_attr_async'
> > dbus-sdp.c: In function `remote_svc_handles_conn_cb':
> > dbus-sdp.c:906: warning: implicit declaration of function
> > `sdp_service_search_attr_async'
> > dbus-sdp.c: In function `get_identifiers_conn_cb':
> > dbus-sdp.c:965: warning: implicit declaration of function
> > `sdp_service_search_async'
> > make[2]: *** [dbus-sdp.o] Error 1
> > make[2]: Leaving directory `/usr/src/bluez-cvs/utils/hcid'
> > make[1]: *** [all-recursive] Error 1
> > make[1]: Leaving directory `/usr/src/bluez-cvs/utils'
> > make: *** [all] Error 2
>
> please, make sure you have bluez-libs from CVS installed before you
> try to compile bluez-utils from CVS. You can also download the latest
> bluez-utils and bluez-libs tarballs for the 3.5 version that Marcel
> released today. :-)
>
> Regards,
>
> -- Ulisses
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
