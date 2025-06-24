Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazolkn19012050.outbound.protection.outlook.com [52.103.33.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E122D4B47
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775045; cv=fail; b=keqRs1VSkvsisBg1MFkrqJ9LOElYU7vh9fW4H2YCiMa+oDEVlsQmZkMdT7Z/WNt7pKTt0gPEw/syEz/M4ebnXn6VCJw4Filzde4Ej34QKkUq9M0kM3k+fVRr+Ytbv0nck3suMX3FiPHrDeCxUxHIpOMWKATBBbRWFr8zBuMnflg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775045; c=relaxed/simple;
	bh=mKc85IsaB0B0+b1T6ABN2CCYe+DCf7hAX2fmXsQ8lWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+iWjSKbLx776b/7vqWzQNj12XSD5uCHrxOZlI70/FOVtg08Ybsh/mJinh7rHs6eY0WxneR+q5ChFOC7K7COQ3v4okpm1i/w4EREwfD0U7tjdj1Rv7+/A85RWAm1hJo4F4x4g1NMmHtOsPpT2lbY+Wo+4MIyVwwLyW8UdObrsjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com; spf=pass smtp.mailfrom=msn.com; dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b=E1QOeu+P; arc=fail smtp.client-ip=52.103.33.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="E1QOeu+P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+bMh5PH240Vs5NHNgxl2QBZIzpszYRkDFFR3tAZUTlwTmZ5MEEGJMAB6gelnkg7hBjHJtfcv8KOuEsY9LBHp2MgKTn3ZJN79AmHFrzpQr5WqVseYgPPsGid067ZV6uBxITOdgfE+YGcZ+gGc3eRfcAZBUQ9qYyXF8TbvVwi30MXwf53KYgRv7K8z7bL4PVr/a1RF7aP7UGxfzyGaL6KJvynPtfloYXQ+en8ps9ezEmdNZG2ujD/gTa6H7s8ju9ADD/6ohrHaZLq9IsZr2P8p77EZ3fdTCze9QXgyljNHlgkDThneQsIg7D/E9SMcin21sBiuPDW43QBS8mT400HEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAVkUuf0Zb9aTmMOmLc+IYVtmka9hU+c2v5i51+cYzQ=;
 b=AGAaTn35tJ/RVpAn7LikhsDtlTfLF+8TkQScVr/vr73vOKaZKXj1ofOutwugdGS4henCVvz3UW/VYPSDCRwebH8eLFzuvjdLL4MTLdUIMQeEHRntttyH+EwjnrRvQBbOUx90lFUUVv4lU8iNor7KAtYief4R2x/IS+m83NM022te4CHEl18pNqAJ1q2hWDy4zh8MAswivMuLY50Q/Y52tp1Wl065xyonl+ce+Z5oDdNnJVpkylY/r4mkAO3wzf0X7a2TDeMMdFvAMGsVV/K2TxfjgP0Q3R8kzQUAago5T/eazj4ATcQHi6qnYBT3eXPusIjmoFcPRDb2tnNJ1iEKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAVkUuf0Zb9aTmMOmLc+IYVtmka9hU+c2v5i51+cYzQ=;
 b=E1QOeu+P2/H688WAeBNTNr45Lzcx5p07WHG239WANUZphU295guRNFFAdtEgcZBF43GqX6HeI3oBgw3GMp1BrqVQLJXxNIxT6h+VSu/wLe7e2TtvyYIfPuX/G+C4QADZNyWiUAJLpUKtzKT0IAsibbNmyFrNxRRNjxuTlbNFcWcrZ1vr93C6R5HGpzJ7ak3TZCtv6oIkIZjvcnzH+4aDjvBa5D31D7gNfcPmXW6VSaA3xRvG8dj9mRC7iJNLObhdodFsfFlpxHGQNHwGsm/T+UeuVw5ApnJpkOQbQxgWS1CnMZuusTzuqBDrScLSiicg/z9mNn8GkHnOU8akMtnplQ==
Received: from DBBPR05MB6283.eurprd05.prod.outlook.com (2603:10a6:10:cf::16)
 by AM7PR05MB6791.eurprd05.prod.outlook.com (2603:10a6:20b:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:24:01 +0000
Received: from DBBPR05MB6283.eurprd05.prod.outlook.com
 ([fe80::448d:14c8:4ce1:5b58]) by DBBPR05MB6283.eurprd05.prod.outlook.com
 ([fe80::448d:14c8:4ce1:5b58%5]) with mapi id 15.20.8857.019; Tue, 24 Jun 2025
 14:24:01 +0000
From: Pete Beardmore <pete.beardmore@msn.com>
To: linux-bluetooth@vger.kernel.org
Cc: Pete Beardmore <pete.beardmore@msn.com>
Subject: [PATCH BlueZ 1/1] obexd: Fix failure to register bt transport
Date: Tue, 24 Jun 2025 15:23:44 +0100
Message-ID:
 <DBBPR05MB6283E530AA7B8138A19DAA008A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <DBBPR05MB62836AA5E235A13B44F962C88A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
References: <DBBPR05MB62836AA5E235A13B44F962C88A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::18) To DBBPR05MB6283.eurprd05.prod.outlook.com
 (2603:10a6:10:cf::16)
X-Microsoft-Original-Message-ID:
 <20250624142344.626518-2-pete.beardmore@msn.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR05MB6283:EE_|AM7PR05MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b28cca-34a5-4cc1-517a-08ddb32ac3ad
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799009|7092599006|5072599009|15080799009|19110799006|41001999006|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVxfM86dP0CZjerUI5GtQqxEEaPajO49EwqnoBn47gKoZSAuVMeh2z88Ot4O?=
 =?us-ascii?Q?BjdHatMKAU9MwoOQfbltG1cYvzj4lc4y92pJkDe8Kgrgvw0/yNBQCID4MP1G?=
 =?us-ascii?Q?gReghMLEnYFZ8+Gn1GWt/e6CoDDsYoZcL4Bb5RwQvoCaRli3L1brvUWsVl4l?=
 =?us-ascii?Q?NZh/llvCFJ7I8F+r0lQ8dVCA6nM3H5cXT/WDKJynH34DOmmMl9joCmg1IPyw?=
 =?us-ascii?Q?I+CT11R7ULsaIGQLOWUeWg00W5nwIYmFGD+j5atsLypzPxis6kf25YDRRyxz?=
 =?us-ascii?Q?5Jg9KzH7CAZFEhyuSFeYNm9v3tkvTAl9NZKWVLVrtTVq5gNb/+fN4LWSkyXF?=
 =?us-ascii?Q?epVUF3Y3DivYn+h8ZCMPuFwvQkbCujbRTNDnJSizj+EixAdI36c2PQMiwHIW?=
 =?us-ascii?Q?N8ot6pw57nu7SS0c5kVvy2DgjbQaNPXiZvden3xb4yH2HUg0ANm32OpCG2Bn?=
 =?us-ascii?Q?a4eze0oAbWjCYxPlp3KaxFXDxQ6Fk1nhKWKBqnb2mscN5XjjauCa8VLkG6Ad?=
 =?us-ascii?Q?vleaC5fPfnZNlJvq9QbMnEuD6UVNIEfbI6SXq8By8YzonmxwyGeRNFysf5dE?=
 =?us-ascii?Q?MHnfpqGDJfzpSnRdcQHERsc5i4w+L3PR+mybAdAklR+2zTpXHOGx5ootf4dc?=
 =?us-ascii?Q?uM9LS6LNewOLsZi3lOhTIhcTYXhkWhTiG4oQXYSb+QqDW4NR6eLwL7t7SGPa?=
 =?us-ascii?Q?a4diT8Dq2qHVu8ZvHbx5lM5ghlkxl5CNWyqZDCejv9xECX23Jza4PboQMQMa?=
 =?us-ascii?Q?CUe49hn/v0p63PtEMmTBtTULPVqkpltCgHvEq4s6fzcfEymUIwsc4xfcJ6+4?=
 =?us-ascii?Q?5NCvbQ9YmCwchxkjlI5jWRhCAy8is4M+kgw2yhb4l/YN06AHx2EhvrJ/qUT0?=
 =?us-ascii?Q?FA7zXA1ECa06hQfYaSpjFgDgCI5L3MYJ4iUyLTsG608qm5rQ17Z2b0Erz0G8?=
 =?us-ascii?Q?WlGaBlADhN4JX1erjkJ4W0/OUJd1RKdlWUjxoG0HG9Ik5VjLJ/c7dZ4Z06dX?=
 =?us-ascii?Q?Fn6TbliazvDvmM2UKWqrW+XTUosZQDjPCHEgGHs0EKfEtfnk9X0q4NlaFieM?=
 =?us-ascii?Q?Nzy/3gWdgWGJrjyxMOtIxYl7d9FmWqgbTO2nfOaa0xusKH9nTLMKbfvkaBYn?=
 =?us-ascii?Q?R4gcDs49NmGsKvfcF+BhUOKHWt3PP33i0xjrv8b2gAEilMe5DRfhqcppRLOe?=
 =?us-ascii?Q?qOEW4AuESXdH2U6uccE0ibrByblZJjo4gFFc+A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDmlRQ8gZG79j7izCOCCBFl8NYu4eQ31GZHkG/Nz8huPPfulnOTOzzazHA4r?=
 =?us-ascii?Q?i3ZmirkjalkXvlMIR4Bb/VUuqSdkEsrEZPGFGwRPZ6EWZCRbCDxmIpH7mNsj?=
 =?us-ascii?Q?dxavakeXv1QEHdljkrNVoKReACSlYfdNoWj/RCaISPekoe1l7vwdoLoLKfm9?=
 =?us-ascii?Q?/X4lag1fPsO3BnxKOT083N20573wktSWdRxCiBlD97CLlA+qhydPa0zOKbEk?=
 =?us-ascii?Q?rudUuQ7hQQBJU61MHnf0TMZRNK7JSPUZ8VQzZfQdMg7kH6qeS5ZgyxKm/HzJ?=
 =?us-ascii?Q?3SIxL8KqDb2OyNNUy4Jw+ldJVS7qT8jAdqd5/i9m3XDDrS5jjc18LlzVoK29?=
 =?us-ascii?Q?UvvBScjInN3Tow5mfBNZOMokKVA3xQYYXw39xtysAWsX5mNmBDP/pBOov2Ic?=
 =?us-ascii?Q?YHdqQk9IZGzJMt4spUurqB3UbOF6AJdRg3tam++03rHKjcDR0+BjEZyojyg9?=
 =?us-ascii?Q?D2ahUXyZfLniuY3HBpjOrx5Zzefrlj35YiEHyJyNsGW2cMHmjhz16Inet/C/?=
 =?us-ascii?Q?3tT0fFhoPQyisFTqH201W13zQsuvMX0yR6Rjctwu4dqBVn+GIve4gv06ceZu?=
 =?us-ascii?Q?a1y/ilisKB7ghxbSrQiiiGeqXT94227PGY1Eom0AMqtAiurDId1QrxKjn31y?=
 =?us-ascii?Q?ljENe62AbUPcp6RMmc+RN+Xbdl237N3TOhEqYbbOYpq95c6JXhvLgJqzsuY4?=
 =?us-ascii?Q?aixyOA6AFbT8PCAd1Fc29LYJ86nb9OzDmzxGfKq786MWYEIrlKiWMAn2f0RB?=
 =?us-ascii?Q?4Zy/NJ7uXF3GW3YNFEiUfQvZOYqwwlMRG21Bo93pIUo4pCKGKafZ/OJEdwBU?=
 =?us-ascii?Q?C13vaNNbAZUWt8DB1VDrFr+qbQ+TqjJKjWeS2QA+xMrXohVvmbnRhoIYBYK0?=
 =?us-ascii?Q?ron4ZfSaEKCFjiN0t3JZgeK7Df+XhVgasKwtkkwMGrhb6zvPvq0lHBa03ews?=
 =?us-ascii?Q?+Y0t6C0i51Bc+MX4ePgpOIjmvHNccZ0brs7QinnZon/CBhb4hgkFkZpftPlo?=
 =?us-ascii?Q?/KEB0zTNU40YoQ2+QmWSqYAivU1N+RnENZTSRL9xdK8zdYwqmTFlXfG2hb8S?=
 =?us-ascii?Q?SkB6NzWHM8Q6U/ZYYomhvve1UGATtMAbuXt1SbqKGnORIHzKlL0mhrvbumjY?=
 =?us-ascii?Q?KFQcvU0F1p19wGDejlXnjpjYKN3K4qK98q3UZ3GgUQXJxpI3IbqiV/YdVcuP?=
 =?us-ascii?Q?XIilsroIjIgvvsTXyS0QtTzjJCj7uq+fvsieoUMmVUoJ+h/MgJeF1ayWqO0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-64219.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b28cca-34a5-4cc1-517a-08ddb32ac3ad
X-MS-Exchange-CrossTenant-AuthSource: DBBPR05MB6283.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:24:01.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6791

On initial logind update, the internal 'active' state is FALSE. Where
querying the current state (`sd_uid_get_state`) returns 'active' we do
NOT want to short-circuit the update to the internal state value and
ultimate transport initialisation.
---
 obexd/src/logind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/src/logind.c b/obexd/src/logind.c
index b4279b209..e681dd39f 100644
--- a/obexd/src/logind.c
+++ b/obexd/src/logind.c
@@ -68,7 +68,7 @@ static int update(void)
 		return res;
 
 	if (state_is_active) {
-		if (!active)
+		if (active)
 			return 0;
 	} else {
 		res = sd_uid_get_seats(uid, 1, NULL);
-- 
2.50.0

