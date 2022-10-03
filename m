Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC36DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 14:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJCOdn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiJCOdl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 10:33:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C964481D6
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 07:33:39 -0700 (PDT)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1MHoZM-1oSfDC2YJa-00EvIn; Mon, 03 Oct 2022 16:33:36 +0200
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH] Bluetooth: Add a workaround for SCO over USB HCI design defect
Date:   Mon,  3 Oct 2022 16:25:58 +0200
Message-Id: <20221003142558.17914-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SwjEmG3MMXAwmEZ4DK7NTvF88aIq/pRfwfvzr9ET54E3kHzcSrd
 r7Hd9jCa2n3hIsPVFzNBqoy38MR+69+fGw+ornDaZ6Mj5tQhYyTRTB1MCcvcfUbrlVT/4o+
 BcwkwtISoz2+Ks5h/NWjIZEViNnczGzxylZAY49ddqhZVJEf9r1DsX05Eqcy1SmOoNOIxcc
 UvswZfP8qQhcXv3/yuxAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g5AHpQHCaOs=:LW/7rVZ9Hwp0ngyguf/TRR
 gSp1+bgOZt212rGHgTSMtT4aRqPwL1931YIRzJKgAA21TGZi/ZAN69m60kDq1AnpGqCYluW4t
 3vUEVIsYQJlXogQJQ8QFnlklo0nnL7iwtFMv4+bSShQVbIc2hHV99upqokxI/K1sg2IaIc/No
 NLOPSvzOuduhBTcOwZ1bwF08h1CBXM61Is+EKT8eI2iosP14Us+phR6rvHAWh4lnchG9XjeFZ
 wJK6aSzYrAwx+0R+L01YNbJla7fLFzK5hnzgVKaTeMQcVWVRYglMvAfhnDCEzTaBjyygSSE84
 npnlbzeB5LTVvjQU9C6u9KqIMQ+Oz5W7zsv7vLzLA2gw0dZEG2JfIoBEkZR6/Mq1LyGJ7Yv1T
 Cmybbb+R3aOLW2hpwvhLa/Blk7+WqWfWOjKZTJrdQHZkwt1d/aYe/bR/kaVyar8MDlYlwhMLw
 98YCwNaFsyz87WUkmwteNUmZRikDQVunEpxGb/mEkI+h9NRU25QQLbIFl40l8MhWRQ6HMa7lA
 drJDPAoy/aACAI5FL9T1KUR1LNiOXhfYsoh3JflZ2oP4mLKeN8eNBEq82BLR9KTDEvx1bAezF
 vFVKjr5PF5Yr8oLxKhW087x4vXt0z//DyaCUecO5YnmnnWSSYYzc1ID+KPXraOa0ly+GVQO0Z
 OIoosbzqnmulnTVv3rjlnr4TWGMNwpWJ9WuPhoWYdDoGjg7ezSre2eymiPCdm1jnl23RnWw3h
 6bM62mIIAWlm/+QtKlHVcwHiVw1+GYDla9xS0ORiBdfVhdeu/zZ9ZgvG5mu/sIJ9qdoBsH0m9
 Ru0JwXkALMAuPZikNtnz0ut/vLcokXnu8vOdVvx+iLZ97bil2I=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The USB interface between the host and the bluetooth adapter used for
SCO packets uses an USB isochronous endpoint with a fragmentation scheme
that does not tolerate errors.  Except USB isochronous transfers do
not provide a reliable stream with guaranteed delivery (There is no
retry on error, see USB spec v2.0 5.6 and 8.5.5).

To fragment a packet, the bluetooth HCI simply split it in parts and
transfer them as-is.  The receiver is expected to reconstruct the packet
by assuming the first fragment contains the header and parsing its size
field.  There is no error detection either.

If a fragment is lost, the end result is that the kernel is no longer
synchronized and will pass malformed data to the upper layers, since it
has no way to tell if the first fragment is an actual first fragment or
a continuation fragment.  Resynchronization can only happen by luck and
requires an unbounded amount of time.

The typical symptom for a HSP/HFP bluetooth headset is that the
microphone stops working and dmesg contains piles of rate-limited
"Bluetooth: hci0: SCO packet for unknown connection handle XXXX"
errors for an undeterminate amount of time, until the kernel accidently
resynchronize.

A workaround is to ask the upper layer to prevalidate the first fragment
header.  This is not possible with user channels so this workaround is
disabled in this case.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 drivers/bluetooth/btusb.c        |  7 +++++--
 include/net/bluetooth/hci_core.h | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 15caa6469538..f6256af98233 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -980,9 +980,12 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 
 		if (skb->len == HCI_SCO_HDR_SIZE) {
 			/* Complete SCO header */
-			hci_skb_expect(skb) = hci_sco_hdr(skb)->dlen;
+			struct hci_sco_hdr *hdr = hci_sco_hdr(skb);
 
-			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
+			hci_skb_expect(skb) = hdr->dlen;
+
+			if (skb_tailroom(skb) < hci_skb_expect(skb) ||
+			    !hci_conn_prevalidate_sco_hdr(data->hdev, hdr)) {
 				kfree_skb(skb);
 				skb = NULL;
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7862903187d..d589b54e89e6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1286,6 +1286,26 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 	return NULL;
 }
 
+static inline bool hci_conn_prevalidate_sco_hdr(struct hci_dev *hdev,
+						struct hci_sco_hdr *hdr)
+{
+	__u16 handle;
+
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
+		// Can't validate, userspace controls everything.
+		return true;
+
+	handle = hci_handle(__le16_to_cpu(hdr->handle));
+
+	switch (hci_conn_lookup_type(hdev, handle)) {
+	case SCO_LINK:
+	case ESCO_LINK:
+		return true;
+	default:
+		return false;
+	}
+}
+
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
-- 
2.37.2

