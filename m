Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45865.156.116.3.43.1149253067.squirrel@webmail.uio.no>
Date: Fri, 2 Jun 2006 14:57:47 +0200 (CEST)
From: markusv@student.matnat.uio.no
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] Bluez service discovery
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

---------------------------- Original Message ----------------------------
Subject: Re: Bluez service discovery
From:    markusv@ulrik.uio.no
Date:    Fri, June 2, 2006 13:01
To:      bluez-users@lists.sourceforge.net
--------------------------------------------------------------------------


hi again
I have finaly found what my problem is, I am using:
uint32_t svc_uuid_int[] = {0x1c712d88, 0xaac711da, 0x818a000b, 0x0000ffff};
sdp_uuid128_create( &svc_uuid, &svc_uuid_int);

to create the service i am looking for. But something goes wrong using the
sdp_uuid128_create function I think. Using the uuid created returns nu
results. But using:
sdp_uuid16_create(&svc_uuid, 0x1002);

gives me a lot of results. I have dobbel checked that the uuid is correct
and that the service is running on my phone so why can i not use
sdp_uuid128_create()??

markus


> On 5/25/06, markusv@st... <markusv@st...>
>  wrote:
>  >
>  >
>  > My UUID is: 1c712d88aac711da818a000bcd4e8912. I created this with
uuidgen.
>  > I have done nothing more to it. Do I have to??
>
>
 > No, that's fine.
>
> What do I have to do? How
>  > do I add the Bluetooth Base UUID or one of the UUID functions
specific to
>  > reserved UUIDs?
>
>
>  To create a valid UUID out of a 16-bit reserved UUID, use
>  sdp_uuid16_create.  See sdp_lib.h for details, it should be pretty self
>  explanatory.  There a bunch of defined constants in sdp.h that you can
also
>  use.  e.g.
>
 > {
 >   uuid_t u;
 >   sdp_uuid16_create( &u, PUBLIC_BROWSE_GROUP );
>  }
>
 > If you continue to have trouble, download the bluez source code and
examine
>  sdptool.c
>
>  -albert
>
 > Markus
 >
 > > Have you added the Bluetooth Base UUID, or one of the UUID functions
 > >  specific to reserved UUIDs?
 > >
 > > -albert
 > >
 > > On 5/23/06, markusv@st... <markusv@st...>
 > > wrote:
 > >
 > >
 > > I have generated my own service and generated a UUID with uuidgen. But
 > my
 > > laptop does not find my service on the phone! If i change the uuid to
 > > search for on the laptop to 0x1002 the public brose root, as far as I
 > know
 > > it should than give me all services on the phone. But still no services
 > > are found. Searching with sdptool finds all services on the phone
 > > including my own. Why can't I find them in my C program? I would realy
 > > appreciate some help here. I have spent far to much time on that now,
 > and
 > > I need that to work for my master thesis.
 > >
 > > Markus
 > >
 > >
 > >
 > > >Individual devices (e.g. phones) do not have UUIDs.  Services do.  If
 > > you're
 > > >implementing a Bluetooth profile, that profile should come with a
 > > >preassigned UUID.  If you're creating your own custom service that's
 > not
 > > >part of the Bluetooth profiles or specifications, make your own uuid
 > with
 > > >uuidgen.
 > > >
 > > >More generally, a UUID is a 128-bit identifier.  Bluetooth has this
 > > notion
 > > >of 16-bit and 32-bit reserved UUIDs.  These are really 128-bit UUIDs,
 > but
 > > >with the lower 112/96 bits fixed to the Bluetooth Base UUID.  If you
 > find
 > > a
 > > >service with a 16-bit UUID (e.g. Serial Port Profile is 0x1101, then
 > you
 > > may
 > > >need to convert it to the full 128-bit UUID.
 > >
 > > -albert
 > >
 > > On 5/23/06, Rajan Rengasamy <rajanrengasamy@ma...> wrote:
 > > >
 > > > Hi Albert, if u dont mind me asking, would you be able to guide me on
 > > how
 > > > i can get my phone's UUID? please thanks.
 > > > i also have a k750.
 > > >
 > > > On Tuesday, May 23, 2006, at 07:54AM, Albert Huang <albert@cs...
 > > >
 > > > wrote:
 > > >
 > > > >
 > > > ><<Original Attached>>
 > > >
 > > >
 > > > Rajan
 > > > -------------
 > > > Tat Twvam Asi
 > > >
 > > >
 > > > If you're using a Bluetooth reserved UUID, make sure that you've
 > > correctly
 > > > specified it by adding the Bluetooth Base UUID.
 > > >
 > > > -albert
 > > >
 > > > On 5/19/06, markusv@st... <markusv@st...
 > > >
 > > > wrote:
 > > > >
 > > > >
 > > > > hi
 > > > > I am trying to discover services on my cellular phone a Sony
 > Ericsson
 > > > > k750
 > > > > i. I am running ubuntu and the Bluez bluetooth protocol stack. I
 > have
 > > > > followed this example:
 > > > > http://people.csail.mit.edu/albert/bluez-intro/x601.html
 > > > > I have ofcourse changed the bluetooth address and the uuid to match
 > my
 > > > > phone and service. But still my program finds no services on the
 > > phone??
 > > > > What is wrong here? Anybody have some hints?
 > > > >
 > > > > Thanks
 > > > > Markus
 > > > >
 > > > >
 > > > >
 > > > >
 > > > >
 > > > >
 > > > >
 > > > > -------------------------------------------------------
 > > > > Using Tomcat but need to do more? Need to support web services,
 > > > > security?
 > > > > Get stuff done quickly with pre-integrated technology to make your
 > job
 > > > > easier
 > > > > Download IBM WebSphere Application Server v.1.0.1 based on Apache
 > > > > Geronimo
 > > > >
 > > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
 > > > >
 > > > > _______________________________________________
 > > > > Bluez-users mailing list
 > > > > Bluez-users@li...
 > > > > https://lists.sourceforge.net/lists/listinfo/bluez-users
 > > > >
 > > >
 > > >
 > > >
 > >
 > >
 > >
 > > -------------------------------------------------------
 > > Using Tomcat but need to do more? Need to support web services,
 > security?
 > > Get stuff done quickly with pre-integrated technology to make your job
 > > easier
 > > Download IBM WebSphere Application Server v.1.0.1 based on Apache
 > Geronimo
 > > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
 > > _______________________________________________
 > > Bluez-users mailing list
 > > Bluez-users@li...
 > > https://lists.sourceforge.net/lists/listinfo/bluez-users
 > >
 >
 >
 >
 >
 > -------------------------------------------------------
 > All the advantages of Linux Managed Hosting--Without the Cost and Risk!
 > Fully trained technicians. The highest number of Red Hat certifications in
 > the hosting industry. Fanatical Support. Click to learn more
 > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
 > _______________________________________________
 > Bluez-users mailing list
 > Bluez-users@li...
 > https://lists.sourceforge.net/lists/listinfo/bluez-users
 >




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
