Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB21131182
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jun 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501643; cv=fail; b=JrvAusvr/xxwT+K0awXvIzgHEMd69Y6P726pV1QF7RbhWkdbWzbeO7wPGDEMhIzwaRBV2sSoEKR2uixEN8NfvBrmPLzjW6m6f0ZxE3WAKi6O5vCXe6apcUMwXiez1PpmHO1xWcda/ABbyUW/u7BQJcVp1JsjnDDp6wGRBNhc+BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501643; c=relaxed/simple;
	bh=yOpBou4WUl9neL47j4GsHiWUI8PEvdwTuHQ+kDvLkIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBgjMy9sXp4th/nxEhJDOsdd5tVEK7W++RNp7XRPOblNVhfbUvXOjy0MLAcRZ2E7WT5PyhI9vDyJGBYG/Dgu2PUWqapwczbA9LNrVPmZxXgtbxuINl6k9mv8zjOygaxBQYD+3bdNOQbe8Gz+ee5JC+kmyhH2EgQTtYwjVN3ztu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XSk1yLn4; arc=fail smtp.client-ip=40.107.249.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XSk1yLn4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+T75ltrW/Ach0Fag785ZFFjqE8IjTQ0x74Y+iXDpIVqK4isG6wrczozAfxxImP2lxgWVyO+WGqlHT/IpVRIi+VDkAgIWXroh5eY28oIKf5K7LsQ6I8koMXHdZJrTpLQSo+2NmdwKutOv9k+YEcyPP6ez2FYMXcc+AQv4pyjEEaXIhcHuJOad81CeI9WIPIvhc0/HwCSRZfrUi1+ew7AFv4zhKX4jGoc67eVGn9wwV3V2IGq9N/ZtwAnFLtfKRZIB8bSpOHRUo9No3+76XXcogdsZNLRvV6GlWXbzo8QEH8KE9qV3jWBPdFceJ5iAv88+Uzw6kJ61MlSrw30pW6VfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BCeSnBmVMavNGRO7Cc+O0S9CaAoQT9hejDaxGLMY4c=;
 b=fnlvwboFEU89Xt5RmwDX/xYGZHb/0kNHKKen0mGunNDbZTTKFyd+9RmtUvC4Ua8TaQfW6eDg8f60HAZZuB6ZIlrgIgM2OG9C4ediTuf/3v2CD6tVkVn0LhdQUFNXBdTSKQYmZ8gRy/Xp11CBbe8KUnaQfuwy4qjVwAMHpVaIjs6d4Af1EWoYT1PBIdC/q4nbFaxmP22Qg9/z7zhAxP7mqdzbmPBDz19y6MzmL9HCIitwBxZkNJUpC0DqvvWWhdk6TTXdqUktbJ8GlWZAu3+4jwdi9ekohP+eXOkGuU3Agp9GTNwNftaB7pILHZVCFoRhAsKrn5k93jWAd9vKIeoDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BCeSnBmVMavNGRO7Cc+O0S9CaAoQT9hejDaxGLMY4c=;
 b=XSk1yLn4SJqCtxZVbU0rjfbhbgGTX+R1QfmRN2Br3vru9jI5rtIk+pjeT6Cs0GYNv7vz9/n+/6NpJjE9NlowsDkXa1nirPRh371Cd7VxSMJ32u7B7PXAqpyxFdwqBmQctzMPhj7aS6vGxW2y4OJyQfHi+i6oCLIa0oJNR4MEyMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by VI1PR04MB10076.eurprd04.prod.outlook.com (2603:10a6:800:1e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 11:47:18 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 11:47:18 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] test-bap: Add Broadcast Source STR one BIS tests
