Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A00C32771
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 08:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIRIFF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 04:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIRIEq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 04:04:46 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2080.outbound.protection.outlook.com [40.92.98.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDEC2A42B
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 01:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGdDGWDFqMpTCZno2eKe9FhJBgeUBMlQToA3DL24SusqS5maPm/V884HOQCPv+vd3QMKm440NBWEmblavE1lhgPoPC2d9SpNMbwyFi5hsTgWmbwlqDYJA7gFGzYBhV51IWe1WZkVumva4gYQsdf4J/YQr7YDV7o7fjKwbJdq/vP9K9/863Vj1tNPl796HfmoL9bBG8jhSNq/CgZIogsR8GiyiJPYkrSwWK51XfjLqTN7lIXmd++JbJ+24WzmBHe6xh5xka0o2wlCp/hrxa7mGAwqf/p37TC4mdfqixhhikeEoAlRUE4aHTWIzY2oysLGHNZD1WUA9eQAnldVVAUeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+oCUlElLdJKeZKUdcQJA+OVNrrnBREuAOFo2ZQiF70=;
 b=FcStwkpk3G8DPBJP7uK3H8S5VQu7mEtzfYjrHK7GFb2MwA5s2W+NVK0O/yvUAy0KakEvvSEPiDa/dD53mq13xxhitMD6NtO7r5JWkzefXXnF2N6vI4q+R+COLP7rL70Jw3kjrSnCcaaq5BWVu6c0tAnrmsMljetQmJZt+s1lrL8JBuUKltdKUh3j4PqNrGtT+RFjzGiAGzv9lV/ckbOTHgzYNH5R/JTtGveX/CKbq++t0uEMn+aBNssP0zim2mwVP8zUOmP40cV+rc0JdDE2P4/iXMmM4/wWwzuUrLjKplvHsWW3hzGLGqoMgvR4rh5J4PsrCj9HzSG7t7Qcw2HfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+oCUlElLdJKeZKUdcQJA+OVNrrnBREuAOFo2ZQiF70=;
 b=mFBnjw4Kl3u5sGbZlF6yX8VYqD3fTvFD/1a+hiVuygZLAi4bkQtrbsnu6ZiP2FjONS1Sm86FwFkkk2Vxf+GUoNgVa0KeL7GmrbYfOQA9231J96xiygVJCtCqiVQKJ50jRDTI1vxcstjwvvrY1oGqPerJdMDxcTPVp6bod21lfG/KwzkSrieQIm4IMqVvcl91WOEhapXUI9QiQlkRfR++ozzQrEKVucYhr8kzZc7+N47wQdKoAN6VdYdE8P9KcMhNk/2MjrxGBA3UubR9dxZ9Ny/Fo0C9nDM0newzB4Qr7ZA7PxwQDAPMWtX0zw80QUWzXL253mCJ0mGhbre8TTnz+w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB2006.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:165::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Sun, 18 Sep
 2022 08:03:23 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d8ae:7397:e3d7:7a77]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d8ae:7397:e3d7:7a77%4]) with mapi id 15.20.5632.019; Sun, 18 Sep 2022
 08:03:23 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2] Bluetooth: btusb: Add more device IDs for WCN6855
