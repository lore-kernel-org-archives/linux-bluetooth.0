Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/4H9HnZ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E327FF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 05:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0+ClCo/0NIwpk+pCQVMhTxDTA0TNCvEwfWlhRg6qrSS4W/9Xs9iSbpoRbBCQssCmMWqI/vZ53TlB2lsz3A1DHnWKzk+IBy7C3WYsXyYfobEl5gtfUrno12Zr7dWYhl4ctQpLnIPGArSsu1N5Fbqb/FTNQqjguOiusMmNR5pl+skzf/T1X44IQ0XdfxvJh1d3pV0dBgAS+I49NNA+7+5rV5nwDuyuJxhk/Lb6VRWKiqaknUV6Kpe1cg7rjX6LPGajtua64njpO1qBKQkYFmVau1JACxpwq8kl4YMj35d8fwLoQCA6LhrCTifrMJgKfDCUQvjEgnR+rvSZjgdzB2Pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNQxlv7uNjEpVJUzwz04LDu4SkDql/nMFIa/wcHgdcM=;
 b=CANf2LPiDQdy1BpXr6JJWP/woHI5SM7ysITH9D3WkGKl3jEvlKyQLcj8o3Guw/xjRxt1P9oKU1GgOtXa5FJxhWBvrWHYp5CHeMTEoXy2HJardv5NlSLPzBUmfaPEv92i/FAdnI09osGKrRIXGmAoRfFEm4mo+/AOtT3loUlKSVeUSG+8SswKbF/wIUDj77zYj8unnLXXgpD08+SHW7ZhHzfWBJPgXw+0Jtr6MuawRis4L4nXMx8ejUzDzKLSFxQKK39HPrGTfVwgmnVD5HSo+X7pRkiyu0gZ39ZqGMK4s2Gr3p/Irv4vlhX01AD7AUQIYrm2Daqpu34f2q6m7w0vAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNQxlv7uNjEpVJUzwz04LDu4SkDql/nMFIa/wcHgdcM=;
 b=O/4H9HnZlktBbu7p2Zj1o76xbAYynjjUbBL+V7WOUA+Aeolow4T07fXQSLuBfS2lHEtdweNAkYxPIbV4r+I7dSD0B5oCZTQIeBXk8Q+UKLX65o6QBbsi8a7Pz0BBCEwG+vUQhOcOk0wTJILcCBqUo3UxUx6oLXqfNtlENZNnnVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 13:41:43 +0000
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::7d89:50bf:5a26:2d3d]) by AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::7d89:50bf:5a26:2d3d%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:41:43 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 2/2] - Code Implementation related Service- AICS. - Specification referred for implementation: 	AICS_v1.0.pdf - Verification: Tested all Mandatory PTS testcases and all 	mandatory testcases passed.
Date: Wed, 29 Nov 2023 15:40:58 +0200
Message-Id: <20231129134058.70612-3-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129134058.70612-1-mahesh.talewad@nxp.com>
References: <20231129134058.70612-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9654:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: f8770825-def9-4f42-867b-08dbf0e0ec2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/SWi0TzRHacmR+9Rm04VDnPvJY0AhN/niGRvzqcdjIjhKLa8OSUDn52vTQMfZvTemanAo/M3W7bb30cf69lTbaM/rjr9PCu8PCMe80N23oSt3styiZt7dlGfPrmK9rNEorNfn8ZNk7GbvR2EPPUMkRMV7tvUgJRXer0CT7PVI69E2764x4fzowrQCLoPYb6e9QrbkNVWY2X5GwrMCoaR7A4nmj0a5Hez6Q2Jksgt/dwk7Hfa1x7i0+gtQgDaGJ3U0KLe7riem5rCy00SlvCvfM6eGtTbi9clMhQTcVOoBAL8RuuyO536B7y9tTUKY5LjObcLtyk9eqS3GaKjjanh6ZWeZrJHyzG6QNgaT0zVN4CsszdazWYgr2fs/IrRUHXeTF+cfumTb9XrEDUrONGYQtY8qljxkyrfy1q/WlNDwA63JSmksL9tGXu4cP3eGHEEphwrFbnv7U4j+MqqH0f+Kgp3tdXyDsQE9FmfDUAHbErjs860KE64gOcZeFDGjCUbRp2h51flcJAIruoWNpuDwlXiZiCsoBk9NNj8FMOSOSJjpPmjmFys894xNHEmqgwK6GRJfSSkFZAX24HWUEq8ZwccD4KMXZL5WKgUrEknievaXpGy82knzE4Qa8Pzg3jF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9654.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(6512007)(2616005)(1076003)(6506007)(52116002)(83380400001)(30864003)(2906002)(478600001)(5660300002)(44832011)(41300700001)(66946007)(6486002)(4326008)(66476007)(8936002)(6916009)(316002)(66556008)(38100700002)(6666004)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBkYq2l+2X0JYIB3DMhbiEMfGGlZrluaXpGqzy1p3CXcx7xvlscnvsRyBa7x?=
 =?us-ascii?Q?5YRrQX8UG9rOhUfln8KWW1GPVsSt0Wf1et1VDVxODiZy+wRQesBsUhLTrZUj?=
 =?us-ascii?Q?Ly8O7gAxADPBuiguOtHxsts7J+X755ZMmWWS1/l8oYE7i0+H4eRmc2OvTwUv?=
 =?us-ascii?Q?Z5jh5qhgs/UsKMASagI3NkrH5Pbd/gKZAqQcZ3gWUGd+rgvLNT7k6o66n6TP?=
 =?us-ascii?Q?AIluiKJ+QwNbQSpp5Ius4GS0oPxIsUfh/Yfygvi/bUG8M+jp4fvk9WJdHaKD?=
 =?us-ascii?Q?F6iETqk8XmnqvecY6caamJZodoGK8/lal+gmCRhHGdmzTS9QlCpkImk3fQFb?=
 =?us-ascii?Q?X6MRAxdIwKqUPLoWUCfGkv0pP4sRwdlubKqK+vadgtt8cRJmwU9nVlw9UbEq?=
 =?us-ascii?Q?MXHxmKz8XoBtNZz6Hh+092LKic6Ukb4z/jn96we43xrbOrZfBWBcZvlxSEG9?=
 =?us-ascii?Q?xAE3nwBm2wfrCTHJ7pKSpgMUL0UM0MeQC+rWgUt656RI7oEW/q+PgrVQJzoh?=
 =?us-ascii?Q?l0iuj+EIscNyNjj1xdw8/P6cwlDnkfa253AwKD69Y7LCoQx/5ADLedI1XS5M?=
 =?us-ascii?Q?X0agxUi/7Ht+OirpslWSDr3DMSnzRWs/EFSuYsnaNgHbUx477NY04of/iCt8?=
 =?us-ascii?Q?yTxt7ZFZjZcEBXeIrEtjH6Gvbnfgc7yxzq2ruu+WgfwIGOPOchwOdPPu3Cy7?=
 =?us-ascii?Q?4XdFu6UVYyGtuV5fIFvyQe5znpxNGEyxkMuiC45IaJaTz3xJG0WA7TjAN+gO?=
 =?us-ascii?Q?xm4uAwKs49CrUn8M0kFrhxaQS3plF2K7j7N/T3eEhJFaz9dKISfrVUJDRPST?=
 =?us-ascii?Q?YIe9HzTKNCbYkCGdHy1B19NTgWG/R2w0wxpW3FvL+ZAKxBgZoVIlZDDfQJXY?=
 =?us-ascii?Q?18l45oFCtjAVBHw+kToDKwMLXGIOAHkxKjkaMBKw5Okf9Dmo5mlqoJ460iad?=
 =?us-ascii?Q?xzSlWgEk9vEjdOwopIheVzCiai0v+HZuyXn/g0T8+iHvVEZjzqEh1YMkt/a2?=
 =?us-ascii?Q?Pywc4WnGHFA8K3AaaGorpFY28GkR7buGF28USZ0YYkL/b9pGzZFCNOGT5k80?=
 =?us-ascii?Q?f6kBbyHFhKuE5r2XuoJDmzYjUl+vUe1F7s8mTEqqHkXYUcvW+vnQW5E/7ure?=
 =?us-ascii?Q?Gqv1skFBGDOEB8h1i6CBh9IuIZfr4zPlnLLI66lYzLNMuKA7BaNoG4McWcUl?=
 =?us-ascii?Q?e0vHaDwq91UFofOl89Jq/DXdbkpVbLVyv4Zd+4X6apBtJYnhOyWl9IKZIbcr?=
 =?us-ascii?Q?ErvDI/7cMoFdzjKU34TATcxbFOfyjsk/x2yS3wrL2XC7VlLOpcq+lLRSJhxx?=
 =?us-ascii?Q?37pOq6FnhHMyHul4jCZ7Ck7boGd+o/d+dlCYQHVGi4n7Q6Hm7FihTFijLBtb?=
 =?us-ascii?Q?AL3jk68rjgJD0p5ZozxHb2uRW4eZan60vrnNfpMLDB/HUGg5Ia4wh8OnK81r?=
 =?us-ascii?Q?GTJkqMR5qZ1zYQ8y+EZ4qHGlX0G9f6OgZe0K3KI318RJlQHf/w4diWH7HPTP?=
 =?us-ascii?Q?080K07UpSXfhOcgagRPH0+XMMYzxuVXeCtK8GRZwk9B8eWmwxrg3Ml5UwIK9?=
 =?us-ascii?Q?Zfx0EWrvXRqYW/+Nb11HzjoJEsBo5sCIDdoPUMzc0AOo/gu06oqZG2oLj8tf?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8770825-def9-4f42-867b-08dbf0e0ec2d
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9654.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:41:43.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nll3W2lE47m6Q7YekIybyzvJij7FRVG8CleAc1Ce9BeVFFPacsYYxtjiSQVZOdCwVxNHZL33ZN5DpkIB6MhVOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326

