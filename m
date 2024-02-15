Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43812BF18
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032246; cv=fail; b=MGUe3oiJbc5l/yrZJGJ6NCM9Y5cCSKDGzeIMk7VHlqXhErKXZqeSmL7B6I8HFTptCTdnsq7bdflDpgfnWBhohcOHB8Z6kkTz77UHf+NFdp9ZaHZas9l5ireGokawfpbxDlRJzATS7/IyQn3w1TLY4diCxFkBwhlEgz4mx/qfcQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032246; c=relaxed/simple;
	bh=S4R95YDnzPsVxD0S2lLkH7Xq5c41yfnYE3/ZFeFpzNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eKYQE+ojZ7SzB7x1zkniyXK6a1+xyV0VPLaIDeez0PsMABnFt7UXsAZpzQwPZdCiKoOYST1lmkAq5Frvk1wejcde21AKykde7//SdomS2tVAqaHSmyJPB6QpPMwEMgxXCv3UFfoC7NF9eueXGyxW9c2RMOd8R9aoWRcu5s5QEWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UB18Pr7y; arc=fail smtp.client-ip=40.107.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UB18Pr7y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joO9v46eBiCQ4t6OSqWD1UIIfv41kYlH/xgc8qZOWWvFsiEmbgfbZtj/plCQFgUSfEbPq65uXUnMARt+YxvLv8Y2AcYXTwy/4zPK69J2i1oD6oQxFgKKNTZdAxtMUtGQj5tZ8dKenDcYbXryVymD8QgFkrAfdJHgx9heEQyVyWK5+dtM67mVAd9BtHFuL8vMMFl/WyEQSI5rGKITBqJps3vaqAJn3faLzVJwUDwsOA5GeU3juc1P5NggKRLUQghwXTcjYY08KuBZ/R/EHkmoTHObi3bDu9St/flg+km2MGnqb0/dolfmX51+Ru076/X6QFD+BBAScqkNL03k3xPo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtioNjKSjtKBUapZqSFHoeEWiIewPA7rpXnhm2BN8E0=;
 b=XcwV0jz6euUUhfoNlVVpiditc6b0Ih9hji26zskHiCi/v6qt0mLKzpZGdhiU7za8ZHA8WAdvHNtDV/N7BGDxfcTyndGsk6v8OoV3PKwTBIgewiOUesg2A98vLTExarWGDKsYLQdmmfqvaJRPxzu8JjWueOIG9XJBZHATbjldl7sMb0pljKcBCQhPbyvr7/k0MR/Vy5aoHmFfV7PrDQ5P/Q9Pi2/pxMj0Q3KkzInUFYILOnXAhBnhpZJoVqLN2R1haD1UO2/Y8gD3FsspF6p7Z68vjOVuXTAyUp77dVJA0s6pUQgwH1k1/29FbZ9oCLC85hgFvRa05RS7kggnYzXLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtioNjKSjtKBUapZqSFHoeEWiIewPA7rpXnhm2BN8E0=;
 b=UB18Pr7yAiHLjFL4b1ArmOcsL6K1euqkN+kcB88UlZ7Wd4cLfaN9CkW3HDWIcVTAlKXh5mcA8yKthNBmoja5KD1VcwmKuvkhyYMILA+PJ6huBahcR4oBnA7lY8X+2zWH5f2UFXyGB2BIUhfrg2SVsimGnTPQaxr7bKwyDvtc4Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 21:24:01 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:24:01 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 0/7] Add support for multiple BISes on the bcast source
