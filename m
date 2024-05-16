Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A562146A81
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864656; cv=fail; b=ADtv1pNZrpDTCxIM0wL2R9HLCcxZQFaIzD/LUVtZUNhfN4vJMeAn/nX9XwqBlbz0lzoP5laGp89k5G5LwSV9gE2FbHbQhEIir8CKzJoxAPAiqpfkxOom7UdKBf2JQ2E1HdpQf8V9c4hcqAC8MoXXX6nVA5fTuWuTUUhcX4sMHLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864656; c=relaxed/simple;
	bh=Abt0AV6yZHctWwj9bjDwdaDsQn6GcoWNWkQHgQAf97A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOl6kIfHN20GHnU6B7RQ3gFZvjtojmsMQvQxMmblmApz3DLu8DFe8PjyDEAIofwKa4nrUsHh+qU2uR+J3kktBQUv4QvBjDJcJPYJPbmAB3Eq+tSx0CC8Jt2ermpH8dQ0LuC7uNMPoZjcnO7uuwHjmtzocEQVNULp8wejugs0rL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oDolIRgK; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oDolIRgK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfIMSa+/ob4bqNmns/r0y+nruyirc6Ls9tpkXq2Kp22ATYVkwN1UwFdBbeea59LV/n277hOFvQce6202SXs11Zghp53MDpjTAzjETD2POnDEp9Ni+cipKTYaZ2LUTIVVtv0OkEtxwLKCnnpHVYkNWPPhAAbhvZyNyvlarnRXpe2bsVLwvJ8OzAVMclIe0Ap4cDe1Uqm3aKmd/pWqlqgoEVKDwExKqsd5xxoZpmxHMHGhECong4mLPuK3QWVD9tNJx2hEpcEHopqx/yBN3RvC1kkUkSFTRiZg517PF0itVjitYv8C8kOMnQz3Fa3ArgAe67O7i1vtD4++HL3UJOW2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvV9FqfzYmBRmsC+/9tPrpYFvxyh75txfkYrOsxRWVg=;
 b=hkgBP2pn1DP7TWOgljgkox9wxTUCXglZfs/avgzG6DSh1kXBwIgRmlYIn3efD3CTmLyrH5HXpHM1J9S9VTSr0KQDuSXOAqZj8L9GJhZeHbbc5ni/62el2wWIyJT7xPlhCJXS8UDZwX/4yhzerB//JOQUzgnV2t+K2dgfYDd16maKkUDQaKEo3I5H6k8Dogi3OO8I8VsEaMcP/U/JRXXUUI+O6qpONRcEv3+8XRkVNzVC6jX1PcomyQCfmbazKLd5riWTF7ztFH6qeocXjh1k44v30WUoHubPyu0v9f1lmHFc0JUceq1PF1RPT56k2gzb+e5Jhl5324IMYAfOHjiZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvV9FqfzYmBRmsC+/9tPrpYFvxyh75txfkYrOsxRWVg=;
 b=oDolIRgKMH09As/xTjqriJPVwKP36GXEpoETximoOqriylGFm0ROvBhuBiXRQsPyIn5iTb9jJNADns9ZHuFzGK3K3q5wfQXgShIs/HwTh8wTkbPpF9l2uBDljIfdCk5nSPRFZunNm/SOE7fK3iyvfbe/COKH3MFDbkYr7ikM0bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 13:04:10 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:04:09 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 2/6] shared/bap: Add function to check the validity of a BIS
