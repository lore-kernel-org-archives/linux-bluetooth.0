Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A261879
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004245; cv=fail; b=RgeR/ukgwkAtFPr/oWL8DgzvP0wyHMmUup5nsL/A2V2TeN/F/GydUOiqYMamAfZti/+vW3QwOL0L+GO3FkeGi3+gXjc0wwpk+EHpUANEge5jQfMnK2wMXo7lBaJGJmNYLt9MXUerwkcHFCdhkzD2XR+EWsSbVxbBYQ9MVRgJyBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004245; c=relaxed/simple;
	bh=0OERKtbiQka3xVP6IOS7/79T8yYaix/L2fx8u5DrKLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpZcefvJZk/ufBD5qlPq40CcYygeORcIPM7FFlkmf7co7pIp4eJi5+y3f0GlnxjgKaUjlIdeNjdsTygauMs27C3CjehXZfKizJsipTOT2xYmC8qFGt++tRLm6Jci3zGT8CBSogmGzUFT8SZzrqmeuxuS62+ebnQs+NU7oFXElF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PPotO5/n; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PPotO5/n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEdoXEaBtofQkAEFuolGYhpduUyNzTp9mwOdKLNgwzOHm3Tj3pJlqqBhHE4BjrTLHf4Ff7yz3GIOCD/dZXgm0flWlHnaIKc0xgooX8zCXk8YwW3vam7JMYY1ekwktGf+IKqI4r/HMUGpc6OG9nrIcqO6zz/TrQVzlutso7zCpjdb7u8fYpQji1KqwfP+zyeDPFEz/wtOlGT9bj/GKNfzNppfkSYUetgv2l/m2yPbTIlczlzCz7xHXmhx7JOA8SD2ER6s0wB6rH08ZN8o1yjUYFzSyf/IVxaJF0J7vYmwXt8pGvP2x/8bz98wVNsZXS4bV8oDDD+BSILDttTXE0pGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8uU4F6PFFWqJjzZD9jkKNse/iyUIo37SILQIFJRN9s=;
 b=oQPE55bbsTlKIymGqETQVQHtNSLEKC/mzC+vaIWqkng5qvieENYnWWJSKkpGfr68in4KgAvmw0XoA+cQCF5fGhrGCqXtDXYFcoJo2hkYZjbgObp575HUpO9/JUa+nQsqrYs5qwAe9vmEF23bt1cYbkS0DSVa8wQmhM37MwY0Pz4oPPY4+l84n0l+fy/Y61/moHIyPduKXSKto8OUaXGxp90EtBfphlpvGNiALIh9tevzPHfBRhax9v+qWwj0nR9FG5IcTvFu6xKsSE+LL5QePag8ZgCxAcxZJ9mVPQ/KqJugvmDJetobOxVifw9Ql2KeK0qF7jqScNBMV6x69QgGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8uU4F6PFFWqJjzZD9jkKNse/iyUIo37SILQIFJRN9s=;
 b=PPotO5/nwb+eTHGutoXIS5HA17UG6iPNXGmyayRVQld75VVQ3ly9Ot2Ljz/FSuhgK9bcFow/xNpACbwirSpIDakGkVOvo/rHCqdARLIPo3soXYlYmquXSaGhixm8UwjQdUa9+VnVHngtQBR6kA6CRFoP3eHG8U0wK+OG8X99cug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 07:23:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 07:23:58 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR MBIS tests
