Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Sep 2006 20:15:47 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060905181547.GA17557@suse.de>
References: <20060903124043.2028.48247.reportbug@forza>
	<1157367160.32195.54.camel@aeonflux.holtmann.net>
	<20060904100025.GA17058@esaurito.net>
	<1157371912.32195.69.camel@aeonflux.holtmann.net>
	<20060905103207.GC30274@esaurito.net>
	<1157454451.4206.17.camel@localhost>
	<20060905164657.GA16417@suse.de>
	<1157476399.5963.4.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1157476399.5963.4.camel@localhost>
Subject: Re: [Bluez-devel]
	Bug#385857:	[Pkg-bluetooth-maintainers]	Bug#385857: please
	upgrade to bluez-utils and	bluez-libs 3.4
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Tue, Sep 05, 2006 at 07:13:19PM +0200, Marcel Holtmann wrote:
> Hi Stefan,
> =

> > JFYI, i packaged the passkey-agent as-is for openSUSE factory and added=
 a
> > README, so the users can authenticate at all until the Desktop environm=
ents
> > are ready. It might make sense to keep it IMO for all those people that=
 do
> > neither use gnome nor kde and still want to occasionally pair a rfcomm =
device,
> > but maybe a multitude of easy to use passkey agents will pop up soon and
> > we will have one for every taste :-)
> =

> my advise would be to include passkey-agent.c in the docs section as an
> example. This is how other packages do it and to make this really clear,
> the passkey-agent.c is an example. It is _NOT_ meant for any regular
> installation. This is the reason why it is marked as noinst_*.

Well, that would mean that i'd have to document /var/lib/bluetooth/*/pincod=
es
and i'd want to avoid that.
But i'll add this disclaimer to the passkey-agent and remove it from the
package ASAP:


Index: hcid/passkey-agent.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/utils/hcid/passkey-agent.c,v
retrieving revision 1.19
diff -u -p -r1.19 passkey-agent.c
--- hcid/passkey-agent.c	28 Apr 2006 14:30:59 -0000	1.19
+++ hcid/passkey-agent.c	5 Sep 2006 18:05:58 -0000
@@ -284,6 +284,9 @@ int main(int argc, char *argv[])
 	char match_string[128], default_path[128], *agent_path =3D NULL;
 	int opt, use_default =3D 0;
 =

+	printf("WARNING: passkey-agent is only a temporary solution. It will be r=
emoved from\n"
+	       "         the openSUSE package as soon as the desktop environments=
 are ready.\n\n");
+
 	snprintf(default_path, sizeof(default_path),
 				"/org/bluez/passkey_agent_%d", getpid());
 =

> If something is marked as noinst_* in bluez-utils, then it is either an
> example, not ready yet or to risky for installation. If you can't get it
> installed with a configure option, then it is _NOT_ meant to be.

Yes. But for the users, there is no way to pair their devices without a
passkey agent. And not everybody can use latest bluez-gnome, but might still
be a valuable tester for bluez-utils :-)

I'll make sure that i get rid of it ASAP and then package the source file
in the documentation directory.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
