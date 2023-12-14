Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NqdRTBmd"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561B11A
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 03:04:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQWZsSohevNU6YZHAhQZ+RRpFKlFiL4IcvtXV+nktgRG2XNytzl25rp4vQx3E8v0rfh+ASlY3laqxP6RnOQd8hgJ+9WJy0xerliP+CqiFe6w0KBpig7vqO6IR/8DFxk46YmnRM2Pcw+KXodakLfAXRoDfocwjIP8xgNu75Lp3Zjex9vBj3Hhdf0n058Oqh9yqn6d8rk4ZPoE1d7diWt0a6T3XqYC44KmpC55dDrN9wvW9BmH5SvoH7UWSigBRL/jAdKkJqehNjeZvE6REf0/jodz8egQimN7o9XhITDXaWMqc4SJW03yeeb/kPM9N29yE/otBk9RuGvUHm3W6ScZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J96sPXpB/VHcMi4kxunevg0KS2UrOK1XV1BiAWhrgBY=;
 b=f9Ch5ZEHUsra9RTpfS4Tl8EONU1fsXwrZPxWfubxWmu2W6NWBchg4S3WTs3/c9oqk0Zyo+flKnXmJojRHyq5VGc4rVAhdtQXyOHyv6wZ181eN/NLvnBL7BOPlu3OV0zkbXWByTrGFuNyEa2wpt5+J8dSbOhkmVN4zlSdBUs12zM8ZznHkEqRcz98c3tKa20UbVHVZF8Rsu553nuKKZs/ZMhSn6GGRX/UtlJJwoRpx9a5UFkS6148Qc5R99vSmngK20m1ET/GVGceir5Er6NuNEvyBs9dFsZBOHkDvZQyX4z+GXjzvZFRB/gyL1BpvhvNYBPaUnegh5dErb+XwgxVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J96sPXpB/VHcMi4kxunevg0KS2UrOK1XV1BiAWhrgBY=;
 b=NqdRTBmdczowLRs0ZPLLLYJ7x1VRHKYSMeg/lGfbVFH61T1qjZzM1Ur34hRKFJhdDCgeKTdG2DjVRDBc6Wuui3B4/q2vHmpQ96lDlaVNeH9pxzazbSb1qeXqjLm36yl7WXkpJQr3AH7B+2EEARtzr/PeEZYBSoOAYlbIsfMz9K0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 11:04:16 +0000
Received: from PA4PR04MB7709.eurprd04.prod.outlook.com
 ([fe80::9f65:a4bf:7753:21bb]) by PA4PR04MB7709.eurprd04.prod.outlook.com
 ([fe80::9f65:a4bf:7753:21bb%6]) with mapi id 15.20.7091.022; Thu, 14 Dec 2023
 11:04:16 +0000
