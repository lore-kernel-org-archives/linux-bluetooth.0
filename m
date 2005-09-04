Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <431AB491.9070403@BDen.org>
From: "Michael.S.G." <OzFalcon@BDen.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] New BlueZ user, Trouble Compiling snd_bt_sco module.
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 04 Sep 2005 18:47:13 +1000

Hello,
    Michael here - Just getting my feet wet with Bluetooth/linux. Sorry 
for the lack of knowhow & simple questions.....
Im running Fedora Core 4 (Upgraded from core 3) and would like to get a 
Bluetooth headset working.
Sofar things have been going smoothly.
Purchased a D-Link DBT-122 bluetooth dongle and Logitec Mobile Pro headset.
Typing:
  /usr/bin/hcitool dev
Devices:
        hci0    00:13:46:00:A5:B7
And after placing the headset into pairing mode:
 /usr/bin/hcitool scan
Scanning ...
        00:0D:44:0B:AA:A8       Logitech HS01-V16

So far so good.
Now as far as I can figure, I need btsco to link the headset to the alsa 
audio system.
Downloaded btsco and followed the directions on 
http://bluetooth-alsa.sourceforge.net/
 Under the BUILD section, Steps 1-3 seem to have worked. (ie  I can run 
btsco*)
However Step 4 doesn't seem to work.... Here's what I get:
[root@psyche kernel]# make
make[1]: Entering directory `/usr/src/redhat/SOURCES'
make[1]: *** No rule to make target `modules'.  Stop.
make[1]: Leaving directory `/usr/src/redhat/SOURCES'
make: *** [default] Error 2

Im guessing this compiles the snd_bt_sco kernel module. But Im unable to 
compile it.
    Am I doing something obviously wrong? How can I get this going?


Originaly the build directory was linked to a folder that didn't 
exist.... (Renamed to badbuild)
 ls /lib/modules/2.6.12-1.1447_FC4/ -l
total 1048
lrwxrwxrwx  1 root root     47 Sep  4 09:13 badbuild -> 
../../../usr/src/kernels/2.6.12-1.1447_FC4-i686
lrwxrwxrwx  1 root root     24 Sep  4 16:39 build -> 
/usr/src/redhat/SOURCES/
drwxr-xr-x  9 root root   4096 Sep  4 09:13 kernel
-rw-r--r--  1 root root 195101 Sep  4 10:23 modules.alias
-rw-r--r--  1 root root     69 Sep  4 10:23 modules.ccwmap
-rw-r--r--  1 root root 234261 Sep  4 10:23 modules.dep
-rw-r--r--  1 root root    813 Sep  4 10:23 modules.ieee1394map
-rw-r--r--  1 root root    357 Sep  4 10:23 modules.inputmap
-rw-r--r--  1 root root  16284 Sep  4 10:23 modules.isapnpmap
-rw-r--r--  1 root root 169814 Sep  4 10:23 modules.pcimap
-rw-r--r--  1 root root  89255 Sep  4 10:23 modules.symbols
-rw-r--r--  1 root root 268974 Sep  4 10:23 modules.usbmap
lrwxrwxrwx  1 root root      5 Sep  4 09:13 source -> build

 After installing the relevant kernel src rpm, I linked the 'build' 
directory to that. (I think).
 ls /usr/src/redhat/SOURCES/
COPYING.modules
gamin-0.0.25.tar.gz
genkey
kernel-2.6.12-i586.config
kernel-2.6.12-i686.config
kernel-2.6.12-i686-smp.config
kernel-2.6.12-i686-xen0.config
kernel-2.6.12-i686-xenU.config
kernel-2.6.12-ia64.config
kernel-2.6.12-ppc64.config
kernel-2.6.12-ppc64iseries.config
kernel-2.6.12-ppc.config
etc etc etc.

*Running btsco produces this. (I can't load the snd_bt_sco module so I 
think this is the problem!)
 > btsco 00:0D:44:0B:AA:A8
Error: hwdep next device (hw:0): Operation not permitted
Error: control open (hw:1): No such file or directory
Error: Can't find device. Bail


Also, This is the kernel src rpm I installed. Perhaps this is wrong/not 
needed?
    kernel-2.6.12-1.1447_FC4.src.rpm

And kernel is:
 uname -r
2.6.12-1.1447_FC4

Installed blue packages are:
 rpm -qa |grep blue
bluez-pin-0.24-2
gnome-bluetooth-devel-0.5.1-12
gnome-bluetooth-libs-0.5.1-12
bluez-libs-devel-2.15-1
gnome-bluetooth-0.5.1-12
bluez-utils-2.15-7
bluez-bluefw-1.0-6
bluez-libs-2.15-1
bluez-hcidump-1.18-1

Any help appreciated.
    ATB
    Michael.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
