Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fqYOBG4x"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E93172C
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 03:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es+fF7ziXneeujq3cpayvUvBAxkum4aXuQoyXBLunjhrbnSGmik9yMzBYwHYasBmI/3965moQnnGneZwS3BeCXIXwxYkarYQvVK/E98OrGXbibnHiQ5Efr60xNoW+6w9tZPb/R5v12Z6/gYE0XqPG83m2aqJYMdZMrrC+tLxRhySVEoU3hBJfNW/1W7TNWmmPAjrSKznZC++Xs3bo1DLT7LrlMQsLMbnkOBKUiih9WZupVsJR0hfw5KWQhEPmT3O7h+VDmbYhKnxiMFQaChqJE+w1xBso7TJi5xM9y1azrTJBLDeuDSrt+FNXMCnEaPRR487A2qqCy6V3IlBvVmk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcvKpN/g57fH94z/Rp+9PzKxcoZZ7cDdB4t9zLiNcjI=;
 b=P2ONT2Iki9hOVEJFm4YvQlq+JKU6V3gbmdKA03LTnpxXxrHswpKFFSZpiehnr42MwV38BMTOYSHN/r988BU/Au3psiFp6Y6tFnM15Pzs6npTC1GpBVeuqxf44jlYA6xaCSZOqHpubgqa6GQVJ/ys/J/8siJlxrQ31UjwFeZWc+spko5BF/AeLKH2NeWAQFd8K54aInTagE+qn8Dgn9FYY/b1Qr1ZIdEswBLGNz4hEMObrkbcPPM7DOnBVT+g4mw7vqwkMMD+Bg9OPwYiI92hk4cYRyviMSCrHxns4aHNf5O5v8YosiUXxn0QwYPHGUmYEeQRcGGXZKHQ99DYdV1zOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcvKpN/g57fH94z/Rp+9PzKxcoZZ7cDdB4t9zLiNcjI=;
 b=fqYOBG4xxkFS91j8z01hCIXMDiUZOtz2h+SagFTvq/5Y3Ph1NyTgpYw9tTO0Z+xzat3cUYr9xIwwwinJ8PTkTZ06xeKAFjF5tnYmpOnnL+xLPEaY6LqoH7Jw5Y+bz5Ng11IxCiQPbsHWoZ+3X45FJUwC/PPTpTuh0VcNIGT5fH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3952.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::10) by DBAPR04MB7237.eurprd04.prod.outlook.com
 (2603:10a6:10:1a4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 11:43:40 +0000
Received: from VI1PR0402MB3952.eurprd04.prod.outlook.com
 ([fe80::b837:b0d8:1b75:9a5e]) by VI1PR0402MB3952.eurprd04.prod.outlook.com
 ([fe80::b837:b0d8:1b75:9a5e%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 11:43:40 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v2 2/3] - Code Implementation related Service- AICS
Date: Fri,  8 Dec 2023 13:42:57 +0200
Message-Id: <20231208114258.133709-3-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208114258.133709-1-mahesh.talewad@nxp.com>
References: <20231208114258.133709-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::20) To VI1PR0402MB3952.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::10)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3952:EE_|DBAPR04MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d48c69d-aa24-48df-9060-08dbf7e2ec0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FBqMD2lSEIloo/ba6Qa/3ioCUvzfVt60G8z6bTtTk2rFUZChOedn19xATnaHwhR9Q67XkkWNE/W6ZBE5VD3paaOY6jk3pMpFb8WJe2HLSJuzl0wF8EvblpaiFvoC7U8+tEFJL8LpgndNxaCRjDRSEADI6apadmvxIqy8+9ss+lJHimZafy1rorH+bRB+XxajQYXm/UJxT00ucJWXdUyeOcad7Og7Bkzn4SBH2ioURfpFPktkNnwbnqhStoTBtVm36RE+PMBwba0O8NEZlIIlCaQ6XuCkkCLjTxq/kytzQBjqdLquO4ETZJAgxwd3KN8M2cQPiePOXzr1buSh/xBa9ZZpJLxVuNHXXwKWxIdCZcgFm/+dyZNsZDnnyHD4x4bGk2piaRIUD7LySAmGUsvBS0Jvu74Ffzc1u3I7h7MjF8VbwODPmgm11BvFUy/4EVS602Y6nzLlnLEwygQLfmLdyBldhYKghTHyq2Hg3SsMaMWZJgo2B5ZV84mp654Kuj8XZ6oJ/5JCdw0Rvw5EHrU+UdaMq5MUy/Y//W0LtaK9SseLf/fxN0c677F4P0rCLFVfeLqriI1p+YOM1zbOCQqx0PSxzCQKGV6BCTmFnmw063/2LwK+3REyN2TK6ZCe9WbA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3952.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(8936002)(4326008)(44832011)(6666004)(6486002)(478600001)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(38350700005)(5660300002)(30864003)(36756003)(2906002)(1076003)(26005)(2616005)(83380400001)(38100700002)(86362001)(52116002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8i4YkKZeq83cCgVUGCAddg3GsSl76+x36OMU8f7xEnu+c+CAm1ZfdiHfgFKC?=
 =?us-ascii?Q?UMZtAXHstwHNFri+vKqfp1tT/i1ZFQZ/scxsSTHYkWv+2AJLDKkxCoA2q3ZJ?=
 =?us-ascii?Q?ORyHVEtWxqFNlzhCphGV0zCW1o/9PnZm5WtTnRxOtYj3TcOBGoV1+rA0IZrv?=
 =?us-ascii?Q?egmq+YC5HHuevYOxWs/T7KebyX3ZAiTKNrvWSEosuErv0AfKEm/e7dE7lx/F?=
 =?us-ascii?Q?2BV0Sd1Z2fjDj4Q72HWPBmu1Q8Eb8aOP9Ig1OzwUNQnglkkKuxcHUE3/4Krc?=
 =?us-ascii?Q?FKVRi9EWbzUZC0nS5VB20bNgsCdTNxsIYDhcaayi/li5GxmxMsKiYJhfJOQO?=
 =?us-ascii?Q?rKtOrBs2TKO1DHqJxfmTFwX80LldZTTkOOenLOpz9uMczUrgjYnKMyQImO/Y?=
 =?us-ascii?Q?5eTGlwPOv9jd8DnVdSBjAj8el0txbgINATUTxnEGvZuAZYjPX5sK3Vjr5HFO?=
 =?us-ascii?Q?opxNaxTvnvav4mq0p2OR1Fxj5q+8VMKX2EuuY2m248ncA0HsmSWPhQnOqsdf?=
 =?us-ascii?Q?7xkcjlldf+9H5QiqBvpTjzkwQSiS0ULeGucYfNJoFKNnEA4oP95xoVFyv8if?=
 =?us-ascii?Q?ItpS9IxLUlCMtINhXAabIOmzHzm6zzbV68Arxj6vYJ+0ubbcozWVdqP1v/mL?=
 =?us-ascii?Q?FAqpUEhNvIEvnk1uS0v5H2D25CXEjty2ZsNRUgba0tHN8laV9raXfQaRnBFu?=
 =?us-ascii?Q?cK9DJ0A5GxKt2XisHFtuH5gg8QtK/DM6sQqUu2KsS9snG2VLqFdlN5q50uad?=
 =?us-ascii?Q?+xa/6orfFZhZf5cFFPSHEmdccBn6rTYZCvcy/AZXXgcJR2FjcC9e5PocP0H5?=
 =?us-ascii?Q?x9TAx95CHtjNu6AsQGYjM+OF5ztHYBMf97K/VM5eGu4hbhkDJuAb7rq22Bbq?=
 =?us-ascii?Q?XWemVyQd5OLpQerE/khgoDdlifWbMqXqHtey/f1nbUEQJbrebv8XOYG0LW29?=
 =?us-ascii?Q?Fve5rk04gEhx3zWUNk/yraU9MrVOjR4Bb2YNE1TOVgT6IKJIWs5beXV3frNL?=
 =?us-ascii?Q?yH/n/mn8qgbyuQAXmMtEbI1qQG5TGvcg94wBRocIWZwj6Wf8HUazl7gg8LFx?=
 =?us-ascii?Q?riXBzZSPq1ejitcpkmayFH/uzOGb45MXczIszufDhZ0b5yCOM3PF8MxRrtrK?=
 =?us-ascii?Q?31hspinFpD1kcvy/g4HUdXpuALe0spOxq6anvpE2nBAUZX/Z8FP3jKWAgb00?=
 =?us-ascii?Q?KShpDGqaYh72ycqWXWfZU9Lb10FxpjBPFlcua0LoAgvPLP0QZUcyh8Qi1pqV?=
 =?us-ascii?Q?XcdwGBjtRRXAFB/Z+q4G+3fOzCB6iU1/K11Lyo/+He3c+94Ik3md7+te0rCG?=
 =?us-ascii?Q?toOoq2qPYqgRtARl6tzvdwDO6a7+aZwvEuS9EnO9/TXuwks7twxO276wnIDX?=
 =?us-ascii?Q?4aAS8DOcj/eWUix7ke6WV1xSBUHI2rhpco50j5R6eruD14FUHqh8I97yT4jz?=
 =?us-ascii?Q?MIcPunUzX/WE1++icfqk6Xcn7wUDEQfpbpDUEKmMaKFrj/Nz7V0njrYVEU/U?=
 =?us-ascii?Q?1ngvtqiE8/RBDdw0i+QHqbhku2K169yhRywQXr0bp5xWqDry0Riwy4Ef22BV?=
 =?us-ascii?Q?ggXL0mq8RuYefqueANWwNaSWTTDqnlWJLyCxwvSuFPmzGwUCnketkDK95IxK?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d48c69d-aa24-48df-9060-08dbf7e2ec0a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3952.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 11:43:40.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/Q3Q1vhYfEJqVw2LrrsCa9h1AHJJQAVSeN0zLqmP+o1NFp5Px/A6EfD6+dXai1rhk/Jbdb/7FrLrdFm4PHa5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237

