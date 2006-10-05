Return-Path: <paul@briny.ondioline.org>
From: Paul Collins <paul@briny.ondioline.org>
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net
Subject: No joy with 2.6.18-mh4 and BT Microsoft IntelliMouse Explorer
Date: Thu, 05 Oct 2006 19:28:22 +1300
Message-ID: <871wpnwa2h.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Like a previous poster I am also having trouble with a Microsoft BT
mouse and 2.6.18-mhX.  Here I am using 2.6.18-mh4 and one thing I
noticed is that the address seems to be reversed in the l2cap debug
info.  The mouse previously worked fine with 2.6.17-mh6 and also works
fine with 2.6.18, albeit in the (dreaded, for me) boot protocol mode.

On vanilla 2.6.18:
  [briny(~)] hidd --show
  00:0D:3A:A1:E2:E4 Bluetooth HID Boot Protocol Device [045e:0098] connected [boot-protocol]

And here is some log output during an attempt to get the mouse to
connect on 2.6.18-mh4.  Note that the bdaddr seems to have its bytes
reversed.  (The machine is powerpc, in case that's relevant.)

I am happy to test patches.  Please CC, as I am not subscribed.


Oct  2 16:47:06 briny kernel: l2cap_connect_ind: hdev hci0, bdaddr E4:E2:A1:3A:0D:00
Oct  2 16:47:07 briny kernel: l2cap_connect_cfm: hcon e4918c00 bdaddr E4:E2:A1:3A:0D:00 status 0
Oct  2 16:47:07 briny kernel: l2cap_conn_add: hcon e4918c00 conn de965f20
Oct  2 16:47:07 briny kernel: l2cap_conn_ready: conn de965f20
Oct  2 16:47:07 briny kernel: l2cap_recv_acldata: conn de965f20 len 12 flags 0x2
Oct  2 16:47:07 briny kernel: l2cap_recv_frame: len 8, cid 0x0001
Oct  2 16:47:07 briny kernel: l2cap_raw_recv: conn de965f20
Oct  2 16:47:07 briny kernel: l2cap_sig_channel: code 0x02 len 4 id 0xc0
Oct  2 16:47:07 briny kernel: l2cap_connect_req: psm 0x1100 scid 0x0078
Oct  2 16:47:07 briny kernel: l2cap_sock_init: sk e4918e00
Oct  2 16:47:07 briny kernel: __l2cap_chan_add: conn de965f20, psm 0x1100, dcid 0x0078
Oct  2 16:47:07 briny kernel: l2cap_sock_set_timer: sk e4918e00 state 2 timeout 10000
Oct  2 16:47:07 briny kernel: l2cap_build_cmd: conn de965f20, code 0x03, ident 0xc0, len 8
Oct  2 16:47:07 briny kernel: l2cap_send_cmd: code 0x03
Oct  2 16:47:07 briny kernel: l2cap_recv_acldata: conn de965f20 len 16 flags 0x2
Oct  2 16:47:07 briny kernel: l2cap_recv_frame: len 12, cid 0x0001
Oct  2 16:47:07 briny kernel: l2cap_raw_recv: conn de965f20
Oct  2 16:47:07 briny kernel: l2cap_sig_channel: code 0x04 len 8 id 0xc1
Oct  2 16:47:07 briny kernel: l2cap_config_req: dcid 0x0040 flags 0x00
Oct  2 16:47:07 briny kernel: l2cap_parse_conf_req: sk e4918e00 len 4
Oct  2 16:47:07 briny kernel: l2cap_build_conf_rsp: sk e4918e00 complete 1
Oct  2 16:47:07 briny kernel: l2cap_add_conf_opt: type 0x01 len 2
Oct  2 16:47:07 briny kernel: l2cap_build_cmd: conn de965f20, code 0x05, ident 0xc1, len 10
Oct  2 16:47:07 briny kernel: l2cap_send_cmd: code 0x05
Oct  2 16:47:07 briny kernel: l2cap_build_cmd: conn de965f20, code 0x0a, ident 0x01, len 2
Oct  2 16:47:07 briny kernel: l2cap_send_cmd: code 0x0a
Oct  2 16:47:47 briny kernel: l2cap_sock_timeout: sock e4918e00 state 7
Oct  2 16:47:47 briny kernel: __l2cap_sock_close: sk e4918e00 state 7 socket 00000000
Oct  2 16:47:47 briny kernel: l2cap_sock_set_timer: sk e4918e00 state 8 timeout 10000
Oct  2 16:47:47 briny kernel: l2cap_build_cmd: conn de965f20, code 0x06, ident 0x02, len 4
Oct  2 16:47:47 briny kernel: l2cap_send_cmd: code 0x06
Oct  2 16:47:47 briny kernel: l2cap_recv_acldata: conn de965f20 len 12 flags 0x2
Oct  2 16:47:47 briny kernel: l2cap_recv_frame: len 8, cid 0x0001
Oct  2 16:47:47 briny kernel: l2cap_raw_recv: conn de965f20
Oct  2 16:47:47 briny kernel: l2cap_sig_channel: code 0x07 len 4 id 0x02
Oct  2 16:47:47 briny kernel: l2cap_disconnect_rsp: dcid 0x0078 scid 0x0040
Oct  2 16:47:47 briny kernel: l2cap_sock_clear_timer: sock e4918e00 state 8
Oct  2 16:47:47 briny kernel: l2cap_chan_del: sk e4918e00, conn de965f20, err 0
Oct  2 16:47:47 briny kernel: l2cap_sock_kill: sk e4918e00 state 9
Oct  2 16:47:47 briny kernel: l2cap_sock_destruct: sk e4918e00
Oct  2 16:47:47 briny kernel: l2cap_disconn_ind: hcon e4918c00 reason 22
Oct  2 16:47:47 briny kernel: l2cap_conn_del: hcon e4918c00 conn de965f20, err 103

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
