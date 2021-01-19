Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD5EC2BA11
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C5720776
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392321AbhASSKR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 13:10:17 -0500
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:30433
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391577AbhASSJm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 13:09:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msLDPY33ty0cQ9brvNN+PRGGAvt2CrHRSIWJZr9pW3F2bw5yg8VutzsO45KwWkLF5rFFKm0Qq70WaVrH+lEg0dUpPAlrM7tkAbvjelUmD3LsfOBNWCVakdbOOCnEuZp4mKy0VjtjypiY/875SXC3N7zA/fxI3P1x1yhiWttpRYyDHncDuAZjm6Z8Ly7HsIMt80msHgpwSSy73/aUXi1UazjxeId9AWfnKn+7gnBdmFCx+Yz56aUyrLtXl6RlF0ABJbmK+LovY3QoFfqawWzPalcS8mZdCwe8nerOsHtr9dTy8jzklXYkBo4rTKahBobIpULbKbu147oXhRtbCwxHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//SlHxvQGc9W37PRVRcWieMDyd6gXfw4sYuI33eX0EU=;
 b=gXSe8XWp49PTBOXbF6/gzd+PsnB8faX6ezLLYJLiRv+Yhtgv0nb1bbl0cHz8OG17WDiMDZqjDP/jKumvIV2SHm0c2cen1ve6Y6wBF+aP27RBZxGrAzOu55c9VNASahaqzXHq8HJnWPAW9LzmAGt0GP2vCmdsSqDvHYDRaZ/jp1v7aYej/8AL8JzSe1Dwfqo1Nf/neuTi3UJkMzKuEzNm0D4A+ARAe6jWgBBEa01gfXJjGhUsHFxcHqWMHGduGLbS1WbV6sHCumEYowXI9kY2loss/uHCw05stRsAoApNg88q6ie/6gE3y1aCBzDeCKFX7bVeYKBytbmkd/2uCzCUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//SlHxvQGc9W37PRVRcWieMDyd6gXfw4sYuI33eX0EU=;
 b=TpChI6ARYxMyvC9xAsGMN+XI8NFc0wxX0TFJPBTjOWDSbEjpfAdSbCEfeuLiwfoNnj9zx6FrBlalaoYJ92Dhm1YpDyEKf8tmteVDJBB/iRWFtX35OgqM47TFluX+dOtTqLRVWSAE+rf9HGkL7VGzZhGH0X40bqnu/u1Dwf3V0jc=
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) by CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 19 Jan
 2021 18:08:44 +0000
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::fcfe:f4e4:1d73:6d79]) by CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::fcfe:f4e4:1d73:6d79%5]) with mapi id 15.20.3784.011; Tue, 19 Jan 2021
 18:08:44 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: "Always fallback to alt 1 for WBS" patch stuck in next
