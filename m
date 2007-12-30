Return-Path: <cyrus@holtmann.org>
Date: Sun, 30 Dec 2007 21:34:40 +0000 (GMT)
From: Chris Rankin <rankincj@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <123485.22659.qm@web52907.mail.re2.yahoo.com>
Subject: [Bluez-users] Bluetooth headset failing with lib/utils 3.24 and
	bluez-gnome 0.15
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

Hi,

I have a bluetooth headset that used to work fine with bluez-gnome 0.6 and libs/utils 3.16, but it
is now suddenly silent. I have patched my 2.6.23.11 kernel with the updated bluetooth drivers, and
the message log is now giving me the following:

Dec 30 21:17:14 volcano kernel: Bluetooth: HCI USB driver ver 2.9
Dec 30 21:17:14 volcano hcid[2053]: HCI dev 0 registered
Dec 30 21:17:14 volcano kernel: usbcore: registered new interface driver hci_usb
Dec 30 21:17:14 volcano hcid[2053]: HCI dev 0 up
Dec 30 21:17:14 volcano hcid[2053]: Device hci0 has been added
Dec 30 21:17:14 volcano hcid[2053]: Starting security manager 0
Dec 30 21:17:14 volcano hcid[2053]: Device hci0 has been activated
Dec 30 21:17:41 volcano hcid[2053]: link_key_request (sba=00:0A:3A:7D:FF:80,
dba=00:19:7F:30:F8:9E)
Dec 30 21:17:41 volcano hcid[2053]: pin_code_request (sba=00:0A:3A:7D:FF:80,
dba=00:19:7F:30:F8:9E)
Dec 30 21:17:55 volcano hcid[2053]: link_key_notify (sba=00:0A:3A:7D:FF:80, dba=00:19:7F:30:F8:9E)
Dec 30 21:17:56 volcano hcid[2053]: link_key_notify (sba=00:0A:3A:7D:FF:80, dba=00:19:7F:30:F8:9E)
Dec 30 21:18:30 volcano audio[2076]: Audio API: received BT_GETCAPABILITIES_REQ
Dec 30 21:18:30 volcano audio[2076]: Audio API: sending BT_GETCAPABILITIES_RSP
Dec 30 21:18:30 volcano audio[2076]: Audio API: received BT_SETCONFIGURATION_REQ
Dec 30 21:18:30 volcano kernel: Bluetooth: SCO (Voice Link) ver 0.5
Dec 30 21:18:30 volcano kernel: Bluetooth: SCO socket layer initialized
Dec 30 21:19:10 volcano audio[2076]: connect(): Connection timed out (110)
Dec 30 21:19:10 volcano audio[2076]: config failed
Dec 30 21:19:10 volcano audio[2076]: Audio API: sending BT_SETCONFIGURATION_RSP
Dec 30 21:19:16 volcano audio[2076]: Audio API: received BT_GETCAPABILITIES_REQ
Dec 30 21:19:16 volcano audio[2076]: Audio API: sending BT_GETCAPABILITIES_RSP
Dec 30 21:19:17 volcano audio[2076]: Audio API: received BT_SETCONFIGURATION_REQ
Dec 30 21:19:57 volcano audio[2076]: connect(): Connection timed out (110)
Dec 30 21:19:57 volcano audio[2076]: config failed
Dec 30 21:19:57 volcano audio[2076]: Audio API: sending BT_SETCONFIGURATION_RSP

The aplay application is giving me the following:

ALSA lib pcm_bluetooth.c:458:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION failed : Input/output
error(5)
aplay: set_params:962: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 44100
PERIOD_TIME: 125000
PERIOD_SIZE: (5512 5513)
PERIOD_BYTES: (11024 11026)
PERIODS: (3 5)
BUFFER_TIME: 500000
BUFFER_SIZE: 22050
BUFFER_BYTES: 44100
TICK_TIME: 0

Ironically, I was actually getting sound out of this same headset on another machine running
vanilla 2.6.23 with utils/libs 3.20 and bluez-gnome 0.14. However, I had previously paired the
headset with that machine while it was running Fedora 7 before upgrading it to Fedora 8. Deleting
that bonding and trying to re-pair it has rendered that machine as useless as this one, so I am
suspecting that pairing is broken somehow. Is there any way to test the connection between my
headset and adapter, please?

I already have:

# hcitool con
Connections:
        < eSCO 00:19:7F:30:F8:9E handle 0 state 9 lm SLAVE 
        > ACL 00:19:7F:30:F8:9E handle 11 state 1 lm SLAVE AUTH ENCRYPT SECURE

but aplay should give me some noise. Is the "connect(): Connection timed out (110)" message from
the log referring to the bluetooth link to the headset?

Thanks for any help diagnosing this,
Cheers,
Chris




      ___________________________________________________________
Support the World Aids Awareness campaign this month with Yahoo! For Good http://uk.promotions.yahoo.com/forgood/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
