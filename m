Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2091.outbound.protection.outlook.com [40.107.21.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288071B47
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230883; cv=fail; b=NuE+TGvLH3l2nu/kwsNx+/sjqTb51D4L7fBkVENsMUZpXXUHIvOyQ20VjdRbC9A9evyIdWPyN21MP1fTTo5CYWd157X8qAtVhYTxxYkBe1G6MV/8P6C0NivxUDnBuLXyOdrmQLdAhWpB8h41z9bTEvGx8Z3xAr8ewNQD5KaacCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230883; c=relaxed/simple;
	bh=JA3NcS8xGXbCWzKP6ekLZeFMC1oOH1yycb7Ond+tnGY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qNJXxJPq/FyFBBNLGblO593Tlgmmm+PsrWHS0dkAxzZ6N1l7MX/CGtQqw/67dTL9l2kEMICLfOMpYmyzTjad55/hb3fdM0tPLy4ZMt4ZvjVOAAOC5NsD4RjU/vaa7LzeVgWjJYoWdWd1Hv3l/lhGlOAFqW4gcBpky/L8vibwZjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b8aSSpLD; arc=fail smtp.client-ip=40.107.21.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8aSSpLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiFeiVjROHWAmaHMKlmcdhNdU5ldEhwaV9QVSztxVTgDFVcs2yhkqPjfse+HG7Crq9A2CaAWr23q3G67KRmEfsxSwfkiFVawgl71pNP6uivh5LybPVg4Mn2Vq+/Swf/Etme2lrGPkchREYjfjUvtiVLeNqOu0fgbAmw3HSvYAQBQ5qWaPEOWcPwqbwCA+Q41Y2KDjGQOEOB3ZLk1FbmgigpaiRznK8XjtcsPbfLdWANxFVj8s4rvtq1ZZTDQui7yZZGEkbsMJZqAZ3n+OZsYlBptHssHDZzt7e5DzvTETqii7qSVA7Anv3sKBw2Q+PkEumI6dgqKBYGt4ZRGckXQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GLcoUmNJJ42pO8JJafutY95RA1FE+9lfefoj+P+2ZA=;
 b=J2RIlPL54K1qXiGfaVZYElDe8TB++wsmDjtXtmP7aCvfbBS7xDnjjN0iXGIbxkBAX4tV0aDqY0T6el5lM0gEf3hmgm3M8a+7UxQAYiHncEgH8PXnUw/lUlVaF+HbetJBfF5HMqHvKLl6P/mSkZLjP/xr81LKwtDljms0QHiRm2MlxNMS5C/A2EX/XMigLYenp12F/zisISQwxwsB6vVxR/ilbVRa/tvJ0Clnf2yvZz8ssimF6gwUCZ2FVnXNXAh/TJfK4UMTYPtymH98zLMZfZdbxi6cMde2iSH0kO00xgL2JzMlkTbTEjzURCVUWdN3s2ofnH57ofGMP/HruB3vYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GLcoUmNJJ42pO8JJafutY95RA1FE+9lfefoj+P+2ZA=;
 b=b8aSSpLDVGRhnPCVpf1U+SQxIRVjTZdV0x6eyeYCbxQS9Zbs7ac5wjd1PUPb7DJL97QbulCMYpG6/I2sr9dX/iF/LKKmJl8jRPSzv+J560fkuT1vt/TGevPynBE1vbQu/vioVp5MBX8tjWwLulf7Zh8vO0KVpw6P5MNrckOEKAw=
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 11:41:18 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 11:41:18 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v2 0/1] Autoconnecttimeout max value increased to 20480 msecs
Date: Thu,  4 Apr 2024 14:40:53 +0300
Message-Id: <20240404114054.4987-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|PA1PR04MB10443:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C80XfPHvJk66q7xjBweIuOJdAjIXppM/5U4yUAPt/fR7kQ7IjwKKXmJa0KVTcGCuGWjinRGmCxJVbKJSNOEgJG/qY4pAQVL6Ki7+SUpY28yrr5RgCyuqMzDVVJW/iHfowkNMXPtGpmVUuSRdQtM85Szl24mdHrCSDx2XkarphVq/fnQoVqJUIguoQMjufJu38imndJkLMV6tCGSNGLUi+9/txUYIj6Nb/BYyhzfThQR3BYlWvqHhKSSSvYT6wg1Z3pJt2ydgT8AkxKT0GMw61rbI8TW8FxAb8YDT4Ir57aFmglJs3M27C2G2gihk5sHxJKDZVmeYZc7pQafwjohNswORhULQWRJKFyYqSM/o/v5d9UgqtdVcH2Sxh1EyOy+owMcgVxpez3CqszMsOZxF25Q/ZC0n3UyJi0N7gNArNP+NRRcNIWU35b7CPE7T5/vUbSeGf2gK/oH5t2cjXJcz+XmNe+HXyxb9TJOJTnJMgyKh8wCTzt5mfIaJ0NFqLU8UyIKSQ1/EKpx4o3xL0d3NNLV+f/nHqJ7cd1+4V68rH8Qf6oL6c1aFJUE45m6dr0hG4aIZGUKjoFA3IocWPRXk9Hl6KqBYz3pIVpV0UC0GsKtyTTl1e2AsOj0CT73xo7quu1+foWKPgnefyxNeOSaznPuamH0pP8v9OHY/GZKEBIc84yhQm9toCCSC6dF/EkjdoB4MN/nIZgETZ8wYQMJLnA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kuufddYDKzGbphmqjOgxpJ07cOL6dUzZN792UewLxbyuYYdmmEE9xb38Ypbr?=
 =?us-ascii?Q?RXNa7grrJ6ywIg7mNAwcU4DLgje0sDh6ScFbYkRQnKV4dQVK0pCVWNLUQqbU?=
 =?us-ascii?Q?MvkwlbhKqY9P9kxXVxQE1DSAL6b+f+YPPZl8xtTHTa0hOE0F/cD8KB0DWax4?=
 =?us-ascii?Q?szbxCbbRVbBny+EOVvhokoDIBZusAf86KgDN1EgzbbqaGduGWH5q+l0PWG3x?=
 =?us-ascii?Q?8eCDSFHzw+Ej7xkyj5zdBZ8P6onzNNbl/PaUqshdaLUmNrroDuuEYlZjCIFZ?=
 =?us-ascii?Q?Nr9teWVKoV02BvOXnh2G8zbWQfGtYc3uTo4bDGRzsLGpqp/0ADfeMy0+hdpM?=
 =?us-ascii?Q?gWNVLcKFcGOSEQmVYAtC8efKegbE7yGztFYikeGM7Mxc2YONv4iJIvDmXwgW?=
 =?us-ascii?Q?GJ3Jyi9T+OZMufPWDASlF+ycUib6N4SV5zFeC7NxrfqPoN6u7tl9yiAi8NwL?=
 =?us-ascii?Q?IRFqHLQe+DJbxaWk1PRYpiLwNq1Z5x6Mvbc9kr7cmdSRg+erFKQLC4gbqDBk?=
 =?us-ascii?Q?QJZNhAv9oKydcNYdFOa6xehmHE+ZBUqUGdS5njt0nA1aP/R6oS7iPhL6rHEV?=
 =?us-ascii?Q?RPLP81Ke6pu7JdBSBGAoyyHKPNMmMvT2udDJT2TsRbpRXj4R8NWa7sZpy0//?=
 =?us-ascii?Q?CWErShfrTSi9Q3JjeFHFx64M97iwEJRnc/f7TA2YW9U6Wrq2VvM/2npq0i0P?=
 =?us-ascii?Q?ZPc3uY78+caqNzEhijwpaTMBzbyAaJrVZ4edVgPUENe0hvwBsKYnVDI/PZvw?=
 =?us-ascii?Q?2NfdLhtMVtIIzKaGocyU8o/jEaIp0N/upLd5/jbrcPT95tROtbzCaxRcMvN5?=
 =?us-ascii?Q?MPrizJBO2QVy4yQo7XdyXrmmpoJK/yz+Xz5wEy1nqfHkZ8G2FK8tWgB7V2Up?=
 =?us-ascii?Q?ItXKeuZHkAbfCL1ZEbNQMSud1cwZ/ZL8atBmXz0ieXLWNuwzME4QjigPJaXu?=
 =?us-ascii?Q?JwCUA7ZgNoaVuWDfLd5aXc3F+6poAAFummcXcbh/XwEzKqVwnqJP9x3Skv3V?=
 =?us-ascii?Q?9GHP+DUGJs5yIk8GEew/N/BdjzDC52x1GlIswo3SIYSwtnGGqjrBD7C88PKh?=
 =?us-ascii?Q?CypXrJi32MbGfCDnDAvftfmk0e6g7eFDs42CjcDDesph1IocojM27kdG3zKA?=
 =?us-ascii?Q?MNJ38ka/XR+lMmzlGFkK8+jpfGp18UNe9tgo7//lm76CerB2J/sDBAiZUt5E?=
 =?us-ascii?Q?cmvaubqs7ldEjVDu4VURtO7VT6gya9DkYVpuNRHIZ2HL/unj3INxRvOaGYTI?=
 =?us-ascii?Q?IRkbKgK80HvLhhjbYVVoGjJpbQ1cLaXR0SKE+CqHXyBTdIvEyPCjpJVT3rjx?=
 =?us-ascii?Q?qFk+0ZI12fg7Qhw3gc60VsDz9XN53hKtoj1yHiAiB1V+PZBQCYy9vwp6k4zw?=
 =?us-ascii?Q?q9FeQ3fQDL2C4i/64Raj3nSTv0+hfgygzSPNGTpZA75lfNrsYXwNG11Ap46l?=
 =?us-ascii?Q?+gBO53CEJHVs/hKSOy4rzStbmg1W+plLaRupJeM8tWkhCEShrzJ1BsRcRqiG?=
 =?us-ascii?Q?r2pmRRZffCESehGzT/sveHR7NKkh7UQ/xanDyPtVpVe5peFqIM4uBXbX2KwL?=
 =?us-ascii?Q?PZjQ1pF+wdV4mahDwZmvnxBziEjlR7eohVAZkhhkUvFOfhlz2JVpNvV8mT8A?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a929d6b8-25ce-4560-a5ab-08dc549c2422
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 11:41:17.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC/5+5sSaLv3qey6FUaZnJPp1uP6xegMil89kDwdo8MiFbnbhj0roWOn7df2F0I5Hv9RmU+CO8rmTEtdc+V5rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

Hello Maintainers,

This Patch is for following point:
  - In current implementation Autoconnecttimeout max value is
    16384[0x4000] msecs.
  - Since some controllers need some more time to respond to
    cmd - LE Extended Create Connection' hence increased this
    Autoconnecttimeout max value to 20480[0x5000] msecs.
    
For ex:
- In some controllers, If we include LE-Coded PHY in the initiating
  PHY List, BLE INIT scheduler selects the 1M and Coded PHY scanning
  as an initiator in round robin manner, and due to this available
  bandwidth gets distributed between 1M and Coded PHY, and this
  results in longer time taken for connection establishment by
  the controller.
 
- If ref device is advertising at 1.5 sec intervals, with create
  connection timeout of 4 sec,  the controller gets only 2 opportunities
  for the connection. Without the inclusion of LE-coded PHY,
  DUT takes ~3.8 sec for the connection establishment.Hence as described
  in above point  with the inclusion of LE-coded PHY it is difficult to
  achieve 100% connection success with the device having
  adv interval of 1.5 sec.
  
Hence increased Autoconnecttimeout max value to 20480[0x5000] msecs.
        
Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  Increase autoconnect timeout max from 16.384s to 20.480s

 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

