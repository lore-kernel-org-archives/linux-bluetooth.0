Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E64BC010;
	Tue,  8 Sep 2026 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906644; cv=none; b=BBAdFD+cN+4yo+0eVwQqhqL1YZZVhMy4hCnIJ3ep80TRpumDL3fPXDafHQSmOHsqDju0+PINdha09ybbn+OF3iGUmK+7bwkfEZ9Ihfm2BdrIu7qja+WUyKtI25/sP5EJtd2/tmiznaSj8/7DRtI69kOEsm+4o3hXRw7TWUzF5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906644; c=relaxed/simple;
	bh=xZ6Sd2R05pKwvcb3HjS/2b+WfqhnTlckniw3WrSKS7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O04+u+5kP1N/UpxrKMtrFiMpod/xSoSHvoUNEej9sd7J+nkLtcJVoqAdZjTAEn3XXYWS2RMMYFe0ma5KOau8kFZQe/EFNe2/yqiqMBGyD/D/K5K0Wxotl2QUC4eoZHBMjttfEs6xHy0gEgJKw4ST7ua28ipl8A8qPAeT6/4Yrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=FR08Gau6; arc=none smtp.client-ip=77.75.78.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="FR08Gau6"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-fgg8f
	(smtpc-mxb-7db765f675-fgg8f [2a02:598:64:8a00::1000:90d])
	id 44756492f24fc98b41fa7eda;
	Wed, 09 Sep 2026 00:30:34 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788906634;
	bh=aB+yGC1HsXwzxZ/XkRIp7Tql2tQi4ucJ46DOtYWPVCg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc;
	b=FR08Gau6XIiSyeRx+bzJevp8w1PNv0XWWsP+mvufCNinxKbXF0QTua92bvN0tfQHh
	 JiIFoY6fCjLAu2wZ0J2broaB0b51XSAt26NTZ4bQrGOvhvXg5nWcFPZSBmCdjNxkcr
	 +/+a550Nkj8qU1P/lVJTH01ivedUFQ9Dh6tAU2/17Bxw8/gR0ypusHmJuTnbrMnVM/
	 h1f6PMh1qliLTcu+3rzd5vi4ABPj/Sp6NK0XpuMjnaQLJbeKV4CH/Ga7962bK1u0oJ
	 GAVNaFvJS4h3oeAXUFfJJMd1w/fO+rsJn7N/07Mi4Nhdk2gOSiDTdO/lI/RN/OdpWm
	 O1drG+ch208RA==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-6ffbffc97b-l7tfj (szn-email-smtpd/2.0.82) with ESMTPA
	id d473bdd2-02b2-4b71-863a-52c80316daa9;
	Wed, 09 Sep 2026 00:29:37 +0200
From: Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH v3 0/2] Bluetooth: dial the address the peer is actually on
 air with
Date: Wed, 09 Sep 2026 00:29:35 +0200
Message-Id: <20260909-for-upstream-le-connect-on-air-addr-v3-0-0e49c4e7abc2@podgorny.cz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6CMBBFr0K6drTWWMGV9zAuhjJIjbZkWglIu
 LstnsDNJG/y582fRSC2FMS5mAXTYIP1LsFhUwjTobsT2CaxUFJpWckSWs/w7kNkwhc8CYx3jkw
 E7wAtAzZNGqdKI2l1lPIkkqlnau24frnefhze9SOdZXVO1BgIakZnuryqIzga4+6FIRLnQGdD9
 DytPQeVRf9VGhTsQSFVLUqtyZSX3jd3z27amo+4LcvyBfaTzS0LAQAA
X-Change-ID: 20260908-for-upstream-le-connect-on-air-addr-a796ae625007
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

An identity address only reaches a peer advertising an RPA if the
controller resolves it for us; where it cannot, the host has to dial the
peer's on-air address itself. v2 did that by keeping the RPA in conn->dst
when the controller will not translate, which Luiz asked for and which
holds for as long as the peer is still using that RPA.

It does not hold once a peer turns privacy off. hci_connect_le() swaps in
the cached RPA whenever the IRK has one, nothing ever clears that cache,
and a peer that stops sending RPAs stops producing the reports that would
refresh it. Before this series the conversion in __hci_conn_add() hid the
problem by turning the stale RPA back into the identity address; keeping
the RPA exposes it, and every connect attempt goes to an address the peer
has abandoned.

So patch 1 drops a cached RPA as soon as the peer is seen advertising its
identity address, and patch 2 is the v2 change on top of it. In that order
neither commit leaves the tree with the regression.

Not addressed here, by agreement: hci_conn_params_lookup() in
hci_le_create_conn_sync() is keyed by identity address and misses when
conn->dst holds an RPA, so the connection falls back to the default
intervals. That is the pre-14b06c3a88f7 behaviour and is better fixed on
top than folded in.

Measurements, hardware and limitations are unchanged from v2 and are
described in patch 2.

Changes in v3:
 - Add "forget a peer's RPA once it advertises its identity address"
   ahead of the address-selection change, after Luiz pointed out that a
   peer that disabled privacy should be dialled on its identity address
   rather than on a stale RPA.
 - Note the dependency between the two patches in patch 2's changelog.
 - Link to v2: https://lore.kernel.org/linux-bluetooth/20260908-for-upstream-le-connect-on-air-addr-v2-1-2ae9fa066ec8@podgorny.cz/

Changes in v2:
 - Move the address choice into __hci_conn_add() rather than translating
   at the create-connection command builders, as suggested by Luiz.
 - Drop the "record when an IRK's RPA was last seen" patch and the
   freshness window with it; hci_find_irk_by_rpa() already refreshes
   irk->rpa on every advertising report the host resolves.
 - Link to v1: https://lore.kernel.org/linux-bluetooth/20260908012048.3681904-2-radek@podgorny.cz/

Per Documentation/process/generated-content.rst: developed with the help
of the Claude coding assistant, as recorded in the Assisted-by trailers.
The prompts described the misdirected create-connection, the btmon
captures taken before and after, and the review feedback on v1 and v2; the
assistant was asked to locate where the dialled address is chosen, to
trace what invalidates a cached RPA, and to draft the changes and their
commit messages. The measurements, the hardware testing and the final
wording are the author's own.

Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
Radek Podgorny (2):
      Bluetooth: forget a peer's RPA once it advertises its identity address
      Bluetooth: put the peer's on-air address on air when we cannot resolve

 net/bluetooth/hci_conn.c  | 13 +++++++++++++
 net/bluetooth/hci_event.c |  9 +++++++++
 2 files changed, 22 insertions(+)
---
base-commit: 701ca71884b3d101fd25b7adbf972355056ef352
change-id: 20260908-for-upstream-le-connect-on-air-addr-a796ae625007

Best regards,
--  
Radek Podgorny <radek@podgorny.cz>

