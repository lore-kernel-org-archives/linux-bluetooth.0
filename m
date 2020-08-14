Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB18C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 22:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5305E2074D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 22:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k73o73VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHNWXo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgHNWXo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 18:23:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF24BC061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 15:23:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so5019870pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 15:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jRl27RMtgZLeq7b/WHxRkukWBIOKeVCPevK+sNiPhQ=;
        b=k73o73VNd0qn9M+iiKly87GFMMXb6KyBorDW4eREbb7tWN2jSXYRFziRAoYgSezuUF
         FLz13Od/1weIFdHYZAkH4EE6DZ2zj7DIZfLAK/em3ojP/RtKqLTLGoQKKszjB6dJ4pV9
         mte4YoB6Bc6FECyWkOAdnIkWLrrXIYtyO/yYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jRl27RMtgZLeq7b/WHxRkukWBIOKeVCPevK+sNiPhQ=;
        b=kfH5VwKIJ6JMDsEB4dqff15jwwl71xg4WX0Dv7kML/inR6KBKQxofINRGXkDrUHcjq
         yaL/PRk6ld9Mz7b0DzZLJxMxHNnnx1uTMrjINiL4OapCoLgVtxFIz5aZ/k7iK/ZVeL8A
         WxaaXMmzE5v27TkuWAQTdbPnJzvZvHbtO6q3oB5IkgIucwIVailXOvMR7hH9P0HOGUAj
         rrtGQIXhSRWv+d6inTkRzoAcfz3TbWhF3mRinSKtyNErNEAsDD3/3qdHd/i+LlyAvZCk
         uk0uRFWvYzYzDbrWBJ1D0bFEGaOrCBfBgGOhh6xTNLA6Bgq3JaJUp2NgCL9ux4An6wwQ
         fwtA==
X-Gm-Message-State: AOAM531ccmB7MfjXv2qruratjqmmr6f5Y93VkqW7uHe/nrSzm8S+PCV/
        593nJUH+lsm9ksTL9elKfgAoCg==
X-Google-Smtp-Source: ABdhPJw4VToGF1Qswjip3GwGa5R4xOuQDDzZR0q80w8U/1h/s8l757szCrDYF3vT/E21VzKADGZyYA==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr3422745plz.239.1597443823248;
        Fri, 14 Aug 2020 15:23:43 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id a17sm9302460pgi.26.2020.08.14.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:23:42 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] bluetooth: Set ext scan response only when it exists
Date:   Fri, 14 Aug 2020 15:23:36 -0700
Message-Id: <20200814152323.1.Ib022565452fde0c02fbcf619950ef868715dd243@changeid>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Only set extended scan response only when it exists. Otherwise, clear
the scan response data.

Per the core spec v5.2, Vol 4, Part E, 7.8.55

If the advertising set is non-scannable and the Host uses this command
other than to discard existing data, the Controller shall return the
error code Invalid HCI Command Parameters (0x12).

On WCN3991, the controller correctly responds with Invalid Parameters
when this is sent.  That error causes __hci_req_hci_power_on to fail
with -EINVAL and LE devices can't connect because background scanning
isn't configured.

Here is an hci trace of where this issue occurs during power on:

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x00
        Properties: 0x0010
          Use legacy advertising PDUs: ADV_NONCONN_IND
        Min advertising interval: 181.250 msec (0x0122)
        Max advertising interval: 181.250 msec (0x0122)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect...
        TX power: 127 dbm (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 1M (0x01)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
        Status: Success (0x00)
        TX power (selected): 9 dbm (0x09)
< HCI Command: LE Set Advertising Set Random Address (0x08|0x0035) plen 7
        Advertising handle: 0x00
        Advertising random address: 08:FD:55:ED:22:28 (OUI 08-FD-55)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Advertising Set Random Address (0x08|0x0035) ncmd
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35
        Handle: 0x00
        Operation: Complete scan response data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x0d
        Name (short): Chromebook
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Daniel Winkler <danielwinkler@google.com>
---

 net/bluetooth/hci_request.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e0269192f2e536..e17bc8a1c66ddd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1533,11 +1533,14 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 
 		memset(&cp, 0, sizeof(cp));
 
-		if (instance)
+		/* Extended scan response data doesn't allow a response to be
+		 * set if the instance isn't scannable.
+		 */
+		if (get_adv_instance_scan_rsp_len(hdev, instance))
 			len = create_instance_scan_rsp_data(hdev, instance,
 							    cp.data);
 		else
-			len = create_default_scan_rsp_data(hdev, cp.data);
+			len = 0;
 
 		if (hdev->scan_rsp_data_len == len &&
 		    !memcmp(cp.data, hdev->scan_rsp_data, len))
-- 
2.28.0.220.ged08abb693-goog

