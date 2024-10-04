Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640215D5DA;
	Fri,  4 Oct 2024 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044333; cv=fail; b=iBXIb4yqfMlAaXHEvi/EI8CCJ4Kx3RjPVHam8Qz4fagenSC3QKeuaap8lKs1FbhKoZXC0jPlBshTcbq7xOrooMwGkM7k46f0Bxbgzk7xFuQUM18xaBXlQnVyvZgejVBgYfZ4xLdrbT41hXAFYsCgRz164kUoKzEK4gB2RBfrNnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044333; c=relaxed/simple;
	bh=oeyVsL7koXgvqIifeR6++c9IvLilLEUHmRp09PuFQJU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FjqD7Q+3BVbUm+TO58uc9OyInZJ/+JqAtXCZsNSZSdgKzHMk08257f7bkxzB1KnWSC3Auf0UaLEWtilX679dqIyP8kqcbfGb1YZZ2lrGCUHetnNwvmFs7NlrlQ+u355NZDXAxB31eCf9UzGWKXK1sKMoTGLnTVUrc2ASbf5no80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PbvkS94k; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PbvkS94k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY+oHq35ujjMb/ksU5NEyZN0GwQeJeUxkdn2bquOLRXriTXLDkMh+riwOXLy1dZz63QRZoDNUqvLYrHk0mGlO4eYqw0F0Tekjnj7So5Sq6UxLnYwwDOaHJ27+cGZAQRwsx0ssvEJ42k6qLMy/IXDzIZz8ugHhpfNoc2HAPGIihLYJnXcTnjHlEsuqQUpbqoMRFgVNo4qlegSAh7jt5L0Qt9fHKOFD6M1CFXrL9HJZQ7ZOl5hJWvaKwjj9RIC+vn3AmVUvCRd+dVQZ/Q5tIUup4FZW8hJPic8DabRB2mvk8kX5jUhFClkUUelVRJQdbWZBbkpD7fqR10pCuJ4R4RyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvtQawfIQ+5AFIWMrWrzKef5HVBykDx2R/It1+WHfYw=;
 b=aqII/+pLOpbXYOyK6zs4lhvCYamRT8FhGjvgyJC8x//cP/8142XGUW4lupY2XYM0JRIGxz2SCKIvV5HrCr9KoLay0x5GNE1E3YhWsOLG+HgACIUdXQammKjTDKPx2bO82h72CwNz/raP6EOT3SmUB1dv0DKfn+8kp8wKxI0XIKmiqzfiHLSweKhHXtKaFCteavRlLmFdQy8dCpyKKJQTR3/WfBo2qzsX+HXAaORpmSAdnTd8sFHrNcfe1HoF6D1kEQz3EbvETcQpAQYeXj/G5pcbPFf/n3kxslkizr9MuiHAFcylPSqTvd0YX1l7MXkYZem3x0XIpWIVhnsGpr/zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvtQawfIQ+5AFIWMrWrzKef5HVBykDx2R/It1+WHfYw=;
 b=PbvkS94kXd+oXNw3n8TZIf+mmf8jsu5URZINO4PGfjGwIneaVHBKJi9tHa4QYu5D/ZH6ATl0tO1l0XBXBcI14BvzBwiYRb9gv+sEJWdvhRp+2ri8Zs30fpUkKytuLurtv7cEWk/DcjaqjAyP3BCLr67eaPkusKTwgopcOUQZzDxZ3OAUX96SxlrzFII3qrzdHrdoRQyZ3f/IzEV+fiiwoM0rFTDs9lbdb9CDovMxqC1uiMHPcvrF5/Ja1g3GOQnLKNPk2n63d8LQAAR2echiUjf7WJWMxo4RWlPoRn0einBceBIrT73iJPcet+5q+uRrXn417xqvSlly02bzWWWQEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DUZPR04MB9871.eurprd04.prod.outlook.com (2603:10a6:10:4b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:18:40 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:18:39 +0000
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
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v3 0/2] Bluetooth: btnxpuart: Add GPIO mechanism to
Date: Fri,  4 Oct 2024 17:49:39 +0530
Message-Id: <20241004121941.572539-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DUZPR04MB9871:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b552b3-de84-4676-c163-08dce46eadb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/6tMOBnxPq5QDm4wVkxcqBdAzPAiFrgBCuqgkL6rijZnozh6EoQj91c0DDvt?=
 =?us-ascii?Q?oYYUQAk6ewNq9F87dISON2PZvIlOTccCCHUa9IkHbRkc3uh5+yYs3gqryUdi?=
 =?us-ascii?Q?0mPlTlazflujI/H882lXPueKB+RzljD6UT7KWzJYTDQ5Grl7Nifv3AcPpVkV?=
 =?us-ascii?Q?xgbsLfdspCCu5PcXK4rJzDdEDTfUmB3Px2+uiJj/Yht1IxtpVn6UJDOrNlgR?=
 =?us-ascii?Q?XpUAEArLY8JCiz6kVwwsuLHBxtXDk9giCqyTMNN5KVT3GVoPXIAqmNKySAhZ?=
 =?us-ascii?Q?pE9X/t7F+8k7PnRwO+EynnI45YzMBk8U+OiB9M64ekKXsra7rbm8lMBpJeJz?=
 =?us-ascii?Q?rOqe1Mz/ojJSWHgKC1ORlrmIJxQPRuhGQkrEBK5IzkOPXEcCVlhsUXjg0Nn7?=
 =?us-ascii?Q?i1Wxy5xfRJKDUJ1Wj7ItSLBWZ+msups3zmlhKG75tzwsBxpc1QsbAVF/QoIT?=
 =?us-ascii?Q?Hfg+gRO8pIivclYCejYQtR11EsBomRqfwQ3d2mysWpfW/N8PLgjcl5FRJS7O?=
 =?us-ascii?Q?iTZAQKAsJTwaoq4zo7OM49xrup5ZC2jnNzxxh1mFuHl9ZH3vwk+HJ+ewsqGn?=
 =?us-ascii?Q?b602nH81gN23TkplRyCfVZGpZsQffAdQTlSMdFp5sZg6EGIBT+LWmvOkjPWh?=
 =?us-ascii?Q?pc3IXMkdQ2qL5v8snBZr7In9aAWkLJAicvRToazyyJmNujMbEe0OeNwVUO4c?=
 =?us-ascii?Q?hnt3W1x8G5c/09mi4QfCNbGQhTDMX71IOQ0twJWILdO6S+vC7w08g0yxeiAt?=
 =?us-ascii?Q?zYDcJMGIqsuHPPnYYIPxALgs8KSXhFujgA6iFZOfyzT4ffz3ykRLajWEzQcw?=
 =?us-ascii?Q?av05ky7OFej16xssuGTZ9uwM7slUpvEIqh/FmSt091xt09T9dI9BvxztsZWG?=
 =?us-ascii?Q?o74jt2acBMjPO9A7+2NbAX2Q8fla90O30T8TXEEvTA3wbuNq1v0lqKjinuJB?=
 =?us-ascii?Q?a19IvCKrLNzsD2fpA0QnTDNkWid9VTLElVUihggbO7xMD8xwmgR56QsdH87N?=
 =?us-ascii?Q?Gn4zkS40xoeiZ4Boct7ftF72OdTwh8Su6jSb0G85EtY2gT3p1+e1Zr/YkaTe?=
 =?us-ascii?Q?WHpTIJS3EhGPNqM2ml6m3rCKeTbS97AKDV93bOXC64PZl/C6uQ9j3DJJURlm?=
 =?us-ascii?Q?5LAMMWn3QsdiHpb411JqLCug73yhB9Qc/Zb5y95VlKpznagGz7zpDxTiAuja?=
 =?us-ascii?Q?QpSilpVyn6HYoMNIQJC5dhwYnQDxQ/Y57J7BEroY38GyVyER3VOQumYgp8Nh?=
 =?us-ascii?Q?z3AGvuOJRCQXZcKHS7Px8ro18mw3ifkfwSfZ2aEoUD75cn7iKov+GyP9VMBX?=
 =?us-ascii?Q?brSkSsD+u42gHWWBlexX+cFZS8MLYIXOZNFKOnx3H/nOGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fd2Qb/xq9OuwdEXAkFmdDMYY5TYRss7PB2Nz7q0uNCOuQR7+Oq+3myhgpRrJ?=
 =?us-ascii?Q?BELqOxCXXxI6cUaggCJ5+h9hFSyMlSgTl1G0rZ3OmBc5WweVQVT0XPp/2Smk?=
 =?us-ascii?Q?4wpEwGGvUHZQP4RV58ElXGnyljgnnOlCKxz1nflBQhau1DXGsILgKCkdz+uz?=
 =?us-ascii?Q?/b4km8cJUK5GFc+L9Fjk5WB6inMt0KpHbZpiHWnzQ/9JMmt+QNAwwK5jKmgo?=
 =?us-ascii?Q?HK7VyOzHj3n+ySle/9SM5r3scm2vGEXELMZN0RNCGosnEWbrM15VQGxsLgRN?=
 =?us-ascii?Q?6FXX7of4cnI3+imNg7agC9+jwgGrixZB2Ect/IQQg6X7T+PQTO8xjVPZR6nH?=
 =?us-ascii?Q?j00Xjoxw3S7cJeWj7/xEraaNf5r2CcEQRrNhCMlOtbyzhG14ViZslWpEXDwL?=
 =?us-ascii?Q?rEHOdDkUvj6yKxAcTRlCPDhh4fNfQuE0l1O3KKzuMezmiFA0gg5bVdhaEEON?=
 =?us-ascii?Q?BWzEclg1QVRgBIvc3AOB9iKPCQdZPU5s6Lw3Vwxce7Xf/EueVSuviGruM6bb?=
 =?us-ascii?Q?+b/A3Go6BCvfGvbtcM1xem1rcnTFkCstAqa41AQlKmTtSnKLLVMz9bE/xFaf?=
 =?us-ascii?Q?1hGyf3Gqvy8hZtO5+CzjGx7nSQSByMYQYEAzeJxEN/BCBhouozbI3YJUS5Q1?=
 =?us-ascii?Q?WJzsq4LDkWUzgsnK0SZ01thWAKA69uFv4p5Gzr8kjZf/fAmSsq8MtpGbiUtO?=
 =?us-ascii?Q?ITIsZnvZrFgChfPvEKK2SxkY7Z4s9GNd2OCYTryzPOFq6txVPKO7URf3O5J9?=
 =?us-ascii?Q?QOUjrG5PrXw+Aj4JduWcuR4iAF4gWGnLCYFnTgWKwruZVx9bWnnKnbxCXucX?=
 =?us-ascii?Q?Vav+lUyr7cWxyfcSCYGR9bS5IZ4cLaMupIlu7VD0GRXpu0eWTvBv5edRgEpM?=
 =?us-ascii?Q?MFDLpitBRAE5xxszegvQH1asde45gn9TsAu+obi2QTPsMuDZT8Y5nG/Jk6TH?=
 =?us-ascii?Q?Y2kNNVdRxr4yuhIFDkpXp+ql8lEWKYwEgnaOVkzE5H25SV4lApX9fp9urSxF?=
 =?us-ascii?Q?AGTaSoWj73HU+nzagux55U69b62GBY2Wp5DOz9fyH+7ZUrTDovFCR27fRu+D?=
 =?us-ascii?Q?6kiOghCnSNz0MdMdhav3DnArEdRNYovaN9KpuYvYZQNIn6YtSbRZ9sNudU+T?=
 =?us-ascii?Q?OcTm0mrJFklH2b3fd76vVaFRIReO6kqXisx6e51ghOhFDgHMQzKCVtQSuktC?=
 =?us-ascii?Q?F3wEXMs+XkjEhVhQgy/ty0oPJcKzkweRAajhpi/KFijW9yXEFBTpDXADUo6T?=
 =?us-ascii?Q?HbnXjNiSNQUiUZKRdzGxCRlG1MmIVOYfHJuOpwUaG400iJ+CWGmmDj2Ze+ns?=
 =?us-ascii?Q?GGQtv+gVE5Q2htf2W8iPHDHyud+tmsU9TUYCH60Fe5+6kZrgmjb5J4nt3JkL?=
 =?us-ascii?Q?xwnlb/Sf4L1i4V6qMD5qSuwSFL/YnmFCCI1aKHPsWsrxoc9eYRlme6Fn0O5f?=
 =?us-ascii?Q?lu6/wPXFWOs6o7sRhU38pfG9EjIznEkiV6P46eNAqVo1psKJca44R1BUoXLf?=
 =?us-ascii?Q?+ci43NlOAPIuMTE5lkTMsBX824iUEGEIU3748Uj+xHgW2LUx8pmkZwosjRuX?=
 =?us-ascii?Q?fUbnQD6vJ5ir+ZwHclyzYaWWNs3VJKLTxHrhAbILRIARAh0q3IfmyyUmslD0?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b552b3-de84-4676-c163-08dce46eadb4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:18:39.5087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh3wyWdgWwSI818EGOC4VgKN/FTPYlktQo7F0T9vffp9XzJMgavZoyovrr1RQmpgmsYjdXakNerweL2N/UP2MmJuibx9IlJzmYMd/v2nAB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9871

This patch series introduces a new optional device tree property
device-wakeup-gpios, which specifies the GPIO connected to BT_WAKE_IN pin of
the NXP chipset.

If this property is defined, the BTNXPUART driver uses this GPIO to put
the BT controller into sleep or wake it up, instead of the default UART
break mechanism.

The vendor command parameters HCI_NXP_WAKEUP_METHOD are configured to
use GPIO method instead of UART-break signal, to inform the chip about
this new mechanism.

Once power save feature is enabled, the driver puts the chip into power
save state by driving the GPIO high, and wakes it up by driving the GPIO
low.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Neeraj Sanjay Kale (2):
  dt-bindings: net: bluetooth: nxp: Add support for power save feature
    using GPIO
  Bluetooth: btnxpuart: Add GPIO support to power save feature

 .../net/bluetooth/nxp,88w8987-bt.yaml         |  8 +++++
 drivers/bluetooth/btnxpuart.c                 | 34 +++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.25.1