Date: Mon, 10 Jun 2024 10:23:55 +0300
Message-Id: <20240610072355.5269-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZL5zp9+ieeVCSsaWQFVw_7qMM21yPNSjH1wV-ANV6Fd8A@mail.gmail.com>
References: <CABBYNZL5zp9+ieeVCSsaWQFVw_7qMM21yPNSjH1wV-ANV6Fd8A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 57779444-963d-494a-7cb0-08dc891e4afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mqUzDnjfw5tF4bsR0yJYwxqXEhPtZvopElJZ/xECCl6R4XVReuHthAkM2FSx?=
 =?us-ascii?Q?wGn1k8k7WZv4wBf0BxWKGZyf9IOi1OzXjPHwz+OgKEdYEBZ/0qejA54ARN+u?=
 =?us-ascii?Q?kgS/OKjAMh4howPWZl/KXkZq5VqKD2bC9IiLoE5E2PWrffOYp400+qy4hfuL?=
 =?us-ascii?Q?ynvkV5okl1DvDkP68bpy37/+F6Xc2lcZmOJiK7Lxol7zNOtJi1LTF09WdeoT?=
 =?us-ascii?Q?QhO4JUSKEl625wUtUxgjEpmtGPbpS3UG1QjJO/e4OyyjZoRWJLnlT0ZZm7Xj?=
 =?us-ascii?Q?fcpdFEErHz2vd7yFYRD5BHJ69iq09TJGR8qkljLOPdY3dQqW6NlXqJS3q6dm?=
 =?us-ascii?Q?uPhyJvU+zdWPeN/0mmutFf9S8q//c5GBW4rKVj7Ar7i4dVCFBJE8YKBI9TDa?=
 =?us-ascii?Q?R0KGx+bmG+fz3/TirBcDcxDRZEF77DWe4AyHKJ38C/sqsdL1HEKbnEwAAQt3?=
 =?us-ascii?Q?iJ/fDdLmfifa8SF9E/CfNfO7KwKo5CSypvldCXfQVGdAp0/RHAWiGFaZqx7e?=
 =?us-ascii?Q?Y9bXTkuY1FGwis2VkdF9s/PEUys2oOF8z4epkil0VzIIjmTqn8USSksx7RW8?=
 =?us-ascii?Q?r/9cbV2YcYWiuQXlWd9vmFw0Hqxs+pkIpnINjHQCN9KNj+xBZ060hf/hzqWi?=
 =?us-ascii?Q?JXpt+YpXYndWnY/UnpuB6W4HWQLgII27N8BRXXa7Id8qHXePwK0yC197pw25?=
 =?us-ascii?Q?VDCWg0uGOr26RIljmqpjX9Z8xj2xRBGd2569CR92DyT6b1SrLU6ldN6qg3QK?=
 =?us-ascii?Q?oYo8tyTTRQgFBsWy7xZrf1MzZgX1EdyfUMIOM9/z1m045SUxOHN1vLFzKhLT?=
 =?us-ascii?Q?VhOJvmqEWMOjUH3g9+AjW0eYwcHPEY0omgCK7b6LABMaz+YCUrw/YH8XfJkU?=
 =?us-ascii?Q?2d5fS17f4nByROg8UwNNErgc+SeZMzTO4X89ApEAthYjOkrj8TrZNO0Tx3iu?=
 =?us-ascii?Q?ZgpxobKlH7gIVSRJJihvT5sgGq3J0doESNGk/oNlekECTifQdiZxuEIxtx+2?=
 =?us-ascii?Q?3R0ysnjdIGjjxEeXHVA+Bz9sMml1HBCY8CJRyJ483yzfVdyvJFVO1YMSHT5M?=
 =?us-ascii?Q?nlKj7NMX2ArVqMvX4yY3fCVgNHIE02ngQxmAwmkrxZi2+vXIX8Vk2Jtw1fhc?=
 =?us-ascii?Q?2NFHaBdS5AoPkhKU39ozCPIKmggIKoVDw+yUW26hOIg8D+x9IeumZRFMz+VL?=
 =?us-ascii?Q?aNd9y7YLWnS7pOxkRz3xdmzySu6kbX5SNxT4S4DnjCLETp2cJtr/BrMHvIOr?=
 =?us-ascii?Q?KlTT0tuwp6TKwPAfiHaPngRhjCWDMnyaJifNth+G+Yd99UUoWXfz1/sIPbW0?=
 =?us-ascii?Q?RNUPMlhByryXHrDfmodtIF+s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/2B/KtWTvjaAWA3AZ6lKGWstATtyDw7gYDzThKm1uLDY8z/LK1y+u0Oq+IAm?=
 =?us-ascii?Q?4XkA8zdwYd0Wz+O3K69iHgp1sb5W/HvDswi/akWxefdkeZ94rpFkGMNHYcD2?=
 =?us-ascii?Q?6dKt94FNC8+ZYcVfn3zj8PNSDrB05kfW8geYoJyx8ctMezjFJNKZNElqPLCa?=
 =?us-ascii?Q?VpQKo6EK98Eau3GpKFlG9xPcn8vGqEwOrMwiLxc1wHxrUAYoCoUMebM5+KUw?=
 =?us-ascii?Q?h5G9p9jtusTQofsSK13zhlK7wwvZHu1SdslyyBifvch5KYJAXJ6+q42IxxZH?=
 =?us-ascii?Q?w9um60Rezh2dq+ng1JkC6cSixR6+lkNTg2YjKMk5IX6Wu1jHuQkFPDKgsDpm?=
 =?us-ascii?Q?YwiwjjiBuTLTPi7DG8MiDGI9qpz/kbMVvzbHxcfEg5gnAtJ4Tecj+wGGx4G4?=
 =?us-ascii?Q?V+CzpVKDbZWY4ujkeSdwgiOdt/QyW+agDsD/RfC7GZU+O0bfS9oDGGhM0le1?=
 =?us-ascii?Q?fOEjRoY74x84NR6Gvo9MXr9oIRK2j+XnexK/DQplwsXeUNc9aNzZ7bwj0Dyh?=
 =?us-ascii?Q?FKCAy73GlgOZFH6FRPEXpA4dlAqjKWBtnHz7XXyK2cdBLVHySuGF7N17SYZt?=
 =?us-ascii?Q?GQ6O9xVSNhtV88k6RptC21lexThD2SHOEuAAVL5DvAJ3MxmtydxB6nzbjk0V?=
 =?us-ascii?Q?GAqcodvI972S2NyuOdxnnE6du4tkf2D6XdnJboujKRSqJ8v3WVjCwejB1w/S?=
 =?us-ascii?Q?ii8TDE+5LnAMl8CE/yu/NrZO57x6tkfYB1zVqV16LMmkr4T1AuLE17wwINzn?=
 =?us-ascii?Q?mL9qAurszDF8Vb0E3CG5g1jEto5RzFL036j5GpkEifcU84fGRNrmPCh4Q87w?=
 =?us-ascii?Q?JjjX+UMtjpDpfVmvBZbt3klVPrtSyNYxAqQql5X5boIBmr5PJfGNlJrMbxqV?=
 =?us-ascii?Q?fV/uHOr3s4uso35i6HaKSnZZDl1Y8pXufvAN9c39KbVCa0f1Z+5CfvdwW8gE?=
 =?us-ascii?Q?7ZovuSwGiu2/qEGFg2Sj3zibzD9Ctb8BIfngeO3F8oHBkN41edFTrkmCStuc?=
 =?us-ascii?Q?2gjbzKhgyTAlwTZOgPXd35ZdheeuVpQ8/o5ZajTsYkqndiB2Dx7eYWEYW3FT?=
 =?us-ascii?Q?nkLP3scPzRJNyKoMP0sZ+rrKouJuWVWrMnQpVobaB9RU5D0L4rA1EbhSpZ7o?=
 =?us-ascii?Q?Aeo7V+EsZvHYY36+mUSFtUI5pwo/adFs/RaYdP/8zhRqMHyxcx29CsT72piJ?=
 =?us-ascii?Q?hiTC9u1KqiZN2V1DtWwlECXJzwwTbvOd4q/B5UCyGoYn2mnNXaiDGekgxpel?=
 =?us-ascii?Q?Ow/HQ9mjZ5K5Q0k12YnhgUgPKe7ultUCNYm5/awOLr7sEnpi7a8+RC+N0jFN?=
 =?us-ascii?Q?CGySWG/89LfbpdXkeZOiXtNgYdNTSE15MCLB/Ax2witOfAOPvkTCEb8jpM+6?=
 =?us-ascii?Q?A84tCQOf8CNPTaQ/K1OJftX4l1kGIOnsl4YdNnfYROy3IHeWxPEcVzZifsUF?=
 =?us-ascii?Q?3SVSGLy7T28nysgds5pdq954lYTQgG5CyicoH2ybtYZMxBbYXehRdz1BuVES?=
 =?us-ascii?Q?lzpYF4g2dhSUfaEK7ec7RBzkDrXZa4VY662Sn35VivxEYibtPQL76AB2g+y6?=
 =?us-ascii?Q?ZmmJqSVsEzHXYJk4P+jplpZPITSk2DVfKC0I5/XvjlwJzajdEoi//6cKV8bp?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57779444-963d-494a-7cb0-08dc891e4afe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 07:23:58.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auWfbOVzaQiepuMdIV52mspSa4SjbSqUAxaoqtXygwhbcPAcLIVPGaSXqf+45Yr60Zge+FU1ucvuFVYO391FKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Thursday, June 6, 2024 11:29 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR
