Return-Path: <cyrus@holtmann.org>
Message-ID: <482AE9AB.8060105@suse.de>
Date: Wed, 14 May 2008 15:31:23 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------070805010706070303040504"
Subject: [Bluez-devel] Mouse not reconnecting after Timeout
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
--------------070805010706070303040504
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hi,

My Logitech MX LASER does not reconnect after the idle timeout.
If i either pull the dongle and replug it or switch off the mouse and switch
it back on or do a

 dbus-send --system --type=method_call \
           --dest=org.bluez /org/bluez/hci0 \
           org.bluez.Adapter.DisconnectRemoteDevice \
           string:"00:07:61:3F:1B:6D"

then it reconnects fine.
This happens with all dongles (The internal one in my hp2510p, one of the CSR
based HAMA mini-dongles, ...)

I'm running 2.6.25.3 and bluez-{libs,utils}-3.31 with btusb (but it also
happened with hci_usb).
My DELL BT Keyboard and other mice are working fine and reconnecting after
timeout. I have reports of similar symptoms from apple bt-keyboard users.

root@stoetzler:/sys# hcitool info 00:07:61:3F:1B:6D
Requesting information ...
        BD Address:  00:07:61:3F:1B:6D
        Device Name: Logitech MX1000 mouse
        LMP Version: 1.2 (0x2) LMP Subversion: 0x545
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <paging scheme> <power control> <transparent SCO>
                <AFH cap. slave> <AFH cap. master>

root@stoetzler:/sys# hciconfig -a
hci0:   Type: USB
        BD Address: 00:1E:37:A7:C6:D8 ACL MTU: 1017:8 SCO MTU: 64:1
        UP RUNNING PSCAN ISCAN
        RX bytes:0 acl:55432 sco:0 events:1410 errors:0
        TX bytes:1554 acl:43 sco:0 commands:51 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: '2510p builtin'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2129 LMP Ver: 2.0 (0x3) LMP Subver: 0x41cf
        Manufacturer: Broadcom Corporation (15)

I will attach a gzipped hcidump logfile obtained like that:

Wait until the timeout surely expired, then
- hcidump -X -V > /tmp/hcidump.out
- now move the mouse, nothing happens with my mouse cursor
- stop hcidump
- hcidump -X -V >> /tmp/hcidump.out
- move the mouse again
- disconnect the mouse with the above dbus-send command
- move it again, now it reconnects

I hope this helps to finally fix this old annoying bug ;-)

Thanks,

	Stefan
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)

--------------070805010706070303040504
Content-Type: application/x-gzip;
 name="hcidump.out.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hcidump.out.gz"

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
g/30Q/L/pSQD0qMZAQA=
--------------070805010706070303040504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------070805010706070303040504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070805010706070303040504--
