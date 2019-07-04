Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E3FC0651F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA72189E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 18:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGDSl2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:41:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:19233 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfGDSl1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 14:41:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 11:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="158334492"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2019 11:41:26 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 11:41:26 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.102]) with mapi id 14.03.0439.000;
 Thu, 4 Jul 2019 11:41:26 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Mahaboob Nazeer SK <nazeer.m@phytec.in>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Testing Bluetooth Mesh with python
Thread-Topic: Testing Bluetooth Mesh with python
Thread-Index: AQHVMh4Yr96fnUv/NkOv6PrxwONL3Ka6y+8l
Date:   Thu, 4 Jul 2019 18:41:25 +0000
Message-ID: <47E2CBA9-0E7D-46D7-AB94-E27B54AAE110@intel.com>
References: <OFCEFD7E67.77A1AF25-ONC125842D.001694FD-C125842D.001694FE@phytec.de>
In-Reply-To: <OFCEFD7E67.77A1AF25-ONC125842D.001694FD-C125842D.001694FE@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

> On Jul 3, 2019, at 9:08 PM, Mahaboob Nazeer SK <nazeer.m@phytec.in> wrote:
> 
> Hi,
> 
> We are using Zephyr Mesh onoff example on nrf52 eval kit to test the Mesh Functionality.For provisioning of the
> node we are using meshctl tool.
> 
> But is there any other way to provision a node using a python script.I found a test-mesh script in the test folder 
> of bluez stack ,but i was unable to provision and test a node with it.Could you share a test procedure if any.

We are in the process of coding the Management1 D-Bus interface which includes many of the method calls required for Provisioner support.  The test-mesh python script does *not* work with the meshctl tool, which uses a GATT based architecture.

The D-Bus interface (as described in the doc/mesh-api.txt) works with the bluetooth-meshd daemon which is currently being built out, and it is entirely built on Advertisement (non-GATT) based communication with other nodes.

The methods required for the Provisioner side are not quite ready to be pushed out.


> 
> --
> Thanks
> 
> 
> 
> 
> 
