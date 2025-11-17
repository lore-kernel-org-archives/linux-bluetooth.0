Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FED31AF07
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371457; cv=none; b=nu+x8kXfVH+4C3o5qV64VD1nplqDiTpW4aW24PYAJejQy0yP8lH1wgeRs6Y+CEvtPYJ6NlKRh1rJQuouO2/Um29jDZuO4RpCK7/b9SoZ2PtcR+HKDnASwsu2r524LMA87JWSuvb/fxrYt0AsbsKhJ7CPIO2aNFbDRyDFEBTY/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371457; c=relaxed/simple;
	bh=8NTclg9fONqzkzKXdx3TcZYe1MgWFjDDdfzZDmBzaJ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=MVMSN5WAvpnqhDZ6mzZYsnqtM2qTTnDvBK2f4g2H6bJkcHX4srJXFEpFfCJ8koDmjh3r66zgOCBniCdV8O0vsOvydR2jArGW1d4MkBiOcfnNgwtN6QQOeOo6iiQvGFted8zyLsPQIafPjTgr8IfIfew99EPW9QRKyc+tiCVKwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N+YA1eqO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N+YA1eqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763371453;
	bh=8NTclg9fONqzkzKXdx3TcZYe1MgWFjDDdfzZDmBzaJ8=;
	h=From:To:Subject:Date:From;
	b=N+YA1eqO9gOZDD4RmraDBKmW74MiIN3/pcsjws1lTzIXhjtgLTxdKoXUyXHfxRpFo
	 lbJhH9Hbnvz0iiRerHarCLVolgTivGjMQtUKrBoHsbZ7NQImoR5yJEfsL1G8GjNwi6
	 Z9E5qipxBlRY45U26L34Zss9bedBpZLyFFtEqW6ajfKNTqvg1gL3UDuTCqQpfydu3E
	 X9iG7x0/CZvWdj1Mo7xGoUkB/Y/4rVOuAMqq24LMXrXoxOAgfqgQcU0+x0CIa8AxNf
	 ZQOG+eaPMwLZfYMAYwIN/DlVOtthzoC1EOzgq9aaXJKhGBzvyb06dEcrnBs1Yj/zuO
	 AARC/XfTRlcUg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-5eba-E77F-2BaC-aa7B.rev.sfr.net [IPv6:2a02:8428:af44:1001:5eba:e77f:2bac:aa7b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 74AB217E11FF
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 10:24:13 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Accept incomplete SDU
Date: Mon, 17 Nov 2025 10:24:08 +0100
Message-ID: <20251117092408.336966-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

During OBEX Abort command, iOS may return an incomplete SDU packet
which ends with the reply to the Abort command.
During OBEX Abort command, iOS may return the L2CAP_SAR_END packet
before the normal end of the SAR packets:

  < ACL Data TX: Handle 21 [2/8] flags 0x00 dlen 11  #194 [hci0] 14.923741
      Channel: 3080 len 7 ctrl 0x060a [PSM 4101 mode Enhanced
               Retransmission (0x03)] {chan 0}
      I-frame: Unsegmented TxSeq 5 ReqSeq 6
        0a 06 ff 00 03 47 84                             .....G.
...
  > ACL Data RX: Handle 21 flags 0x01 dlen 458       #382 [hci0] 19.701854
      Channel: 65 len 1006 ctrl 0x460e [PSM 4101 mode Enhanced
               Retransmission (0x03)] {chan 0}
      I-frame: Start (len 32767) TxSeq 7 ReqSeq 6
        0e 46 ff 7f 90 7f ff 48 7f fc 43 48 41 52 53 45  .F.....H..CHARSE
        ...
> ACL Data RX: Handle 21 flags 0x02 dlen 552         #383 [hci0] 19.701854
> ACL Data RX: Handle 21 flags 0x01 dlen 458         #384 [hci0] 19.755918
      Channel: 65 len 1006 ctrl 0xc610 [PSM 4101 mode Enhanced
               Retransmission (0x03)] {chan 0}
      I-frame: Continuation TxSeq 8 ReqSeq 6
        10 c6 6e 6f 73 61 69 72 65 73 64 65 73 69 67 6e  ..nosairesdesign
        ...
> ACL Data RX: Handle 21 flags 0x02 dlen 552         #385 [hci0] 19.775016
> ACL Data RX: Handle 21 flags 0x01 dlen 458         #386 [hci0] 19.775024
      Channel: 65 len 1006 ctrl 0xc612 [PSM 4101 mode Enhanced
               Retransmission (0x03)] {chan 0}
      I-frame: Continuation TxSeq 9 ReqSeq 6
        12 c6 69 63 6f 20 43 69 74 79 20 54 65 63 68 20  ..ico City Tech
        ...
> ACL Data RX: Handle 21 flags 0x02 dlen 552         #387 [hci0] 19.775024
> ACL Data RX: Handle 21 flags 0x01 dlen 458         #388 [hci0] 19.821542
      Channel: 65 len 1006 ctrl 0xc614 [PSM 4101 mode Enhanced
               Retransmission (0x03)] {chan 0}
      I-frame: Continuation TxSeq 10 ReqSeq 6
        14 c6 6c 74 69 6e 67 20 50 61 72 74 6e 65 72 0d  ..lting Partner.
        ...
> ACL Data RX: Handle 21 flags 0x02 dlen 552         #389 [hci0] 19.821610
> ACL Data RX: Handle 21 flags 0x01 dlen 458         #390 [hci0] 19.821610
      Channel: 65 len 1006 ctrl 0xc616 [PSM 4101 mode Enhanced
               Retransmission (0x03)] {chan 0}
      I-frame: Continuation TxSeq 11 ReqSeq 6
        16 c6 6c 74 69 6e 67 2e 63 6f 6d 0d 0a 55 49 44  ..lting.com..UID
        ...
> ACL Data RX: Handle 21 flags 0x02 dlen 11          #391 [hci0] 19.821610
      Channel: 65 len 7 ctrl 0x8618 [PSM 4101 mode Enhanced
               Retransmission (0x03)] {chan 0}
      I-frame: End TxSeq 12 ReqSeq 6
        18 86 a0 00 03 3e 5d                             .....>]