From: Vinit Mehta <vinit.mehta@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v1 0/1] mgmt: Fix crash after pair command
Date: Thu, 14 Dec 2023 16:33:37 +0530
Message-ID: <20231214110339.1763-1-vinit.mehta@nxp.com>
X-Mailer: git-send-email 2.42.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7709:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: b145efaf-e583-447c-ee39-08dbfc946961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OIv0DdNnSwvktWH3YgrVn59OtQ3rcYSih4WwpE19HdaZEWY/J8aUKVYu9SNxkf5GDJ/jnMQwDaqx3cyEpQ31L1GTLmmuE0zsSpbYIL0zHNmYEjRPJNFUbSgC45WHikOCzmtmZDp/ga8XNCcVNbvcjYdWFxrIHLl5+DNFEisTpXgGilsdoJzdIhPHYLy2wRk/VEem0pvmDB2NJvy9Z0jkOxKRrR35yAeW0GOjDXycFc4UsZ9xR6br2CS970z/L4oySb3zQ5T31x0iu6065RMxXQCVgkmYR0izfUSQbe2l3X7l0GTQajw9pfhqCy/ZQKCrvFGcjsUJlFUg+UqEMMxHpuwY1BYkNWTdobAGv+pRXISDcOVW0RKqH1rJUdRuCxs2HRN2eYl242n82PgWE5w2PRKudeHi1ajXR/MzbX6+HePG3lp217zOGOKcLFIlCMF1mw4H/uXxzdAEvlH4inSSvestEXKHQnOOwhNbLUKRcnPzTnQdl4ExbL+adk1nWElWiOJH6sS+E/6T5w4zgX/J4NT8LAMSduqL+FLRc6GafVC40afJY3FMqaXk6VBVVRQWj0r+6LTZmg41cI7P4ya7gc93p6X3YcoerXpX7fjDX7bu7US/ccfKH+Qr/FbdeYX7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7709.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(2616005)(26005)(6666004)(6512007)(6506007)(86362001)(38350700005)(36756003)(38100700002)(5660300002)(4326008)(8936002)(8676002)(44832011)(52116002)(83380400001)(66476007)(66946007)(66556008)(478600001)(41300700001)(6916009)(4744005)(2906002)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gtBmONeSRZQDHvAaYMyQKC2NaleqgFpOnGV72fZ4FpTK/Qdlz56ouRc9R30o?=
 =?us-ascii?Q?yQ/3NfrxuKU3q5qAPhABG78cW5n6UZaRgPdY8jTSCGHDXw9ylfljMOifu3sG?=
 =?us-ascii?Q?gbO83t8FCYSEC+GDEkApph3S8bbLvBq47O2DV9LGiba2HKiWwrjIclUIpiAE?=
 =?us-ascii?Q?YOWElnkp5OYsi6zNxEmPkesK68OFvbcwNo9rEnIEY/4JMvCFT06Xjfv88/11?=
 =?us-ascii?Q?7seYyRW2AsT6ckBMDvgKUcWfeSidZ6QySNKRox0RBcF1bh/L5BolcrpRISjS?=
 =?us-ascii?Q?9EBIg1SQtkhOwmidbhj7EcRMGgRO6mQ6vf3Ik+1eI50T8DR88bzzr/wTOc3Z?=
 =?us-ascii?Q?xPXX/0v9mR1yn2GmRthokddYl5R/EikIjoVWvWkYP6LyqKHhjrPQTOfYpL28?=
 =?us-ascii?Q?HSolkjKaZmYjfkFZT2vF2geI8nQYMrNOe87JDpi5wGeIhVsTZpf3LbzQGVHd?=
 =?us-ascii?Q?1UE3g7eIwHJZynmxca0ONM10Z4Z+JIcJFQVcrKGrEy5manLtG1QEhoFKsYRh?=
 =?us-ascii?Q?wme2mUw3VZlXTIdJTLCHj+p+AedhgAjTxJusxCo0zXO4awJ68751jgEgJXMo?=
 =?us-ascii?Q?gooNQtb3xZLZvtvFv4/j3RdgdKayaWB8p4J59udZGsPtc/e9zUSX8hMi8YuU?=
 =?us-ascii?Q?bHK/wllxkI+q4/QX8Nd7KT6vaAc6UsNDVH60htBj4WI2CZTrye1EQ4vY/b1u?=
 =?us-ascii?Q?ALuOD4TGa5DsrU8TRzOJQ7U8hS0Zp8OXzOnoTB+9noYxLzMChNwZaP1ceHrO?=
 =?us-ascii?Q?dI8u/WxhRpIv3FNAk22BcvxKduZPwPqEFyhpPJYnCGd5sfWt3XcwaZOXQQ6h?=
 =?us-ascii?Q?CSjU+WrOqG846HyQh/H61AbxVDEL+fOjbeYRSZr7Z/Zhf5ADZ0ofPVMgBclO?=
 =?us-ascii?Q?TCRH9ki38+MYM5TolED93mhWuDgFUEzvOYrQWlkWYaNIjomXNzWgSUZ3x9DA?=
 =?us-ascii?Q?wKVgkBD+nbB9UJxvWXpMw/71JPnaGlLQSb97Kd3smWk6UFG57q7cKrkmlafS?=
 =?us-ascii?Q?zvzaF7oyuuX4uTMQm7jSc4F/2lCNeZWKAXi2/UI7K0U+Q26HiUHxlCltas+E?=
 =?us-ascii?Q?DCFYPj6nDiWUzgN5smQqPYr2hOBXQWLkhSryl2ottbIYAU8fZKdZbFm/i50o?=
 =?us-ascii?Q?d6EoC0W2U10BKnwnF3hnwbg4nc8sIuPKJCU49K2sJvS4LkKj37q3Pqo6wd1U?=
 =?us-ascii?Q?4rfHlZK4IKdeFcDk7VF2Do5Te+O1NtjLk3lbIXqWSkxRY8fHfeAP9Gn+Uk6X?=
 =?us-ascii?Q?ASRMtwCyIL9K6mq9xPnH879/dF/TqkweKOEX0WYZ222H9VI0gaJzVU0rTSi0?=
 =?us-ascii?Q?HbRHJfeAc9mVo9rc0J7r4oxwcl2W/nxetXykvV5aEhd2bbWnBYIvvV9+P5d8?=
 =?us-ascii?Q?m7/CsCGMRCX1JP30HHAOyw9c0Q/s57vd47Pgunu0z6kFoDBa6vv/O96Knx2c?=
 =?us-ascii?Q?Rn7dONe3Pcw9i9jGQuNpaDSO/6kafQWTa4Ws7dbKkemKIE7796UPyzNuk8fr?=
 =?us-ascii?Q?rrk+ne2j5Fly+0JoKOrZ7j4CN7moVwx176ze8czzTXAXGTYpp8qusNy3DoGp?=
 =?us-ascii?Q?OhWkXo0Ybj+GrRwQTlbvukSFHI5lHN6o/rnH24dN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b145efaf-e583-447c-ee39-08dbfc946961
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 11:04:15.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQFYSn1+3HkDw1Rw6hwBHCPDsiv8MRe/oPt85zzKDeGb1CcdsTYEb2CXMiBX2lXy1iMbJfs758hkI1wbBoVnUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042

Hello Maintainers

This patch fixes assertion in bluetoothctl client process

After pair command, if the user doesn't provide any input on bluetoothctl
CLI interface after receiving the prompt(yes/no), than subsequent CLI 
command will trigger a call to DBUS library function 
(dbus_message_get_no_reply) with a NULL message pointer which triggers
assertion in DBUS library causing the bluetoothctl process to crash. 
The change below will ensure in case if no input is given by the user, 
a conditional check is added to handle this scenario and a default 
character ('N') will be passed so as to avoid the assertion.

Thank you in advance for your review.

Warm Regards
Vinit Mehta

Vinit Mehta (1):
  mgmt: Fix crash after pair command

 client/mgmt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.42.0.windows.2

