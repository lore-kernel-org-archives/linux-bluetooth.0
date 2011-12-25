Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <padovan@profusion.mobi>
Subject: BUG: Reordering of L2CAP connection pending/accesspted replies
Date: Sun, 25 Dec 2011 20:34:35 +0000
Message-ID: <A7CD2DBA66569F478A0C1ECFC39E1C520A654C79@DLEE74.ent.ti.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi BlueZ community!

I have encountered an incorrect behavior of l2cap connection
establishment mechanism when handling an incoming connection
request:

> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0083
< ACL data: handle 1 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0083 result 0 status 0
      Connection successful
< HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 1
< ACL data: handle 1 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0083 flags 0x00 clen 0
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 1 mode 0x00 interval 0
    Mode: Active
< ACL data: handle 1 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0083 result 1 status 2
      Connection pending - Authorization pending

After analyzing the code, it seems to me that there is indeed a 
clear possibility that replies will egress out of order on 
multicore systems:

CPU0 (Tasklet: hci_rx_task)          CPU1 (user process)
...                                  sk = sys_accept()
...                                    l2cap_sock_accept()
...                                    add_wait_queue_exclusive()
l2cap_connect_req()                  ...
  result = L2CAP_CR_PEND;            ... 
  status = L2CAP_CS_AUTHOR_PEND;     ...
  parent->sk_data_ready(parent, 0)   ...
  ...                                sys_recvmsg(sk,...)
  ...					       l2cap_sock_recvmsg()
  ...						   __l2cap_connect_rsp_defer()
  ...						     <Send L2CAP_CR_SUCCESS>
  ...
  <Send L2CAP_CR_PEND>            ...

I tried to identify mechanism that should prevent such race but found none.
(Did I miss it ?)
As temporary solution I moved the sk_data_ready() to the end of the function:
 
@@ -2540,6 +2543,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
        struct l2cap_chan *chan = NULL, *pchan;
        struct sock *parent, *sk = NULL;
        int result, status = L2CAP_CS_NO_INFO;
+       int wake_parent = 0;
 
        u16 dcid = 0, scid = __le16_to_cpu(req->scid);
        __le16 psm = req->psm;
@@ -2612,7 +2616,11 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
                                l2cap_state_change(chan, BT_CONNECT2);
                                result = L2CAP_CR_PEND;
                                status = L2CAP_CS_AUTHOR_PEND;
-                               parent->sk_data_ready(parent, 0);
+                               /* can trigger __l2cap_connect_rsp_defer before
+                                * the result is sent (on smp). Indeed?
+                                * parent->sk_data_ready(parent, 0);
+                                */
+                               wake_parent = 1;
                        } else {
                                l2cap_state_change(chan, BT_CONFIG);
                                result = L2CAP_CR_SUCCESS;
@@ -2664,6 +2672,13 @@ sendresp:
                chan->num_conf_req++;
        }
 
+       if (wake_parent) {
+               /* Is locking really required? */
+               bh_lock_sock(parent);
+               parent->sk_data_ready(parent, 0);
+               bh_unlock_sock(parent);
+       }
+
        return 0;
 }

I don’t really like this solution but it does the job.
Comments will be appreciated.
Regards,

Ilia Kolominsky
iliak@ti.com
Direct:  +972(9)7906231
Mobile: +972(54)909009




