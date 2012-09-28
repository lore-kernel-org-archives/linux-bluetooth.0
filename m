Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 09:16:24 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Cc: Yuanhan Liu <yuanhan.liu@intel.com>,
	kernel-janitors@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org
Subject: [bluetooth:master 224/240] net/bluetooth/hci_event.c:886:3: warning:
 format '%d' expects argument of type 'int', but argument 3 has type 'size_t'
Message-ID: <20120928011624.GB5522@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

FYI, there are new compile warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   392f44d3e7894f6fe314b85b4a1611b7b1d98226
commit: 903e45411099ae8292f5ce637ad0c72f6fef61db [224/240] Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc
config: x86_64-allmodconfig

All warnings:

net/bluetooth/hci_event.c: In function 'hci_cc_read_local_amp_assoc':
net/bluetooth/hci_event.c:886:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' [-Wformat]
net/bluetooth/hci_event.c:886:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' [-Wformat]

vim +886 net/bluetooth/hci_event.c

903e4541 (Andrei Emeltchenko 2012-09-27  870) static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
903e4541 (Andrei Emeltchenko 2012-09-27  871) 					struct sk_buff *skb)
903e4541 (Andrei Emeltchenko 2012-09-27  872) {
903e4541 (Andrei Emeltchenko 2012-09-27  873) 	struct hci_rp_read_local_amp_assoc *rp = (void *) skb->data;
903e4541 (Andrei Emeltchenko 2012-09-27  874) 	struct amp_assoc *assoc = &hdev->loc_assoc;
903e4541 (Andrei Emeltchenko 2012-09-27  875) 	size_t rem_len, frag_len;
903e4541 (Andrei Emeltchenko 2012-09-27  876) 
903e4541 (Andrei Emeltchenko 2012-09-27  877) 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
903e4541 (Andrei Emeltchenko 2012-09-27  878) 
903e4541 (Andrei Emeltchenko 2012-09-27  879) 	if (rp->status)
903e4541 (Andrei Emeltchenko 2012-09-27  880) 		goto a2mp_rsp;
903e4541 (Andrei Emeltchenko 2012-09-27  881) 
903e4541 (Andrei Emeltchenko 2012-09-27  882) 	frag_len = skb->len - sizeof(*rp);
903e4541 (Andrei Emeltchenko 2012-09-27  883) 	rem_len = __le16_to_cpu(rp->rem_len);
903e4541 (Andrei Emeltchenko 2012-09-27  884) 
903e4541 (Andrei Emeltchenko 2012-09-27  885) 	if (rem_len > frag_len) {
903e4541 (Andrei Emeltchenko 2012-09-27 @886) 		BT_DBG("frag_len %d rem_len %d", frag_len, rem_len);
903e4541 (Andrei Emeltchenko 2012-09-27  887) 
903e4541 (Andrei Emeltchenko 2012-09-27  888) 		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
903e4541 (Andrei Emeltchenko 2012-09-27  889) 		assoc->offset += frag_len;
903e4541 (Andrei Emeltchenko 2012-09-27  890) 
903e4541 (Andrei Emeltchenko 2012-09-27  891) 		/* Read other fragments */
903e4541 (Andrei Emeltchenko 2012-09-27  892) 		amp_read_loc_assoc_frag(hdev, rp->phy_handle);
903e4541 (Andrei Emeltchenko 2012-09-27  893) 
903e4541 (Andrei Emeltchenko 2012-09-27  894) 		return;

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu, Yuanhan Liu                              Intel Corporation
