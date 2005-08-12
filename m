Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: aeriksson@fastmail.fm
Message-Id: <20050812145457.63BB8EB2A2@tippex.mynet.no-ip.org>
Subject: [Bluez-users] pand vs. sdpd
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
Date: Fri, 12 Aug 2005 16:54:56 +0200

<Resending since last version got QP mangled>

Hi all,

I'm having problems getting a pand network up and running.=20
The tricky thing is that I have had it working once before
so I know that the hw is ok, but now I cannot recreate the=20
setup. I've been following all the docs I could find to no=20
avail.

The situation:
I have hcid and sdpd running. I start pand with the intent=20
to connect to it from my w2k laptop. The connection fails
to establish.

Observations:
* There is no bnep0 device created regardless of pand running=20
or not. My memory is a bit shady on _when_ that device was
to be created.=20

* Running all processes under strace I notice that, when trying=20
to connect from the laptop, sdpd gets a kick, but pand does not.
sdpd says:

<<< starting pand >>>
)      =3D 1 (in =5B5=5D)
accept(5, =7Bsa_family=3DAF_FILE, path=3D=22EST 2005=22=7D, =5B2=5D) =3D =
6
select(7, =5B4 5 6=5D, NULL, NULL, NULL)    =3D 1 (in =5B6=5D)
recv(6, =22u=5C0=5C0=5C0W=22, 5, MSG_PEEK)        =3D 5
recv(6, =22u=5C0=5C0=5C0W=5C0005T=5Ct=5C0=5C0015=5C3=5C31=5C21=5C26=5Ct=
=5C0=5C0045=5C0315=5C6=5C31=5C1=22..., 92, 0) =3D=20
9
2
getpeername(6, =7Bsa_family=3DAF_FILE, path=3D=22A<U=BF=22=7D, =5B2=5D) =
=3D 0
gettimeofday(=7B1123624357, 695313=7D, NULL) =3D 0
send(6, =22v=5C0=5C0=5C0=5C4=5C0=5C1=5C0=5C0=22, 9, 0)      =3D 9
select(7, =5B4 5 6=5D, NULL, NULL, NULL

<<<< Here we try to connect from the laptop >>>
)    =3D 1 (in =5B4=5D)
accept(4, =7Bsa_family=3DAF_BLUETOOTH, sa_data=3D=22=5C1=5C0=5C227=5C371=
=5C31=5C263=5C17=5C0=5C211=5C277=5C0=5C
0
=5C0=5C0=22=7D, =5B10=5D) =3D 7
select(8, =5B4 5 6 7=5D, NULL, NULL, NULL)  =3D 1 (in =5B7=5D)
recv(7, =22=5C2=5C0=5C0=5C0=5C10=22, 5, MSG_PEEK)     =3D 5
recv(7, =22=5C2=5C0=5C0=5C0=5C0105=5C3=5C31=5C21=5C26=5C0=5C24=5C0=22, 13=
, 0) =3D 13
getpeername(7, =7Bsa_family=3DAF_BLUETOOTH, sa_data=3D=22=5C1=5C0=5C227=
=5C371=5C31=5C263=5C17=5C0=5C0=5C0=5C2
7
4U=5C211=5C277=22=7D, =5B10=5D) =3D 0
getsockopt(7, SOL_TCP, TCP_NODELAY, =22L=5C6=5C240=5C2=5C377=5C377=5C0=5C=
0=22, =5B8=5D) =3D 0
send(7, =22=5C3=5C0=5C0=5C0=5Ct=5C0=5C1=5C0=5C1=5C0=5C1=5C0=5C0=5C0=22, 1=
4, 0) =3D 14
select(8, =5B4 5 6 7=5D, NULL, NULL, NULL)  =3D 1 (in =5B7=5D)
recv(7, =22=5C4=5C0=5C1=5C0=5C16=22, 5, MSG_PEEK)     =3D 5
recv(7, =22=5C4=5C0=5C1=5C0=5C16=5C0=5C1=5C0=5C0=5C6<5=5C5=5Cn=5C0=5C0=5C=
377=5C377=5C0=22, 19, 0) =3D 19
getpeername(7, =7Bsa_family=3DAF_BLUETOOTH, sa_data=3D=22=5C1=5C0=5C227=
=5C371=5C31=5C263=5C17=5C0=5C0=5C0=5C2
7
4U=5C211=5C277=22=7D, =5B10=5D) =3D 0
getsockopt(7, SOL_TCP, TCP_NODELAY, =22L=5C6=5C240=5C2=5C377=5C377=5C0=5C=
0=22, =5B8=5D) =3D 0
send(7, =22=5C5=5C0=5C1=5C0a=5C0=5E5=5C=5C=5Ct=5C0=5C0=5Cn=5C0=5C1=5C0=5C=
0=5Ct=5C0=5C0015=5C3=5C31=5C21=5C26=5Ct=5C0=22..., 102, 0)=20
=3D
102
select(8, =5B4 5 6 7=5D, NULL, NULL, NULL)  =3D 1 (in =5B7=5D)
recv(7, =22=22, 5, MSG_PEEK)                =3D 0
close(7)                                =3D 0
select(7, =5B4 5 6=5D, NULL, NULL, NULL


Having briefly looked at the pand code I got the=20
impression that sdpd should alert pand when=20
connections arrived (and pand should have created=20
bnep0 long before that??).

If this sounds at all familiar to anyone all help is
appreciated. I'm stuck now :-(

TIA,

/Anders





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
