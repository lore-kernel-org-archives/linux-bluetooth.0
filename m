Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF5DC32771
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 12:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIRMDE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 08:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRMDD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 08:03:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2056.outbound.protection.outlook.com [40.92.98.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B223F2314E
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 05:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7MAWUzjCdcYSszTmG0k0rmDGlKGxae+YtTaH+CtYy3TPuzcYp4ZYQ2xTMEDRvi35NhatAgNgQfbneAxH/jlWO04R9aZq95S+2D5YDgvkyG1nh/UkPBb9vEChcs7OhHk+4vKtKvsr8OcIXs3xz9jrJMflPlCl460vFLwTCn9yoMpFuzWqdd3acZ8JdXQSuj5qua0trMzSBqt+32eCGmGbg8E5slJIvVP4D3pBkZoWZkqaxeqreR6qNVT0x/Y2B2HqU88ZihxUvuITGDLB/s7zhpWBCXjm3gv9MGV7Dzv8CR3LrH96cDnu8+H3Uq/zmnDFieXNWLLojeiPKZQCPe1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7TV2Yh0je6pVVsH3QCx59DI87he9aJmHrnfel1EOxE=;
 b=k1cmmm6dwgehB/sKcVJ6ZH66UKKc9yxiRNxMD7QAYKVLqxFdm/nraQE7XbhB3RTTolcxYggTtasKJ9v3XHV7b7SDA2VWD5XB1mCZo3TK1Lmlqr+7xlTmEMvU5UW0900fc8M/QXenyNJJUsoSfnPogpnquz8dEyTjYVOdEsssY9jiXkhscsez76cRWazSYy5YZgZuTa4taodpalJ1+zp8aLWdi+m/YESOfNfeEtd0G2lvSteyimGQuD8GWAFkcupfrKW65VdeIPCob6lKauXZgDvqqVnps7QE7CKIDBhsrvQAH2hI1Tl1t4PByFOpHwASxUgyM+RgAmaOObRIKJofaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7TV2Yh0je6pVVsH3QCx59DI87he9aJmHrnfel1EOxE=;
 b=iM3U0x642QsAhVlaGtPa9gA3G8kdHYA2YBqdNXxs+MPsQ72jk7YvCJGxVZ4gDf1VmJHJE8uz5yN1seGmhewe45YulY2CR8sanZ4ktTOVS+FAJNfT4sYW1j8zO4SxBWlSeO9QWh9tffaux+T3WD8et/qlGH+dxaDgpDJoc38lfqo5iHX0DG7lYxgeyR4w0SIVB6jgBKyFVgSBFGWJYEKJKtz6nw9ykEAnWJJVgcHEgMEG1apA5hNUZ8yU6NNOv1Ucoj9XVIjROPNO/v4u2jS8CYJGIk/2EUNoZLOeUTMzkf3goVSd+iioY9AL1aKxpvCjUDI4Ss94AP7lKYfY7Xt93w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB2021.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Sun, 18 Sep
 2022 12:02:59 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d8ae:7397:e3d7:7a77]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d8ae:7397:e3d7:7a77%4]) with mapi id 15.20.5632.019; Sun, 18 Sep 2022
 12:02:59 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v3] Bluetooth: btusb: Add more device IDs for WCN6855
