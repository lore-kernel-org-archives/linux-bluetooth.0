Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA36EEAA
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854168; cv=fail; b=qpqC5+4VtVz4GbwjO0HCbUmJiFgiTC7XGtjxtknxo6bPIhkQyYmD+x0A/HinYXHZqRj7G8bJkMU4P5X5iAA8C39PCjipB2bf9vbC1xx6Om+gQ9dLXy/oZlaAaOk+4rfHNQZwSloer1IIwtc/D+zh2rVbrydiOT4Q1Zfd9Wk8rKI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854168; c=relaxed/simple;
	bh=NgHInzH6kxotcPI1dkT0ek8H88YTVQfH3Sg4E7lv+MA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OUsINKxLqrA6ZtqSFFGMt+AgLK70cCG9UF+P0te2iVjwBObcmnCEdviMcfC+Duh9vJ34HBwpH+0v7FcDlYtwS+OmGVy0PJI/FI8RT1bUPGjTdW1WxqDHYuRvC4fucGGu9mjhNl9J5srFPTQIznE8zYAmH29OQ2U01C0YARNBnGc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=apextoolgroup.com; spf=pass smtp.mailfrom=apextoolgroup.com; dkim=pass (1024-bit key) header.d=apextoolgroup.com header.i=@apextoolgroup.com header.b=UQRyc8y/; dkim=pass (1024-bit key) header.d=apextoolgroup.com header.i=@apextoolgroup.com header.b=UQRyc8y/; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=apextoolgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apextoolgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apextoolgroup.com header.i=@apextoolgroup.com header.b="UQRyc8y/";
	dkim=pass (1024-bit key) header.d=apextoolgroup.com header.i=@apextoolgroup.com header.b="UQRyc8y/"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fZYF2vFvmpPCgkkpobvn4FWgfJ4PzSbxCVMP5qhBN0c+1RiwJ/bkaeTzEmAN4x1YeRzg542mI2wQFZ41Sa1eiW7degac/uJ5sOG1/YWi5+0wJzAgXgJhVvzAeRl9h+lRVy3NRREEpwuo7JAXXRXLpQTo6xRvwk7HcgHuG4xH1aUGUZkZme5AxeANg71D1Vjf4JvqADtP+ZvlXBo1u5So5qS8TUkZlhDRhk091NU9XgIBqO82Z6cVWernx772RKzusAPraaCR/UW+uBiP5WzsG6ZQ6YDWjJutZH3rUBlIgIapGdfdZJuwc7tRwKwGp4dwMUIm9iPUgOw5ZZCpo9jGWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgHInzH6kxotcPI1dkT0ek8H88YTVQfH3Sg4E7lv+MA=;
 b=y7DARIjmBT86qDoN00k7s4EKHGPO1MVjtvEdTOeoBXs3FMS4i/FazPC7V1HeayyOgsUi0Yx80AWH+nbw/49s+KmYiYQJpJfvDbmUpeuBIPF8Bk3QDfqxhbNRERjt8qAL07xM9WMrzROnwdD/j/lE+hWodLrhEye22doxGABcWuxHHHSD/fE5hyQa9n/hIGWRVRvYICdIzISTrRrRaYpNiRoxcHDOZeiq+47wb7r5G+8ncesfVfNRMzVvdsgJGgNEarIOxn+VGzcEvuOrZLT8+Zh9gzOU8y5IsfdWGTsZTJ8RolxCqmPGM03Jm01w3XWfyaS05d8ZPlzWlamj+MLCIQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.209.35.28) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=apextoolgroup.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=apextoolgroup.com; dkim=pass (signature was verified)
 header.d=apextoolgroup.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=apextoolgroup.com]
 dkim=[1,1,header.d=apextoolgroup.com]
 dmarc=[1,1,header.from=apextoolgroup.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apextoolgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHInzH6kxotcPI1dkT0ek8H88YTVQfH3Sg4E7lv+MA=;
 b=UQRyc8y/j5lrUc5oKlzyEfJoKpP/yQscad/m+v7OjP4B47stmMQ8cSLDrDPaGxZ1TvKoRexSyYB73oMLJzuN3QJJyDmCDwVYdCTl0sowp2mfqPgmMTU+XQGDkfKmkwUbe9cgSudPzqdYpqzG4NBaT9Oc9IDYXZBljFNxiJivsaQ=
Received: from DS7PR05CA0056.namprd05.prod.outlook.com (2603:10b6:8:2f::17) by
 CH3PR18MB6118.namprd18.prod.outlook.com (2603:10b6:610:1e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 15:29:19 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::24) by DS7PR05CA0056.outlook.office365.com
 (2603:10b6:8:2f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Mon,
 28 Apr 2025 15:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.209.35.28) smtp.mailfrom=apextoolgroup.com; dkim=pass (signature was
 verified) header.d=apextoolgroup.com;dmarc=pass action=none
 header.from=apextoolgroup.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 apextoolgroup.com discourages use of 104.209.35.28 as permitted sender)