> MBIS tests
> 
> Hi Iulia,
> 
> On Thu, Jun 6, 2024 at 6:26 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > 4.14.3 Broadcast Audio Stream with Multiple BISes - Source
> >
> >      Test Purpose:
> >      Verify that a Broadcast Source IUT can stream multiple
> >      BISes to a Broadcast Sink.
> >
> >      Test Case Configuration:
> >      BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]
> >      BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]
> >      BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1]
> >      BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2]
> >      BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1]
> >      BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2]
> >      BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1]
> >      BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2]
> >      BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1]
> >      BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2]
> >      BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1]
> >      BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2]
> >      BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3]
> >      BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4]
> >      BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5]
> >      BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6]
> >      BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]
> >
> >      Pass verdict:
> >      If the Codec ID is LC3, the IUT sends encoded LC3 audio
> >      data in BIS Data PDUs on each synchronized BIS.
> >
> >      If the Codec ID is a vendor-specific Codec ID, the IUT
> >      sends BIS Data PDUs on each synchronized BIS. The parameters
> >      included in the Codec_Specific_Configuration data are as
> >      defined in TSPX_VS_Codec_Specific_Configuration.
> >
> >      If the Codec ID is LC3, each parameter included in
> >      Codec_Specific_Configuration data is formatted in an LTV
> >      structure with the length, type, and value specified in
> >      Table 4.83.
> >
> > Test Summary
> > ------------
> > BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1] Passed
> > BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2] Passed
> > BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1] Passed
> > BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2] Passed
> > BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1] Passed
> > BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2] Passed
> > BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1] Passed
> > BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2] Passed
> > BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1] Passed
> > BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2] Passed
> > BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1] Passed
> > BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2] Passed
> > BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3] Passed
> > BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4] Passed
> > BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5] Passed
> > BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6] Passed
> > BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]      Passed
> > ---
> >  unit/test-bap.c | 354
> > ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 346 insertions(+), 8 deletions(-)
> >
> > diff --git a/unit/test-bap.c b/unit/test-bap.c index
> > c37f7676f..30c223d16 100644
> > --- a/unit/test-bap.c
> > +++ b/unit/test-bap.c
> > @@ -6972,27 +6972,86 @@ static void test_bsnk_str(void)
> >                 NULL, test_bcast, &cfg_bsnk_str_vs_mbis, IOV_NULL);  }
> >
> > +static void stream_count_config(void *data, void *user_data) {
> > +       struct bt_bap_stream *stream = data;
> > +       uint8_t *streams = user_data;
> > +
> > +       if (bt_bap_stream_get_state(stream) ==
> BT_BAP_STREAM_STATE_CONFIG)
> > +               (*streams)++;
> > +}
> > +
> > +static void stream_count_enabling(void *data, void *user_data) {
> > +       struct bt_bap_stream *stream = data;
> > +       uint8_t *streams = user_data;
> > +
> > +       if (bt_bap_stream_get_state(stream) ==
> BT_BAP_STREAM_STATE_ENABLING)
> > +               (*streams)++;
> > +}
> > +
> > +static void stream_enable(void *data, void *user_data) {
> > +       struct bt_bap_stream *stream = data;
> > +
> > +       bt_bap_stream_enable(stream, true, NULL, NULL, NULL); }
> > +
> > +static void stream_start(void *data, void *user_data) {
> > +       struct bt_bap_stream *stream = data;
> > +
> > +       bt_bap_stream_start(stream, NULL, NULL); }
> > +
> >  static void bsrc_state_str(struct bt_bap_stream *stream, uint8_t old_state,
> >                                 uint8_t new_state, void *user_data)  {
> >         struct test_data *data = user_data;
> > +       uint8_t streams = 0;
> >
> >         switch (new_state) {
> >         case BT_BAP_STREAM_STATE_CONFIG:
> > -               bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
> > +               queue_foreach(data->streams, stream_count_config, &streams);
> > +
> > +               if (streams == data->cfg->streams)
> > +                       /* After all streams have transitioned to CONFIG
> > +                        * state, enable each one.
> > +                        */
> > +                       queue_foreach(data->streams, stream_enable, NULL);
> >                 break;
> >         case BT_BAP_STREAM_STATE_ENABLING:
> > -               data->base = bt_bap_stream_get_base(stream);
> > +               queue_foreach(data->streams, stream_count_enabling,
> &streams);
> >
> > -               g_assert(data->base);
> > -               g_assert(data->base->iov_len == data->cfg->base.iov_len);
> > -               g_assert(memcmp(data->base->iov_base, data->cfg-
> >base.iov_base,
> > -                               data->base->iov_len) == 0);
> > +               if (streams == 1) {
> > +                       /* After the first stream has transitioned to ENABLING
> > +                        * state, bt_bap_stream_get_base will generate the
> > +                        * BASE from all previously configured streams.
> > +                        */
> > +                       data->base = bt_bap_stream_get_base(stream);
> > +
> > +                       g_assert(data->base);
> > +                       g_assert(data->base->iov_len ==
> > +                                       data->cfg->base.iov_len);
> > +                       g_assert(memcmp(data->base->iov_base,
> > +                                       data->cfg->base.iov_base,
> > +                                       data->base->iov_len) == 0);
> > +               }
> >
> > -               bt_bap_stream_start(stream, NULL, NULL);
> > +               if (streams == data->cfg->streams)
> > +                       /* After all streams have transitioned to ENABLING
> > +                        * state, start each one.
> > +                        */
> > +                       queue_foreach(data->streams, stream_start, NULL);
> >                 break;
> >         case BT_BAP_STREAM_STATE_STREAMING:
> > -               tester_test_passed();
> > +               queue_foreach(data->streams, stream_count_streaming,
> &streams);
> > +
> > +               if (streams == data->cfg->streams)
> > +                       /* Test is completed after all streams have transitioned
> > +                        * to STREAMING state.
> > +                        */
> > +                       tester_test_passed();
> >                 break;
> >         }
> >  }
> > @@ -7225,9 +7284,288 @@ static void test_bsrc_str_1b(void)
> >                 NULL, test_bcast, &cfg_bsrc_str_vs, IOV_NULL);
> >  }
> >
> > +#define BASE_LC3_8_1_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_8_1, 0x00, 0x01, 0x00, 0x02, 0x00)
> 
> I wonder if we couldn't define these as part of lc3.h, in fact the
> LC3_CFG looks awful similar to LC3_CONFIG from lc3.h, so perhaps we
> could do just s/LC3_CFG/LC3_CONFIG and add something like LC3_BASE for
> example then rename the existing LC3_BASE to LC3_TYPE(_id), anyway I
> can probably do that myself later after merging this just wanted to
> check first if you thought about that already.

