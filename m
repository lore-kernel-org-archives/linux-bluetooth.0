Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25DF1B2526
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252190; cv=fail; b=ehrW6H2BaOR9k8SZS7YibJQ/rwh8R6Qpbvu2qX+CSlx6oJ40DsVDhN1Zok9q873rOKHurNBrVloxAXSxSo3Lf9liP3ckZBs8sNvS1JKbEcDvUbOJ8q+fsVjM9kK5Ek7Zle5G/zGw5l//x97swa9+OYvAuHTyFSgz3DjH8KcUzgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252190; c=relaxed/simple;
	bh=nsix/iydcx6bPKQBiccwOlfLprFxWvXlo1C93K+Ti58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJC09M+gesa8iSxwOVowxdMmM9Qja1nPv0+I7JIbtFc5XHIMTbb+jgWYSI7GV8YzI3IoR0aB2aAAQ9fEFx1ya+50K77CWWUekaFJQ+KG4g/fhl+BwaFTymbSa9JW0rf8BT9F/vWnLzhMcrapg3BEiqd+wAovOMMkQOuLkqtUeiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QOODsb3d; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QOODsb3d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et7maD7VKzByeVRV4vJKBojXZzj68rAOlnAJRhsZqF0heO6CCgrG8SQX0DxoHtCcrKeHtloNk1pWoBqMTzKwuPtopk+aBbCe31/2NB1E0bCVH56iKl2yiVt/cZP34G/izXDF22lMnI6osjbe4/EUJSOdCIL6iB9DXdpV8bzewI5lVsmUPLxwaYRZ0NSgiObaCiaCotg+GFj5hQ9cIhkh7zJjFe6Jr/YB7ybA2NPVgzq+Bgo+sXHh6/8Xz4NfekZaoYeH1dLkKFxHIcrEh747CNu8CIn5bIS6qzir8UFleMd/Ggc+LyYy8WvoIKt+Lj4uvzK7RT0bJ5C68YrbJ+DpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOk76gSQzcEmV+4aDAZNH8bBzjFePn52Js8YUXJNBfA=;
 b=zAoq8R1NXg/hXEa4HuqFF1AEA6d79pUtvWNoJl2EQ91a4bCBe5/7if1tmPpDUO08wEzN7u6tlT6sU8XVE8aj1oUdgW7A1yyjm1jxnHP1xkxoF+PpUFO4ExRwGJuUJFYmUtuZh8fSs5FOM+2w9dsiFC8zh3jVJ7b0s+02Cg3TqDtgTYJD99WU62VlI2Mn29NfroyMyPTWz4cLcGrJzcDtZQnPM+K+WAty7wIA6WENylAkwlGToQXgDuhQR6fOSTWKAGOXU2tbY8MF94++WUv1kYa4cTP5sNCDJOsPpZrhLioyqma95hCMXlf+D0dGUxvMNDDAIBi3kHsYleMH+cf8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOk76gSQzcEmV+4aDAZNH8bBzjFePn52Js8YUXJNBfA=;
 b=QOODsb3dLIcsdq0cZfd+coFJqXS7MuLkR+YbeqMtkPB/ti5MJX7DWoXolurh9RL8Zyma7krDEcTeXZhUKKyEe5UeF76/rdFsX898r/YIATYrmO4W9XPaIjsNzRMKaeN2jHVnE2Py3XBcCaEEbj+aWULdmFjh7qszZGulDvAaKKdgPvkUgG68Mq9VHcq9HM6Pydx9AF84Ha36fX9YnvWlYQsXJ4iDL4+FZWvvbQ0xxrn4pCrkJwxB/kTbUC5S8AUFuDn+IkbzOSxqGWAKqv/s2qsRTJlGKogoxMzHNUKMUqDDWJBXtaIgCk3q3g6NMOrCst6McoQQUR8COhmlE0tHUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 05/14] shared/bass: Call cp handler for the Add Source op
