Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4AEC282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 09:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1346720844
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 09:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfBDJKt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:10:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:18516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfBDJKt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 04:10:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 01:10:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="123739693"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2019 01:10:48 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 4 Feb 2019 01:10:48 -0800
Received: from bgsmsx152.gar.corp.intel.com (10.224.48.50) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 4 Feb 2019 01:10:47 -0800
Received: from bgsmsx109.gar.corp.intel.com ([169.254.10.162]) by
 BGSMSX152.gar.corp.intel.com ([169.254.6.187]) with mapi id 14.03.0415.000;
 Mon, 4 Feb 2019 14:40:45 +0530
From:   "Panda, Bharat B" <bharat.b.panda@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: Support fast advertising interval
Thread-Topic: [PATCH v2] Bluetooth: Support fast advertising interval
Thread-Index: AQHUcDiPVg5fEVUUwE2S8+QBit+So6WFFqSAgEra+vA=
Date:   Mon, 4 Feb 2019 09:10:44 +0000
Message-ID: <B42C2A3D4050B547BA40CAE18E023BE64D6A77D0@BGSMSX109.gar.corp.intel.com>
References: <marcel@holtmann.org>
 <1540895076-6046-1-git-send-email-bharat.b.panda@intel.com>
 <E8D865FD-B17C-4F46-8CC7-6EC6F010D757@holtmann.org>
In-Reply-To: <E8D865FD-B17C-4F46-8CC7-6EC6F010D757@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjhmNDgwZGMtMzJmMy00NzUxLTljMzItYTY5NGVjZjI3MDBhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZXVLVlhSaVljb0x5cHdcL1NZdXFaWXpBRm9iQkMybm9DMXkycVNkMFRpb1FYNW0rZVpQbjZCYlVXazluUElYM1UifQ==
x-ctpclassification: CTP_NT
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

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Wednesday, December 19, 2018 5:00 AM
> To: Panda, Bharat B <bharat.b.panda@intel.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v2] Bluetooth: Support fast advertising interval
> 
> Hi Bharat,
> 
> > Changes made to add support for fast advertising interval as per core
> > 4.1 specification, section 9.3.11.2.
> >
> > A peripheral device entering any of the following GAP modes and
> > sending either non-connectable advertising events or scannable
> > undirected advertising events should use adv_fast_interval2(100ms -
> > 150ms) for adv_fast_period(30s).
> >         - Non-Discoverable Mode
> >         - Non-Connectable Mode
> >         - Limited Discoverable Mode
> >         - General Discoverable Mode
> >
> > Signed-off-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
> > ---
> > include/net/bluetooth/hci_core.h |  2 ++
> > net/bluetooth/hci_request.c      | 27 +++++++++++++++++++++++++++
> > 2 files changed, 29 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 0db1b9b..868c2fb 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1491,6 +1491,8 @@ struct hci_mgmt_chan {
> > #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> > #define DISCOV_BREDR_INQUIRY_LEN	0x08
> > #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/*
> msec */
> > +#define DISCOV_LE_FAST_ADV_INT_MIN	100	/* msec */
> > +#define DISCOV_LE_FAST_ADV_INT_MAX	150	/* msec */
> >
> > void mgmt_fill_version_info(void *ver); int mgmt_new_settings(struct
> > hci_dev *hdev); diff --git a/net/bluetooth/hci_request.c
> > b/net/bluetooth/hci_request.c index e8c9ef1..fe43498 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -1092,6 +1092,33 @@ void __hci_req_enable_advertising(struct
> hci_request *req)
> > 	else
> > 		cp.type = LE_ADV_NONCONN_IND;
> >
> > +	/* As per core 4.1 spec, section 9.3.11.2: A peripheral device
> > +	 * entering any of the following GAP modes and sending either
> > +	 * non-connectable advertising events or scannable undirected
> > +	 * advertising events should use adv_fast_interval2(100ms - 150ms)
> > +	 * for adv_fast_period(30s).
> > +	 *
> > +	 * 	- Non-Discoverable Mode
> > +	 *	- Non-Connectable Mode
> > +	 * 	- Limited Discoverable Mode
> > +	 * 	- General Discoverable Mode
> > +	 */
> > +	if (cp.type == LE_ADV_NONCONN_IND || cp.type ==
> LE_ADV_SCAN_IND) {
> > +		/* Set the suggested min and max fast advertising interval,
> > +		 * only if the peripheral device has entered any of the modes
> > +		 * such as non-discoverable, non-connectable or limited-
> > +		 * discoverable.
> > +		 */
> > +		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
> > +			!hci_dev_test_flag(hdev, HCI_CONNECTABLE) ||
> > +			hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
> {
> 
> this is still wrongly indented.
Sorry for replying late, I have made the correct indentation and submitted v3 for same. Please review.
> 
> > +			cp.min_interval =
> > +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
> > +			cp.max_interval =
> > +
> 	cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
> > +		}
> > +	}
> > +
> 
> Regards
> 
> Marcel

Regards,
Bharat

