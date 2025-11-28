Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CF3019D7;
	Fri, 28 Nov 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321336; cv=fail; b=OqJxD98FaVo1PDOKOHDMev5rbbpPevd0yFZ2M+b+9gHtZnp56AMU3RKZHZXUc7kstRskAFw0xx5hhv4vyg+nV8D6cDMoObksvD5+hZOHwmyjnIispmyeO/QSOa8aa6F9XiIvL/NO+Y+nK5V+Box0ekArXMEnyAeDBXNOdinEua0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321336; c=relaxed/simple;
	bh=EZo63DR0TPzM0/AImPfULgdxPzyS+J1tS61nsVGKXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zqaxp02MMQmZS56pSC84ctVJ7/J0M/bcR7HSFkRPh/7K2ywgSHvgIbYqJwS9THfi3n0SANATNvUjOBO7STXXW4C/tD04j6LUq7bqC7jpPTZCbMxKZpd4CSkWVquws/C6KEg1u4AiiZ0kZatpmENsR6tU6YyRD6qIsFA9yoq1qls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O8TnpfqT; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O8TnpfqT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH5rzqM1THmifDnfUYNsV+8IN+r/jPV4v2quVnmD2kkLryqwAUbHVlu/wz2jlH8Uhjvdx+U4puvZaPSMvtMpPBgwdqI7oT8INjyUS16C4DW/7yJ0LS6ElFrIx9oE0YdObIiFaJaMwxLqv5eDBPjiEO85EE7CuikiKH+f1dc9XZG/NMQm7C6CGjicMTQswiNPPDPh8Ixb7E/elgq7OmY+uxEjVCazjUvn0/TKpsMMd5qA/eimGBYZ/7Z2ReM6cZT5/NWXsOVWb4Xxvpq71RAzX8nka6tf4wM2eahOzZ9tYpSFay5IFIFFODeU4JcArP4RYKtB0o1FAVvcx9AwecfR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyLSli6q6PvXLMpbs2Zcfbf90mxIIEQkLciE7/+Sr9E=;
 b=szJsd8tYc7nWs9gIc7/bECHmZjEXOYy6SkRvcokV7KrJSYhtKJntswrkVmqfoZCssnCOJYcunXW+9oY5NX/xWmVyREAZOhVcI1ObDTicrKJYBN6x8az+Ge26Hx1Aqd/ykWGagVQEVD6y08BE1UJdTbe9/T7IKbw57zn8lMBzfNbnkdupmufX9ntPuG0S9NBraEZGLdSURZWA0nbj59rI0IwVBFHRQwEhOiYbMkdBY2NS+mcKyNwyJaAgrYTzBX/Fm3o2PWE7J5ciWb7DMg3B/Lr5mFkuKxI9ovfPg2WTXugrIxNA4YvzqMe1J99rdlzq75XeSi3zt7Di5rrCLNF+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyLSli6q6PvXLMpbs2Zcfbf90mxIIEQkLciE7/+Sr9E=;
 b=O8TnpfqTEV3KCt9tQkJMiqFgY2veh7woBG4t1C1Wg5YittbCtV1Odn6eU+5sHvIWkdLvw3JBAINZ6nRIn9XRrt2dK5kBanLxHF1kZ5GNmclEdgplZvDBJd7UtCiydgdI8LzGfJcWY1Yqq1l/P7NoGYA83EwFlFqDYNhqFzVajDtX9f4VHbCYkw0wHRvVT9u1wpr2oYgrAWHu8envIjwQvh7CGMVKXVI3oqsD7ftUsRxQjkx8ddeomPURV5lZsbtDOWchv2nwNw/4LzmaMkfoMRoiudZmiP6bl12GXEALY8lRthScJZ6TlAnHOI+oaDv1cAz8EnROg9ThfIAONjwE1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:30 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:29 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 01/11] Bluetooth: btnxpuart: Add firmware metadata parsing for secure interface
