Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DC399375;
	Wed, 15 Jul 2026 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127582; cv=none; b=AxMGk6R9YxikIs2nqNI4jxCtdzUXy4TneWjUdxglJYSk1RVv3C3qZutzuA1w4mChi9yqd3aNOCbOs4KgAPifDTFq0j4yxggka38KmmIEWi2yIpnX47CajN9BeOqN5Dd0bz6V4L+cO1kv8tV0fjhaeunAM6nb5MdqZNPWtJXemaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127582; c=relaxed/simple;
	bh=DDBcXtACmsjUDSxqwplHh7m77JtKEYiDtWq7oWhUZhI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PYR1L2PBjGWP6b6zy6a8t/L/4n9hfu9dHp68uYDeSedEDMJTe758qfxClqOtzKcmQ48IaTsVaN7lQtXo4vNjL/7F5LHHW2W9BedpcBJGbQbeHpGdYT0B4TND8JKvFxdYIPqWL08oM01rPkDFoA0BTxqXcZuM8g/qXSh7H3MdcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Bpo1nql5; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Bpo1nql5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784127569; x=1784386769;
	bh=+uIga3PNeWDQVXkEr3Hv/JrPUGKzLUZM5Y+pc/Hucuk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Bpo1nql5vKNlzB4sj5Wjk3GvLK/1QL6p1GCCTYfF2G5RVLgCLrW4CF5BDD0lRjiCB
	 FanzAte1S6Eb4Rm8SZUVO14rNf9+mPfMWz/onhxWWgUnsAQS25QUPDiWOGCwRk3oJ6
	 WoM/cPfMrDkucOq77FaRngKWtt0N42hEZF97r1Gct+SeHJRcmAShkzkZBGHVXlN5/U
	 r+YhnfKwFznvn+/KWnULf/rXq3vDT1aCHx3kiygevtOAeg26db1WIjuNsVAR5YcYp7
	 btnIuspm2lcfuQEm6CYMfGRV8hOwHLTI2iXYapFAWxOrUabMxfaCeVu9rWBm7LnQgn
	 4/ClMVSl7u7cA==
Date: Wed, 15 Jul 2026 14:59:24 +0000
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>
From: gg582 <gg582@proton.me>
Cc: "neal@gompa.dev" <neal@gompa.dev>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] bluetooth: hci_bcm4377: Implement Runtime PM support
Message-ID: <rX-ROplxh8z512Ho1P39IUwYIX8jXZU9cCqJwnV84ijwUmpANNB65FFXqYqhYPi4FJFRsjSHTgZ-LdGtvLZh5OdJBy08KXtOWr5z09Lw5lQ=@proton.me>
Feedback-ID: 178852888:user:proton
X-Pm-Message-ID: cbf97c9f3ad7e62fbbaa573423ce1c8f1cbfdf89
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_cqS0E6tWMa4HF5gfvY9ilrY8yna16RsGO2x4MWpA"

--b1=_cqS0E6tWMa4HF5gfvY9ilrY8yna16RsGO2x4MWpA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From dc47862023158e5a244a0a2b9025dd544e658a13 Mon Sep 17 00:00:00 2001
From: Lee Yunjin <gg582@proton.me>
Date: Fri, 3 Jul 2026 10:12:56 +0900
Subject: [PATCH] bluetooth: hci_bcm4377: Implement Runtime PM support

Signed-off-by: Lee Yunjin <gg582@proton.me>
---
 drivers/bluetooth/hci_bcm4377.c | 96 +++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm437=
7.c
index 5f79920c0306..0d5f818bde71 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -15,6 +15,7 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
=20
 #include <linux/unaligned.h>
@@ -840,6 +841,8 @@ static irqreturn_t bcm4377_irq(int irq, void *data)
 =09struct bcm4377_data *bcm4377 =3D data;
 =09u32 bootstage, rti_status;
