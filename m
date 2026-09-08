Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F583BBFD4;
	Tue,  8 Sep 2026 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900141; cv=none; b=CueQyaLy8wB+9XPzX77Bv1J5z+5hE/i+QPdO+R2CoAiDl9x3BLMEFLUJokI4QvH6UJqvYE8HgJqGTx7/zeXv8lWSE7e/YU4GtC66hQL1iK9ij1oY5KZIBYpP2Sg3E/8FUQakUbIGD1v+dd/ZWC4YIx8WPol1gWZl5aVWOaJqTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900141; c=relaxed/simple;
	bh=/5aIl5jFxCxy/B89se+USEFS0yFI+8r5ReGtl+9mPKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PqA1jrpN9Z9GU0fcsnS9HZwstXKkxEgDZd6V8u+nwwOm1pW+gZqgKCbKtqWqSTwBBgNLuxl7lQaDXsGJQFWYLidt6V7O2K4sbZWptaiBJheE8hdLi/g6ulbpzNx4uiXEyFurLXFzFl7BolZV8gB2v81juTzZBdIviI6i2Ddecvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=NeuWlbR8; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="NeuWlbR8"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-b5z24
	(smtpc-mxb-7db765f675-b5z24 [2a02:598:96:8a00::1200:50a])
	id 4a064b52fc3ce64b4f89511a;
	Tue, 08 Sep 2026 22:42:07 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788900127;
	bh=Fy7bapPJD1J8iJlC0ojXN9lkfoGJuyBA3BPYxUrIvFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=NeuWlbR8m6iRAvhT/3O1hgLRj6vL4I2fDy+sWhS9hTq+M5fv0qIcbHwr59xV/I/kB
	 SQCGkWYIR6A1ZyCzeCH29Es4RAvtI1xi8HHKZrRElY/eNh1AJ8X1sXP+jm9Gblp67y
	 JrT4vxn7IVnHcesKIbWIPCq2uEOPWCNebHMM/SsUpuNRJfmV9jDKXLtRmiU+9nPbkk
	 0Vjyww+sDAIubWDYVdRGhhKJdCKOyEp5wjMMRHjuw5GOhuAgQozcxRdKVS9YHwvmS2
	 Acc0+l7RupxbZMjExawxp2v1aEyTms543wq5dYh7cKFOZKYKEgIpva3Xjlzcq0Qbzg
	 IFFgf5HUe7JLw==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-7887d69dc5-l222k (szn-email-smtpd/2.0.82) with ESMTPA
	id 26cf6211-5c38-468e-91f2-4a1104d464cf;
	Tue, 08 Sep 2026 22:41:39 +0200
From: Radek Podgorny <radek@podgorny.cz>
Date: Tue, 08 Sep 2026 22:41:38 +0200
Subject: [PATCH v2] Bluetooth: put the peer's on-air address on air when we
 cannot resolve
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-for-upstream-le-connect-on-air-addr-v2-1-2ae9fa066ec8@podgorny.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNTQrCMBCFr1Jm7WAI2FqvIi4mydRGbFJmUimU3
 t1UNw++x/vZQFkiK9yaDYQ/UWNOFeypAT9SejLGUBmssa3pzRWHLLjMWoRpwjejzymxL5gTUhS
 kEKp0fUvc2osxHdSlWXiI6+/l/vizLu5Va8f0kXCkjE4o+fGwXMHEazlPpIUF9v0LzudTCqgAA
 AA=
X-Change-ID: 20260908-for-upstream-le-connect-on-air-addr-a796ae625007
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

An identity address only reaches a peer that is advertising an RPA if the
controller resolves it on our behalf. Where it cannot, the host has to put
the peer's on-air address on air itself.

hci_connect_le() still swaps the caller's identity address for the peer's
cached RPA before creating the connection, but __hci_conn_add() resolves
the RPA back to the identity address when it stores it, so the identity is
what goes out. Storing the identity is right when the controller
translates it on the way to the radio; without LL Privacy, or with this
peer absent from the resolving list, nothing does.

A peer advertising an RPA cannot answer its identity address, so the
attempt burns a full create-connection timeout. That is not merely a slow
connect: a controller without extended scanning cannot scan while it is
initiating, so every dead attempt also takes the scanner off the air for
the whole timeout.

