Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967F23C4F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368783; cv=none; b=pAD9GsSYL9j9YiHSMTb2Pv9OU1fuOrnoOjow9Y8elxP6Qe/Or+HyQhsB748pxb9dZSG+RioOgdQ2WJQJE1bZnTK3Jr4sp5Op+/9kf9O5mIBQvk3LbQYcwpYph4XcVoaq+zXrcYKd7JUgeR4eiVfUuOPNaA0okA5kq/6HlXjBiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368783; c=relaxed/simple;
	bh=8NTclg9fONqzkzKXdx3TcZYe1MgWFjDDdfzZDmBzaJ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=td1+ewcmwKR3gY8W/vPdKvzA9+YyqxzIqirDthJC0o/GRMecXudbnE7FAR4Ck4Jr04A0bV7TEZmYWWtMnzogepjZYEqXQK2bsL6vhWKlxRD1V2JnyYaPdUXIhMamNACXnrlQoKlObdqYEOHxJNpzt41S/zarqEuV7Lc9OGgsoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jlBbnP8H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jlBbnP8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763368773;
	bh=8NTclg9fONqzkzKXdx3TcZYe1MgWFjDDdfzZDmBzaJ8=;
	h=From:To:Subject:Date:From;
	b=jlBbnP8HU8SCkkHYyNJL99/4uu4cx9s1Y20edgVJxpQou27NGVh89EDS2Ff7agB4v
	 U/H5J+TDjVNx8wTv2cXrcJvGJaf3ICqmmnqWovZJXqDpWDZtv7m0By+kqGf5V4jMxZ
	 5w/G++q4H4a1DwvZYE98uVzEQwUvEHhhREntVUlQg8XutA9z1HunH91PRmGU/nPhsE
	 byspDvQcXW17Mb4MIlw60tqRVDse3pCeXmysXH5JrGNtuQLnXqa41v5TuiIjjW+X5s
	 soy184v27xe/g+5FEW3dBAGpK912rdTrsPjF8MwwS+mGIc3sx5VDtsBxEh8xeJtHkd
	 fc+wCxAgVOh7A==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-5eba-E77F-2baC-Aa7B.rev.sfr.net [IPv6:2a02:8428:af44:1001:5eba:e77f:2bac:aa7b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 215FF17E110D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 09:39:33 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] L2CAP: Accept incomplete SDU
Date: Mon, 17 Nov 2025 09:39:26 +0100
Message-ID: <20251117083926.332188-1-frederic.danis@collabora.com>
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

