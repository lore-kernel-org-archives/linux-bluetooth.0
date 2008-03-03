Return-Path: <cyrus@holtmann.org>
Message-ID: <004d01c87d58$5e4b5b10$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Mon, 3 Mar 2008 11:59:44 -0600
MIME-Version: 1.0
Subject: [Bluez-devel] org.bluez.Manager...Activate Service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Gents,

I am experimenting with the 3.27 version of BlueZ (libs and utils), and am attempting to ActivateService for "audio" on 
org.bluez.Manager (path /org/bluez) using dbus_connection_send_with_reply_and_block.  I am receiving the following error:

Method "ActivateService" with signature "s" on interface "org.bluez.Manager" doesn't exist

I get the same error calling from C++ and from Python.

When I look into the source at ..utils/hcid/manager.c, I can see the signature is there (manager_methods, at line 352).  That is 
also where the signature for (e.g.) "FindAdapter" is present, and I can call it successfully (returning "/org/bluez/hci0") with 
virtually identical code.

I have also (from Python) called "ListServices", returning "None", even though "input" is enabled to Autostart (see input.service in 
/etc/bluetooth).

/etc/bluetooth contains both audio.conf and audio.service, both appear to be correctly set up.

The only things I can think of at this point is might be dependencies on levels of glib, dbus-glib, and dbus.  According to the rpms 
(I am using the Mandriva distro), libdbus appears to be at version 0.92, dbus-glib appears to be at version 0.71 and glibc itself 
appears to be at version 2.4.7.

Are there dependencies on newer versions of these? (I know where to get them and will install them, if that is the case.)

Thanks for any help and insight...

David Stockwell
Frequency One 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
