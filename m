Return-Path: <cyrus@holtmann.org>
Message-ID: <16c4cb990804040152m6a6a3eecsc8ff1539cd5df158@mail.gmail.com>
Date: Fri, 4 Apr 2008 14:22:02 +0530
From: "rahul tank" <rahul.tank@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Loading plugin error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1205985107=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1205985107==
Content-Type: multipart/alternative;
	boundary="----=_Part_6023_30286410.1207299122961"

------=_Part_6023_30286410.1207299122961
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
  I am trying to use the new bluez-utils-3.30 (libs-3.30).  This version
implements the new plugin architecture.
I have compiled the bluez-utils-3.30 with "--enable-audio".

However when i run hcid i get the following errors:

rahul@rahul:~/development/build330/sbin$ sudo ./hcid -n -s -d
hcid[32716]: Bluetooth HCI daemon
hcid[32716]: Enabling debug information
hcid[32716]: HCI dev 0 registered
hcid[32716]: HCI dev 0 already up
hcid[32716]: Device hci0 has been added
hcid[32716]: Starting security manager 0
hcid[32716]: Device hci0 has been activated
hcid[32716]: Starting SDP server
hcid[32716]: Adding rec : 0x8093388
hcid[32716]: with handle : 0x1
hcid[32716]: Adding rec : 0x80936c8
hcid[32716]: with handle : 0x0
hcid[32716]: Service classes 0x00
hcid[32716]: Loading plugins
/home/rahul/development/build330/lib/bluetooth/plugins
hcid[32716]: Can't load plugin:
/home/rahul/development/build330/lib/bluetooth/plugins/libnetwork.so:
invalid mode for dlopen(): Invalid argument
hcid[32716]: Can't load plugin:
/home/rahul/development/build330/lib/bluetooth/plugins/libserial.so: invalid
mode for dlopen(): Invalid argument
hcid[32716]: Can't load plugin:
/home/rahul/development/build330/lib/bluetooth/plugins/libinput.so: invalid
mode for dlopen(): Invalid argument
hcid[32716]: Can't load plugin:
/home/rahul/development/build330/lib/bluetooth/plugins/libaudio.so: invalid
mode for dlopen(): Invalid argument
hcid[32716]: child 32717 exited
hcid[32716]: /org/bluez: org.bluez.Security.RegisterDefaultPasskeyAgent()
hcid[32716]: name_listener_add(:1.65)
hcid[32716]: Default passkey agent (:1.65, /org/bluez/passkey) registered
hcid[32716]: child 32718 exited
hcid[32716]: /org/bluez:
org.bluez.Security.RegisterDefaultAuthorizationAgent()
hcid[32716]: Default authorization agent (:1.65, /org/bluez/auth) registered
hcid[32716]: /org/bluez/hci0: org.bluez.Adapter.GetName()




The plugins are present in the mentioned directory

rahul@rahul:~/development/build330/sbin$ ls -l
/home/rahul/development/build330/lib/bluetooth/plugins/
total 1236
-rw-r--r-- 1 rahul rahul 319346 2008-04-04 13:44 libaudio.a
-rwxr-xr-x 1 rahul rahul    860 2008-04-04 14:09 libaudio.la
-rwxr-xr-x 1 rahul rahul 267899 2008-04-04 14:09 libaudio.so
-rw-r--r-- 1 rahul rahul 109184 2008-04-04 13:44 libinput.a
-rwxr-xr-x 1 rahul rahul    860 2008-04-04 14:09 libinput.la
-rwxr-xr-x 1 rahul rahul  98282 2008-04-04 14:09 libinput.so
-rw-r--r-- 1 rahul rahul 120862 2008-04-04 13:44 libnetwork.a
-rwxr-xr-x 1 rahul rahul    872 2008-04-04 14:09 libnetwork.la
-rwxr-xr-x 1 rahul rahul 106683 2008-04-04 14:09 libnetwork.so
-rw-r--r-- 1 rahul rahul  90674 2008-04-04 13:44 libserial.a
-rwxr-xr-x 1 rahul rahul    866 2008-04-04 14:09 libserial.la
-rwxr-xr-x 1 rahul rahul  86910 2008-04-04 14:09 libserial.so


Any pointers would be appreciated .

thanks,
 rahul !!

