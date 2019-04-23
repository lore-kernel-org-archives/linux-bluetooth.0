Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42367C10F03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3DD218CD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfDWPpx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:45:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:53419 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbfDWPpw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 11:45:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 08:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="164108913"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 23 Apr 2019 08:45:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 23 Apr 2019 18:45:49 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH BlueZ 1/2] hid2hci: Fix EALREADY handling after libusb removal
Date:   Tue, 23 Apr 2019 18:45:48 +0300
Message-Id: <20190423154549.31677-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

usb_control_msg() used to return the number bytes transferred wheras
the replacement (control_message()) just returns 0 vs. error. This
means the EALREADY handling is now broken. So let's just remove the
EALREADY handling entirely.

Cc: Marcel Holtmann <marcel@holtmann.org>
Fixes: e3cc40084ce4 ("tools: Remove libusb dependency from hid2hci")
---
 tools/hid2hci.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 1e0f7aa2ab8b..206a5af032ae 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -111,10 +111,7 @@ static int usb_switch_csr(int fd, enum mode mode)
 	err = control_message(fd, USB_ENDPOINT_OUT | USB_TYPE_VENDOR  |
 							USB_RECIP_DEVICE,
 						0, mode, 0, NULL, 0, 10000);
-	if (err == 0) {
-		err = -1;
-		errno = EALREADY;
-	} else if (errno == ETIMEDOUT)
+	if (err < 0 && errno == ETIMEDOUT)
 		err = 0;
 
 	return err;
@@ -255,13 +252,8 @@ static int usb_switch_dell(int fd, enum mode mode)
 				USB_REQ_SET_CONFIGURATION,
 				0x7f | (0x03 << 8), 0,
 				report, sizeof(report), 5000);
-	if (err == 0) {
-		err = -1;
-		errno = EALREADY;
-	} else {
-		if (errno == ETIMEDOUT)
-			err = 0;
-	}
+	if (err < 0 && errno == ETIMEDOUT)
+		err = 0;
 
 	return err;
 }
-- 
2.21.0

