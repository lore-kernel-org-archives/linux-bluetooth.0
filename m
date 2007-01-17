Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45AE62FB.2080608@yandex.ru>
Date: Wed, 17 Jan 2007 20:55:07 +0300
From: Max <maxsoftpage@yandex.ru>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] hcitool cc in kernel 2.6.19 and 20 doesn't work.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I kernel 2.6.17 all work fine, but on 2.6.19 and 2.6.20 I have a trouble:
"hcitool scan" find my device, but "hcitool cc bt_address" print 
"Connection timed out".
I turn on debugging in bluetooth module and get following in log:

ON KERNEL 2.6.17, then connect to device work
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
...
Jan 17 18:47:40 darkstar kernel: hci_cs_create_conn: hci0 status 0x0 
bdaddr B9:12:D0:37:12:00 conn 00000000
Jan 17 18:47:40 darkstar kernel: hci_conn_add: hci0 dst B9:12:D0:37:12:00
Jan 17 18:47:40 darkstar kernel: hci_rx_task: hci0
Jan 17 18:47:40 darkstar kernel: hci_event_packet: hci0 evt 0x3
Jan 17 18:47:40 darkstar kernel: hci_conn_complete_evt: hci0
Jan 17 18:47:40 darkstar kernel: hci_send_cmd: hci0 ogf 0x2 ocf 0xd plen 4
Jan 17 18:47:40 darkstar kernel: hci_send_cmd: skb len 7
Jan 17 18:47:40 darkstar kernel: hci_cmd_task: hci0 cmd 1
Jan 17 18:47:40 darkstar kernel: hci_send_frame: hci0 type 1 len 7
Jan 17 18:47:40 darkstar kernel: hci_rx_task: hci0
Jan 17 18:47:40 darkstar kernel: hci_event_packet: hci0 evt 0xe
Jan 17 18:47:40 darkstar kernel: hci_cc_link_policy: hci0 ocf 0xd
Jan 17 18:47:40 darkstar kernel: hci_cc_link_policy: hci0: Command 
complete: ogf LINK_POLICY ocf d
...
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


ON KERNEL 2.6.19, then connect doesn't work
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
...
Jan 17 19:02:44 darkstar kernel: hci_cs_create_conn: hci0 status 0x0 
bdaddr B9:12:D0:37:12:00 conn 00000000
Jan 17 19:02:44 darkstar kernel: hci_conn_add: hci0 dst B9:12:D0:37:12:00
Jan 17 19:02:44 darkstar kernel: hci_conn_add_sysfs: conn d7577800
Jan 17 19:02:44 darkstar kernel: hci_dev_get: 0
Jan 17 19:02:44 darkstar kernel: hci_dev_get: 0
Jan 17 19:02:44 darkstar kernel: hci_dev_do_close: hci0 d6192400
Jan 17 19:02:44 darkstar kernel: hci_req_cancel: hci0 err 0x13
Jan 17 19:02:44 darkstar kernel: inquiry_cache_flush: cache d6192520
Jan 17 19:02:44 darkstar kernel: hci_conn_hash_flush: hdev hci0
Jan 17 19:02:44 darkstar kernel: hci_conn_del: hci0 conn d7577800 handle 0
Jan 17 19:02:44 darkstar kernel: hci_conn_del_sysfs: conn d7577800
Jan 17 19:02:44 darkstar kernel: __hci_request: hci0 start
Jan 17 19:02:44 darkstar kernel: hci_reset_req: hci0 0
Jan 17 19:02:44 darkstar kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x3 plen 0
Jan 17 19:02:44 darkstar kernel: hci_send_cmd: skb len 3
Jan 17 19:02:44 darkstar kernel: hci_cmd_task: hci0 cmd 1
Jan 17 19:02:44 darkstar kernel: hci_send_frame: hci0 type 1 len 3
Jan 17 19:02:44 darkstar kernel: hci_rx_task: hci0
Jan 17 19:02:44 darkstar kernel: hci_event_packet: hci0 evt 0xe
Jan 17 19:02:44 darkstar kernel: hci_cc_host_ctl: hci0 ocf 0x3
Jan 17 19:02:44 darkstar kernel: hci_req_complete: hci0 result 0x00
Jan 17 19:02:44 darkstar kernel: __hci_request: hci0 end: err 0
Jan 17 19:02:44 darkstar kernel: hci_dev_get: 0
...
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

I have installed bluez-libs-3.8  bluez-utils-3.8. Usb bluetooth device 
on laptop (from hal):
  usb_device.product = 'KY-BT100 Bluetooth Adapter'
  info.vendor = 'Integrated System Solution Corp.'
Device to connect are different: nokia phone and pocket pc.

Thanks,
Max_L




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
