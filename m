Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Message-ID: <d7rlnc$vnb$1@sea.gmane.org>
References: <d7qmmr$3fc$1@sea.gmane.org> <42A135D3.9000301@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Re: btsco and Jabra Headset
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
Date: Sat, 04 Jun 2005 09:40:42 +0200

Brad Midgley wrote:
>> ***
>> # btsco -v 00:07:A4:05:2E:14
>> btsco v0.4c
>> Device is 2:0
>> Error: Failed to connect to SDP server: Permission denied
>> Assuming channel 2
>> 
>> Voice setting: 0x0060
>> Can't connect RFCOMM channel: Permission denied
>> CoriCelesti:/usr/src#
>> ***

> sdptool search --bdaddr <bdaddr> 0x1108
>
> I suspect it will fail but I'm not sure why that would happen. If the
> *connection* was failing, I'd tell you to try removing
> /etc/bluetooth/link_key to reset the pairing. But the pairing is
> irrelevant for sdp queries.

*** (as gunter)
gunter@CoriCelesti:~$ sdptool search --bdaddr 00:07:A4:05:2E:14 0x1108
Class 0x1108
Failed to connect to SDP server on 00:07:A4:05:2E:14: Permission denied
gunter@CoriCelesti:~$
*** (as root)
CoriCelesti:/usr/src/linux-2.6.11.11# sdptool search --bdaddr
00:07:A4:05:2E:14 0x1108
Class 0x1108
Failed to connect to SDP server on 00:07:A4:05:2E:14: Permission denied
CoriCelesti:/usr/src/linux-2.6.11.11#
***

Maybe I made an error when configuring the kernel?

***
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
***

***
CoriCelesti:/usr/src/linux-2.6.11.11# lsmod
Module                  Size  Used by
snd_bt_sco             14848  0
snd_hwdep              10336  1 snd_bt_sco
hci_usb                16264  2
rfcomm                 42288  0
l2cap                  25928  5 rfcomm
bluetooth              53252  7 hci_usb,rfcomm,l2cap
(...)
snd_pcm                99020  6
snd_bt_sco,snd_ca0106,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
(...)
snd                    57832  19
snd_bt_sco,snd_hwdep,snd_ca0106,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              11040  1 snd
snd_page_alloc         11464  4 snd_bt_sco,snd_ca0106,snd_intel8x0,snd_pcm
ehci_hcd               35080  0
usbhid                 35776  0
ohci_hcd               22024  0
(...)
CoriCelesti:/usr/src/linux-2.6.11.11#
***

Thanks for your comments!

Greetings,

  Gunter

-- 
If the Creator had said, "Let there be light" in Ankh-Morpork, he'd 
have gotten no further because of all the people saying "What colour?"  
      -- (Terry Pratchett, Men At Arms)
*** PGP-Verschlüsselung bei eMails erwünscht :-) *** PGP: 0x1128F25F ***



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
