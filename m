Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <57354.80.203.47.235.1148404102.squirrel@webmail.uio.no>
From: markusv@student.matnat.uio.no
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] Re: Bluez service discovery
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
Date: Tue, 23 May 2006 19:08:22 +0200 (CEST)


I have generated my own service and generated a UUID with uuidgen. But my
laptop does not find my service on the phone! If i change the uuid to
search for on the laptop to 0x1002 the public brose root, as far as I know
it should than give me all services on the phone. But still no services
are found. Searching with sdptool finds all services on the phone
including my own. Why can't I find them in my C program? I would realy
appreciate some help here. I have spent far to much time on that now, and
I need that to work for my master thesis.

Markus



>Individual devices (e.g. phones) do not have UUIDs.  Services do.  If you're
>implementing a Bluetooth profile, that profile should come with a
>preassigned UUID.  If you're creating your own custom service that's not
>part of the Bluetooth profiles or specifications, make your own uuid with
>uuidgen.
>
>More generally, a UUID is a 128-bit identifier.  Bluetooth has this notion
>of 16-bit and 32-bit reserved UUIDs.  These are really 128-bit UUIDs, but
>with the lower 112/96 bits fixed to the Bluetooth Base UUID.  If you find a
>service with a 16-bit UUID (e.g. Serial Port Profile is 0x1101, then you may
>need to convert it to the full 128-bit UUID.

-albert

On 5/23/06, Rajan Rengasamy <rajanrengasamy@mac.com> wrote:
>
> Hi Albert, if u dont mind me asking, would you be able to guide me on how
> i can get my phone's UUID? please thanks.
> i also have a k750.
>
> On Tuesday, May 23, 2006, at 07:54AM, Albert Huang <albert@csail.mit.edu>
> wrote:
>
> >
> ><<Original Attached>>
>
>
> Rajan
> -------------
> Tat Twvam Asi
>
>
> If you're using a Bluetooth reserved UUID, make sure that you've correctly
> specified it by adding the Bluetooth Base UUID.
>
> -albert
>
> On 5/19/06, markusv@student.matnat.uio.no <markusv@student.matnat.uio.no>
> wrote:
> >
> >
> > hi
> > I am trying to discover services on my cellular phone a Sony Ericsson
> > k750
> > i. I am running ubuntu and the Bluez bluetooth protocol stack. I have
> > followed this example:
> > http://people.csail.mit.edu/albert/bluez-intro/x601.html
> > I have ofcourse changed the bluetooth address and the uuid to match my
> > phone and service. But still my program finds no services on the phone??
> > What is wrong here? Anybody have some hints?
> >
> > Thanks
> > Markus
> >
> >
> >
> >
> >
> >
> >
> > -------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services,
> > security?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>
>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
