Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 09:17:06 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Cc: Yuanhan Liu <yuanhan.liu@intel.com>,
	kernel-janitors@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org
Subject: [bluetooth:master 230/240] net/bluetooth/a2mp.c:358:2: warning:
 format '%u' expects argument of type 'unsigned int', but argument 5 has type
 'long unsigned int'
Message-ID: <20120928011706.GC5522@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

FYI, there are new compile warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   392f44d3e7894f6fe314b85b4a1611b7b1d98226
commit: 9a5e94dbb4aa306742a47cbbcb0a44d4fc77a9e4 [230/240] Bluetooth: A2MP: Process A2MP Get AMP Assoc Rsp
config: x86_64-allmodconfig

All warnings:

net/bluetooth/a2mp.c: In function 'a2mp_getampassoc_rsp':
net/bluetooth/a2mp.c:358:2: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat]

vim +358 net/bluetooth/a2mp.c

9a5e94db (Andrei Emeltchenko 2012-09-27  346) static int a2mp_getampassoc_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
9a5e94db (Andrei Emeltchenko 2012-09-27  347) 				struct a2mp_cmd *hdr)
9a5e94db (Andrei Emeltchenko 2012-09-27  348) {
9a5e94db (Andrei Emeltchenko 2012-09-27  349) 	struct a2mp_amp_assoc_rsp *rsp = (void *) skb->data;
9a5e94db (Andrei Emeltchenko 2012-09-27  350) 	u16 len = le16_to_cpu(hdr->len);
9a5e94db (Andrei Emeltchenko 2012-09-27  351) 	struct hci_dev *hdev;
9a5e94db (Andrei Emeltchenko 2012-09-27  352) 	struct amp_ctrl *ctrl;
9a5e94db (Andrei Emeltchenko 2012-09-27  353) 	struct hci_conn *hcon;
9a5e94db (Andrei Emeltchenko 2012-09-27  354) 
9a5e94db (Andrei Emeltchenko 2012-09-27  355) 	if (len < sizeof(*rsp))
9a5e94db (Andrei Emeltchenko 2012-09-27  356) 		return -EINVAL;
9a5e94db (Andrei Emeltchenko 2012-09-27  357) 
9a5e94db (Andrei Emeltchenko 2012-09-27 @358) 	BT_DBG("id %d status 0x%2.2x assoc len %u", rsp->id, rsp->status,
9a5e94db (Andrei Emeltchenko 2012-09-27  359) 	       len - sizeof(*rsp));
9a5e94db (Andrei Emeltchenko 2012-09-27  360) 
9a5e94db (Andrei Emeltchenko 2012-09-27  361) 	if (rsp->status)
9a5e94db (Andrei Emeltchenko 2012-09-27  362) 		return -EINVAL;

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu, Yuanhan Liu                              Intel Corporation
