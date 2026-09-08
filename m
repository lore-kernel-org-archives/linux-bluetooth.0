Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C205599A41;
	Tue,  8 Sep 2026 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906646; cv=none; b=tdm9Vx8wb3Q21USTKfEzysm3eHqFAECFVfDiBqaVvF9WKVZPJWiqovsp56dPlFlur3mi/ViD9rNrCb6LOjTlk3YFD4OXoa7CsxKB+QIa+Mg9GGRAL3/SZA/6Y6SI+l0f6lPr4bmDCDYt8Y6FkIc0OW7AiK64sKlhJooRpogOWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906646; c=relaxed/simple;
	bh=xkRA3SsWryu7DlbwcSzKkpPCmeXlBfjYntbFpVJ3814=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oh6of0gFw5GyUXSrpjDvFpUcLTJj2ZDsxGTSu/Hz4yj3gNPGz9esNghJ82NlUTLvG5E4Z0DV9DTmUc/pHJfQm4lFEV8ZhrZ8m//GnhzC8/cVtOuUDUhr8BZ/ipNPYeYD6Aqel4NOUxBqKeXgpna5Dygf+gBgU0xcnjZvFEXJl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=ww6QiAw7; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="ww6QiAw7"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-fgg8f
	(smtpc-mxb-7db765f675-fgg8f [2a02:598:64:8a00::1000:90d])
	id 1f582406a962891f1ad73e4e;
	Wed, 09 Sep 2026 00:30:34 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788906634;
	bh=qX9dXFdeBk2ipP3lgnFYeexZSCLW9x6QEQvTAxC+6tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=ww6QiAw7vm5bFu8PDlQGqtMtWZ7pezhq29jxVsSRmqIn9pmbsFrpc8qWCBTGYOIkX
	 gcY1wRQ0yER82p/mpsSr/bVYI0RT6U3vbDjhvO3hhiFCrNVf5ese5MD1O2g+oInLjL
	 dbldxKppFAVVZCTigcxXrCdaLpgeSZTKtcm8d3hmLMRlx16OkD5RK8ipb4NlmpLsir
	 g3xRKMjcEUvocggrCKdR5pcy6E1kRYw1xptG+fFxxLuw8IK2epIA50UPBUZ8qhgMqx
	 8TMLAKSTAylSgopiNKDGuokLfHMjoRXkS4l6Y1ObsyTYyhtZ2uS6oTTL3pBEDRyeqx
	 Y+y4ilAME8bnQ==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-6ffbffc97b-l7tfj (szn-email-smtpd/2.0.82) with ESMTPA
	id 31f84ae0-7711-4864-9521-f6556ea17b47;
	Wed, 09 Sep 2026 00:29:38 +0200
From: Radek Podgorny <radek@podgorny.cz>
Date: Wed, 09 Sep 2026 00:29:37 +0200
Subject: [PATCH v3 2/2] Bluetooth: put the peer's on-air address on air
 when we cannot resolve
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-for-upstream-le-connect-on-air-addr-v3-2-0e49c4e7abc2@podgorny.cz>
References: <20260909-for-upstream-le-connect-on-air-addr-v3-0-0e49c4e7abc2@podgorny.cz>
In-Reply-To: <20260909-for-upstream-le-connect-on-air-addr-v3-0-0e49c4e7abc2@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
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

Keeping the RPA is only right while the peer is still using it, which is
why the preceding patch drops the cached RPA as soon as the peer is seen
advertising its identity address. Without that, a peer that turns privacy
off would be dialled on the address it abandoned rather than the one it
is answering on.

Fixes: 14b06c3a88f7 ("Bluetooth: HCI: Always use the identity address when initializing a connection")
Assisted-by: Claude:claude-opus-5
Assisted-by: Claude:claude-fable-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
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

-- 
2.55.0

