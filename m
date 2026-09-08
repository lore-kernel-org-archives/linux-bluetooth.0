Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B038239A;
	Tue,  8 Sep 2026 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906611; cv=none; b=T4C4+JYFlTZ1xW4epXFDVCa6BkYDjoYhK2QekxJycE+adTIaqW+o+pI1Y5NAsd2y4vzlDp3luimVPkcQaRtOEwNx0UmkxrZT8davmu8KY9Eqscp0/HCX5bj+2b7h6IhPszysyzST7iYTDCN7sohHkIs35sryh2rmz89eiJsfZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906611; c=relaxed/simple;
	bh=YlbLFj1jubsTAblV9KkgFQYYIwxSXgA9K2+99tuQ61w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1DwwimutiN8tC7d4BZz1X6u24O77VTaZxnpTqF9ovpPm82eCJ4nhdPcX7yO75/nXERBmNt6G0O3Pwz1MbBh55VkbMSyA+PT6/qVB9L6Ke6n6SZVVS4sCncML9mIG5xQzN99qLtDypXYGWFtbbeuLp66Vx8ERWe6XjEAYB09UiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=B+XUlRae; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="B+XUlRae"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-fgg8f
	(smtpc-mxb-7db765f675-fgg8f [2a02:598:64:8a00::1000:90d])
	id 62648af1d45e27e867eb90b9;
	Wed, 09 Sep 2026 00:29:57 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788906597;
	bh=7QOOJZhlQlG9owCJI+3WV6mxQgey+fVxd8O+Sbk7sqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=B+XUlRaeM3Gcxp1n467xEK0mHyOv2Nuz22uMsi1FMyrRcP8i1ZsYcEAudj6y10Dms
	 yh6jk4DX6w9O7rzznQPTkLr2TMRnTDUmlMtC5B05Aty9C1cv6S2FU5UvHuVh5Cx6W4
	 p+TBNyTyPOT2Wl/lSWjFt5B3NYXdGZh+f1g+P/PsEQLqeMIg9b6a7niHQShm6Usya+
	 km36dV2MheUM3C2E/GcTz4i83wo/OlOxn1yV7xWpezIrNRV4jSH5znnJZOQRNkBAR+
	 ssPobw/dwUHZ3sQpaMUHkXyEvtJld8FMtFSxvBptidCya8rKBeomQ2BDd+5GzpSRDR
	 7K/jNEuaLRD5A==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-6ffbffc97b-l7tfj (szn-email-smtpd/2.0.82) with ESMTPA
	id 72f5e36e-961a-4285-ab70-462fe6c4e235;
	Wed, 09 Sep 2026 00:29:37 +0200
From: Radek Podgorny <radek@podgorny.cz>
Date: Wed, 09 Sep 2026 00:29:36 +0200
Subject: [PATCH v3 1/2] Bluetooth: forget a peer's RPA once it advertises
 its identity address
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-for-upstream-le-connect-on-air-addr-v3-1-0e49c4e7abc2@podgorny.cz>
References: <20260909-for-upstream-le-connect-on-air-addr-v3-0-0e49c4e7abc2@podgorny.cz>
In-Reply-To: <20260909-for-upstream-le-connect-on-air-addr-v3-0-0e49c4e7abc2@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

hci_connect_le() dials the RPA cached in the peer's IRK whenever one is
set, on the assumption that a peer holding an IRK is on air with a
resolvable private address. A peer that stops using privacy breaks that
assumption: it advertises its identity address, the cached RPA keeps the
value it had before the change, and the host aims at an address the peer
has abandoned.

Nothing clears the cache. hci_find_irk_by_rpa() refreshes irk->rpa each
time an advertisement resolves, so it tracks rotation, but a peer that
stops sending RPAs stops producing the reports that would update it, and
the stale address then survives until the adapter is powered off.

On the path that creates the connection object this is currently masked:
__hci_conn_add() resolves the cached RPA back to the identity address, so
that is what goes on air. It is not masked on the reuse branch, which
copies the swapped address straight into an existing conn->dst, and the
next patch removes the conversion for the case where the controller
cannot translate an identity address, so the stale RPA would be dialled
there too.

Clear the cached RPA when the peer is seen on its identity address.
hci_find_irk_by_addr() only matches public and static random addresses,
so an unresolved RPA belonging to some other device cannot reach this
path.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 net/bluetooth/hci_event.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2f5e21ff9752..03b805207ab0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6311,6 +6311,15 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	if (irk) {
 		bdaddr = &irk->bdaddr;
 		bdaddr_type = irk->addr_type;
+	} else {
+		/* The peer is on air with its identity address, so whatever
+		 * RPA is cached for it has been abandoned. Drop it, or
+		 * hci_connect_le() would swap it back in and dial an address
+		 * the peer no longer answers.
+		 */
+		irk = hci_find_irk_by_addr(hdev, bdaddr, bdaddr_type);
+		if (irk)
+			bacpy(&irk->rpa, BDADDR_ANY);
 	}
 
 	bdaddr_type = ev_bdaddr_type(hdev, bdaddr_type, &bdaddr_resolved);

-- 
2.55.0

