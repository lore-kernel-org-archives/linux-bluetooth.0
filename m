Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F16C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 09:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4606109F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 09:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhKFJoP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Nov 2021 05:44:15 -0400
Received: from mail-ma1ind01olkn0159.outbound.protection.outlook.com ([104.47.100.159]:16310
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230081AbhKFJoO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Nov 2021 05:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US6wsQVCzIYv4ht4FxDAqaDRI0yuXmWjBhqbrhV786X62BKMWW9S4pnjYtXIywZw7ZqqOG6p9JOYMfqo3UZsGN1lXMFq2FKYjXtsK2PhgZtrS4qJYKHgmbI0EtduV251fZAMFJQf7Jp3WW36RFZQPXAVYd5rBTRZB6bIXGfBZ5VJhrZj7qfhuTNFzbPqcSRpYH7I9fS8JvfdbrOE3d5rBeRS5/KlqW959NOLlfsDEPOnSOvRTKIRsJpiORN7D1zkaQEhdVkGYFLy87rNoFUM7w/Pj2Nf2HQVK2+S9TBkEhCMjHdjDbe7x6/cjZbboZGbgf97Qx9J5iOcymwEmuC4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GwRHhQMYlklxVdDAbHegzmpnG9SefwFQZ57JVUiE5U=;
 b=CoSDlR47WSSjkOBCbfBFGd4sBNqGDlqHQG1Rbvcql3Pjp9xsuCm+/LivwNRGe1hlwx7gwYxtTBvxi8Ot87hPnhopXbDMhzym+e2dgRDhluka8RYHSohrSi3+RfiX4X0CmuhMPNq63KBlxgK0I8s3h1Z4r5P92quCUAuDeONaCjDytzzRtrohEHujzqPdhkAeTebx5AJC4iaXN+/2EiyC6SS8zZfEKgjSg08BYIMmXEhoLbEB+u1eBuSiSwE9DIcP+jOOZy6zWXPeMzD9E5FnGCQ8Y2HO9aqNHjnIRVxW6ZCx87l9etNcZmF9/MizIZL2pyHe22x40cRK8s74DaLE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GwRHhQMYlklxVdDAbHegzmpnG9SefwFQZ57JVUiE5U=;
 b=MNHGpxZmHLMBi/rzyVC8fZ8MKQNgp83NCmjDLB/w3kFaUXshoNzyAo8Xq5GndMZVlecN7gIGE5H76LgY1jeoJQ5BLPBCGzeHsuoIFD5D1Kjsu8u4u/8nEJrGxiLLa2po+ss7UDCRTU5J0ATBjesewfs3v+CwdpmCQ8P7aFm8nmSEn1RbV8J3Ojd+vu9+XEVQRllPE7TXJPvFcV+oEemIxnJfSOGse7Wb1V1qGZYE9E6j5cWBoQtd4hkqR8R4nZlnTScUbn/VM2loNssXYk5M5khANGMERhowxbmx7eTQ7R3VPf3UDHsvRTPMdUgqQzNE6Mm6YAqd2bEJ/FA76dbpuQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4125.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Sat, 6 Nov
 2021 09:41:28 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%8]) with mapi id 15.20.4669.011; Sat, 6 Nov 2021
 09:41:28 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Topic: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Thread-Index: AQHX0vJ45A6zQVMGfEiNGmUN6kF0hA==
Date:   Sat, 6 Nov 2021 09:41:28 +0000
Message-ID: <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <20210930063106.19881-1-redecorating@protonmail.com>
 <20210930141256.19943-1-redecorating@protonmail.com>
 <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org>
 <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
 <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
