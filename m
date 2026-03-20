Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CC3A963C
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020030; cv=fail; b=V3BeBV+IpxN6WqdrrLWMXXgxbObGe2UlJfUxux8yp0POJ++qw3GkezogpBm+sSi3Ccnw3zQ9SQKMr23v0hYJG5mQbjjwpKVOvOlhXmxHmfReiTas/DvU/2ETKlQFsh4IqDMX1ZgehtnjbxmSdWvJ/dxivxPjxVi86P8nJ5LcJsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020030; c=relaxed/simple;
	bh=DVN4xCJhS5gTaNGBjqcPrMZBf6R3FxNLak1jW2hni+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gURIN7sIW1uyg9F6bPlgXw/Mz1BbViwBBRfzlOPvCKM56m0LJ+tVya9VnvYsIurD/rdrbgKUH7d4lgi24A/BrQZKNHSlOSOrAIKcrcBn1GyeElJl3hiJSVFGHlLyO5gSgIx7eUVdco5VV9qgSkK08PvukWEyh1IKXl4zGTQ65bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PRxn016g; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PRxn016g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM/aap46LwsZaKlTaN9Hiu2UpLs+hJ8OnfUOhVuEpvukgzBQLFdkJULMsyIm2CJHaJwlutMeklFQK5a79u4N5Dlamy9AhrSY06i7R0kG21s0qct1U7pok04ClafvW76SY0bhfYWXIbVF/a1vwHnlCowKZqZRZ4pbq7xAZn90Ne2+p0YbhWzjQKOaL/PBi5Yj83LZ1aFQ/luoI+4I/28tWKBpEqukX40/jdOemDtcPsjMmQXDTw0pO1EdXkDkeQmDDqUUrhNEPp11JoNpBn5ZOXpXqRfBnhoX6norsvHqLlSsXMM1H875QoUYYmqjYUn1YLImu7V+PG3l52Y9xeB8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VNZDRzabnxhL32shUSynauHHkS4tMvMoKoywm/LO3Q=;
 b=kz1LnJPfhNWghSyW0alLUhs8kt7O69Bz9nqWwi0c67VF7TDcfcUP0AdbZk2Jh5UXMBtgMEy7D6LpuxlNG7zgAqz25f/l7hU2PUCytmzVhb544lyeTn2GjfnezzVB/r8poYGrrQRS17D/NFzUXVYhBnk8ga/ZvvIZIXr+e1YP/tF2msKp4XqS9y3+IZYCYHDUD+9U1tRrwA0SBTw82C60S+mS1/lOy7FQKF2XmDuFMBn8fIp9nf3Jsih0/X44hxK2o0DLs7bAnFwUwqu1UI+ccN8hlIAG7NLuHO0XcoJA4vmGrNsjaeSvco8zF/Wj752Yym7E7b1SgNupM3IMW6iwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VNZDRzabnxhL32shUSynauHHkS4tMvMoKoywm/LO3Q=;
 b=PRxn016g3A01td0D9iOwMwBZaMPwT8nCN5Qc32L1X8SSdvoR2lvAQ7q7n0P+HtMtR2naDa1scba6CHr/ZYbb82v+mD3E+rpX+8b06qIbwgFvlicQ/irBNdqf8rsopM56Df6R8+/xa4HaMV0VRMrcHEDDfwvaFCW3hV+pHBppHd2z2saZAN7N17cuAOZSRiTIh0U01zPGvZd+Cj+syl6qpqDFBRRdCNElJciXgpoZ7NWSE1rcGC9/M0pZVus0exJtW3P6Lnks/mDP3DPdeXa9VCMujZHoi6hptNGyDtHbiJdsznzrVM7VsJ0o+pURfMyIrH7fyrrwbwD/tnmqSsR8rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15) by DU0PR04MB9324.eurprd04.prod.outlook.com
 (2603:10a6:10:357::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 15:20:25 +0000
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8]) by GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:20:14 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org
Cc: vinit.mehta@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 1/1] test: Fix pbap-client to work with system bus obexd
Date: Fri, 20 Mar 2026 20:49:58 +0530
Message-ID: <20260320151958.851-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260320151958.851-1-sarveshwar.bajaj@nxp.com>
References: <20260320151958.851-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::16) To GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12191:EE_|DU0PR04MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e243bbb-c807-4615-61f8-08de86942f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|1800799024|376014|52116014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bDaXzDxz8ND+bD+aiHu32fW6DzDYFkNKIMnSA1inx9/ygXew6m9HVPdqikW4LrbVMN3aIsfIPgWAzt/qDREf46Cy48lB/EZWDb95qtvFO4v1JR+/7c5CRvsTtkju7UjZCRykddliLEFLUy1kXrUDCQHBqKka6X4yHWrM2OEB3sQrrlncsbH6HV627ImpTZnBSLpWNxhg/8WfgkJkkx3unr0inPoDjIOTSEWizVvfbxqX2/2/hatHY9xvfSpTFFt7tll2jBoEMt55lobzyottb79+NDQjcH9OEfIyoHLMinXVC1CJM7WWIhSITD8fh/iR8HjI4o5UlKXlyjtsIkPVaLaShPWOqM7i09WLj3MFqxR9fxrrEw+8IyesewzKY8TYsd4gVH7tcK5capOc+/LYVjVzXL5cx6p81RALWvhuhfPYmU6QzE36IJHaFWgr5oPN+L7B8Ox+OBxxCYo5NwHoMRI1GhtDNc/L1oZIU5QC27migGCthToupHRPM9USpOE9zonGlNPxgKivhJMpBQDMPHQ56dzD4HkzrLyuHB6iLR8aIjsGg42R4QPXmhEpyXG5z+lPdndchcQ7KGdOWQUlPvL0WhWqojHa9MXlc8mzHElnUfQ5wuCZhEoCEOTHxYN9Z5RVu9E7WiKhd79aUoH6glpWbA4BL+QmZ4wmYsVtib6m+N28jvkIe3jEJs0F3I7Jrwj0x7rVjll3Ls57/KVY6tC/7PJt5ev2dma63A7iAeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12191.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(1800799024)(376014)(52116014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FjthGyJsPk7LcNU57mDDUwaid9LuMKVN0OFzb1n8nNCt1VnQeTATPMDTtKU4?=
 =?us-ascii?Q?w5PwiCZD66U2MQbEoqxleX5T9NGohNVy1x1+gCMNXywhXpkb3GMWXOEM1Qsl?=
 =?us-ascii?Q?apvmydATeLP5AKVRyM384QzYBsiDz2AwxI94MF1B923N7KEBD3KRpjP1qbQA?=
 =?us-ascii?Q?ZiavBupqLcbaAEHo/90/idzKRYj/SFOZZJhoW7MSyu5SUaAFxdRsBidlVgMy?=
 =?us-ascii?Q?eLAhctMOPuT2Oh6PWdVDL/K3iTCy5EjDvz2/oC3AA9PALr3MOZ1V9fWtyQHS?=
 =?us-ascii?Q?84GxMaAu9RDsrsfc0yF66PaH/m+IpqyvltR8NRWu4Bfp6yGzsqvcr9bRlwu7?=
 =?us-ascii?Q?NIfruZqUItX6kgkERWyc9RAEwkJBSt8I07N2n3dnmrxmN670Y6X6qyaHnm8l?=
 =?us-ascii?Q?jFcNBfK29SyertGUkXYvE2fYgZv/pdw9DW0mzfgtt32cc0HRhJ8N/TKqiJhb?=
 =?us-ascii?Q?WLQwb4JRrFIWAo3h1YoXaySge5xJNtynmNg9QpGiPkAZWb8BZ0+UjFkQwF4P?=
 =?us-ascii?Q?viKZ665eUP6/kjnMEAovCy4GZuBpARWxqMgdwBw5V796ufBU4uV2LWaZz4UW?=
 =?us-ascii?Q?43wbFUvZNK4nCzoMVjDLW9+mYAmUIJRc8f0QzkS3DC/JkM0P156X2T4RI7di?=
 =?us-ascii?Q?1BmhI+EU3dwEo0NVf1ma6shtw11s6ZWrVqtIyzLhm7fHPScKH6A89X1rmpei?=
 =?us-ascii?Q?iRZfCRTRGObRZVgH2oWMTIT012ButuVbBZPYaeZ02gUk468NRKqxiJyoKaCG?=
 =?us-ascii?Q?lq6ldf5uJaVwkRE72OkGcoVVHUueKuCJnbHXxyrSd9x7UlMizN8qUTccF8Qb?=
 =?us-ascii?Q?iPf/OIeP121vdA7I8Gj3T0zehiH5MkpBMDpZPpXMMLf+C+0S+Qsxo7u8YYFf?=
 =?us-ascii?Q?FPlesrs0tLyyoWMcJDvssDE9ycjs0xrvAVfwHP+5BNGrwtzNScUA/vOvapJF?=
 =?us-ascii?Q?S6NVpJS5vmIcIm6OF+9gb7tDwQ2Ye23E20rZTmv9u/hElMEZuA7gIZp1WujG?=
 =?us-ascii?Q?+qrDGbr62Qf+PnE2AJb+5G6SF65gBVQ24ztaYS66XYzaS+DMpbHUnzp36fvS?=
 =?us-ascii?Q?azYqr7ucOGyCLq7WRwcV7V21eIreXMInhzKoTRwnn1nTHEqeIk6Mlu2+lLO1?=
 =?us-ascii?Q?/FX3sAMWUBcz5KNBFFE+i2Ky43nAiYdeY0ZbwHw3Pt97fatTOAXPAlPFornH?=
 =?us-ascii?Q?YHBeAbzD+yeLLIZuv9Uvoi6bVGGBFCbzVdpVQcn42kKbdXCoJ7J1+d1TD7pu?=
 =?us-ascii?Q?AofG+vUsvK90vXavzDnDKPOO7zWYreFn9qWr0DIHjEZcGtkOCY2pQI4vd6Yf?=
 =?us-ascii?Q?hXfj7uv5l7z45NUoTN6FpOf0iTjmRFouRb7PdR5R+pdB/00hB6/fB4nviZ6z?=
 =?us-ascii?Q?w8t7AqNTCpCZekhnqsWnLf+As8YwWlvyPDOXAqf+xqZxdlD+xFMooI7Cy3PQ?=
 =?us-ascii?Q?DdrVxqpjzV7KkwBoTx1XY681fKP32PAXx8wcwIiBWw8XDIGBat5nZqlqSR1H?=
 =?us-ascii?Q?mZAnjbDOpiAzo1SJxH/OzxZwLz0qFX0oaQwRQ563yMZFrUJmBssvVRvYDFPw?=
 =?us-ascii?Q?do9HqoEr44TfjegHd9qJpqV8pz30rTfBSXWVZ4i4JmPJzrGax/KGWWtB7z2Y?=
 =?us-ascii?Q?HNcRl7WtjCFRKjRihfweUjuLoSCG51rteAd5H7gQtl9VZ0tOWVtAjHCvoeZc?=
 =?us-ascii?Q?w//4P/dc6CHF2zUoM94wbF0AM9r1KGlRNBT2eUKZeEIgXIM0CmKS9xjFAyZc?=
 =?us-ascii?Q?7q2Shl+wfFT7pLsf0fhpWvQ0SsAnTdkeyxs4h2t0e4abLpLy1PvqeU+VN/8F?=
X-MS-Exchange-AntiSpam-MessageData-1: 0gPTDztn0qEhEmnAg8YsLqtOfApj5xjQEq0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e243bbb-c807-4615-61f8-08de86942f84
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12191.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:20:14.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7drKG2zt5kWTOwY9kDtAHQhW0LsMIB7r26tFZCKG7Vl92PqbmVUvULewmujJaECDWyoGYgSVfFPtXKOKD8+CzBMULeypkqtFZ5clIRkxmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9324

commit 765356e80262 ("obexd: Unregister profiles when the user is
inactive") added support for running obexd on the system bus with
--system-bus flag. However, test/pbap-client was not updated to
match this change.

As a result, pbap-client fails when obexd runs on the system bus and
prints a NoReply error due to connecting over the session bus instead
of the system bus.

Fix by switching dbus.SessionBus() to dbus.SystemBus() and replacing
deprecated GObject.MainLoop with GLib.MainLoop and removing the legacy
GObject import fallback.

Tested with obexd running with --system-bus and with a paired Bluetooth
device.
---
 test/pbap-client | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/test/pbap-client b/test/pbap-client
index 6dada4a11..4ff301059 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -8,10 +8,7 @@ import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-try:
-  from gi.repository import GObject
-except ImportError:
-  import gobject as GObject
+from gi.repository import GLib
 
 BUS_NAME='org.bluez.obex'
 PATH = '/org/bluez/obex'
@@ -31,7 +28,7 @@ class PbapClient:
 		self.transfers = 0
 		self.props = dict()
 		self.flush_func = None
-		bus = dbus.SessionBus()
+		bus = dbus.SystemBus()
 		obj = bus.get_object(BUS_NAME, session_path)
 		self.session = dbus.Interface(obj, SESSION_INTERFACE)
 		self.pbap = dbus.Interface(obj, PHONEBOOK_ACCESS_INTERFACE)
@@ -114,9 +111,8 @@ class PbapClient:
 if  __name__ == '__main__':
 
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
-
-	bus = dbus.SessionBus()
-	mainloop = GObject.MainLoop()
+	bus = dbus.SystemBus()
+	mainloop = GLib.MainLoop()
 
 	client = dbus.Interface(bus.get_object(BUS_NAME, PATH),
 							CLIENT_INTERFACE)
-- 
2.34.1

