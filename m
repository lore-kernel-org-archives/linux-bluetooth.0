Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexandros Karypidis <karypid@inf.uth.gr>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
References: <200302071951.35073.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
	<200302081740.48000.karypid@inf.uth.gr>
In-Reply-To: <200302081740.48000.karypid@inf.uth.gr>
MIME-Version: 1.0
Message-Id: <200302081814.47394.karypid@inf.uth.gr>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 8 Feb 2003 18:14:47 +0200
Content-Type: text/plain; CHARSET=iso-8859-7

BTW, it dawned on me that:

1) connect() succeeds even if bind() wasn't previously called for the clien=
t=20
socket.
2) accept() also produces a new socket.

I assumed that these operations evidently select a free PSM for the sockets=
=20
they use/produce. I could not find any such thing in the code however (but =
I=20
don't really know the BlueZ code).

Then, I did the simple tests of:

A. Calling getsockname() after a connect() with no previous bind()
B. Calling getsockname() after a accept()

Case A reported PSM zero (0) !!! This is clearly a bug!

Case B reported PSM 5000. This is the PSM where the server socket on which=20
accept() was called was bound. So:

	clsock =3D accept (srvsock, ...);

Produces a clsock whose PSM is equal to that of srvsock. I don't know if th=
is=20
is correct or not.

On Saturday 08 February 2003 17:40, Alexandros Karypidis wrote:
> Hi again,
>
> First of all, perhaps we should move this discussion to bluez-devel.
>
> As I can see in lines 462-470 of core/l2cap.c, either the bind() fails if
> the PSM is in use, or it succeeds if it is free. I think this is where th=
e
> code for the case l2_bdaddr->psm=3D=3D0 should be added, changing the val=
ue to
> some free PSM.
>
> In this case, I am thinking of adding a 8192 byte array in l2cap.c, which
> records (per bit) the PSMs which are in use. This idea is similar to the
> way the kernel tracks the signals which should be masked per process. One
> would then:
>
>  // 0xFFFF PSMs available =3D 8192 bytes
> #define MAX_PSM_NDX 8192
> // Record PSM use here in the following array:
> unsigned char psm_use[MAX_PSM_NDX];
> // Code which should be added to l2cap.c in l2cap_sock_bind()
> for (i=3D513; i<MAX_PSM_NDX; i++) { // start a 513 to skip reserved PSMs
> 	if (psm_use[i] < 255) { // a bit which is not set means there is a free
> PSM // bit ops to locate the first 0 bit
> 		// change the ls->psm value to that bit's index
> 		// set the bit to 1 to record it as in use
> 	}
> }
>
> Then, I suppose that code must be added to set the bit back to 0 when
> close() is called, plus in accept() when new sockets are created for
> clients. I can't think of any other points of interaction.
>
> On Friday 07 February 2003 23:36, Marcel Holtmann wrote:
> > Hi Alexandros,
> >
> > > Yes, but according to the Bluetooth spec, PSMs ranging from 0x1001
> > > through 0xFFFF can be dynamically allocated. How can I choose one
> > > without "trial-and-error" (i.e. trying to bind() through all options
> > > until it does not fail).
> > >
> > > For example, in IP protocols such as TCP/UDP, calling bind() with a
> > > port number equal to zero will cause the underlying implementation to
> > > automatically select a free port which you may later find out using
> > > getsockname(). This is why I tried this with L2CAP. I think it will b=
e
> > > a nice feature to have.
> >
> > nice idea.
> >
> > Max, what do you think about this?
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.NET email is sponsored by:
> > SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
> > http://www.vasoftware.com
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users

--=20
To err is human, but to forgive is beyond the scope of the Operating System=
...

=C1=EB=DD=EE=E1=ED=E4=F1=EF=F2 =CA=E1=F1=F5=F0=DF=E4=E7=F2
=D0=E1=ED=E5=F0=E9=F3=F4=DE=EC=E9=EF =C8=E5=F3=F3=E1=EB=DF=E1=F2
=D4=EC=DE=EC=E1 =CC=E7=F7/=EA=FE=ED =C7/=D5, =D4=E7=EB=E5=F0=E9=EA=EF=E9=ED=
=F9=ED=E9=FE=ED & =C4=E9=EA=F4=FD=F9=ED

Alexandros Karypidis
University of Thessaly
Computer & Communications Engineering dept.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
http://www.vasoftware.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