Date:   Sun, 18 Sep 2022 20:02:43 +0800
Message-ID: <TY3P286MB2611921D86D83105FC85ABE0984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [FY6bcZ1+ISvSkQB4pg+vVwBLkt1tWiqt]
X-ClientProxiedBy: TYCP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::7) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20220918120243.135-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2021:EE_
X-MS-Office365-Filtering-Correlation-Id: c2836e3e-f7b0-4fe5-5a20-08da996dbad8
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrMuqSpC5M8fPEteq5KN2ssV954eEMKhf2j9admw55brFf6bFNTga5iJx0Ru8yaEgY2MFnOwaGnOLdn3IoMoAghLx9k+EVCR7xI7HwD9Sk60xZ0MQzmLIpuEHcBjk74JEucDnghQpuFYT/jJ3mHeFu5f5FMVa6bemzJYfaNbEVi2i5pYX3DnzSXVOMxvdqkn+dNBRnO//NLW6NQh2fmb8Gm/vJYLyYbtlZqMABuh7BCXMIFWdIuJlckOozqx7hGvN/hMnybf80HW9ATstGDE57UhKpJkdAupIeVyimmJNRwadGXa67r6IEIywGtx/kwMRxUb9uyK4mif743Gy3fx/Qdxc14d0bze0VTtiGtxQanB4mqqwJpGFgyV6z2WdAL06ceqJ1CQqEhDVJ1JSesKQ7hjooNq6qatTtmI9OPtWdJEUUODdOVkWs13n40NYFipb8701xs9gfVvNcEbe2lWR6LNr+5apwcR7Kyylxw5myIGN9I+RVZDfUch2Xqmq6Dz+IYGOtWKzs71qC5Kwg/PKWp5mUw1xmGIyOIJ08U2LT3V+KEpQUBo0f7msmm5DpIWPp7ylhJRXFRvLJHxU+tbxEsr1IYlw9sFhL+/VJIs1TIjhkJRq25p1s71MHW0kWTl0RfBNBDtSwKmGUpiBAokhis6OyBBd9dI29ni/l0YZ6FVjvQGJ7ajFOuwg7ndpkzXgfrjudtToGPup7xuaBJMqJ3OaUVTzxER4L6paFYoudd13SiInVJYNrZwXwZl7Fsamzg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuhNurnF7uWHRWqTD9Va+EvvP3V3WHPhH4iNyUdV6emZqDE8MWWgRtuuTdvYS38f2QCd0Y+MBWGx3gbM9oIAQXVNa85yhRRhkLZgrZyfuVOaowEN/GmMQNkvNjXZ1W5p/xlnHW2tKwinn0MF2ZncItLIv0J5olD+bqfz4yReVt6UzbhrC9dzOaqE97a1091bbum33HRm5gFAQ6TJHxT4PQZyLp5TesTeyTFmr5TznLG7L1JccW5tNW5yEQ2q5AVVyni2w92MGbvo46Al6gr60nP/YMifdVzfg3EhFLZfS2zCiJtEJsF2sPOlZlpwGOqOq2wlTMfAA8fG48JkcZF8Cb9NMIFdxPmYoS/jSu46Hhv/9NWboxISl+LN8nScTZvPjkrJgiSEf5mX0MsGUMdBRukdiEjSLbmoEoChqOSdruj0WUGiqFZTLg6JAxNBvtAjjTsy5iNt6w0xZW8cFA4jggohk0G8GyWzKCxlgUZUDnhyUVluf1cIYqn73iFWabcjAutFWDzbc7obpnbWX4UmYuOVHNXhqXjR/u4xHKupmIhfx7blrzFkeNJp0vAZhNNoj3FBauyfn/y9EO5n2DgsXlMGnY8UB6lzm+hcD4q9ROcCCLaG9biqinvkdkgxzuT9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xunSLrCSe6sIKGiVxsCDnGNnRytUq7iLvcD52MG/nEcUPMK1jcfYGkKYISSc?=
 =?us-ascii?Q?4OL08QO0xuHNhwYIIr9LHlSMOWOWwfABI3AjIZ2ou9DNhfbvHv20BDgwBcgP?=
 =?us-ascii?Q?8xb60PKqtv+iDcg+HBQ34PL/TyyzN14B/wq5Hl89LcbudxgPFmHw7R6A+bhf?=
 =?us-ascii?Q?tFLNZSd1sV8iH+DmdaotQAd/5ouu3b62dH86dN4Bk0OYckFyH4yQsOdJsqD7?=
 =?us-ascii?Q?lZyubwzu0NCswKv5hYb89yi7Fe6gf3AxSADN4/rElwZR5Aw0fuJDA12uVmZF?=
 =?us-ascii?Q?NOFIJ/rwVQY2UQtmv0B5dOZwF434CW+IoAy+CKX2qI9UMA9+uqRKwbJXHw/f?=
 =?us-ascii?Q?1vpKVULjEC3D/I0llZAO6b11EBo4E3rgc8ZlUwS/9Qj9wGsFslilP0xqd85f?=
 =?us-ascii?Q?x0KHy3C3POHUDFA9A3P/JdlrS3kS2KO8lnSxEyTk0STCOze1SGvbXty8s0Dq?=
 =?us-ascii?Q?ea2v88YEQDjZFcc+j9CaydnNNm5Mn1IKyb8kbmwi+AO0XCiZYJjdWBucAyBH?=
 =?us-ascii?Q?Wn5AI7tT/KinuVcK2Orlf4A+53khJav1bTasS/Djwc3MQzrEtdRz7acGB6u0?=
 =?us-ascii?Q?prfo1NEiwVD4dmtyETRoEvHx4iW5nVuQpkZF50uSil9DEQ8ZHiL1sOJebp5T?=
 =?us-ascii?Q?pgmdvA+KYu56cRb4OeThq5YlaVSXNycK694HJsM0dI3LihWfvCAXPwpCCvWf?=
 =?us-ascii?Q?JfGQe8HJB9YdVMlGCD7zZHKZU1mj36GWFIZ4Q7KIst/ddBLwtObZDxN/vdJj?=
 =?us-ascii?Q?DOyLaRPd8J9lqcmzWwx7ig7ELA9LDKm2Ck5Tw8/wQ2ynQEJEhLrLGCO6EOEp?=
 =?us-ascii?Q?riMsAsrQMVMPPT807EfHFofwIpGcOFhuSim9gVjWsONAT/KdhROTQCI3Lo30?=
 =?us-ascii?Q?4MgZ06BEMxkhL9r7nkTwI/vO2OZxIhCZCtDBB5ExkXlOShSDCT3ghjhkgLG5?=
 =?us-ascii?Q?3jKy3ljPs/8J8NPvtgTwkla/3S21fj4u1Jcy4q3/nwCsisrT6XmnhDiDvSlF?=
 =?us-ascii?Q?I71jRyJBFR8Uk1LOXSb8NpLrJQvttvvOmm/MgmZ5Iupo18zp1rlmIG/yXvi4?=
 =?us-ascii?Q?lyy1QvKKFTfhI0DlZraIkrXUi4tqd+BRzfJDnogLUvaRFK6AqIWca1aJMxms?=
 =?us-ascii?Q?WWcXrJvVCHe118hyEihqXuZzrL+AdnwJWJ5tCTKp9Ipg/lQeJXfxRvcmWIf3?=
 =?us-ascii?Q?hDw9iL7VwpXTMq/lZKLk3TVvJnwIs54+gOFZni+znIVGiaw9GCnbzknNmOhL?=
 =?us-ascii?Q?Hs9Dx47jNE6LVX2mIfm4LLW+IG6VzuaczQ8/04pa6Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2836e3e-f7b0-4fe5-5a20-08da996dbad8
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2022 12:02:59.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2021
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add IDs to usb_device_id table for WCN6855. IDs are extracted from Windows
driver of Lenovo Thinkpad T14 Gen 2(Driver version 1.0.0.1205 Windows 10)

Windows driver download address:
https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/
thinkpad-t-series-laptops/thinkpad-t14-gen-2-type-20xk-20xl/downloads
/driver-list/

Changes in v3:
- Fix too long address for windows driver

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

