Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C72C32771
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 06:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIRGkx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 02:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRGkw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 02:40:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2074.outbound.protection.outlook.com [40.92.99.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EA61D0F1
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Sep 2022 23:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4sCPhhTw7yN//WA314WoPU5hNz9Tkr8iNfCsCgAtSRpKE0+uTFIQYHTnLHk/UcP8wzArplbE9mvUPLL8MMshA0L+MraqV5FSjP8wwqxlUTWUM+ZM4TdW21kTYQyLFTF/SnxU7SU/mrIC574A5xH/C8JYi6DGbiHdOnWTO1jXETnc+71PREaTHQe/sqSksG5BR04Y4g2k9xAjS4Uuytn9WvsK58fmy3krHs0H8wKsj2anO5bHHP8muLr+ONWCfn4pDpGsmmqn54g54lvUzrAt+fuxG3/UoEK8d9JZetVhGBtRAKEqM8E1RHmNU7y0JFmh1J1/0Y6FALaqDfCbM2zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCGSHCZXJoQSbW/6v/Jus5CtQUYtVsGdDiVZxx6w9Vg=;
 b=bS7b8zdyZKYyN9EwalA2UpfOinSl9hyWUD9SJdJo0YyMFT/6sGPA/rqGPfNhENl59L6o9KOCfgZa3PxIv4AFKphmtftOQXbRjcxbLoopmAD2bk9cMOPZ+/0g5mBVXFxbNmOxg+0hSe3tJ0xAOoSEf1YTS9GvSscdwkIHmoxKsOod0gHUZdRg0jusNGrvoAjsNSGyt/roGvzLe/H3inRAKTZJOZgDJtYTrzSPJU/a1PG14BP6Q2pNvvfGYCmFCKEtKhg+iluZwK9jmcEk+LShyL4Mav9wD5+6PJhyfFXPuhJ7dicy6iXW0nQBnTKMYxSXJU5gwKrI/bQkPx6EmraD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCGSHCZXJoQSbW/6v/Jus5CtQUYtVsGdDiVZxx6w9Vg=;
 b=Nx7xj7B4Kr+bcyzetiu9YdA0g9ulTv/3A32gijLc9m4D8vygp4mY5Kx+zhhuiw4HNp/tyHbppFZ2YaBlxqBbk2yuUcXwuE+gCjBRpcrH8+FvMXfZHXzQorxyA8WwmrB0NFf28rZ5YVbdpRDQkzSoSGlG5Zolu73R2nLFoG2g5WcDBKYORFCsTKBl8De1BqhJsa8UCoae123MY1vPnBbWfWIiBmcvgc0IVlKyCE8WP8EWRMzvplJmjeb55aQBHjruObBCJ529a3ua2u54MvdJQO4TLu1C4gAeUvm76IzCcw6nIBXAWzFhmC6gU7AQVScQbqbjRDsXsXnRHGdxCTZu6g==
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f9::12)
 by TY3P286MB2628.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Sun, 18 Sep
 2022 06:40:48 +0000
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::76e9:5242:9641:12e9]) by OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::76e9:5242:9641:12e9%6]) with mapi id 15.20.5632.018; Sun, 18 Sep 2022
 06:40:48 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH] Bluetooth: btusb: Add more device IDs for WCN6855
