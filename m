Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0D2F39BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104556; cv=fail; b=IV+N6ehfAlSGaykeAvFFjIYfZcz0RzP73avOIdj/9fYRroxNrkG4Mti8ZUOcBs4FP1vuwMf341YYh1eSVkKE59DR5WR1nXNjVHagKFB7Cv0OYm99LCqCEC1ICTMey0h/YhIv+R7uY8UnpupCDNNKsXwCevO9EutLH1VLtZ5MI/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104556; c=relaxed/simple;
	bh=PwoSZYW3Qc2Ie8D5pUkW8PQlOVlReA3rEW9tUFXq26I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVCaVSW2QrVHg4RlYO1HVNNfo9A/2q4/FEXWU2KlFKVIdjZcHc8lUoGNokdMORi9+c4CWZk4pZVgAI7j0bO5tZakbZ33sMKHL4zjuAGszFVqjdQzTr7a+rDk0GOt3++YPE9SmVLvMo8PYaSdHIxWELglKMIFwVjk+ey8pzz9Mqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UWtxkPl3; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UWtxkPl3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOqH2xGjLxiCnwsdoXFthbAt3v3SkRlmbIj01TKqiLftBW5MfAebZquFQjydg1q61RZSJSbrZ18EBqlpc5YNceWqCUlchGXkmi0UAVUBEiyCJsavlvuK3qPQgIRBEOLpyd3vE6DrpLqIVKEbXvAvbm7n/AeUqSynLcrXTVB/z0/5OeLOok2JzTx6AyjqTzzvjN1Iim6LVg+ZYoPfI/dMumR6birPdxe2QvdBOKRDkRw3yVTaTisPW6yqNlB1wNYzcWLgewh3ZZ2DhdeYqNHHImCaHLxppvPbvuQKfFhjLQCLAgbwhpPRqAeMSSbHLAO8rObvFQX8NmDEaOfSkmGXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mjw4eW5k8GfgZE+LbMm1VtviFRz5oZH8s/+D8kPOeUg=;
 b=pf83SrZ1QF3AuK6gK+lya3zsERYH3tTvyTMNLpMNQWWfcUVFRTWv4jYPtlObIWKIhdNxMv7PRVtIKMTbmt+gHRB3Hk6wQFjlHvqJWD707+NDSo7iXoOFNYR8PlL2E3jtAt2oLQlSVOGJO/FB5Zq17rnkaAkpCv2v6cAOsqieG0H4hicgc1idO8r4SW9eNruoHHUs+6nU0HyHOJjLUlbk5OTntR7lbXVdEzLG1+OaU61Ycd6zea6wdfBoGQv95CEaeR57o86dSsml3q5qx5uX19asOjuDRR/gsklviihoMd85HA8zcZqkEmarHfK6ydC/yeEvMwqHSUNL4aHGQAqnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mjw4eW5k8GfgZE+LbMm1VtviFRz5oZH8s/+D8kPOeUg=;
 b=UWtxkPl3HRlOtz5rpXX/y1sp0ZxeXx9xB7oTK+WzyEeTN+C9m+VZ1vDHjS20YNxPgxFJt4dJYCi4GbESVgdUEDMBIUKh3YqIB5i+FCIZMf7yJ2XCAJiC+f26fq/DHB8J03sErmNx7TO64kyN1c/vDXAFwbgmP5LjL53BqeqKJdsZimQf/TvR7Xf5CMYWqnDLxtY//LfN8EuLFIcnejjQLDu5VGH/3+1t/vlCY0xHz4MZokokKkZU4H5H/KAUtMIbF37WGtvImQn8VvDb91P/JtZpXziTUx+857msN5CIjQvMSxC8vzKTJJW1H3xjlQ1vrGr4BII0gPR2C3S5k5iw7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by DU7PR04MB11138.eurprd04.prod.outlook.com (2603:10a6:10:5b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:55:51 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%7]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 13:55:51 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH v3 1/1] tools: Add raw advertising data support to BlueZ