Date: Thu, 16 May 2024 16:03:56 +0300
Message-Id: <20240516130400.16713-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
References: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::49) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 9304be61-e365-4c47-c2c7-08dc75a8ab57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3aMq1QVdPk1o2SYALG5FTL9kcgvQn98NPoou9ior6i2AyuI4UyFvxiv9Sfnf?=
 =?us-ascii?Q?uZagRR8XYHszwk20GzX+WGtjwzDvR7TOCUzVlVdbPyP1ZQVjw5JNaQTZa/nx?=
 =?us-ascii?Q?QEvAuxWl0HH4xMPpqfdAoSGGIw8JgiVsQoHE2lZ3r0EBMN1LuiqGBSxVXGZD?=
 =?us-ascii?Q?EFrJJxNY9s5EMH135b5FfKtQw+t4WONGR3ejsHVUCg/WiXDwKozKV1Tw5fdF?=
 =?us-ascii?Q?5pSsVqsPwr3fbAOFuqjfhItv3RMlS3HpnpGmdRCEHaV/fmtEGaEjj77VtyAy?=
 =?us-ascii?Q?qDB4QoyDVw740k0868sLZ/NsqCw5ybV07aBAUeBNh6/C5UUFQd7LOU0VcDXL?=
 =?us-ascii?Q?4LjoU3LZWxbPl/UXZ2P0Glp1FmZndgdcHL+FfvaLTXz/54OHN0i9muQ3GKPe?=
 =?us-ascii?Q?k05zLOsWIRs4FJLZSUHj3mhogV3UIc5DRdtgYiEPRkK6sPTjVs6oEX8rwS9U?=
 =?us-ascii?Q?mb033yRX//6UqBFQgjFj4+gv2QjbuB4UoWWo3logv0VsuNVA5e1wwWMx1Xfs?=
 =?us-ascii?Q?rsWh3kqQ34XyiatHGGYakf9fXJ8USDuQCeGGNEmS5mbxpe+EYrEMItpiZkWa?=
 =?us-ascii?Q?FP70Jp1WKA00kGed57xl0z6mCbpciCR49Lf82Ov8r/1oTZVd4UDZdSqIH0+U?=
 =?us-ascii?Q?HCdEL/PBzMXOWU6yNwU48iYg3p08ELotkbAJaLp+8Qg8HI2qAOuCaFKa3yh7?=
 =?us-ascii?Q?kgnTXnMgJqLTZ06PiMXhK2yJgc9qGV2cJjPqpa1HrkR/D2GBFwKGlelfdbTY?=
 =?us-ascii?Q?+eKy+v9KfuYpF2Y2HCLglWsXPVHqrTOhz5A4+tvuPYFBZ7qf00iXuxpr88jg?=
 =?us-ascii?Q?6GAzFp2u8CFKXu4YNatcE80lqUnNzIMGD95f+qprXq5hne6pW1Zjgl42TaKm?=
 =?us-ascii?Q?AR/A1K6SHSXJx7dnmIgIqrgBdHYLQHaISJy9Wi5SvPF3kVvhE604rJ2xlkIc?=
 =?us-ascii?Q?4EdS+0uSaKksywL92GXCovcceuIREQR+h4TsYZyMoYyrZSJwmIEyjjoa6cYe?=
 =?us-ascii?Q?0Oooft7mchk2zbjtcpCDBOfhfl+YIwlPfrjg2E9iy05c27QdgRvd4r9zJA0I?=
 =?us-ascii?Q?d9gLmhlpbU0+aZWhYm925H/EUZlkl5O5zd+1Jo7r+06esOQYEZ+LO0b9EmwR?=
 =?us-ascii?Q?SsSfj+MUyaAeM4rVHy6JkYdLCJDm5HbDPNR0JBbJGFmT17CCR5zxZCHwGlg+?=
 =?us-ascii?Q?zWuEAsNolprNUZmBYMqjkXKjWH6AHdNn1f8xfLnrbjQMJIl31eUlVLnNiD2k?=
 =?us-ascii?Q?+23wQAXXngASYi3+s5pj3GfuL5vMDGjuq8X+d+RBbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XzjieEDy3dZE0SL9mkomJsyOtw5hXLccTrNJOPKEjsEzGfO+AkRWhiWtaja?=
 =?us-ascii?Q?KXGk1903EFdaCHTqt/fasqj518K9IHcTZw9EvPqkhpeGuiImAbH1j898J43H?=
 =?us-ascii?Q?mVTIIAelseejTm21ZOZqNfXke+AVNwUAedmlcNih/ZCRjCXoHJNSX6XMsYRp?=
 =?us-ascii?Q?aZgXnJL1hEFwUTMK7r3lZg8bU1KgKSgIvmtRve9GsQ7NuVfM5hWX2Wt6LsTp?=
 =?us-ascii?Q?VnQtFCt5AuVfVWpfZkcTU7eikluysGinrLXK/qzKvxjVjLyOCTMblVfVnwGY?=
 =?us-ascii?Q?Vwsaa/hYd1Ph1+Df2KoFKk7kGVL94sJ6auxCMgL26dglVt1BtcjH2M/au+Ps?=
 =?us-ascii?Q?A+V2GQFND3/DftVBhEsGzyj+l+VH8887rH0TUikDGzOLJQlJy6o+bpXCAa7K?=
 =?us-ascii?Q?exluZN87ObMzRsYhuRPGL4J62/ya/w8Shx+MJianDhs2UkthlugRbGC1jjo9?=
 =?us-ascii?Q?B9mzRxc9kTi2r46iVxraVk6uJjSjiTa4VNXCVp/E5MWdW3T6zpfFX3aw87vI?=
 =?us-ascii?Q?pIAGCpF9EB3UYEzFO1Mwt46+Gru6eCI8eTpk8XhuDfGW0OmXpdD81JxcU4zj?=
 =?us-ascii?Q?laETEuuMMAh2jtp8R5YOm/uZHvAc/0s1eMQ9BIOs1ItfJko08lCHD2dq5OBa?=
 =?us-ascii?Q?BgNFAb+B6OYwLjoTPao0lmDWx4JJPU/kT5iLCk+5O+piRMmNRa7JB4M/abo8?=
 =?us-ascii?Q?XRwHijTeAxjbpMlSKrMWF/HSbukAQUoDwWHK5U7E57WdySC58Wo8X20jHbJ+?=
 =?us-ascii?Q?pNROIXSCD28c3X/6eX+P0VDLaRpXJ1CdkBR4bcMaVwlh9zIReGvyUWd9veKi?=
 =?us-ascii?Q?Xsd7uwIAPXBTWhHAIWI5sJB1qYJYC62OSFqokRmL3IYeD59ULtwNGvmSMLrQ?=
 =?us-ascii?Q?K3/EKaZXIEphub9yj32XrvnmQc1BJmSgzKJg/9pqsMJS/D0mBGYIzWoEk7n3?=
 =?us-ascii?Q?p2q4fE2xjDC5r2slIa5UPEu40iNNtyuVDFXD5nq2gFaxSec/v21WaBjcIpiC?=
 =?us-ascii?Q?N9zjcYmCSH8j2s9RsXkhq/fh+bCCHzwop6wj5rV4XqjWr/ogSHEsTtay2muD?=
 =?us-ascii?Q?ZnRoswby+Va1ESJPGdB2Lj474PSWj8ueLOoHWk8i/ZOa5cwqp4t2TSYZL5V/?=
 =?us-ascii?Q?T3Vpl63RiBybAEGp7HFfPqyD4bDx7XsQuSpUXfTNEIfFZYfMeznMmqSfZZge?=
 =?us-ascii?Q?HnNwFppgMMuwn96LxN2yPy6noukm6915B+PXsu8bm+N0ZsagrgQlys1bWeWd?=
 =?us-ascii?Q?MJZyNP13zUAlE8ya80KqMa3x3kl9tWX1o4Ii/E9qu+hRoWoyA1oqDYM2bNGk?=
 =?us-ascii?Q?KaiTCdPytWetealxj+LQQIvv+I9Y9Ri9mHu9d8aiqt94P8Sv96pdUmUvbw+k?=
 =?us-ascii?Q?Rau1v0nhy5FbO5YHxFT4nugQP3D3fJTaFxe/yvyBb0sIZ/RUVbcNYYlR9MpP?=
 =?us-ascii?Q?HqdzktAkvLPt2isnhd2hy8DCuMQ/xJPTCy6BmyqmeoIek0lUweZBm3U/G8W8?=
 =?us-ascii?Q?C4KTQzhyDTq+Jn+qLWOzrcjn2nG2/UQTHWHerwF9tHOBvjETO84jmNq6Odwp?=
 =?us-ascii?Q?7zHFY8cR9eVeEqGoWSqxZ0GiajBK2vkSi+gV4sOPxHZgJ+6xA76JkRsx8MlD?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9304be61-e365-4c47-c2c7-08dc75a8ab57
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:04:07.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONMOmpA7ln3pe/SfKrporxW/FMpSmhC92CeK+3uStU03qucBBX3rWmQk7I/E6BGe1Rm2CVEinvQpqr0oDmsp/eiAfH/gDPuPKuGqaJD4bVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

