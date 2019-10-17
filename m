Return-Path: <SRS0=wWRn=YK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FEFA372D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F91020820
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 08:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408196AbfJQIXa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:23:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:7306 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389953AbfJQIXa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Oct 2019 04:23:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 01:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,307,1566889200"; 
   d="scan'208";a="226082271"
Received: from pgsmsx112.gar.corp.intel.com ([10.108.55.201])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2019 01:23:29 -0700
Received: from pgsmsx105.gar.corp.intel.com ([169.254.4.226]) by
 PGSMSX112.gar.corp.intel.com ([169.254.3.19]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 16:23:28 +0800
From:   "Bag, Amit K" <amit.k.bag@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>
Subject: Recall: [PATCH v5] Bluetooth: btusb: Trigger Intel FW download
 error recovery
Thread-Topic: [PATCH v5] Bluetooth: btusb: Trigger Intel FW download error
 recovery
Thread-Index: AdWExCcbJmFnvMDc+kG2ljaJBK6JBQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Thu, 17 Oct 2019 08:23:28 +0000
Message-ID: <EFE6F46E14A5F445949D76A8CAC224005845C75F@PGSMSX105.gar.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bag, Amit K would like to recall the message, "[PATCH v5] Bluetooth: btusb: Trigger Intel FW download error recovery".
