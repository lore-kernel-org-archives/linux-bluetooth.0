Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D8745E4
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288953; cv=fail; b=lGtrj79VBe4z2m4dh9ZInpZtO5NS/40EutLL279rPYH2fowp1OreSXq4LEm9/2f5eUvj3ILv+01PboY6rRCxjKRg4nHlh8sErhb3jQAK0juxLZKLHISxWOONwODjibxSdJuMZgzHZH/YYJACxQjMKiQmlQxVp/H+p6mRgSx3Yfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288953; c=relaxed/simple;
	bh=LctpZPAOhW2LD5JA1j1axMpcHBQ7S3dm1RtKDg6NZpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apX0kUvkvTwx27B01f7ks+f8FoICYo0HkZDnhW7SEj4hPqVNnxTDVwB1TT9rjdFYGNYUyJJhrrWDNH/mHBXX7bZIpHUIVtLua7KAMCdaihUZ6izi9znRpZWD2Rri1EWi+gwAYUYc7T8Ahc1oO7J36M7gqZyOCvrzUVYviykdUVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EoX0O7lV; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EoX0O7lV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZUV5s61LqhuSlPBApn/yTLG+5mgaixAxOCraisa937AmF9kWUKm5qmHlIbwBx6qe9ju8XIJXXE6hwABvGHtvLc+pIWYW7rALfFoclol3tK2NgXyHETtA9QdfrDRKHzCn9Sd2O3DKqED8NhHFq+qvQ0GGOJ0etn9zVI8tgeLGYQeldPzV9BgQrzfFcOiJNDRseGYsnxE6FlHaQEvcimTAfN4xFbuF0nNwEgzHTxcdcLm4mzz/6Asi5idHj6Kd24dm6ndy5oMTV4FmUnqcT3fassTob5Mgl7us0rvnU/bcfIcbhCf3uKbhgLW7l8njP0KAoZ+2fgdompMq71iB5vqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9rb3XzH/iWV0t2gmgwwBgt9c8UBfNFDKcATgvkCWhI=;
 b=QtG7FQ4KQagPTLaJh5/QsUkMElUHArpl+TrzAkszszIztxHbrAEFYvRPuyhev82J+idHpPC77wS0rp3kGXWY46RBObWY+iLrIfv3tqVHCSzqmjlMqb/XhG2Bdi7oup+pZCRjxOIhm4Q6zvjjrPN+0YldPebXd+X4nBgsehFocvC3Nq/Bp8zpk2qA85cVJOOnrW7l4G6nXUQ0fBJq9M4mJuAm5fdCxbGfiigVV3vQ6J7YTOYVWZd/4YHF2K+eGWgrhJkfnw2Uh/0nslTadgkc8lOLilDVLm0OwFSd6AGTq0AnMS9NUmUxuDIIKNNnQIObN8zJv/IigNwcyO0ZBs5fVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9rb3XzH/iWV0t2gmgwwBgt9c8UBfNFDKcATgvkCWhI=;
 b=EoX0O7lVCW7XiSnKdzKQG9VuB1L2uUOY1Yqu1f8FaTTNSTLbdAdLIV+lhppLIAS31CnTJOeQhjdddogc+rdPDcMzocqB4PoNgbrjUbbrztte96c9XVXD4Ecz6amQ75QuVl2RmjrqL6mWENZRQnRoj1B6yoEjSJYxFFu9/jTX338=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10947.eurprd04.prod.outlook.com (2603:10a6:150:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:55:50 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:55:50 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] test-bap: Add Broadcast Sink STR MBIS tests