=20
+=09pm_runtime_get(&bcm4377->pdev->dev);
+
 =09bootstage =3D ioread32(bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM43=
77_BAR2_BOOTSTAGE);
 =09rti_status =3D ioread32(bcm4377->bar2 + bcm4377->hw->bar2_offset + BCM4=
377_BAR2_RTI_STATUS);
=20
@@ -863,6 +866,9 @@ static irqreturn_t bcm4377_irq(int irq, void *data)
 =09bcm4377_poll_completion_ring(bcm4377, &bcm4377->sco_ack_ring);
 =09bcm4377_poll_completion_ring(bcm4377, &bcm4377->sco_event_ring);
=20
+=09pm_runtime_mark_last_busy(&bcm4377->pdev->dev);
+=09pm_runtime_put_autosuspend(&bcm4377->pdev->dev);
+
 =09return IRQ_HANDLED;
 }
=20
@@ -892,6 +898,8 @@ static int bcm4377_enqueue(struct bcm4377_data *bcm4377=
,
 =09if (ring->virtual)
 =09=09return -EINVAL;
=20
+=09pm_runtime_get(&bcm4377->pdev->dev);
+
 =09spin_lock_irqsave(&ring->lock, flags);
=20
 =09head =3D le16_to_cpu(bcm4377->ring_state->xfer_ring_head[ring->ring_id]=
);
@@ -974,6 +982,8 @@ static int bcm4377_enqueue(struct bcm4377_data *bcm4377=
,
 =09=09spin_unlock_irqrestore(&ring->lock, flags);
 =09}
=20
+=09pm_runtime_mark_last_busy(&bcm4377->pdev->dev);
+=09pm_runtime_put_autosuspend(&bcm4377->pdev->dev);
 =09return ret;
 }
=20
@@ -1309,6 +1319,12 @@ static int bcm4377_hci_open(struct hci_dev *hdev)
 =09struct bcm4377_data *bcm4377 =3D hci_get_drvdata(hdev);
 =09int ret;
=20
+=09ret =3D pm_runtime_get_sync(&bcm4377->pdev->dev);
+=09if (ret < 0) {
+=09=09pm_runtime_put_noidle(&bcm4377->pdev->dev);
+=09=09return ret;
+=09}
+
 =09dev_dbg(&bcm4377->pdev->dev, "creating rings\n");
=20
 =09ret =3D bcm4377_create_completion_ring(bcm4377,
@@ -1392,6 +1408,8 @@ static int bcm4377_hci_close(struct hci_dev *hdev)
 =09bcm4377_destroy_completion_ring(bcm4377, &bcm4377->hci_acl_event_ring);
 =09bcm4377_destroy_completion_ring(bcm4377, &bcm4377->hci_acl_ack_ring);
=20
+=09pm_runtime_put_sync_suspend(&bcm4377->pdev->dev);
+
 =09return 0;
 }
=20
@@ -2273,6 +2291,14 @@ static void bcm4377_hci_unregister_dev(void *data)
 =09hci_unregister_dev(data);
 }
=20
+static void bcm4377_pm_runtime_disable(void *data)
+{
+=09struct pci_dev *pdev =3D data;
+
+=09pm_runtime_dont_use_autosuspend(&pdev->dev);
+=09pm_runtime_forbid(&pdev->dev);
+}
+
 static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id =
*id)
 {
 =09struct bcm4377_data *bcm4377;
@@ -2414,8 +2440,25 @@ static int bcm4377_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
 =09ret =3D hci_register_dev(hdev);
 =09if (ret)
 =09=09return ret;
-=09return devm_add_action_or_reset(&pdev->dev, bcm4377_hci_unregister_dev,
-=09=09=09=09=09hdev);
+=09ret =3D devm_add_action_or_reset(&pdev->dev, bcm4377_hci_unregister_dev=
,
+=09=09=09=09       hdev);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D devm_add_action_or_reset(&pdev->dev, bcm4377_pm_runtime_disable=
,
+=09=09=09=09       pdev);
+=09if (ret)
+=09=09return ret;
+
+=09pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
+=09pm_runtime_use_autosuspend(&pdev->dev);
+=09/* pm_runtime_enable() already called by PCI bus core (pci/bus.c);
+=09 * calling it again would cause "Unbalanced pm_runtime_enable!"
+=09 * pm_runtime_irq_safe(&pdev->dev) is removed to avoid lock/timing issu=
es in GNOME bluetooth. */
+=09pm_runtime_mark_last_busy(&pdev->dev);
+=09pm_runtime_put_autosuspend(&pdev->dev);
+
+=09return 0;
 }
