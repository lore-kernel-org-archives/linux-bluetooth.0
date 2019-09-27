Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C8C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 02:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00F6208C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 02:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfI0Ct4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:49:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:2968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfI0Ct4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 22:49:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 19:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="scan'208";a="194340959"
Received: from kmsmsx152.gar.corp.intel.com ([172.21.73.87])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2019 19:49:54 -0700
Received: from pgsmsx105.gar.corp.intel.com ([169.254.4.30]) by
 KMSMSX152.gar.corp.intel.com ([169.254.11.65]) with mapi id 14.03.0439.000;
 Fri, 27 Sep 2019 10:49:53 +0800
From:   "Bag, Amit K" <amit.k.bag@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH] Bluetooth: btusb: print FW version after FW download
Thread-Topic: [PATCH] Bluetooth: btusb: print FW version after FW download
Thread-Index: AQHVc4lfO5YrBKLIykCNmu1lbaKwrKc8+TYAgAHbOqA=
Date:   Fri, 27 Sep 2019 02:49:53 +0000
Message-ID: <EFE6F46E14A5F445949D76A8CAC224005844D80D@PGSMSX105.gar.corp.intel.com>
References: <1569405826-4555-1-git-send-email-amit.k.bag@intel.com>
 <EB27BBF5-DB98-4C67-904B-6EA11C800008@holtmann.org>
In-Reply-To: <EB27BBF5-DB98-4C67-904B-6EA11C800008@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjEyOTdlMTUtYjNhMS00ZWExLTlhMWMtYTY5ZTBhYTQwMGMyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRzVnWE9aZkNWSGYzUG1TeGF6NFBqWlE4bTg5Y1ZpVTN6UnplTWk4VXBcL0NsYkozazk5N1ZManlMdFwvUWptMjM2In0=
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>Hi Amit,
>
>> After FW download there is no print to confirm the current FW version. 
>> Add print to check FW version incase of FW download.
>> 
>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>> ---
>> drivers/bluetooth/btusb.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c 
>> index a9c35ebb30f8..f6c033b5042c 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -2432,6 +2432,14 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>> 	 */
>> 	btintel_set_event_mask(hdev, false);
>> 
>> +	/* Read the Intel version information after loading the FW  */
>> +	err = btintel_read_version(hdev, &ver);
>> +	if (err)
>> +		return err;
>> +
>> +	btintel_version_info(hdev, &ver);
>> +	bt_dev_info(hdev, "Setup complete");
>> +
>
>I rather not add an extra Setup complete since that is rather noisy. We can add the extra version information if that adds value.
>

I will remove this message and post the revised patch. 