Date:   Sun, 18 Sep 2022 14:38:45 +0800
Message-ID: <OS3P286MB2597907F01F1935AF89ED52D984A9@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [vOwLPhgzC9RI4GxpPk6admm/tAMCDArn]
X-ClientProxiedBy: TYCPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::14) To OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f9::12)
X-Microsoft-Original-Message-ID: <20220918063845.2196-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2597:EE_|TY3P286MB2628:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb8f1d9-e91e-423f-5043-08da9940b8b7
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnqwZHg0HfSFdi9a7pamOgV9+D/g6kCHnOwnWKkFMerO8Hux0XlcgZwlC9PMXFWUwUHpcn6nzgRPsOSeeQpfIUqHVUgtsGqVEti6729q5wcK6omXpsZxrGIk1uQJCg8XliVTyeAQ5Zv1l1xl4ZE7Wz/v/OCfQ8e8/g4dtVYSZTYp6JYiU10cVt8mhHVNibNTdy13gM7e9PD3q0lgGjTRSzjHpM3cgqnaGVE2buvAKJsUQ0D6qSG7KZkk/zVX7Lhjxev0WqNR4R361BSkkQDAMY/kUSQiBAHh4bgAG3FIewotfHmBrrKQw+Yn8VEjXWRNTeSEnjA5tvuQBUzybAJoqv/7f3x8wb6U28ttVup1VW51/5Ft16ZBwxgG9cq47Cuw2wwewkNY8daaHJk0ZlhCgJz9u0Yt/fUBtkuLw+9DceK1ZfgWZWdyVeXEIyQFgdis9CtXGnmk6xJnE5XsqNUmOBQvECGZ5IiIX3724w/TwHHhDjFhtMzrhZL95uxzAizO91mnVM2w41v85zsPoCG5wqJ3UMsmdlb7J5NM7eglIM7m7Lm/0zgUAS/M33j978DG4eyhGvtEKL0RcuiigaYloAd/mZBwJC9zyLR+2AyMhh1hRyjzsUrXngYq0i0kiogKVXQ0q9DOJM3svGFeYk4ByLy/ujirjfjDZFNak/ByjTSp7c/Uww17ky0aIerEbW8pbs6CzLwMfgYDFF59xPnob+c0TSTIc1IklaChEZpy9aiBH8tXSAvG0qo7N5XxGflLAx0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpCYPRaRmeSI0WwM39hHM3ffaSYbzH+HwZPkHNQYy8BOhwCDly6c3sThK8zrYcCusjpwWpw80zwLfivFbxOr+y3Ytc9TB7POqmi9yx0Q7dvSQ6R4mj+QfI5VdPFkZBoPCAqNbXDEmlJH5X0/J6KuOx7Ws0B6vW5l+F/lTxDq7pQEbYSWtC2YQw9+TklR9iKm9wpBCJKUmQruV2KDTIeto9mtsBs7oiADz0QD2Po3SzX8cuP3xZFlcjZYbxKQOk5rBNv2QGJtkzyIUAioN3YvQAjXLmUElmcfK+O2RVApTjmyRFCnvyfDXKSOaHyCS+wMdC8cSQEre6z9yO7ZUkMAehD/kk152/rusBVbyGGpagEg//CYze4ONrItIATDrn8MZtKCRs7FwPlKuXt/6gRQ04qA4OfEDse/0lM5Qr2cLKDzgKH+cYC2B87u2b+uZoX0wPnizWqb27blpO+YfnJPlnr4oZ4DY2FeJlOVP71BKnZzcc4JF9En/Q/Fm2jOLltP+3+7SqN7nNxLTIcPw4I8s1CLXRgqbzs/Zf0kh9VCnVPUBz5uvZB2rqNGB9UG96mFzDQYmzADw8qf6JMfKM70DlSDCYc2D0O0oMOL0PW59Z0s2sdMhzaLVkUdzr1WWPEyCvCIyfbb51V/OGku9wBmCw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AE1xc8k06uDjB+txO3mIO1TiiPmu1WaUU4QWXanIBnDeYH2DWJOecPUXfJpY?=
 =?us-ascii?Q?BN93iZs8G10SfrjQhtOQA0pQf6umkO6vVvW/1Iysn63bsnYwzFD1CCU1xLX1?=
 =?us-ascii?Q?lhWMsn8Kw49JWqcpqm5Vo/+nKFxblFcq7oLlr6zlw5ttxkR6vGp/9RkhnI6K?=
 =?us-ascii?Q?RnEl3dCOmppIN5Kh65+7+jLJxqK+VXbp/iNq7P/E567znAQOmc794MrQys8/?=
 =?us-ascii?Q?ux9d8pSjFTEHA0yV5kH5VSF7DL3SzWTKkFyv09fQQRqYpX9ALXTH7Q0SXPIb?=
 =?us-ascii?Q?wza8o7lkfc7/Rk2Fb63uMswhGZ+4dZDnu8QMddahvgCddL+sckOPrvBePkas?=
 =?us-ascii?Q?x6lFRWJZpUA8Z8Ph7L8mJ2xf8CxGECmsqq91LLLm4fC/qHqZ1zbuxzEVXNxB?=
 =?us-ascii?Q?Wrqv0nufeRHYSk3gOhrOQi9fjLkYBKOC/Np+xq6JYBB1UHjrauzTLkFRCalO?=
 =?us-ascii?Q?vr2JRAt4bgeENTOMwWMbDswkLXri1LRB1/6XtWgzFBbxe/ZD4CEu+qvFmMCq?=
 =?us-ascii?Q?VBoc74pg6en4yk/GC2s4lJR1qehUSSc+bzeSbhDJnHrcbyYs7nkswbC6F/Si?=
 =?us-ascii?Q?+pmoZekCCfoMVe9t6P3vnnUJ7iYPHjvG2C7daRbRkFY3BKX3CNXtYJZJrYE9?=
 =?us-ascii?Q?eW+wiFhuo1W0YaCLHyJmDdZ0fcXFDicAdJDePxkPteHcigM0LCgl7OCxW1FT?=
 =?us-ascii?Q?oWYxfFC/UcBGAFxIoUmYf7xL/YCIR3hTlMMz2XuecBztRIYwmbs5iMeYV7Gk?=
 =?us-ascii?Q?mxZeFA5Zsr3PBlFnpRXFBTniY5sYmOPkKMhd3EH/wvyt5r8PZf+QyOWPbCvU?=
 =?us-ascii?Q?Cv6wSNfzhM2+xIV8KKAFK5k3R//WE6vtF5Mgq9+x6LZWMRZmaXrlvy+3y5Qy?=
 =?us-ascii?Q?8Gyy0m0r6P5eXATeXTwTkg/pwEWTqk+853vIgx7E4uEXRQM/8l4alGGlOQJ+?=
 =?us-ascii?Q?0GrNr3yTZ64q2TsYk+AG8TxC14OcOftzZWWNACgn0EdRWrbq2gEEKydq7scW?=
 =?us-ascii?Q?LEUqMNjTKm9uSab7B5tvKnTTtfyJf92tk5V/RtTENoEZxrQk3R+SQHsyvWKi?=
 =?us-ascii?Q?T4kK63quVPpD4pDvqHDgrOUXadZXkIpoOFnRVeFHoJhJi4icx+flcWpM3KB2?=
 =?us-ascii?Q?nDNSl2wfvffi1/hClhv99fktm6JVs1vUDajUu7Dg9+O4Mc2jNvS3idq169lt?=
 =?us-ascii?Q?LEfgtGEgoy4ePL6R81RCpN3f3H4phU3RGGm5WQ05rbCzitf6cgakNBRRuRob?=
 =?us-ascii?Q?EgUhoqUeT15Ai4fJPac2Qvp997O5G2SjHiABJ2EkEw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb8f1d9-e91e-423f-5043-08da9940b8b7
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2022 06:40:48.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2628
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add IDs to usb_device_id table for WCN6855.
IDs are extracted from Windows driver of Lenovo
Thinkpad T14 Gen 2.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/bluetooth/btusb.c | 84 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 15caa6469538..adf68affaead 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -316,6 +316,90 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d0), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9108), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9109), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9208), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9209), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9308), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9408), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9508), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9509), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9608), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9609), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9f09), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3022), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0c9), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ca), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0cb), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ce), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0de), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0df), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0e1), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ea), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ec), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3023), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3024), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a22), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a24), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a26), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a27), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* QCA WCN785x chipset */
 	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
-- 
2.25.1