------=_Part_6023_30286410.1207299122961
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>&nbsp; I am trying to use the new bluez-utils-3.30 (libs-3.30).&nbsp; This version implements the new plugin architecture.<br>I have compiled the bluez-utils-3.30 with &quot;--enable-audio&quot;.<br><br>However when i run hcid i get the following errors:<br>
<br>rahul@rahul:~/development/build330/sbin$ sudo ./hcid -n -s -d<br>hcid[32716]: Bluetooth HCI daemon<br>hcid[32716]: Enabling debug information<br>hcid[32716]: HCI dev 0 registered<br>hcid[32716]: HCI dev 0 already up<br>
hcid[32716]: Device hci0 has been added<br>hcid[32716]: Starting security manager 0<br>hcid[32716]: Device hci0 has been activated<br>hcid[32716]: Starting SDP server<br>hcid[32716]: Adding rec : 0x8093388<br>hcid[32716]: with handle : 0x1<br>
hcid[32716]: Adding rec : 0x80936c8<br>hcid[32716]: with handle : 0x0<br>hcid[32716]: Service classes 0x00<br>hcid[32716]: Loading plugins /home/rahul/development/build330/lib/bluetooth/plugins<br>hcid[32716]: Can&#39;t load plugin: /home/rahul/development/build330/lib/bluetooth/plugins/libnetwork.so: invalid mode for dlopen(): Invalid argument<br>
hcid[32716]: Can&#39;t load plugin: /home/rahul/development/build330/lib/bluetooth/plugins/libserial.so: invalid mode for dlopen(): Invalid argument<br>hcid[32716]: Can&#39;t load plugin: /home/rahul/development/build330/lib/bluetooth/plugins/libinput.so: invalid mode for dlopen(): Invalid argument<br>
hcid[32716]: Can&#39;t load plugin: /home/rahul/development/build330/lib/bluetooth/plugins/libaudio.so: invalid mode for dlopen(): Invalid argument<br>hcid[32716]: child 32717 exited<br>hcid[32716]: /org/bluez: org.bluez.Security.RegisterDefaultPasskeyAgent()<br>
hcid[32716]: name_listener_add(:1.65)<br>hcid[32716]: Default passkey agent (:1.65, /org/bluez/passkey) registered<br>hcid[32716]: child 32718 exited<br>hcid[32716]: /org/bluez: org.bluez.Security.RegisterDefaultAuthorizationAgent()<br>
hcid[32716]: Default authorization agent (:1.65, /org/bluez/auth) registered<br>hcid[32716]: /org/bluez/hci0: org.bluez.Adapter.GetName()<br><br><br><br><br>The plugins are present in the mentioned directory<br><br>rahul@rahul:~/development/build330/sbin$ ls -l /home/rahul/development/build330/lib/bluetooth/plugins/<br>
total 1236<br>-rw-r--r-- 1 rahul rahul 319346 2008-04-04 13:44 libaudio.a<br>-rwxr-xr-x 1 rahul rahul&nbsp;&nbsp;&nbsp; 860 2008-04-04 14:09 <a href="http://libaudio.la">libaudio.la</a><br>-rwxr-xr-x 1 rahul rahul 267899 2008-04-04 14:09 libaudio.so<br>
-rw-r--r-- 1 rahul rahul 109184 2008-04-04 13:44 libinput.a<br>-rwxr-xr-x 1 rahul rahul&nbsp;&nbsp;&nbsp; 860 2008-04-04 14:09 <a href="http://libinput.la">libinput.la</a><br>-rwxr-xr-x 1 rahul rahul&nbsp; 98282 2008-04-04 14:09 libinput.so<br>
-rw-r--r-- 1 rahul rahul 120862 2008-04-04 13:44 libnetwork.a<br>-rwxr-xr-x 1 rahul rahul&nbsp;&nbsp;&nbsp; 872 2008-04-04 14:09 <a href="http://libnetwork.la">libnetwork.la</a><br>-rwxr-xr-x 1 rahul rahul 106683 2008-04-04 14:09 libnetwork.so<br>
-rw-r--r-- 1 rahul rahul&nbsp; 90674 2008-04-04 13:44 libserial.a<br>-rwxr-xr-x 1 rahul rahul&nbsp;&nbsp;&nbsp; 866 2008-04-04 14:09 <a href="http://libserial.la">libserial.la</a><br>-rwxr-xr-x 1 rahul rahul&nbsp; 86910 2008-04-04 14:09 libserial.so<br>
<br><br>Any pointers would be appreciated .<br><br>thanks,<br>&nbsp;rahul !!<br><br>

------=_Part_6023_30286410.1207299122961--


--===============1205985107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1205985107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1205985107==--
