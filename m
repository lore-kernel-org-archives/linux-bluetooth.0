Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845A8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 04:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A44360F9B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 04:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhIMEtI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 00:49:08 -0400
Received: from mail-gw101.jp.ricoh.com ([133.139.20.91]:43086 "EHLO
        mail-gw101.jp.ricoh.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhIMEtH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 00:49:07 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2021 00:49:07 EDT
Received: from smtp02.os5.jp.ricoh.com ([10.230.97.112])
        by cmsmtp with ESMTP
        id PdeEmiGDagSnxPdeEm2QXu; Mon, 13 Sep 2021 13:32:50 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ricoh.com;
        s=s20170401; t=1631507570;
        bh=beoXhZAF+6/ljnzEoLqYxGtyyQa8CziaEl3qN+zJo4A=;
        h=From:To:Subject:Date;
        b=pxpQdKWXOcHh5hW5MzK/qMKiWQoOQsXEEw2+HQrMN93rMykNSC1ttH03weUuzzHzv
         wYBMtCvP4imI9QFauk2UecGfyfVABbwF/6vq4NlBaSJp78di/2dQR0MPE9mjKTnfz8
         V3wEwNM6+EHP1Dnabtc/5+1E+AWCNqZ26jVBU+XY=
X-VirusScan: scaned
X-Flow-Control-Result: 
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp02.os5.jp.ricoh.com (Postfix) with ESMTP id DEE689C102F
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 13:32:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCS0iCSwPlm88UD4eRmVaWzKQgB9iRUTCGo0psIn/x7fWSL6Vx3gTREpE4cd1bVnGpGZsOBdw4UlQsfWPwMOU9u2ipQcYGlMJ6nq9fi9MVHrPd8M07l0XehEPm7DzfB/kj1q6Ev4AODG7fNHVoS5QNkp0lIOzV2Pc+VEc5gNvhHtRlumWc8l+COqJzOsvQWEbfycAG1sAQV1fxDNGfkFiGmwiX6Ty92jJRp2TW/2KrQFdqWsr/Hv34Jt4YTooGCwc2k1K2hoLyJ2rNsTTc6vSju9GGtyaZXUUMkvkNMHpRFSPgjhUU1B4pluJqNX46tdaKf11sllGNEizJONvTnX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HRj/R2MHBB67YO4kcbsEXyn8LEeldAFlwEdjWcPSlYY=;
 b=A1PNM6bRCUv5cqCbh2lUWE0Sq3pbbdYJC/31ytEtD4T8MNFYChsfWnsL4aeSGzfYvPfhBZTWIeEEFddJALa2rzPHiCxL8vvpGXCfOxdNgvh9HKc9OSbfaTXJh+QiVRjtq8RAViEmMXXdWyh5JWdUk6ipqMaCwS7mUKnDflx2oQX4RWGCcEOUL1dCGze+ou4DPHBwU6aGLen6bLt+gKIf5qTl8No+n0NczO20flR0xmegLBhUoJaSKOb8eL5HAIXdis1+2zV8Uv2U5KAvM3+QWyaxcyqrpClMyyKZuiKlb8Mr3Co2UROoYi6p3sP4X67GCUKE5NxKZ6DLN2xkMTEEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jp.ricoh.com; dmarc=pass action=none header.from=jp.ricoh.com;
 dkim=pass header.d=jp.ricoh.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rfgricoh.onmicrosoft.com; s=selector2-rfgricoh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRj/R2MHBB67YO4kcbsEXyn8LEeldAFlwEdjWcPSlYY=;
 b=IfIVW6b/D8bA15dmsFXEkxzdZ1pTRtoSnrNWAjK+Na9QaIWxRi/cPUrOxyPcWxsUetN56RkkpSfB3P86/XdW1kqVqvboxDnWgFZQczqL3BFh736xacg24rPRzQ/Vp6Be+0QW3PuZ7kZQEDKlwl2a78OcRr7VFE6kSt5GEpSzh7o=
Received: from OS3PR01MB6837.jpnprd01.prod.outlook.com (2603:1096:604:12f::11)
 by OS0PR01MB6417.jpnprd01.prod.outlook.com (2603:1096:604:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 04:32:49 +0000
Received: from OS3PR01MB6837.jpnprd01.prod.outlook.com
 ([fe80::3437:58b3:7d23:8856]) by OS3PR01MB6837.jpnprd01.prod.outlook.com
 ([fe80::3437:58b3:7d23:8856%9]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 04:32:49 +0000
From:   =?iso-2022-jp?B?VGFrYWhhc2hpIEhpZGVraSAyICgbJEJ8YjY2GyhCIBskQjFRPHkbKEIp?= 
        <hideki.takahashi2@jp.ricoh.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: hci link tx timeout with BCM43438
Thread-Topic: hci link tx timeout with BCM43438
Thread-Index: AdeoOVU2nJW+v6AbSHe5kxZzVur3oA==
Date:   Mon, 13 Sep 2021 04:32:49 +0000
Message-ID: <OS3PR01MB68374959D142463F88FD383684D99@OS3PR01MB6837.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=jp.ricoh.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 618680cc-f5ff-4b4a-32f8-08d9766f8aef
x-ms-traffictypediagnostic: OS0PR01MB6417:
x-microsoft-antispam-prvs: <OS0PR01MB64175F21793C7A0D6C68951484D99@OS0PR01MB6417.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/AKKpDmvR87j0COJmWyoj/2YWj+34xZdn3MsoGFJmHzPOuzJvYHvOq0aHElH31mCrhTk/P4WzX8v63awQhZN3A6/rsrBDYn+Eg5/NLdqOtYtqiKBMXKw/sBnhTrXwwOCw28bwb4iQn0KeYSJXMhV9qZqVi6xBV4PTkTmRHXmiYcQ/wT43HEk181Sa4xKdsSsUJRx4TktvgZnLe41HNcn0UqGS08m2SCsZxViXShi8WKiKaWtpxIFs/c6zSLWhdVwUum6mWHF8Tdfr5+YUbsE8nxeVuIUiz3jxum0M01sILfFWd1wC3HKwacy1G5syQasg/S8dqM1QGQSSor3tohGqSFY082RVFIz+U/wmG1lZUSoCH9f/RznnuDbRH5MFtUgsJSrWsYjPUa1qI4aJdeAP48oVbyjo4q5HUn/PYN4xXpIZYiez+l8XMiV9Pg85NC4t4K/S7Nl/Jbf1UDs1fPcWsOTAN4fafCUJCJPHX3Ww6PDcCPoYtlHVQp19tKBM0Zm1e8lqR549qd3o/iiHIX9TScWAN8O9i7sAuj2eOa5ca7Mbxzkgik8jQzPTszqITDcaMLjS6BQ+UFxZ5HvhB06z9ADHfA5Zs1l945uY7QbQK4i+Xr9ArJ4+FsOthi1IaqVX/eGDm9ghSpvTeUMrkIJiHOXmt+0aAAehz5ePgH2DkMsUgUCtYMzqyNzLNiGJkPbib0Brn5J2CLdR19n3y1Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6837.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(39860400002)(346002)(38100700002)(122000001)(52536014)(9686003)(55016002)(6506007)(66946007)(186003)(5660300002)(85182001)(478600001)(76116006)(66556008)(38070700005)(64756008)(8936002)(86362001)(66446008)(71200400001)(26005)(6916009)(8676002)(316002)(33656002)(7696005)(2906002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VWc4RUliUHhVZDB5S3FUZmZLMlpYMGFFUUQ2YStLSFpPNndJZzFUUm5h?=
 =?iso-2022-jp?B?YUhBd0lWTFRvWjk1Y2pQWDk2UUpYQUxlZUcybDJXZmR4ckU3MWlRN1Mw?=
 =?iso-2022-jp?B?dEZGRmhZcFlITWNtaU9qZlY2VFI5T3hyaVVMRnZjT1JDWUc0U2FPNktQ?=
 =?iso-2022-jp?B?TXZFaTFjcWdmSXFDRGFuZ2dGUEIrSzZETStTSHlNRkRibGRIRHJ6bmgw?=
 =?iso-2022-jp?B?Kzc5R0kvTXV5ME5abFEvZEJDMHVhZ0x3d012WUo4emh0OWFTZEtIZ2JY?=
 =?iso-2022-jp?B?bGpvYU9MRWlPeTE3RXRPL2hIQ2dMYnA5RWlTRFRWNGl1VkRQYUF1N1Zq?=
 =?iso-2022-jp?B?Y2hhZElHOTJ5dUNsbHVEY1NHYTR3ZzlaK3hhZWdlZXhRczUzUDBKUTNu?=
 =?iso-2022-jp?B?Z0M2Mmx0UytPbFF5L3RYUXdlVzg4d3A2NjBrcHNQUzVhQjgyYWtjZ2xq?=
 =?iso-2022-jp?B?OVR6SUtKWGpFRmZ6cEVJYWVLVmw1NWlkZTBkckVnSWtmR2ZwK3ZtRHdM?=
 =?iso-2022-jp?B?WUU4MjFvTEp2bzNjWVUrWWN2M3BaZDFOam1zMlRPTEI1bHlpSWpUTjNE?=
 =?iso-2022-jp?B?MTM2Nk1QRDBka2V0c05veWZDMkdZeDl3eWlDeTc5VWR6R2ViQWNtK21j?=
 =?iso-2022-jp?B?MUROODRQMXRYb0xmaXFsUXdBaVFwR3B2amhLTjFQeUIvRU1aZk1rc2Jn?=
 =?iso-2022-jp?B?Zm1NcUROR2tpblNnQVZZSDF6NDhic2k3aEY5czF1Q3BxQkZobjVQUGxj?=
 =?iso-2022-jp?B?R3dqNmozSkM0V2hZT2hDT2h6SVE0MUo0ZGhKOEwvTlRqcHBQTEJicUQ2?=
 =?iso-2022-jp?B?QmxoWVhYcjVHTlI5VUNLczIvcjEvMUdzaXpvRjJPbnEwVy93c1JmTnRy?=
 =?iso-2022-jp?B?cU85QzFWcU5LNUZWSUwzdUFWSkVyTjBENVR0ZEdZNSs1VmlFTzh0R3ZE?=
 =?iso-2022-jp?B?R3Y2OEhKUHZUejA2SDBEVlhTc2lZcXEwcWFLRG8xN3k1YWsyQWdxY01O?=
 =?iso-2022-jp?B?RlZaNFl0em0wM1R5cWZ3WmFXellqdzlPUHRUWFdkNVZzdlJwdlRzVkJQ?=
 =?iso-2022-jp?B?blJjNmhlUXd4WW1vU0xRVy9MVzh3RzlxNEpsQkdVRlJUVG16YU1KMU1G?=
 =?iso-2022-jp?B?Z2xza0N1L21jSGpQSVY4eDlSU2NrOXZrTWhUN2dqallTTnp4di9yajFw?=
 =?iso-2022-jp?B?YnBkMGJrWmNhSzdZNmQ5NEw0ZUZQQnY2ZzQ2dWJ2QUpQbmZmUWFsQmZl?=
 =?iso-2022-jp?B?UDEwbmFUaThwMmpuOERRN3psN3pBbFFLdW9rQy9obUVPZndOV1FqdDZk?=
 =?iso-2022-jp?B?eGNPQVhpODhWb29IWFNQMDdjMXdCOEwyQ1NyZHRRYkFXWVFrOFlMN0VZ?=
 =?iso-2022-jp?B?b2J0MWFvY0orb0xrWldyL21jaERyWVFraFFYYndHbVBLZHg4b2RUbXhh?=
 =?iso-2022-jp?B?UWFUbkxuQVhQeldxSERQMVdUUTJFeUo3VjZjV0dJRG05N0dWcTkxNDZh?=
 =?iso-2022-jp?B?WHo5MFVscjY5VU1PR0JQT0laY0hZQW1aUFlXRHpzNnpneE9yand2Z1hz?=
 =?iso-2022-jp?B?c0k0elpSVWNDbFhGOElkcnVORXFyUG5ybzFiMXZpSC9QRVhvYTh1UHpq?=
 =?iso-2022-jp?B?UmFCOFVzOTBTb0grcjRzamVYYmNnSUkxZi9wUE5HMVJxcW9CaVdIQUxP?=
 =?iso-2022-jp?B?MlZVKzd6WE1qU1kxSEZ4dkJ0RHRFc0pPQXBFTGZuV1VnY2txbkp5dG02?=
 =?iso-2022-jp?B?VGR3T3BMeXdIYkhpRG1HZW9wVFlRbWlCa3JJSXBxQXllcVVWaEYwUGFH?=
 =?iso-2022-jp?B?YzVudXlNV2VGNTBTMTJaeWl0ZHlhV09yN29xS00wM25lV3Rvc2dmVm15?=
 =?iso-2022-jp?B?ejJPdzV2KzdxYVJ4ZVUyR0h0ZzhBPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
content-transfer-encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jp.ricoh.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618680cc-f5ff-4b4a-32f8-08d9766f8aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 04:32:49.2750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e717ec3d-6036-4776-b72e-41f49481d91e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGq4oFDHC8t2U6smUTI7a0ldhBMhhkXKROu2afAe97q3t12SHlj61Sbv4kxRMMh5oFS2nW6VlfBRSjR+5zRcAz802y54wuHGsWTUC2rRED8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6417
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello All,

I am developing a system that communicates with BLE on Raspberry Pi.
When the developed system is operated, HCI link down occurs several times=
 a week and BLE communication is disconnected.
Shows the results of syslog and hcidump when communication is interrupted=
.
From the result of hcidump, I think that it is a problem of hci because c=
ommunication is not interrupted, but what kind of cause can be considered=
?
Would you please suggest a solution?

Thank you for your help.
Best regards,
Hideki Takahashi

[Execution environment]
=1B$B!&=1B(BRaspberry pi 3 model b
=1B$B!&=1B(BRaspbian Buster 10 Linux raspberrypi 4.19.57-v7+
=1B$B!&=1B(BBlueZ 5.58
=1B$B!&=1B(BBroadcom BCM43438

[syslog]
Jun  1 14:59:31 raspberrypi kernel: [2678208.088754] Bluetooth: hci0: lin=
k tx timeout
Jun  1 14:59:31 raspberrypi kernel: [2678208.088765] Bluetooth: hci0: kil=
ling stalled connection xx:xx:xx:xx:xx:xx
Jun  1 14:59:31 raspberrypi bluetoothd[901]: src/adapter.c:dev_disconnect=
ed() Device xx:xx:xx:xx:xx:xx disconnected, reason 2
Jun  1 14:59:31 raspberrypi bluetoothd[901]: src/adapter.c:adapter_remove=
_connection() =

Jun  1 14:59:31 raspberrypi bluetoothd[901]: plugins/policy.c:disconnect_=
cb() reason 2
Jun  1 14:59:31 raspberrypi bluetoothd[901]: src/adapter.c:bonding_attemp=
t_complete() hci0 bdaddr xx:xx:xx:xx:xx:xx type 1 status 0xe
Jun  1 14:59:31 raspberrypi bluetoothd[901]: src/device.c:device_bonding_=
complete() bonding (nil) status 0x0e
Jun  1 14:59:31 raspberrypi bluetoothd[901]: src/device.c:device_bonding_=
failed() status 14
Jun  1 14:59:31 raspberrypi bluetoothd[901]: src/adapter.c:resume_discove=
ry() =

Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:add_default_agen=
t() Default agent set to :1.108 /org/bluez/agent
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:set_mode() sen=
ding set mode command for index 0
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:agent_ref() 0x56=
8110: ref=3D1
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:register_agent()=
 agent :1.108
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:new_settings_c=
allback() Settings: 0x00000ad1
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:settings_chang=
ed() Changed settings: 0x00000010
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:settings_chang=
ed() Pending settings: 0x00000000
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/device.c:device_remove()=
 Removing device /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/device.c:btd_device_unre=
f() Freeing device /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/device.c:device_free() 0=
x56bfb8
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:agent_disconnect=
() Agent :1.108 disconnected
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:remove_default_a=
gent() Default agent cleared
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:set_mode() sen=
ding set mode command for index 0
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:agent_destroy() =
agent :1.108
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:agent_unref() 0x=
568110: ref=3D0
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:new_settings_c=
allback() Settings: 0x00000ac1
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:settings_chang=
ed() Changed settings: 0x00000010
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:settings_chang=
ed() Pending settings: 0x00000000
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:discovering_ca=
llback() hci0 type 6 discovering 1 method 0

[hcidump]
2021-06-01 14:59:31.304383 > ACL data: handle 64 flags 0x02 dlen 27
    ATT: Handle notify (0x1b)
      handle 0x0012
2021-06-01 14:59:31.304682 < HCI Command: Disconnect (0x01|0x0006) plen 3=

    handle 64 reason 0x13
    Reason: Remote User Terminated Connection
2021-06-01 14:59:31.305089 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2021-06-01 14:59:31.345332 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 64 reason 0x16
    Reason: Connection Terminated by Local Host
2021-06-01 14:59:34.992038 < HCI Command: LE Set Random Address (0x08|0x0=
005) plen 6
    bdaddr 37:68:FE:C8:77:51
2021-06-01 14:59:34.992509 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Random Address (0x08|0x0005) ncmd 1
    status 0x00