Add utilitary function to check if the information from a BIS is matching
the capabilities in bt_bap. This utilitary is used when parsing the BASE
data so that we can decide if we create a new setup/stream/transport for
it, or advance to the next BIS.
---
 src/shared/bap.c | 21 +++++++++++++++++++++
 src/shared/bap.h |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 919ecbb6a016..c927ddc21572 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6521,3 +6521,24 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
 cleanup:
 	util_iov_free(merge_data.result, 1);
 }
+
+void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
+		struct bt_bap_codec *codec,
+		struct iovec *l2_caps,
+		struct iovec *l3_caps,
+		struct bt_bap_pac **lpac,
+		struct iovec **caps)
+{
+	struct bt_ltv_extract merge_data = {0};
+
+	merge_data.src = l3_caps;
+	merge_data.result = new0(struct iovec, 1);
+
+	/* Create a Codec Specific Configuration with LTVs at level 2 (subgroup)
+	 * overwritten by LTVs at level 3 (BIS)
+	 */
+	util_ltv_foreach(l2_caps->iov_base,
+			l2_caps->iov_len,
+			NULL,
+			bap_sink_check_level2_ltv, &merge_data);
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 62e2104850c7..c9cc4c3a4db7 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -257,3 +257,10 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct iovec *l3_caps,
 		struct iovec *meta);
 
+void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
+		struct bt_bap_codec *codec,
+		struct iovec *l2_caps,
+		struct iovec *l3_caps,
+		struct bt_bap_pac **lpac,
+		struct iovec **caps);
+
-- 
2.40.1

