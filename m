Return-Path: <karypid@inf.uth.gr>
From: Alexandros Karypidis <karypid@inf.uth.gr>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Subject: Re: [Bluez-users] How do I obtain a free PSM automatically?
Date: Sat, 8 Feb 2003 17:40:47 +0200
Cc: bluez-devel@lists.sourceforge.net
References: <200302071951.35073.karypid@inf.uth.gr>
	<200302072329.21333.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
In-Reply-To: <1044653775.32672.14.camel@pegasus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-7"
Message-Id: <200302081740.48000.karypid@inf.uth.gr>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi again,

First of all, perhaps we should move this discussion to bluez-devel.

As I can see in lines 462-470 of core/l2cap.c, either the bind() fails if t=
he=20
PSM is in use, or it succeeds if it is free. I think this is where the code=
=20
for the case l2_bdaddr->psm=3D=3D0 should be added, changing the value to s=
ome=20
free PSM.

In this case, I am thinking of adding a 8192 byte array in l2cap.c, which=20
records (per bit) the PSMs which are in use. This idea is similar to the wa=
y=20
the kernel tracks the signals which should be masked per process. One would=
=20
then:

 // 0xFFFF PSMs available =3D 8192 bytes
#define MAX_PSM_NDX 8192
// Record PSM use here in the following array:
unsigned char psm_use[MAX_PSM_NDX];
// Code which should be added to l2cap.c in l2cap_sock_bind()
for (i=3D513; i<MAX_PSM_NDX; i++) { // start a 513 to skip reserved PSMs
	if (psm_use[i] < 255) { // a bit which is not set means there is a free PS=
M
		// bit ops to locate the first 0 bit
		// change the ls->psm value to that bit's index
		// set the bit to 1 to record it as in use
	}
}

Then, I suppose that code must be added to set the bit back to 0 when close=
()=20
is called, plus in accept() when new sockets are created for clients. I can=
't=20
think of any other points of interaction.

On Friday 07 February 2003 23:36, Marcel Holtmann wrote:

> Hi Alexandros,
>
> > Yes, but according to the Bluetooth spec, PSMs ranging from 0x1001
> > through 0xFFFF can be dynamically allocated. How can I choose one witho=
ut
> > "trial-and-error" (i.e. trying to bind() through all options until it
> > does not fail).
> >
> > For example, in IP protocols such as TCP/UDP, calling bind() with a por=
t
> > number equal to zero will cause the underlying implementation to
> > automatically select a free port which you may later find out using
> > getsockname(). This is why I tried this with L2CAP. I think it will be =
a
> > nice feature to have.
>
> nice idea.
>
> Max, what do you think about this?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

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
