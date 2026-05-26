Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7223FBB44;
	Tue, 26 May 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803482; cv=none; b=vDhz0QJ+m98xtYkglDhm0ICygPOavnK+ypY0hnypEr+qgPmCECrirbA18RiWJQFy1Io7hnVVVBFnIo0jFrYdqQQJXEHaAZ6oBec3DGX2uOUA94coEfI1tFaG/PBEiIMZa+6b7FxJWuCozX8+Fe036J5yJ+EPLO7GOlvoCRk2kvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803482; c=relaxed/simple;
	bh=T5cP5aWqHViHWcK7TFKx8t8Fb7G33UJku7kGcP3/o0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ma3cas6z0DyZmV+gf3Gmx8lW53tFjnBlSznDiQm+B5VhCLn0d8U7mgXEfg4q7JxT38YHCujCfLJQRZKXX6N/mgS6lYnk2gzQ4paqtr+5hXStqnuMSiXmQPoo5mHymbAhjC6+7xjbPdI23+rtwMeR20NgiZlZdkWzAahf5/WO1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JnkYsEX1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JnkYsEX1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/N0WmDQkvEjoZtguvmPAossBWif/jgp5Q6q5tkvrs9U=; b=JnkYsEX1z9B8XC83raQXatwoSh
	y4Llh3EMAiI7jBoY0mVYKjKMlTEOvLkV6Q65FuFBB4O6uibyt9C47XHAIbU/a7wvcqkSj8oPohsjm
	Ww8k4LcIIKG9CXrjNCccDLLCcPA0lv+yXSGA9PwrwCRRu1PU/hgJQB9z/V5H993uEVzj1Tn7PiN5/
	bNe86dzKFvxarm4GnDwJ5dN15oFilblzkD7VKMxBOkdC3G6XcOfudtCtTzzQgTl8a9yRha2vJePhn
	on0OgVFy6HOdv7hg/kuHpjArqWDbM1+zENFwmIohBrWcsDnAjg4s4j2SIXtf7PdwvAExHz7D9Q0P7
	IDkC5SXw==;
Received: from 177-136-90-227.vmaxnet.com.br ([177.136.90.227] helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wRsBh-008SdX-Be; Tue, 26 May 2026 15:51:17 +0200
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Tue, 26 May 2026 10:50:58 -0300
Subject: [PATCH v2 2/3] Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE
 during device close
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-hci_send-v2-2-596977a9a814@igalia.com>
References: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
In-Reply-To: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Gustavo Padovan <padovan@profusion.mobi>, Schspa Shi <schspa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Heitor Alves de Siqueira <halves@igalia.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
X-Mailer: b4 0.15.2

Since hci_dev_close_sync() can now be called during the reset path, we
should also set HCI_CMD_DRAIN_WORKQUEUE. This avoids queuing timeouts
while the hdev workqueue is being drained.

Fixes: 877afadad2dc ("Bluetooth: When HCI work queue is drained, only queue chained work")
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 net/bluetooth/hci_sync.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512..84d8f457c799 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5298,6 +5298,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "");
 
+	/* Set HCI_DRAIN_WORKQUEUE flag to prevent queuing work during
+	 * reset/close. See hci_cmd_work() and handle_cmd_cnt_and_timer().
+	 */
+	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
+	synchronize_rcu();
+
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		disable_delayed_work(&hdev->power_off);
 		disable_delayed_work(&hdev->ncmd_timer);
@@ -5321,6 +5327,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		cancel_delayed_work_sync(&hdev->cmd_timer);
+		hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 		return err;
 	}
 
@@ -5420,6 +5427,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	/* Clear flags */
 	hdev->flags &= BIT(HCI_RAW);
 	hci_dev_clear_volatile_flags(hdev);
+	hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));

-- 
2.54.0

