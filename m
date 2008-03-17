Return-Path: <cyrus@holtmann.org>
Message-ID: <194c6ea30803161927v243d712w25eb3cc55e0485d1@mail.gmail.com>
Date: Mon, 17 Mar 2008 10:27:20 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] how to do the HFP/HSP testing?
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

Hi All:
      Im using an ARM9 embeded system running linux2.6.18 and
bluez3.28.Im using a bluetooth module named "STLC2500" with UART
interface.Since the STLC2500 supports only sco over pcm, i connect the
pcm interface of stlc2500 to the CPU's pcm pins.But...so far , i wasnt
able to establish any SCO connections when testing HFP/HSP profile.
Here's some details and questions:
      1.How many ways do we have testing hsp/hfp using bluez?
         I tried "hstest","hsplay", they all resulted in a "sco
connection timed out" error.
         I also tried modifying the asound.conf:
pcm.bluetooth {
  type bluetooth
  device 00:0D:3C:EB:53:F0
     profile hfp
}
Then use "aplay -D bluetooth /*.wav" to play the music. Then it shows:
/ $ aplay -D bluetooth /tmp1/16000.wav
audio[198]: Accepted new client connection on unix socket (fd=7)
audio[198]: Audio API: received BT_GETCAPABILITIES_REQ
audio[198]: Audio API: sending BT_GETCAPABILITIES_RSP
ALSA lib pcm_bluetooth.c:1574:(bluetooth_init) BT_GETCAPABILITIES failed :
Input/output error(5)
aplay: main:564: audio open error: Input/output error
audio[198]: Unix client disconnected (fd=7)

      Anyway, these methods didnt work out. Is there any other way of
testing the hfp/hsp profiles?
      2.My stlc2500 bluetooth chip does not support sco over hci. So i
connected it with my cpu using pcm. My cpu has to play a pcm slave
role, so stlc2500 has to be pcm master(the master generates pcm
clk/sync). The problem is , the stlc2500 should be programmed to be
master or slave , and the value of pcm clk/sync should also be
programmed. According to its spec , it can be programmed through
various HCI commands.....but i dont know which hci command is it?
      Its also loaded with 2 patch files when it started, which the
spec says can also set the value of pcm clk/sync values. The 2 files
are from bluez-firmware-1.2.  Like this:
       STLC2500 R4.2 12102005 12:40:14 ZAV100012
       HW Id= V440BAA
Loading file /lib/firmware/STLC2500_R4_02_04.ptc
Loading file /lib/firmware/STLC2500_R4_02_02_WLAN.ssf
      Is there anyway of modifying those patches so that i can change
the pcm clk/sync(if i can)?

Thanks in advance.

Best Regards


semiyd

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