< ACL Data TX: Handle 21 [1/8] flags 0x00 dlen 12    #392 [hci0] 19.822491
      L2CAP: Disconnection Request (0x06) ident 10 len 4
        Destination CID: 3080
        Source CID: 65

In this case the re-assembled packet should be 32767 bytes as defined
in Start packet (#382), i.e. 33 segmented packets, but the End packet
is sent as the 6th packet.

The l2cap_reassemble_sdu() function returns error -EINVAL if reassembled
packet size != expected size, triggering the L2CAP disconnection, which
disconnects the OBEX session, preventing further OBEX actions.

Log this, discard previous segmented packet data and only send data
from SAR End packet to upstream.

Closes: https://github.com/bluez/bluetooth-next/issues/17
Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/l2cap_core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 35c57657bcf4..5fe1d058455e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5703,13 +5703,20 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb,
 		if (!chan->sdu)
 			break;
 
-		append_skb_frag(chan->sdu, skb,
-				&chan->sdu_last_frag);
+		if (chan->sdu->len + skb->len != chan->sdu_len) {
+			BT_DBG("Incomplete SDU, expected: %u received: %u", chan->sdu_len,
+			       chan->sdu->len + skb->len);
+			/* Discard previous data and keep only L2CAP_SAR_END data */
+			kfree_skb(chan->sdu);
+			chan->sdu = skb;
+			chan->sdu_last_frag = skb;
+			chan->sdu_len = skb->len;
+		} else {
+			append_skb_frag(chan->sdu, skb,
+					&chan->sdu_last_frag);
+		}
 		skb = NULL;
 
-		if (chan->sdu->len != chan->sdu_len)
-			break;
-
 		err = chan->ops->recv(chan, chan->sdu);
 
 		if (!err) {
-- 
2.43.0

