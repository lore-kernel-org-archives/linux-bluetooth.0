Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050323235401.GA4662@externe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] hidd\hidp on a 2.4.18 kernel
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 23 Mar 2005 18:54:01 -0500

Hello

I am trying to use hidd on a 2.4.18 kernel
(externe.net/zaurus/kernel) and I am encoutering a strange problem.

hidd connect works, the device is listed as connected, but when I
press the keys nothing happens at all.

Basically, the keyboard input is not bound to the standard input.
because when I insmod evdev and cat /dev/input/event0, I see some activit=
y
when I press the keys, but nothing happens on the console (!!)

The keyboard works fine on my other linux computers. I can not use 2.6
on my handheld (6000W) because all the drivers haven't been ported
yet, so I'm a bit stuck.

I was wondering if it was a known problem, and what I could do to fix
that? I think it's just a problem of having that input dev. bound
correctly.

If nothing can be done, I can still hack a /dev/input/event0 reader
which will inject back keys through VNC /dev/kbdsim, but I'd rather
do a clean fix :-)

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
