Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 28 Oct 2006 09:02:13 +0200
From: "Marcus C. Gottwald" <gottwald@inf.fu-berlin.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061028070213.GA14362@inf.fu-berlin.de>
References: <200610281431.45651.thomas.kear@gmail.com>
Mime-Version: 1.0
In-Reply-To: <200610281431.45651.thomas.kear@gmail.com>
Subject: Re: [Bluez-users] Excessive output from snd-bt-sco in dmesg
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Thomas Kear wrote (Sat 2006-Oct-28 14:31:41 +1300):

> From dmesg, repeated nearly 1500 times:
> snd-bt-sco: Shift problem detected! Fixing to 1.
> snd-bt-sco: Shift problem detected! Fixing to 0.
..
> Since 99% of the time there is no problem that needs to be solved, is the=
re a =

> simple way to just reduce the verbosity of output to the system log?

This has been working just fine for me:

    mcg@coach:/usr/src/modules/bluetooth-alsa$ diff -u btsco.c_ORIG btsco.c
    --- btsco.c_ORIG        2006-04-13 21:50:23.000000000 +0200
    +++ btsco.c     2006-08-23 20:57:32.000000000 +0200
    @@ -1016,7 +1016,7 @@
     #ifdef AUTO_FIXUP_BYTESHIFT
                            if (lostatcnt=3D=3Dlen/2&&len>32) {
                                    shift=3D!shift;
    -                               dprintk("Shift problem detected! Fixing=
 to %d.\n",shift);
    +                               //dprintk("Shift problem detected! Fixi=
ng to %d.\n",shift);
                            }
     #endif
     #endif /* any of them */


Cheers, Marcus

-- =

   Marcus C. Gottwald  =B7  http://www.inf.fu-berlin.de/~gottwald/


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
