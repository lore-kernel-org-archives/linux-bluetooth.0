Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC49C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 00:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376259AbhK2ATp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 Nov 2021 19:19:45 -0500
Received: from mail-gw104.jp.ricoh.com ([133.139.20.94]:39156 "EHLO
        mail-gw104.jp.ricoh.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbhK2ARo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 Nov 2021 19:17:44 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Nov 2021 19:17:44 EST
Received: from smtp02.os5.jp.ricoh.com ([10.230.97.112])
        by cmsmtp with ESMTP
        id rU4qmipRiynqWrU4smlfk0; Mon, 29 Nov 2021 08:59:26 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ricoh.com;
        s=s20170401; t=1638143966;
        bh=WUeFdeIrTeWoEPN2LK2CzQ9hTNtWbqyix+3j8rU8nrw=;
        h=From:To:Subject:Date:References:In-Reply-To;
        b=gzN7Rf4wc+p1lC9HifdxXk1ZVxXJcIgDV+pEuI+ouqFgPIo9uuMzFBHQwpCYvcHfa
         haIvDZCXyeXqIOtY9ejso3zDbHakGG4oVvVZK6SDY/kVpCvedXQz1sks6JcuWjsxE5
         a+HhFsd85lxY72YQYgvaFtNBCUNExP/zaaYjKCEw=
X-VirusScan: scaned
X-Flow-Control-Result: 
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp02.os5.jp.ricoh.com (Postfix) with ESMTP id 15FD19C1253
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 08:59:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/UVe+jm36lmlLensuxv6L94yCTe49V/fZVWyYUXDFo8Hpswl8G+h/DEns+rWdvEQWuUfOPyzSlSHfS9Jy7VGg8AS4+SG+eOp8fsMFndBNsIzXTtzek47eaN+AL8wKG5V1UeQNLssYh5b6dAfwQqVAcF+X3rjJICsVhuvEhxA3SviIRvjVvoiF0Msu4q1If81u0u8DQyB8gxFfDaq31YIFtIk4l+3D9XDobWY9lNv7ga+QhXYdRxB4yc6cIQuO+YjxohfFWBk76DIrjCCorGXUKuxQRay0cx+dEV8caYtwdf7wThy/+og6N010//86EH5RZZuNTXGbmVrHl+8h8a5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcNbzXRHxzKYGL67wBZ6gfdefOBELRIjvCSGK7MFnrw=;
 b=CMWlpCZgHukIwDot6CdPmsnf2f//YmH57c62Eq0pvfOnDGfwQxXNEf28Lycxbk6FzZB6g1Xr5Xn9h2bUkLwxpcRLsicKfyTqDlq85qNK8zbNvMJJ3sQj0/cPaBqefFp0g2fsfETevxRwLLk6ZCgBHi6G/PzsSiedkYKsAJeIqMfH1YbPoqYaEE3mgf+nJLM/9Sj2lx8/RwbOZK1ycNcbDKIfnjNIHhS8JOklWNGHi0GHTcfTJYywZRG5ReD3NeorQvJpShD1AalCNF3sB1lUVSXH1qPojqEgbMwnwZCr4SP+9o+ouYPVYOK3+C5qh7Mg1Y8ZRDBHKVeaLmohtbNXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jp.ricoh.com; dmarc=pass action=none header.from=jp.ricoh.com;
 dkim=pass header.d=jp.ricoh.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rfgricoh.onmicrosoft.com; s=selector2-rfgricoh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcNbzXRHxzKYGL67wBZ6gfdefOBELRIjvCSGK7MFnrw=;
 b=ECsqr9H53o0xRUVux8h1m1UjDCMfJmRMm/sUYkykNqXXmwWQ0E43JgFbeCAfRnaS09kC6lZZ6Fy7CRtJkohzhBSeS8kekhwllbf9jWi2EWXHCe3Sll1rR8pxYZtlibUWiX+r9caSuhgXiwS9f3wlUWVugaIxVJA4UYGp7xWlQ/o=
Received: from TYCPR01MB7920.jpnprd01.prod.outlook.com (2603:1096:400:187::12)
 by TYCPR01MB7989.jpnprd01.prod.outlook.com (2603:1096:400:186::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sun, 28 Nov
 2021 23:59:24 +0000
Received: from TYCPR01MB7920.jpnprd01.prod.outlook.com
 ([fe80::bcb8:bed2:4d74:6c6c]) by TYCPR01MB7920.jpnprd01.prod.outlook.com
 ([fe80::bcb8:bed2:4d74:6c6c%5]) with mapi id 15.20.4734.024; Sun, 28 Nov 2021
 23:59:24 +0000
From:   =?iso-2022-jp?B?VGFrYWhhc2hpIEhpZGVraSAyICgbJEJ8YjY2GyhCIBskQjFRPHkbKEIp?= 
        <hideki.takahashi2@jp.ricoh.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: hci link tx timeout with BCM43438
Thread-Topic: hci link tx timeout with BCM43438
Thread-Index: AdeoOVU2nJW+v6AbSHe5kxZzVur3oA8dRomA
Date:   Sun, 28 Nov 2021 23:59:24 +0000
Message-ID: <TYCPR01MB79203A97EF7F9D80CF7083B684659@TYCPR01MB7920.jpnprd01.prod.outlook.com>
References: <OS3PR01MB68374959D142463F88FD383684D99@OS3PR01MB6837.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB68374959D142463F88FD383684D99@OS3PR01MB6837.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jp.ricoh.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07649baf-792f-45da-ce3c-08d9b2cb1ac1
x-ms-traffictypediagnostic: TYCPR01MB7989:
x-microsoft-antispam-prvs: <TYCPR01MB7989BE1A016429DB3C80DA5884659@TYCPR01MB7989.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6il4IBdRQvKwsdIQ37sA0icRpXXSr6f+eipqoGHa2VY73CyDcjmm6egL7adIwrRtdrUgtoo9XWXm6AZ5UJKc82zV9EiYs8NQBG+qajoG6j3MIa7BLuHt6reEv0ahEbi47BHhEicqrqDxZtpB9HKjySHg637AIx8riInK6IzZGPWrbPcBbNOZxkQl8Il/BKYaPM425cIdvcRYxzANtQVqKiZZU4kX+OFcLSptHP7jYWYXucIBM9fF1hfJkB2Nf5UJbjl9Jav7n4pHjSMllfCsy3nNZjg7GMuF1k+Fw0J9WLg5MsJqZa0uB76Y/PobkWC/irHO8P4q5ehsof0nVO8SsnWMdpBF/m2YR9hFkenE3Dd6UHVVGl6V1rijkI1QiGZmC509sKIVd9UG54OWKez+TReJz/n6JOUh2/HYm6dD/avw+eza8XBtCcchKdNShRcZupo5RCgznGCQFUzzWt46J7u92VUPVYQ/utrqj92r3MFnSsFejyRB6jitx/4o4aHqR0qgQBbQFt26J6/coVLqPrRInTSqGd539w2sYaPa/MmJ2n2v6uYe+UetTTNTG3SQaTya/7nc4HABJCRdqmyg1Q/wPbE+Z0jXMKPcNI0HPDBMSVxDUf6ZGRZaxObC5EQ5vH0ArdSF9E+rpHv8/B/YkhIYy/ToTaF5S+pN7sl4adTg2jdzgWCXQxg+cmyUXtFe3bCljOMmsVFFQLjr/A2Itg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB7920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(85182001)(38100700002)(8936002)(7696005)(86362001)(66946007)(26005)(83380400001)(66556008)(64756008)(66476007)(66446008)(33656002)(5660300002)(8676002)(55016003)(76116006)(186003)(122000001)(53546011)(38070700005)(6916009)(316002)(6506007)(2906002)(508600001)(71200400001)(52536014)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VEphTnFtTkY2QXNISUZndlI1M3EvdzhkTmg4QnFKWjQ2Q0E3UmNEa3Zh?=
 =?iso-2022-jp?B?REpNTXUwWE13YzJZODBWSGtzMmpMdmxaRHBVS0NZUkZpaHhOSnJvRS82?=
 =?iso-2022-jp?B?M2NyZ1NDdThLZW5oWVRySWQxK3dtS3ZPSGplVlRJdGNjS2h1dGdtN1Nw?=
 =?iso-2022-jp?B?dTVDSGpMUFBQdXEvVW9lTnB1dm1DMkVlK3puak9IRlZrNWpqQlZNRVJK?=
 =?iso-2022-jp?B?ZndiNHM5V2NqTkwrZ0FabVR3WGhOQkx1NXJJTW1DL1R0elFJdEkzMFBZ?=
 =?iso-2022-jp?B?NG1XZHFuRFVONFV2WndGb2w2Y21CTjllNlV5MWd5aGVIdU5aOWVoZHor?=
 =?iso-2022-jp?B?UFlaMllZb29nWlBVQ2s5MkVURk85ZGNWNzN3RTVhVlhoSHRGc0QyOFRK?=
 =?iso-2022-jp?B?bElTM05YcFplWkhsMGFvWUxjRzBDc29zRk15UFUzZUg3RmQzNElUTlVm?=
 =?iso-2022-jp?B?Q3Q4dXpFZ0RMdk5mRzFKMHNFdFcrUFBOWnI4OFFGYWxiNU0va2FPSjd0?=
 =?iso-2022-jp?B?NWtGc0RjWDJZWThsY3BRT0dnK3R6Unk2Z3FiTzFsSHZJUGZaRFhQMENB?=
 =?iso-2022-jp?B?dXRnek8rUkNRRlRmQUlZdGR1Ni9YdU8zSFBCVUZ6S2Q3eUVuTFNNYk1C?=
 =?iso-2022-jp?B?cTA4K2h3a1M2YWFnY2g5aXVjTFdwT0l1RitQWksxQXcvSHJucVYwZG9N?=
 =?iso-2022-jp?B?OWwyekJhUzY0RXYxOHg0K2owdWpVRXV1RkJaL1lRWlNuRHZHV2JLRHNG?=
 =?iso-2022-jp?B?M2pJU3VGcXhwY3EvanlWbXFKWGVvYndGc0RmbEhkeElBL2lqNGxjRGtD?=
 =?iso-2022-jp?B?bXg0dU9Edjdkeko3c09PRUhJaWN4Njc4WmtHU29XMHpUaDRyWENQZVRp?=
 =?iso-2022-jp?B?T2dPcTRnQklsTzdIR3VWVUxWZ1pmQmxwbzRmeUlGWlNaMVFrOGJtQ1I1?=
 =?iso-2022-jp?B?WitlVDVzODF4ZEhFU2MwYkFvQ3NkMFBua0FuL0V4QnVoL2tybW5lOExl?=
 =?iso-2022-jp?B?Kzc5b01VRDcxQ2FCMm0zT2VYNGx3dlJxSklPNWxRb1pwTGI5emRFTURK?=
 =?iso-2022-jp?B?czAva2hPVkRjOWZNSTdpR1Boa0ladEFhS2tPY2ZXZWpjTFMxQmRGUHlL?=
 =?iso-2022-jp?B?RXhUZ1J5SldzaXRTUlliU0duekJRcVNaLzZkdXJ5azNrVW5CMDJ3R0pj?=
 =?iso-2022-jp?B?Z203OERCSkpnMWhtcnV6TVVSSVc0RXdIdXVJV1kxeE1GWWt5TUxMb0NP?=
 =?iso-2022-jp?B?b1pqSGUvNnRzZ3JmKytLd3cyc3drNFhKc3ozWUNKVSsrYWduTzBaTnV6?=
 =?iso-2022-jp?B?T2FEVHlLT1BSS2Mrb0lnNUZza0xsRUVUdDFYQmp6cUF6aHhGWXF3NHky?=
 =?iso-2022-jp?B?NXZjZXZBazl4Nlk3RmdjdU9SampaYkNRSEg5U2lMN2FjSmpidE0vNHA4?=
 =?iso-2022-jp?B?UGtWYnVGcVpZTXFPK1NPTEVibEtDMFdSeTd1dDRDT0FtR0RwWENPRWpM?=
 =?iso-2022-jp?B?V3R1OUk2MzczR3U3VVB6UWh6WnAzT2RWS3JJUmp0YldmcTNZYjZYVnB0?=
 =?iso-2022-jp?B?Z2xHWDV1WURrelpkMlVPOUV0K2tmVjhlTGlmUzlWY3RnTGNZbG9tYWRL?=
 =?iso-2022-jp?B?elRKL2hnRmVSVTk4N2pJZzU2SFptS1BKRjVIelNRV1lUYnRha3JkVnQ1?=
 =?iso-2022-jp?B?Z2V3Rk9xck5KOGJGTmoyQk1rNk1ndU1veFlGWkd1cUZuVFkxcGpxZmE1?=
 =?iso-2022-jp?B?ejM4RlVxbm5TeXZVR3R3MmJYYWJZanNTL0hpcm9EWjIxMDlTSHhWeStx?=
 =?iso-2022-jp?B?Yko3dWhWUWpHUzBKL3pmQWd0UGpiNXhLbHFJNGNUTnFHTEV3Vm1IcHZJ?=
 =?iso-2022-jp?B?cWF4M2RaVXBlOFRGd2JoWStzMCtrSG95STh5WTByd1d3OGcweFBBQXQ2?=
 =?iso-2022-jp?B?a2d6bVFtM1hCNWwyTUdnQTg1RkpYY0hvQlB0VUJ6VFR4MklsdUdSY2Z1?=
 =?iso-2022-jp?B?WkZvNlp3d2ZYVVg2c2RvRzFSU2ttTVpoZ2FPaVNVbzlPeXZIRlJFb1pw?=
 =?iso-2022-jp?B?VDlGYVVnQ2xRUWptQ3VtMVFFd0UweGxoTE1MTWZGM0FWaG9JOGhvUjRr?=
 =?iso-2022-jp?B?UFJ2d3djSXhxRmp3WWJlOVF1WmtMbWtScWR5Y3FwL2hwOEtibGZVdU9T?=
 =?iso-2022-jp?B?SmtZOGI5NmV4OU50NmVjaEM0TGJldXBWMGl3bVE2YmdMTi9OZ2tNTXVV?=
 =?iso-2022-jp?B?U2FFa3lZbmN1WkJValZyUk1paldyblAybGJFRVdQZ0lZUElveDhqSE1a?=
 =?iso-2022-jp?B?UFJvMlA4VEw2VEcrMTNRdkh3UnBVZE56eTdGYnR6UVdJWVAzYmxYbXBx?=
 =?iso-2022-jp?B?YXplUUdjWjhNT3NJaUpIc1E0Wnp4R2lqK0Z5WjlxNzRIaXZlV2l0VVZs?=
 =?iso-2022-jp?B?cU5sOXpRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
content-transfer-encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jp.ricoh.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB7920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07649baf-792f-45da-ce3c-08d9b2cb1ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2021 23:59:24.5256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e717ec3d-6036-4776-b72e-41f49481d91e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SA3tc7mnx43l1TkGjxTOdE3M8yrnTnZ8ql0z7XDfRaYOVuWVz8fEYmNRgBOCunKaxm9LZqBudk4KN9LLmN/0Pz4Htfp7hqWo31ADwt+7JgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7989
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello All,

Updating the kernel version(4.19.57=1B$B"*=1B(B5.10.63) fixed the problem=
.
It seems that bluetooth.ko and hci_uart.ko have fixes. =

Are you fixing them to solve the problem?

[Execution environment]
=1B$B!&=1B(BRaspberry pi 3 model b
=1B$B!&=1B(BRaspbian Buster 10 Linux raspberrypi 5.10.63-v7+
=1B$B!&=1B(BBlueZ 5.58
=1B$B!&=1B(BBroadcom BCM43438


Thank you for your help.
Best regards,
Hideki Takahashi

-----Original Message-----
From: Takahashi Hideki 2 (=1B$B|b66=1B(B =1B$B1Q<y=1B(B) <hideki.takahash=
i2@jp.ricoh.com> =

Sent: Monday, September 13, 2021 1:33 PM
To: linux-bluetooth@vger.kernel.org
Subject: hci link tx timeout with BCM43438

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
k tx timeout Jun  1 14:59:31 raspberrypi kernel: [2678208.088765] Bluetoo=
th: hci0: killing stalled connection xx:xx:xx:xx:xx:xx Jun  1 14:59:31 ra=
spberrypi bluetoothd[901]: src/adapter.c:dev_disconnected() Device xx:xx:=
xx:xx:xx:xx disconnected, reason 2 Jun  1 14:59:31 raspberrypi bluetoothd=
[901]: src/adapter.c:adapter_remove_connection()
Jun  1 14:59:31 raspberrypi bluetoothd[901]: plugins/policy.c:disconnect_=
cb() reason 2 Jun  1 14:59:31 raspberrypi bluetoothd[901]: src/adapter.c:=
bonding_attempt_complete() hci0 bdaddr xx:xx:xx:xx:xx:xx type 1 status 0x=
e Jun  1 14:59:31 raspberrypi bluetoothd[901]: src/device.c:device_bondin=
g_complete() bonding (nil) status 0x0e Jun  1 14:59:31 raspberrypi blueto=
othd[901]: src/device.c:device_bonding_failed() status 14 Jun  1 14:59:31=
 raspberrypi bluetoothd[901]: src/adapter.c:resume_discovery() Jun  1 14:=
59:34 raspberrypi bluetoothd[901]: src/agent.c:add_default_agent() Defaul=
t agent set to :1.108 /org/bluez/agent Jun  1 14:59:34 raspberrypi blueto=
othd[901]: src/adapter.c:set_mode() sending set mode command for index 0 =
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:agent_ref() 0x56=
8110: ref=3D1 Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:re=
gister_agent() agent :1.108 Jun  1 14:59:34 raspberrypi bluetoothd[901]: =
src/adapter.c:new_settings_callback() Settings: 0x00000ad1 Jun  1 14:59:3=
4 raspberrypi bluetoothd[901]: src/adapter.c:settings_changed() Changed s=
ettings: 0x00000010 Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adap=
ter.c:settings_changed() Pending settings: 0x00000000 Jun  1 14:59:34 ras=
pberrypi bluetoothd[901]: src/device.c:device_remove() Removing device /o=
rg/bluez/hci0/dev_xx_xx_xx_xx_xx_xx
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/device.c:btd_device_unre=
f() Freeing device /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx
Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/device.c:device_free() 0=
x56bfb8 Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/agent.c:agent_di=
sconnect() Agent :1.108 disconnected Jun  1 14:59:34 raspberrypi bluetoot=
hd[901]: src/agent.c:remove_default_agent() Default agent cleared Jun  1 =
14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:set_mode() sending se=
t mode command for index 0 Jun  1 14:59:34 raspberrypi bluetoothd[901]: s=
rc/agent.c:agent_destroy() agent :1.108 Jun  1 14:59:34 raspberrypi bluet=
oothd[901]: src/agent.c:agent_unref() 0x568110: ref=3D0 Jun  1 14:59:34 r=
aspberrypi bluetoothd[901]: src/adapter.c:new_settings_callback() Setting=
s: 0x00000ac1 Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:=
settings_changed() Changed settings: 0x00000010 Jun  1 14:59:34 raspberry=
pi bluetoothd[901]: src/adapter.c:settings_changed() Pending settings: 0x=
00000000 Jun  1 14:59:34 raspberrypi bluetoothd[901]: src/adapter.c:disco=
vering_callback() hci0 type 6 discovering 1 method 0

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


