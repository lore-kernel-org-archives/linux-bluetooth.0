Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: David Wuertele <dave-gnus@bfnet.com>
Message-ID: <m365a0b8f9.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Thinkpad X31 @ fedora core 2, trying to connect to Nokia 6380i
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 09 Jun 2004 16:47:38 -0700

I boot my thinkpad, and the bluetooth chip is recognized.  My phone
has bluetooth turned on.  I see my phone when I scan, but I can't seem
to connect with it:

# uname -a
Linux 5nave 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 i686 i386 GNU/Linux
# rpm -q bluez-utils bluez-libs
bluez-utils-2.4-3
bluez-libs-2.5-2.1
# grep CONFIG_BT_ /usr/src/linux-2.6.5-1.358/.config
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
# hcitool scan
Scanning ...
	00:60:57:2A:37:E9	Dave's Nokia
# ls -l /dev/rfcomm0
crw-r--r--  1 root root 216, 0 Jun  9 16:15 /dev/rfcomm0
# hcitool dev
Devices:
	hci0	00:20:E0:75:D6:F6
# ps auxwf | grep hcid
root      1982  0.0  0.0  3100  700 ?        S    16:24   0:00 hcid: processing events
root      2785  0.0  0.0  3104  700 ?        S    16:43   0:00  \_ hcid: processing events
root      2790  0.0  0.0  4012  572 pts/1    S    16:44   0:00              \_ grep hcid
# rfcomm connect rfcomm0 00:60:57:2A:37:E9
Can't connect RFCOMM socket: Resource temporarily unavailable
# tail -2 /var/log/messages
Jun  9 16:43:37 5nave hcid[1982]: link_key_request (sba=00:20:E0:75:D6:F6, dba=00:60:57:2A:37:E9) 
Jun  9 16:43:37 5nave hcid[1982]: pin_code_request (sba=00:20:E0:75:D6:F6, dba=00:60:57:2A:37:E9) 
# 

Is there something else I should be doing?

Thanks,
Dave



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
