Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48225D20F
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621704; cv=none; b=G4r6b1EfmqFRgJj9ieRl2v36XGVJOm6iyPyrPtamoe98bGSBj6eg0mjTtNAi09X34dkmQsiG+zcalQ/Ohk/pssBqmwa/8iV7ZswXmDgUawubyG7pazLiTQtsKubES7xdNnLTWJFMFlYKZzCphVS8jWBu3uTTjzzXH096irwOdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621704; c=relaxed/simple;
	bh=OsD4ZAQ/SxTV128CAmPMrWrttgf0MBcRHWb6eFdcLWM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=T2G7lWEiW35OLDqtnT4AiaiLNGGxLOSkFlbEpje2WOI6vyvNYDkkvPZUsPYNFppI1EuTu5MbTrlBVLS3k+So/onkx8GuZ/i9x0knGsTvEteGB6QRF4/FpyjYIu/vIfpLB652kXwhiw4g1OPK0XNr+XLf31ZTqliBXEvmvo6gi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TG+LBJ0h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TG+LBJ0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744621700;
	bh=OsD4ZAQ/SxTV128CAmPMrWrttgf0MBcRHWb6eFdcLWM=;
	h=From:To:Subject:Date:From;
	b=TG+LBJ0hsrYXCa+QD4be9XkQPrWsCNkQdPZorKiQbdyAeYOhvKytWfr/QFSVKBMyk
	 kKGS0e3BTcOEjnL4unwu5M/UteBdlJB0PtugaKXB+XZyFh+V7J+DbYsynng++ZC769
	 Aks6TYaXTLZLh7AmF/leobSc8tfqjB2cwvh+oVHFR4CcvJg/G+WU3UEImrv3+GW5ax
	 n9YL6HtyKgtGgSSYYsWbL9/zRdx2V7XXAVgQ2w/7ahM0ziIx1bewjdCNlODm6baioN
	 xKty0kjeyW6uzx2Nu70F164KuW0RfBR/Saj+Q1BfdgCrJGVjwzh8Jxr1JTK5QCw5BQ
	 OzmhasuGbUm5g==
Received: from fdanis-XPS-13-9370.. (2A02-8428-aF44-1001-a15b-1170-70c2-2c46.rev.sfr.net [IPv6:2a02:8428:af44:1001:a15b:1170:70c2:2c46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D39117E0E92
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 11:08:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: l2cap: Process valid commands in too long frame
Date: Mon, 14 Apr 2025 11:08:15 +0200
Message-ID: <20250414090815.32366-1-frederic.danis@collabora.com>
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

This is required for passing PTS test cases:
- L2CAP/COS/CED/BI-14-C
  Multiple Signaling Command in one PDU, Data Truncated, BR/EDR,
  Connection Request
- L2CAP/COS/CED/BI-15-C
  Multiple Signaling Command in one PDU, Data Truncated, BR/EDR,
  Disconnection Request

The test procedure defined in L2CAP.TS.p39 for both tests is:
1. The Lower Tester sends a C-frame to the IUT with PDU Length set
   to 8 and Channel ID set to the correct signaling channel for the
   logical link. The Information payload contains one L2CAP_ECHO_REQ
   packet with Data Length set to 0 with 0 octets of echo data and
   one command packet and Data Length set as specified in Table 4.6
   and the correct command data.
2. The IUT sends an L2CAP_ECHO_RSP PDU to the Lower Tester.
3. Perform alternative 3A, 3B, 3C, or 3D depending on the IUT’s
   response.
   Alternative 3A (IUT terminates the link):
     3A.1 The IUT terminates the link.
     3A.2 The test ends with a Pass verdict.
   Alternative 3B (IUT discards the frame):
     3B.1 The IUT does not send a reply to the Lower Tester.
   Alternative 3C (IUT rejects PDU):
     3C.1 The IUT sends an L2CAP_COMMAND_REJECT_RSP PDU to the
          Lower Tester.
   Alternative 3D (Any other IUT response):
     3D.1 The Upper Tester issues a warning and the test ends.
4. The Lower Tester sends a C-frame to the IUT with PDU Length set
   to 4 and Channel ID set to the correct signaling channel for the
   logical link. The Information payload contains Data Length set to
   0 with an L2CAP_ECHO_REQ packet with 0 octets of echo data.
5. The IUT sends an L2CAP_ECHO_RSP PDU to the Lower Tester.

With expected outcome:
  In Steps 2 and 5, the IUT responds with an L2CAP_ECHO_RSP.
  In Step 3A.1, the IUT terminates the link.
  In Step 3B.1, the IUT does not send a reply to the Lower Tester.
  In Step 3C.1, the IUT rejects the PDU.
  In Step 3D.1, the IUT sends any valid response.

Currently PTS fails with the following logs:
  Failed to receive ECHO RESPONSE.

And HCI logs:
> ACL Data RX: Handle 11 flags 0x02 dlen 20
      L2CAP: Information Response (0x0b) ident 2 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x000000000000002e
          L2CAP Signaling (BR/EDR)
          Connectionless reception
          AMP Manager Protocol
          L2CAP Signaling (LE)
> ACL Data RX: Handle 11 flags 0x02 dlen 13
        frame too long
        08 01 00 00 08 02 01 00 aa                       .........

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
v1->v2: Enhance comment with PTS test cases description

 net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f1c4b8bd7a8b..1bba7152fd70 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7539,6 +7539,22 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (skb->len > len) {
 			BT_ERR("Frame is too long (len %u, expected len %d)",
 			       skb->len, len);
+			/* PTS test cases L2CAP/COS/CED/BI-14-C and BI-15-C
+			 * (Multiple Signaling Command in one PDU, Data
+			 * Truncated, BR/EDR) send a C-frame to the IUT with
+			 * PDU Length set to 8 and Channel ID set to the
+			 * correct signaling channel for the logical link.
+			 * The Information payload contains one L2CAP_ECHO_REQ
+			 * packet with Data Length set to 0 with 0 octets of
+			 * echo data and one invalid command packet due to
+			 * data truncated in PDU but present in HCI packet.
+			 *
+			 * Shorter the socket buffer to the PDU length to
+			 * allow to process valid commands from the PDU before
+			 * setting the socket unreliable.
+			 */
+			skb->len = len;
+			l2cap_recv_frame(conn, skb);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto drop;
 		}
-- 
2.43.0

