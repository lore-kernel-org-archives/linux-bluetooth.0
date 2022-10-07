Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 08:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJGITD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 04:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJGITB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 04:19:01 -0400
X-Greylist: delayed 944 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Oct 2022 01:18:57 PDT
Received: from deltahqout.deltaww.com (deltahqout.deltaww.com [220.128.70.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D4FDB71
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 01:18:56 -0700 (PDT)
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6307313C101;
        Fri,  7 Oct 2022 16:03:09 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loytec.com;
        s=Delta2019; t=1665129789;
        bh=TKc3AckFDReKJgF40Kk/na9VOReUWWxXFwf3gWdCebc=; h=From:To:Date;
        b=RSjsc2PEeotVwC9uDTML0KUXLJeeSCVdY//KLKIoRCwc8XwHFD+De3B+vkM3HT4B0
         /KerT7mTLiclf8V9z3aR7/LRp2DjfK3Bh4dLd56VZ4JDUZHAMhVRhTRrMeYVk+ji6i
         sONeWRniwlZpW9FWpAEjnEW52CP5U+/amR0gZbLM=
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CBC613C0CE;
        Fri,  7 Oct 2022 16:03:09 +0800 (CST)
Received: from TWPJ1EXHYBRID03.delta.corp (unknown [10.145.157.227])
        by deltahqout.deltaww.com (Postfix) with ESMTPS;
        Fri,  7 Oct 2022 16:03:09 +0800 (CST)
Received: from TWTPEEXHYBRID02.delta.corp (10.136.157.226) by
 TWPJ1EXHYBRID03.delta.corp (10.145.157.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 7 Oct 2022 16:03:08 +0800
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.43) by
 TWTPEEXHYBRID02.delta.corp (10.136.157.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9
 via Frontend Transport; Fri, 7 Oct 2022 16:03:08 +0800
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::7) by
 GVAP278MB0793.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:56::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Fri, 7 Oct 2022 08:02:58 +0000
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7692:ca19:8bd0:928a]) by GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7692:ca19:8bd0:928a%3]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 08:02:57 +0000
From:   Isak Westin <karl.westin@loytec.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ 6/6] mesh: Fix msg cache ring buffer
Thread-Topic: [PATCH BlueZ 6/6] mesh: Fix msg cache ring buffer
Thread-Index: AQHY2ZRPfmT3xWAhHEazBYifoLHFc64B1psAgACvm1A=
Date:   Fri, 7 Oct 2022 08:02:57 +0000
Message-ID: <GV0P278MB01298A282E81CE90ECE12158955F9@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
References: <20221006145927.32731-1-isak.westin@loytec.com>
         <20221006145927.32731-7-isak.westin@loytec.com>
 <1431ea67c9b2146ee632d47503f0f666687df47d.camel@intel.com>
