Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D9C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 23:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE872080C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 23:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXY1/LFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE872080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbeKTJa3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:30:29 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41473 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeKTJa2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 04:30:28 -0500
Received: by mail-qk1-f202.google.com with SMTP id n68so71498227qkn.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/jmvSk73ZJvN/rJikoGCnBxiMJ8mGKQz9fKupKHZVnc=;
        b=qXY1/LFiLarQRhLrkWROxeQeHmYfzgfPgdLh4bHm5Scg9+m1STMxr9SnF6o28Nqe/A
         /B9/Um33GOCytCDB/1bgNYsyXpINQq8NykqhWbCeo29WJKN3kgMGs5U4ejeZPqtrrurw
         wxv/OQsjYMtY9phIeW3T2o+MJOXSYGQcRROkyofom9Nvri7gguq2z0V2r6MvuhcJ9mgi
         +vir91iYwnQH6SO/rSFbN454vx2qQEALJa3Eji5528kEp7k6Ne2LZmvFuM7EgTZD1f+5
         9SSEqja1Oep0Et8s93A4r2EIA1slufqUtEddwugxAGN862OrY3HPrW4NqITlWV5EN6J/
         TA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/jmvSk73ZJvN/rJikoGCnBxiMJ8mGKQz9fKupKHZVnc=;
        b=MnEsho23j7Wg3v9YvtFvLSbQbL0bLn6xveN4DxW5D/Madd6NC9zZyV38ja5umReJZc
         oJZ0xGbzH1AfzbIiCW0zHfgQah0dXwsDODFK9EnnX9vSqn4Fthq5l0u9shdjksQy+d4K
         JI8jRdS8lHmO7inONCE1GC14HGsKm0lbH3Ao+iznc+ZCeM4g3KisMGo/iUQrInPT+CEY
         3t5/wAojGx6vCq7z7bzAPA/DyyE4uGnCF204DP4vj0+vga3iHC7KfTVcNBNOZfe7pe8Y
         XPaUu2fPxblqhp9xcHEZv5s365X94cuhtk0pEI1h8PHnHztV1q+NjXU2QFXE4AZFS4w5
         FAJw==
X-Gm-Message-State: AGRZ1gI8kru05ywlNiR8Mg2iqBkfeCyO/UN3+p0m6HdCwnfHtsCrg3g4
        OKKpt/1eIFQZ5Q66mu6LvE4vpBJs/SES
X-Google-Smtp-Source: AFSGD/Va7z8PSmAcKHGrEIJjGnGQ2ajacMfWtcwgJvkglit2D6XwXzEKf0fAdwfTe6LOle4ydkE6yf4YDgKJ
X-Received: by 2002:ac8:244a:: with SMTP id d10mr10227616qtd.15.1542668670179;
 Mon, 19 Nov 2018 15:04:30 -0800 (PST)
Date:   Mon, 19 Nov 2018 15:04:07 -0800
In-Reply-To: <20181119230409.258121-1-rajatja@google.com>
Message-Id: <20181119230409.258121-3-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181119230409.258121-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v2 3/5] Bluetooth: Reset Bluetooth chip after multiple command timeouts
From:   Rajat Jain <rajatja@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a quirk and a hook to allow the HCI core to reset the BT chip
if needed (after a number of timed out commands). Use that new hook to
initiate BT chip reset if the controller fails to respond to certain
number of commands (currently 5) including the HCI reset commands.
This is done based on a newly introduced quirk. This is done based
on some initial work by Intel.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: same as v1

 include/net/bluetooth/hci.h      |  8 ++++++++
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 15 +++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e20556..af02fa5ffe54 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -192,6 +192,14 @@ enum {
 	 *
 	 */
 	HCI_QUIRK_NON_PERSISTENT_SETUP,
+
+	/* When this quirk is set, hw_reset() would be run to reset the
+	 * hardware, after a certain number of commands (currently 5)
+	 * time out because the device fails to respond.
+	 *
+	 * This quirk should be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_HW_RESET_ON_TIMEOUT,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5ea633ea368..b86218304b80 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -313,6 +313,7 @@ struct hci_dev {
 	unsigned int	acl_cnt;
 	unsigned int	sco_cnt;
 	unsigned int	le_cnt;
+	unsigned int	timeout_cnt;
 
 	unsigned int	acl_mtu;
 	unsigned int	sco_mtu;
@@ -437,6 +438,7 @@ struct hci_dev {
 	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+	void (*hw_reset)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7352fe85674b..ab3a6a8b7ba6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2569,13 +2569,24 @@ static void hci_cmd_timeout(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    cmd_timer.work);
 
+	hdev->timeout_cnt++;
 	if (hdev->sent_cmd) {
 		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
 		u16 opcode = __le16_to_cpu(sent->opcode);
 
-		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
+		bt_dev_err(hdev, "command 0x%4.4x tx timeout (cnt = %u)",
+			   opcode, hdev->timeout_cnt);
 	} else {
-		bt_dev_err(hdev, "command tx timeout");
+		bt_dev_err(hdev, "command tx timeout (cnt = %u)",
+			   hdev->timeout_cnt);
+	}
+
+	if (test_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks) &&
+	    hdev->timeout_cnt >= 5) {
+		hdev->timeout_cnt = 0;
+		if (hdev->hw_reset)
+			hdev->hw_reset(hdev);
+		return;
 	}
 
 	atomic_set(&hdev->cmd_cnt, 1);
-- 
2.19.1.1215.g8438c0b245-goog