Thread-Topic: "Always fallback to alt 1 for WBS" patch stuck in next
Thread-Index: AQHW6N8BpH0r+KzrDk+El0CQviQHvKovSoCA
Date:   Tue, 19 Jan 2021 18:08:44 +0000
Message-ID: <db29832ebeb0759a2a0a4b61b278043bf93d9d72.camel@infinera.com>
References: <CY4PR1001MB238904840D698F5F6D80FF6AF4AA0@CY4PR1001MB2389.namprd10.prod.outlook.com>
In-Reply-To: <CY4PR1001MB238904840D698F5F6D80FF6AF4AA0@CY4PR1001MB2389.namprd10.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cffd9141-7507-4efb-4b5e-08d8bca542a4
x-ms-traffictypediagnostic: CY4PR1001MB2389:
x-microsoft-antispam-prvs: <CY4PR1001MB23893FA31A2940B10FB1F05DF4A39@CY4PR1001MB2389.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7A784Juz2qANdXUB0shK4IiHoVLtNO6OX85blL49qlBEhTLzS1pei//nO80aR3m8YoY24GT1+1BRsV3JiNf5bH89AdOp6Yk6hQRsxtJu4Fe5N7dQInBA1SvVhsLys7+tg4k0ChG1/O87Wtj2wb0tYbZJt1ShVmapF4XQ3+/p/gaU+ZQcq6U0gOhtMsr1+T+3azzJm5FVJFJHJNwJYpd+uhnPIYp8jplV4TXIg3uqQANLfGfKE3uwKlgb223gBl+NEU8/sC8f1+z3FnPHZ/J4hs7bcsCqQK/ya4mEzuuAhNVBvn+8oU5v5uSvXmhwzhVYpYV3YxA7usFw4FUCpqTE5vFecRdJTVOHtV08wXP3NexOqmAxxYi58rhaO71OvZauN/35SvMkKGHu9ydEIfvD4Ib4+UqMmsLlaojR022v9wjXbI3H5qohHTAKS+Yj9mvYjt0K+kB2m5OAWUWaRs01wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(2616005)(26005)(186003)(4744005)(478600001)(966005)(6916009)(8936002)(6506007)(6486002)(5660300002)(66476007)(66556008)(66946007)(91956017)(76116006)(64756008)(66446008)(2906002)(316002)(6512007)(86362001)(36756003)(8676002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WGs4dU1hZkNlcmdTNzVsdm9NV3ZiVTgyVDVSK21PdU1qUnlEbDFydHlqZUhH?=
 =?utf-8?B?T0gwdU1PSlVvUmNhWW9vT1JJazdKNDcrUms0UTZTM1F5RDg4NURLNklTZll6?=
 =?utf-8?B?SU5YOTRRUzRWYTM1VE1jVWcwMkY4MlpSRnNENkkwVDJzRUhpeUU2OUN5MDRU?=
 =?utf-8?B?SFJDWFVsT3ZYazZBTTh4UG9aQjBFcDAzWDJNVWl5b3RSUzN6QVlJb3I1Rmp6?=
 =?utf-8?B?SDBUZTAwYkpPTWFyR1gvOVo0NElJQTdadVhrV2dTQ0RnRmpHZFJWYjhLTjZY?=
 =?utf-8?B?TktaWWJlLzJPV25pbmc4ejVXM2VVbTlwWmRaT1Zwdm85RXVGTXpxemJwWTRW?=
 =?utf-8?B?dTJxUWJJaFpBdnRMZVdVVDBhSDRyOGN3MHgvc0k2VnRaSTUvbGZ5Z0hpMHMx?=
 =?utf-8?B?ZWhQa040T0pOamtVTUtDY1Zxc0RHczRWc2lZVGNCNjAvTzJmSHU0MnlUZFZY?=
 =?utf-8?B?eCtwL1lLckJOWW1oQWJnOUJTd2ZrR3ZCbi9vMENUUXlCdjR5MVlxVGk5alBN?=
 =?utf-8?B?RWVIdUZ2N0VjN1NNQnpXWi92U0NVb3FibmplSHliN2Q3NFdoQjZYUU9iQlJU?=
 =?utf-8?B?UVBiKzFHTnlFNHRZdUgzdVFxZU5wTWsvMGdvNTBpUlBYdy9DM2ZteTFkTHNI?=
 =?utf-8?B?bXE0cUxrUTNLVEoydlFxSWg2aEMxcC9HUEZNNm55S21wSlFicmNMTnpBTUxK?=
 =?utf-8?B?eWxGbnNBM2UxbFZqZ1lRa0pmK3JhdEFMcW5qVW1YSU9NNnZqVytoV1JEeFFG?=
 =?utf-8?B?eEh4bldMZTFFSzRnMHRPZWRNaDR6Ym1SenNpQXZnVS9Oa1Y4cWxtR2MrYmpl?=
 =?utf-8?B?QVVqR0ErYnJoWjdMT3E2OE9jWDgvbU5XdzFOWFI0bnBrOFNpMS9lMHBONmZV?=
 =?utf-8?B?RjVZRXVic05xWlJVSHA4QnV5aEVTQlNVYmFxZlFKZkxYdjd5SUMzQ0ZTOGtp?=
 =?utf-8?B?MC9pN0hzQ21jcjJ5ZTQ0OXhKUmFMamV1NWNWZjBRbndEQkJRWFhPYWVNTC9q?=
 =?utf-8?B?eFljak9wWTNuNlQ4VHpGODg1d0dHL0lOWGR3MkU5WEE3aWN1WkxQKzlja2cv?=
 =?utf-8?B?RVJHMTBhdnRwTnpFU0QxZWlxK0VYZ0VBZk9mbHlJWkNhcURoN2YrL0tZVHU5?=
 =?utf-8?B?Wjk3Z0Z0cnJKV0NGZ2RvZlZwRnZSZkNXeTZQeUhKenZXZTRORGk4QkFDc2Ev?=
 =?utf-8?B?Z29VNm12dmFsaXUzSzRtVi9md080c1ZxeVhGZWtLMVZreld2bnB6MjlUeTNY?=
 =?utf-8?B?VzNpZUI2eUVSK045V3lOVnpQdFRTckx0Y2t0NUtoWmN1VEtueGJVNXh1NWFT?=
 =?utf-8?Q?JXCOgGNINI084xUdFud8BtI/ZKppF10oNK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <62C3A32A51124B40B42C42C2462B0170@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffd9141-7507-4efb-4b5e-08d8bca542a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 18:08:44.4985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFL+2+oUT4apgz1yWW8Dbm3W8MJVKD4Q7gHH2t5cIo4wgSUXauk9T+CA/Dkh3bRhjxKTl8Fpk8t0skrwlz19+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2389
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTEyIGF0IDEyOjM2ICswMDAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBUaGlzIHBhdGNoKEJsdWV0b290aDogYnR1c2I6IEFsd2F5cyBmYWxsYmFjayB0byBhbHQg
MSBmb3IgV0JTKSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9ibHVldG9vdGgvYmx1ZXRvb3RoLW5leHQuZ2l0L2NvbW1pdC8/aWQ9NTE3YjY5MzM1MWEyZDA0
ZjNhZjFmYzBlNTA2YWM3ZTEzNDYwOTRkZSBpcyBzdHVjayBpbiBibHV0b290aCBuZXh0wqAgYnV0
IHRoZSBwYXRjaCBmaXhlcyBhIHJlZ3Jlc3Npb24uDQo+IA0KPiBTaG91bGQgaXQgbm90IGdvIGRp
cmVjdGx5IHRvIExpbnVzIChhbmQgc3RhYmxlKSA/DQo+IA0KPiDCoEpvY2tlDQoNClBpbmcgPw0K