Date: Fri, 28 Nov 2025 14:44:33 +0530
Message-ID: <20251128091443.2797316-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
References: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DB9PR04MB9676.eurprd04.prod.outlook.com
 (2603:10a6:10:308::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9676:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: e8330464-d5f6-4cd4-6717-08de2e5eacbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TniiF6ScsJlyA8st3g7Zn0XQbIUkDdQes0FrR1+EQtyh+AbgB5lBCM4cl8PK?=
 =?us-ascii?Q?r24fM+QXQtYPrSPD/ZoQXG9q+S9nk3L9yjfE8FBVTlwRk7wb1dp0GQkGLtIy?=
 =?us-ascii?Q?zXgXpWT7kcLS+G/4HCDNpq+1HgD6OlqYapEJ1QKxvHsPSQGkhDf7bnOxtsDw?=
 =?us-ascii?Q?sDOIny6oA2wergvU8egJbR4scOoQiQ45QxxhOcrXPqV6Z+C0bEb4uoN62mSm?=
 =?us-ascii?Q?apmw8aR21TioXd6lGOJagbWyssdH47M6mrhD9MjgcyFE/TU2sZqSWxAOGGrj?=
 =?us-ascii?Q?fn+uijSrC/E1Hio8e3HY3NWkTrMGjiBjfXjY3szME6GDs4cZi+qGhmDszkwB?=
 =?us-ascii?Q?V2Ght6qmeWDtQ3vEet8vqjngwCH52TkDhg8R+pKInzk1Pmv3evDkOS43U3M9?=
 =?us-ascii?Q?rQavOfLG2exNvb3OPTD506vPtKUd5cwXSVGw2rs+e0uwqOr4zwT+wqyz4+8q?=
 =?us-ascii?Q?z7iLhnxj8oXGk5uKK6sFWMdlYx9dZlw7mmcpybGTGyaKiTxks83QzV43lzcX?=
 =?us-ascii?Q?a2IQnD5aiZ5Nr4Ca2oPMo50JRebV6GOVj1/nq525bwBTy7QfMybEyEyhQSeq?=
 =?us-ascii?Q?6kk1hfvJ+aoGZJV6Tdp0zMaHKPVHqIFH6iwi9b4y4cD7QMyeN24Bb4ErCh+k?=
 =?us-ascii?Q?4nyjqcV8bOvrnwYNQ5os+4Bdx2NHdMBM76vCI/+zICeGuASdqswHSG0nVa2e?=
 =?us-ascii?Q?RyFqvLiCcTJ+EIspDH/1fxK4aaFy42no6rIJggHiSo6PYZmW5eXD3f5PgqHR?=
 =?us-ascii?Q?sk0hwIPaQo9F8Z0iCaFhsWOy/a7ibRELma7Kg7JLb1v8+RgboLnGxzT1CwDw?=
 =?us-ascii?Q?y9R4elID3ycqx0CaU+9PF9aUxaeQ+emhVlZ15dgcbF5wOFCHjeJEDM4BWLO7?=
 =?us-ascii?Q?7T70IyNjI6vYzz1P3CBRHo1m1FIGsMsq06rj/wwc+pSgwf3z7MWxNyQ6b5UR?=
 =?us-ascii?Q?ZTp4SGeitjmTOJG40Xu9K6ObpWsMHMYFT7B8FWbsIlUiswWTt5wUxXHCStGU?=
 =?us-ascii?Q?5CRUHdL0jo5sNBjt6wsq3quhXnO6AXbZTOxJ6dwf7NQpsbyoDllIfINwhBCV?=
 =?us-ascii?Q?nkf7itUdtduDjE4gsNdK484Xi7PWSNAjEkvKUlZEve8W49/NKSxQz/jMzqQc?=
 =?us-ascii?Q?MmwtRzq5sfSwjKXKmuZ2HC0m6RfCO0M9e+JA0590nbXT9ZwNFKG7K0NenfLQ?=
 =?us-ascii?Q?CmzXGbr03XV8ytEq8lfYARQhldMDtRq9qPEIU6pMYPEoY1u5uhpy7ChTiqqs?=
 =?us-ascii?Q?H/kRiPKR530gYVo+Tif1tHQ9gN4pQa8jK/ZT5CZjc3hzW2ZKxal+jBcyDV+r?=
 =?us-ascii?Q?uwBnjd0JLyjngS9SJOrqYAYExYYcOc9sanTVYRaoLA85j9QROeI7MNl6tmi0?=
 =?us-ascii?Q?q2qmG98hmVzmCotD9lQaYOyTRshvoWEjNb+Wr/isd0KqFXou2RpylSHNWQa7?=
 =?us-ascii?Q?3Fb/0eLmWhh9ppcL040X8/NGik+1NkDZmVgL1WKxJKmBn0oRFHSCyVSzKksK?=
 =?us-ascii?Q?gGt5zg+YWHJi22sGuRsq5zbxhgtH3fhxbWIc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V0ZcJ+0A55xBqGQUH5cEyHVp02G0EwVVY69KHcKZ3cPTGi89HSQhYQ0N3tEZ?=
 =?us-ascii?Q?Cze8aJWGzj4KXuDils0kt5EVnZ5dHcy4fTM9hSBo/ZPWB5U3kUrdTJHTbdrr?=
 =?us-ascii?Q?LBCvX4Ecz+HgI0UZAQ3FhNbcPlkmuol2fxh+DHdB2kticP3VKPn/o3mQR2QB?=
 =?us-ascii?Q?Mv7qGo2tfrC1g9WMlWrCqlgmVjWwg1/otQc2BwOfUVyZqTV4jdBO76iVr45u?=
 =?us-ascii?Q?CTGvoNQR6zdq99niwg7BfdZBKrEIaHqXhEXOxcR19sM/Jh0Le01M0ps2PthJ?=
 =?us-ascii?Q?cA6hM9G3yzQqjnRhq3fdSJ3qMOnNlRXvKOyDeJ+6hw/0WOEH47/MhMQarjJp?=
 =?us-ascii?Q?HxOFbZ+rYNG49/dJh5d0PNx7z9JGFUShpVMERFyVK4Lb16d6yM9M8ZA0a+RJ?=
 =?us-ascii?Q?smF7gmobu479swsratz6MWsedL1YAJYeA/IMIYegY+8dSa4FeldG8xsCqgTd?=
 =?us-ascii?Q?b9DuIfZNNSp1BnpJ7DH4m1l09f+a3gu/vdKz2YjoUbZuD3exU4m5kn7dWUWG?=
 =?us-ascii?Q?Gn+8GUMF+wK7gg2Nv6rTkXuD2US9dtTAWUNRJvhna5V/bfWORauPTl0oLXg9?=
 =?us-ascii?Q?MR8D99Jwhegv0h6xawVsOcL1wesvhPgWdy/JeLegAwRz5/l8+Kd6sL/SNQxm?=
 =?us-ascii?Q?njMSWvRK00dj41lXgRORIdcp4KuMAUry6UepIWZLF/JSOyG830nyxLxr9fJ4?=
 =?us-ascii?Q?V31OTi1h1roSKLtkCsx5mOxQIfgqSQxk8bu11MwbVV/ZCqGxn+UwpZqGRTZX?=
 =?us-ascii?Q?AfRPvaoRb+DzZzGHUhnbpYa39RWn0OOcg9mSaFVTVHGR9BGAVT5dB2Y36p62?=
 =?us-ascii?Q?62t/mRyuCJB+1JFONSEhq0SuL1GpF9t9V2kwF73SWd8Ld9K9thZbzghvJp50?=
 =?us-ascii?Q?ICLnuoJ+kjq6ldFMN3YCo90i7g0ojRwR47txlQkehNuuwUo49gIc+KxGNEvD?=
 =?us-ascii?Q?8MXVsvIddxWKSKn7/PIm5uGkb5E0KAINvGQecC2q2rGKPyTTyO14PPSzZOQ8?=
 =?us-ascii?Q?tfnM6CXu1y3o5iPqe1GPlU/ifap+DAVxeEXM1W+1ABtQaohDUxjKmAcZQEql?=
 =?us-ascii?Q?chCQMWN++guQkAXZZ8gUeEtbhhJu+Ag/RNaCUzTnhYZvXNSrXHgmqS7h/gxc?=
 =?us-ascii?Q?ePOVWC3b1ndYceEXgrSX8VcNs1JxSStRvoGQXTF6tRNDmYXPQCEGzUqJxe/l?=
 =?us-ascii?Q?BGjE3ccVNEiDnBXNUSZNU0WNiKlMnYAAHANydSCBtYqZQN8FQN8DTqPkkHR5?=
 =?us-ascii?Q?UfYd5yf2WkQCg6ryTUxT54bayb59lSPs1IvHE4mUDLLDbR+rZlwHRSOA2MK6?=
 =?us-ascii?Q?VCVpQGFjbr9hPIPeD1zNXtJCJYMhh3bTpXVLZNm8mjzygFhIyzV90wHwkp+3?=
 =?us-ascii?Q?e+1bLSz+BMRhRnd8vP4tUZG97pgszmmCzFS8+haIWSY35Ost9OEaleTfiXQf?=
 =?us-ascii?Q?Eodc0zCI8LFGZW90rsVgiSTxkyLrQmeXrU9A66qKcuV8f/lvAiQd0WYhL4rr?=
 =?us-ascii?Q?1eiWE6opAXWAYBhGy3ycYElZhurOWtOjpTP7mypAbXkY39yCbQ11KALAWatE?=
 =?us-ascii?Q?jFxVYYnt1IJmYp6qMb9ZBzCc/vEJIW/691ITsVm+ml6UgAFrPZNXFXs3rVUg?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8330464-d5f6-4cd4-6717-08de2e5eacbe
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:29.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8y3OTR2KNLbqiw0svdAv3QRRyW5NQJpOmZZ5hnc4QbhE//vjuVXWnawEXSg7npYTfvd+Kc4itHOjXV/m7zyRUR/Movvr8/lEKh7MfUe4bLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

This adds support for parsing firmware metadata TLVs to extract FW UUID and
ECDSA Public Key from FW metadata for secure interface authentication.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Fix sparse warnings. (kernel test robot)
---
 drivers/bluetooth/btnxpuart.c | 133 ++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3b1e9224e965..78a7651d55d6 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/crc8.h>
 #include <linux/crc32.h>
+#include <linux/math.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
@@ -134,6 +135,14 @@
 #define BT_CTRL_WAKEUP_METHOD_EXT_BREAK 0x04
 #define BT_CTRL_WAKEUP_METHOD_RTS       0x05
 
+/* FW Metadata */
+#define FW_METADATA_TLV_UUID		0x40
+#define FW_METADATA_TLV_ECDSA_KEY	0x50
+#define FW_METADATA_FLAG_BT		0x02
+
+#define NXP_FW_UUID_SIZE           16
+#define NXP_FW_ECDSA_PUBKEY_SIZE   65
+
 struct ps_data {
 	u8    target_ps_mode;	/* ps mode to be set */
 	u8    cur_psmode;	/* current ps_mode */
@@ -180,6 +189,11 @@ enum bootloader_param_change {
 	changed
 };
 
+struct btnxpuart_crypto {
+	u8 ecdsa_public[NXP_FW_ECDSA_PUBKEY_SIZE];	/* ECDSA public key, Authentication*/
+	u8 fw_uuid[NXP_FW_UUID_SIZE];
+};
+
 struct btnxpuart_dev {
 	struct hci_dev *hdev;
 	struct serdev_device *serdev;
@@ -213,6 +227,7 @@ struct btnxpuart_dev {
 	struct btnxpuart_data *nxp_data;
 	struct reset_control *pdn;
 	struct hci_uart hu;
+	struct btnxpuart_crypto crypto;
 };
 
 #define NXP_V1_FW_REQ_PKT	0xa5
@@ -362,6 +377,26 @@ union nxp_set_bd_addr_payload {
 	u8 buf[8];
 };
 
+/* FW Meta Data */
+struct fw_metadata_hdr {
+	__le32 cmd;
+	__le32 addr;
+	__le32 len;
+	__le32 crc;
+};
+
+struct fw_metadata_tail {
+	__le32 len;
+	u8 magic[8];
+	__le32 crc;
+};
+
+struct fw_metadata_tlv {
+	__le16 id;
+	__le16 flag;
+	__le32 len;
+};
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -1190,6 +1225,85 @@ static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_re
 	}
 }
 
+static u32 nxp_process_fw_metadata_tlv(struct hci_dev *hdev, char **payload)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct fw_metadata_tlv *tlv = (struct fw_metadata_tlv *)(*payload);
+	u32 ret = sizeof(*tlv) + le32_to_cpu(tlv->len);
+
+	/* Process only BT specific metadata TLVs */
+	if (!(le16_to_cpu(tlv->flag) & FW_METADATA_FLAG_BT))
+		goto align_and_return;
+
+	switch (le16_to_cpu(tlv->id)) {
+	case FW_METADATA_TLV_UUID:
+		if (le32_to_cpu(tlv->len) == NXP_FW_UUID_SIZE)
+			memcpy(nxpdev->crypto.fw_uuid,
+				*payload + sizeof(*tlv), NXP_FW_UUID_SIZE);
+		break;
+	case FW_METADATA_TLV_ECDSA_KEY:
+		if (le32_to_cpu(tlv->len) == NXP_FW_ECDSA_PUBKEY_SIZE)
+			memcpy(nxpdev->crypto.ecdsa_public,
+				*payload + sizeof(*tlv), NXP_FW_ECDSA_PUBKEY_SIZE);
+		break;
+	default:
+		bt_dev_err(hdev, "Unknown metadata TLV ID: 0x%x", le16_to_cpu(tlv->id));
+		break;
+	}
+
+align_and_return:
+	/* Align the pointer to 4 byte structure alignment */
+	ret = round_up(ret, 4);
+	*payload += ret;
+
+	return ret;
+}
+
+static void nxp_process_fw_meta_data(struct hci_dev *hdev, const struct firmware *fw)
+{
+	const char *metamagc = "metamagc";
+	struct fw_metadata_hdr *hdr = NULL;
+	struct fw_metadata_tail *tail;
+	u32 hdr_crc = 0;
+	u32 payload_crc = 0;
+	char *payload;
+	u32 payload_len = 0;
+
+	/* FW metadata should contain at least header and tail */
+	if (fw->size < (sizeof(*hdr) + sizeof(*tail)))
+		return;
+
+	tail = (struct fw_metadata_tail *)&fw->data[fw->size - sizeof(*tail)];
+
+	/* If tail doesn't contain the string "metamagc", this is invalid FW metadata */
+	if (memcmp(metamagc, tail->magic, strlen(metamagc)))
+		return;
+
+	hdr = (struct fw_metadata_hdr *)&fw->data[fw->size -
+						  sizeof(*tail) -
+						  le32_to_cpu(tail->len)];
+
+	/* If metadata header isn't cmd24, this is invalid FW metadata */
+	if (le32_to_cpu(hdr->cmd) != 24)
+		return;
+
+	/* If header CRC doesn't match, this is invalid FW metadata */
+	hdr_crc = crc32_be(0, (u8 *)hdr, offsetof(struct fw_metadata_hdr, crc));
+	if (hdr_crc != le32_to_cpu(hdr->crc))
+		return;
+
+	/* If payload CRC doesn't match, this is invalid FW metadata */
+	payload = (u8 *)hdr  + sizeof(*hdr);
+	payload_crc = crc32_be(0, payload, le32_to_cpu(hdr->len) - 4);
+	if (payload_crc != le32_to_cpu(tail->crc))
+		return;
+
+	payload_len = le32_to_cpu(hdr->len) - sizeof(*tail);
+
+	while (payload_len > sizeof(struct fw_metadata_tlv))
+		payload_len -= nxp_process_fw_metadata_tlv(hdev, &payload);
+}
+
 static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -1248,14 +1362,6 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		goto free_skb;
 	}
 
-	if (req->len == 0) {
-		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
-			   nxpdev->fw->size);
-		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
-		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
-		goto free_skb;
-	}
-
 	offset = __le32_to_cpu(req->offset);
 	if (offset < nxpdev->fw_v3_offset_correction) {
 		/* This scenario should ideally never occur. But if it ever does,
@@ -1267,6 +1373,17 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
+
+	if (req->len == 0) {
+		if (nxpdev->fw_dnld_v3_offset < nxpdev->fw->size)
+			nxp_process_fw_meta_data(hdev, nxpdev->fw);
+		bt_dev_info(hdev, "FW Download Complete: %u bytes.",
+			   req->offset - nxpdev->fw_v3_offset_correction);
+		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
+		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
+		goto free_skb;
+	}
+
 	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
 				nxpdev->fw_dnld_v3_offset, len);
 
-- 
2.43.0

