Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 13 May 2008 08:47:38 +0800
Message-ID: <094BCE01AFBE9646AF220B0B3F367AAB030C0642@pdsmsx413.ccr.corp.intel.com>
In-Reply-To: <1210600054.16390.55.camel@violet.holtmann.net>
References: <094BCE01AFBE9646AF220B0B3F367AAB030C0117@pdsmsx413.ccr.corp.intel.com>
	<1210600054.16390.55.camel@violet.holtmann.net>
From: "Zhao, Halley" <halley.zhao@intel.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] I can't use 3.31 release,
	but 3.19 release works	on the same platform
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1236011508=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1236011508==
Content-Class: urn:content-classes:message
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

=A1=A1=A1=A11. my pcm_bluetooth plugins are installed in the right place =
of /usr/lib/alsa-lib. I copy the configure command line from README =
file.
=A1=A1=A1=A1
=A1=A1=A1=A12. by the way, as for version 3.19. (if 3.31 could work for =
me, it is not important)
=A1=A1=A1=A1snd_pcm_hw_params() give the return value from low level =
function call:
=A1=A1=A1=A1return pcm->fast_ops->prepare(pcm->fast_op_arg);
=A1=A1=A1=A1I think it will recursive reference to Bluez stack.
=A1=A1=A1=A1
=A1=A1=A1=A1
=A1=A1=A1=A1>-----Original Message-----
=A1=A1=A1=A1>From: bluez-devel-bounces@lists.sourceforge.net
=A1=A1=A1=A1>[mailto:bluez-devel-bounces@lists.sourceforge.net] On =
Behalf Of Marcel
=A1=A1=A1=A1>Holtmann
=A1=A1=A1=A1>Sent: 2008=C4=EA5=D4=C212=C8=D5 21:48
=A1=A1=A1=A1>To: BlueZ development
=A1=A1=A1=A1>Cc: bluez-devel@lists.sf.net
=A1=A1=A1=A1>Subject: Re: [Bluez-devel] I can't use 3.31 release,but =
3.19 release works
=A1=A1=A1=A1>on the same platform
=A1=A1=A1=A1>
=A1=A1=A1=A1>Hi Halley,
=A1=A1=A1=A1>
=A1=A1=A1=A1>> =A1=A1=A1=A1My Bluetooth earphone is Motorola HT820.
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>
=A1=A1=A1=A1>> =A1=A1=A1=A11. When I try to use bluez-utils 3.31 on my =
desktop (Ubuntu7.10),
=A1=A1=A1=A1>> there are some issues: (but there is no such issue when I =
use 3.19
=A1=A1=A1=A1>> version on this same platform). Should I update some =
other package
=A1=A1=A1=A1>> besides bluez-utils and bluez-libs?
=A1=A1=A1=A1>
=A1=A1=A1=A1>please make sure the right pcm_bluetooth plugin is loaded. =
It needs to
=A1=A1=A1=A1>be installed in /usr/lib/alsa-lib. If you installed it with =
a different
=A1=A1=A1=A1>prefix and it ends up in /usr/loca/lib/alsa-lib then it =
won't work. The
=A1=A1=A1=A1>audio service needs to be used with the matching plugin.
=A1=A1=A1=A1>
=A1=A1=A1=A1>> =A1=A1=A1=A12. When I use bluez-utils 3.19 version, =
application calls
=A1=A1=A1=A1>> snd_pcm_hw_params() sometimes will got return value "1". =
(The function
=A1=A1=A1=A1>> description says it will be 0 for success and negative =
number for
=A1=A1=A1=A1>> failure). The positive value makes me puzzled.
=A1=A1=A1=A1>
=A1=A1=A1=A1>This is a question for the ALSA guys. I really have no =
clue.
=A1=A1=A1=A1>
=A1=A1=A1=A1>> 3. Ubuntu hardy has included bluez-utils 3.26 version; =
but I found
=A1=A1=A1=A1>> there are many XRun errors when I use helix engine.
=A1=A1=A1=A1>
=A1=A1=A1=A1>The audio service has been improved a lot of 3.26 and thus =
it might
=A1=A1=A1=A1>simply miss a patch. However for me it is already too old =
to remember
=A1=A1=A1=A1>any details.
=A1=A1=A1=A1>
=A1=A1=A1=A1>Regards
=A1=A1=A1=A1>
=A1=A1=A1=A1>Marcel
=A1=A1=A1=A1>
=A1=A1=A1=A1>
=A1=A1=A1=A1>
=A1=A1=A1=A1>------------------------------------------------------------=
-----------
=A1=A1=A1=A1>--
=A1=A1=A1=A1>This SF.net email is sponsored by the 2008 JavaOne(SM) =
Conference
=A1=A1=A1=A1>Don't miss this year's exciting event. There's still time =
to save $100.
=A1=A1=A1=A1>Use priority code J8TL2D2.
=A1=A1=A1=A1>http://ad.doubleclick.net/clk;198757673;13503038;p?http://ja=
va.sun.com/
=A1=A1=A1=A1>javaone
=A1=A1=A1=A1>_______________________________________________
=A1=A1=A1=A1>Bluez-devel mailing list
=A1=A1=A1=A1>Bluez-devel@lists.sourceforge.net
=A1=A1=A1=A1>https://lists.sourceforge.net/lists/listinfo/bluez-devel


--===============1236011508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1236011508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1236011508==--
