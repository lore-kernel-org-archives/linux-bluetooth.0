Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF3A957;
	Fri, 16 Aug 2024 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791032; cv=none; b=FIPNZbYUUYxj5tC8ackMNQxjedd7KTRqp272g0Vzt2dS8YZ+QiKw+sxT3JNHVX1hpQ7OY9lDvTXmkR43/3R8fH8G3KOwM9D02M62oGdMAJHVomXqtmm/663F4lOuTVij250fq+oj5RkKdOENar4Be10+6VP884UiU3oQi3fgj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791032; c=relaxed/simple;
	bh=IaCxeUGRxOzR+2EH9a4OSRud8kn6GhunpGvBvmz1HG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCqlTKhuRlkOEEfeD3/wy+4n+4uiAk1PyeM64q5iA967Z92aMFqStjDghVzd6JONIWV9EPWAjv7rUZoQGGXvMQO3UMkrEbRGpWkAtRWRw0Q6musvHJQmgv5Ll3kGbI8lvkEBMRS+zYdaMcORPQJC1IdZ7rQSWwIasNSbKTsnEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45337200D6B;
	Fri, 16 Aug 2024 08:50:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D78A5202C97;
	Fri, 16 Aug 2024 08:50:11 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7AA16181D0FD;
	Fri, 16 Aug 2024 14:50:10 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Fix random crash seen while removing driver
Date: Fri, 16 Aug 2024 12:17:51 +0530
Message-Id: <20240816064751.284786-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This fixes the random kernel crash seen while removing the driver, when
running the load/unload test over multiple iterations.
The ps_wakeup() call in btnxpuart_close() schedules the psdata->work(),
which gets scheduled after module is removed, causing a kernel crash.

The new ps_cleanup() deasserts UART break immediately while closing
serdev device, cancels any scheduled ps_work and destroys the ps_lock
mutex.

[   85.884604] Unable to handle kernel paging request at virtual address ffffd4a61638f258
[   85.884624] Mem abort info:
[   85.884625]   ESR = 0x0000000086000007
[   85.884628]   EC = 0x21: IABT (current EL), IL = 32 bits
[   85.884633]   SET = 0, FnV = 0
[   85.884636]   EA = 0, S1PTW = 0
[   85.884638]   FSC = 0x07: level 3 translation fault
[   85.884642] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041dd0000
[   85.884646] [ffffd4a61638f258] pgd=1000000095fff003, p4d=1000000095fff003, pud=100000004823d003, pmd=100000004823e003, pte=0000000000000000
[   85.884662] Internal error: Oops: 0000000086000007 [#1] PREEMPT SMP
[   85.890932] Modules linked in: algif_hash algif_skcipher af_alg overlay fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine authenc libdes crct10dif_ce polyval_ce polyval_generic snd_soc_imx_spdif snd_soc_imx_card snd_soc_ak5558 snd_soc_ak4458 caam secvio error snd_soc_fsl_spdif snd_soc_fsl_micfil snd_soc_fsl_sai snd_soc_fsl_utils gpio_ir_recv rc_core fuse [last unloaded: btnxpuart(O)]
[   85.927297] CPU: 1 PID: 67 Comm: kworker/1:3 Tainted: G           O       6.1.36+g937b1be4345a #1
[   85.936176] Hardware name: FSL i.MX8MM EVK board (DT)
[   85.936182] Workqueue: events 0xffffd4a61638f380
[   85.936198] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   85.952817] pc : 0xffffd4a61638f258
[   85.952823] lr : 0xffffd4a61638f258
[   85.952827] sp : ffff8000084fbd70
[   85.952829] x29: ffff8000084fbd70 x28: 0000000000000000 x27: 0000000000000000
[   85.963112] x26: ffffd4a69133f000 x25: ffff4bf1c8540990 x24: ffff4bf215b87305
[   85.963119] x23: ffff4bf215b87300 x22: ffff4bf1c85409d0 x21: ffff4bf1c8540970
[   85.977382] x20: 0000000000000000 x19: ffff4bf1c8540880 x18: 0000000000000000
[   85.977391] x17: 0000000000000000 x16: 0000000000000133 x15: 0000ffffe2217090
[   85.977399] x14: 0000000000000001 x13: 0000000000000133 x12: 0000000000000139
[   85.977407] x11: 0000000000000001 x10: 0000000000000a60 x9 : ffff8000084fbc50
[   85.977417] x8 : ffff4bf215b7d000 x7 : ffff4bf215b83b40 x6 : 00000000000003e8
[   85.977424] x5 : 00000000410fd030 x4 : 0000000000000000 x3 : 0000000000000000
[   85.977432] x2 : 0000000000000000 x1 : ffff4bf1c4265880 x0 : 0000000000000000
[   85.977443] Call trace:
[   85.977446]  0xffffd4a61638f258
[   85.977451]  0xffffd4a61638f3e8
[   85.977455]  process_one_work+0x1d4/0x330
[   85.977464]  worker_thread+0x6c/0x430
[   85.977471]  kthread+0x108/0x10c
[   85.977476]  ret_from_fork+0x10/0x20
[   85.977488] Code: bad PC value
[   85.977491] ---[ end trace 0000000000000000 ]---

Message from syslogd@imx8mmevk-NH-DUT at Fri Jul 26 05:57:37 2024 ...
kernel: Code: bad PC value

Message from syslogd@imx8mmevk-NH-DUT at Fri Jul 26 05:57:37 2024 ...
kernel: Internal error: Oops: 0000000086000007 [#1] PREEMPT SMP

Fixes: 86d55f124b52 ("Bluetooth: btnxpuart: Deasset UART break before closing serdev device")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index f75b24bd3045..4bac4a81249c 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -449,6 +449,23 @@ static bool ps_wakeup(struct btnxpuart_dev *nxpdev)
 	return false;
 }
 
+static void ps_cleanup(struct btnxpuart_dev *nxpdev)
+{
+	struct ps_data *psdata = &nxpdev->psdata;
+	u8 ps_state;
+
+	mutex_lock(&psdata->ps_lock);
+	ps_state = psdata->ps_state;
+	mutex_unlock(&psdata->ps_lock);
+
+	if (ps_state != PS_STATE_AWAKE)
+		ps_control(psdata->hdev, PS_STATE_AWAKE);
+
+	ps_cancel_timer(nxpdev);
+	cancel_work_sync(&psdata->work);
+	mutex_destroy(&psdata->ps_lock);
+}
+
 static int send_ps_cmd(struct hci_dev *hdev, void *data)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -1363,7 +1380,6 @@ static int btnxpuart_close(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 
-	ps_wakeup(nxpdev);
 	serdev_device_close(nxpdev->serdev);
 	skb_queue_purge(&nxpdev->txq);
 	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
@@ -1516,8 +1532,8 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 			nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
 			nxp_set_baudrate_cmd(hdev, NULL);
 		}
-		ps_cancel_timer(nxpdev);
 	}
+	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 }
-- 
2.34.1