In-Reply-To: <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [jWhyYCldw4MwLKByQ2bAaGKYzcOdMO2/4edB1oqoaDPl9i74zMcyihfRL9XtcavO]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08efcb7c-2063-4f6d-28b2-08d9a1099b64
x-ms-traffictypediagnostic: PNZPR01MB4125:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLyBE5Yq/5dW6zOvItmyKxi1VkzUHChlVZZ6GMehKJ/ABUANBZTkZ0wmREMFJK//7iwT0sW9bejEBkR/285nwzUFNaJTxhOruGqG5IIhtuSf9xLZKPsD24jpFXUf/tui/Jq38NvbUcisZQ1d4boF7+xkg59mw3Ma8Wo16snmw/yF208Xqg2sgoGwInJAfEgbBKHCT4Zf07qcGeubk0z7VfeIPWmgnzEhZsGz6hYhuy10ln21lOe+QaTKgr07xF8tqmsPlIAkUKi1RC3aYpkdeUemztp9bztJgOPKt41N/cJ5ASPfLKCiOxtzLpJ29+u1JUWc5yAtlXLe3jwEyXIxD/kbVZd5pMuC3f4jNrbcA2xwdB7WwiJmjoADYxKk9ceqq1tGfqr6QpkLmTW0midSRg7t/ohP2BTwL1p4G+gsWQCDZRVB8wh/mdM44RW+eJPfKS8+It0p8BwQ52q7s0rZZrOp5pYrALlo5oj11OmbpHRtav89jtkEVx9AQksHjp2KoYcEVkNNxHosVy1xJttNI6GCqqJCF+PxizBy8PzZe/R5Dp+b1IzuQwOQ6Se6h6DB5thrcEML00eGMQmJIdBSAg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: M11dFkXT4KdLkuVroQLF2nE+BKme0/Nv4w8jtIVRG004Jj0ZytbPSbz/UyDGDb9HvZgVs+V0MFbDQtD1SlGk+aqsZElojz8gwq20zfTGL9VevJH2xe+DgYzfMCccDLGr+imb0fZRQzkQ1f6/TlJie5XyPy4xCu4lYVrdpg6XeYNYQAj6ZzIoVbu8tb2MBBYqgWRsifQpx0HNwoJoE9UyHZGCD8X4m895MlhHhC03JHhAlAhkQSXkXGb/U3tiVqgs9n7a6j8xgTIAQ6c8KlsukTn3hRUXL78a4YGCQBNDdvuRm/vbC/xsNHFR89HrS85ItuZuptCTvD1fZBHSwY70xQwe7qme6DIWq8MqQjdmwL++ciHDt1XUHPj+JQKFCFyPbbIh/vjpnCTL0PECx4HKHmXVb84pc+jbDbP6sylFy6YZIepvNRWM8J16dfFletTHUBVloAg2NkFnAGArWAQ3nmOjkn3Ztua+Ayv/E3LPfhsiVwWKiV3RKHSu1XGfMIhYlvM7IJTwO7gBQdnHGla7pD7t1kiD72chiUfwqxD6Ih3hbg/y4JWnqvmLfTeMX5Ls5wQO6dTN7/IKxyRVtNM/YMgJJQhzpxrgpKYrmXVCGHud+psBZoM0hr2+0UgZFnUo9YQEaMa0o84TEBrHuFx3kP+ouG8tyOWmcv/R2joX6ZZwta8oUh4+bS5FVtcbTLsuw6ITYfp2m7/IlrSlP13rYeYEmR175k/BYT5kNDrOgRwp3B1K5EVHe972FNffH5/Ua+8LVO9VWpZ0aXmo1lzgRA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CD984402E5DBD4DA0ECC9EC78032FA4@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 08efcb7c-2063-4f6d-28b2-08d9a1099b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2021 09:41:28.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4125
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On 06-Nov-2021, at 3:17 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com>=
 wrote:
>=20
> Hi Orlando,
>=20
> On Fri, Oct 1, 2021 at 1:56 AM Orlando Chamberlain
> <redecorating@protonmail.com> wrote:
>>=20
>> The LE Read Transmit Power command is Advertised on some Broadcom
>> controlers, but not supported. Using this command breaks Bluetooth
>> on the MacBookPro16,1 and iMac20,1. Added a quirk disabling LE Read
>> Transmit Power for these devices, based off their common chip id 150.
>>=20
>> Link: https://lore.kernel.org/r/4970a940-211b-25d6-edab-21a815313954@pro=
tonmail.com
>> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
>> ---
>> v1->v2: Clarified quirk description
>>=20
>> drivers/bluetooth/btbcm.c   |  4 ++++
>> include/net/bluetooth/hci.h | 11 +++++++++++
>> net/bluetooth/hci_core.c    |  3 ++-
>> 3 files changed, 17 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index e4182acee488..4ecc50d93107 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
>> @@ -353,6 +353,10 @@ static int btbcm_read_info(struct hci_dev *hdev)
>>                return PTR_ERR(skb);
>>=20
>>        bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
>> +
>> +       if (skb->data[1] =3D=3D 150)
>> +               set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->qui=
rks);
>> +
>>        kfree_skb(skb);
>>=20
>>        /* Read Controller Features */
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index b80415011dcd..6da9bd6b7259 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -246,6 +246,17 @@ enum {
>>         * HCI after resume.
>>         */
>>        HCI_QUIRK_NO_SUSPEND_NOTIFIER,
>> +
>> +       /* When this quirk is set, LE Read Transmit Power is disabled.
>> +        * This is mainly due to the fact that the HCI LE Read Transmit
>> +        * Power command is advertised, but not supported; these
>> +        * controllers often reply with unknown command and need a hard
>> +        * reset.
>> +        *
>> +        * This quirk can be set before hci_register_dev is called or
>> +        * during the hdev->setup vendor callback.
>> +        */
>> +       HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
>> };
>>=20
>> /* HCI device flags */
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 8a47a3017d61..9a23fe7c8d67 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -742,7 +742,8 @@ static int hci_init3_req(struct hci_request *req, un=
signed long opt)
>>                        hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, =
NULL);
>>                }
>>=20
>> -               if (hdev->commands[38] & 0x80) {
>> +               if (hdev->commands[38] & 0x80 &&
>> +                       !test_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, =
&hdev->quirks)) {
>>                        /* Read LE Min/Max Tx Power*/
>>                        hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
>>                                    0, NULL);
>> --
>> 2.33.0
>=20
> Nowadays it is possible to treat errors such like this on a per
> command basis (assuming it is not essential for the init sequence):
>=20
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 979da5179ff4..f244f42cc609 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -551,6 +551,7 @@ enum {
> #define HCI_LK_AUTH_COMBINATION_P256   0x08
>=20
> /* ---- HCI Error Codes ---- */
> +#define HCI_ERROR_UNKNOWN_CMD          0x01
> #define HCI_ERROR_UNKNOWN_CONN_ID      0x02
> #define HCI_ERROR_AUTH_FAILURE         0x05
> #define HCI_ERROR_PIN_OR_KEY_MISSING   0x06
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
This diff cannot be applied to stable 5.15. Could you provide a patch capab=
le of being applied to stable.
> index bb88d31d2212..9c697e058974 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3325,11 +3325,18 @@ static int
> hci_le_read_adv_tx_power_sync(struct hci_dev *hdev)
> /* Read LE Min/Max Tx Power*/
> static int hci_le_read_tx_power_sync(struct hci_dev *hdev)
> {
> +       int status;
> +
>        if (!(hdev->commands[38] & 0x80))
>                return 0;
>=20
> -       return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_TRANSMIT_POWER,
> -                                    0, NULL, HCI_CMD_TIMEOUT);
> +       status =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_TRANSMIT_PO=
WER,
> +                                      0, NULL, HCI_CMD_TIMEOUT);
> +       /* Ignore if command is not really supported */
> +       if (status =3D=3D HCI_ERROR_UNKNOWN_CMD)
> +               return 0;
> +
> +       return status;
> }
>=20
> /* Read LE Accept List Size */
>=20
> Anyway, it would probably be worth pointing out to the vendor they
> have a broken firmware if they do mark the command as supported but
> return such error.
>=20
> --=20
> Luiz Augusto von Dentz
>=20

