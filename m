Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FD9C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jul 2022 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiGLSGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jul 2022 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGLSGV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jul 2022 14:06:21 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 48192A9E7B
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 11:06:20 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 6293882713_2CDB81BB
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 18:06:19 +0000 (GMT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id DB002826CB_2CDB81AF
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jul 2022 18:06:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmiJLkVXRDbkphpgk7Mn1jdsA3gCbCK0sKK2RDRYErb+o23ayRgDdzH6UdQlnHdT94BfLOtq5bWhXJUV1eHsRle7coXS5fFRW3qINaKFQjofwYvLP9N7iBh+tUwWs21/f5YwzFcT6bEHVNzEhom4w2ERw1otGlPJy4Sty+J4fpaTjlGN/x7c9Nv+KJTGYne71qTD1wCwg/bbxmjdvTzq9ZqAk3EZeFs3VzlKG2nq3YvlaZYtmyHcYCFSaSJKZGWEIjqZbJfBjtHHgEGUgyEzCwFgZ8D7bKwaN2T+ulVGnvf7T2ednBqQqU8s3HHNyip6GG/cJrhRNPITMi0yWKvZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOLzuuhAbD5EXKucHxrSpj1iwDIVcxrTyyubzWZYOVc=;
 b=LgYbdy1ElG0J7J5TTrTvayF5SEElUCDsmiHpNN3yMaQRwOIR6z8fzQnCsQsO8h/lAvrLVQfbLiuAhHLb6oZMuIU29/HgF+zv78aitIuSNWbWC6eH3tMrbomUQ+UhowEw9JAoAZuTBmGS1AenJlrDUAvONtq0ZUfgyJusqrcss6Obwk2jZCKtwq5G7Cn46vzLbrzzib+37apOidx/3/drIaBbLdMZ7w6/St9a+enmPL3s0AJOCRrK/f4Y8AnQNJRwbnsyWMldDGjA4GVObfUHeGnxWoiP3x7xHtiKNO42/aVX3i3aB+qCHc52nuUojKEH4UpMqdtUI5s9SSnlsfChug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOLzuuhAbD5EXKucHxrSpj1iwDIVcxrTyyubzWZYOVc=;
 b=eIFSPJKK1IQvPwWUink3ccuW6Su5aecBobR5d9byDTPYdXd+c6l44+XSoEZaEfw/AllaJV2bXAgyKolw1N9FAsgXDtDKzbAz5CfIbvJVryw1LjNsUr6ktpWHZcIbz6CEIODPoyMyxV4PT/XCbpwIAWGtpyKgDDMEpqxbVzhomPk=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by CH2PR13MB3352.namprd13.prod.outlook.com (2603:10b6:610:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11; Tue, 12 Jul
 2022 18:06:16 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.020; Tue, 12 Jul 2022
 18:06:16 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: How does bluetoothctl work from the command line with gatt?
Thread-Topic: How does bluetoothctl work from the command line with gatt?
Thread-Index: AQHYlhLsQU9pU+y0dEmfVtUfdtr2gQ==
Date:   Tue, 12 Jul 2022 18:06:16 +0000
Message-ID: <SJ0PR13MB5755315F09CF8B49984DE12FFE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 77587b4d-24c7-726f-733e-f0e7812fc980
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab27fb51-c8d9-4045-8778-08da643136f7
x-ms-traffictypediagnostic: CH2PR13MB3352:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKCTQWITnX+g/Tz+3Fw6hhHVoukfyhotJQAuSxDWG8aQCfK6XFxzmouPTEawIDbeEItRv/6miBqmssdssgwjuMcKG1UCEoyCKwpr1bHnoUz0eIM3k0I93IQ75lI7i7PilxPIBpyD90q5xcc2YINaPhm4fKe3sm5Kmz0i2WI9O+OGeQonSc49Sm523JtpR1MxcCoTvhqJ0ps3OCdCh5WseWBTEut3zNDMcgmoAqOkH+FiQQR4i0uH04YA6qOfZYyL7+FwE0b9ADXmJ8MpuuzF25nb7b6eMWaaBy2HLuESYbtmJ4lMmGPdZj8GRq3E5CVPJSam3ptpSrwxw8duF7awtXmjzTnXYenAVmx+KNA8916L+R5eiDdE3STbLf6w7fLxpAEsByuqe0dxcpYZbPuY4Hnz+OP/x7YLmpBVn5QvGjXb+kbqvqAGHk/rrLiEcbUeGV5zZC+2yM1dqwtbSyvBJ460UDBHUgsxdl8mNKJqJ0hGmaCP6MSnrU3zeDY/AE3Ihhdrnvaf1G5Fd8YoOlZvaBRr2knnmSdfqiGl7qbtJ+g0PEn7QtkwKRRT4zHNwjgVf/z6rxfxPhgKbbc33nZnNeiJJmdM9gsDmvto4wrJc+34V+D8QaSNN5xux4Vk4jBt4DLLAZOfrmoQTHvGqh/6jMfpUbTj1bfYT/+fFnjYPVaeU/QJ/xyR9ata35QOH1otKX8D+MeEi0XU3KDQhwz7Oio4NOl6OcbevtxvBvSCE6rljKqPmcDjbKr7PE7nzJWTBU1pTrLYdRXMi/u5EH/UwgsOxVAIycwBqRTmobW7tL3zgpulvtoGLo6xaUdyiD/TrJdqOSR0i9FUQzD0Bn3eMTjhLvS0EHr9IH0tm2Vr5C8mvwwsTnpWNFFNB/zKUFNo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(39840400004)(346002)(55016003)(33656002)(122000001)(478600001)(71200400001)(5660300002)(38100700002)(4744005)(6916009)(2906002)(8936002)(52536014)(9686003)(26005)(66476007)(8676002)(66556008)(91956017)(64756008)(76116006)(66446008)(66946007)(186003)(6506007)(316002)(7696005)(41300700001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SENEWDlhWDYvajd5dmVPS1dvOEZQREo5SVQrTk9QRWZBV1VnQUhVS0FzdkQy?=
 =?utf-8?B?b0VORTZBTHNYcjlVSXFmTE1VRnJ0dVlraWdmeTJsQUhVVWlneUhRbUg5N2FB?=
 =?utf-8?B?SzN0Yy9hb3BwZUpGT2hYRWwyTUh5Y3ppU1E5UTZiQzZnTGtuQThBcXA3clB6?=
 =?utf-8?B?OGVlcENvM3V0UGpLdlh0ekZ4L3N4NEJ3Z3BsKzQ3ZFBzWERlZXEzQzhqbmJW?=
 =?utf-8?B?TXN1TkpXSy9aQndtNVhwUUdqWU1JTFEydnRQMHFtVjRacG1JVENHdDRGNDRt?=
 =?utf-8?B?aDBFVUpSSjFiMVBFYmRVSWVhWDdJaEI0bHp4YzVnK0o2Z1dvUnZUbEVjMkhD?=
 =?utf-8?B?cnVmU1lpYXY3VllSMTFjTDBTNmtZTkpTdVJHVzQ2UHBPenJyUW1PS3o4ckhQ?=
 =?utf-8?B?M3lndURhNTlMN1hKSXZVQnozeXFLYitxZnBMZjFZdTZSVnJoalNCZUZ3SXE5?=
 =?utf-8?B?aVAyZGY1YzZqZnNrenh0K2lKb0V6V3RPaEF0NzFGeEF3WXhuOFVZeVYzVlQ0?=
 =?utf-8?B?R090QmFWeUlaNzB2ekJ3bTJVQmY1bHZ2OGJJd2p2ZGx6NkMvdHdjWVdYc1U3?=
 =?utf-8?B?YXNhSlV6ZUhCdDMyM2Q4VWExVDhqZjgyMlArM1plenI4WEZ0bFNTeGdjRWUv?=
 =?utf-8?B?VVFmRW8zZ0RqdndualkxUVIvMlU4a1BBMXlSdzMwb1BTcjlxU0xnWEQ3djg1?=
 =?utf-8?B?aGNmN213RXRMdVZ5Z2FWTFMwYjgzVE1BVDRuczRjd2kraWtHamFNRElrelYx?=
 =?utf-8?B?TVRsSnNCMm5uazZ0aCtkcGJ6a2E4TjlOVmhtN3NIT2QydWFsRUgycDFWNGQw?=
 =?utf-8?B?M3FZY0NDRDVLZUNVZzM4aUZDeER5dHhVaGRCRXd2MTdzZlJUd093MWtCSXd6?=
 =?utf-8?B?SkovQXJHNi9aK3M1L3N5Qm1zL3doS3JTQ0ZxbUx6NmlyQy9YUUZ0eTNGRjRa?=
 =?utf-8?B?cmhNUitxTmswUU5mZDcwL2VJZVRCeEFjQkJmK0E5TEJCY1BPNGVKKzNoeWJv?=
 =?utf-8?B?MFN5T2RsclU2OTFrZjhZY0RsbEFQQVl6eHd1RFplWTVkTVhObjFJMzQyeHpV?=
 =?utf-8?B?ZjZtdlpuR0d1cE52MnMrTDFUQmFmQ2srbllGRmJxNmVHL3F2ZnNmZ0x2TlBv?=
 =?utf-8?B?R1FYV3c0WjhFNW43VkErSUw3a0ZZL1lDVCtXSTF0cnVTYXVqS2I3L2d1dmtx?=
 =?utf-8?B?NXM1UHNYRGV2SkRLencvVVhWZC9NcXVmYWFCdm42Qk5lQXVTa0k3ZXFMSWtj?=
 =?utf-8?B?YWxkZnd0Z0FsWkQ3N3I1WjdSRHR1eEZDZlRnK0dOS2YrM3V2OGtGYVlNd0RF?=
 =?utf-8?B?aHZ5emYzN3FJNThSTE5Nb2M4elFyUVdZZHcvY3ZJUVo1OTRPSlQ4UG1vT21s?=
 =?utf-8?B?bURpaEoreDlQRmMxcldzWVZhZ0o2cXdzZWFVOXFwME1FcTVuVGJhTXdoY3Er?=
 =?utf-8?B?Sjl4cCtYNFNSYzZYcGt2c05oVHlBZE5lNlFGekh3LzVFWElreXV3djNDNzA0?=
 =?utf-8?B?NnUwQytvVDljRzA5WFRhajFVZncyc1FFMkRpU3MzcnhGTktnYnRPRG00c0x2?=
 =?utf-8?B?R0c0ZW5vZUdoNkQ2UC8wdXE2ZmpEK25XRTQyeDJjMnV2YmN4K0JkTVRNSmp0?=
 =?utf-8?B?YXZMeWtLYkliQWNmeVhSeUQzWDU0ZGpIY2tsWkhNRTZQYXZndFRiTEtqUlcy?=
 =?utf-8?B?ajk4cUZkQm9qOHlnVVZlL2x2QjJWdUw4R0taU01TY1ZNeEFPdFJrWkswRk8w?=
 =?utf-8?B?djM5eEl6OHpXejV5OERkWlRrUE5mUEVzTHNNeENwUXJiSnJibVlHZGlDZWxa?=
 =?utf-8?B?NnVGa0oyVXpWMFM3WVdLcTlQSmdmL1F2VjBxbWdISzFvQ2t1RmdIempmSGVh?=
 =?utf-8?B?V3VSa2V5elhXSHJBTmhrRW5jck9raldlMHF1aEFaVURWWTZERWdVS3Q5T3A3?=
 =?utf-8?B?aWZzd0svMlFTd1ZXRHIwZHVOR0lLeFZsUmJaTkdXNWp1c0dXVzAwc0ZlT2Rw?=
 =?utf-8?B?bVFvSjk3YVpBZDJaTXlmNExhU3ZKeXlrUzRBcWhJNkdLUm5pN0xBRk1oRFda?=
 =?utf-8?B?SmFSa3U3Z2dLeUJwZk9xVXdsL3NieWR4MXAydFQ5RWs2K2lEdzkxZjM0OWNL?=
 =?utf-8?Q?I0PA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab27fb51-c8d9-4045-8778-08da643136f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 18:06:16.4557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkQ9S4my8hQp430rj5p9IawMqxnJu3JPwyQWgInw9G2FxK4fUVct5UCo8ruxd3B8sHZGzFKefFRCvWH4mxouyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3352
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SG93IGRvZXMgb25lIGRvIHRoZSBmb2xsb3dpbmcgaW4gYmx1ZXRvb3RoY3RsIGZyb20gYSBzY3Jp
cHQgYW5kIGNvbW1hbmQgbGluZSB0aGF0IG9uZSB3b3VsZCBkbyBpbiBnYXR0dG9vbCBhcyBmb2xs
b3dzOgoKIyBnYXR0dG9vbCAtaSBoY2kwIC1iICRiZF9hZGRyIC11IDJhMjkgLS1jaGFyLXJlYWQK
aGFuZGxlOiAweDAwMTcg4oCC4oCC4oCCIHZhbHVlOiA1NCA2NSA3OCA2MSA3MyAyMCA0OSA2ZSA3
MyA3NCA3MiA3NSA2ZCA2NSA2ZSA3NCA3MyAKIyBnYXR0dG9vbCAtaSBoY2kwIC1iICRiZF9hZGRy
IC0tY2hhci1kZXNjIHwgZ3JlcCAtaSBhYTIyCmhhbmRsZSA9IDB4MDAyZiwgdXVpZCA9IGYwMDBh
YTIyLTA0NTEtNDAwMC1iMDAwLTAwMDAwMDAwMDAwMAojIGdhdHR0b29sIC1pIGhjaTAgLWIgJGJk
X2FkZHIgLWEgMHgwMDJmIC0tY2hhci13cml0ZS1yZXEgLW4gMDEKQ2hhcmFjdGVyaXN0aWMgdmFs
dWUgd2FzIHdyaXR0ZW4gc3VjY2Vzc2Z1bGx5CgoKRm9yIGluc3RhbmNlOgoKIyBibHVldG9vdGhj
dGwgY29ubmVjdCBDQzo3ODpBQjo3RTo4NzowNwpBdHRlbXB0aW5nIHRvIGNvbm5lY3QgdG8gQ0M6
Nzg6QUI6N0U6ODc6MDcKQ29ubmVjdGlvbiBzdWNjZXNzZnVsCiMgYmx1ZXRvb3RoY3RsIGdhdHQu
c2VsZWN0LWF0dHJpYnV0ZSAyYTI5CiMgYmx1ZXRvb3RoY3RsIGdhdHQucmVhZApObyBhdHRyaWJ1
dGUgc2VsZWN0ZWQKIyBibHVldG9vdGhjdGwgZ2F0dC5zZWxlY3QtYXR0cmlidXRlIGYwMDBhYTIy
LTA0NTEtNDAwMC1iMDAwLTAwMDAwMDAwMDAwMAojIGJsdWV0b290aGN0bCBnYXR0LmFjcXVpcmUt
d3JpdGUKTm8gYXR0cmlidXRlIHNlbGVjdGVkCiMgYmx1ZXRvb3RoY3RsIGdhdHQud3JpdGUgMHgw
MSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAKTm8gYXR0cmlidXRlIHNlbGVjdGVkCgoKCgoKSm9obiBLbHVnCgoK
