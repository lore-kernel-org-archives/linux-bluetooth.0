Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6D16630A
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406657; cv=fail; b=Bp/Vn8ATg0odvnTbksCdRbOyWl4e9rKk/0vJWPrLGhFre0VC3jWM1YTWp0EHccq//PNYHFA2igSDbsf0CTpaYrUR8ALxyhUg9ChOazZD5ZMqnXQtizucWTS25+l7huv+VabmENiKm4S9cQTKwlb+bFEUq5xivEvSPRwB1UUn4QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406657; c=relaxed/simple;
	bh=bcVsmIhRhhMUXeH98UHdauTkucKfIAZrMp37FLycd7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rnVOLLbb9aPhMAJIv+suKxwN9HRqO/aMqhBiYj0xG+UDcAHUmNu6w81bFycHHgA3sQZzSXk8nTsu7UZkxBGjGWajuFYM5HqPrr93GfoAqaq88GxYTVOsFI5XtSDl395cjtgwS/fk+iMMIuLK2Q/umgzuW1zgZTnQeZ1S5EiJfF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XMf5MxYc; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMf5MxYc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSbrkKTaSYgKEqLhHx7jdVapbSvb7umO+FNBSOK4+jIEoVHanGBOP7HQezSiXHGg9H573ZvDoZ4GFo9rMzSvAqbLF1pY1a6gdN6xW2ZsCHzQnCyEH5od/EO/9aa0LgAuRTOoOABad5f0DGfZtmgvHrrDkisZKBB78bNM/lTMSOoTISOoUgsU9me1Tq1pfl+9L5MJqTEoKgqCI2k0BzcIQWvo+lvilanU8hF1tcXDmzAayYlJR/5xXHKhGCzwdrELrvKur/cGN0iYPHCZKIFsgjzF6a8Nc9aaxiDkVUwourRzNoHloOKkPNsRTUon6M3q0EEvmgbvIIPrfW+o3gGsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEieOMjDKfhF9GpI/FDCHIHIW4hX45LdQuq/JJU4m9Y=;
 b=YbU7w8MoDaQZtrgXOqqVy2Z+NtTb2UmB6CQOKnVjqFwe6N0mnXyk6zuLmsA9VEu4tkCfZGyhoWf0ZnzrX7PbwTSJNbaecWpG6ccXgPuAsyTuTF5hbc+DsBniowOKmWdIaDKb6gUSUCoSgVTvmvrhtZwSuqc27sjOsD9/ynBLKTeFSMdTq/wzQ94/d7piO5ErvJ/qtPcpw+g+qd9yF6EF8aM1OVQCJgyj0Rtv9Wckxr1mcH0RTnKo4fZZ7fNnIJl4E5phhxn/7f7PQuufH5JJ1yS8r1fWD/nay2PhZWRbep/+W6ylyZGX205C/KLeFBcPtuyd/HMnu5e2gLpKpN+iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEieOMjDKfhF9GpI/FDCHIHIW4hX45LdQuq/JJU4m9Y=;
 b=XMf5MxYcWeDqk6C2U0Ow4uP3K7gh9nnpvNjNClnPsM1Wo6M6KzBgMakaEDwCFRj1BmOIEmV3VKV3oVoBb1tpABp9IHevunYPFyfjKEN83STk0PWuXiq6FIgt9MMzdCIvyROtIdpekZ7k02dQmsXE11ZJcL7TIqdprytvoed6Jj0MF9/4OFyYCi33cvBqLFEKqin10xbnVQ+q7i+KcLkFxW/G1tYPzWP6ADVY5MB0+y7b3e0e+SXR1cZO1bhHWeN7+kM4XwbjM5bt/DFRPhFet7T6lD6TiBASByUPFWPdqAYq+FAJPp7SVoKRySUMthN0YLxonxSYYh22+c4a6sR6hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:32 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:32 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 1/8] doc/media: Add 'broadcasting' state and 'Select' method