Date: Fri, 10 Oct 2025 16:55:21 +0300
Message-ID: <20251010135521.4854-2-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251010135521.4854-1-adrian-constantin.dudau@nxp.com>
References: <20251010135521.4854-1-adrian-constantin.dudau@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0048.eurprd03.prod.outlook.com (2603:10a6:208::25)
 To DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|DU7PR04MB11138:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a8f71a-9348-4fa0-8052-08de0804b8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+Lq6r8oWKApmA7Y8GXCZEKqrIx4HncF1yJ4gYPYOUuZwiURkCqS2Ebqv0xd?=
 =?us-ascii?Q?UdyPZOwvs4dZVXkVTEEwcYmp+zMA1vuEineQq2A3gPytAp49KyIwmaRyPh0y?=
 =?us-ascii?Q?xxSucKLbcgCwd85SLjv9ETnuxocnEjsnEk86/cXQgIO5VyUJv2ZqQ5h8U0KC?=
 =?us-ascii?Q?M8q4QDzRHXCMh+yBdfSRbXMaaQYAGOKju8eYyE3MATGy9sKVIz7122W+mhPh?=
 =?us-ascii?Q?zZ7tkMb9TrAvaqjWX216iEpHeupa/YAcLw5MuTaMQ/fzR/L/Hgs6NEdhoFb8?=
 =?us-ascii?Q?VV7qqHB2LQ/WszE4U3fyVvP8MrzFX8Yog/RGP9c2EC+Ridxe1GJT4om+s8rV?=
 =?us-ascii?Q?qRLJDV2vHtDoUY4Ogro4+TNdlxsox7s63YUr/MIyQFsmvXsbP/Q/rJf8OLnn?=
 =?us-ascii?Q?cLy1+RHV/QrRBc7oUTq+9jvPFpKeZXuw9zhX2QPp6o3I9qSSwVKJf/voTE7F?=
 =?us-ascii?Q?lfCnuS3H6nKa89xcu5E6rRnnDX7K/t7I/mFmxpOkm9OVoN6yHXTvmR/dYLaK?=
 =?us-ascii?Q?XHE1CYcnLfvWIg2vjc0DD3dvcbsiSR5yebtIc35LzoE2gCLY//2CwpLlhlKK?=
 =?us-ascii?Q?UieXEXnOc74GjKK7lWG3o/lmj6aF+Ncy33t/ewu3YmTfq7iurNTIP6dtp45w?=
 =?us-ascii?Q?rnLgfJKU08SjlCN7ZrZi017b/BISZNlgFJo3Xa4/YCDqkNA5sjXQ9+m/+mvn?=
 =?us-ascii?Q?lQlf3Zh5T07c2LvBQTXIac/TFqWxZ6UjKEft8ZirhXRne77eBYrtUgLODitU?=
 =?us-ascii?Q?nEoAUkmBLzMY3Q0/J/hInRo42kf9qn2cEvBNolQdRkeTsNsdsLDEQU1CjXqt?=
 =?us-ascii?Q?gciXXPmyAO+TPY5ww2+cIqBT1Cy413SzXMFxqQLuIKqIxsJnLQUHW1BzLLnP?=
 =?us-ascii?Q?I1xlLklFk8lIJmI+IYs3fgY3WoEv8amqcEAWvBCQ6l3ZXa+bbdeKKTP9ooSU?=
 =?us-ascii?Q?sVCGtWLsMuht0dVh56Qj3rUEYFv3GTAa6rvQJWxoPYRB4mvV0Ovz40H2uBfC?=
 =?us-ascii?Q?dpsxosWM2kqX7OCrcq6H4n3/qkEXpOapn3Q/oK3ktUk8fCpqIewbYlfgvbJT?=
 =?us-ascii?Q?i4R3/CBPHb9X5tvbuABVb1/7zTvKcLHYj501vxRA7nCzxd8sZ0dNI7kBiIsc?=
 =?us-ascii?Q?A0RjhH5SyyIjRgWlFVxYrzFdHeX5PpED63XIVpnrFCFxnnhM7YI4Zi1sQfk1?=
 =?us-ascii?Q?3VdnoJVZVr7FS86Mah/TBMq9Yz6EZGhVn0s2fVnS7o7NtjOvfClG3GrSR5ci?=
 =?us-ascii?Q?TH9dyKJSy15h1Z+yDE5TkW7QZJt33fhWfyy6fLzakbxtzKkQGrJ6bXQmll7c?=
 =?us-ascii?Q?+ifqJ+KxVO3JiyTZGDB6xDUUi6fU6d1ApOIBpB1GIqj/tLPiSZ/i7UDoW+ac?=
 =?us-ascii?Q?WRfHuzmg+hHs+SwlYfjctirUH2DzoOUJDasGr/BfJ4rFTGEuiHKr3gLVPrpF?=
 =?us-ascii?Q?Kx3hHmvkCJz2DrC95cOWRWjjoUBQW3jZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37lCrQZCh5RBaWM0REz1WwxIitK3NqTKV6D3/gTZu7gw/7q/WOSL8HUEojEV?=
 =?us-ascii?Q?0Rd6r0fNYWmoqIVBVkEAaOi+LBdofzZe6eDA/a7z6ZZTz7X1So20k1g7+Aeu?=
 =?us-ascii?Q?a2Z3a+nnXEUPs6n4fz5dPYmBYBSSxwx0cMvA+hpfQOJlI4LF6nSWWVwRIVoi?=
 =?us-ascii?Q?8k4yTmdJpLOzeps89N8029pL4tnBi9R2dMQjlQ/4Y3Welyvx+yJApLB1IQZr?=
 =?us-ascii?Q?zzx9JKGcB7aPwJNeGgO3aP3/Qrw97M68loQU0nRKXPhF5NGTiXnfTRqPWiZa?=
 =?us-ascii?Q?ezfqkanXBL3odX/uFVex/LMSHZx/8QjaEerFSCjnaV/puU858DztLY4CrXH+?=
 =?us-ascii?Q?EvZi0PBWZH7vQsXdwPOvLiphvWGA6wVT53zapAQGf7E9zwnaPuww0s/zdM/W?=
 =?us-ascii?Q?3qrUiIzrHODVcoABHMuWaJMO2Sc+l4kQz2udEjjPjF6StAbd+lqL6d3KRxJT?=
 =?us-ascii?Q?sCCsnDZtjB+M1WEzd59zsfHRX+x8KTy6/vV9rI3kYxGz9+lkQMya+8+5zsHX?=
 =?us-ascii?Q?6w76PU1FI2IXm/GDmSUxFRXTOWoGgx6JFLCP1EAsCxBYncMsYuowKII8TZWn?=
 =?us-ascii?Q?EYx1hmAvTSvsGzd6xho8Z1Kv3gXXeAOoiFsH720fxLrr0L3VePEZHM8arc/T?=
 =?us-ascii?Q?sHPQyo+99Tok/LtW1PqCtKCPPgam2o9cZk68gekTyKz9D2hOm1ckalz0bC4g?=
 =?us-ascii?Q?EJpIvtFvhcprt+wIlP1ERiEIwGbbps4K5YuJL5jZRTdJipoaY+HMvYAER+lo?=
 =?us-ascii?Q?73YNYFjWhivSk7UXsLtH8kAaOxjS39CP5SWAPYyMTJa6YS0FqzxzgOgQMu0t?=
 =?us-ascii?Q?RuxonvGua/qBaSgliPyerMtQ2PfV7Gnxrr4omFZgd1kkNjpBm0HxsHCXuioJ?=
 =?us-ascii?Q?bmIYEjgBpnf+Eo21jx7WC3bsAzvePHTC15s/V+KDehYLSEbs1xscTaxcxqH+?=
 =?us-ascii?Q?0noIj0Gk7ObK1BJcanKrLmKFiLB8J17CeYqRX7ukMV4M1XbKmV0Zj6f5tv9H?=
 =?us-ascii?Q?XsxCbWJadlnjr+0d+kJ8m2bYkC5jb3PniJviZKpXnbW6hy9+AIXs4rx0nXuc?=
 =?us-ascii?Q?92ic831hTdeEFPHV5WuNoPMnSLwdy+poCyvE+a+XzTc7rE8qNoRlYZNluHgl?=
 =?us-ascii?Q?lGF0vUxY3xpR2b/1JUwrBEUy3/VR+zBkAmxExWHeyFOZFAECr4hCbPAWEd39?=
 =?us-ascii?Q?lSCEqK++9FvrVoHZ8a+Z6nwLACAjcEpQpYMtpNjN4VjcRMjYZp0JiD7B6Ujk?=
 =?us-ascii?Q?fgbHqTntrpJRMwzjfApU3LM6Lcfcw8wp9unfTH6878CN1gDpA6DnebWmbxFL?=
 =?us-ascii?Q?FtSoYxYv6BB4cAr7tjPGTb3hWnTYdhj38Ip9JNFQI4RA2dmaDuYqjlnhLnNa?=
 =?us-ascii?Q?V1rHsEzOnX3cnBVZDmt+iiDiWHIlFkHqYZ4wIQyGGMdk+N0pRGB/uWnboEqP?=
 =?us-ascii?Q?dU7wNonPBGJCXM4cFr+tirzIhKRbba+fqBeaayUCTKNOAP24ZHFXPCei7UPc?=
 =?us-ascii?Q?ZhkTBghDi8h1521shku3qK96zALhBdtbH/gh6OHoOK99mC8TQsOBUWenVUCa?=
 =?us-ascii?Q?mk78LYLqskDWi9WUNu4DZpLL8FGcNtZIfdwgWlYlZhMWlSrFU4oDsQxGid2Q?=
 =?us-ascii?Q?zHlRcK/u3Y363n9wTHv8S04=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a8f71a-9348-4fa0-8052-08de0804b8c0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:55:51.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHXdUUMM6teKU58lBjONWBL92GP1brinaMSX0Lmy40KhN8Wl3sjcSId1ycsbFeKglYuS6EIkjPfwzej0tFR/J6FfMt328Jpi2SjD+/vmCgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11138

