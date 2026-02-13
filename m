Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1B361672
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000916; cv=fail; b=mBjI9b9LI5eqDKkwSOUbGzo03bFxWwpirRqx/ppoPXaIN71jBiabXmP9G//Er6N1BeyKmEB5IxeXmiojNnHWpVAADWOcl0ZYe48ltW85xeiM8d3wGIU6KeD4vA1Cy11uJds72RbEcbRGvj3Dv5pRmVGsxs9ZeKCgJDgR0kyEAG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000916; c=relaxed/simple;
	bh=uyY580vePporKYfGrsJpWkxbGhAycav76qF/GqzHGbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gl52DiOCRFpbllzg10Xqj3Uw8vS7GiaTai3YjL7gBMka6BmnfG9IB/3nn3UNHJNIZNXlLFD2KLcrbQSWpqHrX7wuTdEIrgNZ7tcxwBJ202uRxAL4Qh+gv9Uz5dzEySKOfqahQ4pxUnpyAye/0DHlO2QExBlvVx/QiRUhd28MF60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BsTYtv25; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BsTYtv25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEcD3dXt/BOzQ/HiqWzcMhWd+2oQx7R1T4Kms9q0+UOtNXrnERSpLAfHRS3rd+RlyOeMfX0AUxDZV5N0JkwZJq2Nnl37sBESR2cJPpkqMEfPGCm5sIAQL45xeNMfRGvmxo0P6CtF1h9Kx0MSN7wyOr/gqARCm5tFlyl7cnsUNqNljcYhftD/DnEyd4lyOr1Ebb5mofmutKT7BfHIQPnN9qiF8yBoug6yUOYxEcIezWQBAhOfaWsQvmlWNpNW/VhRg9zXg+f+8M2YxTg+zRtIbM4QWBi7DKX/9QBGaukto9EML6yKc/mBA/z+RClqcxFiy65H1YLCljRc7F46iF2JcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mZ9PZbOwBHEVWNhfCITU9gwpPZqlR858jlS6Mg7yHY=;
 b=YCrVsUMgywstDFHp7ub/jOX4bGaylQnaItF5H19w6AItnbc04BEFCm+PqL82Le5QydkssiOMAPt2xSQlrKudccyzBwtaFqmOZtt0v9DmNvpIvXZ+zREI6RCvnITDTZozxmc0ItAp8Q0K/1aSdR74IFQs4/8yVZ8/TjrOQAPyc6USgRx9etTbxlR3fO42/m5IKNZhdic5l4PR5WnjL257Yteo6RIEpa/FeatpO00dAqLGA1dlQn32ndO7o/X2AIyMagMfX7iSbUmP0OrEOg5LRoPVrvQN8/eNljBs2QmMqu1PIAF7VzQ699tQtOokQ4U9gRLfsAnrBoB9wk2mCInGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mZ9PZbOwBHEVWNhfCITU9gwpPZqlR858jlS6Mg7yHY=;
 b=BsTYtv25x1TMzvCaN3Ko6rY36GNWZOqAjXta+Fo9YFYwvTcMaiATxK8/Z+6nddp0Ihv7yyl4kxaoULRs14gJHtR1qtzjyuY3nGld5KNyDZ3u94iyVOSl3xCbPDE5q1WIHPmHrW+zKHXo8Q5dQPObi96awH1IPyIUvz8NQ+WQrXVQDjMMlpXo0rHzxF0rtH7W2MOpZ/HWQMWjkJgAe+DnBMX/B/CPzZu3yWgmYr5NCQsEQqTyrAFCF15/E+oWjD7srnhC5jx4nohKyP+ojxhNLpkN1HhuPHfE9MWxZ9qlsAWKoXfFjHJ4zNwjKIs2+WNZvxQ0bPFcvxVeXsH554U4hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB5PR04MB12203.eurprd04.prod.outlook.com (2603:10a6:10:64b::16)
 by GVXPR04MB10708.eurprd04.prod.outlook.com (2603:10a6:150:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:41:52 +0000
Received: from DB5PR04MB12203.eurprd04.prod.outlook.com
 ([fe80::ec86:5dfc:992d:8d47]) by DB5PR04MB12203.eurprd04.prod.outlook.com
 ([fe80::ec86:5dfc:992d:8d47%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 16:41:52 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 1/1] bap: Fix use-after-free in broadcast sink cleanup
Date: Fri, 13 Feb 2026 22:11:20 +0530
Message-ID: <20260213164120.502-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260213164120.502-1-sarveshwar.bajaj@nxp.com>
References: <20260213164120.502-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To DB5PR04MB12203.eurprd04.prod.outlook.com
 (2603:10a6:10:64b::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR04MB12203:EE_|GVXPR04MB10708:EE_
X-MS-Office365-Filtering-Correlation-Id: b66258f2-e30b-485b-cf00-08de6b1eca45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MiieTCAtmY17Glrr6MxdPteakQ1PJejnDdUYASl/zo55v3pLUIUyAKcwA6Pm?=
 =?us-ascii?Q?3/XmuU9s3ZXbv45n46lZ5sY/l0qVfrEjFhFUYu1VMYzIGT2z6EKyw8fpwv4V?=
 =?us-ascii?Q?Pm7Z7Cwse6ok/Mp+5eX6/MXvWa8Riglj1HAUgG/vkjnCFI1vIJIm/y6Pa9Kx?=
 =?us-ascii?Q?JiQBl1UuxOLxDH2U5jx2/CuCoBWa5XfTFVpaf2mVDvADEHW2eWolrLWj0Qdg?=
 =?us-ascii?Q?FrcxgkKd3PzkpwPcwL4/zJzB2AX0siqGnhZ2jiI5oWGl+9qWeri+JZlxCiV+?=
 =?us-ascii?Q?kWy9DSel8qljnWdRM6ccq0G7gFR7vf+RPVb8FHUrImBPEWE36zZ1O/uNwH0P?=
 =?us-ascii?Q?oRU8xuHnRyYOp2jMcoiEuYwejQ/EalrZeumnujFtI6tIP1tpDaVWve/vPKVb?=
 =?us-ascii?Q?VrOysqpeCPU5HPwVl7DHDwYqZrvBsBEgXY5uVaYmMGNyPsLIgMJK0/lEyFpC?=
 =?us-ascii?Q?LiGSNbqstDH9ZwHcNZ0/DN8QD9cGKY8AisWz6wQhIRKQaR2jgbqmEjUt+SVw?=
 =?us-ascii?Q?JwggSwm+z6sMdNPmOVlqrkaIJ8ttl6mjR3oYeYKUCFY/hsozv3/M/LPS+Kbn?=
 =?us-ascii?Q?gKWyBXtAtSVe0XaDpXq55Sl/cj4U6QJsbgDHoKLf3hqB2x7mkmtPM0QiA7rR?=
 =?us-ascii?Q?0RSUPIJIWITLxhH0H8uP8PmqpSQXnNDhC8ZUguU5nFjgARSLZhp+zaKhh8h2?=
 =?us-ascii?Q?ZUDRtLKeMV/YnlVat8NcpTOvYyqQDNcmHYrbtGUv3JAX19ZNOqT5pOf3Jj1C?=
 =?us-ascii?Q?l7GdrLm51XzY4An1lBlY5Rr6ajQbsiqcDi0i29MKy8kVmDkakRcj7YvpNx61?=
 =?us-ascii?Q?Y4Bkb7zFRZR0m8elhxuDxEF2O6f4e41NlUegoiz4jlOYyvS9P8RIBA0A99WY?=
 =?us-ascii?Q?+7ELUBZpbFQtVL5uspwFM7oXz2f55F4i1VHhc6bxzpiP3x0KaGDcY32rHy1P?=
 =?us-ascii?Q?K92+K46NuRQtqgGO54Jrc28iz5wWrlw83pFHO5hS4xdAirE5o5YmcSe1DbYw?=
 =?us-ascii?Q?QAVeKUJc7xjfncRwsW5hFQxk4Y4hESLCldNlCV5lZzqNxdALB2r+hAOxRJer?=
 =?us-ascii?Q?jI9PjgUyBSAEzkyBHTm+refzo51F60+zdcOhVqzARy+8lDKqgmd3+dWaBAnw?=
 =?us-ascii?Q?UjUkwuCm5SgFtzNA62gixj9r5VQIwuIvqxLR2yeHsUoG3P0dbZ8SpHhCRTNA?=
 =?us-ascii?Q?GpmvHXBUjqD63r3RrCY7vhadPUZZ54ZqFZoLsBHKs9bGIEMFmOaDNVcRTjVX?=
 =?us-ascii?Q?gVVkmqtdEe7B8iQSnOKBXglBTTPMTzsHw3t3amb42xw3IP/7k0HjGkfFl8Dz?=
 =?us-ascii?Q?N09MWQL3z6BWp3xSX2XwgYZVNcSmhaGFmaGNXtraGS4WJkIJ3RLfjh9O3n7O?=
 =?us-ascii?Q?ZprTIYPflP17nkovIo+M3k8y1U+A/WOoSFkuBxhnSI9wm9QaaygSzevaz7XE?=
 =?us-ascii?Q?sW6X8vWXYT4Qqd3+EoxBhFtqCIDIaTD2y/5hMVDRT73nqvYRlPuRr4Sa0Z+4?=
 =?us-ascii?Q?5uV7mJrTJju3C6kNxubPrCpk/pSfJ+B4c30XmcfaQi9jfXk/f8gdg3l1TPnS?=
 =?us-ascii?Q?YOctq9vlvZNwBRs+YzrDiJCq0raDwEJj5xAk0sxVoG8i+rAy+WwPQWRMypBu?=
 =?us-ascii?Q?SpcuuYFmZwJKAfVSjZ5HrT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR04MB12203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Qf5D58joTrf8KLkycwR0nImSqZSfcPQXvJVyuje04spzEA64FH5BJ7daEDq?=
 =?us-ascii?Q?e/NjGeBH8c8c/tv/StjzDWRRRnhjZrnm3W2qc9OYMW+D5Pd0FCFvfspobWU6?=
 =?us-ascii?Q?+aZRLxocrbBlrJeB31Q2HkNxhgDu1na003v+kqjmhnQG+/pCKkerOh2egihj?=
 =?us-ascii?Q?StyQ5PSSpxkLHZNawO8vJjlpteTaW/Hx43IJYZ3/W8TELWXocpWLZllcab43?=
 =?us-ascii?Q?6LWgOa80rcArxhKdZzh6vmwOdXsLo4p5/tbabZy6OK5CP8A9enSTS3gyYmx9?=
 =?us-ascii?Q?G3wR+AjUFF+ZXEksGzQmhKsVRwoss4TqLZC6zrClJnv4TxOeqtBGY0IgFydM?=
 =?us-ascii?Q?o3LZnklMCfgUx71A6c8eVqANIFWkROcI7OcqLWsGgqcRblATj6RLKDRiWuq3?=
 =?us-ascii?Q?Us4q2y0coTY3piOCzvO2yri/R8Cz8NaSzUjb/253CinTk8c901rHTzPRr83a?=
 =?us-ascii?Q?T2OdOBJz91SOHvANkA/ir/2HuCtIH1RXgTmg1wDrLJPhjDiHy62ABg8baAjV?=
 =?us-ascii?Q?Nfjonfl4ZnfuOzDktRVflMXxP+kehNcd0lki+1LWCBm+dkT1JpglrPlcxf9P?=
 =?us-ascii?Q?1+aXkU4MRpV70sjoXRBIArIRlEZgw7mXFSztPX+BFehsYj9rvoEPYqLBr0XG?=
 =?us-ascii?Q?gOO5NEr51aAIsbGwDAmkJq3LZLB5C9t2Z9H9Wg77kA9BO47zj9HmUiCBaICF?=
 =?us-ascii?Q?BM/PZYRY4q47I5SPE/SOiuhDuLaa5swUTHXIPhmyRtIvTUItD5m88uqZtmrS?=
 =?us-ascii?Q?3tqhyUe7obftt7bKEP5KRoFXsHE8P6LDPq92+0beensXXtZsrSaVC6Wnetpc?=
 =?us-ascii?Q?x+B5VhneA5yWkRHHzrGY+B4HYXeBqA79S1Z8juiMVKvfVA3/X+1mK8Saj7ZD?=
 =?us-ascii?Q?q+PtrERbG9VIKY7Tj8DfWseC+2AdUhV1iD8Y0ME4aisLcyIymIIcvQbqaUFI?=
 =?us-ascii?Q?A0aUilAFu3DezJEN/tPSuTbo/twwlhLzEiY++IWA9a7lCTyt5oJ9VIHD+nNK?=
 =?us-ascii?Q?QVpYNPlKhNJAP3e6L4CheTtjOUaOcUUXJv0/eD6jom6R8BFnhsFS1pmWuRg6?=
 =?us-ascii?Q?aHrr1zChTwnR7z3JPq50CaexpNZ4bK2STN33vbtxzVHXCcsELa5TCJ7miGZZ?=
 =?us-ascii?Q?tAdovDbiwoqC//k3Utdni6QVMIvlHwF9pSnueSMRIgbFSOmzXQSZWx/+XXwe?=
 =?us-ascii?Q?bM6PNA0+iM6ROFwhV8oi96nGB/evAUDBqJKpXqmNwkmz5yE30MF27dC1x4Ee?=
 =?us-ascii?Q?t5Al5rQtM5IPzddptCycwdUQaoM7980qroOp0D/nDT+3wZCWCNgCdW4UfxRH?=
 =?us-ascii?Q?jwhEJ4n+5kB96N78j66945lJwtS7fONuiNb3Iol12ORtZ+hlE5+XZihLGIQ2?=
 =?us-ascii?Q?aNoJWfl7uLTr/85HZL0edFvyFf7k0U9xjnsdmlTxQQbEAma2PF4BWcx4j6US?=
 =?us-ascii?Q?TWpS2aQH9Yia2TaetGusfQpjKXlm6bcXXEDLmt7UXwD5mitNH06+qW+PtNxn?=
 =?us-ascii?Q?xi/W6QA0GdhksiSf8nY05R4j9GWSQ6yCDwmptcwgSqf1Dkr1qOt2QhL2lSon?=
 =?us-ascii?Q?vkcN2szp3PO7jMCRtW3MOvMmPFDDL22Sq6q9mGS8QnXVjmc03lyzaA5l0hRM?=
 =?us-ascii?Q?hDezj2wC3+1LxefHial0xTUokbXh7Yk+YxvOXlDKTeWg54PWiqGonhlNz5RA?=
 =?us-ascii?Q?vZJFJxcqSUpnoMwOXiwF1EEChwIZMx7CjnKG8sPl5KLoQlyhV4Lqse+sAxbC?=
 =?us-ascii?Q?bdewkJYxy3qJnHp+CrJ1JWvOY5Ucx7g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66258f2-e30b-485b-cf00-08de6b1eca45
X-MS-Exchange-CrossTenant-AuthSource: DB5PR04MB12203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:41:52.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w52TgEQ5MBdFk8IWW9m9wlgHJR/RgvbOIBsA041JV7tpghGy36thbv5o1VcWbPf4PKlbWOdLfiO2iRTxFoHER8UpmERnzQ0e9sQnt8fJMSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10708

bap_data_free() was calling bt_bap_detach() before destroying
bcast_snks queue. bt_bap_detach() frees all streams but broadcast
sink setups in bcast_snks queue were still holding pointers to these
streams. When queue_destroy() calls setup_free() as its destructor,
it attempts to access these already-freed stream pointers, causing
a use-after-free.

Fix this by destroying the bcast_snks queue before calling
bt_bap_detach() and ensuring stream references are released while the
streams are still valid. This matches the cleanup order already used
for unicast.

Crash trace:
  AddressSanitizer: heap-use-after-free
  #0 bt_bap_stream_unlock src/shared/bap.c:6384
  #1 setup_free profiles/audio/bap.c:1123
  #2 queue_destroy src/shared/queue.c:60
  #3 bap_data_free profiles/audio/bap.c:210

https://github.com/bluez/bluez/issues/1866
---
 profiles/audio/bap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 90a978667..9108bf729 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3822,6 +3822,12 @@ static void bap_bcast_remove(struct btd_service *service)
 		return;
 	}
 
+	/* Clean up before bis_remove and data_remove */
+	if (data->bcast_snks) {
+		queue_destroy(data->bcast_snks, setup_free);
+		data->bcast_snks = NULL;
+	}
+
 	bt_bap_bis_remove(data->bap);
 
 	bap_data_remove(data);
@@ -3938,6 +3944,11 @@ static int bap_bcast_disconnect(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return -EINVAL;
 	}
+	/* Clean up broadcast sinks before detach (like unicast does) */
+	if (data->bcast_snks) {
+		queue_destroy(data->bcast_snks, setup_free);
+		data->bcast_snks = NULL;
+	}
 
 	bt_bap_detach(data->bap);
 
-- 
2.51.0

