Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Jan 2008 21:07:08 +0100
From: Michael Domann <profbunny@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-Id: <20080119210708.333efbd8.profbunny@gmx.de>
Mime-Version: 1.0
Subject: [Bluez-users] sound problems with headset
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

hi list,

i try for some time to use my bluetooth headset with debian lenny, atm version 3.24 libs and bluez-utils.

it looks like i have more success like befor, but it doesnt work.

syslog displays

Jan 19 20:47:08 sysiphus kernel: Bluetooth: HCI USB driver ver 2.9
Jan 19 20:47:08 sysiphus kernel: usbcore: registered new interface driver hci_usb
Jan 19 20:47:08 sysiphus hcid[3700]: HCI dev 0 registered
Jan 19 20:47:08 sysiphus hcid[3700]: HCI dev 0 up
Jan 19 20:47:08 sysiphus hcid[3700]: Device hci0 has been added
Jan 19 20:47:08 sysiphus hcid[3700]: Starting security manager 0
Jan 19 20:47:08 sysiphus hcid[3700]: Device hci0 has been activated
Jan 19 20:47:38 sysiphus audio[3724]: Accepted new client connection on unix socket (fd=9)
Jan 19 20:47:38 sysiphus audio[3724]: Audio API: received BT_GETCAPABILITIES_REQ
Jan 19 20:47:38 sysiphus audio[3724]: Got path /org/bluez/hci0 for adapter with address 00:13:EF:F1:44:13
Jan 19 20:47:41 sysiphus audio[3724]: Audio service discovery completed with success
Jan 19 20:47:41 sysiphus audio[3724]: Found Headset record
Jan 19 20:47:41 sysiphus audio[3724]: Discovered Headset service on RFCOMM channel 2
Jan 19 20:47:41 sysiphus audio[3724]: Selecting default device
Jan 19 20:47:41 sysiphus audio[3724]: Audio API: sending BT_GETCAPABILITIES_RSP
Jan 19 20:47:41 sysiphus audio[3724]: Unix client disconnected (fd=9)
Jan 19 20:48:01 sysiphus /USR/SBIN/CRON[27631]: (www-data) CMD (         [ -x /usr/share/drupal5/scripts/cron.sh ] && /usr/share/drupal5/scripts/cron.sh)
Jan 19 20:48:29 sysiphus audio[3724]: Accepted new client connection on unix socket (fd=9)
Jan 19 20:48:29 sysiphus audio[3724]: Audio API: received BT_GETCAPABILITIES_REQ
Jan 19 20:48:29 sysiphus audio[3724]: Audio API: sending BT_GETCAPABILITIES_RSP
Jan 19 20:48:29 sysiphus audio[3724]: Audio API: received BT_SETCONFIGURATION_REQ
Jan 19 20:48:29 sysiphus audio[3724]: State changed /org/bluez/audio/device1: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Jan 19 20:48:33 sysiphus audio[3724]: /org/bluez/audio/device1: Connecting to 00:1A:45:6E:D5:23 channel 2
Jan 19 20:48:33 sysiphus hcid[3700]: link_key_request (sba=00:13:EF:F1:44:13, dba=00:1A:45:6E:D5:23)
Jan 19 20:48:34 sysiphus audio[3724]: State changed /org/bluez/audio/device1: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Jan 19 20:48:34 sysiphus audio[3724]: /org/bluez/audio/device1: Connected to 00:1A:45:6E:D5:23
Jan 19 20:48:34 sysiphus kernel: Bluetooth: SCO (Voice Link) ver 0.5
Jan 19 20:48:34 sysiphus kernel: Bluetooth: SCO socket layer initialized
Jan 19 20:48:34 sysiphus audio[3724]: State changed /org/bluez/audio/device1: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
Jan 19 20:48:36 sysiphus audio[3724]: SCO socket opened for headset /org/bluez/audio/device1
Jan 19 20:48:36 sysiphus audio[3724]: SCO fd=11
Jan 19 20:48:36 sysiphus audio[3724]: Audio API: sending BT_SETCONFIGURATION_RSP
Jan 19 20:48:36 sysiphus audio[3724]: State changed /org/bluez/audio/device1: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
Jan 19 20:48:36 sysiphus audio[3724]: Audio API: received BT_STREAMSTART_REQ
Jan 19 20:48:36 sysiphus audio[3724]: Audio API: sending BT_STREAMSTART_RSP
Jan 19 20:48:36 sysiphus audio[3724]: Audio API: sending BT_STREAMFD_IND
Jan 19 20:48:36 sysiphus audio[3724]: Audio API: received BT_STREAMSTART_REQ

it looks good i think


i have connected  to the HS:
sysiphus:~$ hcitool con
Connections:
        < SCO 00:1A:45:6E:D5:23 handle 0 state 5 lm SLAVE 
        < ACL 00:1A:45:6E:D5:23 handle 2 state 1 lm MASTER 

this also

but my syslog is bombed with messages looks like that
Jan 19 20:48:36 sysiphus audio[3724]: Audio API: sending BT_STREAMFD_IND
Jan 19 20:48:36 sysiphus audio[3724]: Audio API: received BT_STREAMSTART_REQ
sysiphus:~$ cat /var/log/syslog|grep "Audio API: sending BT_STREAMFD_IND"|wc -l
68787

when i try to play with audacious, its only swishes. i have had success to record one time, i dont know how i have done this, i have never can do this again.

any suggestions for me?
thanks and regards from germany

micha



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