Date:   Sun, 18 Sep 2022 16:03:05 +0800
Message-ID: <TY3P286MB261158D091A010380F30E539984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cp7aWoBQgpaAhhPK+zCafq2ibeHc1sWM]
X-ClientProxiedBy: TYAPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:404:28::26) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20220918080305.337-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2006:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc45a2b-616c-4545-24c4-08da994c4236
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrMuqSpC5M8fPEteq5KN2ssV954eEMKhf2j9admw55brFc/X2/bGVJvJJ409esX4F+j5AjtAgH8vCFRUG5oq3pHbB/FS7A94VRNT5t+sVjQkTTG+CwTD/4v/b2ap57w14PZ9usP1O1ecKzeBO3/TPE20S1yt4Lj2vt23P9u2HGEXI4rAS5o+mPlevuTIWGZ9IAlC7RkW2F2luFVtukcx5zsiapk9ld89/Zk4x9xww6WyECqEQQBWNXSzUnO6eEbdgWyo2FpjwZCThvplxWDUl6xyViI+4r1BAUlsHA5OMJKeKsFnBx1P4ThDZa+t28g3CKvQozgmfYvrtmfeo+FHJP4u0fwvaKhjAlTkSn0vIxvdqf+GW+asAQUWjYo8I43E7H2aMlm2+rHIkcoERyC7DcR6GvGa/wCBQEj/iA97NoMeor2HsFzM5X9hjB6PNKAXK3Z8TdRZBQSp4PeR2KYkQ7PnJcQhapGNRYnLMd6WDZutO9UZ3YyfkmvRPZTcef7ZfPXOIWYcjtJYuBYsepvkxAA5bS3cuf1cYoeGLwQt/kTmqMs60Rr3E8BmqETp2BA+EW+YR/MCIoPeHROgjnMFUt8uxBkQXZ3/kNIx/ruqW0Ut6hdNI3yDCWZWiN53kK+2m+Ks7bAuF0mph2lZqOwmbWJQhqlDS5b4ozoY9DtDw8yRIoXQMJ6ei4RAuQyJTm4ZF/v8NJ7BZ1SGpX1KTeZf/owe46/X4jonyFD7g0tyRKb2ILLUfWZXMMVu8YbRGEQfi7A=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kh+PzQsTa9l1iQQtL2K7aK1N5QfBPKQRrPOW7YxI7RWBo9jUheijhi2c5OgH3ze9qXX/MLa2NfTZcVBSP34+cbpLpxJr5p/B6bYk1PJNM5J4tIXdIFS5qJmo84owey0ONzthycbUCdR8nCyYGo/UNm6xYc4zl951S3JzkahzNG9mkmBi39mdUqyOORq3uYN4pu1zFrBIzt0cH6f7WtiRzp017/OXk0OFzhsU7ENtiJ46olFb9ucT8ZacWejAyAq7xhs2A6y4stZc4rlk877cw5K2FhNAR5QUyg7nDkDv88Pxu6AiaMb/ItsJbrXo8uCnqyWlC8kVdIalk6VQAdmmFAnO09tvItUKgDYQxgjOrfnKqsgTmehf+ebXjKz95TZ+7qMifPzWUOuEgV7eAZjDhuy3LBD2FDrlsl+vT9epEkUOKkIMLminI/lyh5fH7WuaGvzDLoESvpXe/N2j8LPBvLND0fkFqka60Thu1L2sIhrDBI8QO4F+G/Lh1/1xr1vPSrA87VTTKO+Q050R5CWgjQP6hrWpjVJ0NI1uQ7jx1Olu/z2JENQcKVW/O5t9OYeIxqF84v/A+IvRMW0qtvgD8jlGc6mNp/dowjaNOSBBkdNTdGM9IBdnNAqU5sNEg+dp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEhVasljO5FURDOBzg446u6pqhiYyTUsMoMcsOsBkLeL02TC3zbI2D/WEzk9?=
 =?us-ascii?Q?L3kluRtssFzRa9nEkGlRuy6ps3s5z1nN89ynhTF5xJiQ5RNBNqZ8BJIn/CzC?=
 =?us-ascii?Q?bkypNFgaHrZIilG7dozplWEfIxePznK5QXuaZTFsPQw94UotnG5D8Bd717Tx?=
 =?us-ascii?Q?+ZmaKAc+PhisKVz8yrbHfq2qnl/SuWfemgotB/HSGHO6mx804Hbw+eO3fN3Y?=
 =?us-ascii?Q?pt5inrSVDEogS8Zm7jI6j4/1qN0T4lvXikuBcLRaspC3BOn23MYmRr901BJU?=
 =?us-ascii?Q?txfRcPkavMh8GiTmqmUb8VB1+K0R5cfvMmYKNJxFOLOPX+vTfc4hm4YDkT/c?=
 =?us-ascii?Q?RcjYkqrWPTcXnZMdbn0vmcinggPY9sU7u32YzpUE/WeQVzxfaDsy0GKR8M1c?=
 =?us-ascii?Q?tFCVOK5zLFkAoc8jxtP5E6NQRz56KVCenVVeEFuh+enmBFkotfsWOY0G9Wf7?=
 =?us-ascii?Q?OeMUY1uEHddzk4NVdN0NKktnUZEy7/E3TRFhuouofdkjpcUE16tctkw60jJd?=
 =?us-ascii?Q?AycuQbELaul42mynVyuHDgYkde7MIcAc82cYCuDf5YCVms9UJAAqMUpjXErL?=
 =?us-ascii?Q?TCzq4vbDsuieb/dJxZ5tg+JLrUhnx1hfyWcI5+3lY3fiu3NoAV2IEm320PPc?=
 =?us-ascii?Q?jiG8gMMceizSjJ5CHbDAaRKUFdBtV5cRfLDADjHapc2/ueN8hkj3l64QkuaZ?=
 =?us-ascii?Q?lEAzW3noH+lqFUAgptpk+DSCrMiDbwgKk9RW5D67Pk7SEWVQiwUAS1QEtLmE?=
 =?us-ascii?Q?tIVIZidTn6dmf8ZiX1ajy6nFT9tMAEj02CvJW8lBoxaXnmiznP3fkPO8x6xu?=
 =?us-ascii?Q?HhZ/VABIwjrQETLxOXz2e4zWS1y9K6B3JOGJAuT/uoOaPihlooJjciowRvuJ?=
 =?us-ascii?Q?W1O1m7O77Jkan574gH/OX1rm0DpJKuwJkl1/ay4KtC6PrqIb+dG6BtlvDy2I?=
 =?us-ascii?Q?rXa9mCFAS5hPoNUn3DMfTP9z2fOmHNnZbCx5OA0vSdnbBdIbDUHSIimv4vBn?=
 =?us-ascii?Q?lN6thO7rBRTjWbVMtY2ES9rEJ3LUegsS1u8k20WXFrdC+vvzjHxWqz7lfSwX?=
 =?us-ascii?Q?ZsQ1J2oCDvE2JKRmgaEG4WcxfTgFYDVwNIo+Yrs6z++zZesmvhHfwgF2Y6b5?=
 =?us-ascii?Q?Aa+IRjaGwD49mLIMxlmdjYocma+JKQaMtw0RWq40qm9nqnCmKyeJeMvUdWgl?=
 =?us-ascii?Q?nAysSLe223AeGlu4sCRBKKT+9Wbw5lA8DYutAXLEM/o6KHk5DenHNqtJ3KYf?=
 =?us-ascii?Q?rpSMmAihQ8OdGIewJV3iqW06px3+HHVE5fq3qvGg8A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc45a2b-616c-4545-24c4-08da994c4236
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2022 08:03:23.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2006
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add IDs to usb_device_id table for WCN6855. IDs are extracted from Windows
driver of Lenovo Thinkpad T14 Gen 2(Driver version 1.0.0.1205 Windows 10)

Driver download address:
https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t14-gen-2-type-20xk-20xl/downloads/driver-list/

Changes in v2:
- Reflow commit massage line width
- Add driver version and download link

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