Received: from us2.smtp.exclaimer.net (104.209.35.28) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:29:18 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
	 by us2.smtp.exclaimer.net (104.209.35.28) with Exclaimer Signature Manager
	 ESMTP Proxy us2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Mon, 28 Apr 2025 15:29:19
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 27910152
X-ExclaimerImprintLatency: 510165
X-ExclaimerImprintAction: 1c7ea8f0e67f4edba62ca312e5f4eecb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfCZUdCiizxkuzBod0zUiw6HgLTW1l2UNfmPT9cq9L9UAqCcvLyYylRDiKFlRs7fF1uNiAvx4tbQjaN2l7DRfIv43A8KtTutl5f94vu0GcPuey4cuUYQ7eVxEaq3Ea4GrS8zbCAihzgKassHrONQT/uv8gZ2wk2L2fMsXU6inMMJq1zihY9X/MT/uUe1B+lns9UUy589L3qAcEwZK2Fgp/FNXo1SU38dBMHs8w0XgLsqgknBMr/qIfJclryMjW+sFYIszYKUkY2jMEYhiiULpmhSlQ1JVbI3CAVVMynT91i8p+1JrZKh9Kl2a5carc187jFGl1vcvRTsGsKrL7bmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgHInzH6kxotcPI1dkT0ek8H88YTVQfH3Sg4E7lv+MA=;
 b=NX9oEfTNJjb5eaLs66K33HOF6BnpXnQ2PyUdy+a3RpcaS3at8laNgLBNQMVNlCKBty3oGCtTk6l8c7G6FgskFFs8whKf3LDyDe48CaQBZbHA25KK9hoaNlVdKhbGMC2a5LlfQ4DDivSXuKvVZtSSxhU+YDGHyRRQeST0ADNYPJHD1bonfBIRqSbZJoXi9pqDFMrCtEupFDj/HQfzKjZ4DfiV/HwJdw8bqKVdE4UJAGr8NrzhbHDNKTcCE/jEDUPCto+tC2MNSvuhNKj5AO9XiiPpQZAtI27YEwGfD7NKRZc7QxoyUWy9x72tVkjoJ82fvXCLXx1vCjpQ1Mws59hP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=apextoolgroup.com; dmarc=pass action=none
 header.from=apextoolgroup.com; dkim=pass header.d=apextoolgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apextoolgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHInzH6kxotcPI1dkT0ek8H88YTVQfH3Sg4E7lv+MA=;
 b=UQRyc8y/j5lrUc5oKlzyEfJoKpP/yQscad/m+v7OjP4B47stmMQ8cSLDrDPaGxZ1TvKoRexSyYB73oMLJzuN3QJJyDmCDwVYdCTl0sowp2mfqPgmMTU+XQGDkfKmkwUbe9cgSudPzqdYpqzG4NBaT9Oc9IDYXZBljFNxiJivsaQ=