This patch introduces support for storing and exposing raw advertising
data from Bluetooth Low Energy devices through D-Bus properties and
internal APIs.

Key changes:
- Add raw_data fields to eir_data and bt_ad structures
- Implement bt_ad_set_raw_data(), bt_ad_clear_raw_data(),
  bt_ad_has_raw_data(), and bt_ad_get_raw_data() APIs
- Expose RawAdvertisingData D-Bus property on device objects
- Store raw advertising data during EIR parsing
- Update BTP client to include raw advertising data in device found events

The RawAdvertisingData property is marked with G_DBUS_PROPERTY_FLAG_TESTING
for debugging and protocol testing purposes. This enables applications to
access complete raw advertising packet contents for custom parsing,
compliance testing, and troubleshooting scenarios.

The raw data format follows the Extended Inquiry Response Data Format
as described in BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>
---
 src/adapter.c     |  5 +++++
 src/device.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h      |  2 ++
 src/eir.c         |  7 ++++++
 src/eir.h         |  3 +++
 src/shared/ad.c   | 50 +++++++++++++++++++++++++++++++++++++++++
 src/shared/ad.h   |  8 +++++++
 tools/btpclient.c | 56 ++++++++++++++++++++++++++++++++++++++++++----
 8 files changed, 184 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1ee2f3a08164..66d48c90fe8a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7471,6 +7471,11 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	if (eir_data.data_list)
 		device_set_data(dev, eir_data.data_list, duplicate);
 