- Specification referred for implementation:
	AICS_v1.0.pdf
- Verification: Tested all Mandatory PTS testcases and all
	mandatory testcases passed.
---
 src/shared/vcp.c | 1011 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 1010 insertions(+), 1 deletion(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 5d163266b..05dd74047 100644
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
 
+#define VCS_TOTAL_NUM_HANDLES	11
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
+#define AICS_GAIN_SETTING_UNITS	1
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
 
@@ -982,6 +1083,488 @@ static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
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
+		DBG(vcp, "error: VDB not available");
+		ret = 0;
+		goto respond;
+
+	}
+
+	audipst = vdb_get_audipst(vdb);
+	if (!audipst) {
+		DBG(vcp, "error: Audio Input State value is not available");
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
+		DBG(vcp, "error!! gain mode is Automatic only or Manual only");
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
+		"error!! Gain mode field value not Automatic");
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
+		DBG(vcp, "error!! gain mode is Automatic only or Manual only");
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
+		DBG(vcp, "error!! Gain mode field value is not Manual");
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
+	/* TODO : AICS optional feature */
+}
+
 static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 {
 	struct bt_vcs *vcs;
@@ -1000,9 +1583,12 @@ static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 
 	/* Populate DB with VCS attributes */
 	bt_uuid16_create(&uuid, VCS_UUID);
-	vcs->service = gatt_db_add_service(db, &uuid, true, 10);
+	vcs->service = gatt_db_add_service(db, &uuid, true,
+						VCS_TOTAL_NUM_HANDLES);
 	gatt_db_service_add_included(vcs->service, vdb->vocs->service);
 	gatt_db_service_set_active(vdb->vocs->service, true);
+	gatt_db_service_add_included(vcs->service, vdb->aics->service);
+	gatt_db_service_set_active(vdb->aics->service, true);
 
 	bt_uuid16_create(&uuid, VOL_STATE_CHRC_UUID);
 	vcs->vs = gatt_db_service_add_characteristic(vcs->service,
@@ -1111,6 +1697,108 @@ static struct bt_vocs *vocs_new(struct gatt_db *db)
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
@@ -1126,6 +1814,10 @@ static struct bt_vcp_db *vcp_db_new(struct gatt_db *db)
 
 	vdb->vocs = vocs_new(db);
 	vdb->vocs->vdb = vdb;
+
+	vdb->aics = aics_new(db);
+	vdb->aics->vdb = vdb;
+
 	vdb->vcs = vcs_new(db, vdb);
 	vdb->vcs->vdb = vdb;
 
@@ -1685,6 +2377,307 @@ static void foreach_vocs_char(struct gatt_db_attribute *attr, void *user_data)
 
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
+		DBG(vcp, "Unable to get Gain Setting Properties Char");
+		return;
+	}
+
+	if (!success) {
+		DBG(vcp,
+		"Unable to read Gain Setting Properties Char: 0x%02x",
+		att_ecode);
+		return;
+	}
+
+	aics_gain_setting_prop = iov_pull_mem(&iov,
+				sizeof(*aics_gain_setting_prop));
+	if (!aics_gain_setting_prop) {
+		DBG(vcp, "Unable to get Gain Setting Properties Char");
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
+		"Unable to read Audio Input Type Char: error 0x%02x",
+		att_ecode);
+		return;
+	}
+
+	memcpy(&ip_type, value, length);
+
+	DBG(vcp, "Audio Input Type : %x", ip_type);
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
+		"Unable to read Audio Input Status Char: 0x%02x", att_ecode);
+		return;
+	}
+
+	memcpy(&ip_status, value, length);
+
+	DBG(vcp, "Audio Input Status : %x", ip_status);
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
+		DBG(vcp, "Unable to get Audio Input Description");
+		return;
+	}
+
+	if (!success) {
+		DBG(vcp,
+			"Unable to read Audio Input Description Char: error 0x%02x",
+			att_ecode);
+		return;
+	}
+
+	ip_descrptn = malloc(length+1);
+	memset(ip_descrptn, 0, length+1);
+	memcpy(ip_descrptn, value, length);
+
+	if (!ip_descrptn) {
+		DBG(vcp, "Unable to get Audio Input Description");
+		return;
+	}
+
+	DBG(vcp, "Audio Input Description: %s", ip_descrptn);
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
+			"AICS Audio Input State Char found: handle 0x%04x",
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
+			"AICS Gain Setting Properties Char found: handle 0x%04x",
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
+			"AICS Audio Input Status Char found: handle 0x%04x",
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
+			"AICS Audio Input Description Char found: handle 0x%04x",
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
@@ -1711,6 +2704,19 @@ static void foreach_vocs_service(struct gatt_db_attribute *attr,
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
@@ -1736,6 +2742,9 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
 	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vocs_service, vcp);
 
+	bt_uuid16_create(&uuid, AUDIO_INPUT_CS_UUID);
+	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_aics_service, vcp);
+
 	return true;
 }
 
-- 
2.34.1