Date: Tue,  4 Jun 2024 14:47:08 +0300
Message-Id: <20240604114708.33423-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604114708.33423-1-iulia.tanasescu@nxp.com>
References: <20240604114708.33423-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0061.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::10) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|VI1PR04MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eba407d-8653-4aee-54d4-08dc848c1615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+84vVBggVoc0lxSrlEmrfWqoba03mY2C2GvwhXduM8lDY8ai9bss9bMM+hIx?=
 =?us-ascii?Q?Bj2CyeD4gzM16bVWV2TJFEFYLEEkFSv/JZZqIE4tGKLiA25g8z1C1L/KEPxW?=
 =?us-ascii?Q?75VQmSTegnJEcPBdmxA6quSLbe3P4NsFwNahRek3gAeaZRFRhDC1x6QQLLge?=
 =?us-ascii?Q?35IsEyCpC0z4oI5wogz2IkzpNf0vVHyquvQv0FZKWsgngQKpFs2WHqGPgMb3?=
 =?us-ascii?Q?8WuBhlWnjmB8azzObHf8PDDpG+sPZeg29NSu+3b8pKsMHcSR1t6uZmegySrl?=
 =?us-ascii?Q?1htuHlBVT8yhfNAbFA+2Hs1kxRpMf3C9ZC75UExSSHYAYhEHme4a68mOgFxd?=
 =?us-ascii?Q?VPjMekcL1bRUAthWy4joo+oae3ye6dIOAQtjaZptbeJ/WXg+wRdZkXbPVKhv?=
 =?us-ascii?Q?4myoZ04lob57FWJh0c8dGN+uQRwsL65HyE6gmMfnU/7g0iP4zPB8o9T90uWK?=
 =?us-ascii?Q?if0EHdgJCZ5Q64iBiDxqqziF+9nspLmpX0d6xHTU9OcsIgPjEj834Kxc95Ek?=
 =?us-ascii?Q?UNzpsU4QhA0wIfPO9HCp3zjxO2HM8m82sN9B2yva5XpGo1rFf+gbZhLjcSO8?=
 =?us-ascii?Q?SW+TD97JMzjmxVIOJtXSyERE3dJIiYvWBcBWHZp8cXPQt/SIejOBcXTowuGL?=
 =?us-ascii?Q?q6J+XBe4T9eICtmUdr+Ebz41H/jgB+Eli0QaBmNMoQsoElZb1lEf3AV3e9Hg?=
 =?us-ascii?Q?8wtBV3yV/t554v3J4yBIaxXrdYCM5BCF1QrbKTwVdKpKI5CHnYR9V4IlzquA?=
 =?us-ascii?Q?nh9+sErxkg0/ZWtSywar0NELu/iVOvrZl3tHbjSYdmZhdNzDcl9pcgb5tssO?=
 =?us-ascii?Q?z+lnbEO5hdXBgPZJsVe9252a90O/+nzHAz1NOaucTkJb1xBWxIt5v4DS4j3Q?=
 =?us-ascii?Q?7N2OAFoho6RhXAajex/I6Qg+pdS1vGNnyz3h3ogHdQivcUtYhHcwKCdaH+w/?=
 =?us-ascii?Q?1n2HczQxu5qnpYRhVJB+ULrinSgRIFwK9EotcGL8RZhd0eowFlPNFCLvAXTH?=
 =?us-ascii?Q?oTR75/pToTfS/r4qZMzzYIjkx9lSUJF3CbK0cxx9dT/cEpAqQAiw4ThZzo4A?=
 =?us-ascii?Q?w39poIeXFmIIHmDt8SZCESz6TF2sopXqCG2cVDMBVfSFDI+vFEMKMGQwSTHF?=
 =?us-ascii?Q?IVTaH5cOGOj12xLAKPa6F21+O57uvM1q/rxFfelgxDJcml/JbO3hjrWpYaem?=
 =?us-ascii?Q?IVr6Doq0pmZBYsTtLP5f+yl2gSQc+r3Z+54UjzkWL1llaog0OBzrGMrygypv?=
 =?us-ascii?Q?7s0CJ/5oCE7CnyyQfNHQJSzx/h/ItMZHddMd4uXTLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8oUXBnSAn1jbu/QVOm870ThIds9B+JocehpgiYH8vUjE2lB2Jc/n5FXEcKsT?=
 =?us-ascii?Q?7NstjrDJiRfwb5gUFpHViPWTnCi5KyIM5pJLm40oNcG6WnGUxnMH31ZD8Jmj?=
 =?us-ascii?Q?AeBaHmXgKk2wgwHDpCOPzfaB7bIlaHbHnJ+qK/I3XliKq/MP3dmMFC93EOoM?=
 =?us-ascii?Q?VxWrakIY/UiNXPdAsHJZuNJCss3oyhNr85z2qDBdqgEfdYzyB/y2ZNcls3uq?=
 =?us-ascii?Q?ecu4V25UPHAGZabwepnBs67vK+WUCho8ilasUNaKtHbmRQKESsP84UEVNcTM?=
 =?us-ascii?Q?jWLThmy+tSyvKD+RBa5pMUh4bY8Mj+hyuNOJyIb5y3KHm3bvyM60aRMNHXsB?=
 =?us-ascii?Q?tHEHI4z8Tvj1anSGnk8HmDgrHUx3rDDMrY3obihduxuYckH+1/XRfcxxiSr1?=
 =?us-ascii?Q?ko+ou71UU9I6EcA6aqwtuqDNzcJyP8AYlNSb8nr8M4c6GiVOuC7iz3EgmlgF?=
 =?us-ascii?Q?BPbSSsct2Z+PKvnyg0kPuiNyYZvL533lsyIW4fUgDjjh4jKyTuH02TnacyMa?=
 =?us-ascii?Q?NKAXNRYMEQGwuCm3ysLRbNFMw5K8fktoJxq/sAEC7xT7if3YqhZGyYTfH2U3?=
 =?us-ascii?Q?6MV4LXqVgNvTx4i2ZN0ZG7jib+m+rA2Ubv+iybc+wkLhOs0JjfgvqQiBk1fd?=
 =?us-ascii?Q?0kU6QO95JTl9uPw9PjChYmO7Yp65W5bkjuu+1Oe81QXWlOMY71uOuihQmQR4?=
 =?us-ascii?Q?jj0LoA0gKQbVtoUu4EE+j3UCctuO2JikgNzDGSBnT/1/qRgU7v8Yn1f5NfRe?=
 =?us-ascii?Q?NtYGuclnHJSLkRljLTCfY7K2A98PeU+gIdUC8c9/iDmgX3/tSpq6TCs1r340?=
 =?us-ascii?Q?KsxDSBWi1pJjOqVu2wVwzicUeek9ihpvS40oBy35THRYCRzN1J/5lvWqb762?=
 =?us-ascii?Q?n3swReNJpL31gYIyMLwckrKru/YUqu8XdisfhDKw4/a14zUregQHwxZOMYyc?=
 =?us-ascii?Q?RyH/W28p2BauRNxqWCbQnuhJToXyo3CatFTkE//uRdpRSVQbgLZ7K+OxoOWW?=
 =?us-ascii?Q?ZI05c+PzFBKkXoVmtIx4oCciQG1kpmYPpBFQ0pzU7sUekO3f8d4+Tu80BgHs?=
 =?us-ascii?Q?nYYU3SPorNDuGatGUHLvGjQl/Jnrcy24jGpkv5tnF+7BbWtdYICD35wtZsyw?=
 =?us-ascii?Q?jTsoo7YbjMExaNRJlmNeKmb57jlQpuvYrZnQSI8IsEuexNmiJGfBAOxSv8WB?=
 =?us-ascii?Q?zv4ETe5aO+vzsGV7xzwyNnm6sIZHmNi+a7stVIvSr3H69xoY296YDxQ2dfPr?=
 =?us-ascii?Q?ND8Fgn6yTtZmE0eRKbqFlnHfcYGcN8AczBCMuJfeHr+trnNvtDB5mns9eMyp?=
 =?us-ascii?Q?0uMuAgCX6j4S6Netds4M4AcWjhT4yPO4agL6K04t3r6tTeMnrgj9S1cNZhje?=
 =?us-ascii?Q?pYncgaNe/VCnLkcISKW4EFImNjvA755fFiB+QQBgtsLVeXiUYkEXvp1u/NtE?=
 =?us-ascii?Q?TqdhC5R+oLLKk2fSDQUJmwYIR3mPSFF3N5ojsu5lUTtce5Emdc05OdxxEN/S?=
 =?us-ascii?Q?bhUo8HRU5iUd0WvrlsZVnQJTFcG1AH0/ld77IkjzoypgBQzyG6B0eJt17LCR?=
 =?us-ascii?Q?vyq9GSa5zD0o0kT3AyjBFXDMk6gHxOjTUWmdh0Rz0pTssj+CIpKczSEf7Ruo?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eba407d-8653-4aee-54d4-08dc848c1615
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 11:47:18.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tADh/OlcAerSZWVtdqH9ttyRyD6wShHYfi4dmGORoAuT+7k9CmUnXkbPjscqguby0FiCBvHqVrdiri+ptgovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10076