In-Reply-To: <1431ea67c9b2146ee632d47503f0f666687df47d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=loytec.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV0P278MB0129:EE_|GVAP278MB0793:EE_
x-ms-office365-filtering-correlation-id: a0524978-9452-4223-352f-08daa83a58d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZXMRvcQHiKTBVALhzVvLaqLnNoi8XCqiev4QA8GRhrRoNw6OefizChpOD50cbXxQoVWM213jis8RzI6zlylNiwZ5XPxgy8OVdSV+WtxIqPptzfM3MCRooRrpLiR05G97F0akMwj8veUC21lgEohP+m5X45IbqI40cmKvD6QHfALCJYbydHK1HPuGn4qvwYrmVNgxgktN4laYz1sxh3qJIjMQXc8VfETo3LFMvuY4Byy+fNjfnc2ekkasYcIEQyhvxoPQZVehLKXy/QW0DhJRj0Yxh07QVzQ3kRwPYFoBr9xVmCPXZqmlc+w+SJK09JezcbHVSkAjZC/FFsDYo3pYEy9zvOSgSo9UaSmd5Gb7L/S8D0QYptxdi22S6A2DN5csMkNFguQmYsqcsD788g4aKqG5ByOh0bO+2PqBpyKnkaURHnDxlOzS1jKZKAp+ABG9nd/i2vM3XQ5nZHDVhfH5lqAc3NHeMw+ID3pX3oUrfoRhmJTpp0YaBfLb1Z6IhsToRAt0l2ss13YBY3S2do5hv4R6eN6T5eGt5veHfdEF8HGAqYTiggCu+D3GXUmj0xN8KE4caLcJCngoDqniBBGp9UTiBqaiz7PjOH6lHjLwp4kdf+GKITUoLQelza2u71NIwxhDQIq2pSQpvwvhHsxprUSxNBqVoSWb7IgbhV+ASu6BY6TPj6GRMrFoKrMMtiE4GbeO3OfSePTULtWGYEJv2FM/fWLrOPobYPmdTqpruzFoJ/RTjO0uiLoh/mOAk06aC79ayELl3Usqx/EOfwvyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39850400004)(376002)(451199015)(86362001)(55016003)(44832011)(110136005)(2906002)(33656002)(316002)(478600001)(76116006)(7696005)(6506007)(26005)(52536014)(83380400001)(8936002)(122000001)(8676002)(66446008)(66946007)(38070700005)(66556008)(66476007)(64756008)(41300700001)(186003)(9686003)(38100700002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDZRRU03TEMxNlZqbjBNUUU2NzZKa3RtRGhjRmxmT1BUMFhYSGRuWkZsRUl1?=
 =?utf-8?B?cGRHdmE0a1dtSyt5SXpKS0tmNUwwL0UySXh0LzFxVzFzY1dLUHVkMzhvWlFU?=
 =?utf-8?B?U21RcW1hazJIWW1yUU05TDZ3NVgzOUVBTEJDOElZZVJkQXQrN3BobG04dTBz?=
 =?utf-8?B?RmRiRGpQcWdYOEcxOE1FRHRYbHU3L1AyaTNMZ1NMSXhjNGRNN0xSSHFaQkxQ?=
 =?utf-8?B?QzVRNmwraEF0WENxRjloT2t4SDRDQ1Bic0w5elh3ZUZ5cE44QzA1QjRkemUx?=
 =?utf-8?B?ZmJoamxEZ1VMbHJwR0JUcW9MYkM0U0poQkpyYUpqcWE5V3I1VTVMYTNQV1Bi?=
 =?utf-8?B?T0lvRk9Pb3VWYXVWNDAxd2JpMTkrbURveVB3K3hSSTRFRTlpZnM1Nk1la3p6?=
 =?utf-8?B?TnRIK1AzQ3ZtbUtnMkJEeXVOak9RSm5NdnM1YUJMVDN5QVp4aUM4ZERCako0?=
 =?utf-8?B?czBzVkxmejc1c0Y0bUN5YllKYVA1TDgxT2RTT21Ba2hnOStuVHZ0elFRMkg2?=
 =?utf-8?B?U0JOU1Z6b09PeGtjd2FhRzFsa0xNRlp3c20vYlRpM1NGZ0lKUlFWSHpsSlFU?=
 =?utf-8?B?THVPQnNGMENWbGw4MFdQM0xhdkFpbFVTV0FFWUwzVHdLWmFGbGRlRzF0emZl?=
 =?utf-8?B?c3YyTEZPZnkyT2RpbTVjcUJVdzhZV0pxcXQ1WkMzSGlpa0JEWEJncnVSVFEz?=
 =?utf-8?B?enZJWUEyYTVOREVwbXJBQlhtUzFndldYVEprbmY2R0VVcHRvNGZBRnN4QXQw?=
 =?utf-8?B?ckZrSHNhMzFJb2lOZG1tNlBQV3VseHorVTBaa24xMmJMUUxxYTg2bGlXa2t2?=
 =?utf-8?B?cEZZc2VySEx3SmJEelIxcGxmN1BhR3UrdExUUnRRQnlwQXROWTZLVEJDNVFj?=
 =?utf-8?B?dnZIWTUrTjJLYWVmQzJVcUlPQWwzZDZORVk0TVFuS1FDa2huSWg0MlJSUloy?=
 =?utf-8?B?aVI2RjV3ZFJleEx4ZTh1bzBERWdQVlpSZ0o5OVRCSU1lVUpCRlkvemhKdlNW?=
 =?utf-8?B?UVA2SHJvWDNVUjFyeUd0WmliNHZ1N1prbkwzekRkT1Fqc2FOZEJGRnM1ci9S?=
 =?utf-8?B?enpiNEhIaGdELzAvR1diZ2NvUlU0RitzSDNVM05zRUdOSzBvMllEbW9vWHhK?=
 =?utf-8?B?K1R3SXd2Nzc1SXZhV1JrTDEyZmNoTnhqN1RGWkZkdXdmTHY4bUhQeFp4Q0lw?=
 =?utf-8?B?NkR6bXhGT000Ym5URnFaSktsY0djQk95cEVCRHV6U29CTzFsT1pZZ0VIYVlI?=
 =?utf-8?B?NDJuTWVMWVpYODVSRjVTU01rdEswV3NDM1hjS3h6SzVraWgyNFNWMnBRU1Zy?=
 =?utf-8?B?Z1NqZmxyNTFvcmRtYkw5MjJFM2VIT0JVTW5iKy9rSG5JYjU0U0pkRmNsTDlB?=
 =?utf-8?B?dEwwdWRZU3NkYVZDV1FSeWFucXI5N09JRWNsVmNTVDBhN01zRVNLMnhKZGFk?=
 =?utf-8?B?ZGxPVFhwZGJOWUU3cWxkWnB6dUZBck9wWFVlWTlyczloc285WmVpZUpqZGZZ?=
 =?utf-8?B?Zk9kUElwZVpLMnZWMFRtOWpOWld0Zld4L2RMWEY4bmVUYlMxRHk3K3ZnaEV1?=
 =?utf-8?B?YTRmemR0UnpaQkVGYkpucDIyRjVRVVk4MmphN0dPMTZLQlJySjdjcmNtUkNl?=
 =?utf-8?B?blBES3dBYkdrTEJ4WGk2ai9QcGlCMnVSM3M0bHFmOUptNys4VC9VV2YrZmx2?=
 =?utf-8?B?aWVKOEZXZ0NJa2NORUxmNzBweml0TnVSVGJVbk9mMXdJQ1M2WmlEQ2NpYzNE?=
 =?utf-8?B?WWdwR2h3TWhiRUlzQ2h5enJnVU5DOEZ1YklTb245VEFVWS9lMDgzMDZvRVQz?=
 =?utf-8?B?RWQ5M1djU3BOQTJ4ZDJ1Q0xaUHprZnlkbTBOdjZuQmcvZ1luakVOL2R2eEVw?=
 =?utf-8?B?YTY1amFia0UxSVF0S1JSZXFZSmFHTTNHYzltYm9YMnR5ZWlpTlNxODhMYlIy?=
 =?utf-8?B?SURuT04yU0puVDFIWURRL01jVVQ2UDBSZG5JVjl6ek9uQVAxcU1kaFpJdFJV?=
 =?utf-8?B?WXdIYW1xZndOTVlUQ2lxOXVUMnExMW1yQWJlc0Jxakd1bVNQU0taVTIvNnkr?=
 =?utf-8?B?N3dKaHVOWnQraGZLcVMrUnFjelZCSXRHNStkQ2FLNVVDSmpaZXFiUE9Fbm5v?=
 =?utf-8?Q?IXFNy6fl+LOlgjVpL5ZpJxhU5?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9eamfTLOmx2hj2RXqodNTrIbZkHTQXCHWoSFMfMJ1jRKTsfa63hrRwZkSkbeV1FaufPkoAXNFTD2kVBrNcg3gVkoQX+LWuYtRHl1Wf6gbGMOv6oxsktD+2lzwQheRYxG4Ll1yav9UTVg+2GpM4F2O9pHFlkbvKzm53VZshJ3wDJFVgrCcMYIAKSN5qvkFtuMbOKaUcWwTcmyhONgdAhqdKbYbP/BxI+/pQ5XQ0Hay7CDLfH7lz8KVIktElX4ea+kX+wfHoDCYapqeEutIRl7OmdSniUXISc32ekeZjB6lQu9h9t2QVPAmsxEPMdHUoVtsyZoDlL6KAETICPhq1yLg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDSFGu6i6NpmAHkErmlAqG3hJ7pvG24CFXylK6SsYfI=;
 b=de7ZazsATGZ5J9RD9c/Rujitt4So6iVVY2snm3bsZ44wgNbKU/yOgU6Hi47VH5eMer5gjYkjiwl9bDhHWFPbNApguTG9zh66bh/or3s6nX9U55BOkFXNRR/OtYXR97xxJTuFauPPinqn2ha3HgtclgkZahnfJuK4S3gtfZmgRnysbOwF6tbxIwKsV99WcqtdrJD3n0g8HkybNDENky7hy348C9vJovfcqVddJngUj5mCXW+jwyr9RiYKghDAiuUR+k71XpMcvADSdB1JndLjDmppDUsADDCMved8JaE9lg/Reeu8WABdhq4ChpLGVsZk7sk96+7MdXiPXry3qePRoQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=loytec.com; dmarc=pass action=none header.from=loytec.com;
 dkim=pass header.d=loytec.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
x-ms-exchange-crosstenant-network-message-id: a0524978-9452-4223-352f-08daa83a58d5
x-ms-exchange-crosstenant-originalarrivaltime: 07 Oct 2022 08:02:57.7815 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 19f25823-17ff-421f-ad4e-8fed035aedda
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: RPkG/BvFD7MQeCOJo8wctlTLZPm4Vg70N1mogA4wYR9yeZxE1InLkB90Vlq7QDhgj1/aFsd4iSOBGh0qlDNWmw==
x-ms-exchange-transport-crosstenantheadersstamped: GVAP278MB0793
x-originatororg: loytec.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.2116-9.0.0.1002-27186.006
X-TM-AS-Result: No--11.739-7.0-31-10
X-imss-scan-details: No--11.739-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.2116-9.0.1002-27186.006
X-TMASE-Result: 10--11.738600-10.000000
X-TMASE-MatchedRID: nVQUmLJJeyY4HKI/yaqRm65i3jK3KDOofjJOgArMOCY1Y73PdzvXZALV
        L/qx/ph4XoyZmORsN2WaernOJKdgiC/7QU2czuUNA9lly13c/gEYR+gKWoGXzjb9TB28UbkiJf5
        otvavOZe1h3Ci3ttLrTyeS5IKVRbvJVWqk0NljVw6N/cDgNNi4X0tCKdnhB58pTwPRvSoXL0ir3
        kOMJmHTB9GgLAHOBFiIAcCikR3vq/QdfmJIQu21/V3MraN8pcCMtiCYZfVO+OdeCjilw8VwBbbb
        ndhioVR
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQnJpYW4sDQoNCj4gSGkgSXNhaywNCj4NCj4gT24gVGh1LCAyMDIyLTEwLTA2IGF0IDE2OjU5
ICswMjAwLCBJc2FrIFdlc3RpbiB3cm90ZToNCj4gPiBUaGUgbWVzc2FnZSBjYWNoZSBzaG91bGQg
YmUgYSBzdHJpY3QgcmluZyBidWZmZXIsIHN1cHByZXNzZWQgbWVzc2FnZQ0KPiA+IHNob3VsZCBu
b3QgbW92ZSB0byB0aGUgZnJvbnQgb2YgdGhlIHF1ZXVlLg0KPiA+IC0tLQ0KPiA+ICBtZXNoL25l
dC5jIHwgMyArLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+
ID4gaW5kZXggZTk1YWU1MTE0Li44YmU0NWU2MWEgMTAwNjQ0DQo+ID4gLS0tIGEvbWVzaC9uZXQu
Yw0KPiA+ICsrKyBiL21lc2gvbmV0LmMNCj4gPiBAQCAtMTAyOCwxMiArMTAyOCwxMSBAQCBzdGF0
aWMgYm9vbCBtc2dfaW5fY2FjaGUoc3RydWN0IG1lc2hfbmV0ICpuZXQsDQo+ID4gdWludDE2X3Qg
c3JjLCB1aW50MzJfdCBzZXEsDQo+ID4gICAgICAgICAgICAgICAgIC5taWMgPSBtaWMsDQo+ID4g
ICAgICAgICB9Ow0KPiA+DQo+ID4gLSAgICAgICBtc2cgPSBsX3F1ZXVlX3JlbW92ZV9pZihuZXQt
Pm1zZ19jYWNoZSwgbWF0Y2hfY2FjaGUsICZ0c3QpOw0KPiA+ICsgICAgICAgbXNnID0gbF9xdWV1
ZV9maW5kKG5ldC0+bXNnX2NhY2hlLCBtYXRjaF9jYWNoZSwgJnRzdCk7DQo+ID4NCj4gPiAgICAg
ICAgIGlmIChtc2cpIHsNCj4gPiAgICAgICAgICAgICAgICAgbF9kZWJ1ZygiU3VwcmVzc2luZyBk
dXBsaWNhdGUgJTQuNHggKyAlNi42eCArICU4Ljh4IiwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNyYywgc2VxLA0KPiA+IG1pYyk7
DQo+ID4gLSAgICAgICAgICAgICAgIGxfcXVldWVfcHVzaF9oZWFkKG5ldC0+bXNnX2NhY2hlLCBt
c2cpOw0KPg0KPiBUaGUgcHVycG9zZSBvZiB0aGlzIGJpdCBvZiBjb2RlIHdhcyB0byBtYWludGFp
biBhIGNhY2hlIG9mIHRoZSBYIG1vc3QgcmVjZW50bHkNCj4gcmVjZWl2ZWQgcGFja2V0cyBpbiB0
aGUgb3JkZXIgbW9zdCByZWNlbnRseSBzZWVuLCB3aGljaCB3YXMgd2h5IHRoZSByZS1vcmRlcmlu
Zw0KPiB0b29rIHBsYWNlLiBXYXMgdGhpcyBjYXVzaW5nIGluY29ycmVjdCBiZWhhdmlvciwgb3Ig
YXJlIHlvdSBkb2luZyB0aGlzIGFzIGENCj4gc3RyZWFtbGluZT8NCg0KUFRTIGlzIHRlc3Rpbmcg
c3BlY2lmaWNhbGx5IHRoYXQgdGhlIG1lc3NhZ2UgY2FjaGUgaXMgYSByaW5nIGJ1ZmZlciAoaW4g
dGVzdA0KTUVTSC9OT0RFL1JMWS9CVi0wMi1DKS4NCg0KVGhlIHRlc3QgZ29lcyBsaWtlIHRoaXMg
KHNwZWNpZmllZCBjYWNoZSBzaXplID0gNCk6DQoNClNlbmQgbXNnIDEgICAgICA8LS0gcmVsYXkg
ZXhwZWN0ZWQNClNlbmQgbXNnIDIgICAgICA8LS0gcmVsYXkgZXhwZWN0ZWQNClNlbmQgbXNnIDMg
ICAgICA8LS0gcmVsYXkgZXhwZWN0ZWQNClNlbmQgbXNnIDQgICAgICA8LS0gcmVsYXkgZXhwZWN0
ZWQNClNlbmQgbXNnIDEgICAgICA8LS0gcmVsYXkgKm5vdCogZXhwZWN0ZWQNClNlbmQgbXNnIDUg
ICAgICA8LS0gcmVsYXkgZXhwZWN0ZWQNClNlbmQgbXNnIDEgICAgICA8LS0gcmVsYXkgZXhwZWN0
ZWQNCg0KU28gdGhlIHRlc3QgZmFpbGVkIHdpdGggY3VycmVudCBiZWhhdmlvdXIuIFRoYXQgaXMg
aG93ZXZlciB0aGUgb25seSByZWFzb24gZm9yIHRoZSBwYXRjaC4NCg0KPg0KPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPg0KPg0K