+	if (eir_data.raw_data_len > 0)
+		device_set_raw_adv_data(dev, eir_data.raw_data,
+					eir_data.raw_data_len,
+					duplicate);
+
 	if (bdaddr_type != BDADDR_BREDR)
 		device_set_flags(dev, eir_data.flags);
 
diff --git a/src/device.c b/src/device.c
index 8d74ae0ea0ff..a244ab1cb796 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1615,6 +1615,47 @@ dev_property_advertising_data_exist(const GDBusPropertyTable *property,
 	return bt_ad_has_data(device->ad, NULL);
 }
 
+static gboolean
+dev_property_get_raw_advertising_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	uint8_t *raw_data = NULL;
+	size_t raw_data_len = 0;
+	DBusMessageIter array;
+
+	if (!device)
+		return FALSE;
+
+	bt_ad_get_raw_data(device->ad, &raw_data, &raw_data_len);
+
+	if (!raw_data || raw_data_len == 0)
+		return FALSE;
+
+	dbus_message_iter_open_container(iter,
+					DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING,
+					&array);
+
+	dbus_message_iter_append_fixed_array(&array,
+					DBUS_TYPE_BYTE,
+					&raw_data,
+					raw_data_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean
+dev_property_raw_advertising_data_exist(const GDBusPropertyTable *property,
+					void *data)
+{
+	struct btd_device *device = data;
+
+	return bt_ad_has_raw_data(device->ad);
+}
+
 static bool device_get_wake_support(struct btd_device *device)
 {
 	return device->wake_support;
@@ -2401,6 +2442,19 @@ void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
 	g_slist_foreach(list, add_manufacturer_data, dev);
 }
 
+void device_set_raw_adv_data(struct btd_device *dev,
+			const uint8_t *data, size_t len,
+			bool duplicate)
+{
+	if (!dev)
+		return;
+
+	if (duplicate)
+		bt_ad_clear_raw_data(dev->ad);
+
+	bt_ad_set_raw_data(dev->ad, data, len);
+}
+
 static void add_service_data(void *data, void *user_data)
 {
 	struct eir_sd *sd = data;
@@ -3619,6 +3673,9 @@ static const GDBusPropertyTable device_properties[] = {
 					dev_property_flags_exist },
 	{ "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
 				NULL, dev_property_advertising_data_exist },
+	{ "RawAdvertisingData", "ay", dev_property_get_raw_advertising_data,
+				NULL, dev_property_raw_advertising_data_exist,
+				G_DBUS_PROPERTY_FLAG_TESTING },
 	{ "WakeAllowed", "b", dev_property_get_wake_allowed,
 				dev_property_set_wake_allowed,
 				dev_property_wake_allowed_exist },
diff --git a/src/device.h b/src/device.h
index 9ff9cdfefc28..84dfa9faaa82 100644
--- a/src/device.h
+++ b/src/device.h
@@ -81,6 +81,8 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
 void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
 							bool duplicate);
+void device_set_raw_adv_data(struct btd_device *device, const uint8_t *data,
+				size_t len, bool duplicate);
 void device_set_service_data(struct btd_device *dev, GSList *list,
 							bool duplicate);
 void device_set_data(struct btd_device *dev, GSList *list,
diff --git a/src/eir.c b/src/eir.c
index 68ed74fe6493..497e11bd3125 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -243,6 +243,13 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 	if (eir_data == NULL)
 		return;
 
+	if (eir_len > 0 && eir_len <= EIR_MAX_LEN) {
+		memcpy(eir->raw_data, eir_data, eir_len);
+		eir->raw_data_len = eir_len;
+	} else {
+		eir->raw_data_len = 0;
+	}
+
 	while (len < eir_len - 1) {
 		uint8_t field_len = eir_data[0];
 		const uint8_t *data;
diff --git a/src/eir.h b/src/eir.h
index b9f7c3874eb3..bb7b74527d97 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -53,6 +53,7 @@
 
 #define EIR_SD_MAX_LEN              238  /* 240 (EIR) - 2 (len) */
 #define EIR_MSD_MAX_LEN             236  /* 240 (EIR) - 2 (len & type) - 2 */
+#define EIR_MAX_LEN                 240
 
 struct eir_msd {
 	uint16_t company;
@@ -91,6 +92,8 @@ struct eir_data {
 	GSList *msd_list;
 	GSList *sd_list;
 	GSList *data_list;
+	uint8_t raw_data[EIR_MAX_LEN];
+	size_t raw_data_len;
 };
 
 void eir_data_free(struct eir_data *eir);
diff --git a/src/shared/ad.c b/src/shared/ad.c
index 9e21cbf61a29..443ba002fc56 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -35,6 +35,8 @@ struct bt_ad {
 	struct queue *solicit_uuids;
 	struct queue *service_data;
 	struct queue *data;
+	uint8_t *raw_data;
+	size_t raw_data_len;
 };
 
 struct pattern_match_info {
@@ -55,6 +57,8 @@ struct bt_ad *bt_ad_new(void)
 	ad->service_data = queue_new();
 	ad->data = queue_new();
 	ad->appearance = UINT16_MAX;
+	ad->raw_data = NULL;
+	ad->raw_data_len = 0;
 
 	return bt_ad_ref(ad);
 }
@@ -199,6 +203,8 @@ void bt_ad_unref(struct bt_ad *ad)
 
 	free(ad->name);
 
+	free(ad->raw_data);
+
 	free(ad);
 }
 
@@ -1252,6 +1258,50 @@ bool bt_ad_has_data(struct bt_ad *ad, const struct bt_ad_data *data)
 	return queue_find(ad->data, data_match, data);
 }
 
+void bt_ad_set_raw_data(struct bt_ad *ad, const uint8_t *data, size_t len)
+{
+	if (!ad)
+		return;
+
+	bt_ad_clear_raw_data(ad);
+
+	ad->raw_data = malloc(len);
+	if (!ad->raw_data)
+		return;
+
+	memcpy(ad->raw_data, data, len);
+	ad->raw_data_len = len;
+}
+
+void bt_ad_clear_raw_data(struct bt_ad *ad)
+{
+	if (!ad)
+		return;
+
+	free(ad->raw_data);
+	ad->raw_data = NULL;
+	ad->raw_data_len = 0;
+}
+
+bool bt_ad_has_raw_data(struct bt_ad *ad)
+{
+	if (!ad)
+		return false;
+
+	return (ad->raw_data && ad->raw_data_len > 0);
+}
+
+bool bt_ad_get_raw_data(struct bt_ad *ad, uint8_t **data, size_t *data_len)
+{
+	if (!ad || !data || !data_len)
+		return false;
+
+	*data_len = ad->raw_data_len;
+	*data = ad->raw_data;
+
+	return (ad->raw_data && ad->raw_data_len > 0);
+}
+
 void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_data)
 {
 	if (!ad)
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 7c5d94db0458..8a7e018e9387 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -176,6 +176,14 @@ bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len);
 
 bool bt_ad_has_data(struct bt_ad *ad, const struct bt_ad_data *data);
 
+void bt_ad_set_raw_data(struct bt_ad *ad, const uint8_t *data, size_t len);
+
+void bt_ad_clear_raw_data(struct bt_ad *ad);
+
+bool bt_ad_has_raw_data(struct bt_ad *ad);
+
+bool bt_ad_get_raw_data(struct bt_ad *ad, uint8_t **data, size_t *data_len);
+
 void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_data);
 
 bool bt_ad_remove_data(struct bt_ad *ad, uint8_t type);
