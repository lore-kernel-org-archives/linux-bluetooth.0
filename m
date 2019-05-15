Return-Path: <SRS0=OL4k=TP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60CEC04E53
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 16:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77BF20873
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfEOQq1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 May 2019 12:46:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:23545 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEOQq1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 May 2019 12:46:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 09:46:26 -0700
X-ExtLoop1: 1
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2019 09:46:26 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 15 May 2019 09:46:26 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.101]) with mapi id 14.03.0415.000;
 Wed, 15 May 2019 09:46:26 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/3] mesh: add Keyring to CreateNetwork
Thread-Topic: [PATCH BlueZ 0/3] mesh: add Keyring to CreateNetwork
Thread-Index: AQHVCpHMWU1CCXyn6kaxJJ4roAdW7KZs26sA
Date:   Wed, 15 May 2019 16:46:25 +0000
Message-ID: <1557938784.32584.4.camel@intel.com>
References: <20190514201525.16067-1-brian.gix@intel.com>
In-Reply-To: <20190514201525.16067-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.7.218]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDC74549A123114DBC6304E9FF38C44B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtc2V0IGFwcGxpZWQsIHdpdGggbWlub3IgZWRpdCB0byB0ZXN0LW1lc2ggY29tbWVudHMN
Cg0KT24gVHVlLCAyMDE5LTA1LTE0IGF0IDEzOjE1IC0wNzAwLCBCcmlhbiBHaXggd3JvdGU6DQo+
IFBhdGNoLXNldCBhbHNvIGZpeGVzIHNvbWUgZmlsZSBjcmVhdGlvbiBwZXJtaXNzaW9ucyBhbmQg
YWRkcyBDcmVhdGVOZXR3b3JrDQo+IHRlc3QuDQo+IA0KPiBCcmlhbiBHaXggKDMpOg0KPiAgIG1l
c2g6IEFkZCAiY3JlYXRlIiBjb21tYW5kIHRvIHRlc3QgYXBwDQo+ICAgbWVzaDogRml4IGZpbGUg
b3BlbiBlcnJvciBjaGVja2luZyBhbmQgcGVybWlzc2lvbnMNCj4gICBtZXNoOiBTYXZlIGdlbmVy
YXRlZCBOZXQgYW5kIERldiBrZXlzIGluIEtleVJpbmcNCj4gDQo+ICBtZXNoL2tleXJpbmcuYyB8
ICA4ICsrKysrLS0tDQo+ICBtZXNoL25vZGUuYyAgICB8IDIwICsrKysrKysrKysrKysrKystLS0t
DQo+ICBtZXNoL3N0b3JhZ2UuYyB8ICAyICstDQo+ICB0ZXN0L3Rlc3QtbWVzaCB8IDQ2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIDQgZmlsZXMgY2hh
bmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA==
