Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345B19D066
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139767; cv=fail; b=t7Yed10xNooq2oYmY8+gJB6bbkhBfB6aMF8baBa1u8zeAY/mD/2bf235DC1x53yeUaenPbGD1ywZ0gUhERTWEhy4nPUTulXqrBMPDxHJOa45ActMn3tUAVYNOQJGPKhE4rTOnkcDScfAWEEVnVY1GSytqVoxir4FaYH3DP/+HwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139767; c=relaxed/simple;
	bh=ua6TblhuyBNkZjJRXDYS5Rgw3QcQoCZR93GLPanq/MY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGQKxMlKFtQt3PpAw+0BIjnJfpBdAITWVRzt0UW5QPgRIboE2zRpNCCRlBDZcoQ3MHOSdWX209yjRzVnFZ6lsqX3NXQ9j1rxwrqft2WTJp1QMYia5O2zpHQ6HfDSkcBA1tMPjq6dVQPLUhK8k0zIIYrTlfpO8a0kpnTbT/SBBak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A7WAJY6P; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A7WAJY6P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsRBCEnqbbLf/Mnc0+pWBuhKxMV9KHlqrI+S+vSNqfYeTgrx0Nh1nrAOQGtNzLehMzVLNl2vvREIcoh4gK8MbQyFDWrFkvjAfTqLwXehr1uhj6ZdQ77/uHYh+y+EW1ABcER0VZmadc2nLXhuPlgg+tlKxvRLXxFKfhty0C41QI3cMKthr7/QDoirlexdYVJ/+xbjcqrHQ8yTpLtb5Lxwz9xvlLUdE4DBRWWGrt5k0hAcnqRsi59GLIm7HpbMX2Hh5rcKfpkBJ4o4VoQsoBm/pXemkdi1lVp5+HCiNnWTJ+99orJzKqRCJRQjY3QB9RA/3HF/JoNjxS+kwlQzJPPYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XRJsCas1pQ3rbGAdecb7i7y3ClDA6SyRhcxHysd11s=;
 b=MnFNqXax3NHO0Y6uGhPMlgFjfl7QtCsGTXm0rMEUGVRL8qQUw8LMXTkI+GaZxzn0L4AwThtktGIDKEZBdN8EM2KyluAjjt8+GThkMle+/utsOHdlsdy72owc9qhFCfLOhY61tvZ53E63uIrkHmKq3/XsDj5PqgtFrj1RclfCdSvgxuUfF9KeRF2gvt3FBv0Mq9mF1z2YIVFdomtRdQQIgia2SEbItnijeCCHi16TRVtzRVHd5+qbIftbvemxw8uy224dFKMNkq7EXsi1EV0WKNZ3wvH36ow5rwZy0knRC8eukWMCjBXSAD1utUbk7OEZ0jGDvLRUDK8XhYzvmo05NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XRJsCas1pQ3rbGAdecb7i7y3ClDA6SyRhcxHysd11s=;
 b=A7WAJY6PXHy9nSHlZAZ4tKUw9vGVV9XhBX2SYXHZojx6bSy72MnX/C9giowxbRQ0s7f30zGyNHOaAxBGqX2bJhYcv/GI7tJzJQ1VQqTvXCqgu2GyLKvQ4cMAmEo2wmrKhPxbzvr0fmlhoA+/bg6rBx/Nh/znEjkwAgqKISL/Dkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:43 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 09/10] bap: Notify scanned BISes to BASS