---
 src/shared/vcp.c | 1009 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 1008 insertions(+), 1 deletion(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 263da4c30..cf919526b 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -39,6 +39,9 @@
 #define BT_ATT_ERROR_INVALID_CHANGE_COUNTER	0x80
 #define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED	0x81
 #define BT_ATT_ERROR_VALUE_OUT_OF_RANGE		0x82
+#define BT_ATT_AICS_ERROR_VALUE_OUT_OF_RANGE	0x83
+#define BT_ATT_AICS_ERROR_MUTE_DISABLED			0x82
+#define BT_ATT_AICS_ERROR_GAIN_MODE_CHANGE_NOT_ALLOWED	0x84
 
 #define BT_VCP_NA                   BIT(0)
 #define BT_VCP_FRONT_LEFT           BIT(1)
@@ -70,10 +73,52 @@
 #define BT_VCP_LEFT_SURROUND        BIT(27)
 #define BT_VCP_RIGHT_SURROUND       BIT(28)
 
+#define VCS_TOTAL_NUMB_HANDLES	11
+#define AICS_TOTAL_NUM_HANDLES	16
+
+/* AICS Audio Input Type Values */
+#define AICS_AUD_IP_TYPE_UNSPECIFIED		0x00
+#define AICS_AUD_IP_TYPE_BLUETOOTH		0x01
+#define AICS_AUD_IP_TYPE_MICROPHONE		0x02
+#define AICS_AUD_IP_TYPE_ANALOG		0x03
+#define AICS_AUD_IP_TYPE_DIGITAL		0x04
+#define AICS_AUD_IP_TYPE_RADIO			0x05
+#define AICS_AUD_IP_TYPE_STREAMING		0x06
+#define AICS_AUD_IP_TYPE_AMBIENT		0x07
+
+/* AICS Audio Input Status Values */
+#define AICS_AUD_IP_STATUS_INACTIVE	0x00
+#define AICS_AUD_IP_STATUS_ACTIVE	0x01
+
+/* AICS Audio Input Control Point Opcodes */
+#define BT_AICS_SET_GAIN_SETTING		0x01
+#define BT_AICS_UNMUTE				0x02
+#define BT_AICS_MUTE				0x03
+#define BT_AICS_SET_MANUAL_GAIN_MODE		0x04
+#define BT_AICS_SET_AUTO_GAIN_MODE		0x05
+
+/* AICS Gain Mode Field Value */
+#define AICS_GAIN_MODE_MANUAL_ONLY		0x00
+#define AICS_GAIN_MODE_AUTO_ONLY		0x01
+#define AICS_GAIN_MODE_MANUAL			0x02
+#define AICS_GAIN_MODE_AUTO			0x03
+
+/* AICS Mute Field Values */
+#define AICS_NOT_MUTED	0x00
+#define AICS_MUTED	0x01
+#define AICS_DISABLED	0x02
+
+#define AICS_GAIN_SETTING_UNITS	0.1
+#define AICS_GAIN_SETTING_MAX_VALUE	127
+#define AICS_GAIN_SETTING_MIN_VALUE	-128
+
+#define AICS_GAIN_SETTING_DEFAULT_VALUE	88
+
 struct bt_vcp_db {
 	struct gatt_db *db;
 	struct bt_vcs *vcs;
 	struct bt_vocs *vocs;
+	struct bt_aics *aics;
 };
 
 typedef void (*vcp_func_t)(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
@@ -138,6 +183,10 @@ struct bt_vcp {
 	unsigned int audio_loc_id;
 	unsigned int ao_dec_id;
 
+	unsigned int aics_ip_state_id;
+	unsigned int aics_ip_status_id;
+	unsigned int aics_ip_descr_id;
+
 	struct queue *notify;
 	struct queue *pending;
 
@@ -190,6 +239,43 @@ struct bt_vocs {
 	struct gatt_db_attribute *voaodec_ccc;
 };
 
+struct aud_ip_st {
+	int8_t	gain_setting;
+	uint8_t	mute;
+	uint8_t	gain_mode;
+	uint8_t	chg_counter;
+} __packed;
+
+struct gain_setting_prop {
+	uint8_t	gain_setting_units;
+	int8_t	gain_setting_min;
+	int8_t	gain_setting_max;
+} __packed;
+
+struct bt_aics_set_gain_setting {
+	uint8_t change_counter;
+	int8_t gain_setting;
+} __packed;
+
+struct bt_aics {
+	struct bt_vcp_db *vdb;
+	struct aud_ip_st *aud_ipst;
+	struct gain_setting_prop *gain_settingprop;
+	uint8_t	aud_input_type;
+	uint8_t	aud_input_status;
+	char *aud_input_descr;
+	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *aud_ip_state;
+	struct gatt_db_attribute *aud_ip_state_ccc;
+	struct gatt_db_attribute *gain_stting_prop;
+	struct gatt_db_attribute *aud_ip_type;
+	struct gatt_db_attribute *aud_ip_status;
+	struct gatt_db_attribute *aud_ip_status_ccc;
+	struct gatt_db_attribute *aud_ip_cp;
+	struct gatt_db_attribute *aud_ip_dscrptn;
+	struct gatt_db_attribute *aud_ip_dscrptn_ccc;
+};
+
 static struct queue *vcp_db;
 static struct queue *vcp_cbs;
 static struct queue *sessions;
@@ -268,6 +354,20 @@ static struct bt_vocs *vcp_get_vocs(struct bt_vcp *vcp)
 	return vcp->rdb->vocs;
 }
 
+static struct bt_aics *vcp_get_aics(struct bt_vcp *vcp)
+{
+	if (!vcp)
+		return NULL;
+
+	if (vcp->rdb->aics)
+		return vcp->rdb->aics;
+
+	vcp->rdb->aics = new0(struct bt_aics, 1);
+	vcp->rdb->aics->vdb = vcp->rdb;
+
+	return vcp->rdb->aics;
+}
+
 static void vcp_detached(void *data, void *user_data)
 {
 	struct bt_vcp_cb *cb = data;
@@ -298,6 +398,7 @@ static void vcp_db_free(void *data)
 
 	free(vdb->vcs);
 	free(vdb->vocs);
+	free(vdb->aics);
 	free(vdb);
 }
 
@@ -980,6 +1081,488 @@ static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
 							iov.iov_len);
 }
 
