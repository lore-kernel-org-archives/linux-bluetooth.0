Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAB47F51
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858303; cv=fail; b=FbryYWc5jTiloYk4ua6GZwrplh37tBuDKMA5ENmtHKplbmJNWUL8YHL6U+pVBY6cmlOiRQTG0DFxVjtRVdd2TAijmNaOrEwZa9yS16lr4v/h57/jTfGcgOiRpgvWfOO+ihfWk9KD3DR3gcan3gIzPDZK/p+3mOl+Ld8u5Aia+S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858303; c=relaxed/simple;
	bh=psaemDF53KHX9C1QepdPklXtoOqitukjw5t6itPzx50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaNMZVBi8DnFV5XZus/BEdWE0KbJ5oqJMraH5r7Lq9kaVYdbN5spkJMtkJ6K7ri9uKutZE0+wz1I/E7LoIXKQgaBiOQhTDjf9BpEz6CD3VAi29StX5J07smYamp5fZTgMm8MZbkomB5aPvwxMsyci8xqARcSs0T5tC+RbCpBmc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PyLQHHdM; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PyLQHHdM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtSCLqbQKa4GpK3RJL4k6DQHLh8lAAQE0I1kamO57gQmbnJLGy4m05JdEYEa1af19KcOUwUOcFvW9+qoNxCZguC3Gu75I8Q3ns0sRweuT4ZE29o1EJs9jiUZAVpnJDwwaUYEVnomraZ7z/bC+ecV3b1J5P3j7MSr/mRIXGaccfj+k7rq+bL5vtn1kSE17djurVyPYPFaZtvRWxXoTkaNCG4HUZHcB7CLRZg/aAomwSDTH1G05usgxJpdCGP0yTcoqgNr+qONEVU/lxEnycS5QDIatkxTpPsBgmmcMkHCSjg9j8EQG4g1HvgHQCmZNvAuY9P5cPgZvH0DV8JIYfMcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtddCRq0m2G7fHm+OhmIx09pvZBO7iHZWKoFmAXxkfo=;
 b=WBZUtyDh81X09UOfwag8TSbEf4FX9M8JfVOhxSlTcLEzhlumxZwKSF27gE0pvFWwoxtW4U4tL6iX+7UtUuQ19lfmXDiEC2zU9OGk/diL6w6dv4YOqSaBKenThwtZBCl/o/y60WgzA47/fl+R68S5eQEUpjepK9ldrusqn+DTyRZ0s9LBggXA79/Z09XTtP9zdw+vTpUo+KmZ8g7Y9SopO4/JpllF+hGDy/40HN7h+OcA6Ew9OuNlKT4ar5vNoBIwpsNmTD1oZ/zBw1IuvVtcyj70pgTXuB+HrTsFCGTWg4rxZAHCRolCO7FabO58coy34UXNm+QcIbaPa/6+jQGN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtddCRq0m2G7fHm+OhmIx09pvZBO7iHZWKoFmAXxkfo=;
 b=PyLQHHdM1uq32HW3BAzO6rsanjzNuxNl9SCwcxeRPwJx95qJhkH2ROjhUun0LDn3Vc5WM2jMQHwl12FBvWDG5vYTczfvWA3v6v7DJivAJk2JC92FBmw/VZFwnTfcO+WEX925pzbCnUpNqPI88SJMWcgGglQDMAfQzB9U2/3pJxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:44:59 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:44:59 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: vinit.mehta@nxp.com,
	devyani.godbole@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 0/1] Fix null pointer deference in bap_get_ascs()