Date: Thu, 15 Feb 2024 23:23:49 +0200
Message-Id: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:205::23)
 To VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: ea200a3f-1529-4f43-52a6-08dc2e6c6d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lKMbMj2jfrtGoUDWzkMCOLmWPfvwQEDDjNJaFMCrtnoAxRFSkPLeu/Q/RAlBJqaEWMsGA8RkPSPMKBhWl8IC8/+HzZOyeB8f5RXK7jFdhuYJJ2btyTy6uuMtKMFmgDmgZ1/SRkpxMiOarg2ozFwiVX5QM6iNnVAPNCz0v07ywesSYxZrp9a6+U88Xy1LKhZL2625FqHKhUgmi50xyet1IMzETy+Fedj6B1el+FCPlKMcTxvBNbne0wqj60GuslzmCAN8JS5v0U1EjFH578M2prPuPSacvy7xdCSwT8qiPXSuST3ZxLUl/6rw1AFpR6v8GVYc+Ope287ZtVWoFIAsKJL37f/7CEB571lOc4sxs+PJNNcfwPWV12JDR5pU3TPfKEcetIsQjmuz4vE0I0D9SoGjPtkDtDxppiRqghN8e3vdXh2mPAkF5T7NxnUJzBbiITe7NbR5QWUuX+09tBkS/9EvqNjOEakpUsVpQ+TRBBp9cPV+jCmUUTyl+lb5bBeZh0vIINP9akZgpxWTlJgOBF3t7SfbykAubXvLYK6y4sH9kGdYJmQkz9pneBfYNKzt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(316002)(66946007)(2906002)(5660300002)(66556008)(4326008)(66476007)(86362001)(478600001)(41300700001)(8936002)(6916009)(8676002)(6512007)(6506007)(6486002)(26005)(1076003)(36756003)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nWmH3fPk5Lrz6bImbs0RRyPBktqEGDRoNPWSzj+Dm5rpeHJBeUytvPuVqohk?=
 =?us-ascii?Q?uE0VM5SfPxk4Xi2975GaHPE10V5jC2YN/A3ty9BfL9P0bZQ2+xiyjMxOf2NP?=
 =?us-ascii?Q?g5DkIwpWM1sGCYNShWGmFlQCWj6q48cFXMd69FFY5Jl/eCU7yrYxeqfjHZAD?=
 =?us-ascii?Q?vPpAYXVBhY3kyonfGKhY/e3cD/HztzfXzwcmIl7Zm/sBGQjNlrUJKzeUpq0k?=
 =?us-ascii?Q?ecynV4eK68OBqbz7aSM51EnoyNmhD3Vu0oBqhKLwOd2BfH6/Dve3C0UQvCxX?=
 =?us-ascii?Q?64+jcm9Sxcc6ltfR8DM3USUAGFwAOhgn65nlMjW3UMEbGDeropo9Zmg4f1l4?=
 =?us-ascii?Q?1cIQSi2qF2sGkPWHo+1JUwv5KHJ5UPyd7FZ+nLCE70Gt7nARH0xBtOVXRWhz?=
 =?us-ascii?Q?VsnIqLUixzxwPRLrSp/EOxoMrR02VEgv504886tlYeqzYiehIi65QZNT8ly8?=
 =?us-ascii?Q?lxqe6T+Ds+e/FjBQMlHgtj5XMj91yWTZhuQsdBNJeeNgGfoiHnDd+uAA4bn5?=
 =?us-ascii?Q?GcQL38i0SSeyLBgR+npleEuq20ROpaF8caEMTTxeUgNPMb5IDFCcImEUAqet?=
 =?us-ascii?Q?14+KqkKYGEyiNOpfZuZ2IIE/EA9ex+wgiXPvww3LgEzpfW3PoFEo2mdTJqXi?=
 =?us-ascii?Q?tVPHDNTfRmSFRWj2vH9T++8JYddDNIa0UEKec4sf+aVLPXaGgod6+9ZsNZVl?=
 =?us-ascii?Q?Lv66p9bF3B7Zr+rHiDtGYnerwvQtovXvuht90XzgNTEIHjEGwhBFxcy7AYvh?=
 =?us-ascii?Q?qnuv9HtamVj3gHjJhSiMLd4Q0UTsnQrJwjmB5z7QZTZ0zUPv9FKQtlpyPJ58?=
 =?us-ascii?Q?gYdSzc0JrUyNSIxxYVKOB6EXh0CgeF8yDmfTJ7NoDdCB5EQfYUpWeZM8jP2e?=
 =?us-ascii?Q?w/0nxHBNKVmyu7Se3bg4ga1PWDUlWP34gQP4Ickbjkfasb+BvnBqUErniFun?=
 =?us-ascii?Q?DnndCtz6Mu+4cZKfsmBBtkC1vnJzuqG9YPNxbOUMYwPxMBPBUaBQOILrlIsi?=
 =?us-ascii?Q?zzOwTxe4onq2vG7L1vrBySVSY8geS5+MPiaqv7fBoqRO8jTUCwlBbmZLcUxL?=
 =?us-ascii?Q?5LH4R49OaIZ8pwoWrt8TOnLNQlystqj/xk3WheGG/YRD9knbB2GCPn0gIFuY?=
 =?us-ascii?Q?t2b4HxxwyDEvYcj3hEF1LwwNjTJvx12X+ox8MKFe9d0+IqFQRWnHSGeEGqdU?=
 =?us-ascii?Q?aqAPDZX8sZs5C+XDbyD6Cjiw+cprSdnFzdiGnVFZYJjvU4sXnvqfaTSVWwfB?=
 =?us-ascii?Q?R9p1e+QhDFDxHMCTBBaxzEvfXzFyzp4frgcbXCwUnmvdqrLi5nndKD1c6gkK?=
 =?us-ascii?Q?8gOSB5Y3Jq/CEFF6ibA5VmQk4gLo/1R3BPQi/Eblbkm/UH/2AtXAQ+v1SEZ/?=
 =?us-ascii?Q?iDsWiaMxVH8LHZAVxdh0axTaW8kVR4BCI5vX3/XKGUcE1iApyluNmrcqQbsj?=
 =?us-ascii?Q?0ncexqC42hb0UlTKhepdayLDKhNakIyVzqNpR0/D2DKrPwNiM8opkTz/qaR5?=
 =?us-ascii?Q?KKg1IBsm4m3tPzyJiIPiunuzhWWkXHb5noHr2Hn+QCinYje4tFjDIS2x1zau?=
 =?us-ascii?Q?tzwes+p+ZfUT2u5UEwlX4nXE1k0UwPbvMn00yJZjclH4WGx98nta5QyeYyJE?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea200a3f-1529-4f43-52a6-08dc2e6c6d75
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:01.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fg6b1oQucW0qWd8xHsFJkKu0bMxdYyOolawp6WgrkCCPwHf87vBEkrYSVFqLIoBHu/h0yQfXLeozQYxc4HBR0C9cxOkIJX9qOGsPrKv713s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128

