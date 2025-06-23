Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C31A00E7;
	Mon, 23 Jun 2025 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664751; cv=fail; b=eSBJENLBIAm0Z2sRqoVOzJfBw/5cLgjSUEPoHzMiTuY1FqGOfD4JyUgE1RsnUGzfJpQFM3tw7i9GZ1GIVk1wa8OE6DhUzBUzzNJyom7HEUtPY4qSrxRaf04STlqMRahxD890R2OnlAm+dWIovCc/3tJV724eQPJbNQlvYbCTW6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664751; c=relaxed/simple;
	bh=LKENz2L/xmToizGSUcUMvhsaYzsv72oxBiMHjq6VwAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IV5cBxIxOUPuou1soCOtrGWx6m2pgZgGxikmnn48XEGnrlpp5KWJfrQOSPW88nYnDjW1A+vunDD2gIkw90IvCW55JBVaGjgg78MQNOB9yJsZT+kbWiInSsBTrfOGrnNUGn1KiMhKEQ+gkBe3xkHmlaD6U9/ihh7fgqm0DksuDgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OVjZHC03; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVjZHC03"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SllcG4QNrxRzGNOnnFdzVnqDHXjv72aY+RhxWDH9JK4ZxxVyJ1TyJ/ldsMpLnTvMS7zAuYecOfLCd9/mQRJmmifCMxir8k9v8ywqcDdeKMiZ8AHexiaWZIqiBfBLDWc9ttkBLgDmI6W2yzSq2+G6IMsPqes4XXKJLJ9pnps2kg+OE5zF//FxqC1AUOhx5hT9f0gXM03oIFrEz4P/4hHjCYX+TnjiaRJ13P9VhmsvlENgaRii3VUlBigxSoZCSzZDake+D5/JRHGtwHD4gCfe1ixymIgnJ/rbBv2xiYsszzdfQxyx6V211BiI4VHrBGfSSN7RBI270PFZ3bjriEjH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m9KvPs/72hmF3V0irlkgHU7zAVoo8X3Xbz/KFFg4lg=;
 b=TZyH9R+wUi00h3rOJXBJnMs6EyZ6teiMne+YRWdLCU2imB0aGXW/3yd2hhkw0xr/v+tBhf1f5Z2NhVUNfa4xHCSG5QwsRdRrWocV5O7Qynp2PBRWoUpzoz8OAzgFgS0zyjLJv1a+URRKE93p8S59OZz4sHjaWDEzGtwWsHGRYoii3gJ5JB6n6vd7vLIiQbcQ1TTjAr84xj0Kgkp88Nm7CAymSnOr5SNzyVRu4SVwtlu/76Iu181b89zxgBonkW7XrpUNtgBY/mjwruLo/W3UNFBQGk9cUf1yN3SVbwesjNgA3Lept2pHVCFFmrZyLucJeuCtwfTljuJDRSPClDLpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m9KvPs/72hmF3V0irlkgHU7zAVoo8X3Xbz/KFFg4lg=;
 b=OVjZHC03fkw7QyiZmeQk/GRzYa96eIkwW8nGKNvBjxExPkYk8AZ1NNGea6rQOh2aV1dlXnbzTHcvX78T23IALh4eVKOBGijZtADYBpBXPpZAgAIC7KEmPJ2uPSfq/IbEUjvgPoizJ8W8eAwIYqnqHAPTX3VvnQATzQdwayNJTFxXEhMDs0ONYxBCJXIHef3Zztjvv0tFC8+kaZhI0KkRayytINN7pJK4+ITnscKmymcA3wyc/90LlrEULxxmT0pdd8hIYQdbF7HQmPADMdHhJtoVyiCoBqk1/scq+pMRi4Q1wiIgPEgNVExf9UB1dxxJxvKPGCWZ4onIDmzDchdm3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8443.eurprd04.prod.outlook.com (2603:10a6:102:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 07:45:47 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 07:45:47 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	manjeet.gupta@nxp.com
Subject: [PATCH v5 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Date: Mon, 23 Jun 2025 12:57:44 +0530
Message-Id: <20250623072744.130594-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623072744.130594-1-neeraj.sanjaykale@nxp.com>
References: <20250623072744.130594-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5d9088-ab1d-4618-3d34-08ddb229f758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94VXqcnfwXt5RxaSb0jMYmNbtW5de8ByLdHRGeR/hVh4Viopv22j9Ue4otsd?=
 =?us-ascii?Q?+c6VyhlwymY1gI4ycRcOsWt28xmLbVn0zicGKrjVmCMZF5Y8Vhh1Iq932sm9?=
 =?us-ascii?Q?pPjk5RVimGVveQ0897s3+2k1cQ4SkFC3EoSC1ewXU7CYZcFvs8U98/vinIkd?=
 =?us-ascii?Q?WcOL8G+/6Yb/JSFSg9LfvMP7w1FgBjb1emyH+UJ3EOhxxEjFVz0hT5nkF2oz?=
 =?us-ascii?Q?6DWTxHMnX4yRpjUTY/TgzcnyHb8+sNg4Vl6WyDBFbSC7O6Tv0JN1W3Qs8N0Z?=
 =?us-ascii?Q?zkLtU6dJciV4NSuTIpX4DZSJWjsojmGbW9NnCbZ/SKxPBcVX45uOlDtas1OD?=
 =?us-ascii?Q?2hhIL0oqagwkhUs3ZhJ5ULmKKgl2m6RBPtIF8yklISCnK0TE7dctCFKeRun8?=
 =?us-ascii?Q?Hi4mEl4J85ccF+Ujcs8nhrw43ilRO0gxqDV0y4lxLCfgypuL71MhmkewnYbq?=
 =?us-ascii?Q?LDEbCTEQub3guXrDTzIhMvL2Ozq4mtd4ZkNmifENsGaL5HP+1sHogZDPTdML?=
 =?us-ascii?Q?Eo0ZRrEFel0cYtXqiXkMC8Fp6LlvIQ5mZhHWTtmkGaMh58BMgXr8qValjAko?=
 =?us-ascii?Q?JgIKB6waXOl+FG2nlHhJuA1vBgxN6yCmXTPnICln3qFmH+Gk8GTg9LS4bPyt?=
 =?us-ascii?Q?d+sYhfrN783v930foRSy4oo8sDtPoPGwbYguRI/+nAuoBMfb/pm8ck/QYXbu?=
 =?us-ascii?Q?xGqDca5TF7ebhADy8a2AoKWGvHhpBkKKqv7NepOesL+T7OVlLJ+CaNzbudQc?=
 =?us-ascii?Q?ERIy/ZyUiipmlDDzIweZ/CpCraWW7o2KwxDw+K1DPaQlw1DjlsdUVHBI+52G?=
 =?us-ascii?Q?C2fyA7vy5WfoUfk1qsSIQnFJJIwSySYvAxBotPwL8DWl/pPl+Qj2kn1/Naef?=
 =?us-ascii?Q?3dwRhaEYYHeCmPrTqQRrs91epAHf3J3CKSkEFK/Xwwj2yT2XkccjBdmQjjJs?=
 =?us-ascii?Q?uaen3dVnWDxE2U4YNlC43tjhT3asZYVw/ZnyBQL0mbjerzBmzKHVYtIhA7dy?=
 =?us-ascii?Q?9V3Ai9f/N0OKcLMtAzhSWSTnxZPESbifGk3AKiRwk568Xk4aWObgjqQ6SbzO?=
 =?us-ascii?Q?Q2aXqF9Nkdg0mJm91CaVCiUonkIoVilU7NGqDYf02x63dGF0o1iiAy8b68SN?=
 =?us-ascii?Q?uVxp9bgN3ql1yxZAm/8clLRhH/lk8GT90Y2wTKqkoFflRVDmFGCCsb8l1Ofe?=
 =?us-ascii?Q?/zafpq2VX3pxv7nLHA1L5tJNCRZC4Ghc+9qh8HRqarGvWDuL1lnnVcmiERlr?=
 =?us-ascii?Q?j0n3LG2qjTFdYWtf1kfdkFcETwn0y9b2DwNyGCMt6ii1pEtxFsEq7epI+my4?=
 =?us-ascii?Q?Mw4ciCEbiV2CRYyj9esmt+Vstj0qBsDLSu0lKAhps2smdk+BENZJ4fEeevKE?=
 =?us-ascii?Q?GXT9PeA669dYaJ60D69WjaxxVkGMXiDDGhOoDLxN+ly5c9f7wzrldpBezgcT?=
 =?us-ascii?Q?jd0lvf8jlSuY0J1GFbpnQYr3Jh9CljWzM92gnPcFLTH5oNMjZtoOOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/yIA1Nar1f3pgeJfrMDJ9eKywAbTeyBw5Icdt1XC4hpNGCo6yTHTP4DZT6s?=
 =?us-ascii?Q?0+2q1E64fz4DyzXhd91NPoKxHHvsRVlbcQy3lm3V0GfrMc0t7Qw7gBhFi666?=
 =?us-ascii?Q?LMXxdAGqTOyzYdtqEzoEm9bvQjqkRkRa25UGjfXHm5m+8i94rx4u7uwrvLD2?=
 =?us-ascii?Q?T20+suEl586bgveLZtQ63glfSd0alXVjXVsmq7PvrfDpRdPBBD9fT00p5rnI?=
 =?us-ascii?Q?JAoVnTh8nJG0Nn6a/SiFFGt+boHlxBZoqwatjuuUJzANLAgEdtev4sPNC58n?=
 =?us-ascii?Q?GMWpAkF0lRBQIJGbH/EKcGxnM+NBgAb0PybDkPtIkQ3u5DnLtWOJ8sK6rSrA?=
 =?us-ascii?Q?VX1GeLrs4o7BQ6H6p5+VoAzlK7GtgsX1kjcKxvUOKPddq2+t7nBrK5iDzZtU?=
 =?us-ascii?Q?e2X8kA9yUstFO2W3ZKl2GnhIDEFoPUfawlHrZF4YQUXn2b7Fge9kKMMfLV2o?=
 =?us-ascii?Q?R5mkfl3Uzfo3Ok3o1HqDMqDJAzvrel+Pgsa+TIfzajAgMeCDLdgGxGPhApZn?=
 =?us-ascii?Q?MFTtDtxgsNMZax5G1b6JVCmEhBnrNppIivw8Uc6mqPMNh1N8nk9vhWo0u4HI?=
 =?us-ascii?Q?O9zAbWmkXZ3U2PNuyFajNQFYscXnD/zQWNvY0fk0rzN0DqR/nFi9kDxlKzBW?=
 =?us-ascii?Q?AtRI2J1YI2AQeIBEk8UpNxBg9clP1SYLYnLf+KRHHrjWhv0rJ5Wu9vbziHlb?=
 =?us-ascii?Q?g6ovJEUZ8lLYSkJtg4czW2HFvvOSR4vOjl1fXQn2YhD5fQ9iQF2Ul8gUXYHM?=
 =?us-ascii?Q?NMXzHkXGoTolo6uCDnPL6mUs4oWK5r7JFcHZ90KPOXgDqqu4wE45sKIRs1t6?=
 =?us-ascii?Q?E1cpT7v0gnOUWaNYBc83+8P60DWzb7p8mszrUuh3Gu/sX9u19vCjAdBfL9Sh?=
 =?us-ascii?Q?pX0PSWa8GAnCZwO4xuWcwdhlGeC7bOG9yuZeEx88H0Qk94je4W0IgapWMjdx?=
 =?us-ascii?Q?W5rJp0NjuZ+jSfKTznh8nMU4UzqWGxAbNm5mOLN+VP6fTY1SFDs7+bS9fizh?=
 =?us-ascii?Q?9+IPqghE3wYAAsxX6DC4Sg+KTCoSFhk5RAUtN5kOAgs/gpqFFl+uueQNuuU3?=
 =?us-ascii?Q?hdMKk/vorG/F3YfSSMm0/0HL8utJoiq/Mi2INyxVilHoflDbGHBoYHWZ0q/d?=
 =?us-ascii?Q?Gf7qyY7+4IUUu7Q/uxmlppr0JrO8TGdSuFWj2WglzyXgaeNr5EdaF8QIPwNW?=
 =?us-ascii?Q?kCboipKBlJAi5rl58yntDjbMkX3Qyf+Y8Pr8ddQZ8K69/qUa71KRQzOvddKz?=
 =?us-ascii?Q?UlnTX1n/uy/E9GzUx3e+dKjoZgAIqkVS6G1QHCHv2imrmE8Aef12aGCY3BGw?=
 =?us-ascii?Q?QJXDCeTdkEBfeDAv4tmGUnTDbd8Da3GeArotbjlDi1D96ZhYUH2//747HCPG?=
 =?us-ascii?Q?/zYhkAGnggdRcXgjKrQYJpldkxt+Q8rmcHyxs9q5euZWOC6Yt02GB18S7oUl?=
 =?us-ascii?Q?yBVSySYvbyRrCN3LqfpotooMJeO1AU8Tnhg1FDxMufG1rlWcOmeK4AFr7VQC?=
 =?us-ascii?Q?utztQCUhhwWYNR7G5o/EZa/O0/BL2LV+HPC1mywoJwxiUt+vC6BOSqP2tR89?=
 =?us-ascii?Q?T70vV2jEX6RbUjLGqnNsIQ3NoiJyV3Ovlu/QuuJBX2TzfW2sHrNP1QCk8TB/?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5d9088-ab1d-4618-3d34-08ddb229f758
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 07:45:47.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iabJZyUL/Q9CFH5zOvJo1oXbgw+fWjnX47+W28vn/nlddVEiVGuDDT17C8/4QNYpwt7l/HFzMTuUjz0MhmwTmdJF/IrUKXAQOBl3e0mSEXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8443

This adds support for 4000000 as secondary baudrate.

This value is selected from device tree property "max-speed"
which is then used to download FW chunks, and as operational baudrate after
HCI initialization is done.

Earlier, the secondary baudrate was fixed to 3000000 in driver, but now
with "max-speed" property, this secondary baudrate can be set to
4000000.

The secondary baudrate is set by the driver by sending a vendor command
(3F 09) to the firmware, with secondary baudrate parameter, in
nxp_post_init().

Any other value set for max-speed other than 3000000 or 4000000 will
default to 3000000, which is supported by all legacy and new NXP chipsets.

This feature is applicable for all new V3 bootloader chips and w8987 V1
bootloader chip.

This property does not apply for w8997 compatible device, since it
downloads a helper.bin FW file that sets secondary baudrate as 3000000
only.

The switch to 4000000 baudrate is validated using a Saleae Logic Analyzer
and imx8m-mini with AW693 M.2 module.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Change DT property to 'max-speed'. (Krzysztof)
    Add support for 4M baudrate to w8987. Update commit message.
    (Sherry)
v3: Add check for 'max-speed' and set default to 3000000. (Sherry)
    Add functional and testing details in commit message. (Paul)
v4: Add error message for invalid max-speed. (Sherry)
v5: No Change.
---
 drivers/bluetooth/btnxpuart.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6b13feed06df..c56b52bd8d98 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -73,7 +73,8 @@
 #define FW_AUTH_ENC		0xc0
 
 #define HCI_NXP_PRI_BAUDRATE	115200
-#define HCI_NXP_SEC_BAUDRATE	3000000
+#define HCI_NXP_SEC_BAUDRATE_3M	3000000
+#define HCI_NXP_SEC_BAUDRATE_4M	4000000
 
 #define MAX_FW_FILE_NAME_LEN    50
 
@@ -201,6 +202,7 @@ struct btnxpuart_dev {
 	u32 new_baudrate;
 	u32 current_baudrate;
 	u32 fw_init_baudrate;
+	u32 secondary_baudrate;
 	enum bootloader_param_change timeout_changed;
 	enum bootloader_param_change baudrate_changed;
 	bool helper_downloaded;
@@ -802,7 +804,10 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 		nxpdev->fw_v3_offset_correction += req_len;
 	} else if (req_len == sizeof(uart_config)) {
 		uart_config.clkdiv.address = __cpu_to_le32(clkdivaddr);
-		uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
+		if (nxpdev->new_baudrate == HCI_NXP_SEC_BAUDRATE_4M)
+			uart_config.clkdiv.value = __cpu_to_le32(0x01000000);
+		else
+			uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
 		uart_config.uartdiv.address = __cpu_to_le32(uartdivaddr);
 		uart_config.uartdiv.value = __cpu_to_le32(1);
 		uart_config.mcr.address = __cpu_to_le32(uartmcraddr);
@@ -966,12 +971,13 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			goto free_skb;
 		}
 		if (nxpdev->baudrate_changed != changed) {
+			nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 			if (nxp_fw_change_baudrate(hdev, len)) {
 				nxpdev->baudrate_changed = changed;
 				serdev_device_set_baudrate(nxpdev->serdev,
-							   HCI_NXP_SEC_BAUDRATE);
+							   nxpdev->secondary_baudrate);
 				serdev_device_set_flow_control(nxpdev->serdev, true);
-				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+				nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 			}
 			goto free_skb;
 		}
@@ -992,7 +998,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			nxpdev->helper_downloaded = true;
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   HCI_NXP_SEC_BAUDRATE_3M);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -1216,12 +1222,13 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (nxpdev->baudrate_changed != changed) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		if (nxp_fw_change_baudrate(hdev, len)) {
 			nxpdev->baudrate_changed = cmd_sent;
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   nxpdev->secondary_baudrate);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
-			nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+			nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 		}
 		goto free_skb;
 	}
@@ -1447,8 +1454,8 @@ static int nxp_post_init(struct hci_dev *hdev)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
+	if (nxpdev->current_baudrate != nxpdev->secondary_baudrate) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
@@ -1773,6 +1780,17 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (!nxpdev->fw_init_baudrate)
 		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
 
+	device_property_read_u32(&nxpdev->serdev->dev, "max-speed",
+				 &nxpdev->secondary_baudrate);
+	if (!nxpdev->secondary_baudrate ||
+	    (nxpdev->secondary_baudrate != HCI_NXP_SEC_BAUDRATE_3M &&
+	     nxpdev->secondary_baudrate != HCI_NXP_SEC_BAUDRATE_4M)) {
+		if (nxpdev->secondary_baudrate)
+			dev_err(&serdev->dev,
+				"Invalid max-speed. Using default 3000000.");
+		nxpdev->secondary_baudrate = HCI_NXP_SEC_BAUDRATE_3M;
+	}
+
 	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
-- 
2.34.1