Date: Wed, 31 Jul 2024 09:17:06 +0300
Message-Id: <20240731061713.435586-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
References: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ee4317-0aa1-4d07-13ed-08dcb1287642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?haqBfgkFoSWQq9gD3nVY0d79i+J/CY3rzbbLjmANfIdHqhaZSPPe+D/KA4hx?=
 =?us-ascii?Q?MTiYf8N2U/axNze+deBh3nDDAsZKUL3iSn2r/dz9zfQt1Z6B0gKVwA3b47Kq?=
 =?us-ascii?Q?bSTBeCeZXWBph1RqXlFYk64bqLKcDIkIG/rsguPQdPl2jpaHnjgvWtPam4Ij?=
 =?us-ascii?Q?Z4tryBH+h4WJsf88SVpHhpNcALVq9xUd9eLLu6zr3UJM8ZdZRsj+yZS4/OeJ?=
 =?us-ascii?Q?otaeA2z4F4BBpPwaQnMG5pI967Sf3eqztRZ/CXweYl4Ch2G+SgFKNYiRkWGI?=
 =?us-ascii?Q?Gd0z1uAZuphjZ6wSfI4JYllHAw7Ewhwg+RDS4Rjd3DRzbe0rsmUPWNTOpBdK?=
 =?us-ascii?Q?s1CACdYsC7JFkbmYsjEeGaEmkHMyWzO1g1kRGSQ/v98drEahvXpUKe+qIWsr?=
 =?us-ascii?Q?+R9ZyjPUtfvi/Godre0oZnOqqujRvdcHKOzbIKc/Yyh4t+uqjvw1UDbKvkcP?=
 =?us-ascii?Q?40XeB1jPFuFezZXKDjJwVQurCw10jM0mgksK7irZKJHJo0pgDXB/7Ulru6Pu?=
 =?us-ascii?Q?Skfo2spMdHz0WJLex30TclAHT9Q95KVdneAHn+yoy5gQPnrq60aQiwP0jRfW?=
 =?us-ascii?Q?koFWIhq1tK3v/gnvwxSdH0mPPQ9i9KE8+nyJNOeJ/t4lCBECCt6bGDN6vI5J?=
 =?us-ascii?Q?19c6xnlSMqb36VGqW3t8VvuBgq/+OR/A/KTVgxG8+SYHBdrc8jzS+VOMJEug?=
 =?us-ascii?Q?PYuftsfBGyr9HXvbdkwnpE6X5G2bfXUQrqU/CxpcqR1cXKqzTonwfH/hdR/a?=
 =?us-ascii?Q?J6Aut6VSgHfG4IpGazpi3SQsgIEHTXW4bG3acQta2fznL3nVhNYkBj0FlKh3?=
 =?us-ascii?Q?twBvQ/n/dAlxx5I6sBHQGHnkU/BeYLZbjuqTSmSEoLi9+S+zThLbBu0NUT65?=
 =?us-ascii?Q?B0R+CB7D3cjN001qckwv1Go7eLheY24mnd3OnpAQpTaST/+o2kwW0DfMfJsj?=
 =?us-ascii?Q?rRlIbdDKy9wvHnXFWIcN9l5hxRae4170ltP2vzTuf7gGfmXMYtR3RyJSSphs?=
 =?us-ascii?Q?/RztLrG+yqAt9QhAzo/ErxmB+0q2MtfiIrdvtGYSiOHcFtAtsItepzlZ6Jer?=
 =?us-ascii?Q?A3tUEKLJVswpKBcmEwKtPskAffH9teVidmh2w8NENDJi1R3dNUA9C8eNi1Ej?=
 =?us-ascii?Q?0XR7X5JGs/jaCY4gTAYB4YfXuBP3QVss9yL8zjQGteAyn7XeLft3r89S3EiX?=
 =?us-ascii?Q?YZFh2hJ+eYkMQwm7hdwduiwqALR5SnhPoiXp9IN1+gesYfKF+3nqmtBu8TPM?=
 =?us-ascii?Q?xAVPMTU/RgPDA+ow0lus4TXA+1GKUsN3UvrmlRUCB3Gkex+d/SY/VCjRcEDa?=
 =?us-ascii?Q?Bz2jStEcAz7kvfVPt+NleGEbQyw1NgWS4G3EAfF+C+lWPOl4y7yJCc6cMxzL?=
 =?us-ascii?Q?YcfafWjtxt1N4AjuN3LqGZZqYjfTZJgoB5QOwDQ9IDTksyzNRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+JkFrD2aZMPrhNzNJCim3GGWdI87+Xx6F2BJ1xNj24pN678rMIuwc/C3YYZW?=
 =?us-ascii?Q?lggEGugDU1FtKxjM/LfFP5UnGUdVG4aS7BViIiEjO7MUufGS6ERMMTo/xeMd?=
 =?us-ascii?Q?TYE/BNQF701KiiVL1PyrAGqFY+pnF5Z61Hu8ZixznhJDL6BbyqxPkMld1J67?=
 =?us-ascii?Q?M/f0zlvpnDfH38UnYv9Q/Lw47tRBjo3K8XPCr5Jn5lqReRpBBJ7D+kOakfvr?=
 =?us-ascii?Q?xQmT1vOE8qGXhE6Bg5UD7q63XNBTXaGvPrqyDZZuoeWfdlSHwr76II21QPoQ?=
 =?us-ascii?Q?sPECX07ajBfeBJJgTFZmEcJ7nH0zZUIxn1Xu88Z+gYHo+zd9lRWUiX3Jbj6H?=
 =?us-ascii?Q?IMhf1KdsuJmsx7qXzT0rQQvJb7OvdBlsjYVS2JiSRO4GbGGThYJbZDrUCy4U?=
 =?us-ascii?Q?flKCdrYgKepd9GG0w3y3gxhDe/pMJO6Ryfad2xgv4EC8mRLLx4PQrlUkrK6S?=
 =?us-ascii?Q?IHsN7ZYiDVmis6wNwQYJ2g1PdsyQuYDCu/WDe+jJFwdpEvGPWZZDxKRlzw4u?=
 =?us-ascii?Q?z0VHbFX+FZGFzsdW8Mn3hm360hmyLEcZqKF+3ffTPyvZOPIUbvteW4akB4Xr?=
 =?us-ascii?Q?X9DyGSiw+amqUHxKMqzrLPB+r2tNH7sBPhJiV2lDNPezNCFh4kG/KCSHD72V?=
 =?us-ascii?Q?I5naCWidsnpLeIB/nmNh/yumxUiJYW/MObeBi4DO2gbn0Rf5AymiELx1JB3h?=
 =?us-ascii?Q?Nlefgr0he0GNhezow+NjAsVkTLDGjVFwsqffQwt2YHc+NYvneZY/MA/RThwS?=
 =?us-ascii?Q?8aZFTnNVHk6KcPydfpzEkg/7Li32mzQjc6nXQKNjxzD5TbH1mLqrosNPNHUh?=
 =?us-ascii?Q?zwTlfGSLrLlxYOq3SAC1F5OLOsuh33pT0lSCLIwdSA+/l5KjBlo9GztWvYb3?=
 =?us-ascii?Q?nYlQMsJGxMDuUm56P8EcXMTFKzz7hWacNy0W17hnkTTCvnvFMhfdIM5rfGeT?=
 =?us-ascii?Q?c3x90EOqEk89jXTR8OU+NH3eEclfrp8emvlzJG9DW+0TWl3AgyjrNrU1ApU0?=
 =?us-ascii?Q?R7+0HVaktZYS7BjiB8uFix0W1nnQE+o12lBJnIaKbgUcffJiiEh4P47YJec/?=
 =?us-ascii?Q?+P5M9YQU2j9i8LTpn7L3dgGyLkFlBYCNOXkhdaTeOwdfha9xI+QnOFkbtzuN?=
 =?us-ascii?Q?1T8kNPK4eFZogA7YaA1MREMts9uVMstR69MTSUt9RtW18jQawBnQnt2Pc8Ur?=
 =?us-ascii?Q?2nGKC974+p0ds2RZgHMHYPBiUVNMUX4r/QI4HX6b09mXRbYm5SFneCqAo4eX?=
 =?us-ascii?Q?IWZiVQBeQbwR9LCz+f7AkZH4e4NJpeVzyhZjq+7DguyPueSxwJS3yC8DjDaA?=
 =?us-ascii?Q?sdN74oKWdMilrZipFUBm7TQAPuxKMJljTPLY7zEAA6fZNh1HZ5mf4x72B8V1?=
 =?us-ascii?Q?iAXCjOmsq3XwqCr1mn6SE+pfLXQNEeQdRVStjQZ+FiWCpo8fVBidcxTKlJ3p?=
 =?us-ascii?Q?UJ/rWx6gB/zr1Y2Jq4cYfzaVCBkQn1JNESGS27aRwng3adXtiGcAa3orstxM?=
 =?us-ascii?Q?5DEvMa0o1KkzOqn557rQS/8K1s+qtmoBvnQWYYRDH5hYZZYveXAkFFVVNY9d?=
 =?us-ascii?Q?VZRePSO8Rn0utsBdLMeal6tRVsq178aL4CAT1+Bc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ee4317-0aa1-4d07-13ed-08dcb1287642
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:32.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJaLpvIumHx5w910THRjqHtXhHCGbYuBmIgF1CpL5uA9SHFEfigZhl7JjGh+Jwyz/PjxyAPNVKSjJYsSPyEuAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

