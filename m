Return-Path: <SRS0=P4FJ=4D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B98C352A3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Feb 2020 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D0E2083B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Feb 2020 19:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="K05YHXFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgBOTut (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Feb 2020 14:50:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:63576 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgBOTut (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Feb 2020 14:50:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2020 11:50:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,445,1574150400"; 
   d="scan'208";a="227977182"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2020 11:50:48 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 15 Feb 2020 11:50:48 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 15 Feb 2020 11:50:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sat, 15 Feb 2020 11:50:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHLqf7hrdwGLfS/Ha9855B7WsXkWcbkRExAFNvaWbmpWPZqoE2SPYFYB97HrnP1d4PaJIZ5xMTQhRMutmmF9Duf27cfXow5qMJqBp0lmeY8h7vDN9YaH3gcFuZMNqB/k5fAo4aGAoudAK0LLN5wN/lI74dorH+RFPfPySXPUKicAm5ZNtK97TlcAKhXjRfanM21pI1IAi8wSllc2qDUhLbOyHb6NHM+A57sy+P6bN9z7nWA5KIoG25PTiNSiIOvQCQ/RRsFeQHgcVn4MWxudbRM9kzo4e+IL9GZzdNIirO9eHjUWR1o2sDk2Uzy2G7duRBxPzna01F1pvmY0C6LqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKnBtUOUsDdP5Il9N9LQDFu9FheFPeVcwJk/Hx3Z6Zc=;
 b=KpFQGtbLFfKd3vsa3bH9nVxFraLha8c6xv8Zue7TFXjBYYHl5htNUsFqKntd4LfUtROTKFhcIGx6AWUeEPAy7WGiWI97R8LF0SNIs5H1rtKW/dsI1m53eC7bHFTnV5wUaXRa9jYGvHU5TBwgTuDxh5dktWRQFevSNWsQUqe7BltkW4zk05n17j91P/SeIYuhiun0Z9t+hGl+r50/yZ4GiZot3NVAGUxnY2xfxsan1D4O42/PiPgZLD3fHVQdcy30utkPQH7059HVSmgKYzUkpoZxRR6TRUhqjbyMfl3FxOnUfDgSOZVuK4QB8Os+iyrDU27qmL4u5tBZgrDfG7Y3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKnBtUOUsDdP5Il9N9LQDFu9FheFPeVcwJk/Hx3Z6Zc=;
 b=K05YHXFSmaoltDRCG9hUvzDKa68i0kQWvjG/XPE8qieu7UuscA16dofvQRg81SUbk25n0QT7rQwzcagMbmM9HFwgofJ4N847gIwNHvpcFjV312EvJ7I6DjLETW1Zx31zwWRhByhP1ly/B7o0sBYj53OlGO8OKe3BTS1KTazj2V4=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2547.namprd11.prod.outlook.com (52.135.255.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Sat, 15 Feb 2020 19:50:44 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2707.031; Sat, 15 Feb 2020
 19:50:44 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "mike@mnmoran.org" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: Send mesh model message to group address
Thread-Topic: mesh: Send mesh model message to group address
Thread-Index: AQHV5C2Vy513aGUpRUitpLa2q+/ksagcqg6A
Date:   Sat, 15 Feb 2020 19:50:44 +0000
Message-ID: <e2f322b4ba3abb81b59a51d8bb5c3611b968cd4f.camel@intel.com>
References: <848c1b0b-83c6-41a3-fc66-1359fa9a72bb@mnmoran.org>
In-Reply-To: <848c1b0b-83c6-41a3-fc66-1359fa9a72bb@mnmoran.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 024a7332-669b-4a2e-82bc-08d7b250583f
x-ms-traffictypediagnostic: BN7PR11MB2547:
x-microsoft-antispam-prvs: <BN7PR11MB2547CE60803DC26EA6E40B8CE1140@BN7PR11MB2547.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03142412E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(189003)(199004)(71200400001)(76116006)(66446008)(15650500001)(36756003)(110136005)(91956017)(316002)(6486002)(26005)(2906002)(86362001)(2616005)(478600001)(64756008)(6512007)(81166006)(8936002)(81156014)(66946007)(8676002)(6506007)(66556008)(186003)(66476007)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2547;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtLeP+WUkSsBa3YsxQ26z6C3aFeLyE67SM4RJhgxPpgqh0r/FxKgwcqfOqpM6iXcqSA9FCQeYivYx6whA0eb/QGhZSiPHmLlB1fioZZU2IQEzoiS/l71FDAlN2qm/+P1MmdTuvZf/Pg11XwYfHP2w6tOSwe7Rl55QqzxmLxgZTl8g9+t5jjxsV9EygBGGru6wSBEOT92SCy7pLdHIGUzAHuDz+NkpgUkP7uRIHhc/B3t7maEHHyVzTpV42vdFuli7nzXXok/LwPhjYBZTa2tSS9WoBRB01a3RZqZmC7UUx7qRFkWfG6cYchgsNXjo3SY0vKxX2IyBEUC/+PR1nrtvdMMIhORxRUdes8pfBjjsst4g4OsfuYnmoq3nhX97XmAuLIrW0mDcIJnyLtWNZqBpcYyAcGAb357Xdd0O+rp04Qj+9G5bGLG3n2ckfin0Kfy
x-ms-exchange-antispam-messagedata: 8hmeY52uchBY193+RC2M/C+LJmqSkEiWw0M/GbbFmKfHu3zXwhbihELkUFRhbOzdZf5Si88CsQOw2/9eZ4pwo3oEH4lBJ1QKcwQ8e/wnh4ualQKDGbvQBuMv9OzCpA7k9siJcGYSgKM98NcHhVHsiA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AF6EF0F8FE19645BCE81EFA223522C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 024a7332-669b-4a2e-82bc-08d7b250583f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2020 19:50:44.2470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8kTt4FFkRZIezQ292ioXpuB/AThy1ERbeQ2PmbwKz3PMv806jWpCZJxAQiwuJh5EYlNwsPA/ijgaEkrpLz08A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2547
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFlbCwNCk9uIFNhdCwgMjAyMC0wMi0xNSBhdCAxMzoyMCAtMDUwMCwgTWljaGFlbCBO
LiBNb3JhbiB3cm90ZToNCj4gSSd2ZSBiZWVuIHVzaW5nIG1lc2hjdGwgdG8gcHJvdmlzaW9uL2Nv
bmZpZ3VyZSBhIGdyb3VwIG9mIA0KPiBtZXNoIG5vZGVzLg0KDQpGaXJzdCBvZmYsIGRvbid0IHVz
ZSBtZXNoY3RsIGZvciB3b3JrIGdvaW5nIGZvcndhcmQsIHVubGVzcyBmb3Igc29tZSByZWFzb24g
eW91ICpyZXF1aXJlKiBHQVRUIHN1cHBvcnQuICBNZXNoDQppcyBkZXNpZ25lZCB0byBwcmltYXJp
bHkgYmUgYW4gQWR2ZXJ0aXNpbmcgYmFzZWQgc3lzdGVtLCBhbmQgc28gYWxsIGN1cnJlbnQgd29y
ayBpcyBiZWluZyBkb25lIG9uIHRoZQ0KYmx1ZXRvb3RoLW1lc2hkIGRhZW1vbiwgd2hpY2ggZG9l
cyBub3QgeWV0IGhhdmUgR0FUVCBzdXBwb3J0Lg0KDQpXZSBjdXJyZW50bHkgaGF2ZSBhIHByZXR0
eSByb2J1c3Qgc29sdXRpb24gYmFzZWQgb246DQoNCjEuIFJ1biBtZXNoL2JsdWV0b290aC1tZXNo
ZCBhcyByb290DQogICAgMS4xIFlvdSBtYXkgbmVlZCB0byBmaXJzdCBpbnN0YWxsLCAqb3IqIGNv
cHkgDQogICAgICAgIG1lc2gvYmx1ZXRvb3RoLW1lc2guY29uZiAtLT4gL2V0Yy9kYnVzLTEvc3lz
dGVtLmQvYmx1ZXRvb3RoLW1lc2guY29uZg0KDQogICAgMS4yIE1ha2Ugc3VyZSBtZXNoL2JsdWV0
b290aC1tZXNoZCBoYXMgYSBkZWRpY2F0ZWQgdjQuMCBvcg0KICAgICAgICBiZXR0ZXIgY29udHJv
bGxlci4gVGhpcyBjYW4gYmUgZG9uZSBieSBzdG9wcGluZyBibHVldG9vdGhkLA0KICAgICAgICBv
ciBieSBoYXZpbmcgYSAybmQgY29udHJvbGxlciBpbiB0aGUgc3lzdGVtIGFuZCBtYWtpbmcgc3Vy
ZQ0KICAgICAgICB0aGF0IGluIC9ldGMvYmx1ZXRvb3RoL21haW4uY29uZiwgQXV0b0VuYWJsZT1m
YWxzZQ0KDQogICAgMS4zIHJlYm9vdA0KDQoyLiBSdW4gdG9vbHMvbWVzaC1jZmdjbGllbnQNCg0K
PiBUaGVyZSBkb2VzIG5vdCBzZWVtIHRvIGJlIGEgbWVjaGFuaXNtIGluIG1lc2hjdGwgdG8gc2Vu
ZCANCj4gbW9kZWwgbWVzc2FnZXMgdG8gZ3JvdXAgYWRkcmVzc2VzIG9yIHZpcnR1YWwgYWRkcmVz
c2VzLg0KPiANCj4gQXMgYW4gZXhhbXBsZSwgY29uc2lkZXIgdGhlIHNpbXBsZSBPbk9mZiBtb2Rl
bC4gSSBjYW4gDQo+IGNvbmZpZ3VyZSB0aGUgc3Vic2NyaXB0aW9uIGZvciBhbiBPbk9mZiBtb2Rl
bCB3aXRoIGEgZ3JvdXAgDQo+IGFkZHJlc3MuIEhvd2V2ZXIsIHRoZSBtZXNoY3RsIG9ub2ZmIGNv
bW1hbmQgd2lsbCBub3Qgd29yayANCj4gd2l0aCBhIGdyb3VwIGFkZHJlc3Mgc2V0IGZvciB0aGUg
b25vZmYgdGFyZ2V0Lg0KPiANCj4gSSBoYXZlIG1vZGlmaWVkIHRoZSBjbWRfc2V0KCkgZnVuY3Rp
b24gaW4gb25vZmYtbW9kZWwuYyBieSANCj4gcmVtb3ZpbmcgdGhlIG5vZGVfZmluZF9ieV9hZGRy
KHRhcmdldCkgY2hlY2sgYW5kIHRoaXMgd29ya3MgDQo+IGZpbmUuIE9idmlvdXNseSwgdGhhdCBv
bmx5IHdvcmtzIGZvciB0aGUgT25PZmYgbW9kZWwuIEknZCANCj4gaGFwcGlseSBzdWJtaXQgYSBw
YXRjaCBmb3IgdGhhdCBtb2RlbCwgYnV0IHRoYXQgZG9lc24ndCBzZWVtIA0KPiB0byBiZSBhIHZl
cnkgZ29vZCBnZW5lcmFsIHNvbHV0aW9uLg0KPiANCj4gU28gaXMgbWVzaGN0bCB0aGUgcmlnaHQg
KG9ubHkpIHRvb2wgdG8gdXNlIG9uIExpbnV4Pw0KPiBJcyB0aGVyZSBhIG5ld2VyIHRvb2wgdGhh
dCBpcyBwbGFubmVkIG9yIHVuZGVyIGRldmVsb3BtZW50Pw0KDQpTZWUgYWJvdmUsIGFuZCB1c2Ug
dGhlIHRpcCBvZiB0aGUgcmVwb3NpdG9yeSAoY3VycmVudGx5IGF0IHY1LjUzKQ0KDQo+IA0KPiBy
ZWdhcmRzLA0KPiBtaWtlDQo=
