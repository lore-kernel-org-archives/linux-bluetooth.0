Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703AC36B
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513894; cv=none; b=rpjHEBhspJ+N+K1bbIpJpC8DSlo6uYfxHAsHxx15RxojlQvA+X+rpEB+7m9xH0Doi1AqyVpjYalbNsqyM8rFj8Wga/UxiwF2ZcqIAkC0fpB23xtl3Gl0SsrVfRrzm55LPgnnTQnodujFaglQphDQArpvg3MyXeYwcLdxDB9lYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513894; c=relaxed/simple;
	bh=OpH1qgJ21IOSTBs710VOfIQd6xPgRDhtRSviTmp9mrw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CVAkszFXoGx/fRjdg/jso6KF8Sxy9Nl6vX03X6rDfNCxyl6hySpmxR157w8gi03Z6lnuj1C4CcXDhkAdf0NCqeA0FPNsv/MvFg8/hPugW7CPXYS6GGh+lqmJWjHBUXK3FZ8VzBJ55JaKAO9GU189BHxerwCdJJqtNbaPWgMhyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sAevQKoY; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sAevQKoY"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (1.general.hwang4.uk.vpn [10.172.195.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8CA963FB33;
	Wed, 27 Mar 2024 04:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711513889;
	bh=LJ5uyujg2B+J0TBV7YDoRy7rmffmNcxEYPaS/OWPDww=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=sAevQKoYrB8i7QZIz9yRGj+aKWlHQ32/AI65pDC8izSaiucmDgRVSmWWRtzbhD8PJ
	 UUucFrh0AS6qLkIMeJG/WjCxm0cKuk9szZAef8p86NsbU5F+UqSluSKG6SleEdFz/2
	 CpLaYayhNMFQeBEBA8JHctIyhvT9jqFmhQlHtxYXfbIzVCStIbg5SCT1slzpSHuh9l
	 SO6OY9gwaEQ4xoafvlHq0TIXxhBQvIXVExqllMjFryvoxJr3wYNOVPeGO6mv/dinNj
	 9917PdELNpSByu/WCYQVbvxibBKkLYTqz2reGmpChoWM7UuYzS88aNag0cy6gNb/SN
	 HtndR1t6VkFsA==
From: Hui Wang <hui.wang@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	pmenzel@molgen.mpg.de
Subject: [PATCH v2] Bluetooth: hci_event: set the conn encrypted before conn establishes
Date: Wed, 27 Mar 2024 12:30:30 +0800
Message-Id: <20240327043030.243737-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a BT headset (Lenovo Thinkplus XT99), the pairing and
connecting has no problem, once this headset is paired, bluez will
remember this device and will auto re-connect it whenever the device
is powered on. The auto re-connecting works well with Windows and
Android, but with Linux, it always fails. Through debugging, we found
at the rfcomm connection stage, the bluetooth stack reports
"Connection refused - security block (0x0003)".

For this device, the re-connecting negotiation process is different
from other BT headsets, it sends the Link_KEY_REQUEST command before
the CONNECT_REQUEST completes, and it doesn't send ENCRYPT_CHANGE
command during the negotiation. When the device sends the "connect
complete" to hci, the ev->encr_mode is 1.

So here in the conn_complete_evt(), if ev->encr_mode is 1, link type
is ACL and HCI_CONN_ENCRYPT is not set, we set HCI_CONN_ENCRYPT to
this conn, and update conn->enc_key_size accordingly.

After this change, this BT headset could re-connect with Linux
successfully. This is the btmon log after applying the patch, after
receiving the "Connect Complete" with "Encryption: Enabled", will send
the command to read encryption key size:
> HCI Event: Connect Request (0x04) plen 10
        Address: 8C:3C:AA:D8:11:67 (OUI 8C-3C-AA)
        Class: 0x240404
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Wearable Headset Device
          Rendering (Printing, Speaker)
          Audio (Speaker, Microphone, Headset)
        Link type: ACL (0x01)
...
> HCI Event: Link Key Request (0x17) plen 6
        Address: 8C:3C:AA:D8:11:67 (OUI 8C-3C-AA)
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
        Address: 8C:3C:AA:D8:11:67 (OUI 8C-3C-AA)
        Link key: ${32-hex-digits-key}
...
> HCI Event: Connect Complete (0x03) plen 11
        Status: Success (0x00)
        Handle: 256
        Address: 8C:3C:AA:D8:11:67 (OUI 8C-3C-AA)
        Link type: ACL (0x01)
        Encryption: Enabled (0x01)
< HCI Command: Read Encryption Key... (0x05|0x0008) plen 2
        Handle: 256
< ACL Data TX: Handle 256 flags 0x00 dlen 10
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Command Complete (0x0e) plen 7
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Success (0x00)
        Handle: 256
        Key size: 16
...

The Bluetooth host controller I have tested:
 Intel 8087:0029
 Intel 8087:0033

Link: https://github.com/bluez/bluez/issues/704
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
In the v2:
 - I replaced "goto notify" with if {} else {}
 - Change the commit title and description according to comments in v1

This is the btmon log for auto re-connecting negotiation
(also pasted the log to the https://github.com/bluez/bluez/issues/704):

Before applying this patch:
https://pastebin.com/NUa9RJv8

After applying the patch:
https://pastebin.com/GqviChTC

 net/bluetooth/hci_event.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4ae224824012..a8b8cfebe018 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3208,6 +3208,31 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_ENCRYPT, &hdev->flags))
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
 
+		/* "Link key request" completed ahead of "connect request" completes */
+		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
+		    ev->link_type == ACL_LINK) {
+			struct link_key *key;
+			struct hci_cp_read_enc_key_size cp;
+
+			key = hci_find_link_key(hdev, &ev->bdaddr);
+			if (key) {
+				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+
+				if (!(hdev->commands[20] & 0x10)) {
+					conn->enc_key_size = HCI_LINK_KEY_SIZE;
+				} else {
+					cp.handle = cpu_to_le16(conn->handle);
+					if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
+							 sizeof(cp), &cp)) {
+						bt_dev_err(hdev, "sending read key size failed");
+						conn->enc_key_size = HCI_LINK_KEY_SIZE;
+					}
+				}
+
+				hci_encrypt_cfm(conn, ev->status);
+			}
+		}
+
 		/* Get remote features */
 		if (conn->type == ACL_LINK) {
 			struct hci_cp_read_remote_features cp;
-- 
2.34.1

