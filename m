Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51E190664
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734062; cv=fail; b=g1IuouwLNk+kfivbSR/28dzD4znjhv4MA82MXDk7qZOdch4t93TAdZVc21P2r4jUoHd84S8kkKWEGystfdolDXQCsYzm0iahxADkUgnBSDJ04jFtKlKyGi+zHfpbOrKqlhVLjDXBe8aRCJqtBOjTkC6ZgoWRD9d9haT3CHBirmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734062; c=relaxed/simple;
	bh=5kM1+j43q38CLjKH0l5S/TAHjyclAsA8avI181BvUZU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q2cLHceXjlav6OEh/DWCyqB9SDpok+NCjvsDK0WYz9vEAlkuphfF1rfo1q7HxPV6Cmmr4gwuJob4pYiUVRVKtA+QU9I5/hQOQiyLRZ5YP2iFRvzqdREpvUsX7H+zA9xW4zQ1NjfFeYjXfm8InGnpAqnnCAJefcTKQTaIqMj7HXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OWtm7+Au; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OWtm7+Au"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1/+ndjT4z6N1b1rIfnXuIwldLNlueTRknT5UqpkwqnNZyFronQ4RrafoSpJQWlCCQPhiT78abg5Gqa/hG1NFbj+xdu1vbXTXkFXLs9+8x9rd6q0cJ9U2WuNn/hu0TVdSo/9vVaOyFfowh2VP3ntF271t7tQ449sQJs4RbgM075/6K2C8sk8mN+kYZpRzo3vEb6XLzovzmF714dNPaOuysTUUGVCQQaWbNybM8pdnodPFA3ZW5hnSg29xjSs0iuQSVLW+gsgpqWxYk7xc1s3MIw49PfElY2kuuzfHVb8VqXqYvJ0+4AM5pcWm2J004Pq3bZVD9YzR7rLKbfRSOyDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDrh3lo3HVvvGnKavjS8ZAELO3Ps16JIt0UOafy9rUo=;
 b=kJfbItkrWMrUk+H/venJhvHWEZQPFmaOCo/5+E9UDi46YCvOk0QFtBZwlSd7Vau/U3Dk3FLP8ULr4JVeHBfiKHaq5LbLTVGz/gRT6uzZhE4K1gYitpPegUfoH4mLQ2GQruVPzZL2yfKMbd7f3fXngduPpJ0JyVthLw8FzmSwINeTGRkKPehAPhLgV/x1z32k+2UWNBxkgVfWmyKkK8mqv85yqCk/rI9mH7UOyAdbr9dA768MliDWotJZfpO+o2WTfn17ITxmtRq4BjdyDz8SGHlamw2PaUCq2g84jWM6Y7+YkZpdgRy4C5bbsSC8gm6jfiVlYxMBfxg3ODEHo9zpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDrh3lo3HVvvGnKavjS8ZAELO3Ps16JIt0UOafy9rUo=;
 b=OWtm7+AuiRD+G8VYksj28C9kBTJk5cXwwezsgzky5aOdj4he7DQl8YE20XiJZGNBus06OUIjbvCtWfNS43q35WkzWmPEbqEAvbf+qNVqNk82PhuZZKVAKsqnbtgwVT+JjpITHC2fGYa00Q/nBuYgK2pTDVIAjkOp0eXikv/aPQK4yLx96UKHdTkXwcDQkJIPCwqKoi7UVUDA+w3mzsdDMuF3RPiwp5plcxz6q/6lLL0qNFpnEW3uVIu8kL5Mkfy7FWNCrCdga8k1EZ7EfMHXGUxDZOEtX5BCy/eUXV3lVOyxWbppMbYA4eT7wx27a35FbTp7evDDmx2F40+2zidf3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9842.eurprd04.prod.outlook.com (2603:10a6:10:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 08:20:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7918.024; Thu, 19 Sep 2024
 08:20:56 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Set bap debug func at broadcast probe
Date: Thu, 19 Sep 2024 11:20:45 +0300
Message-Id: <20240919082046.7208-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9842:EE_
X-MS-Office365-Filtering-Correlation-Id: ed609a23-390d-48c9-7763-08dcd883fc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CO3keQhf9IeiQ1triDggyLVOZjyq3NVjrDB/JBrBUj7GrvPwNKr+4F7QM+2i?=
 =?us-ascii?Q?zamAKkLqJNaLeSitIssEmUGFEgO0PG3EiyBUk+p9RqFdiqeMGD3w4+8V0ot5?=
 =?us-ascii?Q?HSE4XoGjdVBBQvZEUoF0pICyC/5JxxDTCS9XiKrMIhIygxL6ISg3ohcGB/p7?=
 =?us-ascii?Q?FoNnXGbVz5gvAsu1FzXQjrLqIpHwpT30kc9QT9aYXcfoM3fsMkEJJ7Oi2rIC?=
 =?us-ascii?Q?ZT8gM3BhBweiXYaQNGnD0SUaK7rU8SKk0diTb5I9wX6B1z7c9o4STvU5UG2i?=
 =?us-ascii?Q?UdAecirzTBntCjptmBWXCl6YFKXi7+4HyHI7xWzGyCv/QUPo6HRkAVEuQbNH?=
 =?us-ascii?Q?9oJRCXpvBpflUl1CNBPqEwNPxa3cYuY4bCm4tWC7MV2D92ZnYwKaKbM4+moQ?=
 =?us-ascii?Q?3inw+7VmUThdjVtMVHeAAtdCmCj2tDiavxSTs2DlPtUnfxfyJN5VhXK3UOIF?=
 =?us-ascii?Q?AsJMb98huDSgNLu56j7SdKN69NVRwfWXMhnCRXlZTXDvvGlSW4/SwZK5OjRZ?=
 =?us-ascii?Q?PrlAPFjiUAKp5gWjcUy2guuG0bi66q9LawyUXarus/jpNVwjPFKQCVq3WT6h?=
 =?us-ascii?Q?eBMojK1UioyUPG9ZZkIMo83d6B2deF77Cl0z6+DfFdyCCUCF1KZCbuC1aVGd?=
 =?us-ascii?Q?9plijRclPkNv3kDqQK/hLeCcmj7hZZtpGS2PpOu66uw91ULGsxt5JgMGA4Xh?=
 =?us-ascii?Q?55xtAtKQePetwgr5W94hvRYIJinK75vQqVBXG9Ajapw/YnaFJgTlPDVhhP9S?=
 =?us-ascii?Q?PpxQidcn1POAmew8Kkdj4Elkd6CedcRh5viSdXG4T3XpB3ST6k8m78qohf/b?=
 =?us-ascii?Q?J6ryYrxUOleNL3h2UgODcr42ACjtGiR/ZxOiv/gpGxk8st87eSRavFgT0gYy?=
 =?us-ascii?Q?emSXqswe+jYbvZtmT6xED0cql0JExh3lDeT/GYIOfhR77KePuLWDZT7tP0Wl?=
 =?us-ascii?Q?dLrojNHyOnaVU4vMHmXd6yT5w/ud6+dd/cdGG8PEaelxRtY3pNxae+CQCAlv?=
 =?us-ascii?Q?BURTUo1LHoD8fgjP0DMci2whu7fu5WMNnEMKkQL//4HiVIZtBVgZ7VOWuREf?=
 =?us-ascii?Q?CAKWu0LAQBM+KeYul4ykn4Ahc8PJ5oSKohpGp9BY3hd8rMeyL8OdWO3raffp?=
 =?us-ascii?Q?5ibUoLD3r/WWdxVa9ZOfRbeqeB4bWZ6Uki+I/2QIHjpwCpUSRGDtfxMxGeKw?=
 =?us-ascii?Q?bdjmLn/pfjKelmRCH1tIcc4HUD4vE6rm4JpwpzyzGiq236kww3vhPPj6W3dp?=
 =?us-ascii?Q?ZzY2cXou1PvnQADxBk+rXrnmtaD3HrLdjz9eStpg9RluzxcJP4pnc2/EywGp?=
 =?us-ascii?Q?skcJhWJ8WYpk8VHMCpomwt0ugHduPhVYNSwlEfQG7xcN2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zoLvZJuUtXnzF5vRPm7d0kO5qbKYVruq+lWNciNkYI6MSeDq5UZnTMybeQ7?=
 =?us-ascii?Q?8iFv+qygV7KFv9vW/oVJfOg7063s7ZLJ43cc+fZTRf+KwgTFOqKYPG8+L3Fy?=
 =?us-ascii?Q?4lg0CslfaiHATr8TFq7WvS+eddgEbgnT/WxcKcHQacFW/Nary/82WDjrQi6/?=
 =?us-ascii?Q?a+dKN98BI0rFVnlcJw4wZ9ZabEvz9YASW26zcn0z5r0CJNaKYj1tb9bNjps9?=
 =?us-ascii?Q?oj/Fr2PCneFJQtnevny1sKdundOwoTZGMWQOFzbtrre5P5XTJ6qHrISbubq6?=
 =?us-ascii?Q?NZEFxhLhNddOj3pUYAtCpS/02yEs/e7fbdxdylNLV4jUDthf7RCqskFG0oDQ?=
 =?us-ascii?Q?KZ6X4P0BeZ+5C2CFt7loJLNO2Gn2nNCyeYKEwONqzTBqsKkTPx6tnkB7TfXw?=
 =?us-ascii?Q?hQz2ozwaEiFVkUSmzCmSExK/ZIZ3EmEm14l4gmpuU+t+oqsND848zdNuZ0nk?=
 =?us-ascii?Q?yW5HZ+j0gY6Kihl0Q+ty46C6ztwbzRBFxjzDYfo2TJCVW9eEih8fCs/Auivc?=
 =?us-ascii?Q?njRItGl65hD/LcWd33DZK7mEVWn8lbAuKfs6fVD+wy/fa82gDaDHyG5ZBO3C?=
 =?us-ascii?Q?S6xhJwYUHQDjI7Mf0bE8y6fHT4ldSUgQg2/IKZ/UI48qYpE/rI8UFSbCBhK2?=
 =?us-ascii?Q?S42ea8hvorzsjv5otYRt/AVR2nnpFFOfl+oECBY9qNeryQIb4oxmmHZjcBHV?=
 =?us-ascii?Q?5nTKa4f1WjnMF3uwgyMiSnt2cSi1KkYOCYDgJuue1FQhyMPWygQYzFRnoPpQ?=
 =?us-ascii?Q?7JI5yprP/fkAClvlsraVV4qR6hD9fIEFvraNsNtzk560/6lTdklU1W2Z5c2u?=
 =?us-ascii?Q?kzGp2h0E7+7RuuspXT6SVQfIrmXY9xE3OVjLGzAC70etsvDBDqcRMl1oEgj7?=
 =?us-ascii?Q?ccDFoG0yg9RF0lt8PW737iN58vPbxMQBnUdYnWThvH4Ean8BQ4GTPczmXgL6?=
 =?us-ascii?Q?oRAPjenkYekwyg4Uz5ZKpwIVSQ0ihgBSeFJYHRiyEr/Di18RGB5KBrMxbO7R?=
 =?us-ascii?Q?v/ChGhakiU9xaqJj1sojWQ54PVpd7IURqlaJD/eHBZ1wr8EymdOYhkyLQR/c?=
 =?us-ascii?Q?3/xHxKFSMrktFpz8uBlyHYmXHi0mH1ciowhsiPMugrGCHxcTDyZs7whQ8qDW?=
 =?us-ascii?Q?MmwkD6/9gMO/dLSq8Tz47Dr4qaaSx1mNh2wFu4Fd+yWDehMV2jRYiLr4JFhD?=
 =?us-ascii?Q?SkHCVAoFYXKPo6yf1f9WUQPN5ootCwM/6AznlJhYl4UgP6109fJTDUfuFPL6?=
 =?us-ascii?Q?NluXDaGXxbHCew3pWLY+JhY+NpjRGQ351UfZsgGVpZk05shyMoxOo5clCxT4?=
 =?us-ascii?Q?GCpWB0jPrnjORunkqdYrqNmIksrdiBouNKO0pcTbpJZDtzzLrmcGU2qHZW0i?=
 =?us-ascii?Q?jfSW7VhPz50RqqfxzdhYGBdERja/N9eLIOPeneO/b45wRyWd3y1YhoEXDxrj?=
 =?us-ascii?Q?ryuI3gwosnvvjGGweXe0UZPemqD2Sn0dofqb/u9JVBddhWAFBlYW9APPiaaf?=
 =?us-ascii?Q?7PgEscYmdZwPozu5KCuA3nXxkrxzml4pmARf+bR72xsgAoNRlxzWOBiwkGc+?=
 =?us-ascii?Q?30XQeIwcowc6hIGRrlsUDtM8xxczWVkqMGx/vhEKruD3jPoVWdE7qHaaqMz3?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed609a23-390d-48c9-7763-08dcd883fc18
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 08:20:56.4104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbuKXsk6ZLHsrf+Kp+X1odR10vMAuiIzJ5PDVYNSkjFVxY6ShB6PgcdzJaOGZbg21Zd+i1DBAW+u4PGJICGXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9842

When a Broadcast Sink acting as a Scan Delegator probes a Broadcaster with
the help of a Broadcast Assistant, a new BAP session is added for the
Broadcaster device before additional session information is initialized
(like the bt_bap session). This causes the bap debug func to not be set
in bap_data_add.

This patch adds an explicit call to set the function after the bt_bap
session is created.

Iulia Tanasescu (1):
  bap: Set bap debug func at broadcast probe

 profiles/audio/bap.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: 7aa245979db6ee74b665154f5c1f203a277eb64a
-- 
2.39.2