=20
 static int bcm4377_suspend(struct device *dev)
@@ -2424,9 +2467,17 @@ static int bcm4377_suspend(struct device *dev)
 =09struct bcm4377_data *bcm4377 =3D pci_get_drvdata(pdev);
 =09int ret;
=20
+=09ret =3D pm_runtime_get_sync(dev);
+=09if (ret < 0) {
+=09=09pm_runtime_put_noidle(dev);
+=09=09return ret;
+=09}
+
 =09ret =3D hci_suspend_dev(bcm4377->hdev);
-=09if (ret)
+=09if (ret) {
+=09=09pm_runtime_put_sync(dev);
 =09=09return ret;
+=09}
=20
 =09iowrite32(BCM4377_BAR0_SLEEP_CONTROL_QUIESCE,
 =09=09  bcm4377->bar0 + BCM4377_BAR0_SLEEP_CONTROL);
@@ -2438,15 +2489,50 @@ static int bcm4377_resume(struct device *dev)
 {
 =09struct pci_dev *pdev =3D to_pci_dev(dev);
 =09struct bcm4377_data *bcm4377 =3D pci_get_drvdata(pdev);
+=09int ret;
=20
 =09iowrite32(BCM4377_BAR0_SLEEP_CONTROL_UNQUIESCE,
 =09=09  bcm4377->bar0 + BCM4377_BAR0_SLEEP_CONTROL);
=20
-=09return hci_resume_dev(bcm4377->hdev);
+=09ret =3D hci_resume_dev(bcm4377->hdev);
+
+=09pm_runtime_mark_last_busy(dev);
+=09pm_runtime_put_autosuspend(dev);
+
+=09return ret;
+}
+
+static int bcm4377_runtime_suspend(struct device *dev)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(dev);
+=09struct bcm4377_data *bcm4377 =3D pci_get_drvdata(pdev);
+
+=09iowrite32(BCM4377_BAR0_SLEEP_CONTROL_QUIESCE,
+=09=09  bcm4377->bar0 + BCM4377_BAR0_SLEEP_CONTROL);
+
+=09pci_save_state(pdev);
+=09return 0;
+}
+
+static int bcm4377_runtime_resume(struct device *dev)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(dev);
+=09struct bcm4377_data *bcm4377 =3D pci_get_drvdata(pdev);
+
+=09iowrite32(BCM4377_BAR0_SLEEP_CONTROL_UNQUIESCE,
+=09=09  bcm4377->bar0 + BCM4377_BAR0_SLEEP_CONTROL);
+
+=09return 0;
 }