diff --git a/tools/btpclient.c b/tools/btpclient.c
index a140253d92a6..9b990746d811 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -2510,12 +2510,18 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device *device = find_device_by_proxy(proxy);
 	struct btp_adapter *adapter = find_adapter_by_device(device);
+	struct l_dbus_message_iter dict_iter;
+	struct btp_device_found_ev *p_ev = NULL;
 	struct btp_device_found_ev ev;
 	struct btp_gap_device_connected_ev ev_conn;
 	const char *str, *addr_str;
 	int16_t rssi;
 	uint8_t address_type;
 	bool connected;
+	const uint8_t *raw_data = NULL; /* Buffer for Raw Advertising Data */
+	uint32_t data_len = 0U; /* Length of the raw_data buffer*/
+
+	ev.eir_len = 0U;
 
 	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) ||
 					str2ba(addr_str, &ev.address) < 0)
@@ -2538,11 +2544,53 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
 
-	/* TODO Add eir to device found event */
-	ev.eir_len = 0;
+	do {
+		/* dict_iter will contain the item for RawAdvertisingData */
+		if (!l_dbus_proxy_get_property(proxy,
+						"RawAdvertisingData",
+						"ay",
+						&dict_iter))
+			break;
+
+		/* raw_data contains the Advertising Data, in raw format
+		 * data_len contains the length read in the data buffer
+		 */
+		if (!l_dbus_message_iter_get_fixed_array(&dict_iter,
+								&raw_data,
+								&data_len))
+			break;
+
+		if (data_len <= 0U)
+			break;
+
+		/* Allocate new buffer, recalculated to sustain new data
+		 * size of previous struct + new length
+		 */
+		p_ev = (struct btp_device_found_ev *)
+			l_malloc(sizeof(*p_ev) + data_len);
 
-	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
-						sizeof(ev) + ev.eir_len, &ev);
+		if (!p_ev)
+			break;
+
+		/* Populate structure that will contain the raw adv data */
+		memcpy(p_ev, &ev, sizeof(ev));
+		memcpy(p_ev->eir, raw_data, data_len);
+
+	} while (false);
+
+	if (p_ev) {
+		p_ev->eir_len = data_len;
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
+				adapter->index, sizeof(*p_ev) + data_len,
+				p_ev);
+
+		l_free(p_ev);
+	} else {
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
+				adapter->index, sizeof(ev) + ev.eir_len,
+				&ev);
+	}
 
 	if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected) &&
 								connected) {
-- 
2.45.2

