Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46413D6698
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036279; cv=fail; b=ONd62+t1wo/5vwQcnZ5sAWXiB7CT1D6/ckayh3bih94kUZZzlvSJ5tz33ZLoltksxfdE35jwF6wwEZ2NyDlHHqh3jyRmte9PN76pVVZaP8b3tRXEX+9g5TlQuIH/A3tdm/sKKWIXJFz3Mv+vjbPE6kI9apebUVsYYur52PU2Mk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036279; c=relaxed/simple;
	bh=zmXPyYp4iB0Kz0ByXlAF/FB28+rB1lB9gCubM6UPQEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFOj6NdOftgizAIePdPSnVKq+W16C6kD1j2njrxBZT3dipCa5+mZf3iGAR0KVM5+sn0k51XUmIbyW64WqIRsd3EigdP5FcHqJdDWyq0rGY+pEtpdjiVQYaZT9pNO/s6ajNzAP7wT+AXDoeanlmXMy47fSkz68PC7xJpWxphgW/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=bsdTMz0Y; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="bsdTMz0Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMzCemk0g0Q4wwVNSrcWGU1+Kb7ktaGgqkII/l7LabPdUGr2h7oO0tfVjIxCy3j8dkvtRM0AY5ZN/BOyInpJOfUh4lvdh/dbKFyNDkHlKUpuY/rGFbSbsQ0h1psirXRzeJ2Gc3xlmhlBpbX4E/5gOxfFDxwN5xmU+OFM2GHc6J+XKcx+boGFtaYSTcLOgMSzX45iyM7EG/2btg9U8uIFvMqXFEu4gnZUHROt3l7MZFRTJaRnbIPZPq9y/GFeQn5kSyO2yYhKFbLchpGbKIGvHmPaCo6emB96YxqrJxVijArrysevP3dzVpjOoa8sT8dH6jZ4uw87K59sEjEWr023Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3GvI3tIGH2SvJE3qcw993hDUXVeF3A1H9ln5QcYfGo=;
 b=hKKthqa9MOKSfhgFc3dNJx2GouK6uZNp+bSQM92Fdne0dU0BS949DZMoE4wwIUTth4I3YMBF6df0vG2HvzQbX09A/Vcme/f4Nfo1XWA/lZzhW5PPJgH4p+1vXjJSzgKtso9Ux4h8yR8EykdQIxG1EqmaICGLFCZdhHSRO0XOMf+mTGGYKfUWclM20kGaqmunKyhS8G0HitS8CxUGM0xwMnIIqejO5L51I29kU8cPKc5FuDhM9081K09wEBs/AO4AarjKTvcRF1VosLa9CkMFM4xx59202sI55+24qwezKhiu7H8Qx0fHKokpQ5pIo9DEknmQQVKATzV+5o4kJwyp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3GvI3tIGH2SvJE3qcw993hDUXVeF3A1H9ln5QcYfGo=;
 b=bsdTMz0YEruteLJ5cy4evxiLld3AG03pHLM5Y2hel162m3z0YcUU2HbZWvYdnL5GoobymFrn8+C6xIRKe3iSccpgTrSYfogAxeFBRe07GX7NwR/em+1i5C7jQBWgooearsIugZZdu03OKbLCirreaKYEmJmMr1FHuOR7HcQb2lw=
Received: from DUZPR01CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::16) by DB9PR03MB7401.eurprd03.prod.outlook.com
 (2603:10a6:10:221::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 16:17:51 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::cd) by DUZPR01CA0079.outlook.office365.com
 (2603:10a6:10:46a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 16:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:17:51 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:17:50 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 03/12] src: replace ATT_CID with 'shared' BT_ATT_CID