Date: Tue, 21 May 2024 13:55:15 +0300
Message-Id: <20240521105515.103972-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
References: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:208:1::49) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e495fcc-6cf9-4217-df16-08dc798493b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAvzMm+aLn6fSmYgCVtGx3SoNRElvOHoFdhG4fphAkO17bnl7a9qokewaDW5?=
 =?us-ascii?Q?MlVGkHbTnCaI/+elHw/okastxte8Rr0GOP2olCNALjD7wgtQ1wAkTYsgYta+?=
 =?us-ascii?Q?1pUi6WwmT2BU/STIVRfix/CF1gyLQ5TM7gELIpQYETPePqJsB2avyxC7d7/l?=
 =?us-ascii?Q?9oEhaOoSd6kk5RvYuLpdLnzvRG91Y2mm5VhsBjKNSfBvAv0GngWVicSJ30p+?=
 =?us-ascii?Q?ujXX/JOsDWrNvwNuQFydcbfV7aR240fJ1/+1149s5lmJLcLUhLQdYCTa6LCv?=
 =?us-ascii?Q?qfou/LEQiJoFz8d0B5OtK7BI2+LrAkrrurpsRptv+5YELPXMp3XD9m8soYNt?=
 =?us-ascii?Q?CApbIa8s2tLBVVRVYitnVtME9AYtFpEmTLxhy3HMadCa1lm7c7va4l5oNuqS?=
 =?us-ascii?Q?k2dncXNnUp27TtXotZS7as5CW8OLLY9gLCKBWTygPBLDgDwvW0Y+oWBHa10n?=
 =?us-ascii?Q?Q9CRUn+d7a5KTBbEIFNBnVHksByl2NtiSehTXdoUTSRrzT93e4yesJ5Qvu1L?=
 =?us-ascii?Q?5jqnNnpTTKvRTMAGn2T8ZYGzwmykn+xVV7O6d3Mte3nm55I1Yb6fFQbs2pU3?=
 =?us-ascii?Q?wQCphGGSxMQ4Wg3y2gARtJGkbne4hIy5/fjwsZ7Kwl9ISu6/J/B/px7MhMQi?=
 =?us-ascii?Q?u0Bt0d8h8Z1d6wb3VOajmPAnFD60EXWkKy1ef6mb7XpxaChpOGgtexyD6og4?=
 =?us-ascii?Q?2s1ZJcertqZn7Ah0ja9WqpuqNs5UMHlgnibZAwvJy6JVjbWwxdwSxRS6kJDO?=
 =?us-ascii?Q?K0+vz2WrNzg2y1KB79Ny6emUjQ/5bOP6w2zQOvqro7QaABY/PeLmoouZvI99?=
 =?us-ascii?Q?7pyEr+HpB76uju1gI7TQ4cL7cuoOe45A7XH3M52dMh0ZXMpnkzXP777I3Aws?=
 =?us-ascii?Q?ThOgF2b99JtkHxBLrojX9Yp3KrWfPZjZLI2nKG35PQJMCr98sH0nRcaGkmzL?=
 =?us-ascii?Q?Sx/6S2rvo2ndRBZtuvVy38CUmjLh/deNXxd4WcQzuvkI6yruWJjkS2fmPyXI?=
 =?us-ascii?Q?hB3L2K3N3JTXSfIzqpdGiHR/0V5IJCaly5q68nx0wsPG6gQoAUtVDWfHrpeQ?=
 =?us-ascii?Q?0MFJhoGWfAjDqX9d/eFdIKxcd3pmn01DrcYB42LkDRuKjbatRRXmGt3Zog1o?=
 =?us-ascii?Q?CkONMpWwTSb1MrWx4ZZrj00Mx8hp8wxFI7qFVURVLS/vakEa4tP8PYZhrmCM?=
 =?us-ascii?Q?YZEosnhRkCYyuLYeLprlUczRYyM0CfKO8Hfyb25Aw1PEckMKScLD5vpN++tV?=
 =?us-ascii?Q?7Si/FYXB+IEe/9qxUTaycNGqmwYO2D3ryLzwZ9hm8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sSPUujwfRyY/N9O+KvU/md0bv0EvYJABhj+DfcYHGBx/On0sDZMjx3FrvW3J?=
 =?us-ascii?Q?sIVv2HJmMxAFrRFEKXouSmnDJkU4AaucocyU+RNHVP6/wqiBnpYl1WfeHQul?=
 =?us-ascii?Q?cpBhCLgQP7AnLauIgOxPtlrfKnZg9V0rOEFrL8Et9BwX3bdWH2DI8vpsUveD?=
 =?us-ascii?Q?FCQzYXAbdu9gBaXIu1jSpAHu3uRpMWgnmxfN6JoRnZPVdnSMa6v1V5xDKmJu?=
 =?us-ascii?Q?5HlF/WUmN1lUjH1qjkmYSf46Cl/0MwA3+tPTB3ZRdxCdvA6GRnMDRFv/uzCw?=
 =?us-ascii?Q?7HbJ/YlR71kivcPM3AqOoZ0459B2DGF2s0B86vjGLcfJDW7vKFW98Lmp7fXG?=
 =?us-ascii?Q?AbONgKVaJThAXJ9i58OEQU6C1/1gG//0G8uUW8H6NfPi+cYVeL4sDLyc+IcD?=
 =?us-ascii?Q?ihGr1xYl70yb6VTBe08irkiN4iGyxt7fFRINGAE1oAeN585tikh8I9/SRAz3?=
 =?us-ascii?Q?7bjrzpUU/1E6rRMImEaLaqTZSaPpSUKbw/z/T6xnKRsacvkLW3GjzcxfHai1?=
 =?us-ascii?Q?5q9TrFJoxFmaaGfXvp6R85bGZUcNQnMzcckvKABayv3i7UpNjK9DZcOkJjDw?=
 =?us-ascii?Q?001WzbCjtLMyl4dW5v09RQYIrZKppFm/FzvRj9VfsCtl19xnaVPYqQVXi9fD?=
 =?us-ascii?Q?ASUryOOQjLveNaYFXN/0wvu9+gK0MHO05z3tlKrWWZptN0jQnKB+sOKAJDzL?=
 =?us-ascii?Q?7PUDPp4zNQmapZNspHPphCxJUmnwDtrrzy2cxFB1hRsqFEpAq+n9U9ph803d?=
 =?us-ascii?Q?pa7Mlhbhz/xM390OkK2HSSEPx1YxTBeLLsfFpJFW/c0tMMFeuJB/8de7qMlA?=
 =?us-ascii?Q?i+QkyE8Jx/W/CiRvmRu35/X1QPyUazV2iD6B3dtUaVTkiYHt7M1cPzJSgwr+?=
 =?us-ascii?Q?Pt/m4P6mcWokCfxtO3NxvwoURbHl0Lf5OGK2wg7sbmRRgGtnImtxKeEinvXV?=
 =?us-ascii?Q?8IRjgtbJQ2X6svZcsRUfmzfeec0ygMS65mzxdB6ao9qssqD6oahRyU7gEPtX?=
 =?us-ascii?Q?rmLl6JzO8PvKfIXocJ5m02j39a4r61uemVB5OxJNMHbRKnzlFPyb5idTWf++?=
 =?us-ascii?Q?diA3BTbSD27JEjYoT4dYeN32n4l8pGKvhs20nZzsUDf8B1fmD1BT6pTBL0kz?=
 =?us-ascii?Q?zhwgdGcVzrnghLf6PdbZ6wzlJphXRv7X8L9s3Dk4yzfjCev+KnRW4+DWOZuc?=
 =?us-ascii?Q?Z79Syylog+QjUH1sXgSXJHZ8oxYTqSEbKyg0Gsx03Co/PnYnm0eaPk4cwQ9J?=
 =?us-ascii?Q?fuALEhh8zj4lYCsjxXpnKq+htW2QFXitxMTpKFDBQJ/Kvy/cmGyy8oVsHqdP?=
 =?us-ascii?Q?zyxvsDNkT5UXmVFFlGq8dgB89sqgjq8CaHkm2EyNhQmlR4BzuigpoDrLwDyA?=
 =?us-ascii?Q?6tmCZZFcMlf4NWFYQsq4nPgpneajg3xmAqwNLJlnTE8NyvmsYZzUoa1H94xR?=
 =?us-ascii?Q?xxsdvRsKDlhjsqV+TiatnRCMm0IPc3AmT6FkX9aU9Z9QCWgSy1NuvGo/3II8?=
 =?us-ascii?Q?b8gm5hbbYpv81xhRJ5PatxfmKesktl4dKeJJhaZrGhrwDguuKii6BqlCgQj6?=
 =?us-ascii?Q?tdmWePDyP7nb0vW3E6S8+EfX87AWzYwKEvDb0Ig3Z7UxvjsNfh5ZlqNJHkFV?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e495fcc-6cf9-4217-df16-08dc798493b8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:55:50.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp0S5ESx8FKg0ZhKoCXHg2wM/mkdd+2iPujwj6m+mZlXgZQQYtqz401vhFcou2/6WCW0b9QEWKwAU2pSJOLeUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10947

