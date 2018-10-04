Return-Path: <SRS0=5F6V=MQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6CAC00449
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 02:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C94E20856
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 02:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C94E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJDJTr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:19:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:62219 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJDJTr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Oct 2018 05:19:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 19:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="76041187"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2018 19:27:29 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 3 Oct 2018 19:27:29 -0700
Received: from bgsmsx154.gar.corp.intel.com (10.224.48.47) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 3 Oct 2018 19:27:29 -0700
Received: from bgsmsx105.gar.corp.intel.com ([169.254.3.166]) by
 BGSMSX154.gar.corp.intel.com ([169.254.7.90]) with mapi id 14.03.0319.002;
 Thu, 4 Oct 2018 07:57:26 +0530
From:   "Phulari, Mallikarjun" <mallikarjun.phulari@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v3] Bluetooth : Errata Service Release 8, Erratum 3253
Thread-Topic: [PATCH v3] Bluetooth : Errata Service Release 8, Erratum 3253
Thread-Index: AQHUWzpBLw868abpK0un34hqVlPdoKUOXLDQ
Date:   Thu, 4 Oct 2018 02:27:25 +0000
Message-ID: <70C091497DE2844DBD9E143B2282ABDA9C3C93@BGSMSX105.gar.corp.intel.com>
References: <1538574034-31184-1-git-send-email-mallikarjun.phulari@intel.com>
 <9BB9F76D-A318-4B6E-ACB3-9E30CEAD4B84@holtmann.org>
In-Reply-To: <9BB9F76D-A318-4B6E-ACB3-9E30CEAD4B84@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTA2NzVjOTctOGY3Yy00MWJmLWFlMGItODgwNmJjNTM3ZWVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib2tNWndMVzZXMEdZRjlnenU1eGk4UHI3VGdXOVhIUnRnU1RhXC9zRnJOOUJTSFREdnJqVWlsYUtxVTFLaFhld3IifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNl
bCBIb2x0bWFubiBbbWFpbHRvOm1hcmNlbEBob2x0bWFubi5vcmddDQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgT2N0b2JlciAzLCAyMDE4IDEwOjI4IFBNDQo+IFRvOiBQaHVsYXJpLCBNYWxsaWthcmp1biA8
bWFsbGlrYXJqdW4ucGh1bGFyaUBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIEJsdWV0b290aCA6IEVycmF0
YSBTZXJ2aWNlIFJlbGVhc2UgOCwgRXJyYXR1bSAzMjUzDQo+IA0KPiBIaSBNYWxsaWthcmp1biwN
Cj4gDQo+ID4gTDJDQVA6IE5ldyByZXN1bHQgdmFsdWVzDQo+ID4gCTB4MDAwNiAtIENvbm5lY3Rp
b24gcmVmdXNlZCDigJMgSW52YWxpZCBTb3VyY2UgQ0lEDQo+ID4gCTB4MDAwNyAtIENvbm5lY3Rp
b24gcmVmdXNlZCDigJMgU291cmNlIENJRCBhbHJlYWR5IGFsbG9jYXRlZA0KPiA+DQo+ID4gQXMg
cGVyIHRoZSBFU1IwOF9WMS4wLjAsIDEuMTEuMiBFcnJhdHVtIDMyNTMsIFBhZ2UgTm8uIDU0LCAi
UmVtb3RlIENJRA0KPiA+IGludmFsaWQgSXNzdWUiLg0KPiA+IEFwcGxpZXMgdG8gQ29yZSBTcGVj
aWZpY2F0aW9uIHZlcnNpb25zOiBWNS4wLCBWNC4yLCB2NC4xLCB2NC4wLCBhbmQNCj4gPiB2My4w
ICsgSFMgVm9sIDMsIFBhcnQgQSwgU2VjdGlvbiA0LjIsIDQuMywgNC4xNCwgNC4xNS4NCj4gPg0K
PiA+IENvcmUgU3BlY2lmaWNhdGlvbiBWZXJzaW9uIDUuMCwgUGFnZSBOby4xNzUzLCBUYWJsZSA0
LjYgYW5kIFBhZ2UgTm8uDQo+ID4gMTc2NywgVGFibGUgNC4xNA0KPiA+DQo+ID4gTmV3IHJlc3Vs
dCB2YWx1ZXMgYXJlIGFkZGVkIHRvIGwyY2FwIGNvbm5lY3QvY3JlYXRlIGNoYW5uZWwgcmVzcG9u
c2UNCj4gPiBhcw0KPiA+IDB4MDAwNiAtIENvbm5lY3Rpb24gcmVmdXNlZCDigJMgSW52YWxpZCBT
b3VyY2UgQ0lEDQo+ID4gMHgwMDA3IC0gQ29ubmVjdGlvbiByZWZ1c2VkIOKAkyBTb3VyY2UgQ0lE
IGFscmVhZHkgYWxsb2NhdGVkDQo+ID4NCj4gPiBBbmQgYWxzbyByZW5hbWVkIHRoZSByZXN1bHQg
dmFsdWVzIHNwZWNpZmljIHRvIExFIENyZWRpdCBiYXNlZA0KPiA+IENvbm5lY3Rpb24gYXMgTDJD
QVBfQ1JfTEVfKiBhbmQgY2hhbmdlZCB0aGUgb2xkIG5hbWVzIHdoZXJldmVyIHRoZXkNCj4gd2Vy
ZSB1c2VkLg0KPiANCj4gSSB3YW50IHRoaXMgYXMgdHdvIHNlcGFyYXRlIHBhdGNoZXMuIEZpcnN0
IGRvIHRoZSBuYW1pbmcgY2hhbmdlcyB0byBleGlzdGluZw0KPiBjb2RlIGFuZCB0aGVuIGluIGEg
c2Vjb25kIHBhdGNoIGFkZCB0aGUgbmV3IGNoYW5nZXMgZnJvbSB0aGUgZXJyYXR1bS4NCg0KDQpJ
IHdpbGwgc2VuZCB0d28gcGF0Y2hlcyBhcyB5b3Ugc3VnZ2VzdGVkLg0KDQo+IA0KPiBSZWdhcmRz
DQo+IA0KPiBNYXJjZWwNCg0KVGhhbmtzICYgUmVnYXJkcw0KTWFsbGlrYXJqdW4gUGh1bGFyaQ0K