Date: Tue, 23 Apr 2024 13:14:26 +0530
Message-Id: <20240423074426.62480-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240423074426.62480-1-sarveshwar.bajaj@nxp.com>
References: <20240423074426.62480-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To AS1PR04MB9630.eurprd04.prod.outlook.com
 (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c66ff50-d411-46fe-4090-08dc636946a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XE8x6MqbsI3EHcguw8l1xilzOPm6np0MMPrRukWyzfzRHm+BLva7OnRndas8?=
 =?us-ascii?Q?+JhMitg8IZAaLFIzkLDoHAgT4LslDu4igvcBqZyz09/A0GXMAHGPmEqdRF3d?=
 =?us-ascii?Q?+lTQVP7K4EzbuzvI9FtGTXuLZB0Cxf7izY9ky03hu1cxwr+gjdndg+YVYBZ0?=
 =?us-ascii?Q?8pu2Qicj8BMQVg+VB5fFYjdfhIunJPSjZGLm0X03SturOfNhS+/uV2amgaYT?=
 =?us-ascii?Q?/eD8LFvbSb+h2qXACwUIBPcby8n/rXKgiSJ335onS1wLqUaJgDrkAwFlcgAA?=
 =?us-ascii?Q?uAuT1wUdT9AY0pYo/M+IL5KZW8PW5gMlExAG5KiC7K9xUSjGRP/ooJcsp3/5?=
 =?us-ascii?Q?/FnjXXK1bMXKgCifwFddUk+cv2raPFtWnzWAx7s/hpGN0Dk8jcJ82oWJcRoW?=
 =?us-ascii?Q?tNf9CySpWVstuind7PXlj10L08YWWZ4egMuhgBoj1LUIT7i5riPNVZkYLG2T?=
 =?us-ascii?Q?PpIfY4q/TBhdEOx9BX31HVUa2hBh/cY+FVnVcik/6AKk/pSFp0ZWmb45CNxq?=
 =?us-ascii?Q?0AHRwLvIO4JO53/VC775P6aqFUL/rk4Sbp5GIUcJwFXP2ymaipJnapgj52Lh?=
 =?us-ascii?Q?Yl6TxMmUkVnFS5uN/XIZ9L7D9qeQaBu/IRM7AXnxENeJHCgEKXfDLTIspUBH?=
 =?us-ascii?Q?N6aLwxtIUX0JKJLE+pL8Sk8PSXQrv8PjNXUlafKX6ZJ0xRcurq+OLm2ZlyXd?=
 =?us-ascii?Q?wsLPOp2iXN95hFW57rq/5HHQXOifVhscSpEGfEVh0tKplWh30rjwmjX/p1xl?=
 =?us-ascii?Q?GL/9m0eijGL/vvsGfoVcTRgXeGfU9dmY9DXHa5Tfkw6qpF7k36XuTVGWnvCn?=
 =?us-ascii?Q?xehI3bczCe52nCdmBqzd4JkPnJe9RZu90lUjqDJR+xuytiwjqqDclt6gJWUE?=
 =?us-ascii?Q?aLxqYGgYHYWBvehwBgVLLGGWenUS8Z/QMY+26rCn65wpcKdxY2yebiyVr61H?=
 =?us-ascii?Q?4dJDgr8mcHTMXjEdCx3GHdfXFxTcGVr7w1pfXChyGg/Jme21A8F9evYkVL5E?=
 =?us-ascii?Q?T3ifD7ziU+eDhYGyYB/7A7EMP6ighba8W7j8qYjB+bz5pG9N9jDy4DLulKx9?=
 =?us-ascii?Q?hxjgML9hGQGSK7Qjtmc8v/lI9Inp4YcPwd1rzw1XiueZjYRcDBzttMM2ohB3?=
 =?us-ascii?Q?YVxM12iiQW5IiMruWLC93CW6+5cxnMEHCq4yEx+aCxfR+ceTWFT0Kt0fqaKN?=
 =?us-ascii?Q?RBYR1CuHhLpKXqvqGhSNwpEzlvh8DJdoKyLGRL+b5PYSICcJRSYdXdwhjLsC?=
 =?us-ascii?Q?+OT8BKq9HupQ8KChqMwX+ppENgn40AnFv10OZMzeHIWgTICSyqy5wruoDHz5?=
 =?us-ascii?Q?fG7IDfz01VAvZslSVeC9Z+TSKUCGpKmDBuUsfqGRDo+1+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bFqYCGE+mGotF7DQvIGF7+oCrD7gWfOPkvWiSwIi7gm+tatRSflT89Pxt3Sb?=
 =?us-ascii?Q?XhBptHeu5sJHhefdvNnJEcRPT80C0WI79+pEEpb6C/jis0XgH3F8fZSac1Gc?=
 =?us-ascii?Q?itPi1PMzdYwffnjLAA5SsYVlod9vnJvGCo1oZBWlo1DN8J24NkSAnqa2S9rw?=
 =?us-ascii?Q?TBzMc5Iyek1rnItDxAG2YSfhy5HtF+5IIcD7WTsetNtDAKkyI94bU8MFA2ki?=
 =?us-ascii?Q?AL5Q78rt+jYsPDdkuduoAVOuNqo2M8dT1AGXffbVlnkWJC+PYSZHhLx/Zriv?=
 =?us-ascii?Q?BSWtw2Qo5Fsed0GDJqyM+2xGt0hXRPAlXT2GsKsobWFnW2p4U5aM8JTR2Dug?=
 =?us-ascii?Q?L0732tCLBWyXcoejGVcmIrIMdybYjeN4VmqKzPOANgZGud+fQFUFU0pHMvtx?=
 =?us-ascii?Q?nI01Orh5aoi1UlWtAReH8oCywr3LsyOEV/TGtzu4q0GVdQeP2AUN9r+siM6J?=
 =?us-ascii?Q?bAUy6Br7P3cA4UtSyAcH3VUjV5tH+h0vmVDt81FpWVOAX3m9HYnrVpBS8bsf?=
 =?us-ascii?Q?k5FcSeWe2zVmNHhxBIkbGfE37nVQRht/qoEZ1QVakG0acCNTsIxUmcMdnX2H?=
 =?us-ascii?Q?tWKF2F3DG1fLG7zinguUafkqr43dMedVsLQIG9kJTjkM7Tp9n58Fa5goY4sx?=
 =?us-ascii?Q?A5CkKU8z2pjZvfH1TKUmOeVlmhx4ohyic0nz9Zzy56S3pjvVQK1ON37YYP3L?=
 =?us-ascii?Q?8UjJJXZS2MyOvV4AGPZ7L9JxOkoVNSRGk0yAXcv0fY0S3Sl7s9vNUuWtW9Pk?=
 =?us-ascii?Q?KjzoVaQ9Xw6fjY3c3HGOdtUqN2/F3zZGS6cAOtcWKQpBY1LwWI5xspGf61je?=
 =?us-ascii?Q?zoOeoM47BRkv9vV1Sv2eBr1Y8Ub+TkrWI5XOQS4NnxBIRK+3hoN9CahAmzXZ?=
 =?us-ascii?Q?gL9eCvJ+JXVFQOW6vPwJq2jd4U3qOk4weccaUWAXlqDmyOMbabGu99mp+9dx?=
 =?us-ascii?Q?0Sq5vRnUFZjtVklmXmxsrTF6ClLTa2Y73+wbgLBQEwGo5bQ1P3QsyA8J9eGQ?=
 =?us-ascii?Q?DczrN87xm02GGNM8ZK5e+B62prmRE9qz9nCq71sTPCmHHGx9wo8K2J1EEAe9?=
 =?us-ascii?Q?JDRVMIkHvKeQQ9KU8NMV+0CPCLaulj1RdiBDUS2dOjNQehxCvWmsBiE84+lf?=
 =?us-ascii?Q?5kvzmT2xGD2dv9XM11NMc770WaVjuAghHRqGF96g5FgrRrmkU+pp3BBMPlNF?=
 =?us-ascii?Q?CApTXz+lpQzXuwRCV1vlit8Uf1uVmEeANK10KzZ298MSak/5cA2pDIWwgadr?=
 =?us-ascii?Q?UTmZL6E7eLEYbTfu5VVk5kXiwEGcBZekw7Ha6OvaXv8Gh3W1nWGF1r1JvtTg?=
 =?us-ascii?Q?Q7ppOETYKApF2KgMD+vzm/rFk5Q9CQ2ABk8KXq+0WU5QtGJSkDL2eXRaeNRp?=
 =?us-ascii?Q?2Nhbb3sw9oFPX4ZezEngnX7//4nJPOtJRyfiPm5LaSc2B/XUI8bj5nrvn2KH?=
 =?us-ascii?Q?PUdjKOrhlnIeBEuWpsPFEDLClKwRatN5Oaq5Asjte9XfRiP+VDkOgESH0HNe?=
 =?us-ascii?Q?4MykT8eOgPj2SHhYXWOFLivWazKBv4MgLy9OWvDw/8BUMP60O74wWrZ87Vbs?=
 =?us-ascii?Q?Lniav9YtZSSM1xnuh6u1kOVtcI9qJ2dCqL6v2cTzo9bwltNVJ7ThYm1HiyDp?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c66ff50-d411-46fe-4090-08dc636946a5
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:44:59.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRo1thBemoGMzsm22hd3iKfIZQUCppC5LVd0HtCgthji6/TwaRCxZPK45PbjDurLMYB0rJZv02OP2BCTuN/jpClA8y3FUBvS+VwJ6giWgMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

Hi team,

This is the fix for preventing crash for null pointer dereference.

Ensure that bap and rdb pointers are valid before accessing or allocating 
memory for ascs. Added  null check to prevent potential crash


Sarveshwar Bajaj (1):
  Fix null pointer deference in bap_get_ascs()

 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.21.0.windows.1

