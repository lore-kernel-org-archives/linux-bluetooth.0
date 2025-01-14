Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311B236A83;
	Tue, 14 Jan 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861692; cv=fail; b=lnMhDPW/TUfXcr0+LiwqOhMwEwuxO8iizI+spTg2e60ryLb1MuvpJfx7I44zEhbKkVviufrekj2v6f+Hf9KoXCbt17ebMb2tKmz3+rWta0UW4N/haFd9ST6Jn3UHCud1yOysdNrBvhpDUgBkf1SaE21eMr2rtJw8BPdzWUeE2Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861692; c=relaxed/simple;
	bh=qEwOgUuNtM3MeGJu+fGRwOdHtEdlmeqDutKE/H3W7xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HQOkBkI01ocgygb2eemV1hoORl5jcqKKon4jJdtDPrc1obxB77H75nplOVeJwXdkdkGnas19BbT0YTZpbJdyZf4FwNGI1XTvYvQASSFmawQEoz/Cmrj5jGC3I1dh4Y2aFmw3rMWBmFE+CLpSg2NJJhc/rFGbOb08JjAFbtl4Fj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f1ng9elr; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f1ng9elr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMmH7s75luVGkWtlGUVaaVyF5Np5B76zLV3Tl7V0fkYFMfjWQaNVM7Mr7VTaAGIXzdDggjMH3bBOJQz87dMD5V974KHpFGcXdhBvRh1mxscYRCBz/OuOUA/dIve0YQ1SXrx9mZKWiCqQrrtITneVWXo4DUsOrHZXL3O+ANM3c9QtAvU8X3f9i5vc9aYF5mg0fl0a6O6m+DoUzSR/b2q41Ce0/gdUb26XJY9Nc+dfj+V3XgZzNJ36naQYjYbkyRMgeAqSbQxqpyMFClhiQILp5n+s437hMcKf4101lZXYj6y2Hs+nIGGPkzXQLXYQm/PikJ+ajJXpHgPJvr43X7b/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3GfMA54z6RQBfAsc5L3IwjxdztoEiO/a87y148hXfw=;
 b=jFR0YMgkrwF2uaFKuS0OC3Iy1LiQcJOZ6xR6TCGx/dmPM2zTcyirkuBak49Hqj9nltQfxwtueFtpIxVF+IMXu7/PGohiwYvbmc2nvP4Irp9SaXNxNA1mTFhMPJgFLNXQLfnUXOzWEJgWRb6MszIA/8oGvh1BUNWjIi+0P5jpRbDuiY3aYQoAP467zUwxQ9tHnGvjsRNag+Af/aGfl6vzPqzJJRArTpdYfcKt48lbwDF3bXkLODaY+Z/WosDbXvDzdG4vj4c301JmXZ/GaiINV96knxiRzl74lEmyI27p4r8BH+IfcwRs8ET4fBcOF3JpTR4HN5//4V28n4O4JI75qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3GfMA54z6RQBfAsc5L3IwjxdztoEiO/a87y148hXfw=;
 b=f1ng9elrHyB+nUnGApzTYb/4lAyX0IzsHzx7j1vOtqPjG2xMH1vv/pZ+3gT3Ji7yZ60KAPK/68W7902LzD1Uhu7Z8v47veQTf/1asChepsFxl6n79u63CgnwIrW5cbNWZ++G/VN9jh3ZJKQKySkH0ewyZmHrfgwgEIVROQrEzLKlo0iUxfcTMaL0Uo+1DMoiNUOlg0sZau/jTajfZpJjkGHIyGSzC3WIc5vQkGlKq/GGCdr/DJj/BUY0hwDN04n2Z2ulbXYhUCsDnI426zTKD36ozp6LDeqv7xxnmGiEtHYh3iHy3dBkNgIadaOhKrql27ZPp9BLE+1Ib0uDXTGAWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.19; Tue, 14 Jan
 2025 13:34:47 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%5]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:34:47 +0000
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
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	johan.korsnes@remarkable.no,
	kristian.krohn@remarkable.no,
	manjeet.gupta@nxp.com
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for set BD address
Date: Tue, 14 Jan 2025 19:05:48 +0530
Message-Id: <20250114133548.2362038-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
References: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To DB9PR04MB9676.eurprd04.prod.outlook.com
 (2603:10a6:10:308::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|DB9PR04MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: aaaed26f-7756-40f0-95cd-08dd34a03688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDE5OSswMUYwNFdNOHNkK3huUmNOR0pBMnZxSGxFc3ZxOTFyL2hnMC9lTDhu?=
 =?utf-8?B?djNINlQwWmp3Y0lkOFJ1QWNsVk9nL1BuZ2VZQm82bVVkWlQ5cUhPSG5kcXVu?=
 =?utf-8?B?ci9hQWMyVjlWc0FhQTJCakhNVXlSdzRDRkIwdVRjZmJZT0JvYnRSUldxenpr?=
 =?utf-8?B?OVRmdGlOekJFNGlXS1NJN0VxT2lWck5BNUFUaGZ0VEZwUlF0aEsyZ3NsS3Vl?=
 =?utf-8?B?aW1mdmV2WXUyYjcxNCtmT3dMKzNtS0NjVnZPbjRpTy9LczlmZ2RuZEh5cVc5?=
 =?utf-8?B?bUFtV21tVlJwaUFDNGJubVNmZnNZOW9PaWZBbCtKVVZBSUI4d1J6UktBNXhF?=
 =?utf-8?B?ZmYzTFliUnQ0RW1BMENUSk5NZlhiMXNTZmtGdjRZcTc4WjdUd08zSG5YeSsy?=
 =?utf-8?B?UVN3Q1N2RnN2WUlBU3VhTWNJTUc1K0tGMVFIWFJLdTdvTXV4dUZIN1NDejJG?=
 =?utf-8?B?MXZJV0dPRWhGamwyNmx3U2k3c282VTU5VG9LWkdTYmFhdWNiamlNNkY0TnQr?=
 =?utf-8?B?V3UrU1lUZ05KS0JSRGo3bkhSbUxtZkZlZExxa2QyZnFuL0l5RUh6a3RnZU5G?=
 =?utf-8?B?Rm5Wb0ROMW4rbURCcncxbldOVWV3bnV3bXk2ZDdhVkdMem15dFJQSlVNRXhN?=
 =?utf-8?B?QXNOL2NqeUdlV0RWY0YxN1Q2TzJCckJwa0ZyQUFZbTFOY3ZnelExaGlzNlNS?=
 =?utf-8?B?MVVXajlRMEZWSXU4VHJWWVRET1E0bGdvMDVEbDhTQWJQNGZIV3lSZE5mOTNv?=
 =?utf-8?B?ZWNrdEF0VGhvcnN3azdpRHlGd09Nc2lSalVaZFlZSVkySFB0ZEhZMGVjNHR0?=
 =?utf-8?B?WDhETkNDVmlCWmtDaHg3WlV0L1J0RWpzSDdRK0VNZGMvZ2dDWk5XU3lUOGV4?=
 =?utf-8?B?bG1tVnhFNU5mZDk3MzhuM09PRXJqb29GOXlsbFhBRE0wc0ZDbzZEUlh0ekJG?=
 =?utf-8?B?UDRxb1NsdXU0cjNyN0JTNmEvSjNGL2lUbXdJN21ieWFlc1Jtdi9Ba1FjeWJL?=
 =?utf-8?B?cWFOUVgxZGZzcWlKT0Z6M291T0VVcUExTTUzb20rSEx3Y21tRkxiVHhnSXJ4?=
 =?utf-8?B?bFA3Vm9YTG40ZjM5N0tSQWVEcDdPSXl0Mmx2UE1XdFlkQXYzYTBwMElueC9O?=
 =?utf-8?B?L0lneHpBNEI3RzhzbzFVcUVoYXEzci85T3FnM1d5WTQxcXJxS1QzOW1kblZz?=
 =?utf-8?B?Q3BWQ0E1cVZuWTdqN1JoOHNrNllsWkU0S09jK3JiV05pbDBtYU5aSlBHWnFs?=
 =?utf-8?B?YU9BcFFnVGRDMnZQVkxxT0Q0VTNCdlJES0NoUEtNdmYwQWYzSGFFUDBJVG5r?=
 =?utf-8?B?bk5kUkQwMS9lOCt5NDFFT3laNmNNL3pUN1lTd2NwK1dKWGlHNVkweTJjRHJP?=
 =?utf-8?B?SGswRVRoYU1YT095RldiditwRnAveXhFTk9YMzBkTkdxcGNPbGQ4dDluWlh6?=
 =?utf-8?B?Q2lERFB2cHBuMmtONlFqZTZ4eGxPYmk3NWtrN0ZpMVg4d2g1SnY4YmZDeUd4?=
 =?utf-8?B?OFFCMXdOanRHYy9kTytzc29PeGFjcEErMkQ1QU5XSDRDQXlvMkRTdjJWUEtv?=
 =?utf-8?B?dlVnSnB3aFVYaElyZWx6VnJOY3M2d0Vka201MWhFNFAwRDMydXhRNm52TVRq?=
 =?utf-8?B?a3FqZUVjSVFWOXpsejh0WWhYVjJadk9vWnpuVmlpL0JxbEVuNkFjV2xRTUEy?=
 =?utf-8?B?U1BMREtWQWxneVNGdVhoZ0d5TGtacFdneTdZTkdjOHBjYW0vNVk1OHEzZjBT?=
 =?utf-8?B?WUozb2NCNTlDdlh4bGg3Rk92UHdJZFd6V2xpckRrL0lKbHkwbW9McGQyVmhr?=
 =?utf-8?B?UUdqS25yUEtHaHhvV0pNVDI2MDZBODNOaVFYSEV0Titkall1YUg4S2NrUXlw?=
 =?utf-8?B?N2R4T0pENXM3RjY0Q0t1aTh1WW5PaDZDb2p3ZFNIUElyVzhGekdNRVg5MUtj?=
 =?utf-8?Q?YhXxbn+5MJBcbhXYrjGMLN5tY7L16z6D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFFlV2FZRXRsckJyQlVKV0hJZEIwUDV4UnNKdFpYaVNSK0JBekRhYUpvc09i?=
 =?utf-8?B?TDZrd3crbkVRTHRTUWlZVXBuNVRMdnZ1cXpVRktGQ3pad2h4N2gyZDQ4L2Vy?=
 =?utf-8?B?bUVwdE14RnhwWlZUNFpOTFFxVFdzQzB6L2lqcjhKeEtaOThYMkF5cm5zcWdX?=
 =?utf-8?B?dkZUSWE0R3hMT1I2REwzTW1aVW4zcmw0RDFpVmtVRDlCbWhka1VYMzRjZDY5?=
 =?utf-8?B?ZmYzOGlKVEZXR2ljYWlXWGtuTDFienc0L2hRaDFsbVB4Rkh2Wk1OdHB4ZW5w?=
 =?utf-8?B?amVjdks5cjJnYVJra2ZkUGdJU1JBNFBMVXRZdFQwbDV3ejNqZjJmTmFsSk5K?=
 =?utf-8?B?YkVTSzlvMUdISnBaVXBqNU9BOUF4OWxRdUlIOEdoYkpsbUZiK2dpV2ZmUnpr?=
 =?utf-8?B?VTNKd0FtR1FYTVZnYzJRUnRoY0Rsa0pyLzM2Q1A2UmpUNTdJd3IybERlelV5?=
 =?utf-8?B?M3hYVVpNUXZLbU12a1hLM1IzdkdtNGUwYWluK3RXVDJBYUlZL25zTCtabmNB?=
 =?utf-8?B?d3hJNGhrYkw4WnR5WTcva3RiSXpRY2NtdlNYdkhNYldHYlJkTk9ueVJwR0Na?=
 =?utf-8?B?UWluU1B5WmpObGhpb3YwWU9ZNW1XMGJQTWh1czFaWFN2eDRkK0FvdkJrdG51?=
 =?utf-8?B?ZmNCck5wNXp2Wmc1T3hzNE9la1VLdFZra1hVQmRYTU85YkFDT3hidUlWM1Jo?=
 =?utf-8?B?a1dnZUc4eGtMSEMzTTY2YVl5d2N4TE9uVU9UL3ZmQWQ4WnFDUXg0ZXBPYkJy?=
 =?utf-8?B?WVVrSiszeUdlS0dQdGZ0eVI1ZTR0NkJsSWpUdWpKSFVYRWRWOGhEMHVCY0xt?=
 =?utf-8?B?ZWlDYlFpNTdORk1ZNFNmNXhPcklSMmwvZnZJbjV6U3QzZVAzY2xIOTdqRjZo?=
 =?utf-8?B?eWk4c1I1elJVbEg3Ylo1aWpBR2NNOXZvZzJQTURobk82YmZ5Sk5FUmxJejBs?=
 =?utf-8?B?bS9Kcm1FU0NkOVNKTW5EK1ZoTkUyQjhVTlplQ2xOc1h5NWpEUHRJNHJuSHdX?=
 =?utf-8?B?VWcwSXUzbnNGNEIxYUUwdXpqTG1QaG1aK0xrTWxoNm80aUU4SHp3RjR2RkNB?=
 =?utf-8?B?OUZwZnl6MmprZDkwRUhNL0lrV3UvdzZDUGkrekRzVnlQM25rRVgxVWl2L0ZX?=
 =?utf-8?B?NENrb1J3ZytTU0Q5Q0tDVzJ2cU1MWDJVbU9rRWs4a1c2b21TMlZhU0IwWVNB?=
 =?utf-8?B?TnZvUnVHMVpoRkoxbWMzRkV2K1NtWnNGUlU4WHF3T1A0QXFzMEdBdzBEbnN0?=
 =?utf-8?B?VDd1WnB5Z1B2ZFcxeWcyN1pDK2NneHg1TXZvZGVobHF1dkZMQS9RdTA0SUZU?=
 =?utf-8?B?RGpoSU84TUdFN0xLM2NCMWViSEtzTDhXOXNkdmVtZ0lRQzJSdDdiMFdoRGJ6?=
 =?utf-8?B?cFRKdDlKUzl3UHMzVVI5OXdyV29uV3VKZmppTHo5bVREZnVCT1NXTkx5aXVQ?=
 =?utf-8?B?cUUwbHlCQkR5Wm9TSU14eUZWVEoyQitucjVsdG1TbnR2eFhxb3NnbUNBelR3?=
 =?utf-8?B?Qjc1T0NjSGFaYi9tOGM5YXZIUmVHWXFLSlk4QlZ1UUF6ZEdyelpRbjM2OFNK?=
 =?utf-8?B?eHhwWjd0alRMRCtHQjNkWEJsQjlZb1hJZ0lsQUxmeEw3RkNaZGoyTnFNcGZE?=
 =?utf-8?B?b2NlZHkzY2NzVi9UdGd2QjQ3S2tQTzlvRGMxbGVUemdiSmdvbm9vQ0FKSUZ4?=
 =?utf-8?B?WjZQZzJ0UVB4YmVEZW1qcWxPb3NWc3NiaEkzMVpkL00rTnVUL1d3MCtEc3BS?=
 =?utf-8?B?dDlmQU9UUWcrVnJnYk8vYjUwNFF6TXFzU3dlZDI1ZjlhMXJFc2VmVE1xUUcz?=
 =?utf-8?B?L1B5cFd0TWpvNjFibytFQVhFYWppNTRkT1JhNklKNUV2WHkvTUJUaElHQUtN?=
 =?utf-8?B?S21iempsTzVSb2sxcGlaOHZZWnY1QjU2c1lDdWp3KzBLWC9vTVpNcG96VmFC?=
 =?utf-8?B?RVpBRFE0QWxtOXF4clpUazkxRzJzb1dTbDczK0N4OHRtUFYxUVN2b0dwWXBZ?=
 =?utf-8?B?WnVCTWNvMytadFZBVll3eUw4UFBTUUVXZUoxZXRjSWsvVlM2MWtXRlVxZVlG?=
 =?utf-8?B?NGl2L2pYQVJYRDg3RFlrakdmRjl6Y1UzMFAwd2J3WFI2eXc1NEJNSW1XSWs0?=
 =?utf-8?B?RGV1dHQyTzFIL3Z2VzhFY3M0QTM3eFpINXBjTFk0dWlXVTkvUHVPY282ZW1B?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaed26f-7756-40f0-95cd-08dd34a03688
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:34:47.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3a9SSmev3iIeY36DcYtAGioG2Jma2Ah06946jdKO8PnulMMHyufgjCi4uJy7ISC9Wystn3fzBA1X1g98Nntl6kg2Q/1XlOyf8yIOeCl1LI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

This adds support for setting BD address during hci registration. NXP
FW does not allow vendor commands unless it receives a reset command
after FW download and initialization done.
As a workaround, the .set_bdaddr callback function will first send the
HCI reset command, followed by the actual vendor command to set BD
address.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
Signed-off-by: Kristian HusevÃ¥g Krohn <kristian.krohn@remarkable.no>
Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1230045d78a5..deb546a4e664 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1197,6 +1197,34 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 	return hci_recv_frame(hdev, skb);
 }
 
+static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	u8 data[8] = { 0xfe, 0x06, 0, 0, 0, 0, 0, 0 };
+	struct sk_buff *skb;
+	int err;
+
+	memcpy(data + 2, bdaddr, 6);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
+			   PTR_ERR(skb));
+		return err;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(data), data, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Changing device address failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1547,8 +1575,12 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->set_bdaddr = nxp_set_bdaddr;
+
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
-- 
2.25.1

