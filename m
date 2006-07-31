Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 31 Jul 2006 19:13:08 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060731171308.GD29916@suse.de>
References: <20060727083312.81035.qmail@web27915.mail.ukl.yahoo.com>
	<1154177867.25939.15.camel@localhost>
	<44CE11FA.7020302@kernelconcepts.de>
	<1154369825.4982.12.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1154369825.4982.12.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
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

Hi,

On Mon, Jul 31, 2006 at 08:17:05PM +0200, Marcel Holtmann wrote:
> Hi Nils,
> =

> > Probably make it as default for hcidump and let "-X" and "-V" turn it o=
ff?
> =

> it is too late for that :(
> =

> Maybe at some point when I rewrite hcidump, but I don't see that happen
> in the near future.

maybe something like that helps a bit:

Index: src/hcidump.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/hcidump/src/hcidump.c,v
retrieving revision 1.69
diff -u -p -r1.69 hcidump.c
--- src/hcidump.c	17 Jan 2006 18:45:06 -0000	1.69
+++ src/hcidump.c	31 Jul 2006 17:10:19 -0000
@@ -827,6 +827,12 @@ int main(int argc, char *argv[])
 		}
 	}
 =

+	if (!(flags & DUMP_VERBOSE && flags & DUMP_EXT)) {
+		fprintf (stderr, "Warning: if you want to use this tool to report "
+				 "a problem, you should at least\n"
+				 "run \"hcidump -X -V\".\n");
+	}
+
 	argc -=3D optind;
 	argv +=3D optind;
 	optind =3D 0;

:-)

(not even compile-tested)
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