Date: Wed, 21 Aug 2024 17:55:53 +0300
Message-Id: <20240821145602.92083-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f160f4b-bab3-4ddd-4461-08dcc1f16dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGMT39WFj1o0nd4PHfYH34D9cYYkdidf4mHhEscOIPZijKcMOd9FpSmwxRIl?=
 =?us-ascii?Q?spDig89ltJPzd/nhozQ7/3UL9vH+83zHvDBGF0top2VGjMoTTFDwB1luyik6?=
 =?us-ascii?Q?5f0gfp+/0It/Qxxk0SyCvhmrEEA3e2q83Ixulu7wa7VT7mc0+4+roLrgz1dy?=
 =?us-ascii?Q?AwAHTMOgOa+AeSasWCxSUaL7GFxcMCv2bPAXnInF2qpRHwW0zsXZa+/RWG/0?=
 =?us-ascii?Q?sru7/jCYPtIAZP8ZvCQYEYKOl1sBgB9Dvl3l/qGo0lZ6LW4wPFuBMEdkWdd8?=
 =?us-ascii?Q?t/uQwNV4ayLin1tAZVf664Q0yjYKjQ+jwkAvS8uR4+Dt+JGbbUuq438nbUBK?=
 =?us-ascii?Q?1uQ4v8kVzwiWvAaJ7RZKjK8rVFbl0TlQ/7dsF0Vk130j2hu2a6bOM681/0jv?=
 =?us-ascii?Q?oZDSU4ov0d1/etorhTFnXi+rYnbng+L2Mm5YJMQFKs+ig11M28x9pSMIkv4N?=
 =?us-ascii?Q?xgLLvIS9ruHLmZ5ByWAxo9ZO/akjXewmeSlyyq3Rj803iY85VTTZ1ciBuEfk?=
 =?us-ascii?Q?mXXU7MGjNLU35gA30UViXJlNCRY9YseSdte9t4QB2pSR9MK8b7rDFoyKkRtA?=
 =?us-ascii?Q?jJqGypxGJTncLv3ZwghEH//rHmnYlz0nENP0fXY26d5hJH1ecljhfNXDqKDG?=
 =?us-ascii?Q?Y+9gP+Fb1y1ituE2e3i9jGx0Btc6nmhudhGiBbiggiUyBpb+67iXhQpyE3/v?=
 =?us-ascii?Q?uUwomwvqtHW64xkzrD5ywt1BpKaTWAeH0m+87FzpyzZVRYUina07XDlRUI27?=
 =?us-ascii?Q?oKcujo7niqyPkILbB4N4btkCEjyWv0/f/4ghTh4IHxAPY6I/Y7UCzfdWW59w?=
 =?us-ascii?Q?FDF55AFohAIG0peykIx4+HHx82oou9j1QMmcCXNYyjJBZSfzhs/oS7riL1sY?=
 =?us-ascii?Q?wcYySXmF8l+YIuQA/pPwnTMycBlsIoh4F/x20t0PkLG8PWtbNZAuo6ci3UdS?=
 =?us-ascii?Q?r5Z3pHkaquMS6q+aM7HOQ2E8UfoGXcaLWi2G/Ask6ELUZzpJsZEzX5YRYAVD?=
 =?us-ascii?Q?ir8KKKT26kPS/XAosX1e5Ct6rAf+mAmUknWYxYQMxvdGn33ViObSyu/SqL/7?=
 =?us-ascii?Q?5GBUDSZNmX6aY2Ojlx0NfbEnqvslXdlFsIusBkxB091eYF3b7qH7t3AMbqkG?=
 =?us-ascii?Q?Wx1kET6rI8h6MlDNbWaext9oFdg8FKCLwDwhYN8DoYTfz8gfyw+Mu6stjSPL?=
 =?us-ascii?Q?CTyNsU36TYC1ICk583qD7VYQzBlxWh9iwsZzBSzmFxmUxJuaeRT74hRuMkTe?=
 =?us-ascii?Q?+0IP9oyu7TmROsyNtkc6m0O/spsMWdRIYqpcCkEBq0BgPlPeW88CoXj9DFlg?=
 =?us-ascii?Q?KxMBwgWFcjVw/6nc52EuMt4ESWc30x/wRrcOi6zl6SM3qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWmXDwnuRN64t6gTKg618/GqI2vYzQzOeUEzvRseYXy0M0XLZg/mRGHFjFP0?=
 =?us-ascii?Q?zNurpPCeLZ4u9dc939+0KbwQQ4ACc0YdH5lggDX3PdeM2g9qG71AsDgXg0Na?=
 =?us-ascii?Q?zimcdzVP561jmrtd2c8FNEgwh8nunpaFcrVZou1DarrTU2qDAcXp7WAmw3BZ?=
 =?us-ascii?Q?pb0mJw/V2LkSsFvI2Ii5qZCnfVoEjl0F/D+BymF7MgwbyRb59nkCVcopX3Er?=
 =?us-ascii?Q?3fIr1AbDD2k07VB2o7u5cVTouGupMLbM+66oJp2Xy9b+Dy3h3ldQDdEkCT0a?=
 =?us-ascii?Q?AW5hNIfWAxZz/PxF5riO5I3FHN+oFMpU1xNEHWTii7XOu0XMArvBrKRy9TYt?=
 =?us-ascii?Q?BXLJJAPn4AQtbGQ18b7/7YIp1uWWoCBHSxRs+/DYYZXZpgJGVe2mNbiS+Nvn?=
 =?us-ascii?Q?DNQXDe81nAl+l9Bje9S6N61Uii4JFigK+bC8MhgJK4BKATtO8jQaeMgyB173?=
 =?us-ascii?Q?IN1CeNETzTFYdXsp51FpOW1nNMI8SxYH7WJRsAyJ+N+WXZiKyFdWDdRqY3jH?=
 =?us-ascii?Q?TwKuxJ4AfY/8+WedEL424TxtU5J0Dr2Kovtdj+gaGvqnlXrXf9FUKAOwd2yM?=
 =?us-ascii?Q?oTEjHUEVUgwmZEHZLRwQ9AgNwkXbLIdgi9q0lfn8zek48w7qUA8PxcznCB2u?=
 =?us-ascii?Q?imB8iRp2g2Pss9bWcW4iO7ExWbfpm/i1SP2CmHIsFJgsagtxC7cWNXn670Fk?=
 =?us-ascii?Q?y3//EWcexJbR+7DeR9xCmWWkHtKkiSUhW2xJVJ0+ekda1zZt8aok+kU7/h6I?=
 =?us-ascii?Q?WMORqdlpWFFiqQSbG1LrxSO33FyYT2GEFFoBcK+zMXw2cqBVm+rvZPQAGaUY?=
 =?us-ascii?Q?Pqm7CHtEp2IzfDuOH6WV3m8y7jdYJE99JTpqoKFnPDZ1U9qY4oRPDgzkAUzh?=
 =?us-ascii?Q?Ox/xS/hxiJAzcOPW19VLP7DkLNekVHROVP9524zdxrxkSnmXVA5Lq/3MZhwS?=
 =?us-ascii?Q?xyA67O6SgXFGo7+Uq1K0lq2JDFt3AtSjh0lNVnb85BXnTQaveBTjETlF2hfP?=
 =?us-ascii?Q?RYT16mxzKq2LCmtyLeS8SfyiZKt71qBh+DHaqYGUEXKwb7WUOYKTN2a9wSr7?=
 =?us-ascii?Q?ZnXZ/MGY0zjOgQeon7/WtUCJzOlCJ7vdiLZZxl9OpIRVUvBo4EjPisYEWpRN?=
 =?us-ascii?Q?6p0KKLHAC9i/HzAyLfxzHiRmyVB6aDya8pETInirtKATZAZLweowYCxoJjyE?=
 =?us-ascii?Q?h8b+KPg2a4nX5B8YncBYfZQYbU7aTqT/1UqSQIjehG/Rpx1MZOnxT+dB8zIV?=
 =?us-ascii?Q?M6kGRy5bUqzZvwdMnaLUv1hnnRKuz1TwSIVm0wKq9BNTwcEXYAHChLfnqjlK?=
 =?us-ascii?Q?+kZWt4a1Hnqc++EXBi1r9pTD5fW6ZrBO97uwWd5461oWIIFGuNxmpoRlJ8TI?=
 =?us-ascii?Q?7OpP5rzLgAbYJFkVtDU8snfI0TVBtBOblIg3hv/NTpAEwdr2vJB+EYwOn9tV?=
 =?us-ascii?Q?nXg8tv76SPej7OCXj/Lqs0OOZiSgul+Ll3S5oE8R6X/Ajz5frUBdCE8TX/Mh?=
 =?us-ascii?Q?mIK6XzKFnr9w1GxqKCutJ9n8i7AqsNZNzcpoU0qN932g2/TGZa6TOGkbqlt9?=
 =?us-ascii?Q?vNBZ2NbqGJaljwJazfq/+F+3l536oSF8ORVHlcQq33DwsVJK25BtFQJlK0Sc?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f160f4b-bab3-4ddd-4461-08dcc1f16dcb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:25.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+KhIZ0rJXv7NAtXREKIbaNefKhrtolTGScDjYzyTAPUQg5Lgj4ncsQ1WcWgie9WaDaa9WhiP5KZ4IfUy5ao8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

