Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FBC126F06
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497215; cv=fail; b=jPLf3WbShFd+lWWfnWI0277HRDAAAYcpxf+78uhO/0o7ItRMkzFTUbhpMAyMCyVqd5qSRxKU67yBB+P8zNEVsWIipBwjWXOvxy3HehqVRx9+tC7BAL9W62leYQOrzGlPR7VsJvsf9uMkCQ0ArT6QOpTLxkRwaMtv7Q9WbNKU5A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497215; c=relaxed/simple;
	bh=bBi5mN66fkTzjuhyXVL8Nq50saerbfEEFcjF6jbmP8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppWzKjE4fqEF08vj87pN816C5EdmsUtmhInDisy2WAJibOQERDn/WuV6MOPxzLeSwwDzlLVKIV2QfHzw8PKwbYaeUWfwJKO/L0jDn/mUNS8ZotZb3qUURICi5Au+wFHiQZgMnCsnHtqR64BIxhkhH5BN6Nc4UXv00qrm2b/oRhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UKgROV/z; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKgROV/z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY+redvzZALpVCjRw6dgpVVfp/eLXLmHYGBBTCY/sbOmisOtVJVx7cUtF3QscCnSJ/0Ofd/cX+ZSWAOaPCWn99QU18c5ib0vbAI6ndJO/RIatuqa4mqt8IHauShPzE4Tho8MBD+8t/684S87+6b6mJhPz4y9fncJsqKOimOQ8GNVM9upTpavITZrlFs7gjyd8yHOJ43orHAMMpgDQ9B6PwAIWRCn6FWfJX0yNmOEyK+KXiJEmAo+8N4zCFQ1acemDYSjDeL7mEdjMT+o4qVbZb3emPPrdhFe+hoBctNCYAWDyYWJX70LnbFW51AaP7a0YIx6VFcqTkY+YOihqgQuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HuAAlUU+zSyLx2bY5+syPkkfHG5MJ3Z2no3alS9v44=;
 b=jHJppixAW1oxiy10fCquZ4jdDiztUxI/pjHZOZZUZVuJmZg8CUOo/0DatkWvFRGzPqI2laNZyHTjdnI/H/QImiv3+p/K+u+P7pM6x0jJHwtU3w05YqOAOKa4OujUshKQHxpIYeea4C4HAZxd+Tc7z6pMdLIQV76Klrpi10eOc2rRWUdxrBE6xmk/Ooa/GdN27SQgTAz0e5k0qzR8xjhJ5ZSCrrxJDtFdSQSbTM/rcKs5TpzwYabepS39k4Pj3AmLceKgFJkoCU3EHmioX9OfGNUZvulbRtclxtHUpipvG3So5Lzjpdz74H5q1PZUsaOk7OgzneJSOkuwJEJUd0Sv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HuAAlUU+zSyLx2bY5+syPkkfHG5MJ3Z2no3alS9v44=;
 b=UKgROV/zBW38v5uQeM/MtGDpRct0Uk8jo0ac5mLcGkZobzPHfyD5wJseJc7K7KvfVcnsJ/6boRf34GZzQ0PTAUxfu+wXexThYGaHTOEeJhrROxKk2w4x7BDPBj6pyDhPDqELSW0N9yq1nxsfBz9V2TXT6ss+9p3E44YrSPOXMw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 16:46:42 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 16:46:42 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v2 6/6] shared/bap: Remove stream double configuration
