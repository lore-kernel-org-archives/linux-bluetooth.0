Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040330201859.75357.qmail@web10911.mail.yahoo.com>
From: Abhishek Patil <patil_abhishek@yahoo.com>
Reply-To: patilabh@cse.msu.edu
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1823257196-1080677939=:74894"
Subject: [Bluez-users] BlueZ with 2.6.4 kernel
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
Date: Tue, 30 Mar 2004 12:18:59 -0800 (PST)

--0-1823257196-1080677939=:74894
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline


Hello Everyone,

I'm having trouble getting BlueZ to work with the new kernel (2.6.4). I am
using a 3COM Bluetooth USB device. 

I checked Marcel's website and didnt find any patch for the 2.6.x kernel.
so, I assume that I dont need to patch the 2.6 kernel... please correct me
if I am wrong.

I have the Bluetooth options compiled as modules in my kernel. I havent
enabled UART, BCM203X and BFUSB coz I will be using the 3COM USB device
only:

#
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m


My kernel compilation went smoothly and after the first reboot, I installed
the latest bluez-libs and bluez-utils with no errors. After another reboot,
I tried starting bluez:

[root@abhishek-pc BlueZ]# modprobe bluez
FATAL: Module bluez not found.
[root@abhishek-pc BlueZ]# modprobe hci_usb
[root@abhishek-pc BlueZ]# modprobe hci0 up
FATAL: Module hci0 not found.

lsmod shows the following:

[root@abhishek-pc BlueZ]# lsmod
Module                  Size  Used by
snd_seq_oss            32576  0
snd_seq_midi_event      6272  1 snd_seq_oss
snd_seq                52400  4 snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            49220  1
snd_mixer_oss          17536  1 snd_pcm_oss
snd_via82xx            21792  1
snd_pcm                88128  2 snd_pcm_oss,snd_via82xx
snd_timer              22080  2 snd_seq,snd_pcm
snd_ac97_codec         60548  1 snd_via82xx
snd_page_alloc          9348  2 snd_via82xx,snd_pcm
snd_mpu401_uart         6208  1 snd_via82xx
snd_rawmidi            20800  1 snd_mpu401_uart
snd_seq_device          6468  3 snd_seq_oss,snd_seq,snd_rawmidi
hci_usb                12224  0
bluetooth              44452  1 hci_usb
usbcore                63904  1 hci_usb
autofs                 14464  0

I have attached a file called depmod.txt that shows the output of: 
depmod -av | grep ^/lib | grep bluetooth

I guess the error may be coz I havent specified anything about BlueZ in my
modprobe.config. I looked around on the web and found many website that
mention the stuff to be entered in modules.config (which the new kernel
doesnt refer to any more).

Can anyone help me figure out where I am going wrong. Also, it would be
very helpful if someone could send me the entries that I need to have in my
modprobe.config file for BlueZ to work.

Thanks & Regards,
Abhishek


__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
--0-1823257196-1080677939=:74894
Content-Type: text/plain; name="depmod.txt"
Content-Description: depmod.txt
Content-Disposition: inline; filename="depmod.txt"

/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_vhci.ko needs "hci_free_dev": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_vhci.ko needs "hci_alloc_dev": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_vhci.ko needs "hci_unregister_dev": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_vhci.ko needs "hci_register_dev": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "hci_free_dev": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "usb_register": /lib/modules/2.6.4/kernel/drivers/usb/core/usbcore.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "usb_driver_release_interface": /lib/modules/2.6.4/kernel/drivers/usb/core/usbcore.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "usb_submit_urb": /lib/modules/2.6.4/kernel/drivers/usb/core/usbcore.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "usb_match_id": /lib/modules/2.6.4/kernel/drivers/usb/core/usbcore.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "usb_driver_claim_interface": /lib/modules/2.6.4/kernel/drivers/usb/core/usbcore.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "hci_alloc_dev": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "usb_set_interface": /lib/modules/2.6.4/kernel/drivers/usb/core/usbcore.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "usb_deregister": /lib/modules/2.6.4/kernel/drivers/usb/core/usbcore.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "usb_unlink_urb": /lib/modules/2.6.4/kernel/drivers/usb/core/usbcore.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "hci_unregister_dev": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/drivers/bluetooth/hci_usb.ko needs "hci_register_dev": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "hci_send_sco": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "proc_bt": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "batostr": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_sock_link": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_sock_unregister": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_sock_alloc": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_accept_dequeue": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "hci_get_route": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_sock_unlink": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_accept_enqueue": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "hci_connect": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_err": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_sock_wait_state": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_sock_register": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "hci_unregister_proto": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_sock_poll": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "bt_sock_recvmsg": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/sco.ko needs "hci_register_proto": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "l2cap_load": /lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "proc_bt": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "batostr": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_sock_link": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_sock_unregister": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_sock_alloc": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_accept_dequeue": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_sock_unlink": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_accept_enqueue": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_sock_wait_state": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_sock_register": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/rfcomm/rfcomm.ko needs "bt_sock_poll": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "hci_conn_auth": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "proc_bt": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "batostr": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_sock_link": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_sock_unregister": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_sock_alloc": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_accept_dequeue": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "hci_conn_encrypt": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "hci_get_route": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_sock_unlink": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_accept_enqueue": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "hci_connect": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_err": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_sock_wait_state": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_sock_register": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "hci_unregister_proto": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_sock_poll": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "bt_sock_recvmsg": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "hci_register_proto": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko needs "hci_send_acl": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/bnep/bnep.ko needs "l2cap_load": /lib/modules/2.6.4/kernel/net/bluetooth/l2cap.ko
/lib/modules/2.6.4/kernel/net/bluetooth/bnep/bnep.ko needs "bt_sock_unregister": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/bnep/bnep.ko needs "baswap": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/bnep/bnep.ko needs "bt_sock_alloc": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko
/lib/modules/2.6.4/kernel/net/bluetooth/bnep/bnep.ko needs "bt_sock_register": /lib/modules/2.6.4/kernel/net/bluetooth/bluetooth.ko

--0-1823257196-1080677939=:74894--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
