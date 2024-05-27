Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B532E636
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796492; cv=fail; b=Ez1oQPmbi+SgkSBnq1FH7HHHRClTazmZ71J6AanxJMQY7mVTAEKaeNuEz6cA/4rlSO5FGOGtjawCnmcy3NzXuQkLIRU+xi5TPB+b+Xk7roH0eqvUpsbNmZw3aKxqqGEbFBbk7VX97CklNjz5+7ow9iqyumaepEoa/hsUe2rgnmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796492; c=relaxed/simple;
	bh=bQGL1IuzXVETFZzzD4yA3LQn/UuvZIG0oy2oJQj6Vgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rsvcnhuKRH6Jv+LOaTaopCTHuZzO+kULNWSgOc+lmD9kGKZDlnFeOZ1CroLmAzsmgMWfsI6PBMGpSdADq2eBxm3Xym2RUQ5WYV2ianmyt6LAV1MWizEbHoWp9GVsB7lj0WW3KRBxpupBZDWUqVkQscyS5GsWjiL8kT5rXZgf7QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pZgp7r7B; arc=fail smtp.client-ip=40.107.6.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pZgp7r7B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MahlKdVBM9mCaKBGGGepmag7n9QrWk6NYthzUmmPUmE5QmffhFwZ3k857cU/LVteMREV2vApC2E6keKnUQxTQqbBianwAi3ClvVUwY5RVfBSfEjdpjdr7mD4uC8t6z9m1+/BIcFsiJDgIDBDdPqBQZUozUsrMTVc7hZIsnx6GulnsYDKQOySuBdjICEUcYKGp9tqwMdlHKO60FDZe/4jalifrau2XUeHhv33MK5jVKNz7/yo8yLhC+pCmK/WwsPHEqATm+t7bDlGzAORdncJTDRNF7pOAJChVIy1YTmciJyT3fRcRHZmJZHQoQeOhMmqgbPZsoNu987ActAyT3MnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HZhsr81iO98KszrjrO7ZP85AEn4ILHxE4LzGv01g5w=;
 b=S/lm0Bv2kt1jAOQfXk9vRPj6EIYIBokesIz23S1/0kIFIa8zALr27AwIi0s5LV1LoVw+gKi4P8yWuH1VqB1dedKhltCntZ443+E+aW1rDmbhFFGMgba3c+hr6r7IPJMxmM2hb6Z87ygfT0m/3o8+akNyEKKDMRWdorRYgySeGKGc8MnKByH6E0+XHhb0IJonz3MkJFxF+n7Sq1IQIy3G9kW6sKwrNZmYdOPP0qqFZvK2EFNTPUKSPNI6j+elD1RKDMZrLndA1kJ4GCby1SEF4BUhuD6z/069P98zHJK2rh377WqF4cMTb+Czu+7lq3a1hgxxOVn9OLjU7I33A0ZB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HZhsr81iO98KszrjrO7ZP85AEn4ILHxE4LzGv01g5w=;
 b=pZgp7r7BOZqTn/Gvs/Nwfg17YVgVkFdOI4f3JA+4hGHZsoEgaOz9IOZOAyEDLXjAnthB44Xz+I3f0wLiKrJsalgRoWFeStQQV6knL3gTq8xR+lsDRAP1FeR7/53tng1UuWI7ob3ruscrmLYCsRkNsODINlwLmTIIfHaapbYvj0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Mon, 27 May
 2024 07:54:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:54:48 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/6] test-bap: Add Broadcast Source Disable test