This patch adds support for multiple BISes in broadcast sources.

Example commands:
Create a local endpoint and an endpoint for BIS1:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 0x03
[/local/endpoint/ep0] Supported Context (value): 0

Configure BIS1, create BIS1 transport and endpoint for BIS2:
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0x01
[/local/endpoint/ep0] Enter channel location (value/no): 0x01
[/local/endpoint/ep0] Enter Metadata (value/no): n

Configure BIS2, create BIS2 transport and endpoint for BIS3:
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0x01
[/local/endpoint/ep0] Enter channel location (value/no): 0x02
[/local/endpoint/ep0] Enter Metadata (value/no): n

For multiple BISes acquire must be called on all transports
before the BIG is created:
transport.acquire /org/bluez/hci0/pac_bcast0/fd0 
transport.acquire /org/bluez/hci0/pac_bcast0/fd1
.....
transport.release /org/bluez/hci0/pac_bcast0/fd0
transport.release /org/bluez/hci0/pac_bcast0/fd1

Silviu Florian Barbulescu (7):
  bap: Remove set lpac user data at bcast ep register
  bap: Split bap_state and bap_connecting in two functions
  shared/bap: Generate single BIS BASE for a config with BIG ID 0xFF
  shared/bap: Add state in the stream struct for broadcast source
  shared/bap: Check the state of all the streams with the same BIG ID
  shared/bap: Add support to create a stream for broadcast source
  bap: Set the generated BASE on all setups from the same BIG

 profiles/audio/bap.c | 307 ++++++++++++++++++++++++++++++++++---------
 src/shared/bap.c     |  87 +++++++++---
 src/shared/bap.h     |   2 +
 3 files changed, 314 insertions(+), 82 deletions(-)


base-commit: ee880bee85864b0e691370197c9de8d2f7ba0af2
-- 
2.39.2