This updates the Add Source control point handler inside shared/bass to
call the handlers queued inside bt_bass, so the required socket operations
will be properly handled by the plugins that registered callbacks.
---
 src/shared/bass.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 635fe1054..70e747700 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -775,6 +775,9 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	struct gatt_db_attribute *attr;
 	uint8_t pa_sync;
 	struct iovec *notif;
+	int ret;
+	const struct queue_entry *entry;
+	struct bt_bass_add_src_params *params;
 
 	gatt_db_attribute_write_result(attrib, id, 0x00);
 
@@ -839,22 +842,25 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
 	bcast_src->id = src_id;
 
+	params = util_iov_pull_mem(iov, sizeof(*params));
+
 	/* Populate broadcast source fields from command parameters */
-	util_iov_pull_u8(iov, &bcast_src->addr_type);
+	bcast_src->addr_type = params->addr_type;
 
-	bacpy(&bcast_src->addr, (bdaddr_t *)util_iov_pull_mem(iov,
-						sizeof(bdaddr_t)));
+	/* Convert to three-value type */
+	if (bcast_src->addr_type)
+		params->addr_type = BDADDR_LE_RANDOM;
+	else
+		params->addr_type = BDADDR_LE_PUBLIC;
 
-	util_iov_pull_u8(iov, &bcast_src->sid);
-	util_iov_pull_le24(iov, &bcast_src->bid);
+	bacpy(&bcast_src->addr, &params->addr);
+	bcast_src->sid = params->sid;
+	memcpy(&bcast_src->bid, params->bid, sizeof(params->bid));
 
