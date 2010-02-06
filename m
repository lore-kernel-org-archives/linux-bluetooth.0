Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <24cc6d3e1002031249u4465b927odab06a3e11c6dea@mail.gmail.com>
References: <24cc6d3e1002031249u4465b927odab06a3e11c6dea@mail.gmail.com>
Date: Sat, 6 Feb 2010 18:34:35 +0300
Message-ID: <24cc6d3e1002060734i1ba36695va8deead6606fd04c@mail.gmail.com>
Subject: Problem with bluetooth headset IQUA BHS-333
From: =?KOI8-R?B?4czFy9PFyiDz1czJzg==?= <sulinalex@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hello! My bluetooth headset IQUA BHS-333 work only on kernel 2.6.24. On all
newer
does not work. Tried last kernel from git blietooth-test, it also does not
work.

nilus@HoMe /usr/src/linux-2.6.24-gentoo-r8 $ cat .config | grep BT
CONFIG_BT=y
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
CONFIG_MAC_EMUMOUSEBTN=y


Now installed gentoo-kernel-2.6.31
net-wireless/bluez-4.39-r2
media-sound/pulseaudio-0.9.19

The headset is connected, I hear the hiss, but the sound is not heard.
Microphone does not work too.

# cat /usr/src/linux-2.6.31-gentoo-r6/.config | grep BT
CONFIG_BT=y
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_BTRFS_FS is not set


$ sudo tailf /var/log/messages

Feb 3 22:52:16 Geenna pulseaudio[3996]: ratelimit.c: 136 events suppressed
Feb 3 22:52:21 Geenna pulseaudio[3996]: ratelimit.c: 127 events suppressed
Feb 3 22:52:25 Geenna bluetoothd[4081]: Disconnected from 00:15:BE:2A:71:81,
/org/bluez/4081/hci0/dev_00_15_BE_2A_71_81
Feb 3 22:52:26 Geenna pulseaudio[3996]: ratelimit.c: 99 events suppressed
Feb 3 22:52:31 Geenna pulseaudio[3996]: ratelimit.c: 91 events suppressed
Feb 3 22:52:36 Geenna pulseaudio[3996]: ratelimit.c: 24 events suppressed
Feb 3 22:52:41 Geenna pulseaudio[3996]: ratelimit.c: 25 events suppressed
Feb 3 22:52:44 Geenna bluetoothd[4081]: link_key_request
(sba=00:0A:94:02:D2:E0, dba=00:15:BE:2A:71:81)
Feb 3 22:52:46 Geenna pulseaudio[3996]: ratelimit.c: 48 events suppressed
Feb 3 22:52:47 Geenna kernel: [18995.307339] btusb_isoc_complete: hci0
corrupted SCO packet
Feb 3 22:52:47 Geenna kernel: [18995.307378] hci_scodata_packet: hci0 SCO
packet for unknown connection handle 0
Feb 3 22:52:47 Geenna kernel: [18995.307384] hci_scodata_packet: hci0 SCO
packet for unknown connection handle 0
Feb 3 22:52:47 Geenna kernel: [18995.307389] hci_scodata_packet: hci0 SCO
packet for unknown connection handle 0
Feb 3 22:52:47 Geenna kernel: [18995.307394] hci_scodata_packet: hci0 SCO
packet for unknown connection handle 0
Feb 3 22:52:47 Geenna kernel: [18995.307398] hci_scodata_packet: hci0 SCO
packet for unknown connection handle 0
Feb 3 22:52:51 Geenna pulseaudio[3996]: ratelimit.c: 52 events suppressed
Feb 3 22:52:52 Geenna kernel: [19000.347654] hci_scodata_packet: hci0 SCO
packet for unknown connection handle 43
Feb 3 22:52:52 Geenna kernel: [19000.347664] hci_scodata_packet: hci0 SCO
packet for unknown connection handle 43
Feb 3 22:52:52 Geenna kernel: [19000.347669] hci_scodata_packet: hci0 SCO
packet for unknown connection handle 43
Feb 3 22:52:52 Geenna bluetoothd[4081]: No matching connection found for
handle 43
Feb 3 22:52:56 Geenna pulseaudio[3996]: ratelimit.c: 22 events suppressed
Feb 3 22:53:01 Geenna pulseaudio[3996]: ratelimit.c: 24 events suppressed
Feb 3 22:53:06 Geenna pulseaudio[3996]: ratelimit.c: 26 events suppressed
Feb 3 22:53:12 Geenna pulseaudio[3996]: ratelimit.c: 19 events suppressed
Feb 3 22:53:17 Geenna pulseaudio[3996]: ratelimit.c: 42 events suppressed
Feb 3 22:53:22 Geenna pulseaudio[3996]: ratelimit.c: 40 events suppressed
Feb 3 22:53:27 Geenna pulseaudio[3996]: ratelimit.c: 26 events suppressed
Feb 3 22:53:32 Geenna pulseaudio[3996]: ratelimit.c: 36 events suppressed
Feb 3 22:53:37 Geenna pulseaudio[3996]: ratelimit.c: 30 events suppressed
Feb 3 22:53:42 Geenna pulseaudio[3996]: ratelimit.c: 40 events suppressed
Feb 3 22:53:47 Geenna pulseaudio[3996]: ratelimit.c: 38 events suppressed
Feb 3 22:53:52 Geenna pulseaudio[3996]: ratelimit.c: 68 events suppressed
Feb 3 22:53:57 Geenna pulseaudio[3996]: ratelimit.c: 44 events suppressed
Feb 3 22:54:02 Geenna bluetoothd[4081]: Disconnected from 00:15:BE:2A:71:81,
/org/bluez/4081/hci0/dev_00_15_BE_2A_71_81
Feb 3 22:54:02 Geenna bluetoothd[4081]: No matching connection found for
handle 43


What other logs need to send?
