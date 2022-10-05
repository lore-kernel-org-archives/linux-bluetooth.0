Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8ECC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 15:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJEPHI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJEPHH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 11:07:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3A63F1E
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 08:07:04 -0700 (PDT)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1M3VAI-1ogeDX3KBW-000Ycm; Wed, 05 Oct 2022 17:07:01 +0200
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Work around SCO over USB HCI design defect
Date:   Wed,  5 Oct 2022 17:06:21 +0200
Message-Id: <20221005150621.20771-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rpplxXzr8J3LWZir6nsrOegkWaeMyURcPwdf3tEEsILi5hofr0M
 GdlwYBDlpV3Pmskc/u9NSTG+QPC5057GXWsAob141YqFTwOeMkaZrw58My8OjNFrsWxpCmV
 ekNCoYWA8ak6w9ikr9p8N6GannlPQ/zzGrZ2Bpc0YZOD4KVP6t0ZvSjAFo8QjkimlohxQFD
 8Q6nY8UMqbBQeimH72FCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JN2/sP06x7o=:hWM9O5BZpOECFk8Oql5Umy
 DSML9XrnMM71b5rvUJDbQ1iL8U8TNB6Q1NqBhc3Fn+2bBsiard0+sA1sqbASRXUZZOilJDxNE
 UV23IF0OwhgjZwOVLAaRcXEqFPUS2yeilPULcC7+IhNLxj3EPPsqk33cMs1stlDSwZISe0gqf
 9Swc2GEvlbO2ReKBkHyWQcG+rvX18xTHmU5Mx1LGXIkqzoMJ0FKxH46/rQBUx143FiRASKqE2
 hYu6aKfRotOs7jskaRTGi862oOBSZjYXpXMQFXBkaVoFglVBvAnEgBFu8CN31nlqB6Go137LA
 qJrYku3453z7XdazuSmAGWlHfXV8Z6ni6NeHwNQFlB3BwhDYdj5ZiJ9H8W1ufboiwY0tADRdC
 SN//0k61R+fkD+bjkP5icx7VOlnOVCHnYfyLPKeJiJz9ztMGx0TkludeAex56CQep9UYh/NRT
 LcJ+LpsFU2qRdnK6hWWmAtDiTbz//mawV/UBQPavS83OncuZI3CNtHsDqXiv4A1GWbozSACsG
 dEPMZAaDXZljsNrahMXu0UANfnKwA1bmQtfpPUmKxV4dyfhjZ99aFocUGcd11AYSj+a4crOMy
 CzxX8cF3eyQ0Wva/b4BOHNg3CGVPSC4SfXeSs1mdcTox2iSYniMj6GEn8NGa0nrhmxCB7nfw3
 vQgIL99o1jCfxadg1ASTLL8e9FG8iRPeK0MtNqkXRv0+396Op1Fs07IamKr7Oi1HXZ88MyMkx
 mgbIEDNIUNmcfhr06UjTiBq9AFOxoH9jD99Nit7V0w5/CDKfiIokZ71SIEBveD877dARHEBgO
 8O0DHYA1dJRYmYAJwJm1wA9ulsSU57Ljnl9mrvlP8Exrz09cso=
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
v3: put everything in btusb.c with a comment
v2 (mistakenly sent without 'v2' in title): fix typos in commit description
    and expand it

 drivers/bluetooth/btusb.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 15caa6469538..fbf450883601 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -948,6 +948,34 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
+static bool btusb_validate_sco_handle(struct hci_dev *hdev,
+				      struct hci_sco_hdr *hdr)
+{
+	__u16 handle;
+
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
+		// Can't validate, userspace controls everything.
+		return true;
+
+	/*
+	 * USB isochronous transfers are not designed to be reliable and may
+	 * lose fragments.  When this happens, the next first fragment
+	 * encountered might actually be a continuation fragment.
+	 * Validate the handle to detect it and drop it, or else the upper
+	 * layer will get garbage for a while.
+	 */
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
 static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -980,9 +1008,12 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 
 		if (skb->len == HCI_SCO_HDR_SIZE) {
 			/* Complete SCO header */
-			hci_skb_expect(skb) = hci_sco_hdr(skb)->dlen;
+			struct hci_sco_hdr *hdr = hci_sco_hdr(skb);
 
-			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
+			hci_skb_expect(skb) = hdr->dlen;
+
+			if (skb_tailroom(skb) < hci_skb_expect(skb) ||
+			    !btusb_validate_sco_handle(data->hdev, hdr)) {
 				kfree_skb(skb);
 				skb = NULL;
 
-- 
2.37.2

