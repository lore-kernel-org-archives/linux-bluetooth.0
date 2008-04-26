Return-Path: <cyrus@holtmann.org>
Message-ID: <00b401c8a7ec$5f957550$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Sat, 26 Apr 2008 17:25:00 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B1_01C8A7C2.750FE890"
Subject: [Bluez-devel] Bluez-utils-3.30 plugins failing at startup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_00B1_01C8A7C2.750FE890
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I have been working to get a simple connection working between BlueZ and a CSR Bluetooth module.  I have again hit a roadblock in 
that when initializing the libxxxxx.so plugins, the call to g_module_open fails as shown in the following:

Apr 26 16:27:28 freqonec001 hcid[2817]: Can't load plugin: /usr/lib/bluetooth/plugins/libnetwork.so: invalid mode for dlopen(): 
Invalid argument
Apr 26 16:27:28 freqonec001 hcid[2817]: Can't load plugin: /usr/lib/bluetooth/plugins/libserial.so: invalid mode for dlopen(): 
Invalid argument
Apr 26 16:27:28 freqonec001 hcid[2817]: Can't load plugin: /usr/lib/bluetooth/plugins/libinput.so: invalid mode for dlopen(): 
Invalid argument
Apr 26 16:27:28 freqonec001 hcid[2817]: Can't load plugin: /usr/lib/bluetooth/plugins/libaudio.so: invalid mode for dlopen(): 
Invalid argument

It appears that the dlopen() is failing when called within g_module_open, which is called from /utils/hcid/plugin.c

In my configure, after specifying all of the various directories, I select --enable-debug and --enable-all; I get no errors in the 
make and make install.  The .so and .la files are all in the /usr/lib/bluetooth/plugins directory.  What am I missing?

Interestingly, and probably because I have modified the audio.conf file, the audio service DOES register itself, despite the failure 
of the libaudio.so plugin, as shown in the following...

Apr 26 16:27:28 freqonec001 hcid[2817]: Registering service object: ident=audio, name=Audio service (/org/bluez/service_audio)

When I try to Activate the audio service, it falls over, because under 3.30, the service apparently is looking for a plugin, and not 
the daemon that was used in 3.29 and before (I think I have this right).

Apr 26 16:34:48 freqonec001 hcid[2817]: /org/bluez: org.bluez.Manager.ActivateService()
Apr 26 16:34:48 freqonec001 hcid[2817]: Unable to execute /usr/lib/bluetooth/bluetoothd-service-audio

Prior to today, to get SOMETHING [sort-of] working, I copied a 3.29 version of bluetoothd-service-audio into the /usr/lib/bluetooth 
directory and it had some functionality.  However, once I renamed that module to take it out of the equation, ActivateService fails: 
Exec format error.

The entire startup log (this time around) is attached.

David Stockwell



------=_NextPart_000_00B1_01C8A7C2.750FE890
Content-Type: application/octet-stream;
	name="20080426 Bluez startup.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="20080426 Bluez startup.log"

Apr 26 16:27:27 freqonec001 hcid[2817]: Bluetooth HCI daemon=20
Apr 26 16:27:27 freqonec001 hcid[2817]: Enabling debug information=20
Apr 26 16:27:27 freqonec001 hcid[2817]: Registering experimental manager =
path=20
Apr 26 16:27:27 freqonec001 hcid[2817]: Registering experimental manager =
interface=20
Apr 26 16:27:27 freqonec001 hcid[2817]: HCI dev 0 registered=20
Apr 26 16:27:27 freqonec001 hcid[2817]: Starting SDP server=20
Apr 26 16:27:27 freqonec001 hcid[2817]: Adding rec : 0x8089c10=20
Apr 26 16:27:27 freqonec001 hcid[2817]: with handle : 0x1=20
Apr 26 16:27:27 freqonec001 hcid[2817]: Adding rec : 0x8089dd8=20
Apr 26 16:27:27 freqonec001 hcid[2817]: with handle : 0x0=20
Apr 26 16:27:27 freqonec001 hcid[2817]: Service classes 0x00=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Loading plugins =
/usr/lib/bluetooth/plugins=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Can't load plugin: =
/usr/lib/bluetooth/plugins/libnetwork.so: invalid mode for dlopen(): =
Invalid argument=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Can't load plugin: =
/usr/lib/bluetooth/plugins/libserial.so: invalid mode for dlopen(): =
Invalid argument=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Can't load plugin: =
/usr/lib/bluetooth/plugins/libinput.so: invalid mode for dlopen(): =
Invalid argument=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Can't load plugin: =
/usr/lib/bluetooth/plugins/libaudio.so: invalid mode for dlopen(): =
Invalid argument=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Registering service object: =
ident=3Daudio, name=3DAudio service (/org/bluez/service_audio)=20
Apr 26 16:27:28 freqonec001 hcid[2817]: HCI dev 0 up=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Device hci0 has been added=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Starting security manager 0=20
Apr 26 16:27:28 freqonec001 hcid[2817]: Device hci0 has been activated=20
Apr 26 16:27:28 freqonec001 hcid[2817]: child 2848 exited=20
Apr 26 16:27:28 freqonec001 hcid[2817]: child 2877 exited=20
Apr 26 16:34:48 freqonec001 hcid[2817]: /org/bluez: =
org.bluez.Manager.ActivateService()=20
Apr 26 16:34:48 freqonec001 hcid[2817]: Unable to execute =
/usr/lib/bluetooth/bluetoothd-service-audio=20

------=_NextPart_000_00B1_01C8A7C2.750FE890
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
------=_NextPart_000_00B1_01C8A7C2.750FE890
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_00B1_01C8A7C2.750FE890--