4.14.4 Broadcast Sink Receives Audio Data Over Multiple BISes (page 193):

    Test Purpose:
    Verify that a Broadcast Sink IUT can receive audio data over
    multiple BISes from a Broadcast Source. The verification is
    performed for each set of parameters in turn.

    Test Case Configuration:
    BAP/BSNK/STR/BV-18-C [BSNK, Multiple BISes, LC3 8_1]
    BAP/BSNK/STR/BV-19-C [BSNK, Multiple BISes, LC3 8_2]
    BAP/BSNK/STR/BV-20-C [BSNK, Multiple BISes, LC3 16_1]
    BAP/BSNK/STR/BV-21-C [BSNK, Multiple BISes, LC3 16_2]
    BAP/BSNK/STR/BV-22-C [BSNK, Multiple BISes, LC3 24_1]
    BAP/BSNK/STR/BV-23-C [BSNK, Multiple BISes, LC3 24_2]
    BAP/BSNK/STR/BV-24-C [BSNK, Multiple BISes, LC3 32_1]
    BAP/BSNK/STR/BV-25-C [BSNK, Multiple BISes, LC3 32_2]
    BAP/BSNK/STR/BV-26-C [BSNK, Multiple BISes, LC3 44.1_1]
    BAP/BSNK/STR/BV-27-C [BSNK, Multiple BISes, LC3 44.1_2]
    BAP/BSNK/STR/BV-28-C [BSNK, Multiple BISes, LC3 48_1]
    BAP/BSNK/STR/BV-29-C [BSNK, Multiple BISes, LC3 48_2]
    BAP/BSNK/STR/BV-30-C [BSNK, Multiple BISes, LC3 48_3]
    BAP/BSNK/STR/BV-31-C [BSNK, Multiple BISes, LC3 48_4]
    BAP/BSNK/STR/BV-32-C [BSNK, Multiple BISes, LC3 48_5]
    BAP/BSNK/STR/BV-33-C [BSNK, Multiple BISes, LC3 48_6]
    BAP/BSNK/STR/BV-34-C [BSNK, Multiple BISes, VS]

    Pass verdict:
    The IUT synchronizes to the Lower Tester (the Link Layer
    receives a BIS Data PDU). The host on the IUT receives an
    LE BIG Sync Established event.

    If the Codec ID is LC3, the IUT receives encoded LC3 audio
    data in BIS Data PDUs on each synchronized BIS. The audio
    data is formatted using the LC3 Media Packet format.

    If the Codec ID is a vendor-specific Codec ID, the IUT receives
    BIS Data PDUs on each synchronized BIS. The parameters included
    in the Codec_Specific_Configuration data are as defined in
    TSPX_VS_Codec_Specific_Configuration.

    If the Codec ID is LC3, each parameter included in
    Codec_Specific_Configuration data is formatted in an LTV structure
    with the length, type, and value specified in Table 4.85.

