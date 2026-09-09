Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06A554092
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957280; cv=none; b=m/g58AX++7etctNWsjwpThJaAviOxA2g0W2HjwFPQG6jkAUstHk518Jddcq94XNhjr2c7pTdTDSC4Nsw/91t8ktC17M1SIwXoCOetGyuiYjqjLkVA9en1QIWBZj0oIBtUx+VvLjUJNKBPfpO50HXK4EpssGqpax3SQnyjVPLDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957280; c=relaxed/simple;
	bh=//c8F1cx0k+bb8nyFj6lXf8mcRAemMwHlyURb9FV3bQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWx1PwFLcdP+09DuYkMI4JEPUYSz56gaBkuyh59orR8M97rj+hjW7XtfDMAPwhsTl9vz1xkhYdpkoN/VSTM+8/BkdEQJa3rVR5XXXv5C5+KhZeYM6zNy1oyDQO85pN89BqavDZ/zvHEvpLCDgGYefIxlCkYD2qZgXWLZ0gzqE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=iKBWumfg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="iKBWumfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788957275; x=1789216475;
	bh=J1O58uA+SipTQJzoHAqMs/spIqMX0Sd8gvJTBdtJ2u4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iKBWumfg1/VluBmSpmfniqn4HKS9r2arc/aoJ5BmEoP/0jvnV6GEgXkEbeXTdEJOk
	 r+uHbTjXn4Ew+xGXOUvRACMP7MFvhq1id1yVWdEVUg7likIq+nKkHqufvU93lm+IBZ
	 LRrQ1V5mjfzzFsFeADQZwsACwi8wNcll+VslkajcR8Bm/pphmED9LqJon9/RDAmzN0
	 AOfLcg/zSefqbnP+M6rpcl2yv9pMxK0gx8GRgQ9CSpi0B/MxAngsAoQ4SrTwVC9hG5
	 CXUR9xEGbTo5B+6NTbV/Ov9x/8rlztyIaoFqOBZGb7TwpxNbZhUwZNrvfZQ1uZYWA7
	 qA0cmydJZbrJA==
Date: Wed, 09 Sep 2026 12:34:32 +0000
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ravindra <ravindra@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Ferenc Lengyel <dev@lengyelf.eu>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Mahalingeshwara Chambarakatta <mahalingeshwara.chambarakatta@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Message-ID: <20260909123416.71919-2-lsa.uz@pm.me>
In-Reply-To: <20260909123416.71919-1-lsa.uz@pm.me>
References: <20260909123416.71919-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 45fb7b56740a1ee7d9aef5be86292eee2c212fea
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Vladimir V. Kondratyev <vladimirkondratyev2@gmail.com>

btintel_pcie returns -16 (EBUSY) during suspend, causing the entire
suspend operation to abort on Intel Lunar Lake hardware. The system
immediately resumes
after every suspend attempt:
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
retry count 0
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
retry count 1
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry,
retry count 2
  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend
[btintel_pcie] returns -16
  btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend
returns -16
  btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
  PM: Some devices failed to suspend, or early wake event detected

btintel_pcie_set_dxstate() falls back to checking the controller state via
btintel_pcie_in_d3/d0() when the alive interrupt is missed. However, these
helpers read boot_stage_cache, which is only updated by the interrupt
handler. As such, if the interrupt was missed, the cache is stale and the
fallback check always fails, exhausting all retries and returning -EBUSY,
causing suspend to abort.

The fix involves re-reading the hardware register before the fallback state
check, consistent with btintel_pcie_resume().

Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() /=
 _resume()")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221481
Link: https://lore.kernel.org/linux-bluetooth/20260830151550.44687-1-lsa.uz=
@pm.me/
Signed-off-by: Vladimir V. Kondratyev <vladimirkondratyev2@gmail.com>
Tested-by: Sergey Lebedev <lsa.uz@pm.me>

Signed-off-by: Sergey Lebedev <lsa.uz@pm.me>
---
 drivers/bluetooth/btintel_pcie.c | 8 +++++---
 drivers/bluetooth/btintel_pcie.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_p=
cie.c
index 7a2139a04..361c550b5 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -4191,10 +4191,12 @@ static int btintel_pcie_set_dxstate(struct btintel_=
pcie_data *data, u32 dxstate)
 =09=09=09=09=09  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
 =09=09=09=09=09  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
=20
-=09=09/* A hardware bug may cause the alive interrupt to be missed.
-=09=09 * Check if the controller reached the expected state and retry
-=09=09 * the operation only if it hasn't.
+=09=09/* A hardware bug may cause the alive interrupt to be missed. Refres=
h
+=09=09 * boot_stage_cache from hardware, since only the interrupt handler
+=09=09 * updates it. Finally retry only if the state check still fails.
 =09=09 */
+=09=09data->boot_stage_cache =3D btintel_pcie_rd_reg32(data,
+=09=09=09=09=09=09=09       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
 =09=09if (dxstate =3D=3D BTINTEL_PCIE_STATE_D0) {
 =09=09=09if (btintel_pcie_in_d0(data))
 =09=09=09=09return 0;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_p=
cie.h
index f35f80f80..016795fcb 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -51,6 +51,7 @@
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED=09(BIT(14))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON=09(BIT(16))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE=09=09(BIT(23))
+/* Reflects live D-state. Updated by hardware on every D-state transition.=
 */
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY=09(BIT(24))
=20
 #define BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM=09(BIT(4))
--=20
2.50.1 (Apple Git-155)