+static void aics_input_state_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_aics *aics = user_data;
+	struct iovec iov;
+
+	iov.iov_base = aics->aud_ipst;
+	iov.iov_len = sizeof(*aics->aud_ipst);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static void aics_gain_setting_prop_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_aics *aics = user_data;
+	struct iovec iov;
+
+	iov.iov_base = aics->gain_settingprop;
+	iov.iov_len = sizeof(*aics->gain_settingprop);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static void aics_audio_input_type_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_aics *aics = user_data;
+	struct iovec iov;
+
+	iov.iov_base = &aics->aud_input_type;
+	iov.iov_len = sizeof(aics->aud_input_type);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static void aics_input_status_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_aics *aics = user_data;
+	struct iovec iov;
+
+	iov.iov_base = &aics->aud_input_status;
+	iov.iov_len = sizeof(aics->aud_input_status);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static struct aud_ip_st *vdb_get_audipst(struct bt_vcp_db *vdb)
+{
+	if (!vdb->aics)
+		return NULL;
+
+	if (vdb->aics->aud_ipst)
+		return vdb->aics->aud_ipst;
+
+	return NULL;
+}
+
+static struct gain_setting_prop *vdb_get_gainsettingprop(
+					struct bt_vcp_db *vdb)
+{
+	if (!vdb->aics)
+		return NULL;
+
+	if (vdb->aics->gain_settingprop)
+		return vdb->aics->gain_settingprop;
+
+	return NULL;
+}
+
+static uint8_t aics_set_gain_setting(struct bt_aics *aics,
+				struct bt_vcp *vcp, struct iovec *iov)
+{
+	struct bt_vcp_db *vdb;
+	struct aud_ip_st *audipst;
+	struct bt_aics_set_gain_setting *req;
+	struct gain_setting_prop *gainsettngprop;
+	uint8_t	ret = 1;
+
+	vdb = vcp_get_vdb(vcp);
+	if (!vdb) {
+		DBG(vcp, "error: VDB not available");
+		ret = 0;
+		goto respond;
+	}
+
+	audipst = vdb_get_audipst(vdb);
+	if (!audipst) {
+		DBG(vcp, "error: Audio Input State value is not available");
+		ret = 0;
+		goto respond;
+
+	}
+
+	req = iov_pull_mem(iov, sizeof(*req));
+	if (!req) {
+		ret = 0;
+		goto respond;
+
+	}
+
+	if (req->change_counter != audipst->chg_counter) {
+		DBG(vcp, "Change Counter Mismatch Audio Input State!");
+		ret = BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
+		goto respond;
+	}
+
+	if (audipst->gain_mode != AICS_GAIN_MODE_MANUAL_ONLY &&
+		audipst->gain_mode != AICS_GAIN_MODE_MANUAL) {
+		DBG(vcp, "Gain Mode is not Manual only or Manual");
+		ret = BT_ATT_AICS_ERROR_GAIN_MODE_CHANGE_NOT_ALLOWED;
+		goto respond;
+	}
+
+	gainsettngprop = vdb_get_gainsettingprop(vdb);
+	if (req->gain_setting > gainsettngprop->gain_setting_max ||
+		req->gain_setting < gainsettngprop->gain_setting_min) {
+		DBG(vcp, "error: Value Out of Range");
+		ret = BT_ATT_AICS_ERROR_VALUE_OUT_OF_RANGE;
+		goto respond;
+	}
+
+	audipst->gain_setting = req->gain_setting;
+	/*Increment Change Counter*/
+	audipst->chg_counter = -~audipst->chg_counter;
+	gatt_db_attribute_notify(vdb->aics->aud_ip_state, (void *)audipst,
+				sizeof(struct aud_ip_st),
+				bt_vcp_get_att(vcp));
+	ret = 0;
+
+respond:
+	return ret;
+}
+
+static uint8_t aics_unmute(struct bt_aics *aics, struct bt_vcp *vcp,
+							struct iovec *iov)
+{
+	struct bt_vcp_db *vdb;
+	struct aud_ip_st *audipst;
+	uint8_t *change_counter;
+	uint8_t	ret = 1;
+
+	vdb = vcp_get_vdb(vcp);
+	if (!vdb) {
+		DBG(vcp, "Error: VDB not available");
+		ret = 0;
+		goto respond;
+
+	}
+
+	audipst = vdb_get_audipst(vdb);
+	if (!audipst) {
+		DBG(vcp, "Error: Audio Input State value is not available");
+		ret = 0;
+		goto respond;
+
+	}
+	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	if (!change_counter) {
+		ret = 0;
+		goto respond;
+
+	}
+
+	if (*change_counter != audipst->chg_counter) {
+		DBG(vcp, "Change Counter Mismatch Audio Input State!");
+		ret = BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
+		goto respond;
+	}
+
+	if (audipst->mute == AICS_DISABLED) {
+		DBG(vcp, "Mute state is Disabled!");
+		ret = BT_ATT_AICS_ERROR_MUTE_DISABLED;
+		goto respond;
+	}
+
+	audipst->mute = AICS_NOT_MUTED;
+	/*Increment Change Counter*/
+	audipst->chg_counter = -~audipst->chg_counter;
+	gatt_db_attribute_notify(vdb->aics->aud_ip_state, (void *)audipst,
+				sizeof(struct aud_ip_st),
+				bt_vcp_get_att(vcp));
+	ret = 0;
+
+respond:
+	return ret;
+}
+
+static uint8_t aics_mute(struct bt_aics *aics, struct bt_vcp *vcp,
+						struct iovec *iov)
+{
+	struct bt_vcp_db *vdb;
+	struct aud_ip_st *audipst;
+	uint8_t *change_counter;
+	uint8_t	ret = 1;
+
+	vdb = vcp_get_vdb(vcp);
+	if (!vdb) {
+		DBG(vcp, "error: VDB not available");
+		ret = 0;
+		goto respond;
+	}
+
+	audipst = vdb_get_audipst(vdb);
+	if (!audipst) {
+		DBG(vcp, "error: Audio Input State value is not available");
+		ret = 0;
+		goto respond;
+	}
+	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	if (!change_counter) {
+		ret = 0;
+		goto respond;
+	}
+
+	if (*change_counter != audipst->chg_counter) {
+		DBG(vcp, "Change Counter Mismatch Audio Input State!");
+		ret = BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
+		goto respond;
+	}
+
+	if (audipst->mute == AICS_DISABLED) {
+		DBG(vcp, "Mute state is Disabled!");
+		ret = BT_ATT_AICS_ERROR_MUTE_DISABLED;
+		goto respond;
+	}
+
+	audipst->mute = AICS_MUTED;
+	/*Increment Change Counter*/
+	audipst->chg_counter = -~audipst->chg_counter;
+	gatt_db_attribute_notify(vdb->aics->aud_ip_state, (void *)audipst,
+				sizeof(struct aud_ip_st),
+				bt_vcp_get_att(vcp));
+	ret = 0;
+
+respond:
+	return ret;
+}
+
+static uint8_t aics_set_manual_gain_mode(struct bt_aics *aics,
+				struct bt_vcp *vcp, struct iovec *iov)
+{
+	struct bt_vcp_db *vdb;
+	struct aud_ip_st *audipst;
+	uint8_t *change_counter;
+	uint8_t	ret = 1;
+
+	vdb = vcp_get_vdb(vcp);
+	if (!vdb) {
+		DBG(vcp, "error: VDB not available");
+		ret = 0;
+		goto respond;
+	}
+
+	audipst = vdb_get_audipst(vdb);
+	if (!audipst) {
+		DBG(vcp, "error: Audio Input State value is not available");
+		ret = 0;
+		goto respond;
+	}
+
+	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	if (!change_counter) {
+		ret = 0;
+		goto respond;
+	}
+
+	if (*change_counter != audipst->chg_counter) {
+		DBG(vcp, "Change Counter Mismatch Audio Input State!");
+		ret = BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
+		goto respond;
+	}
+
+	if (audipst->gain_mode == AICS_GAIN_MODE_AUTO_ONLY ||
+		audipst->gain_mode == AICS_GAIN_MODE_MANUAL_ONLY) {
+		DBG(vcp, "Error!! gain mode is Automatic only or Manual only");
+		ret = BT_ATT_AICS_ERROR_GAIN_MODE_CHANGE_NOT_ALLOWED;
+		goto respond;
+	}
+
+	if (audipst->gain_mode == AICS_GAIN_MODE_AUTO) {
+		audipst->gain_mode = AICS_GAIN_MODE_MANUAL;
+		/*Increment Change Counter*/
+		audipst->chg_counter = -~audipst->chg_counter;
+		gatt_db_attribute_notify(vdb->aics->aud_ip_state,
+					(void *)audipst,
+					sizeof(struct aud_ip_st),
+					bt_vcp_get_att(vcp));
+		ret = 0;
+	} else {
+		DBG(vcp,
+		"Error!! Gain mode field val not Automatic");
+		ret = BT_ATT_AICS_ERROR_GAIN_MODE_CHANGE_NOT_ALLOWED;
+	}
+
+respond:
+	return ret;
+}
+
+static uint8_t aics_set_auto_gain_mode(struct bt_aics *aics, struct bt_vcp *vcp,
+				struct iovec *iov)
+{
+	struct bt_vcp_db *vdb;
+	struct aud_ip_st *audipst;
+	uint8_t *change_counter;
+	uint8_t	ret = 1;
+
+	vdb = vcp_get_vdb(vcp);
+	if (!vdb) {
+		DBG(vcp, "error: VDB not available");
+		ret = 0;
+		goto respond;
+	}
+
+	audipst = vdb_get_audipst(vdb);
+	if (!audipst) {
+		DBG(vcp, "error: Audio Input State value is not available");
+		ret = 0;
+		goto respond;
+	}
+	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	if (!change_counter) {
+		ret = 0;
+		goto respond;
+	}
+
+	if (*change_counter != audipst->chg_counter) {
+		DBG(vcp, "Change Counter Mismatch Audio Input State!");
+		ret = BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
+		goto respond;
+	}
+
+	if (audipst->gain_mode == AICS_GAIN_MODE_AUTO_ONLY ||
+		audipst->gain_mode == AICS_GAIN_MODE_MANUAL_ONLY) {
+		DBG(vcp, "Error!! gain mode is Automatic only or Manual only");
+		ret = BT_ATT_AICS_ERROR_GAIN_MODE_CHANGE_NOT_ALLOWED;
+		goto respond;
+	}
+
+	if (audipst->gain_mode == AICS_GAIN_MODE_MANUAL) {
+		audipst->gain_mode = AICS_GAIN_MODE_AUTO;
+		/*Increment Change Counter*/
+		audipst->chg_counter = -~audipst->chg_counter;
+		gatt_db_attribute_notify(vdb->aics->aud_ip_state,
+				(void *)audipst,
+				sizeof(struct aud_ip_st), bt_vcp_get_att(vcp));
+		ret = 0;
+	} else {
+		DBG(vcp, "Error!! Gain mode field value is not Manual");
+		ret = BT_ATT_AICS_ERROR_GAIN_MODE_CHANGE_NOT_ALLOWED;
+	}
+
+respond:
+	return ret;
+}
+
+#define AICS_OP(_str, _op, _size, _func) \
+	{ \
+			.str = _str, \
+			.op = _op, \
+			.size = _size, \
+			.func = _func, \
+	}
+
+struct aics_op_handler {
+		const char *str;
+		uint8_t op;
+		size_t  size;
+		uint8_t (*func)(struct bt_aics *aics, struct bt_vcp *vcp,
+				struct iovec *iov);
+} aics_handlers[] = {
+		AICS_OP("Set Gain Setting", BT_AICS_SET_GAIN_SETTING,
+				sizeof(struct bt_aics_set_gain_setting),
+				aics_set_gain_setting),
+		AICS_OP("Unmute", BT_AICS_UNMUTE,
+				sizeof(uint8_t), aics_unmute),
+		AICS_OP("Mute", BT_AICS_MUTE,
+				sizeof(uint8_t), aics_mute),
+		AICS_OP("Set Manual Gain Mode", BT_AICS_SET_MANUAL_GAIN_MODE,
+				sizeof(uint8_t), aics_set_manual_gain_mode),
+		AICS_OP("Set Automatic Gain Mode", BT_AICS_SET_AUTO_GAIN_MODE,
+				sizeof(uint8_t), aics_set_auto_gain_mode),
+	{}
+};
+
+static void aics_ip_cp_write(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *value, size_t len,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_aics *aics = user_data;
+	struct bt_vcp *vcp = vcp_get_session(att, aics->vdb->db);
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = len,
+	};
+	uint8_t	*aics_op;
+	struct aics_op_handler *handler;
+	uint8_t ret = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+
+	DBG(vcp, "AICS Control Point Write");
+
+	if (offset) {
+		DBG(vcp, "invalid offset %d", offset);
+		ret = BT_ATT_ERROR_INVALID_OFFSET;
+		goto respond;
+	}
+
+	if (len < sizeof(*aics_op)) {
+		DBG(vcp, "invalid len %ld < %ld sizeof(*param)", len,
+							sizeof(*aics_op));
+		ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto respond;
+	}
+
+	aics_op = iov_pull_mem(&iov, sizeof(*aics_op));
+
+	for (handler = aics_handlers; handler && handler->str; handler++) {
+		if (handler->op != *aics_op)
+			continue;
+
+		if (iov.iov_len < handler->size) {
+			DBG(vcp, "invalid len %ld < %ld handler->size", len,
+				handler->size);
+			ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
+			goto respond;
+		}
+
+		break;
+	}
+
+	if (handler && handler->str) {
+		DBG(vcp, "%s", handler->str);
+
+		ret = handler->func(aics, vcp, &iov);
+	} else {
+		DBG(vcp, "Unknown opcode 0x%02x", *aics_op);
+		ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
+	}
+
+respond:
+	gatt_db_attribute_write_result(attrib, id, ret);
+}
+
+static void aics_input_descr_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_aics *aics = user_data;
+	struct iovec iov;
+
+	iov.iov_base = aics->aud_input_descr;
+	iov.iov_len = strlen(aics->aud_input_descr);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static void aics_input_descr_write(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *value, size_t len,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	/* AICS optional feature */
+}
+
 static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 {
 	struct bt_vcs *vcs;
@@ -998,9 +1581,12 @@ static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 
 	/* Populate DB with VCS attributes */
 	bt_uuid16_create(&uuid, VCS_UUID);
-	vcs->service = gatt_db_add_service(db, &uuid, true, 10);
+	vcs->service = gatt_db_add_service(db, &uuid, true,
+						VCS_TOTAL_NUMB_HANDLES);
 	gatt_db_service_add_included(vcs->service, vdb->vocs->service);
 	gatt_db_service_set_active(vdb->vocs->service, true);
+	gatt_db_service_add_included(vcs->service, vdb->aics->service);
+	gatt_db_service_set_active(vdb->aics->service, true);
 
 	bt_uuid16_create(&uuid, VOL_STATE_CHRC_UUID);
 	vcs->vs = gatt_db_service_add_characteristic(vcs->service,
@@ -1109,6 +1695,108 @@ static struct bt_vocs *vocs_new(struct gatt_db *db)
 	return vocs;
 }
 
+static struct bt_aics *aics_new(struct gatt_db *db)
+{
+	struct bt_aics *aics;
+	struct aud_ip_st *aics_aud_ip_st;
+	struct gain_setting_prop *aics_gain_settng_prop;
+	char *ip_descr;
+	char ip_descr_str[] = "Blueooth";
+	bt_uuid_t uuid;
+
+	if (!db)
+		return NULL;
+
+	aics = new0(struct bt_aics, 1);
+
+	aics_aud_ip_st = new0(struct aud_ip_st, 1);
+	aics_gain_settng_prop = new0(struct gain_setting_prop, 1);
+	ip_descr = malloc(256);
+	memset(ip_descr, 0, 256);
+
+	aics_aud_ip_st->mute = AICS_NOT_MUTED;
+	aics_aud_ip_st->gain_mode = AICS_GAIN_MODE_MANUAL;
+	aics_aud_ip_st->gain_setting = AICS_GAIN_SETTING_DEFAULT_VALUE;
+	aics->aud_ipst = aics_aud_ip_st;
+	aics_gain_settng_prop->gain_setting_units = AICS_GAIN_SETTING_UNITS;
+	aics_gain_settng_prop->gain_setting_max = AICS_GAIN_SETTING_MAX_VALUE;
+	aics_gain_settng_prop->gain_setting_min = AICS_GAIN_SETTING_MIN_VALUE;
+	aics->gain_settingprop = aics_gain_settng_prop;
+	aics->aud_input_type =	AICS_AUD_IP_TYPE_BLUETOOTH;
+	aics->aud_input_status = AICS_AUD_IP_STATUS_ACTIVE;
+	memcpy(ip_descr, ip_descr_str, strlen(ip_descr_str));
+	aics->aud_input_descr = ip_descr;
+
+	/* Populate DB with AICS attributes */
+	bt_uuid16_create(&uuid, AUDIO_INPUT_CS_UUID);
+	aics->service = gatt_db_add_service(db, &uuid, false,
+					AICS_TOTAL_NUM_HANDLES);
+
+	bt_uuid16_create(&uuid, AICS_INPUT_STATE_CHAR_UUID);
+	aics->aud_ip_state = gatt_db_service_add_characteristic(aics->service,
+				&uuid,
+				BT_ATT_PERM_READ,
+				BT_GATT_CHRC_PROP_READ |
+				BT_GATT_CHRC_PROP_NOTIFY,
+				aics_input_state_read,
+				NULL,
+				aics);
+	aics->aud_ip_state_ccc = gatt_db_service_add_ccc(aics->service,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, AICS_GAIN_SETTING_PROP_CHAR_UUID);
+	aics->gain_stting_prop = gatt_db_service_add_characteristic(
+				aics->service,
+				&uuid,
+				BT_ATT_PERM_READ,
+				BT_GATT_CHRC_PROP_READ,
+				aics_gain_setting_prop_read, NULL,
+				aics);
+
+	bt_uuid16_create(&uuid, AICS_AUDIO_INPUT_TYPE_CHAR_UUID);
+	aics->aud_ip_type = gatt_db_service_add_characteristic(aics->service,
+				&uuid,
+				BT_ATT_PERM_READ,
+				BT_GATT_CHRC_PROP_READ,
+				aics_audio_input_type_read, NULL,
+				aics);
+
+	bt_uuid16_create(&uuid, AICS_INPUT_STATUS_CHAR_UUID);
+	aics->aud_ip_status = gatt_db_service_add_characteristic(aics->service,
+				&uuid,
+				BT_ATT_PERM_READ,
+				BT_GATT_CHRC_PROP_READ |
+				BT_GATT_CHRC_PROP_NOTIFY,
+				aics_input_status_read, NULL,
+				aics);
+	aics->aud_ip_status_ccc = gatt_db_service_add_ccc(aics->service,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, AICS_AUDIO_INPUT_CP_CHRC_UUID);
+	aics->aud_ip_cp = gatt_db_service_add_characteristic(aics->service,
+				&uuid,
+				BT_ATT_PERM_WRITE,
+				BT_GATT_CHRC_PROP_WRITE,
+				NULL, aics_ip_cp_write,
+				aics);
+
+	bt_uuid16_create(&uuid, AICS_INPUT_DESCR_CHAR_UUID);
+	aics->aud_ip_dscrptn = gatt_db_service_add_characteristic(aics->service,
+				&uuid,
+				BT_ATT_PERM_READ |
+				BT_ATT_PERM_WRITE,
+				BT_GATT_CHRC_PROP_READ |
+				BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP |
+				BT_GATT_CHRC_PROP_NOTIFY,
+				aics_input_descr_read,
+				aics_input_descr_write,
+				aics);
+	aics->aud_ip_dscrptn_ccc = gatt_db_service_add_ccc(aics->service,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	return aics;
+}
+
 static struct bt_vcp_db *vcp_db_new(struct gatt_db *db)
 {
 	struct bt_vcp_db *vdb;
@@ -1122,6 +1810,8 @@ static struct bt_vcp_db *vcp_db_new(struct gatt_db *db)
 	if (!vcp_db)
 		vcp_db = queue_new();
 
+	vdb->aics = aics_new(db);
+	vdb->aics->vdb = vdb;
 	vdb->vocs = vocs_new(db);
 	vdb->vocs->vdb = vdb;
 	vdb->vcs = vcs_new(db, vdb);
@@ -1676,6 +2366,307 @@ static void foreach_vocs_char(struct gatt_db_attribute *attr, void *user_data)
 
 }
 
+static void read_aics_audio_ip_state(struct bt_vcp *vcp, bool success,
+				  uint8_t att_ecode,
+				  const uint8_t *value, uint16_t length,
+				  void *user_data)
+{
+	struct aud_ip_st *ip_st;
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	if (!success) {
+		DBG(vcp, "Unable to read Audio Input State: error 0x%02x",
+			att_ecode);
+		return;
+	}
+
+	ip_st = iov_pull_mem(&iov, sizeof(*ip_st));
+	if (!ip_st) {
+		DBG(vcp, "Unable to get Audio Input State");
+		return;
+	}
+
+	DBG(vcp, "Audio Input State, Gain Setting:%d", ip_st->gain_setting);
+	DBG(vcp, "Audio Input State, Mute:%x", ip_st->mute);
+	DBG(vcp, "Audio Input State, Gain Mode:%x", ip_st->gain_mode);
+	DBG(vcp, "Audio Input State, Change Counter:%x", ip_st->chg_counter);
+}
+
+static void aics_ip_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct aud_ip_st ip_st;
+
+	memcpy(&ip_st, value, sizeof(struct aud_ip_st));
+
+	DBG(vcp, "Audio Input State, Gain Setting:%d", ip_st.gain_setting);
+	DBG(vcp, "Audio Input State, Mute:%x", ip_st.mute);
+	DBG(vcp, "Audio Input State, Gain Mode:%x", ip_st.gain_mode);
+	DBG(vcp, "Audio Input State, Change Counter:%x", ip_st.chg_counter);
+}
+
+static void read_aics_gain_setting_prop(struct bt_vcp *vcp, bool success,
+					 uint8_t att_ecode,
+					 const uint8_t *value, uint16_t length,
+					 void *user_data)
+{
+	struct gain_setting_prop *aics_gain_setting_prop;
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	if (!value) {
+		DBG(vcp, "Unable to get AICS Gain Setting Properties Char");
+		return;
+	}
+
+	if (!success) {
+		DBG(vcp,
+		"Unable to read Gain Setting Prop Char: 0x%02x",
+		att_ecode);
+		return;
+	}
+
+	aics_gain_setting_prop = iov_pull_mem(&iov,
+				sizeof(*aics_gain_setting_prop));
+	if (!aics_gain_setting_prop) {
+		DBG(vcp, "Unable to get AICS Gain Setting Properties Char");
+		return;
+	}
+
+	DBG(vcp, "Gain Setting Properties, Units: %x",
+				aics_gain_setting_prop->gain_setting_units);
+	DBG(vcp, "Gain Setting Properties,  Min Value: %d",
+				aics_gain_setting_prop->gain_setting_min);
+	DBG(vcp, "Gain Setting Properties,  Max Value: %d",
+				aics_gain_setting_prop->gain_setting_max);
+}
+
+static void read_aics_aud_ip_type(struct bt_vcp *vcp, bool success,
+					 uint8_t att_ecode,
+					 const uint8_t *value, uint16_t length,
+					 void *user_data)
+{
+	uint8_t ip_type;
+
+	if (!success) {
+		DBG(vcp,
+		"Unable to read Audio Ip Type Char: error 0x%02x",
+		att_ecode);
+		return;
+	}
+
+	memcpy(&ip_type, value, length);
+
+	DBG(vcp, "AICS Audio Input Type : %x", ip_type);
+}
+
+static void read_aics_audio_ip_status(struct bt_vcp *vcp, bool success,
+					 uint8_t att_ecode,
+					 const uint8_t *value, uint16_t length,
+					 void *user_data)
+{
+	uint8_t ip_status;
+
+	if (!success) {
+		DBG(vcp,
+		"Unable to read Audio Ip Status Char: 0x%02x", att_ecode);
+		return;
+	}
+
+	memcpy(&ip_status, value, length);
+
+	DBG(vcp, "AICS Audio Input Status : %x", ip_status);
+}
+
+static void aics_ip_status_notify(struct bt_vcp *vcp, uint16_t value_handle,
+				const uint8_t *value,
+				uint16_t length,
+				void *user_data)
+{
+	uint8_t	ip_status;
+
+	memcpy(&ip_status, value, length);
+
+	DBG(vcp, "Audio Input Status, %x", ip_status);
+}
+
+static void read_aics_audio_ip_description(struct bt_vcp *vcp, bool success,
+					   uint8_t att_ecode,
+					   const uint8_t *value,
+					   uint16_t length,
+					   void *user_data)
+{
+	char *ip_descrptn;
+
+	if (!value) {
+		DBG(vcp, "Unable to get AICS Audio Input Description");
+		return;
+	}
+
+	if (!success) {
+		DBG(vcp,
+			"Unable to read Audio Ip Descrn char: error 0x%02x",
+			att_ecode);
+		return;
+	}
+
+	ip_descrptn = malloc(length+1);
+	memset(ip_descrptn, 0, length+1);
+	memcpy(ip_descrptn, value, length);
+
+	if (!ip_descrptn) {
+		DBG(vcp, "Unable to get AICS Audio Input Description");
+		return;
+	}
+
+	DBG(vcp, "AICS Audio Input Description: %s", ip_descrptn);
+	free(ip_descrptn);
+	ip_descrptn = NULL;
+}
+
+static void aics_audio_ip_desr_notify(struct bt_vcp *vcp, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	char *aud_ip_desr;
+
+	aud_ip_desr = malloc(length+1);
+	memset(aud_ip_desr, 0, length+1);
+	memcpy(aud_ip_desr, value, length);
+
+	DBG(vcp, "Audio Input Description Notify, %s", aud_ip_desr);
+	free(aud_ip_desr);
+	aud_ip_desr = NULL;
+}
+
+static void foreach_aics_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_ipstate, uuid_gain_setting_prop, uuid_ip_type,
+			uuid_ip_status, uuid_ip_cp, uuid_ip_decs;
+	struct bt_aics *aics;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_ipstate, AICS_INPUT_STATE_CHAR_UUID);
+	bt_uuid16_create(&uuid_gain_setting_prop,
+					AICS_GAIN_SETTING_PROP_CHAR_UUID);
+	bt_uuid16_create(&uuid_ip_type, AICS_AUDIO_INPUT_TYPE_CHAR_UUID);
+	bt_uuid16_create(&uuid_ip_status, AICS_INPUT_STATUS_CHAR_UUID);
+	bt_uuid16_create(&uuid_ip_cp, AICS_AUDIO_INPUT_CP_CHRC_UUID);
+	bt_uuid16_create(&uuid_ip_decs, AICS_INPUT_DESCR_CHAR_UUID);
+
+
+	if (!bt_uuid_cmp(&uuid, &uuid_ipstate)) {
+		DBG(vcp,
+			"Audio Ip State Char found: handle 0x%04x",
+			value_handle);
+
+		aics = vcp_get_aics(vcp);
+		if (!aics || aics->aud_ip_state)
+			return;
+
+		aics->aud_ip_state = attr;
+
+		vcp_read_value(vcp, value_handle,
+					read_aics_audio_ip_state, vcp);
+
+		vcp->aics_ip_state_id = vcp_register_notify(vcp, value_handle,
+					aics_ip_state_notify, NULL);
+
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_gain_setting_prop)) {
+		DBG(vcp,
+			"Gain Setting Props Char found: handle 0x%04x",
+			value_handle);
+
+		aics = vcp_get_aics(vcp);
+		if (!aics || aics->gain_stting_prop)
+			return;
+
+		aics->gain_stting_prop = attr;
+
+		vcp_read_value(vcp, value_handle, read_aics_gain_setting_prop,
+					   vcp);
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_ip_type)) {
+		DBG(vcp, "AICS Audio Input Type Char found: handle 0x%04x",
+			value_handle);
+
+		aics = vcp_get_aics(vcp);
+		if (!aics || aics->gain_stting_prop)
+			return;
+
+		aics->aud_ip_type = attr;
+
+		vcp_read_value(vcp, value_handle, read_aics_aud_ip_type,
+					   vcp);
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_ip_status)) {
+		DBG(vcp,
+			"Audio Ip Status Char found: handle 0x%04x",
+			value_handle);
+
+		aics = vcp_get_aics(vcp);
+		if (!aics || aics->aud_ip_status)
+			return;
+
+		aics->aud_ip_status = attr;
+
+		vcp_read_value(vcp, value_handle,
+				read_aics_audio_ip_status, vcp);
+
+		vcp->aics_ip_status_id = vcp_register_notify(vcp, value_handle,
+					aics_ip_status_notify, NULL);
+
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_ip_cp)) {
+		DBG(vcp, "AICS Input CP found: handle 0x%04x", value_handle);
+
+		aics = vcp_get_aics(vcp);
+		if (!aics || aics->aud_ip_cp)
+			return;
+
+		aics->aud_ip_cp = attr;
+
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_ip_decs)) {
+		DBG(vcp,
+			"Audio Ip Descrpn Char found: handle 0x%04x",
+			value_handle);
+
+		aics = vcp_get_aics(vcp);
+		if (!aics || aics->aud_ip_dscrptn)
+			return;
+
+		aics->aud_ip_dscrptn = attr;
+
+		vcp_read_value(vcp, value_handle,
+				read_aics_audio_ip_description, vcp);
+		vcp->aics_ip_descr_id = vcp_register_notify(vcp, value_handle,
+					aics_audio_ip_desr_notify, NULL);
+	}
+}
+
 static void foreach_vcs_service(struct gatt_db_attribute *attr,
 						void *user_data)
 {
@@ -1702,6 +2693,19 @@ static void foreach_vocs_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(attr, foreach_vocs_char, vcp);
 }
 
+static void foreach_aics_service(struct gatt_db_attribute *attr,
+						void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+	struct bt_aics *aics = vcp_get_aics(vcp);
+
+	aics->service = attr;
+
+	gatt_db_service_set_claimed(attr, true);
+
+	gatt_db_service_foreach_char(attr, foreach_aics_char, vcp);
+}
+
 bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
@@ -1727,6 +2731,9 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
 	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vocs_service, vcp);
 
+	bt_uuid16_create(&uuid, AUDIO_INPUT_CS_UUID);
+	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_aics_service, vcp);
+
 	return true;
 }
 
-- 
2.34.1