Received: from SN7PR18MB4031.namprd18.prod.outlook.com (2603:10b6:806:105::14)
 by LV8PR18MB6080.namprd18.prod.outlook.com (2603:10b6:408:233::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 15:29:11 +0000
Received: from SN7PR18MB4031.namprd18.prod.outlook.com
 ([fe80::8fee:e497:9c4c:589e]) by SN7PR18MB4031.namprd18.prod.outlook.com
 ([fe80::8fee:e497:9c4c:589e%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:29:11 +0000
From: "Saleem, Shehzad" <Shehzad.Saleem@apextoolgroup.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: Probable Issue with Bluez (v4.101) in a NAP with multiple Slaves
Thread-Topic: Probable Issue with Bluez (v4.101) in a NAP with multiple Slaves
Thread-Index: AQHbtgBIVvfnZh30t0CdaO7SkT9jYbO5OFDk
Date: Mon, 28 Apr 2025 15:29:11 +0000
Message-ID:
 <SN7PR18MB40314EE37FD65272BB1AA95F8A812@SN7PR18MB4031.namprd18.prod.outlook.com>
References:
 <SN7PR18MB4031DF00C9F7AB89946AB3A58A842@SN7PR18MB4031.namprd18.prod.outlook.com>
In-Reply-To:
 <SN7PR18MB4031DF00C9F7AB89946AB3A58A842@SN7PR18MB4031.namprd18.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=apextoolgroup.com;
x-ms-traffictypediagnostic:
	SN7PR18MB4031:EE_|LV8PR18MB6080:EE_|SA2PEPF00003F62:EE_|CH3PR18MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f96b0f-e782-4094-39d5-08dd86697187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?Bm0F+9jmndsPc2oVnlTT00YrdouDNgfcqbVns02x77DAVg1Q9grmSczdgF?=
 =?iso-8859-1?Q?KQAPtrOffsw3UUn3EvxgVJNfiXRwSC/yhK05h7+ku0d4Rkp5AMvxplF5CY?=
 =?iso-8859-1?Q?A742NViuaqllZ+sxEXIPy4e1hwnfcUEGledDAK0Orsn21bmGuIZ53GzSMW?=
 =?iso-8859-1?Q?eJY0BNlqOjX+hs5iLcruOW1DLN1ceskHe2wjy2pEa0ndPV8xXlcv7YZDEN?=
 =?iso-8859-1?Q?B7uGMJQLO0OmAwRlwJ6ogUSjvdxMZqMEja0QDqo8lG9tp4DzuldwBWeuUd?=
 =?iso-8859-1?Q?ROkA5rRHTZpEQybEkX1uZDNjX3oS7TPWZCHlFS5rxLgDm2/lpvDZB+sQJw?=
 =?iso-8859-1?Q?MPXXSFvvJAr/NP94nQ2UFEvILp682ttOYzehMmcbyuBrJL1m3DqjX3ele3?=
 =?iso-8859-1?Q?aChybLwO1SC4MwwghnPc3HfddZsNm5AMEnLID8cq2sBP0jLHS1vfLY8vVJ?=
 =?iso-8859-1?Q?9GhB+TE1sOetWAna6GR0XA8Ht/9D7XggD4iD1x8olK7FmLQY8b8WF8wAU2?=
 =?iso-8859-1?Q?R7q2tdE+u7HVHF+8nZi/sT5kuNgcZ1XdVycTBKD+tbsxj8GjpxWMVhdtSc?=
 =?iso-8859-1?Q?lBy8T02aVAv7gY3xCCvniG0EpFvcXCcVtERvcubZD6siBJJYzu2LmnPB43?=
 =?iso-8859-1?Q?3TCLQgSGxoG8QGQfy+YsNSnjoVhkNE29qV9XIADorWx2k4HuA34FaXYoI1?=
 =?iso-8859-1?Q?bZ42ufVRerNk1T9J2n5txKguWhJErZimIiZtf9xFcJ9QOJ0BS1/UiMRzq2?=
 =?iso-8859-1?Q?Nm2HCKeSege0ITu0Nj62moDUFvucpKPojpz1g5anQTvDE+bLfH0vXJKcBi?=
 =?iso-8859-1?Q?ihIw8Or0fEgaDmU/ftLbWwq4WJmqu+jwfhyvzZ3w3ZH8GtjBBDhRo3WZ6G?=
 =?iso-8859-1?Q?+ltmbS1D9kk+SORnro0pHINgcxHBa8KbJG6iVWTYHK+ROBl3N5XIFK7sdT?=
 =?iso-8859-1?Q?UgH9Eu3PPRdOVgzd30cwlOvdJu4+6ttUmrFQP5KEtlF3GO4qKuf6zEMtrh?=
 =?iso-8859-1?Q?C1LXdgAlhGyw/gM7dvTRwKHcw8sHMUTsLxsNScPpQ3seU1kq2FND0h4ckF?=
 =?iso-8859-1?Q?xKVR2n+GOoKDX2M6+8rJzYbwHrNP/9V05jyaPz83AxPjbIh3Am95QLz5ex?=
 =?iso-8859-1?Q?LAnoaQyD0hIskSeFaL8OU09oTYE7DnNg/HYjQ0qsrsnHKm2nuI4RNHz2Vx?=
 =?iso-8859-1?Q?39J1O5eD5jUM8qmXK27kLe3qRGt+7ZlqNvr66cSDVi7VML027w4F+f6oiM?=
 =?iso-8859-1?Q?UoLrAzErx76TVC+0hc6SqtolJ305SDPBDw1WFcb6P7knG108evg+YLe8HL?=
 =?iso-8859-1?Q?gebIJv5oxIJMNGtA9f+mlycWKFLiYDwKb6vIsRW0S9ByMH21+KRYHGmBFz?=
 =?iso-8859-1?Q?MDEAEaYkuUkoMc0LK23nNhYHiHCCKG6TXXLEQ2g4qxi4YeN8odKpmgZmyv?=
 =?iso-8859-1?Q?9pVGeNU9mDUUG/h7nz+mgkRKVwkm5a1IbRU5qBiu/1OTYYAhfRcX9WW8sa?=
 =?iso-8859-1?Q?/blZH7cYD73dRsNAiNh3xJq7YhNdvwbLt8AOYi5ioaMQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB4031.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6080
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2bdc9f3b-6683-43b8-e886-08dd86696ccd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|376014|14060799003|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?t4nyd1LEleZsuAeI5nEfgE3Q9KotQYbB51/z3eFmM4Nc5cXnddJEtQqqDp?=
 =?iso-8859-1?Q?BYI8lid1rI7nukuuW37ZQMEYfVicnf7RKLX2fcO7oYXj8Qx61Q/eN1MMaf?=
 =?iso-8859-1?Q?5dLpHnWnqLpDHkeJgqT4iVIBikkG/wahXHGTT6Nu4Rrx/qHPUskWnxkd1r?=
 =?iso-8859-1?Q?VO5Z+YLvGCm7L7XJGorqKFhDigsJ/6RUsO4qDoTknYEHB3oaZA4/fUSjHz?=
 =?iso-8859-1?Q?NjoeHMk3y346Wwwbel6D+9lnVNaaSoe2T+F4+1MSKo6TNWe4ZCqCBF3K9c?=
 =?iso-8859-1?Q?ooSA+2ktDxFbeiuEIcmBt1kbXAaz/NmciYJYNvcEou9bAh0i4bj1Swfl4W?=
 =?iso-8859-1?Q?+9vwv3/FyteUl4GlNmUDkRNyfHJS1CMW083ZnP9WsVYEhIjiGt5K4FGpGC?=
 =?iso-8859-1?Q?RfbxiAPIj6Js/oBRbvykDMgq22050Jg/LIJUtmRN4zb8UDg11NOqxybWGF?=
 =?iso-8859-1?Q?CzoylY4qaruAZ7By/OLnSR1QcZxSr+ipOxoEK8pdUR3/z9gTu1qaGVfDJa?=
 =?iso-8859-1?Q?g7SmmnjR++KbXI84r0em9OH1eifMjAqorgd+VHg4VmFVEiAN/0+2pehn2S?=
 =?iso-8859-1?Q?w3Jq40gdBEEpjBrDEn0ue0dLKxaN7sFOELOXawi5tn0N6kMpodbaGypCGK?=
 =?iso-8859-1?Q?4FQ68hah/MWEO7LJWgVeeM8U2FvsXlJy8HCos32JqPkW4C/eBahF9FtqlK?=
 =?iso-8859-1?Q?isXuAXpLwwYdVZ1n/I5d1I0OUszdB0Pg/tdREnoh0V2LYfx6T5EuuUP3wq?=
 =?iso-8859-1?Q?1DYDcowfkZPqcSy9MFxf1pu/PnVkwhmJVMvmWSPnhgLWdZuyUam3CZQJR2?=
 =?iso-8859-1?Q?qVlHlZvfLF5t8LbAs9hmZa0Us5U2K5MrBqk7wBBQGmcooZnGxiUZtrdPDj?=
 =?iso-8859-1?Q?NR/PYrCxhRo1vmEuvM1qEbqOjjnWj8hfoITncRL06XG7kah7b9xqldPmt2?=
 =?iso-8859-1?Q?LVxUrVAKVLLJn5ozycBKFJW630H17yvl3YpYdOuMzzU+LsLUN6lvsqPQEg?=
 =?iso-8859-1?Q?u/xQ6mpwbtuXNMyJlUQIk7E+RtVS1hKvdPd8PsajyrNlhANByOxZvKccJM?=
 =?iso-8859-1?Q?aXGWad5tU/rbrNbStfeEKiTC7thc1X4orwixHWYu4NWCiQP99/E2hll9J2?=
 =?iso-8859-1?Q?b42Bto6XTVjjpabhVAKjSrxR8fQ6v3ccPZyXaPp1UOF73sR1y3+pRNNsKO?=
 =?iso-8859-1?Q?4lI5yHVstW/tQ4k6BR092l6/X/xyaUeDi0HTDM0Gx6o7TrBaC81nrJhcUH?=
 =?iso-8859-1?Q?T0DaqaMwM7VqRYH5R7uk1I9sfaVGRXZwdlDU5QxpRhnFwEDWliB5F2PUjG?=
 =?iso-8859-1?Q?fvr1WKbnW4qVQvkFt7w+XEhEDfW5hvmzhmf1IwPEtcC9J6771Joq6u6Ecc?=
 =?iso-8859-1?Q?8inAkRvvd4jDoqEA1cT1HauauS1rBWWxY3rubmPCNUv5NyPR8JNT2TUcpK?=
 =?iso-8859-1?Q?DNxEi39M2wZo2xcLLeGjW+Au2kKsHq82eLm6vqlxfupmQGdvdk5VFA368W?=
 =?iso-8859-1?Q?7BpSN6V5ahJtFbPpB4ps6D2+mGGG2zkqjHSmY/25sroAaMJCVgURpnYM0W?=
 =?iso-8859-1?Q?uGI2qQJy+AMmD3XOeEacY7MKz56M?=
X-Forefront-Antispam-Report:
	CIP:104.209.35.28;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:us2.smtp.exclaimer.net;PTR:us2.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(376014)(14060799003)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: apextoolgroup.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:29:18.8367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f96b0f-e782-4094-39d5-08dd86697187
X-MS-Exchange-CrossTenant-Id: 231bbb7c-1b4b-43dc-bcb5-c40e5f722be5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=231bbb7c-1b4b-43dc-bcb5-c40e5f722be5;Ip=[104.209.35.28];Helo=[us2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6118

Hello,=0A=
=0A=
Setup:=0A=
Master as a NAP in a bridge configuration.=0A=
2x slaves connected=0A=
Master & Slaves with Linux Kernel v5.10.109=0A=
Bluez version 4.101=0A=
Bluetooth BR/EDR=0A=
NAP using default settings of bt-network=0A=
=0A=
the data transfer rate goes extremely slow ~100kbit/s (2x slaves) as compar=
ed to ~700kbit/s with 1x Slaves connected.=0A=
What could be a reason for this and is there a way to improve it?=0A=
=0A=
BR,=0A=
Shehzad=0A=