I added LC3_CFG because LC3_CONFIG from lc3.h defines a iovec struct,
while I needed some byte array to include in BASE_LC3. But I do think
it would be useful to add the BASE defines to lc3.h, and they could be
used for iso-tester as well.

> 
> > +static struct test_config cfg_bsrc_str_8_1_mbis = {
> > +       .cc = LC3_CONFIG_8_1,
> > +       .qos = LC3_QOS_8_1_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_8_1_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_8_2_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_8_2, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_8_2_mbis = {
> > +       .cc = LC3_CONFIG_8_2,
> > +       .qos = LC3_QOS_8_2_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_8_2_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_16_1_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_16_1, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_16_1_mbis = {
> > +       .cc = LC3_CONFIG_16_1,
> > +       .qos = LC3_QOS_16_1_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_16_1_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_16_2_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_16_2, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_16_2_mbis = {
> > +       .cc = LC3_CONFIG_16_2,
> > +       .qos = LC3_QOS_16_2_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_16_2_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_24_1_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_24_1, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_24_1_mbis = {
> > +       .cc = LC3_CONFIG_24_1,
> > +       .qos = LC3_QOS_24_1_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_24_1_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_24_2_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_24_2, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_24_2_mbis = {
> > +       .cc = LC3_CONFIG_24_2,
> > +       .qos = LC3_QOS_24_2_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_24_2_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_32_1_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_32_1, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_32_1_mbis = {
> > +       .cc = LC3_CONFIG_32_1,
> > +       .qos = LC3_QOS_32_1_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_32_1_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_32_2_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_32_2, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_32_2_mbis = {
> > +       .cc = LC3_CONFIG_32_2,
> > +       .qos = LC3_QOS_32_2_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_32_2_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_44_1_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_44_1, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_44_1_mbis = {
> > +       .cc = LC3_CONFIG_44_1,
> > +       .qos = LC3_QOS_44_1_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_44_1_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_44_2_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_44_2, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_44_2_mbis = {
> > +       .cc = LC3_CONFIG_44_2,
> > +       .qos = LC3_QOS_44_2_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_44_2_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_48_1_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_1, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_48_1_mbis = {
> > +       .cc = LC3_CONFIG_48_1,
> > +       .qos = LC3_QOS_48_1_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_48_1_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_48_2_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_2, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_48_2_mbis = {
> > +       .cc = LC3_CONFIG_48_2,
> > +       .qos = LC3_QOS_48_2_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_48_2_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_48_3_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_3, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_48_3_mbis = {
> > +       .cc = LC3_CONFIG_48_3,
> > +       .qos = LC3_QOS_48_3_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_48_3_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_48_4_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_4, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_48_4_mbis = {
> > +       .cc = LC3_CONFIG_48_4,
> > +       .qos = LC3_QOS_48_4_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_48_4_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_48_5_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_5, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_48_5_mbis = {
> > +       .cc = LC3_CONFIG_48_5,
> > +       .qos = LC3_QOS_48_5_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_48_5_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_LC3_48_6_MBIS \
> > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_6, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_48_6_mbis = {
> > +       .cc = LC3_CONFIG_48_6,
> > +       .qos = LC3_QOS_48_6_1_B,
> > +       .base = UTIL_IOV_INIT(BASE_LC3_48_6_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .streams = 2,
> > +};
> > +
> > +#define BASE_VS_MBIS \
> > +       BASE(40000, 1, 2, 0xFF, 0x00, 0x00, 0x00, 0x00, \
> > +       VS_CFG, 0x00, 0x01, 0x00, 0x02, 0x00)
> > +
> > +static struct test_config cfg_bsrc_str_vs_mbis = {
> > +       .cc = UTIL_IOV_INIT(VS_CC),
> > +       .qos = QOS_BCAST,
> > +       .base = UTIL_IOV_INIT(BASE_VS_MBIS),
> > +       .src = true,
> > +       .state_func = bsrc_state_str,
> > +       .vs = true,
> > +       .streams = 2,
> > +};
> > +
> > +/* Test Purpose:
> > + * Verify that a Broadcast Source IUT can stream multiple BISes to
> > + * a Broadcast Sink. The verification is performed for each set of
> > + * parameters in turn, as specified in Table 4.82.
> > + *
> > + * Pass verdict:
> > + * If the Codec ID is LC3, the IUT sends encoded LC3 audio data in
> > + * BIS Data PDUs on each synchronized BIS.
> > + *
> > + * If the Codec ID is a vendor-specific Codec ID, the IUT sends BIS
> > + * Data PDUs on each synchronized BIS. The parameters included in the
> > + * Codec_Specific_Configuration data are as defined in
> > + * TSPX_VS_Codec_Specific_Configuration.
> > + *
> > + * If the Codec ID is LC3, each parameter included in
> > + * Codec_Specific_Configuration data is formatted in an LTV structure
> > + * with the length, type, and value specified in Table 4.83.
> > + */
> > +static void test_bsrc_str_2b(void)
> > +{
> > +       define_test("BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]",
> > +               NULL, test_bcast, &cfg_bsrc_str_8_1_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]",
> > +               NULL, test_bcast, &cfg_bsrc_str_8_2_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3
> 16_1]",
> > +               NULL, test_bcast, &cfg_bsrc_str_16_1_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3
> 16_2]",
> > +               NULL, test_bcast, &cfg_bsrc_str_16_2_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3
> 24_1]",
> > +               NULL, test_bcast, &cfg_bsrc_str_24_1_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3
> 24_2]",
> > +               NULL, test_bcast, &cfg_bsrc_str_24_2_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3
> 32_1]",
> > +               NULL, test_bcast, &cfg_bsrc_str_32_1_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3
> 32_2]",
> > +               NULL, test_bcast, &cfg_bsrc_str_32_2_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3
> 44.1_1]",
> > +               NULL, test_bcast, &cfg_bsrc_str_44_1_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3
> 44.1_2]",
> > +               NULL, test_bcast, &cfg_bsrc_str_44_2_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3
> 48_1]",
> > +               NULL, test_bcast, &cfg_bsrc_str_48_1_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3
> 48_2]",
> > +               NULL, test_bcast, &cfg_bsrc_str_48_2_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3
> 48_3]",
> > +               NULL, test_bcast, &cfg_bsrc_str_48_3_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3
> 48_4]",
> > +               NULL, test_bcast, &cfg_bsrc_str_48_4_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3
> 48_5]",
> > +               NULL, test_bcast, &cfg_bsrc_str_48_5_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3
> 48_6]",
> > +               NULL, test_bcast, &cfg_bsrc_str_48_6_mbis, IOV_NULL);
> > +
> > +       define_test("BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]",
> > +               NULL, test_bcast, &cfg_bsrc_str_vs_mbis, IOV_NULL);
> > +}
> > +
> >  static void test_bsrc_str(void)
> >  {
> >         test_bsrc_str_1b();
> > +       test_bsrc_str_2b();
> >  }
> >
> >  int main(int argc, char *argv[])
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz


Regards,
Iulia