Date: Wed, 25 Feb 2026 17:17:06 +0100
Message-ID: <20260225161715.20394-3-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|DB9PR03MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: b25dbbe8-6f80-4d41-c9a3-08de74896c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	y+iBlwVo4US1mEw38ZX5ds9zG9CXUNes9Kf88WS6i3L06UR/Uma9qMdxC3rPNa9T+wm5M7y+Gad+vfWEpdy6QFUsL2AEXitaI6fjrB3eGSvv61cW+qgg01/iHeOVbkWB6MW+TjXLXH5elDwed2foLTtFC2Rmarm9zbBWhLE9r/je22ohOj9XXMrP9PLMZVrYw77CkuHZCKjwoZZJRf2viX2pXfs9TN+n8BBJydt8lJFgwD46w0RDdHSxfK6uivXOc/ENUGPz+GIhE6nwxwwE7tqyDBwrZxJCguZGIDp9Ux8LonAz8Tjk9wtOIe1qwtOmvop4xXdziv2d+wVwKY3LxyJeZ7r4tXYy2JEeQnn9ENIvzfduHTk5A91y5bjuWNhWsqOURxAZBKcEDW+OR0DVuCTjf1alzHLLBBG9rBTQ736mS4AtFjDOvMSqkTMCCzaeDhuaWMJKfqF16SmtibZNZnhuYc6gPmdd6XMSqGT/DapWdLeJY4TkaToTKQ3aIEy/nckGMcA+8e2TC+LitqZ1qFaLY7w5rmCeGrjTDh38aOcRzIVgB5qiKFWfz8MeADXi6FlJlgR6FjDJ7VyelW4ZuDeiG8/DyjZcvXeZU6SkVqztL9Ro+vCjG9F36OSM7cxxo2dlvRIVC2WZi03mGTKCmGZwzSFatQG1g9u+2lCes6UDqrslYfm4B4tPHRCLHe4qai6VWnEHgsXK1Oo8kFPIb37JSBAob6005b49hYrwukKm6PEHI99a/1Bm5dMA+Tl809U+IySAkcpFByXs/ZbL03PwVAIsUVZWkb2uZ//rxboyGOMmkN90YWvzS/vibrg+Ohi1N2vS8jp4NoHcV0ASPg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LpTiP5C15oC9eWfyJorDhF718Pp8oNYhUhPQfWbwAiqViiZHjm8L6w7RwivMS+znPeDZ8S46u0pur1HV876+tjE2JbhHs/JhnCCl+P1NYNBA7Ffx+wxXkTIfxC3Rv8i7e+q4e6AfiYIlpyRHpIWPbliQf0lwV8n/atyWky/q2LNeWbSrztFgbXsvlHe7omSGEldGTKmXIrVuLtiYHMpidPO1R8WrMFXjIhPbf6DlJHvwx6iMoMZ/2QEcqX0kbM3JYcwFCTOMACLmIhC8QJNK2nW2SovXSSoF9MUBfufKfsZYHZxdkF4mJYS6AQh2gdod02mNPIVcMG2IPuiHsGD0GhdWgU67rleCu26rgu1gzDDAUKW/dBlqO36Dl8/N49XHdEpQsNPTMd2JRme98q5QNc0ezKu5LhufSJ3DCaVxVjhEd1q2tnKJIG2g75iIAsQK
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:17:51.1717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25dbbe8-6f80-4d41-c9a3-08de74896c79
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7401

Avoid multiple definitions of the same value.
---
 src/adapter.c | 2 +-
 src/device.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6aa7c0ed0df4..9bb1950a9f7d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3768,7 +3768,7 @@ static void device_connect(struct btd_adapter *adapter, const bdaddr_t *dst,
 				BT_IO_OPT_SOURCE_TYPE, adapter->bdaddr_type,
 				BT_IO_OPT_DEST_BDADDR, dst,
 				BT_IO_OPT_DEST_TYPE, dst_type,
-				BT_IO_OPT_CID, ATT_CID,
+				BT_IO_OPT_CID, BT_ATT_CID,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 
diff --git a/src/device.c b/src/device.c
index af8df5f29b97..2efbc1e148a8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6453,7 +6453,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 
 	dev->att_mtu = MIN(mtu, btd_opts.gatt_mtu);
 	attrib = g_attrib_new(io,
-			cid == ATT_CID ? BT_ATT_DEFAULT_LE_MTU : dev->att_mtu,
+			cid == BT_ATT_CID ? BT_ATT_DEFAULT_LE_MTU : dev->att_mtu,
 			false);
 	if (!attrib) {
 		error("Unable to create new GAttrib instance");
@@ -6610,7 +6610,7 @@ int device_connect_le(struct btd_device *dev)
 			btd_adapter_get_address_type(adapter),
 			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
 			BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
-			BT_IO_OPT_CID, ATT_CID,
+			BT_IO_OPT_CID, BT_ATT_CID,
 			BT_IO_OPT_SEC_LEVEL, sec_level,
 			BT_IO_OPT_INVALID);
 
@@ -6705,7 +6705,7 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 				btd_adapter_get_address_type(adapter),
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
-				BT_IO_OPT_CID, ATT_CID,
+				BT_IO_OPT_CID, BT_ATT_CID,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 
-- 
2.51.0