Measured on a CYW43438, which reports neither LL Privacy nor extended
advertising (LE features 3f 00 00 08 00 00 00 00), against a peer
advertising a resolvable private address the host holds the IRK for, with
the connection requested on the peer's identity address:

  before: LE Create Connection to the identity address, public type
          1.61s -> 22.07s, then LE Create Connection Cancel
          LE Connection Complete: Unknown Connection Identifier (0x02)
  after:  LE Create Connection to the peer's RPA, random type
          LE Connection Complete: Success

Advertising reports reaching the host per second, same window, same five
unrelated devices on the adapter:

  before   1s:2   [nothing from 2s through 21s]   22s:5  23s:3
  after    0s:11 1s:5 2s:2 3s:5 4s:3 5s:4 ... 21s:2 22s:1 23s:2

One dead connect costs twenty seconds of scanning for every device on the
adapter, not just the one being dialled.

Keep the RPA in conn->dst unless the controller will translate the
identity address: address resolution enabled and the peer's identity
actually programmed into the resolving list. Testing ll_privacy_capable()
alone would not be enough: it reports the feature bit, not whether
resolution is switched on and not whether this peer is in the list.
Resolution is cleared with the other volatile flags on power-off and
switched off again while suspend pauses scanning, and a peer's IRK is only
programmed along the accept list path, so a direct-connect target, a peer
without HCI_CONN_FLAG_ADDRESS_RESOLUTION, and one that did not fit in a
full list are all absent from it.

With the peer programmed, the identity address stays in conn->dst and the
controller translates it: measured on an Intel controller, the host dials
the identity and LE Enhanced Connection Complete reports Resolved Public
with the peer's RPA in the separate peer resolvable private address field.
With the peer absent from the list the same setup dials the RPA itself.

Everything downstream already copes with an RPA in conn->dst: it is what
every outgoing LE connection stored before 14b06c3a88f7, the connection
complete event names the address that was dialled, and
le_conn_complete_evt() resolves it back to the identity once the link is
up. ISO links keep the unconditional conversion: they are created from an
existing ACL or a periodic sync and never dial this address themselves.

Fixes: 14b06c3a88f7 ("Bluetooth: HCI: Always use the identity address when initializing a connection")
Assisted-by: Claude:claude-opus-5
Assisted-by: Claude:claude-fable-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
Changes in v2:
 - Move the address choice into __hci_conn_add() rather than translating
   at the create-connection command builders, as suggested by Luiz. The
   RPA that hci_connect_le() swaps in is simply kept when the controller
   will not translate the identity address for us, which is how every
   outgoing LE connection stored it before 14b06c3a88f7.
 - Drop the "record when an IRK's RPA was last seen" patch, and with it
   the freshness window and the smp_irk change. hci_find_irk_by_rpa()
   already refreshes irk->rpa on every advertising report the host
   resolves, so the cached address is as current as the scan that led to
   the connect and no timestamp is needed.
 - One patch instead of two, so no cover letter this time.
 - Link to v1: https://lore.kernel.org/linux-bluetooth/20260908012048.3681904-2-radek@podgorny.cz/

Per Documentation/process/generated-content.rst: this was developed with
the help of the Claude coding assistant, as recorded in the Assisted-by
trailer. The prompts described the misdirected create-connection, the
btmon captures taken before and after, and Luiz's review of v1; the
assistant was asked to locate where the dialled address is chosen and to
draft the change and its commit message. The measurements, the hardware
testing and the final wording are the author's own.
---
 net/bluetooth/hci_conn.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8de98af2fb58..c9466cb2c7c0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1023,6 +1023,19 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 		if (!hdev->le_mtu && hdev->acl_mtu < HCI_MIN_LE_MTU)
 			return ERR_PTR(-ECONNREFUSED);
 		irk = hci_get_irk(hdev, dst, dst_type);
+		/* An identity address only reaches a peer advertising an RPA
+		 * if the controller translates it. Unless address resolution
+		 * is enabled and this peer is programmed into the resolving
+		 * list, keep the RPA the peer is on air with;
+		 * le_conn_complete_evt() resolves it back once the link is
+		 * up.
+		 */
+		if (irk &&
+		    (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) ||
+		     !hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list,
+						      &irk->bdaddr,
+						      irk->addr_type)))
+			irk = NULL;
 		break;
 	case SCO_LINK:
 	case ESCO_LINK:

---
base-commit: 701ca71884b3d101fd25b7adbf972355056ef352
change-id: 20260908-for-upstream-le-connect-on-air-addr-a796ae625007

Best regards,
--  
Radek Podgorny <radek@podgorny.cz>

