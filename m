Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4558611A.2050900@palmsource.com>
Date: Mon, 13 Nov 2006 13:12:10 +0100
From: =?UTF-8?B?RnLDqWTDqXJpYyBEQUxMRUFV?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <454F59DE.40707@palmsource.com>	<1162839360.31808.61.camel@aeonflux.holtmann.net>	<455063B8.5070109@palmsource.com>
	<20061110231536.GA9420@localhost.localdomain>
In-Reply-To: <20061110231536.GA9420@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------060802050201010402050901"
Subject: Re: [Bluez-devel] rfcomm patch to startup
	an	executable	at	connection
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060802050201010402050901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,
Attached is a proposal for the manpage.
It looks like this:

listen <dev> [channel] [cmd]
Listen on a specified RFCOMM channel for incoming connections.
If no channel is specified, it will use the channel number 1,
but a channel must be specified before cmd. If cmd is given, it
will be executed as soon as a client connects. When the child
process terminates or the client disconnect, the command will
terminate. Occurences of {} in cmd will be replaced by the name
of the device used by the connection. This command can be termi=E2=80=90
nated with the key sequence CTRL-C.

watch <dev> [channel] [cmd]
Watch is identical to listen except that when the child process
terminates or the client disconnect, the command will restart
listening with the same parameters.

Frederic

Johan Hedberg a =C3=A9crit :
> Hi Frederic,
>
> The patch is now in the CVS. Could you provide a patch to the manual=20
> page (rfcomm.1) too?
>
> Johan
>
>
> -----------------------------------------------------------------------=
--
> Using Tomcat but need to do more? Need to support web services, securit=
y?
> Get stuff done quickly with pre-integrated technology to make your job =
easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  =20


--------------060802050201010402050901
Content-Type: text/x-patch;
 name="patch_bluez_rfcomm_man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_bluez_rfcomm_man.patch"

? Doxyfile
? Makefile
? Makefile.in
? aclocal.m4
? autom4te.cache
? bluezutils.kdevelop
? bluezutils.kdevelop.pcs
? bluezutils.kdevses
? config.guess
? config.h
? config.h.in
? config.log
? config.status
? config.sub
? configure
? debug
? depcomp
? install-sh
? libtool
? ltmain.sh
? missing
? stamp-h.in
? stamp-h1
? alsa/.deps
? alsa/.libs
? alsa/Makefile
? alsa/Makefile.in
? alsa/libasound_module_pcm_a2dp.la
? alsa/libasound_module_pcm_headset.la
? alsa/pcm_a2dp.lo
? alsa/pcm_headset.lo
? alsa/sbc.lo
? audio/.deps
? audio/.libs
? audio/Makefile
? audio/Makefile.in
? audio/bt.audiod
? common/.deps
? common/.libs
? common/Makefile
? common/Makefile.in
? common/test_textfile
? cups/.deps
? cups/.libs
? cups/Makefile
? cups/Makefile.in
? cups/bluetooth
? daemon/.deps
? daemon/.libs
? daemon/Makefile
? daemon/Makefile.in
? daemon/bluetoothd
? daemon/bt.echod
? daemon/service-agent-glue.h
? dund/.deps
? dund/.libs
? dund/Makefile
? dund/Makefile.in
? dund/dund
? fuse/.deps
? fuse/Makefile
? fuse/Makefile.in
? hcid/.deps
? hcid/.libs
? hcid/Makefile
? hcid/Makefile.in
? hcid/auth-agent
? hcid/hcid
? hcid/lexer.c
? hcid/parser.c
? hcid/parser.h
? hcid/passkey-agent
? hcid/service-agent
? hidd/.deps
? hidd/.libs
? hidd/Makefile
? hidd/Makefile.in
? hidd/hidd
? input/.deps
? input/.libs
? input/Makefile
? input/Makefile.in
? input/bt.inputd
? network/.deps
? network/.libs
? network/Makefile
? network/Makefile.in
? network/bt.networkd
? pand/.deps
? pand/.libs
? pand/Makefile
? pand/Makefile.in
? pand/pand
? rfcomm/.deps
? rfcomm/.libs
? rfcomm/Makefile
? rfcomm/Makefile.in
? rfcomm/cvs
? rfcomm/lexer.c
? rfcomm/main.c.modified
? rfcomm/main.patch
? rfcomm/mainx.c
? rfcomm/parser.c
? rfcomm/parser.h
? rfcomm/rfcomm
? scripts/Makefile
? scripts/Makefile.in
? sdpd/.deps
? sdpd/.libs
? sdpd/Makefile
? sdpd/Makefile.in
? sdpd/sdpd
? sync/.deps
? sync/Makefile
? sync/Makefile.in
? test/.deps
? test/.libs
? test/Makefile
? test/Makefile.in
? test/attest
? test/bdaddr
? test/hciemu
? test/hstest
? test/l2test
? test/rctest
? test/scotest
? test/sttest
? tools/.deps
? tools/.libs
? tools/Makefile
? tools/Makefile.in
? tools/ciptool
? tools/hciattach
? tools/hciconfig
? tools/hcisecfilter
? tools/hcitool
? tools/l2ping
? tools/ppporc
? tools/sdptool
Index: rfcomm/rfcomm.1
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/rfcomm.1,v
retrieving revision 1.5
diff -u -r1.5 rfcomm.1
--- rfcomm/rfcomm.1	10 Aug 2006 09:48:13 -0000	1.5
+++ rfcomm/rfcomm.1	13 Nov 2006 12:08:14 -0000
@@ -70,10 +70,22 @@
 tries to read the data from the config file. This command can
 be terminated with the key sequence CTRL-C.
 .TP 
-.BI listen " <dev> [channel]"
+.BI listen " <dev> [channel] [cmd]"
 Listen on a specified RFCOMM channel for incoming connections.
-If no channel is specified, it will use the channel number 1.
-This command can be terminated with the key sequence CTRL-C.
+If no channel is specified, it will use the channel number 1, but
+a channel must be specified before cmd. If cmd is given, it will be
+executed as soon as a client connects. When the child process 
+terminates or the client disconnect, the command will terminate.
+Occurences of {} in cmd will be replaced by the name of the device
+used by the connection. This command can be terminated with the key
+sequence CTRL-C.
+.TP
+.BI watch " <dev> [channel] [cmd]"
+Watch is identical to
+.B listen
+except that when the child process terminates or the client
+disconnect, the command will restart listening with the same 
+parameters.
 .TP
 .BI bind " <dev> [bdaddr] [channel]"
 This binds the RFCOMM device to a remote Bluetooth device. The

--------------060802050201010402050901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------060802050201010402050901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060802050201010402050901--