Date: Mon, 27 May 2024 10:54:21 +0300
Message-Id: <20240527075422.18953-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
References: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7ce2ba-3e64-4eb6-9ee3-08dc7e224804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FGxckqeTYOlC1U6iexko04pBheriG4zrMbW/MBJ8VicCQiWhJkx12e/y/rO3?=
 =?us-ascii?Q?+nQHcIRdo5d/319jfvAfGzHR140G1EzkYmu9Nv1v+xEI/SdI5HTyXv8dgTW7?=
 =?us-ascii?Q?RVaRMkUaPkNX9gxz5OYZRa7LrOXHgHq9pLP1PXuJsAfC0BJG2XWcHZlbJX4z?=
 =?us-ascii?Q?ww6xRYfFF6e/35GMlBR3IJT2sYYBRsSH+Rft/RRUmb/AwbXEy5wXe5vE9dXj?=
 =?us-ascii?Q?SzqmykB4SgQMtflcBTGCRn+k/u/PZBzfrGejij8it5i5VisGSRWsxxGPbpAJ?=
 =?us-ascii?Q?wdjaRvHU3txXwtRLsDjMykC+T4FvLFEKByxvbXbtPXhCqS3Fw7H5vZzFlhU9?=
 =?us-ascii?Q?GXvAZI5sOHS3BTGmAOOxhdZ0twG6kZgZ+wYdvDNmEZAerFgHjw4zyjM/MbcI?=
 =?us-ascii?Q?qyYhzZ+TRuUUCAXNeGqaja5cS6q9yrGviVrj726b91bBR5xb46FNMQhdLHke?=
 =?us-ascii?Q?Qxz2mqdvx5FKwb64cm3rmEfoX6Exfsl8nLuwOmOoXR6rmScsyfKDkCYQ4nUB?=
 =?us-ascii?Q?RrMMYD3K5RBCrygV1NALAYRhY1mhTUTjvsR6Qd5CAxvVhhe3Kihku+eHKyh5?=
 =?us-ascii?Q?bErX+be2WSRXzbzqdGwMbtR7U4i0HvzHX1Zv1kPsAKkWx+/bgJJ3PRcBTIas?=
 =?us-ascii?Q?lZTUjyC2p9euEdsbVdicaONtKX64yFxZftVBO9Q7pmYwSi3nM6jGkiPb78Ke?=
 =?us-ascii?Q?rcKJiFLP9v7hdkYHDpVe3hjOZZojEe57mt13b8CT0DebnLRSP1mY7QKCEJyq?=
 =?us-ascii?Q?lLp/ULWtwuHXXX8HSqyOqG4nnC+034utxHW9gDb/xefiTRID3SQRhxldk8+M?=
 =?us-ascii?Q?8R3/WxKP+lc1JTKrLsiApwiya1iFhIrWIXFtGmvzK5m3Y2axDVbOLNT9sRvK?=
 =?us-ascii?Q?YaBFrNIefzYVDXrPTFqM+JSSpjtA4HLQEUXnN4j7fFegam8/L5AOH4QSXBNt?=
 =?us-ascii?Q?mIYovgW0xNof3kUeDsN8UMLFlRi1Jdq7sB8DGy3ZJCfI0N5GwHJK0kZ74r4S?=
 =?us-ascii?Q?6nIhTzoESfctKtOZexvuWAg7lKSSspBtAG+CVX/gFsrSKWJqlbbxKyXCTjhx?=
 =?us-ascii?Q?McGy+h9uMoG62ZqLvtGw3A3i2/i3DB8VfNIg17Rad6+c998dYKfli7if1p5n?=
 =?us-ascii?Q?1uv//6qMtoSGrXHkZvEov09iAONzB1x3R+Td/xSMFHpHSPgmnDtJpps8rMoH?=
 =?us-ascii?Q?neU7dHF97ock1Xp80iZJgO1xGJ6xP+lYttnqNorpBaINRLcQzH5WsS3vGTXm?=
 =?us-ascii?Q?cKZ2aJ3eZrRoGISrCJIEU//h+icFVybiZBYVYpm0Lg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvVc7IeGICpKL6bERCpj+2YmHb9PP+iAFhsOT81FlLLebwpSUyRD1cTePkZ4?=
 =?us-ascii?Q?4t3utN4FL7UnT+phacGwW3aDaZhC/Nq/hQNWiYC1NiGuK9XCgaZG7Cq8kteU?=
 =?us-ascii?Q?xJRyGjFxWGUHPuz26gwJXZrHR2k6gApouovKW8TEr767FRTg43a0s30PF8Pa?=
 =?us-ascii?Q?lQf6THTX/cNte0o2lM00Yj7zS6GyqpGzRHmob9x5+9gAimt0rGaLcX+K1eGt?=
 =?us-ascii?Q?eCtu/r3KDFw8qZg56FdOGV0U3uy3i2oVgXLOk9s71Dtam8qDWxbB+JwCcAE2?=
 =?us-ascii?Q?9YGXflBW6/GlVsYFDTedDZ6NzTXXIAdrQO9ESvBj9lOAeAuL7qLdmE//YL/o?=
 =?us-ascii?Q?pbAek4fGaqDdc/9+ZGBxwUeLE9+Y4WSsJur9vde4Z13XOeaq7OuewpRv7iLQ?=
 =?us-ascii?Q?2mxF++9QUh08jOxRtcjSiK7KIGTrqEdyFPi0HPNhnN3ioPdD3nnuspE7TiSr?=
 =?us-ascii?Q?odax2OCpI2LXkrSJmXKTbjtzo8O1EQsYiJUm3MeYQC39PPQ2DkENAUzisjch?=
 =?us-ascii?Q?/LA7U2l1900bZXaVoLqPAYRKLkJVOYTTnvFFtfoCu9nsXwK8zb24Eq3HxY0B?=
 =?us-ascii?Q?c6HzkviOAag/ReEXSdKM4d+BdKDxYqOZsghOmoUsFVyJ68Hr795kcPx8U2Q/?=
 =?us-ascii?Q?Az5xux26X2FNZKMqKLJYXGgpGjKMk4fURTUKJ0FzVk3501fI5OianDztYkGS?=
 =?us-ascii?Q?+dalyIhmTZhUx9T5XsedilP4n7KKccccGwu1XxR4Xc2xX5MPt2EudBKvIoqo?=
 =?us-ascii?Q?4OMFiRbCQNJA0wq3u598a3LoaztLEl+YIm+g3yHiuvzHL246/OgBvwMN48mM?=
 =?us-ascii?Q?maKoHqTlPU/f3aHGCH+nXMsbI3HsL1A1dslUWgOLybJJtnV0nLsJhTCecKYu?=
 =?us-ascii?Q?5ZSLEuFpxb2uZPMV4IT/hu1Q2xQ+OXDq+8FZya4WZ9s5HlXsXLPVGLoFLGLZ?=
 =?us-ascii?Q?8KhBPXr2ar8l+nPuKsBQ6kA+cZQgAPNCYeNBgAN5E9p1FMPuvXb8PQsVh9gu?=
 =?us-ascii?Q?Eae2GlcPweRdrxybgyBW3xoT6JG/LHeEPA73Vyg+3e3PDWC6whZor94zn58Z?=
 =?us-ascii?Q?zl4cnYJyXQizv2veJUwhDkDzpG9D2GbqMnrzxaN4dtVpKZUjD+mZavlXgipg?=
 =?us-ascii?Q?PyheKd1z/eYQ9SrSfr3Hrm5swlU1ygcag52c/QenlOo5a0P8aup2GimSXmbK?=
 =?us-ascii?Q?+OsBNZLXBGACqNGQliumWQXvW56Gi2pQW1EMiy8XzpsZs+9QideXzDG++YzZ?=
 =?us-ascii?Q?KaSDziiRQoiVuAyQFiQ24pPCvvQwdMJbPPMJGVz0yWKupWNGbyMVmSJz99mt?=
 =?us-ascii?Q?fcqTeKD/PwSl+VUG6eMgMp/2W16E7lk/dQ/znPQdeKaZ19TFYXUI6TFqx/Iv?=
 =?us-ascii?Q?ECzKW+EYW0tvrl1V95sMyH/gqUjlZATw+AWA1pQPnn1ZdKuNcK7+8OEQKWRb?=
 =?us-ascii?Q?w9i3cQlwaMCRFSLfYR3ut1D7OIdSlD5bqe5ZXf/cWGQbrOoM14lkwBq79jhR?=
 =?us-ascii?Q?yDYxtzzO2zovLQVmiqlpzar2d6FUspDJHw//mweAJCJhWcF2QAPDeOiXcnZ6?=
 =?us-ascii?Q?uOrIDqpaH3bawjd7AHbM/ZDt0d4qRRpUaJDrM86RIGM5l9svwxC7g04r0Jbt?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7ce2ba-3e64-4eb6-9ee3-08dc7e224804
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:54:48.2803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Scunvim2u/Ipe0Pv+ZPCimXkWOTHtZ/Q+NCyH3J6YXMoHfD2/VPD5CKpbtvWHFQiIVWuEMhZyB6coJcUaMO1Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