Test Summary
------------
BAP/BSNK/STR/BV-18-C [BSNK, Multiple BISes, LC3 8_1]    Passed
BAP/BSNK/STR/BV-19-C [BSNK, Multiple BISes, LC3 8_2]    Passed
BAP/BSNK/STR/BV-20-C [BSNK, Multiple BISes, LC3 16_1]   Passed
BAP/BSNK/STR/BV-21-C [BSNK, Multiple BISes, LC3 16_2]   Passed
BAP/BSNK/STR/BV-22-C [BSNK, Multiple BISes, LC3 24_1]   Passed
BAP/BSNK/STR/BV-23-C [BSNK, Multiple BISes, LC3 24_2]   Passed
BAP/BSNK/STR/BV-24-C [BSNK, Multiple BISes, LC3 32_1]   Passed
BAP/BSNK/STR/BV-25-C [BSNK, Multiple BISes, LC3 32_2]   Passed
BAP/BSNK/STR/BV-26-C [BSNK, Multiple BISes, LC3 44.1_1] Passed
BAP/BSNK/STR/BV-27-C [BSNK, Multiple BISes, LC3 44.1_2] Passed
BAP/BSNK/STR/BV-28-C [BSNK, Multiple BISes, LC3 48_1]   Passed
BAP/BSNK/STR/BV-29-C [BSNK, Multiple BISes, LC3 48_2]   Passed
BAP/BSNK/STR/BV-30-C [BSNK, Multiple BISes, LC3 48_3]   Passed
BAP/BSNK/STR/BV-31-C [BSNK, Multiple BISes, LC3 48_4]   Passed
BAP/BSNK/STR/BV-32-C [BSNK, Multiple BISes, LC3 48_5]   Passed
BAP/BSNK/STR/BV-33-C [BSNK, Multiple BISes, LC3 48_6]   Passed
BAP/BSNK/STR/BV-34-C [BSNK, Multiple BISes, VS]         Passed
---
 unit/test-bap.c | 188 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 38a9f5c12..5bbf375cd 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6564,6 +6564,143 @@ static struct test_config cfg_bsnk_str_vs = {
 	.num_str = 1,
 };
 
