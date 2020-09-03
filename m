Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA10C433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF7B2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 18:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgICSsz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:48:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:4301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgICSsy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Sep 2020 14:48:54 -0400
IronPort-SDR: 847C3m88iI1t3pCpCB+MVtPWDPBRBJNVRjyRxWobTCoC25rjykS1iKdVpTLGZiQLEXSglOmklm
 qQJumFc1g1dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="155037267"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="155037267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 11:48:53 -0700
IronPort-SDR: zlmlb0keiLm9Oo+VY+pLO+INVq+KgL/+scd2WeN0ehbEGz8unYDKYO5mC0m8K16TUKzoivGynd
 In/R6CXTsakQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="339391380"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2020 11:48:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 24E26E1; Thu,  3 Sep 2020 21:48:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] Bluetooth: hci_intel: drop strange le16_to_cpu() against u8 values
Date:   Thu,  3 Sep 2020 21:48:48 +0300
Message-Id: <20200903184850.53055-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
References: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sparse rightfully complains:

  hci_intel.c:696:26: warning: cast to restricted __le16
  hci_intel.c:701:26: warning: cast to restricted __le16
  hci_intel.c:702:26: warning: cast to restricted __le16
  hci_intel.c:703:26: warning: cast to restricted __le16
  hci_intel.c:725:26: warning: cast to restricted __le16
  hci_intel.c:730:26: warning: cast to restricted __le16
  hci_intel.c:731:26: warning: cast to restricted __le16
  hci_intel.c:732:26: warning: cast to restricted __le16

because we access non-restricted types with le16_to_cpu().
More confusion is added by using above against u8. On big-endian
architecture we will get all zeroes. I bet it's not what should be
in such case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/hci_intel.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 703d774be5a6..50e4fc6813c2 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -693,14 +693,11 @@ static int intel_setup(struct hci_uart *hu)
 	case 0x0b:      /* SfP */
 	case 0x0c:      /* WsP */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
-			 le16_to_cpu(ver.hw_variant),
-			 le16_to_cpu(params.dev_revid));
+			 ver.hw_variant, le16_to_cpu(params.dev_revid));
 		break;
 	case 0x12:      /* ThP */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
-			 le16_to_cpu(ver.hw_variant),
-			 le16_to_cpu(ver.hw_revision),
-			 le16_to_cpu(ver.fw_revision));
+			 ver.hw_variant, ver.hw_revision, ver.fw_revision);
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
@@ -722,14 +719,11 @@ static int intel_setup(struct hci_uart *hu)
 	case 0x0b:      /* SfP */
 	case 0x0c:      /* WsP */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
-			 le16_to_cpu(ver.hw_variant),
-			 le16_to_cpu(params.dev_revid));
+			 ver.hw_variant, le16_to_cpu(params.dev_revid));
 		break;
 	case 0x12:      /* ThP */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
-			 le16_to_cpu(ver.hw_variant),
-			 le16_to_cpu(ver.hw_revision),
-			 le16_to_cpu(ver.fw_revision));
+			 ver.hw_variant, ver.hw_revision, ver.fw_revision);
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
-- 
2.28.0

