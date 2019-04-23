Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45D0C282E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D87C217D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfDWPpz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:45:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:20334 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbfDWPpz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 11:45:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 08:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="167166256"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 23 Apr 2019 08:45:53 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 23 Apr 2019 18:45:52 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] hid2hci: Fix the exit value on success
Date:   Tue, 23 Apr 2019 18:45:49 +0300
Message-Id: <20190423154549.31677-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423154549.31677-1-ville.syrjala@linux.intel.com>
References: <20190423154549.31677-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Presumably we would want the program exit value to indicate
success when things worked out. Do that.
---
 tools/hid2hci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 206a5af032ae..2da7dd4ed7f8 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -432,6 +432,8 @@ int main(int argc, char *argv[])
 	if (err < 0)
 		fprintf(stderr, "error: switching device '%s' failed.\n",
 			udev_device_get_syspath(udev_dev));
+	else
+		rc = 0;
 exit:
 	udev_device_unref(udev_dev);
 	udev_unref(udev);
-- 
2.21.0

