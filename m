Return-Path: <cyrus@holtmann.org>
Message-ID: <47BAC7BC.7050503@wurmsdobler.org>
Date: Tue, 19 Feb 2008 12:12:44 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Unable to get on D-Bus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

This topic has already come up several times, but the respective answers 
did not solve the problem for me. What happens is:

mx27# /usr/bin/dbus-daemon --system
mx27# /usr/sbin/hcid -n -f /etc/bluetooth/hcid.conf
hcid[1869]: Bluetooth HCI daemon
hcid[1869]: Could not become the primary owner of org.bluez
hcid[1869]: Unable to get on D-Bus

Below some more details about the build process and the configuration 
files. My feeling is that the dbus daemon does not read the bluetooth 
related settings.

Many thanks for your help in advance,
peter.


Build history:

dbus:
     get, extract dbus-1.0.2 and cd
     For successful mx27 cross-compilation patch with:
     diff --exclude CVS -uNr dbus-1.0.2/configure.in 
dbus-1.0.2.modified/configure.in
     --- dbus-1.0.2/configure.in	2006-12-11 19:21:19.000000000 +0000
     +++ dbus-1.0.2.modified/configure.in	2008-02-11 10:57:34.000000000 
+0000
     @@ -719,6 +719,7 @@
          exit (0);
      ]])],
                    [ac_cv_have_abstract_sockets=yes],
     +              [ac_cv_have_abstract_sockets=no],
                    [ac_cv_have_abstract_sockets=no]
      )])
      AC_LANG_POP(C)

     /usr/bin/autoconf
     LIBS=-lz ./configure --prefix=/usr --host=arm-linux 
--build=i686-pc-linux-gnu --without-x
     make
     make install

bluez-libs:
     get, extract luez-libs 3.26 and cd
     ./configure --prefix=/usr --host=arm-linux --build=i686-pc-linux-gnu
     make all
     make install

bluez-utils
     get, extract bluez-utils 3.26 and cd
     LIBS=-lz ./configure --prefix=/usr --host=arm-linux 
--build=i686-pc-linux-gnu --with-alsa=/home/peter/mx27/rootfs/usr/lib 
--with-usb=/home/peter/mx27/rootfs/usr/lib --without-openobex 
--without-fuse --enable-bccmd --with-bluez=/home/peter/mx27/rootfs/usr/lib
     perl -pi -e 
's,^sys_lib_search_path_spec=.*,sys_lib_search_path_spec=,' libtool
     make all
     make install


Configuration files are as

/etc/group:
messagebus:x:666:

/etc/passwd:
messagebus:x:666:666:messagebus:/usr/var/run/dbus:/bin/false

/etc/dbus-1/system.conf:
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-Bus Bus Configuration 
1.0//EN"
  "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
   <type>system</type>
   <user>messagebus</user>
   <fork/>
   <pidfile>/var/run/dbus/pid</pidfile>
   <auth>EXTERNAL</auth>
   <listen>unix:path=/var/run/dbus/system_bus_socket</listen>
   <policy context="default">
     <deny send_interface="*"/>
     <deny receive_interface="*"/>
     <deny own="*"/>
     <allow user="*"/>
     <allow send_destination="org.freedesktop.DBus"/>
     <allow receive_sender="org.freedesktop.DBus"/>
     <allow send_requested_reply="true"/>
     <allow receive_requested_reply="true"/>
   </policy>
   <includedir>system.d</includedir>
   <include ignore_missing="yes">system-local.conf</include>
   <include if_selinux_enabled="yes" 
selinux_root_relative="yes">contexts/dbus_contexts</include>
</busconfig>

/etc/dbus-1/system.d/bluetooth.conf:
<!-- This configuration file specifies the required security policies
      for Bluetooth core service to work. -->
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 
1.0//EN"
  "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
   <!-- ../system.conf have denied everything, so we just punch some 
holes -->
   <policy user="root">
     <allow own="org.bluez"/>
   </policy>
   <policy at_console="true">
     <allow send_destination="org.bluez.Manager"/>
     <allow receive_sender="org.bluez.Manager"/>
     <allow send_path="/org/bluez"/>
     <allow send_destination="org.bluez.Adapter"/>
     <allow receive_sender="org.bluez.Adapter"/>
     <allow send_destination="org.bluez.Service"/>
     <allow receive_sender="org.bluez.Service"/>
     <allow send_destination="org.bluez.Database"/>
     <allow receive_sender="org.bluez.Database"/>
     <allow send_destination="org.bluez.Security"/>
     <allow receive_sender="org.bluez.Security"/>
   </policy>
</busconfig>




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