=20
 static DEFINE_SIMPLE_DEV_PM_OPS(bcm4377_ops, bcm4377_suspend, bcm4377_resu=
me);
=20
+/* Re-define with runtime PM once callbacks are in place */
+static const struct dev_pm_ops bcm4377_pm_ops =3D {
+=09SET_SYSTEM_SLEEP_PM_OPS(bcm4377_suspend, bcm4377_resume)
+=09SET_RUNTIME_PM_OPS(bcm4377_runtime_suspend, bcm4377_runtime_resume, NUL=
L)
+};
+
 static const struct dmi_system_id bcm4377_dmi_board_table[] =3D {
 =09{
 =09=09.matches =3D {
@@ -2547,7 +2633,7 @@ static struct pci_driver bcm4377_pci_driver =3D {
 =09.name =3D "hci_bcm4377",
 =09.id_table =3D bcm4377_devid_table,
 =09.probe =3D bcm4377_probe,
-=09.driver.pm =3D &bcm4377_ops,
+=09.driver.pm =3D &bcm4377_pm_ops,
 };
 module_pci_driver(bcm4377_pci_driver);
=20
--=20
2.55.0

--b1=_cqS0E6tWMa4HF5gfvY9ilrY8yna16RsGO2x4MWpA
Content-Type: text/x-patch; name=0001-bluetooth-hci_bcm4377-Implement-Runtime-PM-support.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-bluetooth-hci_bcm4377-Implement-Runtime-PM-support.patch

RnJvbSBkYzQ3ODYyMDIzMTU4ZTVhMjQ0YTBhMmI5MDI1ZGQ1NDRlNjU4YTEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZWUgWXVuamluIDxnZzU4MkBwcm90b24ubWU+CkRhdGU6IEZy
aSwgMyBKdWwgMjAyNiAxMDoxMjo1NiArMDkwMApTdWJqZWN0OiBbUEFUQ0hdIGJsdWV0b290aDog
aGNpX2JjbTQzNzc6IEltcGxlbWVudCBSdW50aW1lIFBNIHN1cHBvcnQKClNpZ25lZC1vZmYtYnk6
IExlZSBZdW5qaW4gPGdnNTgyQHByb3Rvbi5tZT4KLS0tCiBkcml2ZXJzL2JsdWV0b290aC9oY2lf
YmNtNDM3Ny5jIHwgOTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgOTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2JsdWV0b290aC9oY2lfYmNtNDM3Ny5jIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jj
bTQzNzcuYwppbmRleCA1Zjc5OTIwYzAzMDYuLjBkNWY4MThiZGU3MSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ibHVldG9vdGgvaGNpX2JjbTQzNzcuYworKysgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lf
YmNtNDM3Ny5jCkBAIC0xNSw2ICsxNSw3IEBACiAjaW5jbHVkZSA8bGludXgvbXNpLmg+CiAjaW5j
bHVkZSA8bGludXgvb2YuaD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KKyNpbmNsdWRlIDxsaW51
eC9wbV9ydW50aW1lLmg+CiAjaW5jbHVkZSA8bGludXgvcHJpbnRrLmg+CiAKICNpbmNsdWRlIDxs
aW51eC91bmFsaWduZWQuaD4KQEAgLTg0MCw2ICs4NDEsOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qg
YmNtNDM3N19pcnEoaW50IGlycSwgdm9pZCAqZGF0YSkKIAlzdHJ1Y3QgYmNtNDM3N19kYXRhICpi
Y200Mzc3ID0gZGF0YTsKIAl1MzIgYm9vdHN0YWdlLCBydGlfc3RhdHVzOwogCisJcG1fcnVudGlt
ZV9nZXQoJmJjbTQzNzctPnBkZXYtPmRldik7CisKIAlib290c3RhZ2UgPSBpb3JlYWQzMihiY200
Mzc3LT5iYXIyICsgYmNtNDM3Ny0+aHctPmJhcjJfb2Zmc2V0ICsgQkNNNDM3N19CQVIyX0JPT1RT
VEFHRSk7CiAJcnRpX3N0YXR1cyA9IGlvcmVhZDMyKGJjbTQzNzctPmJhcjIgKyBiY200Mzc3LT5o
dy0+YmFyMl9vZmZzZXQgKyBCQ000Mzc3X0JBUjJfUlRJX1NUQVRVUyk7CiAKQEAgLTg2Myw2ICs4
NjYsOSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYmNtNDM3N19pcnEoaW50IGlycSwgdm9pZCAqZGF0
YSkKIAliY200Mzc3X3BvbGxfY29tcGxldGlvbl9yaW5nKGJjbTQzNzcsICZiY200Mzc3LT5zY29f
YWNrX3JpbmcpOwogCWJjbTQzNzdfcG9sbF9jb21wbGV0aW9uX3JpbmcoYmNtNDM3NywgJmJjbTQz
NzctPnNjb19ldmVudF9yaW5nKTsKIAorCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koJmJjbTQz
NzctPnBkZXYtPmRldik7CisJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoJmJjbTQzNzctPnBk
ZXYtPmRldik7CisKIAlyZXR1cm4gSVJRX0hBTkRMRUQ7CiB9CiAKQEAgLTg5Miw2ICs4OTgsOCBA
QCBzdGF0aWMgaW50IGJjbTQzNzdfZW5xdWV1ZShzdHJ1Y3QgYmNtNDM3N19kYXRhICpiY200Mzc3
LAogCWlmIChyaW5nLT52aXJ0dWFsKQogCQlyZXR1cm4gLUVJTlZBTDsKIAorCXBtX3J1bnRpbWVf
Z2V0KCZiY200Mzc3LT5wZGV2LT5kZXYpOworCiAJc3Bpbl9sb2NrX2lycXNhdmUoJnJpbmctPmxv
Y2ssIGZsYWdzKTsKIAogCWhlYWQgPSBsZTE2X3RvX2NwdShiY200Mzc3LT5yaW5nX3N0YXRlLT54
ZmVyX3JpbmdfaGVhZFtyaW5nLT5yaW5nX2lkXSk7CkBAIC05NzQsNiArOTgyLDggQEAgc3RhdGlj
IGludCBiY200Mzc3X2VucXVldWUoc3RydWN0IGJjbTQzNzdfZGF0YSAqYmNtNDM3NywKIAkJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmcmluZy0+bG9jaywgZmxhZ3MpOwogCX0KIAorCXBtX3J1bnRp
bWVfbWFya19sYXN0X2J1c3koJmJjbTQzNzctPnBkZXYtPmRldik7CisJcG1fcnVudGltZV9wdXRf
YXV0b3N1c3BlbmQoJmJjbTQzNzctPnBkZXYtPmRldik7CiAJcmV0dXJuIHJldDsKIH0KIApAQCAt
MTMwOSw2ICsxMzE5LDEyIEBAIHN0YXRpYyBpbnQgYmNtNDM3N19oY2lfb3BlbihzdHJ1Y3QgaGNp
X2RldiAqaGRldikKIAlzdHJ1Y3QgYmNtNDM3N19kYXRhICpiY200Mzc3ID0gaGNpX2dldF9kcnZk
YXRhKGhkZXYpOwogCWludCByZXQ7CiAKKwlyZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKCZiY200
Mzc3LT5wZGV2LT5kZXYpOworCWlmIChyZXQgPCAwKSB7CisJCXBtX3J1bnRpbWVfcHV0X25vaWRs
ZSgmYmNtNDM3Ny0+cGRldi0+ZGV2KTsKKwkJcmV0dXJuIHJldDsKKwl9CisKIAlkZXZfZGJnKCZi
Y200Mzc3LT5wZGV2LT5kZXYsICJjcmVhdGluZyByaW5nc1xuIik7CiAKIAlyZXQgPSBiY200Mzc3
X2NyZWF0ZV9jb21wbGV0aW9uX3JpbmcoYmNtNDM3NywKQEAgLTEzOTIsNiArMTQwOCw4IEBAIHN0
YXRpYyBpbnQgYmNtNDM3N19oY2lfY2xvc2Uoc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJYmNtNDM3
N19kZXN0cm95X2NvbXBsZXRpb25fcmluZyhiY200Mzc3LCAmYmNtNDM3Ny0+aGNpX2FjbF9ldmVu
dF9yaW5nKTsKIAliY200Mzc3X2Rlc3Ryb3lfY29tcGxldGlvbl9yaW5nKGJjbTQzNzcsICZiY200
Mzc3LT5oY2lfYWNsX2Fja19yaW5nKTsKIAorCXBtX3J1bnRpbWVfcHV0X3N5bmNfc3VzcGVuZCgm
YmNtNDM3Ny0+cGRldi0+ZGV2KTsKKwogCXJldHVybiAwOwogfQogCkBAIC0yMjczLDYgKzIyOTEs
MTQgQEAgc3RhdGljIHZvaWQgYmNtNDM3N19oY2lfdW5yZWdpc3Rlcl9kZXYodm9pZCAqZGF0YSkK
IAloY2lfdW5yZWdpc3Rlcl9kZXYoZGF0YSk7CiB9CiAKK3N0YXRpYyB2b2lkIGJjbTQzNzdfcG1f
cnVudGltZV9kaXNhYmxlKHZvaWQgKmRhdGEpCit7CisJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBk
YXRhOworCisJcG1fcnVudGltZV9kb250X3VzZV9hdXRvc3VzcGVuZCgmcGRldi0+ZGV2KTsKKwlw
bV9ydW50aW1lX2ZvcmJpZCgmcGRldi0+ZGV2KTsKK30KKwogc3RhdGljIGludCBiY200Mzc3X3By
b2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQp
CiB7CiAJc3RydWN0IGJjbTQzNzdfZGF0YSAqYmNtNDM3NzsKQEAgLTI0MTQsOCArMjQ0MCwyNSBA
QCBzdGF0aWMgaW50IGJjbTQzNzdfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0
cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKIAlyZXQgPSBoY2lfcmVnaXN0ZXJfZGV2KGhkZXYpOwog
CWlmIChyZXQpCiAJCXJldHVybiByZXQ7Ci0JcmV0dXJuIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNl
dCgmcGRldi0+ZGV2LCBiY200Mzc3X2hjaV91bnJlZ2lzdGVyX2RldiwKLQkJCQkJaGRldik7CisJ
cmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCZwZGV2LT5kZXYsIGJjbTQzNzdfaGNpX3Vu
cmVnaXN0ZXJfZGV2LAorCQkJCSAgICAgICBoZGV2KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0
OworCisJcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCZwZGV2LT5kZXYsIGJjbTQzNzdf
cG1fcnVudGltZV9kaXNhYmxlLAorCQkJCSAgICAgICBwZGV2KTsKKwlpZiAocmV0KQorCQlyZXR1
cm4gcmV0OworCisJcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoJnBkZXYtPmRldiwg
MjAwMCk7CisJcG1fcnVudGltZV91c2VfYXV0b3N1c3BlbmQoJnBkZXYtPmRldik7CisJLyogcG1f
cnVudGltZV9lbmFibGUoKSBhbHJlYWR5IGNhbGxlZCBieSBQQ0kgYnVzIGNvcmUgKHBjaS9idXMu
Yyk7CisJICogY2FsbGluZyBpdCBhZ2FpbiB3b3VsZCBjYXVzZSAiVW5iYWxhbmNlZCBwbV9ydW50
aW1lX2VuYWJsZSEiCisJICogcG1fcnVudGltZV9pcnFfc2FmZSgmcGRldi0+ZGV2KSBpcyByZW1v
dmVkIHRvIGF2b2lkIGxvY2svdGltaW5nIGlzc3VlcyBpbiBHTk9NRSBibHVldG9vdGguICovCisJ
cG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeSgmcGRldi0+ZGV2KTsKKwlwbV9ydW50aW1lX3B1dF9h
dXRvc3VzcGVuZCgmcGRldi0+ZGV2KTsKKworCXJldHVybiAwOwogfQogCiBzdGF0aWMgaW50IGJj
bTQzNzdfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCkBAIC0yNDI0LDkgKzI0NjcsMTcgQEAg
c3RhdGljIGludCBiY200Mzc3X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQogCXN0cnVjdCBi
Y200Mzc3X2RhdGEgKmJjbTQzNzcgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7CiAJaW50IHJldDsK
IAorCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsKKwlpZiAocmV0IDwgMCkgeworCQlw
bV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsKKwkJcmV0dXJuIHJldDsKKwl9CisKIAlyZXQgPSBo
Y2lfc3VzcGVuZF9kZXYoYmNtNDM3Ny0+aGRldik7Ci0JaWYgKHJldCkKKwlpZiAocmV0KSB7CisJ
CXBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2KTsKIAkJcmV0dXJuIHJldDsKKwl9CiAKIAlpb3dyaXRl
MzIoQkNNNDM3N19CQVIwX1NMRUVQX0NPTlRST0xfUVVJRVNDRSwKIAkJICBiY200Mzc3LT5iYXIw
ICsgQkNNNDM3N19CQVIwX1NMRUVQX0NPTlRST0wpOwpAQCAtMjQzOCwxNSArMjQ4OSw1MCBAQCBz
dGF0aWMgaW50IGJjbTQzNzdfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3Qg
cGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKIAlzdHJ1Y3QgYmNtNDM3N19kYXRhICpi
Y200Mzc3ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOworCWludCByZXQ7CiAKIAlpb3dyaXRlMzIo
QkNNNDM3N19CQVIwX1NMRUVQX0NPTlRST0xfVU5RVUlFU0NFLAogCQkgIGJjbTQzNzctPmJhcjAg
KyBCQ000Mzc3X0JBUjBfU0xFRVBfQ09OVFJPTCk7CiAKLQlyZXR1cm4gaGNpX3Jlc3VtZV9kZXYo
YmNtNDM3Ny0+aGRldik7CisJcmV0ID0gaGNpX3Jlc3VtZV9kZXYoYmNtNDM3Ny0+aGRldik7CisK
KwlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRldik7CisJcG1fcnVudGltZV9wdXRfYXV0b3N1
c3BlbmQoZGV2KTsKKworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgYmNtNDM3N19ydW50
aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQoreworCXN0cnVjdCBwY2lfZGV2ICpwZGV2
ID0gdG9fcGNpX2RldihkZXYpOworCXN0cnVjdCBiY200Mzc3X2RhdGEgKmJjbTQzNzcgPSBwY2lf
Z2V0X2RydmRhdGEocGRldik7CisKKwlpb3dyaXRlMzIoQkNNNDM3N19CQVIwX1NMRUVQX0NPTlRS
T0xfUVVJRVNDRSwKKwkJICBiY200Mzc3LT5iYXIwICsgQkNNNDM3N19CQVIwX1NMRUVQX0NPTlRS
T0wpOworCisJcGNpX3NhdmVfc3RhdGUocGRldik7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBp
bnQgYmNtNDM3N19ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCit7CisJc3RydWN0
IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldik7CisJc3RydWN0IGJjbTQzNzdfZGF0YSAq
YmNtNDM3NyA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKKworCWlvd3JpdGUzMihCQ000Mzc3X0JB
UjBfU0xFRVBfQ09OVFJPTF9VTlFVSUVTQ0UsCisJCSAgYmNtNDM3Ny0+YmFyMCArIEJDTTQzNzdf
QkFSMF9TTEVFUF9DT05UUk9MKTsKKworCXJldHVybiAwOwogfQogCiBzdGF0aWMgREVGSU5FX1NJ
TVBMRV9ERVZfUE1fT1BTKGJjbTQzNzdfb3BzLCBiY200Mzc3X3N1c3BlbmQsIGJjbTQzNzdfcmVz
dW1lKTsKIAorLyogUmUtZGVmaW5lIHdpdGggcnVudGltZSBQTSBvbmNlIGNhbGxiYWNrcyBhcmUg
aW4gcGxhY2UgKi8KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBiY200Mzc3X3BtX29w
cyA9IHsKKwlTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhiY200Mzc3X3N1c3BlbmQsIGJjbTQzNzdf
cmVzdW1lKQorCVNFVF9SVU5USU1FX1BNX09QUyhiY200Mzc3X3J1bnRpbWVfc3VzcGVuZCwgYmNt
NDM3N19ydW50aW1lX3Jlc3VtZSwgTlVMTCkKK307CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1p
X3N5c3RlbV9pZCBiY200Mzc3X2RtaV9ib2FyZF90YWJsZVtdID0gewogCXsKIAkJLm1hdGNoZXMg
PSB7CkBAIC0yNTQ3LDcgKzI2MzMsNyBAQCBzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIgYmNtNDM3
N19wY2lfZHJpdmVyID0gewogCS5uYW1lID0gImhjaV9iY200Mzc3IiwKIAkuaWRfdGFibGUgPSBi
Y200Mzc3X2RldmlkX3RhYmxlLAogCS5wcm9iZSA9IGJjbTQzNzdfcHJvYmUsCi0JLmRyaXZlci5w
bSA9ICZiY200Mzc3X29wcywKKwkuZHJpdmVyLnBtID0gJmJjbTQzNzdfcG1fb3BzLAogfTsKIG1v
ZHVsZV9wY2lfZHJpdmVyKGJjbTQzNzdfcGNpX2RyaXZlcik7CiAKLS0gCjIuNTUuMAoK

--b1=_cqS0E6tWMa4HF5gfvY9ilrY8yna16RsGO2x4MWpA--

