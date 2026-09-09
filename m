Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BA558216
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957292; cv=none; b=Po6Qwi2rNK1Dexjy6GtbAP2a4nZ2gXZKvzED8xrMEneFlDuPUIrif0XerC9Xr5FcUpfplbyMI1QgGvjOY5J11DMwt3rtPIeq9TMviR4y/aEOL7hstu4RZeY/2/9uS/iM2ZpjOLQJmFBMzOpZsHfx0k1we9o1LbZaj9tSbVtlIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957292; c=relaxed/simple;
	bh=HWglzUhp1hqB53Fe6berq28CaqEGFMOieXgG6YFOjIU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jn8TWpjlNJgR4cmIZDYuV5K2sbUEUZAJlllX5xP6M/ARS2DWBgBJaNfDKr+H975XRcqVI71i2/FKSYvXxssEsnZoBs5QZNXMFEI+tQevGSfUJMBL7rlis3XafkxH42UkLd1YOQaZz/fiipXOY8FN/k2DbULNykrpG49nF2Q9ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=R/u44cMI; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="R/u44cMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788957281; x=1789216481;
	bh=+D2le/KqWrhPdU1IuLBg0EWsxIbaA4h514MeEcI5EVU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R/u44cMI15ax1c4ZhSxtUCHnukvo6B3Y4ZilaMNJ3VeZRpqsqDJkHTqUPEL1S2BfL
	 nv5JNDvEc7U4e+blPEj5QUoT+49QzbXt4a5AzcRAyMuWQFunjHhUEZeLfv4WDJtDES
	 cY9gCsG8RqPnH17zFkiqmIqkIJ33ihGnotYbcdwD81UuDlH55G2I741Tfz/hWC2QRB
	 2UZDkdPzdrVW+d+ozmipEkOK2E0fjpjPtngAk0nlA9PDlV1mk8TYHQklxSGYWtqszZ
	 /5anZdkGT8+Ed30QKiLA5bli1Ejsa3jTIeBk7OzCuCg1gFKRHv7z91mZhCJBOZbzUV
	 0VO+3GU++k7MA==
Date: Wed, 09 Sep 2026 12:34:38 +0000
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ravindra <ravindra@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Ferenc Lengyel <dev@lengyelf.eu>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Mahalingeshwara Chambarakatta <mahalingeshwara.chambarakatta@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260909123416.71919-3-lsa.uz@pm.me>
In-Reply-To: <20260909123416.71919-1-lsa.uz@pm.me>
References: <20260909123416.71919-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 011a6f2f9df594d6d4479e794f4155c996b35717
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Ravindra <ravindra@intel.com>

Use pm_suspend_target_state to differentiate S0ix from S3/S4. Set the
controller to D3_HOT for S0ix (PM_SUSPEND_TO_IDLE) and D3_COLD for
S3/S4, freeze and hibernate to prevent post-resume instability.

Register .freeze, .thaw, .poweroff and .restore callbacks for proper
hibernation support. The freeze and poweroff (hibernate) paths set
D3_COLD via btintel_pcie_suspend_late. The thaw path resumes with a
normal D0 transition, while .restore forces FLR-based firmware recovery
after S4 since power is lost. S3 (PM_SUSPEND_MEM) resume also triggers
FLR. S0ix resumes via a normal D0 transition.

Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() /=
 _resume()")
Assisted-by: GitHub-Copilot:GPT5
Signed-off-by: Ravindra <ravindra@intel.com>
Assisted-by: Claude:claude-opus-5
Tested-by: Ferenc Lengyel <dev@lengyelf.eu>
Signed-off-by: Sergey Lebedev <lsa.uz@pm.me>
---
 drivers/bluetooth/btintel_pcie.c | 64 ++++++++++++++++++++++----------
 drivers/bluetooth/btintel_pcie.h |  2 -
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_p=
cie.c
index 361c550b5..e37e710b9 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
+#include <linux/suspend.h>
=20
 #include <linux/unaligned.h>
 #include <linux/devcoredump.h>
@@ -4168,11 +4169,16 @@ static void btintel_pcie_coredump(struct device *de=
v)
=20
 static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dx=