This adds a new state for transports created by the Broadcast
Sink. Such transports will remain  in the 'idle' state until the
user calls 'Select' on them, at which point they will be moved to
'broadcasting'. This allows the user to select the desired BIS as
the audio server automatically acquires transports that are in this
state.
---
 doc/org.bluez.MediaTransport.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 6e95df8f2..c8aca0223 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -7,7 +7,7 @@ BlueZ D-Bus MediaTransport API documentation
 --------------------------------------------
 
 :Version: BlueZ
-:Date: September 2023
+:Date: July 2024
 :Manual section: 5
 :Manual group: Linux System Administration
 
@@ -51,6 +51,20 @@ void Release()
 
 	Releases file descriptor.
 
+void Select()
+`````````````
+
+	Applicable only for transports created by a broadcast sink. This moves
+	the transport from 'idle' to 'broadcasting'. This allows the user to
+	select which BISes he wishes to sync to via a 2 step process:
+	1) the user calls this method, changing the transport's state to idle
+	2) the audio server detects that the transport is in the 'broadcasting'
+	state and automatically acquires it
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+
 Properties
 ----------
 
@@ -84,6 +98,8 @@ string State [readonly]
 
 	:"idle": not streaming
 	:"pending": streaming but not acquired
+	:"broadcasting": streaming but not acquired, applicable only for transports
+		created by a broadcast sink
 	:"active": streaming and acquired
 
 uint16 Delay [readwrite, optional]
-- 
2.40.1