4.14.1 Broadcast Audio Stream with One BIS - Source (page 180):

    Test Purpose:
    Verify that a Broadcast Source IUT can stream one BIS
    to a Broadcast Sink. The verification is performed for
    each Config Settings in turn.

    Test Case Configuration:
    BAP/BSRC/STR/BV-01-C [BSRC, LC3 8_1]
    BAP/BSRC/STR/BV-02-C [BSRC, LC3 8_2]
    BAP/BSRC/STR/BV-03-C [BSRC, LC3 16_1]
    BAP/BSRC/STR/BV-04-C [BSRC, LC3 16_2]
    BAP/BSRC/STR/BV-05-C [BSRC, LC3 24_1]
    BAP/BSRC/STR/BV-06-C [BSRC, LC3 24_2]
    BAP/BSRC/STR/BV-07-C [BSRC, LC3 32_1
    BAP/BSRC/STR/BV-08-C [BSRC, LC3 32_2]
    BAP/BSRC/STR/BV-09-C [BSRC, LC3 44.1_1]
    BAP/BSRC/STR/BV-10-C [BSRC, LC3 44.1_2]
    BAP/BSRC/STR/BV-11-C [BSRC, LC3 48_1]
    BAP/BSRC/STR/BV-12-C [BSRC, LC3 48_2]
    BAP/BSRC/STR/BV-13-C [BSRC, LC3 48_3]
    BAP/BSRC/STR/BV-14-C [BSRC, LC3 48_4]
    BAP/BSRC/STR/BV-15-C [BSRC, LC3 48_5]
    BAP/BSRC/STR/BV-16-C [BSRC, LC3 48_6]
    BAP/BSRC/STR/BV-17-C [BSRC, VS]

    Pass verdict:
    If the Codec ID is LC3, the IUT sends encoded LC3 audio
    data in BIS Data PDUs on the broadcast Audio Stream. The
    audio data is formatted using the LC3 Media Packet format.

    If the Codec ID is a vendor-specific Codec ID, the IUT
    sends BIS Data PDUs on the broadcast Audio Stream. The
    parameters included in the Codec_Specific_Configuration
    data are as defined in TSPX_VS_Codec_Specific_Configuration.

    If the Codec ID is LC3, each parameter included in
    Codec_Specific_Configuration data is formatted in an LTV
    structure with the length, type, and value specified in
    Table 4.79.

Test Summary
------------
BAP/BSRC/STR/BV-01-C [BSRC, LC3 8_1]                 Passed
BAP/BSRC/STR/BV-02-C [BSRC, LC3 8_2]                 Passed
BAP/BSRC/STR/BV-03-C [BSRC, LC3 16_1]                Passed
BAP/BSRC/STR/BV-04-C [BSRC, LC3 16_2]                Passed
BAP/BSRC/STR/BV-05-C [BSRC, LC3 24_1]                Passed
BAP/BSRC/STR/BV-06-C [BSRC, LC3 24_2]                Passed
BAP/BSRC/STR/BV-07-C [BSRC, LC3 32_1]                Passed
BAP/BSRC/STR/BV-08-C [BSRC, LC3 32_2]                Passed
BAP/BSRC/STR/BV-09-C [BSRC, LC3 44.1_1]              Passed
BAP/BSRC/STR/BV-10-C [BSRC, LC3 44.1_2]              Passed
BAP/BSRC/STR/BV-11-C [BSRC, LC3 48_1]                Passed
BAP/BSRC/STR/BV-12-C [BSRC, LC3 48_2]                Passed
BAP/BSRC/STR/BV-13-C [BSRC, LC3 48_3]                Passed
BAP/BSRC/STR/BV-14-C [BSRC, LC3 48_4]                Passed
BAP/BSRC/STR/BV-15-C [BSRC, LC3 48_5]                Passed
BAP/BSRC/STR/BV-16-C [BSRC, LC3 48_6]                Passed
BAP/BSRC/STR/BV-17-C [BSRC, VS]                      Passed
---
 unit/test-bap.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 259 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 47a19b8c3..638717afc 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6934,6 +6934,264 @@ static void test_bsnk_str(void)
 		NULL, test_bcast, &cfg_bsnk_str_vs_mbis, IOV_NULL);
 }
 