state)
 {
-=09int retry =3D 0, status;
+=09int retry =3D 0;
+=09long status;
 =09u32 dx_intr_timeout_ms =3D 200;
=20
+=09/* Not reset per retry: dxstate is unchanged, so a late interrupt from
+=09 * an earlier attempt still confirms the target state.
+=09 */
+=09data->gp0_received =3D false;
+
 =09do {
-=09=09data->gp0_received =3D false;
=20
 =09=09btintel_pcie_wr_sleep_cntrl(data, dxstate);
=20
@@ -4220,18 +4226,23 @@ static int btintel_pcie_suspend_late(struct device =
*dev, pm_message_t mesg)
=20
 =09data =3D pci_get_drvdata(pdev);
=20
-=09dxstate =3D (mesg.event =3D=3D PM_EVENT_SUSPEND ?
-=09=09   BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD);
-
-=09data->pm_sx_event =3D mesg.event;
+=09/* S0ix (s2idle) uses D3_HOT; S3, freeze and hibernate use D3_COLD. */
+=09if (mesg.event =3D=3D PM_EVENT_SUSPEND &&
+=09    pm_suspend_target_state =3D=3D PM_SUSPEND_TO_IDLE)
+=09=09dxstate =3D BTINTEL_PCIE_STATE_D3_HOT;
+=09else
+=09=09dxstate =3D BTINTEL_PCIE_STATE_D3_COLD;
=20
 =09start =3D ktime_get();
=20
 =09/* Refer: 6.4.11.7 -> Platform power management */
 =09err =3D btintel_pcie_set_dxstate(data, dxstate);
=20
-=09if (err)
+=09if (err) {
+=09=09bt_dev_err(data->hdev, "Failed to set dxstate:%u (%d)",
+=09=09=09   dxstate, err);
 =09=09return err;
+=09}
=20
 =09bt_dev_dbg(data->hdev,
 =09=09   "device entered into d3 state from d0 in %lld us",
@@ -4254,7 +4265,7 @@ static int btintel_pcie_freeze(struct device *dev)
 =09return btintel_pcie_suspend_late(dev, PMSG_FREEZE);
 }
=20
-static int btintel_pcie_resume(struct device *dev)
+static int btintel_pcie_resume_event(struct device *dev, pm_message_t mesg=
)
 {
 =09struct pci_dev *pdev =3D to_pci_dev(dev);
 =09struct btintel_pcie_data *data;
@@ -4262,19 +4273,15 @@ static int btintel_pcie_resume(struct device *dev)
 =09int err;
=20
 =09data =3D pci_get_drvdata(pdev);
-=09data->gp0_received =3D false;
=20
 =09start =3D ktime_get();
=20
-=09/* When the system enters S4 (hibernate) mode, bluetooth device loses
-=09 * power, which results in the erasure of its loaded firmware.
-=09 * Consequently, function level reset (flr) is required on system
-=09 * resume to bring the controller back into an operational state by
-=09 * initiating a new firmware download.
+=09/* S3 and S4 may cut power, erasing the firmware. Force FLR to recover
+=09 * instead of a normal D0 transition.
 =09 */
-
-=09if (data->pm_sx_event =3D=3D PM_EVENT_FREEZE ||
-=09    data->pm_sx_event =3D=3D PM_EVENT_HIBERNATE) {
+=09if (mesg.event =3D=3D PM_EVENT_RESTORE ||
+=09    (mesg.event =3D=3D PM_EVENT_RESUME &&
+=09     pm_suspend_target_state =3D=3D PM_SUSPEND_MEM)) {
 =09=09set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
 =09=09btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
 =09=09return 0;
@@ -4283,7 +4290,9 @@ static int btintel_pcie_resume(struct device *dev)
 =09/* Refer: 6.4.11.7 -> Platform power management */
 =09err =3D btintel_pcie_set_dxstate(data, BTINTEL_PCIE_STATE_D0);
=20
-=09if (err =3D=3D 0) {
+=09if (err) {
+=09=09bt_dev_err(data->hdev, "Failed to set D0 state (%d)", err);
+=09} else {
 =09=09bt_dev_dbg(data->hdev,
 =09=09=09   "device entered into d0 state from d3 in %lld us",
 =09=09=09   ktime_to_us(ktime_get() - start));
@@ -4308,13 +4317,28 @@ static int btintel_pcie_resume(struct device *dev)
 =09return err;
 }
=20
+static int btintel_pcie_resume(struct device *dev)
+{
+=09return btintel_pcie_resume_event(dev, PMSG_RESUME);
+}
+
+static int btintel_pcie_restore(struct device *dev)
+{
+=09return btintel_pcie_resume_event(dev, PMSG_RESTORE);
+}
+
+static int btintel_pcie_thaw(struct device *dev)
+{
+=09return btintel_pcie_resume_event(dev, PMSG_THAW);
+}
+
 static const struct dev_pm_ops btintel_pcie_pm_ops =3D {
 =09.suspend =3D btintel_pcie_suspend,
 =09.resume =3D btintel_pcie_resume,
 =09.freeze =3D btintel_pcie_freeze,
-=09.thaw =3D btintel_pcie_resume,
+=09.thaw =3D btintel_pcie_thaw,
 =09.poweroff =3D btintel_pcie_hibernate,
-=09.restore =3D btintel_pcie_resume,
+=09.restore =3D btintel_pcie_restore,
 };
=20
 static struct pci_driver btintel_pcie_driver =3D {
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_p=
cie.h
index 016795fcb..3030b4e8b 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -713,7 +713,6 @@ struct btintel_pcie_ini_dump_info {
  * @txq: TX Queue struct
  * @rxq: RX Queue struct
  * @alive_intr_ctxt: Alive interrupt context
- * @pm_sx_event: PM event on which system got suspended
  */
 struct btintel_pcie_data {
 =09struct pci_dev=09*pdev;
@@ -773,7 +772,6 @@ struct btintel_pcie_data {
 =09struct btintel_pcie_dbgc=09dbgc;
 =09struct btintel_pcie_mdbgc=09mdbgc;
 =09struct btintel_pcie_dump_header dmp_hdr;
-=09u8=09pm_sx_event;
 =09u32=09debug_evt_addr;
 =09u32=09debug_evt_size;
 =09dma_addr_t=09debug_table_addr;
--=20
2.50.1 (Apple Git-155)


