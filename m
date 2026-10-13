Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EBC479890
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861242; cv=none; b=P4gXdy1feVvOV39NSTfDpr8kcJyuxK6fA9k3lYYxH3wl7iwwB/iD5HEnZb+R/CcW/Ciarq6utFtYx+m/JLqL0Xqx+JvEheuV0gF0xqRNnokuwx+GmnpG9nHJE/GqJ8+VOXEpYPDR2p4XPCeqt5gWUHvi+UsWvnwMzINmmdgGBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861242; c=relaxed/simple;
	bh=fWiT9qYz9GXa8C4RDqGgwU5yH6Bj2XxxOLMaYOZ7rhc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gtorxQXB8ApeOHZDGjtLuhKMfEk/5pvo62yt3Nh8QWBtYo7RsxUYTFgQ9uCbEsPL7LYgNdHnYKH5xa6ILp2FHPhLoy/hBhvs7Z8d6JkCOA6gPNZLWCUZYbGsFNIcJ5Kbf7tDEXUEcVcroncD3i/Xk631gdg4ty0sBY4AvVte2CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NUbyfuG1; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NUbyfuG1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791861233; x=1792120433;
	bh=/flxWmjOQT873io2qPY+p7QiHU00nyqrTJb8WXIdw3g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NUbyfuG1QkDVpTM5zgTz+/5GVBfJ6LhP1jrR1bsIhvkODSui4liTB0htAAl2jDGqU
	 e4OIvvMD2wM7G1PhiFpYA/ij6fF8+qZiGGOIYfBP1EJHw/ZLVQe4fgxv7kPxdMQaGP
	 A+CTlv+N3QgRZ9UEEcBqhRC5XU9r45cMrfs0c63HWS9JYLl8DIUWrser0/w7eQ5m+f
	 +ws6YjuiJnRgRSR8U0VmJk+1FUAOOS7hYfYoF3NS6HHODBrWEspHpDGQJA2T/+Knn6
	 BhBXFBQeEO8qgT/2OEVIMQMnVSUApCWL2F2Jvr0KWidYP/eC/mDn8CqKvROrIRG/Gv
	 eJz3Eiu2XMqUA==
Date: Tue, 13 Oct 2026 03:13:49 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs
Message-ID: <20261013031329.483597-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: b8df25e2198dff611e922a6d1e796b12f58158e1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On controllers without LL Privacy, the accept list cannot match a bonded
peer identity against the peer Resolvable Private Address. Background
scans using the accept-list filter therefore hide those advertisements
from host-side address resolution and auto-connect never starts.

When a pending peer has an IRK but controller-side resolution is
unavailable, use unfiltered scanning while the host is awake. Keep
accept-list filtering during suspend, where host-side resolution cannot
run.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Submission review notes (not part of the commit message):
The downstream N8/UB500 recovers an ACL link after range loss.
No patch-off comparison or changed-RPA necessity test was supplied.
Do not equate link reconnection with automatic audio/application resume.
Privacy-capable and suspend/wake regressions remain coverage gaps.

 net/bluetooth/hci_sync.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index efbd2e538..d0fbb3e08 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2907,6 +2907,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev =
*hdev)
 =09struct bdaddr_list *b, *t;
 =09u8 num_entries =3D 0;
 =09bool pend_conn, pend_report;
+=09bool rpa_no_llp =3D false;
 =09u8 filter_policy;
 =09size_t i, n;
 =09int err;
@@ -3025,6 +3026,17 @@ static u8 hci_update_accept_list_sync(struct hci_dev=
 *hdev)
 =09=09=09kvfree(params);
 =09=09=09goto done;
 =09=09}
+
+=09=09/* A bonded peer that advertises with a Resolvable Private
+=09=09 * Address can only be matched by the controller's accept list
+=09=09 * if the controller can resolve addresses itself (LL Privacy).
+=09=09 * When it cannot, note the peer so the scan below can fall back
+=09=09 * to host-side resolution instead of accept list filtering.
+=09=09 */
+=09=09if (!ll_privacy_capable(hdev) &&
+=09=09    hci_find_irk_by_addr(hdev, &params[i].addr,
+=09=09=09=09=09 params[i].addr_type))
+=09=09=09rpa_no_llp =3D true;
 =09}
=20
 =09kvfree(params);
@@ -3047,6 +3059,11 @@ static u8 hci_update_accept_list_sync(struct hci_dev=
 *hdev)
 =09=09=09kvfree(params);
 =09=09=09goto done;
 =09=09}
+
+=09=09if (!ll_privacy_capable(hdev) &&
+=09=09    hci_find_irk_by_addr(hdev, &params[i].addr,
+=09=09=09=09=09 params[i].addr_type))
+=09=09=09rpa_no_llp =3D true;
 =09}
=20
 =09kvfree(params);
@@ -3061,6 +3078,16 @@ static u8 hci_update_accept_list_sync(struct hci_dev=
 *hdev)
 =09    hdev->interleave_scan_state !=3D INTERLEAVE_SCAN_ALLOWLIST)
 =09=09err =3D -EINVAL;
=20
+=09/* If a pending peer advertises with an RPA but the controller cannot
+=09 * resolve addresses (no LL Privacy), accept list filtering would drop
+=09 * its resolvable adverts and it could never be reconnected. Scan
+=09 * unfiltered instead so the host resolves the RPA in software and
+=09 * triggers the connection (see process_adv_report()). Skipped while
+=09 * suspended, where host-side resolution is not available.
+=09 */
+=09if (rpa_no_llp && !hdev->suspended)
+=09=09err =3D -EINVAL;
+
 done:
 =09filter_policy =3D err ? 0x00 : 0x01;
=20

base-commit: 964430c038967fd06643e866f68115664e1a1bd1