+static void bsrc_state_str(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_CONFIG:
+		bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		data->base = bt_bap_stream_get_base(stream);
+
+		g_assert(data->base);
+		g_assert(data->base->iov_len == data->cfg->base.iov_len);
+		g_assert(memcmp(data->base->iov_base, data->cfg->base.iov_base,
+				data->base->iov_len) == 0);
+
+		bt_bap_stream_start(stream, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		tester_test_passed();
+		break;
+	}
+}
+
+static struct test_config cfg_bsrc_str_8_1 = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = LC3_QOS_8_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_8_2 = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = LC3_QOS_8_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_16_1 = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = LC3_QOS_16_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_16_2 = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_24_1 = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = LC3_QOS_24_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_24_2 = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = LC3_QOS_24_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_32_1 = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = LC3_QOS_32_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_32_2 = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = LC3_QOS_32_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_44_1 = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = LC3_QOS_44_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_44_2 = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = LC3_QOS_44_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_48_1 = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = LC3_QOS_48_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_48_2 = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = LC3_QOS_48_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_48_3 = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = LC3_QOS_48_3_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_48_4 = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = LC3_QOS_48_4_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_48_5 = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = LC3_QOS_48_5_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_48_6 = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = LC3_QOS_48_6_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+};
+
+static struct test_config cfg_bsrc_str_vs = {
+	.cc = UTIL_IOV_INIT(VS_CC),
+	.qos = QOS_BCAST,
+	.base = UTIL_IOV_INIT(BASE_VS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 1,
+	.vs = true,
+};
+
+/* Test Purpose:
+ * Verify that a Broadcast Source IUT can stream one BIS to a
+ * Broadcast Sink. The verification is performed for each Config
+ * Settings in turn.
+ *
+ * Pass verdict:
+ * If the Codec ID is LC3, the IUT sends encoded LC3 audio data
+ * in BIS Data PDUs on the broadcast Audio Stream. The audio data
+ * is formatted using the LC3 Media Packet format.
+ *
+ * If the Codec ID is a vendor-specific Codec ID, the IUT sends BIS
+ * Data PDUs on the broadcast Audio Stream. The parameters included
+ * in the Codec_Specific_Configuration data are as defined in
+ * TSPX_VS_Codec_Specific_Configuration.
+ *
+ * If the Codec ID is LC3, each parameter included in
+ * Codec_Specific_Configuration data is formatted in an LTV structure
+ * with the length, type, and value specified in Table 4.79.
+ */
+
+static void test_bsrc_str_1b(void)
+{
+	define_test("BAP/BSRC/STR/BV-01-C [BSRC, LC3 8_1]",
+		NULL, test_bcast, &cfg_bsrc_str_8_1, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-02-C [BSRC, LC3 8_2]",
+		NULL, test_bcast, &cfg_bsrc_str_8_2, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-03-C [BSRC, LC3 16_1]",
+		NULL, test_bcast, &cfg_bsrc_str_16_1, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-04-C [BSRC, LC3 16_2]",
+		NULL, test_bcast, &cfg_bsrc_str_16_2, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-05-C [BSRC, LC3 24_1]",
+		NULL, test_bcast, &cfg_bsrc_str_24_1, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-06-C [BSRC, LC3 24_2]",
+		NULL, test_bcast, &cfg_bsrc_str_24_2, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-07-C [BSRC, LC3 32_1]",
+		NULL, test_bcast, &cfg_bsrc_str_32_1, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-08-C [BSRC, LC3 32_2]",
+		NULL, test_bcast, &cfg_bsrc_str_32_2, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-09-C [BSRC, LC3 44.1_1]",
+		NULL, test_bcast, &cfg_bsrc_str_44_1, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-10-C [BSRC, LC3 44.1_2]",
+		NULL, test_bcast, &cfg_bsrc_str_44_2, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-11-C [BSRC, LC3 48_1]",
+		NULL, test_bcast, &cfg_bsrc_str_48_1, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-12-C [BSRC, LC3 48_2]",
+		NULL, test_bcast, &cfg_bsrc_str_48_2, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-13-C [BSRC, LC3 48_3]",
+		NULL, test_bcast, &cfg_bsrc_str_48_3, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-14-C [BSRC, LC3 48_4]",
+		NULL, test_bcast, &cfg_bsrc_str_48_4, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-15-C [BSRC, LC3 48_5]",
+		NULL, test_bcast, &cfg_bsrc_str_48_5, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-16-C [BSRC, LC3 48_6]",
+		NULL, test_bcast, &cfg_bsrc_str_48_6, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-17-C [BSRC, VS]",
+		NULL, test_bcast, &cfg_bsrc_str_vs, IOV_NULL);
+}
+
+static void test_bsrc_str(void)
+{
+	test_bsrc_str_1b();
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -6943,6 +7201,7 @@ int main(int argc, char *argv[])
 	test_bsrc_scc();
 	test_bsnk_scc();
 	test_bsnk_str();
+	test_bsrc_str();
 
 	return tester_run();
 }
-- 
2.39.2

