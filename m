Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE333998
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954999; cv=none; b=Gf0C+BW8h7pTYx53nd/1xezU0CSvQPUIeVrq6R9fofmnepGtZWfJHaNKrO3MVKJXM9JZlh/BLSo5Uv4CLRvBUCZf3YKvID4m18SL3sT+3bfevDj5n2kmnHHvmxZjzp/nURHijqYeGZO+zj+ke9mjxyn/uxsqCBeUL+JgeQs8VEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954999; c=relaxed/simple;
	bh=n3XgsC2XHNNQgSpWFPtJj++/Oex3opAT+FOm6qePyps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4AI7BLsjX1sy+xl3B6HgngTY/WdQI7s1AR9JIXTKVE/l20KO+ZNBGKwuwlIxXsXC8iKD54/GiHlxEyN+DNG8KxuG4a9dvLZdk+YjxdaXwZgGsizesDJA8IUAJ8ky8yYa4x+zTT7d83XWNSbS4BUW3VdpQOzPIIIMumjZaVtHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gD6t0glY; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gD6t0glY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791954985; x=1792214185;
	bh=Ip7MS1InEgmWWN/AP6NfNP9i8MBdg2GqaAX9Ycdx6TM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gD6t0glY3ICgdtcLDDDtOrCWTbG4jfEWTTp2VT9sChaQFau7FHWbP5a7qgqd8Op7U
	 JleyF1a1Hbwe/hm+R0paJ2NWDca7H95IFrhzIVwTdxrCwMThmWOI5ogHgISPSXxhgm
	 31OfSkNpmKW+L8MpCpaxfJETb+i0e5aGiB1ZL+T7E7iZmZUzn1NPBVj62HMwDriFCB
	 GCfNTjxkOBSvvqivmUGM1VO1St/DrF4l8r1XowQC/stYsaG0Iq09O8f2aW6paOKxdB
	 2Wc3gCzZHYdWDF9xTGVy5c/OjGvTcWzSLo6TWgnfIukRjX+G70I8oW9qqdbFdqhVbY
	 D870Cyfn56wyw==
Date: Wed, 14 Oct 2026 05:16:20 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs
Message-ID: <20261014051600.408746-1-cochcoder@proton.me>
In-Reply-To: <20261013031329.483597-1-cochcoder@proton.me>
References: <20261013031329.483597-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: b13949a3691cca1257508faf3f82b01083f334c9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Restore unfiltered scanning for pending IRK peers when the controller
cannot resolve private addresses. Keep accept-list filtering while
suspended and when forced by periodic advertising synchronization.

Fixes: e209e5ccc5ac ("Bluetooth: MGMT: Mark LL Privacy as stable")
Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes since v1:
- Restore the host-resolution fallback in hci_le_add_accept_list_sync()
  instead of adding per-loop and final-filter bookkeeping.
- Preserve filtering during suspend and forced periodic advertising sync.
- Identify the removal of the old fallback in e209e5ccc5ac.
- Add native mgmt-tester reproduction in the companion BlueZ
  patch "mgmt-tester: Add host-resolved RPA scan checks".

Previous submission:
https://lore.kernel.org/linux-bluetooth/20261013031329.483597-1-cochcoder@p=
roton.me/

Testing on bluetooth-next 609a23989d63, with KASAN and lockdep enabled:
                                upstream   revised
  Auto-connect with IRK           FAIL       PASS
  Background report with IRK      FAIL       PASS
  Auto-connect without IRK        PASS       PASS
  Background report without IRK   PASS       PASS

The cases check scan programming through emulated HCI, as requested by
Luiz. They do not test actual address rotation or radio reconnection.
The complete mgmt suite was also run: upstream 503/512 pass, four fail,
five not run; revision 506/512 pass, one fail, five not run. Both runs
time out in "Set Static Address - Success 2". The upstream run also
fails the two new IRK cases and "LL Privacy - Set Flags 3 (2 Devices to
RL)", already listed as flaky; its pass is not attributed to this fix.
No KASAN/lockdep diagnostic was captured in these runs.

The revised implementation has not been newly tested on physical
hardware. Changed-RPA reconnect, privacy-capable-controller and
suspend/wake regressions remain unverified. No automatic audio-resume
claim is made.

 net/bluetooth/hci_sync.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index efbd2e538..03f706c1f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2618,7 +2618,7 @@ static int hci_le_set_privacy_mode_sync(struct hci_de=
v *hdev,
  */
 static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 =09=09=09=09       struct conn_params *params,
-=09=09=09=09       u8 *num_entries)
+=09=09=09=09       u8 *num_entries, bool force_filter)
 {
 =09struct hci_cp_le_add_to_accept_list cp;
 =09int err;
@@ -2631,6 +2631,11 @@ static int hci_le_add_accept_list_sync(struct hci_de=
v *hdev,
 =09=09return 0;
 =09}
=20
+=09/* Host-resolved peers need unfiltered scanning while awake. */
+=09if (!force_filter && !hdev->suspended && !ll_privacy_capable(hdev) &&
+=09    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type))
+=09=09return -EINVAL;
+
 =09/* Select filter policy to accept all advertising */
 =09if (*num_entries >=3D hdev->le_accept_list_size)
 =09=09return -ENOSPC;
@@ -2956,7 +2961,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev =
*hdev)
=20
 =09=09=09num_entries =3D 1;
 =09=09=09err =3D hci_le_add_accept_list_sync(hdev, &pa,
-=09=09=09=09=09=09=09  &num_entries);
+=09=09=09=09=09=09=09  &num_entries, true);
 =09=09=09goto done;
 =09=09} else {
 =09=09=09rcu_read_unlock();
@@ -3020,7 +3025,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev =
*hdev)
=20
 =09for (i =3D 0; i < n; ++i) {
 =09=09err =3D hci_le_add_accept_list_sync(hdev, &params[i],
-=09=09=09=09=09=09  &num_entries);
+=09=09=09=09=09=09=09=09&num_entries, false);
 =09=09if (err) {
 =09=09=09kvfree(params);
 =09=09=09goto done;
@@ -3042,7 +3047,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev =
*hdev)
=20
 =09for (i =3D 0; i < n; ++i) {
 =09=09err =3D hci_le_add_accept_list_sync(hdev, &params[i],
-=09=09=09=09=09=09  &num_entries);
+=09=09=09=09=09=09=09=09&num_entries, false);
 =09=09if (err) {
 =09=09=09kvfree(params);
 =09=09=09goto done;

base-commit: 609a23989d637e2f90522a37c62e65c8c9b8b0ff

