Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1156854435.8576.113.camel@localhost>
References: <1156839814.8576.104.camel@localhost>
	<1156848370.5613.66.camel@aeonflux.holtmann.net>
	<1156854435.8576.113.camel@localhost>
Date: Tue, 29 Aug 2006 16:34:43 +0200
Message-Id: <1156862083.6183.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid crash
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pierre-Yves,

> > can you try the latest version from the CVS. I think that Johan fixed
> > this with the mainloop rewrite.
> 
> The CVS version compile is failing at the moment:
> 
> gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
> -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -g -o hcid
> main.o security.o device.o logging.o storage.o sdp.o parser.o lexer.o
> kword.o dbus.o dbus-common.o dbus-error.o dbus-manager.o dbus-adapter.o
> dbus-device.o dbus-service.o dbus-security.o dbus-sdp.o
> dbus-rfcomm.o  /usr/lib/libdbus-1.so /usr/lib/libbluetooth.so ../common/libhelper.a
> dbus-sdp.o: In function `search_process_cb':
> /tmp/Bluez_cvs/bluez-utils-3.4/hcid/dbus-sdp.c:484: undefined reference
> to `sdp_process'
> dbus-sdp.o: In function `sdp_client_connect_cb':
> /tmp/Bluez_cvs/bluez-utils-3.4/hcid/dbus-sdp.c:625: undefined reference
> to `sdp_create'
> /tmp/Bluez_cvs/bluez-utils-3.4/hcid/dbus-sdp.c:632: undefined reference
> to `sdp_set_notify'
> /tmp/Bluez_cvs/bluez-utils-3.4/hcid/dbus-sdp.c:635: undefined reference
> to `sdp_service_search_async'
> 
> I am new to the use of CVS, so I may have made something wrong: as
> running (from bluez.org website)
> 
> cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez co -P utils 
> 
> doesn't create the autoconf scripts, I assumed (sounds strange to me)
> that I had to use those from the released version. So after running the
> command above, I copied the new files from the CVS over the old ones
> from the 3.4 release. Is it the way I am supposed to do, or is there
> another way to retrieve the full "utils" modules, including the scripts
> needed to compile it?

you need to install the libs from CVS, too. We are in the process of
adding an async API to SDP.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
