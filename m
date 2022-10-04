Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E864C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJDOy1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJDOyZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 10:54:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00064631D3
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 07:54:19 -0700 (PDT)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1MTAJr-1om1820wQx-00UcC0; Tue, 04 Oct 2022 16:54:17 +0200
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Work around SCO over USB HCI design defect
Date:   Tue,  4 Oct 2022 16:53:51 +0200
Message-Id: <20221004145351.13066-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3pDagnmDbM1nSb4gBii3QsrhccuxyKZZVaF+aBTTMH1npDGKrkg
 7kY/yauIFW/gQdyYnRvVWnPpqWWv1Xp/Jq+/OibDXRHLgUeJc4jnhaDfcLxJWP5qDAuyrvv
 cA91r5zgsZ2p8VT8UtISE4/Wr6zWdbFaItThRo3MFRoos8F3JAZeYBfkhVqLdV0V/fSf2Bl
 8TsmAYRn0h+1WMYYjk2kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yregkCLqj8c=:AeiBZrGnTBHGRq6+p1Zquu
 vwY33MdeK3RbjblqZG6Z5Bdhbwb3sicZERJ4SSS3P/0xlUrK0GFHEXpnjS0MxORb8yn9mUSDh
 BozmE4D4MLsJq9mrWRtX0iWXCcxBdaBfbk1hIpESbrv385Ou1RuRrbFiUUP98NRcO7PW1Ac/3
 Y91SWWOrx3vUVtwB9CORsgznA0nafJTeX6CG060Mrq6KdyhYVTry8S5+GkI3y9JuqoZcGVqDt
 1MnzYA+lf9Dy4C+PCsmqA6jakpKcEhxPd4ma+SN8eBzydiOEIbNVcCGa2Kn3WUJFv86IucoTf
 8xZa4OdKDHMIU5ZbhzOxRDnwT8APu2guAxKN4yGk2FiQQGEJNof1/JbF0SEZqBMF73csMZwb+
 kSLV+I760TH87OmjXuVhC+D1rOTzkiVuI5UqRXWx91uGqf54Vf1vwL/RcXD+MtfjU/rwso8pZ
 a1mnDmotsjcRxvd+SveQlUed3P6uq+1KZYCeCkDNwymCGSZkKhI8IdFZ1XCGNFQtQakck7u3n
 jUI/NJiXmiCvSRlkDVcNUnXk8u9seNtIqVBr1C86xi9IEGChrS7yc97jCexqD2WGTpoLt4JBw
 ovMe0zxule7YwYXwAcZlxHDk8Gx9UNP/6yKzh3zkKObpVbH/3v9ba5Bu67WHlWcMbSDWNgWB+
 8FbdXPSRsvkVMNwsFywL2CylIHs6FpjXGwA/8MJRD+DlrpToOwfceBs4D4+ScbNIySsLsTK9x
 uogi6u2j2f5B7k+yFfs44+Y8mw2RkZyQ0kGjOhncG1id6bH6ugxT4eshD36XlUF88rGr4eQ4G
 AFTqTvSMfP1lAzmOnTyvT/IYVXCceAd5jtVQOrn6GT/SJZVReY=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The USB interface between the host and the bluetooth adapter used for
SCO packets uses an USB isochronous endpoint with a fragmentation scheme
that does not tolerate errors.  Except USB isochronous transfers do
not provide a reliable stream with guaranteed delivery. (There is no
retry on error, see USB spec v2.0 5.6 and 8.5.5.)

To fragment a packet, the bluetooth HCI simply splits it in parts and
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
errors for an indeterminate amount of time, until the kernel accidentally
resynchronize.

A workaround is to ask the upper layer to prevalidate the first fragment
header.  This is not possible with user channels so this workaround is
disabled in this case.

This problem is the most severe when using an ath3k adapter on an i.MX 6
board, where packet loss occur regularly, possibly because it is an USB1
device connected on an USB2 hub and this is a special case requiring
split transactions.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

---
v2: fix typos in commit description and expand it

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