-	util_iov_pull_u8(iov, &pa_sync);
+	pa_sync = params->pa_sync;
 	bcast_src->sync_state = BT_BASS_NOT_SYNCHRONIZED_TO_PA;
 
-	/* TODO: Use the pa_interval field for the sync transfer procedure */
-	util_iov_pull_mem(iov, sizeof(uint16_t));
-
-	util_iov_pull_u8(iov, &bcast_src->num_subgroups);
+	bcast_src->num_subgroups = params->num_subgroups;
 
 	if (!bcast_src->num_subgroups)
 		return;
@@ -886,7 +892,18 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	}
 
 	if (pa_sync != PA_SYNC_NO_SYNC) {
-		/* TODO: call BASS plugin callback to establish PA/BIG sync */
+		for (entry = queue_get_entries(bass->cp_handlers); entry;
+							entry = entry->next) {
+			struct bt_bass_cp_handler *cb = entry->data;
+
+			if (cb->handler) {
+				ret = cb->handler(bcast_src,
+						BT_BASS_ADD_SRC,
+						params, cb->data);
+				if (ret)
+					goto err;
+			}
+		}
 	} else {
 		for (int i = 0; i < bcast_src->num_subgroups; i++)
 			bcast_src->subgroup_data[i].bis_sync =
-- 
2.39.2