Date: Tue, 16 Jul 2024 17:22:06 +0300
Message-Id: <20240716142207.4298-10-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aec88e0-f893-4f3b-85c2-08dca5a2c16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UELhyru3k2UFC4wrJnlav+hvCHwVK5JDGsiIW1tixrCSnd0WzrdoIiuIOS13?=
 =?us-ascii?Q?5wTOWJ6ikaTj+LGHnDI+YCTkN7y3KovnlOGt3sJp5TYxZQQTPu5lrmyPTkSb?=
 =?us-ascii?Q?Lz+BOfKBNIYy3B4V7i5eBBEgNL2tkHZ5RF3vtYTYCIGGBNL4pRXDlgtc7Wvj?=
 =?us-ascii?Q?lHK4n7J5Ij8BOzNXJV8eI3i1KjM3Hj6XluUJPJXfoz2PQOk/dDcTFv0VkKbe?=
 =?us-ascii?Q?+klJjBxNTk7DpsFwsa4DszqXR2uwS4veVgGom0JJawtx39u0MrvgSNU6i8V7?=
 =?us-ascii?Q?N9bUGI8Y5WIiChxmezr9ZCS0bFzIYJu0q62sfNJM17cVHZtwSH8awrMTuThW?=
 =?us-ascii?Q?bYp7f9AdAuLsJLElDU8j9P0VczID790oxgqisGQWJFGTSLNWF6uczS8973yh?=
 =?us-ascii?Q?XXv/6S4IgA9WRvPueQOOJHAOnwXHNKiWlyzGdd24vM19xL1W6eu9EArvWvAu?=
 =?us-ascii?Q?wybQWRincVjiXjvZJVHQcb7RMGvtr5Jmd3mjVKcsDK7tiq2aijA1wsp+quvP?=
 =?us-ascii?Q?9abTMFgOTRM36JWlVkyv9xWgg+rcMcW3zCCyMjcUnjkkN6EBK2D41V6Ubo+h?=
 =?us-ascii?Q?4TyKrfsCwVKenNrQXnTIqASrGNIUMCCB0I30vDMRff+DE5/eDFuKmszpu3KC?=
 =?us-ascii?Q?zS8mhU/Tl0SuR/UXmA60fx2rt1x8oUs0H9pd8VpspsdN/B2NtPh/VyxyqG8w?=
 =?us-ascii?Q?8Q9E65cCeeK7i2k8cUXtKAPx/U8GYB0f7mLbLzOgpq21Quuufr3qL+3pT7Fq?=
 =?us-ascii?Q?1MFR7SYtulihCwC6h+Pfcnxc5r+rupy4/8ePrBjaUwWNPmTWBKa2ARMrWKuP?=
 =?us-ascii?Q?G8FiD3esleopBmal9qQeupME96bs6re/UxGhfrpFQOwOpgD8WpVJ2VcvUdOm?=
 =?us-ascii?Q?adKRUKwAlR4Uj3A54OHGWOEiuR0AlquuM3FEfXBC9X1tIMA/X9cz1Lu2J8Lx?=
 =?us-ascii?Q?Qg8wyPZygl7qUlqydQm5ox6pQBS9BDZ/tupC4lZdMiZkc/Pl86i2hUVcMZWZ?=
 =?us-ascii?Q?bnXtawfCudNH/pxd9i2OU2sSthBAGc4jsetBwPfSNMtqFrsxukHax6pyMsDp?=
 =?us-ascii?Q?xMzn9sFM18esA0KTTJrtArTAPVvBOn5UVcMboK2kow7yOVm91jt1Qng89p9I?=
 =?us-ascii?Q?PIEQ6jaWiyZxzbGf3g+v0KYTIipU1fEs9QPVE6weqBkrxICOABWqN5iVsxWF?=
 =?us-ascii?Q?QA4hn4/UdJiZg5u3nZBcX9xyPHuJStNyqmCe5YRNJ6RayZlkUl/byoPtf0VX?=
 =?us-ascii?Q?8NlkJIEW7R3l2ZEksHkMggsCvScuvsiZChr5ysmF0/r7W7xt4wO20mSPwC1b?=
 =?us-ascii?Q?rWcMfPLmUxXsJBe7uNM4GR7lXI5JR+ILBgid+We7/wBnow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wKLygoVH5QChw0dqJ8vbIIzXem9hrlACokUo+HG0tMoRxiquUcJKRqBdit0q?=
 =?us-ascii?Q?s3lg5uZ3JKpcv6z4zYax0zLn3G0u11wpFpX2AeYoDkhNY4ha19yeugfhJvno?=
 =?us-ascii?Q?nr/PHKheSgsBGDnrnN+wRdIotiqoVRGuMCnYy0Z0SCPJnaI+MiHK95EwK3mE?=
 =?us-ascii?Q?6rhFHdF3E3J0RODLD6Me5ZBzL0w0JsQyqyM6PLhq+S6caw6YpmASwuSUWYtc?=
 =?us-ascii?Q?uAzOoauszZHFBprswTjNEUWq6mKZ0tiqZM0rcTKTFtkrkOsKJD3WTEl1/l1K?=
 =?us-ascii?Q?gbeEbXZOqA7OjbwCqZeMNL1OLNTi0aNuJ4jolyc5UEd7pnMN/jislEQiStKi?=
 =?us-ascii?Q?pPTIUt+YFgQD+3qQRaoL6spflEmTCeLf57JJt61yKoePMNVt3Sjo2g0fuTxY?=
 =?us-ascii?Q?BfM+uP7kzJB3QmLfcqTFs0kxvcEw+Ie7S6Wyo3TJgFmI4F901/dDdlKN2OFT?=
 =?us-ascii?Q?TuazjTNYomOYjsBsgES1xRZUItb3BHZvJiLlJd67U4DEkWaXt29P7SadhAwe?=
 =?us-ascii?Q?2CjYu9dgmV+RfQdtuTkY37nVUCW3qxFYiW+mJre2vBD25ULT92OJdxoRh7gO?=
 =?us-ascii?Q?oZTdxenbkLPXf8beL8VBY1zLQYgls2EzNNwHJlGzmnaMVVmgt1TsI70Xspgd?=
 =?us-ascii?Q?KqAVMPkt/FsSu1WW42EYglP0w6TEtQaaY1ifZDlAzsSwzZwqul2wD6knM4rL?=
 =?us-ascii?Q?c+KHo+aVQn9dvOsDpFd7JzHRZaK7XzPR7EwC2EL2y+j+wRBoj3BILKTmqOy3?=
 =?us-ascii?Q?Lx5C0oFy+t/4990mdJhQCyei9fMtVhXVkNKtGbeoaUpJjUzzhh6zqFad6QOA?=
 =?us-ascii?Q?LQm+h4xksrtCQCOjsrdDt7xYErQ+qhEZSrle8PO+73xJATrmqoNiW6FqR3Sx?=
 =?us-ascii?Q?HBfCLw9ob9IgkSGngYVgGyCg4ubNmiIs3O7Qqg7lumJndi5wDYP/i0y+rnJZ?=
 =?us-ascii?Q?KEzbVctrjcgN2gHM2Vz4+b97pfGrzWys7zL+9HbxqE+jYvuNYJoROvWi5a4W?=
 =?us-ascii?Q?Il6GBMN5OjRXT/GHaJ0yjs7dCvb+xuWL5c602oZy7l8ZMpAYC/KDcxYReEzl?=
 =?us-ascii?Q?xWCtEgXQBIPWZjYhTy2AY6gUZfsKe0VquPSpSjs22LlCFVsOgCs4Lb1zUXcm?=
 =?us-ascii?Q?HCUbt0mF+dLUW9KC/MIYnv0QLKXmXimA8NX8bPdYfFo73f8wgEQvhi+DmiwO?=
 =?us-ascii?Q?05rlHLCPOWkI8c5JOlipLdHF2eKAWZ1HMXnPX3v+MXZ98i7g37PP6/VbJhkL?=
 =?us-ascii?Q?or50Ez0shAGU2H8QkHX+1yh3NucJfJjeDQl3m5/1NhoCNFs+k/DX/w47es+o?=
 =?us-ascii?Q?nGYITEfbDOX1krYFKu5r/bOtwrR+sU36XYiQqP3XWQTqyHkiX955E+hXE8J3?=
 =?us-ascii?Q?GZNl/yJbu5MWoTHmTe9PgTJpPFL2tb31D9MB6bsljqUu/U08JxBHbygZk7b+?=
 =?us-ascii?Q?pOTrlPHRVABM7vAhRQuMxajbeEwWZ0pY0ewaTsvUDntg48cFa7sA8KjaaC8S?=
 =?us-ascii?Q?oc+FcpZ54G9w9gjA1qRUvIXBcA72QhDsTNi2alsC5xasdm5T/+ULOKUOSxTF?=
 =?us-ascii?Q?yICFQMPycIZl4H7Jswtx1MZuwU2oNwysnl6f2rBNopwgFx9yO5+YR9Ym3Hna?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aec88e0-f893-4f3b-85c2-08dca5a2c16c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:42.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4etfJ7V9rc60NiK3UpgWYo+QxHVCq5+U0ju+iWiLvayp4b9yHeVwKhcgzd2KkoEwZEwJJNSyOtCJv2OhoAn+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

This updates the BAP implementation to also notify the BASS plugin about
scanned broadcast streams, or when a scanned broadcaster is removed. This
is needed for the BAP Broadcast Assistant role - the BASS plugin registers
MediaAssistant objects for each detected stream that matches the audio
capabilities of peer Scan Delegator devices.
---
 profiles/audio/bap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fe5390e6a..50a68f27a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -57,6 +57,7 @@
 #include "src/error.h"
 
 #include "bap.h"
+#include "bass.h"
 
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
@@ -1199,6 +1200,9 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 				continue;
 			}
 
+			bass_add_stream(bap_data->device, meta, merged_caps,
+						qos, idx, bis_index);
+
 			/* Check if this BIS matches any local PAC */
 			bt_bap_verify_bis(bap_data->bap, bis_index,
 					merged_caps, &matched_lpac);
@@ -3227,6 +3231,8 @@ static void bap_bcast_remove(struct btd_service *service)
 	free(req);
 
 	bap_data_remove(data);
+
+	bass_remove_stream(device);
 }
 
 static int bap_probe(struct btd_service *service)
-- 
2.39.2

