Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503E212F98
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004934; cv=fail; b=dYj/mUiyFcsRrK+K1kWMrYxG3zYpUP9c2tdOn/oCCQwaaQn6uQswwTwrV0fpUwiuFCcJNl9yE4u02h9S6nCiZjlJsZNPPEqAXps0unyz+t4fujdo7XhVeK2ohA1rEXLmXLaBdpGS6jMN37amLHb60EScrZSY/n6QWDrdNTooPbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004934; c=relaxed/simple;
	bh=AGJV5QLaU22HDN5wXqWyTiH1MtcJ6SvTWQ2CUxd4fZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XDZSAIfmamGOzldNrejU2yflSehAIJX0VNfwYUYenn/k5SnaICfx+cLaEP+nu791F3QsqGM7pBlIKAIzIwWkRNUCBG2K181CtmU8cJikTuHkqSKO8IzwaubIeoSuayf05TMWsGBbKPxJnHIa/JqZ66Dc+I760zYP+s7Vcl+keUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gBdMkh9f; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBdMkh9f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nft/9dte/vfl+jUjOHY8qQgUPwFA8ME8mgsQJt2NZY1O4VCYmKiUb5cLvYt7Hl9+SVKOba3T1/iIxmFVvCVfcF9FOeYMf3ZmGkGLd+puNLv8wQhlfSCKZECnrDDm2yBAeAP8isVhZFByd1WHZUJ08rUsyqAXgmiVvVxwNpuw0Xcfr9CqGHmnItUw1Ckqp2JxKfCHqGKqR3MuG2WxG8S37JcBoSIZAlACL/58ISOb2EO314KCEU41D8t0ODsQ2vx0e7dzMStzXjTiGW74grklC9t1RwfhxhtTue3JsO4SOMQfsWgZ0A4aR3qQBx5Nt9n/GCN9aywZvPhsWH3jo9+jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX7EQHO31H8aEjdoyp/npNoxObXdT3bdwR5blOI//DE=;
 b=Xle1PpiZUiO5QhsJq6C9QNFJ2Ulgyh2L35BtXLpgY8Sia4Cc99Ig8goy3qYY9TmogGTJN443F8C/OMZQGrEtoTqTQ3AhaIPnTurAlAyKjiDQsmWyVB82AKvhWoz8Xqld5GkM30iaNfjPIb6nJgcPP2RF8EtejKFj4FgrZyjRtsGB6g63+ukD6z7SjYF7uJ8lMHQ9sfQzhQyHMf/msHmhBBkItC0BJ5TuMCXhqhW5jHujSLmi9HD74irERYtgFGtrVDtcM6zja3TwnihzafK8OstH2W7ew2EIFusn1lpGwI/eOYkWnzAbAY9hpL4j2XJo5NwzJN9zEVN9X5oIK2n99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX7EQHO31H8aEjdoyp/npNoxObXdT3bdwR5blOI//DE=;
 b=gBdMkh9fWxy6OhYMK0HMdhoVth61EQhJwv/DhC9eytmM7EmIygUHelbl6v+7TgjwHHG9fNWG3c5wpnQ12giU+9S3tyMK8GPInzY/+n1nt2Y9QKPs3Z1RXmVoKmD/9k6CJFcYSbA6vlUmGiONNMysQzDCeHGE6JFUKW81PlHdf7ZaEIhRr+fJ6nnY8C4J2e6PKqQAeUehOToNx9DxmseO4uFmZu15LiGO+Z7QMHE16Maskz6GqA3srxK/Rsu3xGBejva4KsLo5DUeAMBQ4syPSsBtBcsf7BMK9XbxWApCf7vt5R30Ay2wMzjMXCw3DClc37/7g2M36SwlWEaVIHZZ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Mon, 29 Dec
 2025 10:42:07 +0000
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e]) by AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e%6]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 10:42:07 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v3 0/1] Enhanced or Legacy Accept Synchronous Connection Request command
Date: Mon, 29 Dec 2025 16:16:29 +0530
Message-Id: <20251229104630.2734644-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To AS1PR04MB9454.eurprd04.prod.outlook.com
 (2603:10a6:20b:4d9::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9454:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e0b8f3-80d9-48f9-41a8-08de46c6e97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCxfmt3Q+AUug+LByguTC5r+MrpXKJHLzcZpvglDPj+2TnWeALok3fP7qTqH?=
 =?us-ascii?Q?u5LXK2n00ghgiAF/BgB7F0D1t1frrHLmypwZXacdW2z8Rxwk15FRQ2FfXncY?=
 =?us-ascii?Q?60N0qaYodI6TDeCiNb2Hn6NRi0Vj9eI0v3ULbaOMoQF7n/qG4SDJquOUo/jz?=
 =?us-ascii?Q?7vHDJ2x/MvR/JNXWBvyBVts/aSJgnFXTDlos8JUBzQgq26jxHPdfWvhxgsr1?=
 =?us-ascii?Q?pZRKbSaUTp3Lk5tVAQmqrAP68nW7okIp/Cnk3/b8TCWonOtsI1X6+HLnpbnS?=
 =?us-ascii?Q?MVBH8f08XD+S7nt7HFGE+8GpGTcaWpn3YmcUWuIZNQYfkPbX4rCpYMPpco1I?=
 =?us-ascii?Q?0zJEzsay+GF//7ZQEzx4G7/iNuVui/S8k27oCsjEHdLrJogEVmMNIj7SCTHZ?=
 =?us-ascii?Q?NNJcx5EgpRvLqkhM2BQhqW3eU83mSgqPZdJO4H0Nyqbg0Wwa41VD4hdLkEO0?=
 =?us-ascii?Q?dL4mAVEgujUVYr5BSp0RlEKCfwsje4dUBbIwVYlvK3C2Hi0IV9xtxUjRx6jJ?=
 =?us-ascii?Q?7er7cGc9Fs44JAI7xnowQQqp88m+7rKVe3F7RvLFeHhbygUO75t2RY0jBCLX?=
 =?us-ascii?Q?LWbze1s3blzcwYzyzsUNYkSZhCguf3lcmlYsSaN8Qy2XmXUNAjXHlNuWK4Zf?=
 =?us-ascii?Q?oT6Pb5XWhqPY9mZ/VS20OdV4Mbms/+tbo3S0vCZf15BH4UKhQn5t75iFIsDP?=
 =?us-ascii?Q?N6l3g2hLQv2pFdJs+VpQYmxd7A5f0lavA4xg5dnV80TFe5eEDpXKW7e/VBT3?=
 =?us-ascii?Q?h42WTOiSPPAmA4xMPsz1latFgyvt7kEkC5D1XAbWdW6Tpyat900SbYYZN+gE?=
 =?us-ascii?Q?l8aPMfP8Qup3fQX3NouwHp5agH46JDMvR3BxN0OCDyIH7NaF4ojGuB2bwTh8?=
 =?us-ascii?Q?b4NmNo7PwIIWpklve7ntrzGQ0FFZ6K4Udnya/dyxt+tZxb0NV95EugJviOMP?=
 =?us-ascii?Q?glgVQHWVZ+cgjL62/cBmb/VG8cxscQB9VWsdoYBm8uRirPV2yML/DAoa89vw?=
 =?us-ascii?Q?UWJseRkFEvxbuy6/2xGLRaXrehxpkonKesWvaLo6YElC+NINh1T0967fbTGh?=
 =?us-ascii?Q?nh6CxfGWTdvW2wdv+PHEgNaTCfhKiFSMWJvSfrsV6mGOYC70rMNAq7gxT5HT?=
 =?us-ascii?Q?IehGrjHjIv9NnMgUiH0aAPG0C3VM/IMARqTrVGor+F6QQaNg0QQOKyKAWPJd?=
 =?us-ascii?Q?90QeEUP0dG9QlS2igH7s2LLP/GNNDDUL5xR1drKLl9CCC8/JgMOYu43vOKXf?=
 =?us-ascii?Q?mOS17NVOu7R28VPLFCyw3VAG3WIkPYbvvsWUXSXsS+EfdLNa5dYfLMuezpCx?=
 =?us-ascii?Q?IPt2xVq7HuaF7Gb/s/p46ERwM285BSjRQiPVx2jiQ9pdsjngRIS02Kzdi/B+?=
 =?us-ascii?Q?8t0G7r2fG81eyO+7LGrMt46/Fr7Hm/AmMhxrc493cR64nYZlkmphFSwOzI28?=
 =?us-ascii?Q?5/8vjauPFF+L+gMskFJbEd6ddLByCZWKo1Sc1fAGKGpIUN5Hzqw+4AgocV+E?=
 =?us-ascii?Q?ZfkZ8oVA6kZLBLBqh8t2/q1/JH+9J679vryJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9454.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e4p8KznpHsprsf47Fs3Un8LgKPKHLjpLj7jhIdx1RdDbEnzYv7zEP6z9jrUU?=
 =?us-ascii?Q?/1EPK8kwYKZjGvztH80vkr34a6FBSfNF1nNNDLTrlOeTg0wKMkDVzfl079/7?=
 =?us-ascii?Q?GWU58CMwhpZwEErHWfrspHUHkR0A3jwDKqCbBcDOKVETEy4PUIKLahoUi1U8?=
 =?us-ascii?Q?vWXN3dZw6DIP6L+v33j6Jgb8T/wKLqCs4torbDnxAKDJ9ZPps2NpIocf4wEV?=
 =?us-ascii?Q?TwA8YMaBNm6Nu6QHsJ+ZVWe1HVc9GqeX1O6PIWXv7x6GbcpQZi4uwJJk037h?=
 =?us-ascii?Q?hJdiWW/V8HhxTxId+HayL4xpf1RxCxRXuOS7xAVW4/koeg8pUcTqzoZMAJ4x?=
 =?us-ascii?Q?ZMLhROEgBu6YZVFKvsSUA04YvkBy2jcIGA8pzVmFyJP/Hjx2kd36LExPuZz4?=
 =?us-ascii?Q?rumDk5u6vIULrj5Iw/yQ0Syyd6ti1svdS/Bhj32trlMTcsmiCImiMeTXFtZT?=
 =?us-ascii?Q?RRWWbj2/zpBCtHqjZUrLfqnKuTwon0sXBbC01qDqFxrE8TT194ppichNQXwC?=
 =?us-ascii?Q?qEX1k7EYT/cnXSGyxDJZJs+OpT5JbgLxxfL4QC6D84fKNH7lGg5EytmMsu87?=
 =?us-ascii?Q?MztqzcAnkmLkDfPDfkb38B9E6TOQjV4G8VHyJU/CLOu8kgCG9DAISGa4Icf5?=
 =?us-ascii?Q?sf9knEw3IBsP1OR/OTDMByF6iqE7oVSTclC6mUjZL32cKtg50N5FyonV6lF4?=
 =?us-ascii?Q?UJ7TBJoPNk/iz0eP465QspHQZNdTTVAwtZAy46m+v1fwuA+aVub7iufV5dEd?=
 =?us-ascii?Q?VpOdMRNDmHv+JhXqYDtsKNfCR2cxuem98yTyNs1hkV3UgVKQYl3DEkYY79p7?=
 =?us-ascii?Q?dDEsMn0SryWQqxhu5QPlqjSzjFREsA9k2m+EcSF4MQN0Id+9nOCmaYis2dvs?=
 =?us-ascii?Q?Pl+T7XoyAS7IZiVDxC8yOm1H8WGqY9YGEfKiUo4V8fSKovNIQvqY7R5fQAYS?=
 =?us-ascii?Q?t6bpsxXfQY1NIDbdkYrYo/P7jn/oZluAdRNxhFHqWbPOoBH0kKX8wUSxAF2U?=
 =?us-ascii?Q?1tXD78MUq6lWODQqCYL28X088rY0W/vBFt9o6MErASHKRyjFWji/LUK8ESsL?=
 =?us-ascii?Q?yq7gHapwomtSCE33cficzSZgk8I8LdfWqVBo193P3sIYztLPSI3z23+wDIB1?=
 =?us-ascii?Q?GrD+YR1G5EkQpZa33fJp33gXpn4RaEh3gGTEC6rnAcQX3Wjso4hBy7yzcHN0?=
 =?us-ascii?Q?yErFMcXEFQvGevNzrvnyRjWnAeemEdlfWvW17Jd7Mdamymb+dQxGKAyI5j0L?=
 =?us-ascii?Q?smqq2Yg81wB05koActwVQ29APHx58tpVJCf00I32WyIzVWvjuKh0MynbXMLa?=
 =?us-ascii?Q?nzHZOmk1ZT4iXLzFy6H3qKqlwehXGJX7zAKb40oSOTwPJq/DEV+Ip+Mu/QOm?=
 =?us-ascii?Q?fgxxKoFAvqMwfqbQqFJZUU+vbJ+oN+/bBJvan8LEVEO/eQdhAeUXLnXvmv7u?=
 =?us-ascii?Q?QLjia/8yeu8HH38KXyka69Sb6x7qQh7HvxiuerZrgqbGJ/sBNVDWH2CPDvyl?=
 =?us-ascii?Q?L12jy9LTwruGBaTytJIRlaVPXWtjTOSFwgVwYTfEZlcLzwO+SUzPcYCAD2Xr?=
 =?us-ascii?Q?ksefiwF/neawZ2m9ZdWPyPwwzQRo7dAe8HQGZ7u34hD+q+TItMcCUACZld1h?=
 =?us-ascii?Q?K3aqhiKS2TJbb5NTAvjgZW/KonL5ZhWajkGs6P1vnHSg+ks+BinnZoJyHj66?=
 =?us-ascii?Q?k10JvfKjsRTY3yW0V20bErVsFyA8OXpPb6rV6HN+7HgwA55vcImrnv8xJ/NJ?=
 =?us-ascii?Q?Zb/GrguyXA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e0b8f3-80d9-48f9-41a8-08de46c6e97d
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9454.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 10:42:07.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKJbioA5jeUdc6uzQpI/9HUohG/SQI+LTCW9GtU742l/rKxCrEyXStzDIgsmgho+rCHhSsAue+ZstZmpLayQHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

Hello Maintainers,

	In the current implementation, when Connect request for eSco is received,
	Bluez Kernel is sending 'Accept Synchronous Connection Request comand'
	[legacy command], irrespective of whether controller supports 
	enhanced synchronous connection command or not.
	
	In this PR, When Connect request for eSco is received, if controller
	supports enhanced synchronous connection command then it will go for
	'Enhanced Accept Synchronous Connection Request command' or else it will
	go for legacy command['Accept Synchronous Connection Request command'].
	This PR also have a fix for one warning mentioned in the previous PR.
	
Thanks and regards,
Mahesh Vithal Talewad


Mahesh Talewad (1):
  Enhanced or Legacy Accept Synchronous Connection Request command

 include/net/bluetooth/hci.h      | 34 ++++++++++++++
 include/net/bluetooth/hci_sync.h |  9 ++++
 net/bluetooth/hci_event.c        | 27 ++++++-----
 net/bluetooth/hci_sync.c         | 78 ++++++++++++++++++++++++++++++++
 net/bluetooth/sco.c              | 34 ++------------
 5 files changed, 141 insertions(+), 41 deletions(-)

-- 
2.34.1