+static struct test_config cfg_bsnk_str_8_1_mbis = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_8_2_mbis = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_16_1_mbis = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_16_2_mbis = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_24_1_mbis = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_24_2_mbis = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_32_1_mbis = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_32_2_mbis = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_44_1_mbis = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_44_2_mbis = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_48_1_mbis = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_48_2_mbis = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_48_3_mbis = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_48_4_mbis = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_48_5_mbis = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_48_6_mbis = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
+static struct test_config cfg_bsnk_str_vs_mbis = {
+	.cc = UTIL_IOV_INIT(VS_CC),
+	.qos = QOS_BCAST,
+	.snk = true,
+	.vs = true,
+	.state_func = bsnk_state_str,
+	.num_str = 2,
+};
+
 static void test_bsnk_str(void)
 {
 	define_test("BAP/BSNK/STR/BV-01-C [BSNK, LC3 8_1]",
@@ -6616,6 +6753,57 @@ static void test_bsnk_str(void)
 
 	define_test("BAP/BSNK/STR/BV-17-C [BSNK, VS]",
 		NULL, test_bcast, &cfg_bsnk_str_vs, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-18-C [BSNK, Multiple BISes, LC3 8_1]",
+		NULL, test_bcast, &cfg_bsnk_str_8_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-19-C [BSNK, Multiple BISes, LC3 8_2]",
+		NULL, test_bcast, &cfg_bsnk_str_8_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-20-C [BSNK, Multiple BISes, LC3 16_1]",
+		NULL, test_bcast, &cfg_bsnk_str_16_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-21-C [BSNK, Multiple BISes, LC3 16_2]",
+		NULL, test_bcast, &cfg_bsnk_str_16_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-22-C [BSNK, Multiple BISes, LC3 24_1]",
+		NULL, test_bcast, &cfg_bsnk_str_24_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-23-C [BSNK, Multiple BISes, LC3 24_2]",
+		NULL, test_bcast, &cfg_bsnk_str_24_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-24-C [BSNK, Multiple BISes, LC3 32_1]",
+		NULL, test_bcast, &cfg_bsnk_str_32_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-25-C [BSNK, Multiple BISes, LC3 32_2]",
+		NULL, test_bcast, &cfg_bsnk_str_32_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-26-C [BSNK, Multiple BISes, LC3 44.1_1]",
+		NULL, test_bcast, &cfg_bsnk_str_44_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-27-C [BSNK, Multiple BISes, LC3 44.1_2]",
+		NULL, test_bcast, &cfg_bsnk_str_44_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-28-C [BSNK, Multiple BISes, LC3 48_1]",
+		NULL, test_bcast, &cfg_bsnk_str_48_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-29-C [BSNK, Multiple BISes, LC3 48_2]",
+		NULL, test_bcast, &cfg_bsnk_str_48_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-30-C [BSNK, Multiple BISes, LC3 48_3]",
+		NULL, test_bcast, &cfg_bsnk_str_48_3_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-31-C [BSNK, Multiple BISes, LC3 48_4]",
+		NULL, test_bcast, &cfg_bsnk_str_48_4_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-32-C [BSNK, Multiple BISes, LC3 48_5]",
+		NULL, test_bcast, &cfg_bsnk_str_48_5_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-33-C [BSNK, Multiple BISes, LC3 48_6]",
+		NULL, test_bcast, &cfg_bsnk_str_48_6_mbis, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-34-C [BSNK, Multiple BISes, VS]",
+		NULL, test_bcast, &cfg_bsnk_str_vs_mbis, IOV_NULL);
 }
 
 int main(int argc, char *argv[])
-- 
2.39.2

