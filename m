Return-Path: <SRS0=WW16=OC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A39C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Nov 2018 10:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2770A206B2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Nov 2018 10:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2770A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409510AbeKWVgO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:36:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:58198 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390614AbeKWVgO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Nov 2018 16:36:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 02:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,269,1539673200"; 
   d="scan'208";a="276265237"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2018 02:52:26 -0800
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 23 Nov 2018 02:52:26 -0800
Received: from BGSMSX108.gar.corp.intel.com (10.223.4.192) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 23 Nov 2018 02:52:26 -0800
Received: from bgsmsx110.gar.corp.intel.com ([169.254.11.69]) by
 BGSMSX108.gar.corp.intel.com ([169.254.8.68]) with mapi id 14.03.0415.000;
 Fri, 23 Nov 2018 16:22:23 +0530
From:   "Panda, Bharat B" <bharat.b.panda@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        'Marcel Holtmann' <marcel@holtmann.org>
Subject: RE: [PATCH v2] Bluetooth: Support fast advertising interval
Thread-Topic: [PATCH v2] Bluetooth: Support fast advertising interval
Thread-Index: AQHUcDiPVg5fEVUUwE2S8+QBit+So6VNffoggA/WwHA=
Date:   Fri, 23 Nov 2018 10:52:22 +0000
Message-ID: <B42C2A3D4050B547BA40CAE18E023BE64D679A04@BGSMSX110.gar.corp.intel.com>
References: <marcel@holtmann.org>
 <1540895076-6046-1-git-send-email-bharat.b.panda@intel.com>
 <B42C2A3D4050B547BA40CAE18E023BE64CCAE70D@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <B42C2A3D4050B547BA40CAE18E023BE64CCAE70D@BGSMSX101.gar.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzdlYzQyMjUtYzFmNy00YjQ3LWE2MGItN2UwODMyYmMzY2Y4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieTVsek95M0h3a2tTbFVuaGNSSnp5dmwxTm1kNjBJc1NobXlpc0NKZWZQQWxqSmZESzhxMkc2UzlBbXFWSmpIdiJ9
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

Ping

> -----Original Message-----
> From: Panda, Bharat B
> Sent: Tuesday, November 13, 2018 2:31 PM
> To: linux-bluetooth@vger.kernel.org; 'Marcel Holtmann'
> <marcel@holtmann.org>
> Cc: Panda, Bharat B <bharat.b.panda@intel.com>
> Subject: RE: [PATCH v2] Bluetooth: Support fast advertising interval
> 
> Soft reminder.
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Bharat Bhusan Panda
> > Sent: Tuesday, October 30, 2018 3:55 PM
> > To: linux-bluetooth@vger.kernel.org
> > Subject: [PATCH v2] Bluetooth: Support fast advertising interval
> >
> > Changes made to add support for fast advertising interval as per core
> > 4.1 specification, section 9.3.11.2.
> >
> > A peripheral device entering any of the following GAP modes and
> > sending either non-connectable advertising events or scannable
> > undirected advertising events should use adv_fast_interval2(100ms - 150ms)
> for adv_fast_period(30s).
> >          - Non-Discoverable Mode
> >          - Non-Connectable Mode
> >          - Limited Discoverable Mode
> >          - General Discoverable Mode
> >
> > Signed-off-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h |  2 ++
> >  net/bluetooth/hci_request.c      | 27 +++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 0db1b9b..868c2fb 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1491,6 +1491,8 @@ struct hci_mgmt_chan {
> >  #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> >  #define DISCOV_BREDR_INQUIRY_LEN	0x08
> >  #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/*
> > msec */
> > +#define DISCOV_LE_FAST_ADV_INT_MIN	100	/* msec */
> > +#define DISCOV_LE_FAST_ADV_INT_MAX	150	/* msec */
> >
> >  void mgmt_fill_version_info(void *ver);  int mgmt_new_settings(struct
> > hci_dev *hdev); diff --git a/net/bluetooth/hci_request.c
> > b/net/bluetooth/hci_request.c index e8c9ef1..fe43498 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -1092,6 +1092,33 @@ void __hci_req_enable_advertising(struct
> > hci_request *req)
> >  	else
> >  		cp.type = LE_ADV_NONCONN_IND;
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
> > LE_ADV_SCAN_IND) {
> > +		/* Set the suggested min and max fast advertising interval,
> > +		 * only if the peripheral device has entered any of the modes
> > +		 * such as non-discoverable, non-connectable or limited-
> > +		 * discoverable.
> > +		 */
> > +		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
> > +			!hci_dev_test_flag(hdev, HCI_CONNECTABLE) ||
> > +			hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
> > {
> > +			cp.min_interval =
> > +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
> > +			cp.max_interval =
> > +
> > 	cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
> > +		}
> > +	}
> > +
> >  	cp.own_address_type = own_addr_type;
> >  	cp.channel_map = hdev->le_adv_channel_map;
> >
> > --
> > 1.9.1