Date: Fri,  9 Feb 2024 18:46:30 +0200
Message-Id: <20240209164630.92208-7-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0009.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::12) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb08887-e1d5-4b19-5c54-08dc298eb1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vWMS7GQ3M/hbcIiwjb1w83NCMvHjRK4dw8dpN9Wok85WxpkOkyySAzqJwDjPMYY+IPp8tf9srMzKK7xyZjatu16n++33sSqkcAE3Vuy2W3/kU8i+Js7oJI8PjsCOo5rfgLFxErRsLo3rgcO0XkeGOAJKzi7eZyqLXJkrRfnJnmfz4oIVQTM4l5I75ZlqkoZtuVpP7uyMt0Bf34EIhu/Hj2x0HPUiaX1GEZwmnLfeFZJmPHfc1AZ3o26snWLILsWw3UMDv+eFAEIg23809OuZY87GR3Swa0rzZDyolMacrWp9hYn/4Se1TvOX0qcWKky5eRca0GasbNQ4ZQSn49RbNeaM7GlI5RqSfszwG7a7Nfnz+qH3l44RgHarBd8BzaM4KkQA9WXBpcmV/TD1AjPbIchz4eNJIfvv7EC0YCyTFyBMX26hLTI/zNt9cHxoGFWi1mzznOEBLA5UBxYCvSMX6vnD84KhS+K5D6mkPdYdo90Sjr1GocysxSdUYC85oDQHnLW3niL9Xu6nW13jjFPVAqjcn2oFhoA2mQsQIuP2E69YNIzgOM5IcNIUQDFrEEub
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4326008)(4744005)(5660300002)(6916009)(66556008)(66946007)(8676002)(66476007)(8936002)(44832011)(2906002)(83380400001)(26005)(36756003)(86362001)(38100700002)(1076003)(6666004)(316002)(478600001)(41300700001)(6486002)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QwV5NfnmEFWHNtTQbA+cOpg4hB9RgX8fMGPe8VPX07JPusoY1T6y6Y4Bbptp?=
 =?us-ascii?Q?Abnrg7LdF6/VIcAhbeV606EScU0llzJefPDhd0Cq2BCnDchq6mn4Fund++3m?=
 =?us-ascii?Q?GOGbWjPhqKMfCo2DTFBc/Bk2plT3f0OtGNER0PwWNP/0BBtEF+ASnN43DfmG?=
 =?us-ascii?Q?bslfCj1r+CFPbmsEisQ9tUY9mf9bZO8b/mDccqEkoa/EGNMm7uEB6K4Wrf4z?=
 =?us-ascii?Q?eXQNO7UAFkONcUDJTPMCkIUgQKT/9PNKze8hWU0ytJkpwvHih9rh0nRfhmbL?=
 =?us-ascii?Q?u7H76Be/+tQpI3OSZx00Ln2/15dQSbzBkTII3DABQj2LX5YZqmE1dJg7chx2?=
 =?us-ascii?Q?VIW50H23vJG8aaCNIQ0Oq/nAFVT7bdiOEKhzGlM21GNdL/19twXsLVksgq+w?=
 =?us-ascii?Q?zaJWpQCZuNwP567xFEriFR8J9IWKGXNQlqzs+PSR1Y7AmS5N2eYIKY+f4pSt?=
 =?us-ascii?Q?R9PP6c30wKBfRuQudBVtdQMIUye3k1fXVJPvU0eEHgfzWfpTpg18eevyMCdQ?=
 =?us-ascii?Q?ExA6xwWRZhAd6EkW2wrSFq0YsXqamkHwfIt4SxJpJGZgRIeCPHFo3zCQewwA?=
 =?us-ascii?Q?dcIFc8aOyC1R6qu8CjCct14fFQGxfG0zZlQSn0cjU1z2pTzmAaSic5rHRFjs?=
 =?us-ascii?Q?QwqsvpctXEZnCzej/DMhVlulLzW4tdB26m57+gUcTzzvXsf/fvopFllhx2mS?=
 =?us-ascii?Q?guwuRFRQIISO3E8Tl1XqTxzdRe3UyZOyfU2l56rrDDbuknwdbuPSo2Q2gSyA?=
 =?us-ascii?Q?4cp1sVoaOuSaiyS8vuFAaiIzdOeAh9Ht2Df3OYwaA1M2KYEKOnhiO+p62dk8?=
 =?us-ascii?Q?sWfDBbbgDovfoW2NjxBIyktQ/lMw+sOu+kKOAIje5XjHb3GpTrwRByk7uRrZ?=
 =?us-ascii?Q?9fMXLcUYkTS24Zdh3sB52bcq8SfktTyyeq4mrMEPPM8bs4ugQcb1v2Nib5Ym?=
 =?us-ascii?Q?mQ7S6zByZUw2AQPiU7vufFpjclP5z2qhTFYVX+yRBlOxDuNpzAWduT7L2Q2T?=
 =?us-ascii?Q?f6ntDL2YNImqBTQmce1TDVB1hUavtN+zMsGGyGQlYnDLU+YxnnB/Og68YtEN?=
 =?us-ascii?Q?1TUchzSdzIWuMiNtkzKUud2+MBjozhlMsNLV/OMDHOD3txggWMUjNGf4Fp2w?=
 =?us-ascii?Q?yeVExLzPG4X0tHfdNvkAVS9VCMqlxd1qqjqvVbPanY39U/eUuMGB7eyEyaXX?=
 =?us-ascii?Q?wOKwrQN3jMxUKtwNQ3lSyckus0HPFQKsUew+b3wVp17PsDxX+NSUFRC4ZCPO?=
 =?us-ascii?Q?mwY8B1kKwnrBaFRH5JGjzifOmseIN9YGdN2gOcWzwBcBKk4L88BIo0JBppll?=
 =?us-ascii?Q?l9HDJQV37gs0gjV/FJbImWTU2ZnzemZHIFlP2e/7Y7iNUIKlss/66xXYJdeb?=
 =?us-ascii?Q?EBeGuoqM7uIxkUVTWzACP7Z2sLIGAPVvtnwH6qmtvsBKtBiSk0+dErWfO6dm?=
 =?us-ascii?Q?6k4oC2sV5GDNkzwxp8fnMeMCuZELeUby96Am+BmG8fYtTO3cnRy/zpBw/ozV?=
 =?us-ascii?Q?i04e+n+cDdDbrvnaR+ni/7lUXCcypCGw65EmBW1T1JsBNOus7FU3kqDem0JC?=
 =?us-ascii?Q?/oqua/3o+E20ldcrXqYoZdZ+17MB8ecZILxNiZgigB9Qc4LsdEa8RY+qPbdF?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb08887-e1d5-4b19-5c54-08dc298eb1e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 16:46:42.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IkF+uPTZzVx0yMLKOYDqWpC4pWpdHaBXjEQtvX9v7ffhl6uEV/K4ONg7tZvMNQgff76ZwJfDwIIMbEiLpS0+dCdVY1ZtSiMivH2hlIwCAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097

The stream configuration is done in bt_bap_stream_set_user_data.
This will be cleaned in a later patch.
---
 src/shared/bap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index b88fc60842a3..133711e99d71 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1677,12 +1677,6 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     bt_bap_stream_func_t func, void *user_data)
 {
 	stream->qos = *qos;
-	if (stream->lpac->type == BT_BAP_BCAST_SINK) {
-		if (data)
-			stream_config(stream, data, NULL);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-	}
-
 	return 1;
 }
 
-- 
2.40.1