BAP/BSRC/SCC/BV-36-C [Disables Broadcast] (page 176):

    Test Purpose:
    Verify that a Broadcast Source IUT can disable a broadcast
    Audio Stream.

    Pass verdict:
    The IUT sends a BIG_TERMINATE_IND PDU.

Test Summary
------------
BAP/BSRC/SCC/BV-36-C [Disables Broadcast]            Passed
---
 unit/test-bap.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 59e056e05..3fc3b5f02 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6169,10 +6169,53 @@ static void test_bsrc_scc_estab(void)
 		NULL, test_bcast, &cfg_bsrc_8_1_1_estab, IOV_NULL);
 }
 
+static void bsrc_state_disable(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (old_state == BT_BAP_STREAM_STATE_IDLE)
+			bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+		else if (old_state == BT_BAP_STREAM_STATE_STREAMING)
+			tester_test_passed();
+		else
+			/* Other transitions to CONFIG state are invalid. */
+			tester_test_failed();
+		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		bt_bap_stream_start(stream, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		bt_bap_stream_disable(stream, true, NULL, NULL);
+		break;
+	}
+}
+
+static struct test_config cfg_bsrc_8_1_1_disable = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = LC3_QOS_8_1_1_B,
+	.src = true,
+	.state_func = bsrc_state_disable,
+};
+
+/* Test Purpose:
+ * Verify that a Broadcast Source IUT can disable a broadcast
+ * Audio Stream.
+ *
+ * Pass verdict:
+ * The IUT sends a BIG_TERMINATE_IND PDU in step 1.
+ */
+static void test_bsrc_scc_disable(void)
+{
+	define_test("BAP/BSRC/SCC/BV-36-C [Disables Broadcast]",
+		NULL, test_bcast, &cfg_bsrc_8_1_1_disable, IOV_NULL);
+}
+
 static void test_bsrc_scc(void)
 {
 	test_bsrc_scc_config();
 	test_bsrc_scc_estab();
+	test_bsrc_scc_disable();
 }
 
 static struct test_config cfg_bsnk_8_1 = {
-- 
2.39.2

