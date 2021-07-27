Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2FAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A755861B2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 15:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhG0PQu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 11:16:50 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41742 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232633AbhG0PQt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 11:16:49 -0400
X-UUID: 7b753a97c2f44459a2aceedf8c0b41e2-20210727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kKp4E5fNqERokbvf7fSPQzBB0OGUsAb35WQ+YvKITjo=;
        b=G/9UsajJpqwigZfBDwNAHqNbgjzv2pyJmXFUXdXGy+9z3uevhsExBq3QiCFXEIH8u+Pk9igDbR5TOxq+b9sF5NJ04KN6aZ+XAmn/JK8tnRJQdPtLXFIetlw8+uPz7/tliojwMENZFhpg3PcdwLXt3b9biXouwM2Tb7wIDNoO1HA=;
X-UUID: 7b753a97c2f44459a2aceedf8c0b41e2-20210727
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-yw.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1114168676; Tue, 27 Jul 2021 23:16:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkexhb01.mediatek.inc (172.21.101.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 23:16:44 +0800
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Jul 2021 23:16:43 +0800
Received: from SL2PR03MB4457.apcprd03.prod.outlook.com (2603:1096:100:5b::16)
 by SL2PR03MB4524.apcprd03.prod.outlook.com (2603:1096:100:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7; Tue, 27 Jul
 2021 15:16:26 +0000
Received: from SL2PR03MB4457.apcprd03.prod.outlook.com
 ([fe80::bdf4:3ce1:6db4:20ef]) by SL2PR03MB4457.apcprd03.prod.outlook.com
 ([fe80::bdf4:3ce1:6db4:20ef%4]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 15:16:25 +0000
From:   =?big5?B?TWFyay1ZVyBDaGVuICizr7StpOUp?= <Mark-YW.Chen@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        =?big5?B?Q2hyaXMgTHUgKLOwuFiqbCk=?= <Chris.Lu@mediatek.com>,
        =?big5?B?V2lsbC1DWSBMZWUgKKf1rEa/byk=?= <Will-CY.Lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "michaelfsun@google.com" <michaelfsun@google.com>,
        "shawnku@google.com" <shawnku@google.com>,
        "jemele@google.com" <jemele@google.com>,
        "apusaka@google.com" <apusaka@google.com>
Subject: RE: [PATCH v4 2/2] Bluetooth: btusb: Support Bluetooth Reset for
 Mediatek Chip(MT7921)
Thread-Topic: [PATCH v4 2/2] Bluetooth: btusb: Support Bluetooth Reset for
 Mediatek Chip(MT7921)
Thread-Index: AQHXbrFRiFNYeJTB8EePMzyodx1EaKtOoUkAgAeyTdA=
Date:   Tue, 27 Jul 2021 15:16:25 +0000
Message-ID: <SL2PR03MB4457B4B5FFE8A3A7529D08BFB3E99@SL2PR03MB4457.apcprd03.prod.outlook.com>
References: <20210701194243.5449-1-mark-yw.chen@mediatek.com>
 <20210701194243.5449-2-mark-yw.chen@mediatek.com>
 <0FDB7895-4ABF-4975-AF61-FCFA86597254@holtmann.org>
In-Reply-To: <0FDB7895-4ABF-4975-AF61-FCFA86597254@holtmann.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMTM2NzhcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05Njk5NzU2MC1lZWVkLTExZWItOTFhNy0yY2YwNWQ0NmQzNzBcYW1lLXRlc3RcOTY5OTc1NjEtZWVlZC0xMWViLTkxYTctMmNmMDVkNDZkMzcwYm9keS50eHQiIHN6PSIyODY2IiB0PSIxMzI3MTg3MjU4Mzg0ODE4MzUiIGg9ImkrZHZMdVltOHF1a0hZRzlpd2tjRlVrR0hrUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a65bf35b-5b24-4421-98fd-08d95111804d
x-ms-traffictypediagnostic: SL2PR03MB4524:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SL2PR03MB4524D12833CE942C84A4A05AB3E99@SL2PR03MB4524.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cBNWFkeib9hrF4FHRe0AJYd6ig2ZgGEYvKkXaZMePXSPwUdarUuL9yvhDrM+glsuFyVyO2xwJX5PoMctDo4mZ32U17GtTA251VwzNMViNGObJjisXGTMXtttNHV5PUKRLuL5oX5VhOQhzjVl6LZRI/dJZ08d+yUs4qCnPMYkTHVktJOtU0GCEN2un7a8BwxEgfJw4mGG9gujzBABCLg0qkx5KY25W65Tzrw/xs9pgDV9xXJgzcvAyNPTUT1vjHa0m1ypqFiH3qmK7oIviSoJfRFK8d5CLx+R/gEGHhspDmBFGs7g26NC6D0Az8fG/shw+Liyjo5tSxRHw/NwkgZMRgHd3GEhctBXQGvpfCMcEC+8V1fLtTouPrO+RbxDU23KhdmbakW3Oib5KXbADnQAEobBo45jQzq5mgLzRIw2WPF32Wub5SpQ7IxisjyzUIMdll83WlJQ/g0rPyzVVQz9fkl21JQ6ahWSk/hjKcLFXL/gkQiQSrV7v1KRr3UvclntRBFxO7X0NzP+SC2CbqMKs3xrV5JJr6sMg3+SAXkJJp6Iqll+/21f9GSJ5DreiheHAbrPZ6kuF5iKBT3v0Y2F9ck4YUrn8TlAuPLncUkIQ/0D2tE2aje5P17lHepMUe3CcCoDVxSzzKOq+USn8rTLfSuLgN3EsJeVxnq7XrYt/Mxr3AU4487j43443OeyBD5Wm/qfeSE8la0s0oRZz9A59A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4457.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(53546011)(9686003)(76116006)(64756008)(66476007)(66946007)(316002)(71200400001)(6506007)(66446008)(55016002)(66556008)(186003)(52536014)(2906002)(38100700002)(33656002)(122000001)(8936002)(6916009)(8676002)(4326008)(54906003)(83380400001)(7696005)(508600001)(86362001)(5660300002)(85182001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?SDNaRUdTZi9WeGxydGZZSTl5bE5KVDlYdG5CY2ltbjJ6ZE02K2ZSMFdzdnRaTlVv?=
 =?big5?B?eDVJN29PUFgzT1B3TGEyWDFIUjZjQTdyVndsUThKczRxaWN6cis2dEJZTEFHOCt6?=
 =?big5?B?Wnp3Y3NlaVJXQUUwYi9YdWxPQU9UU3QxTWNHSkxHTjRQdXVQbHNqeGFrbTFHb1Jx?=
 =?big5?B?WHh2V1J0ZXp0cURxWWQ4MjlSUll1ZUUyUDNHMVpaM3hSOWlYYzMxbE50UlRpOUg2?=
 =?big5?B?YWdGY1JkbHoxcE40L2JrUU1mKzlOR1dITGtmaE13VC9LdEhZT2NoK1R5U0JWYm9U?=
 =?big5?B?MXNZcHZMNkJuQXVkcjF6WVlPcWV0YjcwQjJyQVZ2TlZPQ2xLS2Jnc3U4dXNjNmls?=
 =?big5?B?cTloYzVMN1d5cG9JUDNqNlFDNHdYZjU4NWZSLys5YmVoTFJCa2c4Sld0eVpNQ0M1?=
 =?big5?B?UU0xbHVta1ZnYjVWQTNXM3ZqaStTbEp1TkUwc1lHYnZYbjFUcUxldVlYRGljTjlW?=
 =?big5?B?Wlo2bmVLTGhLeWMycEVyNDA3Sm1EeVpwMHI3Ukl5M1lWQWNaNnppaFpNTFVmZEVm?=
 =?big5?B?dVJsenhFY3luZ0FmNGs0U2VWSXdhRWd2UVdqMTFRVzBleTNpVUlDZk1iMG5hMnZK?=
 =?big5?B?M0JjczA0YTExNjN1V1owWUhvKzRvbW10Q2tPYjRrWHMwY0VuSnRGUnltNDVwZlNX?=
 =?big5?B?ZUNBVVMvTUpVRGpnMXRGUGFWa1dnaHNWRHFNeGVHc0xIYkd2OStUSmhQUW9zUWZU?=
 =?big5?B?cDVGRUJsN243RG9IOS83WkF3RmFOalBTeC8wWUxIWWRhTkxyaDFhOWJ0NjgwR1da?=
 =?big5?B?SGUzTGlJcmVTaHVBTC9LaDk3OER1eGd0OGlzcklqYU42OVFaQkZtcGN5VEprVEhF?=
 =?big5?B?SzhhbzUwaU1La0ZjS1pxZWxwTmhmWENqeS91cXVvaURkNURmOTFWRzNueE1aQWs1?=
 =?big5?B?NnVXakxraEg1R0JiSUdZbzgzYmJUQ1J5dWt2UGJpMVMzUW0xNnE1eUdDUlYwbXpL?=
 =?big5?B?VGJYTjZSZXIzR2s4T0x1ZU91blIwUzF6MUpEMmFSUU9YRGg0b2VQVTFDaVQ0Z2xT?=
 =?big5?B?c0VIUnpudXE0R1ZpTDdnTURuTXEvTFl1cExpLytEd0VKUitFNERjaHN6L2hGT2JL?=
 =?big5?B?ZW1SYVZTQlVpZkdJdWZPaGpRWUJVQTVIVFlIdk0vMnIzVk9mZ3QzT2h6b2ZPZERj?=
 =?big5?B?WXBhZk5rQlpyYTU1UHVScTcrZ3NldnUrWmpkSW1rTFNKWWFNUDRQLzBJVEJaajBk?=
 =?big5?B?dm1zMlNxTjFMVlduZWdxZWlSc2Rmc2c4a01oWnlCeW1ubFo0eHEraStQNXYvcGEw?=
 =?big5?B?aHJRcWF4aU9aV1dBZkczL1VXR004UlhvY0x6VElvVjdjQTkzTFFYVU03eFFVcHpt?=
 =?big5?B?b09aMElzbVpua2pUQkt3OEpjR1pxbXY2eExCcHRkb2lOYnMwN28zelZMdFVWRUNF?=
 =?big5?B?ZCtZdDNTMmhVVXdFKzdWTFNkYVRSVVFoRDY4M1J4bkM2dUhHSkVWTHptZ0JnODQw?=
 =?big5?B?TFJoUXplZkdkRnlLcDFZVE1mNXZNUWxkalVlaDY4Z3BRR3VsWmlKOTZ0Y0ZxbE10?=
 =?big5?B?UzlWam54Rk9CNVY4eitmRWMzSGhnOUVaeUN4U2pTUTUxUm93RU00dE1tcUM0WGNX?=
 =?big5?B?WVptbW04K3RvWUhxdFQxSmNUeGRvTjNnQWxIdVduZTdnSkh0TW5hUzhJdHlRaTVy?=
 =?big5?Q?eS/xV9YGRYYNJd7ipLjUdJMfqOk=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdjugCmybZ5nfmXhFiE9vRr7yB3caaO1+vznUHuxR1z92ttzXFbgL3IKyY+jDx5PbXDWJEIJxADF+n68tfVQ+nZohqGiHBAx7Adv2qVPEnAmymAL+bZ1Q3lZf/p70zzJjB/tEBaYTK0RiWjBvysv4k4XMi8PlLAWvwhzxeaA/ui6uP5r+a90QjHbW+RfphT+xJDne6GD8VO6jE/X7j2aCHGg16IttT7k1EshQ6cUw0uTqdUObP3vyUjDyVxJCk3WuFIor+x/sQ4hOvnqRwNVeUJ5NchpK7DENAxYd27fSaMax52Gf50UCBridlG+6Gm1TERPa+sKLltavzUV+xh4vA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTFQJuQWVggBP05HhvC5SBL+rQRMB6SrO9YxJRVxEf4=;
 b=ZqQTD2bzy84EmdWEsUR2TOivKeSDjB962DLMsHrq5gWZC7/HJNMbxKGF5UEwvF86zjDC+52PdRfAptYMp74Lu6ZldaGQNR1UWLBABDVVxqV67grWFjorc2mBY8ul8EI06sRwC/omGzM8Tcq0s8Wvs2dDu+FY5mVAHZsUI+5OcoshJOtKUMlcYyROjp0F64pPSGRYUHIOg5lPqdWmNcuPzJSXlZBxYjJH8mo45w/EsbpdUlZLho5plSIXa6KoeRrH9lxvw/0iHShY9BVvMjAFnWmx//7Ogie8tai3Vz66fAXPkcfAJsiPn8+nqgFScXy/PGjAXOI8fZ6GB9Qo17Dh+A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTFQJuQWVggBP05HhvC5SBL+rQRMB6SrO9YxJRVxEf4=;
 b=CfVIf9ETw4e9eWtjvNlB96lTYzcJIRA5B1xnypOi6Zc0vF19HTeXHV73Cmiy4hxjZ8pNyLtmvcHCo6rrEg4MDe4r2g5aBXoPRdYD39Pz90dLKr8XW//B0FELNtg8pc2Mkz7G410WatssEn2BkmAV0fGVpD/uOveNb7I+PlXdmTA=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SL2PR03MB4457.apcprd03.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: a65bf35b-5b24-4421-98fd-08d95111804d
x-ms-exchange-crosstenant-originalarrivaltime: 27 Jul 2021 15:16:25.6609 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: rWke255T0D5ZfcpgEAIh0bAvk6O/Uh0OMTFI+oux1V1o4oqXKD7bHSrQkNLOyZSjSBbiyqHu4c8h/C/KzYlGHNVRdlvnx0pRcnlUdV7Xv2A=
x-ms-exchange-transport-crosstenantheadersstamped: SL2PR03MB4524
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+IEFuZCB3ZSBuZWVkIHRvIHdvcmsgdG93YXJkcyBhYnN0cmFjdGluZyB0
aGUgdmVuZG9yIHNwZWNpZmljIHBvc2l0aW9uIG91dCBvZiBidHVzYi5jIChhbmQgSSBpbmNsdWRl
IHRoZSBJbnRlbCBwYXJ0IGhlcmUgYXMgd2VsbCkuIFRoZSBidHVzYi5jIGlzIGdldHRpbmcgb3Zl
cmxvYWRlZCB3aXRoIHZlbmRvciBzdHVmZi4NCkkgYWdyZWUgd2l0aCB5b3VyIGNvbW1lbnQsIFRo
ZSB2ZW5kb3Igc2hvdWxkIGNyZWF0ZSB0aGUgdmVuZG9yLmMgZm9yIHRoZWlyIHNwZWNpZmljIGJl
aGF2aW9yLg0KDQpGaXJzdCwgSSBhZGQgdGhlIHByZWZpeCBpbnRvIHRoZXNlIHBhdGNoZXMuDQpB
ZnRlciB0aGVzZSBwYXRjaGVzIG1lcmdlZCwgd2Ugd2lsbCBjcmVhdGUgdGhlIGJ0bXRrLmMgdG8g
aGFuZGxlIE1lZGlhdGVrIHN0dWZmLg0KDQpXaXRoIGJlc3QgcmVnYXJkcywNCk1hcmsNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1hcmNlbCBIb2x0bWFubiBbbWFpbHRvOm1h
cmNlbEBob2x0bWFubi5vcmddDQpTZW50OiBUaHVyc2RheSwgSnVseSAyMiwgMjAyMSAxMDowNCBQ
TQ0KVG86IE1hcmstWVcgQ2hlbiAos6+0raTlKQ0KQ2M6IEpvaGFuIEhlZGJlcmc7IENocmlzIEx1
ICizsLhYqmwpOyBXaWxsLUNZIExlZSAop/WsRr9vKTsgU2VhbiBXYW5nOyBCbHVldG9vdGggS2Vy
bmVsIE1haWxpbmcgTGlzdDsgbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgb3Bl
biBsaXN0OyBtaWNoYWVsZnN1bkBnb29nbGUuY29tOyBzaGF3bmt1QGdvb2dsZS5jb207IGplbWVs
ZUBnb29nbGUuY29tOyBhcHVzYWthQGdvb2dsZS5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQg
Mi8yXSBCbHVldG9vdGg6IGJ0dXNiOiBTdXBwb3J0IEJsdWV0b290aCBSZXNldCBmb3IgTWVkaWF0
ZWsgQ2hpcChNVDc5MjEpDQoNCkhpIE1hcmssDQoNCj4gV2hlbiB0aGUgZmlybXdhcmUgaGFuZyBv
ciBjb21tYW5kIG5vIHJlc3BvbnNlLCBkcml2ZXIgY2FuIHJlc2V0IHRoZQ0KPiBibHVldG9vdGgg
bWN1IHZpYSBVU0IgdG8gcmVjb3ZlcnkgaXQuIFRoZSByZXNldCBzdGVwcyBhcyBmb2xsb3dzLg0K
Pg0KPiAxLiBDYW5jZWwgVVNCIHRyYW5zZmVyIHJlcXVlc3RzIGJlZm9yZSByZXNldC4NCj4gMi4g
SXQgdXNlIHNwZWljaWZpYyBVU0IgSFcgUmVnaXN0ZXIgdG8gcmVzZXQgQmx1ZXRvb3RoIE1DVSwg
YXQgdGhlDQo+ICAgc2FtZSB0aW1lLCB0aGUgVVNCIEVuZHBvaW50MCBzdGlsbCBrZWVwIGFsaXZl
Lg0KPiAzLiBQb2xsIHRoZSBVU0IgSFcgcmVnaXN0ZXIgdW50aWwgcmVzZXQgaXMgY29tcGxldGVk
IGJ5IEVuZHBvaW50MC4NCj4gNC4gVG8gcmVjb3ZlcnkgdW5leHBlY3RlZCBVU0Igc3RhdGUgYW5k
IGJlaGF2aW9yIGR1cmluZyByZXNldHRpbmcgdGhlDQo+ICAgQmx1ZXRvb3RoIE1DVSwgdGhlIGRy
aXZlciBuZWVkIHRvIHJlc2V0IHRoZSBVU0IgZGV2aWNlIGZvciBNVDc5MjEuDQo+IDUuIEFmdGVy
IHRoZSByZXNldCBpcyBjb21wbGV0ZWQsIHRoZSBCbHVldG9vdGggTUNVIG5lZWQgdG8gcmUtc2V0
dXAsDQo+ICAgc3VjaCBhcyBkb3dubG9hZCBwYXRjaCwgcG93ZXItb24gc2VxdWVuY2UgYW5kIGV0
Yy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogbWFyay15dy5jaGVuIDxtYXJrLXl3LmNoZW5AbWVkaWF0
ZWsuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDEyNyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMTI3IGlu
c2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMg
Yi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQo+IGluZGV4IGIxMjQ5YjY2NDk4MS4uMTIyYTky
OGViY2I1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQo+ICsrKyBi
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gQEAgLTMwNzYsNiArMzA3NiwxNyBAQCBzdGF0
aWMgaW50IGJ0dXNiX3NodXRkb3duX2ludGVsX25ldyhzdHJ1Y3QgaGNpX2RldiAqaGRldikNCj4g
ICAgICAgcmV0dXJuIDA7DQo+IH0NCj4NCj4gKy8qIFVIVyBDUiBtYXBwaW5nICovDQo+ICsjZGVm
aW5lIEJUX01JU0MgICAgICAgICAgICAgICAgICAgICAgMHg3MDAwMjUxMA0KPiArI2RlZmluZSBC
VF9TVUJTWVNfUlNUICAgICAgICAgICAgICAgIDB4NzAwMDI2MTANCj4gKyNkZWZpbmUgVURNQV9J
TlRfU1RBX0JUICAgICAgICAgICAgICAweDc0MDAwMDI0DQo+ICsjZGVmaW5lIFVETUFfSU5UX1NU
QV9CVDEgICAgIDB4NzQwMDAzMDgNCj4gKyNkZWZpbmUgQlRfV0RUX1NUQVRVUyAgICAgICAgICAg
ICAgICAweDc0MDAwM0EwDQo+ICsjZGVmaW5lIEVQX1JTVF9PUFQgICAgICAgICAgIDB4NzQwMTE4
OTANCj4gKyNkZWZpbmUgRVBfUlNUX0lOX09VVF9PUFQgICAgMHgwMDAxMDAwMQ0KPiArI2RlZmlu
ZSBCVF9SU1RfRE9ORSAgICAgICAgICAweDAwMDAwMTAwDQo+ICsjZGVmaW5lIEJUX1JFU0VUX1dB
SVRfTVMgICAgIDEwMA0KPiArI2RlZmluZSBCVF9SRVNFVF9OVU1fVFJJRVMgICAxMA0KDQp5b3Ug
bmVlZCB0byBwcmVmaXggdGhlc2Ugd2l0aCBNVEsgc2luY2Ugb3RoZXJ3aXNlIHdlIGdldCBjb25m
dXNlZC4NCg0KQW5kIHdlIG5lZWQgdG8gd29yayB0b3dhcmRzIGFic3RyYWN0aW5nIHRoZSB2ZW5k
b3Igc3BlY2lmaWMgcG9zaXRpb24gb3V0IG9mIGJ0dXNiLmMgKGFuZCBJIGluY2x1ZGUgdGhlIElu
dGVsIHBhcnQgaGVyZSBhcyB3ZWxsKS4gVGhlIGJ0dXNiLmMgaXMgZ2V0dGluZyBvdmVybG9hZGVk
IHdpdGggdmVuZG9yIHN0dWZmLg0KDQpSZWdhcmRzDQoNCk1hcmNlbA0KDQo=
