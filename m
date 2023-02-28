Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0439C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 00:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjB1ANn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 19:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjB1ANg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 19:13:36 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F54E268A
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 16:13:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c6ce8d74so172390977b3.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 16:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zganrZlEZNt1pC9IiqoJtBTU38y2S6sutB3XmJEIjOQ=;
        b=GvuKeHm6KryowowADTIzEiupUt+Pr9uk0FdmdW3FBhCJBtHSpwcisZRn69OkTrIF1r
         ovptt5Pbb+y8e92zqed7MQ4ubg5BBAn+TAFnFgZJ9hiDYuzIjwmdQ47hiFoAp+lyOMzp
         bw4zH/F6+yjkw4sk75HV5NXkL0nGNLHJbaRe1IpRcgQog1k6fbATreaWbqCLU0ohaX+p
         NE6Xoc4ajh2vBehbHJRkTsAJBJC9nBY8GkMoKJvVGY9U+wduDLZff85sNoTcfUiLiB9p
         IdhjNFuPqObYV/uQBlsy7Ia26HHzvLc6EHvN1xpSydqDtaBQfV3sUoEu81V+gqKujirm
         AAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zganrZlEZNt1pC9IiqoJtBTU38y2S6sutB3XmJEIjOQ=;
        b=kE27H29QS7FpdY5FW95Pk0ShlPIlfItxNwaKb7xHG0QRRKEiRVZJwGht5DHizX7Fa2
         Pox3NTImfaTIPNsnpXXziTS5jkaVpH8IrAxNO40IRIsjonkCeURSwbfMA6hMAUmyu6nl
         H5D/oL8nJtfaRS7Mtm0eNuIvYMMIEIbgUl66gjYw4OpjRiypsRgVK3GmW9TsecEXtSkt
         +f9zIM2Vfe9pbhB1DyEzxw8dresqow28oPDATU03gty3Qdhlpo52JMtviJdFk9o5sG0H
         sI9kiqTBlHksEN4NQCAAiqH1s4orvih9uqyaf7uc1CDDhQq66lbhUBx+TJBrRes+K0nL
         NZRg==
X-Gm-Message-State: AO0yUKUWdK3eQHmnMx0YrV1TnmQQnpD/QE/uRUnRHx6UrWrYj29MWS1x
        1L2JltlRUJLKaMOMx6oBYRx2Nf4eRfbjyRInwPgfiT42/Tk/1EKhRVRuAFejsBS9qJNjYB+MPde
        HwnNahEsnPXFgQEpzE28OAr1fLi4XojTgfiMZ69KKPWo1nHdoFNlgmugWZ3RDVk1ZISpyUsDI+n
        F+
X-Google-Smtp-Source: AK7set8z3wnVv4GR7dPDvNzT1PbIuQjYKCCTz2/kps1zv9gO8KeL2rsqO771BHLqP9QIxPeX2P+EIrR94O4f
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a5b:346:0:b0:855:fa17:4f66 with SMTP id
 q6-20020a5b0346000000b00855fa174f66mr169038ybp.8.1677543206646; Mon, 27 Feb
 2023 16:13:26 -0800 (PST)
Date:   Mon, 27 Feb 2023 16:13:23 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227161320.kernel.v4.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
Subject: [kernel PATCH v4] Bluetooth: hci_sync: Resume adv with no RPA when
 active scan
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The address resolution should be disabled during the active scan,
so all the advertisements can reach the host. The advertising
has to be paused before disabling the address resolution,
because the advertising will prevent any changes to the resolving
list and the address resolution status. Skipping this will cause
the hci error and the discovery failure.

According to the bluetooth specification:
"7.8.44 LE Set Address Resolution Enable command

This command shall not be used when:
- Advertising (other than periodic advertising) is enabled,
- Scanning is enabled, or
- an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection, or
  HCI_LE_Periodic_Advertising_Create_Sync command is outstanding."

If the host is using RPA, the controller needs to generate RPA for
the advertising, so the advertising must remain paused during the
active scan.

If the host is not using RPA, the advertising can be resumed after
disabling the address resolution.

Fixes: 9afc675edeeb ("Bluetooth: hci_sync: allow advertise when scan without RPA")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v4:
- Change return value of hci_pause_addr_resolution from err to 0 for
  readability

Changes in v3:
- Add a function to check the requirements to pause addr resolution
- Pause and resume advertising in hci_pause_addr_resolution
- Resume advertising if pausing addr resolution fails or privacy mode is
  not used for advertising

Changes in v2:
- Commit message format

Changes in v1:
- With LL privacy, always pause advertising when active scan
- Only resume the advertising if the host is not using RPA

 net/bluetooth/hci_sync.c | 64 +++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 117eedb6f709..eb4429d94f95 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2367,6 +2367,45 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 	return err;
 }
 
+static int hci_pause_addr_resolution(struct hci_dev *hdev)
+{
+	int err;
+
+	if (!use_ll_privacy(hdev))
+		return 0;
+
+	if (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+		return 0;
+
+	/* Cannot disable addr resolution if scanning is enabled or
+	 * when initiating an LE connection.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+	    hci_lookup_le_connect(hdev)) {
+		bt_dev_err(hdev, "Command not allowed when scan/LE connect");
+		return -EPERM;
+	}
+
+	// Cannot disable addr resolution if advertising is enabled.
+	err = hci_pause_advertising_sync(hdev);
+	if (err) {
+		bt_dev_err(hdev, "Pause advertising failed: %d", err);
+		return err;
+	}
+
+	err = hci_le_set_addr_resolution_enable_sync(hdev, 0x00);
+	if (err)
+		bt_dev_err(hdev, "Unable to disable Address Resolution: %d",
+			   err);
+
+	// Return if address resolution is disabled and RPA is not used.
+	if (!err && scan_use_rpa(hdev))
+		return 0;
+
+	hci_resume_advertising_sync(hdev);
+	return err;
+}
+
 struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev,
 					     bool extended, struct sock *sk)
 {
@@ -2402,7 +2441,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	u8 filter_policy;
 	int err;
 
-	/* Pause advertising if resolving list can be used as controllers are
+	/* Pause advertising if resolving list can be used as controllers
 	 * cannot accept resolving list modifications while advertising.
 	 */
 	if (use_ll_privacy(hdev)) {
@@ -5394,27 +5433,12 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 
 	cancel_interleave_scan(hdev);
 
-	/* Pause advertising since active scanning disables address resolution
-	 * which advertising depend on in order to generate its RPAs.
-	 */
-	if (use_ll_privacy(hdev) && hci_dev_test_flag(hdev, HCI_PRIVACY)) {
-		err = hci_pause_advertising_sync(hdev);
-		if (err) {
-			bt_dev_err(hdev, "pause advertising failed: %d", err);
-			goto failed;
-		}
-	}
-
-	/* Disable address resolution while doing active scanning since the
-	 * accept list shall not be used and all reports shall reach the host
-	 * anyway.
+	/* Pause address resolution for active scan and stop advertising if
+	 * privacy is enabled.
 	 */
-	err = hci_le_set_addr_resolution_enable_sync(hdev, 0x00);
-	if (err) {
-		bt_dev_err(hdev, "Unable to disable Address Resolution: %d",
-			   err);
+	err = hci_pause_addr_resolution(hdev);
+	if (err)
 		goto failed;
-	}
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
-- 
2.39.2.722.g9855ee24e9-goog

