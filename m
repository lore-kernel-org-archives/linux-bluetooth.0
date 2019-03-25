Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE33C10F03
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 04:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5387B2087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 04:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfCYEw2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:52:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:53575 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfCYEw2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 00:52:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 21:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="331668896"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2019 21:52:27 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 24 Mar 2019 21:52:26 -0700
Received: from bgsmsx154.gar.corp.intel.com (10.224.48.47) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 24 Mar 2019 21:52:26 -0700
Received: from bgsmsx103.gar.corp.intel.com ([169.254.4.38]) by
 BGSMSX154.gar.corp.intel.com ([169.254.7.225]) with mapi id 14.03.0415.000;
 Mon, 25 Mar 2019 10:22:24 +0530
From:   "Hegde, Raghuram" <raghuram.hegde@intel.com>
To:     Sasha Levin <sashal@kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] btusb: Re-program BULK IN URBs once the Intel BT
 controller  is in operational firmware mode.
Thread-Topic: [PATCH] btusb: Re-program BULK IN URBs once the Intel BT
 controller  is in operational firmware mode.
Thread-Index: AQHU3hP7E7940SuhCEC00sQYCDW2HKYbLc4AgAChl2A=
Date:   Mon, 25 Mar 2019 04:52:24 +0000
Message-ID: <E5FA71999F8E8845A748D0B68F0A4BDF3730CE9F@BGSMSX103.gar.corp.intel.com>
References: <1552972986-32258-1-git-send-email-chethan.tumkur.narayan@intel.com>
 <20190325003837.B5F742171F@mail.kernel.org>
In-Reply-To: <20190325003837.B5F742171F@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sasha,

Please consider this patch for stable kernel releases from v4.4.176 onwards, as the support for Intel RAM based Bluetooth products is missing in the v3.18.136.


Thanks,
Raghuram

-----Original Message-----
From: Sasha Levin [mailto:sashal@kernel.org] 
Sent: Monday, March 25, 2019 6:09 AM
To: Sasha Levin <sashal@kernel.org>; Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>; Hegde, Raghuram <raghuram.hegde@intel.com>; linux-bluetooth@vger.kernel.org
Cc: Hegde, Raghuram <raghuram.hegde@intel.com>; stable@vger.kernel.org; stable@vger.kernel.org
Subject: Re: [PATCH] btusb: Re-program BULK IN URBs once the Intel BT controller is in operational firmware mode.

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.0.3, v4.19.30, v4.14.107, v4.9.164, v4.4.176, v3.18.136.

v5.0.3: Build OK!
v4.19.30: Build OK!
v4.14.107: Build OK!
v4.9.164: Build OK!
v4.4.176: Build OK!
v3.18.136: Failed to apply! Possible dependencies:
    17b2772b8fe3 ("Bluetooth: Read Broadcom chip info for Apple Bluetooth devices")
    18835dfa3ac5 ("Bluetooth: btusb: Use matching names for Broadcom firmware files")
    1df1f5910825 ("Bluetooth: btusb: Use generic functionality by Broadcom module")
    213445b2b40e ("Bluetooth: btintel: Enable extra Intel vendor events")
    2cbd3f5ccd43 ("Bluetooth: btusb: Add internal callback for USB bulk rx data")
    3267c884cefa ("Bluetooth: btusb: Add support for QCA ROME chipset family")
    385a768c3be1 ("Bluetooth: btusb: Provide hardware error handler for Intel devices")
    4185a0f5d043 ("Bluetooth: btusb: Use generic Intel support for address support")
    48f0ed1bb685 ("Bluetooth: btintel: Introduce generic Intel Bluetooth support")
    4fba30f07f51 ("Bluetooth: btbcm: Introduce generic Broadcom Bluetooth support")
    4fcef8ed75af ("Bluetooth: Fix issue with Roper Class 1 Bluetooth Dongle")
    6d2e50d24098 ("Bluetooth: btintel: Add support for enabling tracing functionality")
    893ba5440a25 ("Bluetooth: btusb: Add support for USB based AMP controllers")
    97307f51d7ce ("Bluetooth: btusb: Add internal recv_event callback for event processing")
    973bb97e5aee ("Bluetooth: btintel: Add generic function for handling hardware errors")
    bfbd45e9acd2 ("Bluetooth: Add device shutdown routine for Intel Bluetooth device")
    cda0dd7809f8 ("Bluetooth: btusb: Add firmware loading for Intel Snowfield Peak devices")
    d57dbe779e0e ("Bluetooth: btusb: Set the HCI_QUIRK_BROKEN_LOCAL_COMMANDS quirk")
    d8270fbb3ffe ("Bluetooth: btintel: Set quirk for non-persistent diagnostic settings")
    eeb6abe97390 ("Bluetooth: btusb: Use hardware error handler from Intel module")


How should we proceed with this patch?

--
Thanks,
Sasha
