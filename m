Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <250249470@web.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?"Daniel=20W=FCrfel"?= <dice-box@web.de>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bluez-devel] Bluez on Axis DevBoard 82
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 05 Aug 2004 12:51:25 +0200

Hi,

I use the kernel 2.4.22 and bluez-utils-2.5 and bluez-libs-2.4, bacause I =
have a Makefile for the bluetooth-directory that should work. But I am not=
 sure. make install works fine, but when I want to make images, I always g=
et an error.=20
I have searched in the archive for hints, but those I found (including a M=
akefile) have not solved this problem.
Can anybody help me=3F
Has anybody a better working Makefile for those versions or even for the l=
atest versions of bluez=3F
Thanks,
Daniel W=FCrfel

[root@localhost devboard=5F82]# make images
##### Including needed shared library files #####
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE =3D (unset),
        LC=5FALL =3D "CC",
        LC=5FLANG =3D "CC",
        LANG =3D "CC"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
strip-cris: Warning: Output file cannot represent architecture UNKNOWN!
libbluetooth.so.1 -> libbluetooth.so.1.0.3
#### No ld-linux.so.2 in /var/test/axis/devboard=5F82/target/cris-axis-linux=
-gnu/usr/lib /var/test/axis/devboard=5F82/target/cris-axis-linux-gnu/lib
make: *** [cramfs.img] Error 1
[root@localhost devboard=5F82]#


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Aufnehmen, abschicken, nah sein - So einfach ist=20
WEB.DE Video-Mail: http://freemail.web.de/=3Fmc=3D021200



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
