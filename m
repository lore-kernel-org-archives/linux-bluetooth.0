Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hy7Ta7Tx"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79BB120
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 03:04:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODesKXfYphCa66QNQDlGUOdDtVbI5LvuKuXTNUBDXg1Book8BKrDiJ+509FoVKm3uENkn3uKDS74DozErluPLX8Z06zUHsk8lx1+sBOhs3Dz5QGTQWvOiHR9qMBOyR5LnsgV+wMt/RNv+jYYxviGxMvwJ9tDD3Tl0EHnTGCxJXy2PY5kwyO90pe50M0Dr2EpkInBA4L26+i2v26RFoP08+qJv0YNUn8oOl5Dp8GbHnYzLVP5iQuAu5C2w5S734XbNV3KpHXfrnAZsycHHtaorSSsjPOPMTjUCW8ABoG79r/V2XUXtUZACxmq+Vm2mobz/hj4mzYx5cRbFsY7jnc4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYuuFBCyKpQvNxSbvDzNCovuE2DtcuMS9lIHsEOlJl8=;
 b=JNjuPkkaBH0YfwQZ1MywhcNPeDCGkn9XwcmSfiU79r6ihCjwBRaWz5Bk+yrRqJ/LaYPzMKfK67Rcj2o+XMopomIZve4cjuXrus8vYH7QdH/3Lul9I8Mjnu16/ESxMnSYbB2LcuTqIpkGvscjR4jPzgrG5sYosdJnqlttEniuhDYlfSdsHka92n6iWO0DN8tCR2JIxHpmDwCKwMRfInt/CQQOv+7PyfOFbhP879nm4Wj+PnSEKXAAPf4Qs68YlwhkqukHOAC8Qzq0naBkssoHAIqogwZ9IdOvRIrQvyd2cbh5vp1VkvJKAi72p4kcpxtZh9+l2xteRM57WOfPjPY82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYuuFBCyKpQvNxSbvDzNCovuE2DtcuMS9lIHsEOlJl8=;
 b=Hy7Ta7TxasUoQ4qc7P4SBOefT5X9BZjxU3xINAer76inbwAbtxW3xb4MnY9T3Yus31k/7a2YaqGJiNHfg5PD16KtFqmhBsEs8ssYzXhvN881ZttVjvarKu6s+rrLcKM6NZDxZl8fR/ydYNgDXCnKbpejseFT0vhG/zxjc+2vmm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7709.eurprd04.prod.outlook.com (2603:10a6:102:e3::11)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 11:04:22 +0000
Received: from PA4PR04MB7709.eurprd04.prod.outlook.com
 ([fe80::9f65:a4bf:7753:21bb]) by PA4PR04MB7709.eurprd04.prod.outlook.com
 ([fe80::9f65:a4bf:7753:21bb%6]) with mapi id 15.20.7091.022; Thu, 14 Dec 2023
 11:04:22 +0000
From: Vinit Mehta <vinit.mehta@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v1 1/1] mgmt: Fix crash after pair command
Date: Thu, 14 Dec 2023 16:33:38 +0530
Message-ID: <20231214110339.1763-2-vinit.mehta@nxp.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20231214110339.1763-1-vinit.mehta@nxp.com>
References: <20231214110339.1763-1-vinit.mehta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b119719-0bea-4c61-2c17-08dbfc946d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0k8RLJ5HGb1TkZqhSTe8g9CRhGNq6J4a0sDThUqqIZbl/p7JxsiCdNUzA+QweuOxmybV9edVb82n2GHy5zhxBX0LcCflo7s1fWpqpeLr1Yl1ebOLYDswFL3M6KnWbziATmSuqCxdTGk15r9rvndDzFWuN07Gal0Pyy+Kmx7N1NwfWw9/Gi6R6kbpphMYWGf+cq41Kp/pbXmg6CaXZKQ1wukqpPhAPs3mI9FoQRf7bCAD7S91bfUG6L77w4XZkzsgbHEPMWrz+Bgyho/YJ9IwrfN+QJBRwQqY126fAUrf8NRPdpZM/1Nfh1Elzvzcdb92smupeaTxEz8mxTaAou9JBaaqsL3eePK8rlabJM+FrMO10Ld6/yoiU0C6c1kK1MuVYRFpRJsdzrDXGkFm3AeKZEbqfzFhxwJPAA27PAB3rSfdJ4/S11hUM9b3SIPIiFiyeF+zvVgEEuTSZJAmHMkALin2qjVrlaPPpEqFyHEtR8aOw9CTu3aaiQUY8CLhCgwEm3/uMIVPJXF4RiNRNx0yBK6VgMo9i8TDu+k3HNO11RFpkHwrA6zo2b/13EB0g5UWUOhqd212LIXMOTxi68xo8+XM45Qt1IN6szdrkuKP+v5oQ/TI6joZb2j3HGYhIstC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7709.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(2616005)(26005)(6666004)(6512007)(6506007)(86362001)(38350700005)(36756003)(38100700002)(5660300002)(4326008)(8936002)(8676002)(44832011)(52116002)(83380400001)(66476007)(66946007)(66556008)(478600001)(41300700001)(6916009)(2906002)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RrflxE+M50dQ3QW9dX4uLrj1ENCzYx8vSEGPAmS+pwHWvv6bJuQ7gAN72Wt7?=
 =?us-ascii?Q?x/QtphAdgIoYDGdLjzh0r/lLKjUiUGLfPQ47emCxJLRoHDcM+q80yWqIfTHt?=
 =?us-ascii?Q?cq8ihAp+0Z9YCfiIUSv8/63EaQOo3ZP+tPMPuB33jQXv5EmVOqJv3c5R7nmU?=
 =?us-ascii?Q?G56NGBA3KxuKYlBIfd5kIOPgMK6VEIIN/qk7SQ8G1qKBabN+osgkDyXk5DcC?=
 =?us-ascii?Q?lBYgEEWLTWpJh7k8idQNbkL6242c+mM/WoOj6Oh4/HvhejJxx7g381xRjXrR?=
 =?us-ascii?Q?VZgSQ6fhVHPmATKR+QELwkUFwYzaonuCo/0USS0oI62Ks9leEqp1oUJoi75P?=
 =?us-ascii?Q?UqyNMD4+atJAO4bWt+zHIoml1w4Bqqo8KokMSJa5GKpXBpJkWAs1YXEWL5jN?=
 =?us-ascii?Q?maJ7unmqF3wG/mnHy8VHEP+lxiTt2KUY931PwJ+QgS2QsGNLviiYk78PuL5V?=
 =?us-ascii?Q?IZ4ZEMn5wyoesgWbIOtgGXXpOqtkAl7Ii4U3O2VoyW0EAUPG4b2BvwZdiZFo?=
 =?us-ascii?Q?s2h9JXB+StEh5ewY7rIZXGCGALpjaIIzDETOqo0JebybVmB1H+uAMbyyoimr?=
 =?us-ascii?Q?WaBV3R9b5Zvx9NAt5YHcDEyVtrGLY6Mt2xMXIfS5imJjrzJqhV56TFYg+00Z?=
 =?us-ascii?Q?xqNtORQqWb24Se78Y/SvTmvG8W8KgnPkpmXfy7GD25f8kDk22+D6+b/5+lAQ?=
 =?us-ascii?Q?tsh+E5ONGaPg9+qtWXNbNZAya+EkKveKnRW39wlCQYC00Lx5vA1c9agiNHCY?=
 =?us-ascii?Q?TaTyo8vFZWKYlhjPJfAxiyKGE62OKZ8EjgPNxvTsEvpRj+HH2W0NIcN7bCYi?=
 =?us-ascii?Q?8kLqKY8qVUbf7yBqS7Lpja/kjmRw5l/F6t/Dk4FHsV/700SDQrg+IF2sC4Cz?=
 =?us-ascii?Q?vutKKcrgkYp40GctgekHSofYLGfMbpP9CqJZ/7c2yLg7KId+tEdy9lsfMH18?=
 =?us-ascii?Q?7Ih0sD14YMY972+/p0TIkCyyBFJAhtfbkXqBWzHcOyO9ojAXg8az+EfzzPAI?=
 =?us-ascii?Q?/c+slqYBmKOlMbUEYg5foHZ3KLTBnScl0JQXf92C7XbnVpGrA9oysCEZpAWd?=
 =?us-ascii?Q?gtKqPZbLqDQqv+5ZgPjVW/kPcuyboH0iqpYM/kodqzefxO61RBJl/xweJ5ev?=
 =?us-ascii?Q?423ge2j20gxiPHHQdRAVdT0/Ty2vIVEiGFNZkdI2COKgoJgQz7Dl8AmoFfXR?=
 =?us-ascii?Q?pWoqcwMKYw7c1l5gQ+ML3OjtXraAoNrkmn55TNDYUELtyR3p8Sn4hY7vlFAP?=
 =?us-ascii?Q?WnVCtYqYlt64d/mCMmeD0EMEJ8gV8tRtJUsC1EOGYj+NMYf+Nd6ixjNE3KIU?=
 =?us-ascii?Q?MLR1c0ZZJ3Fiw1/LeGZRQM24C06wdzMrx3TyyUeIMNTCKLXfg+oanEArPXpQ?=
 =?us-ascii?Q?pY4fzBtlQnXyVLjYadHSs95UsbCAr7ikBnlj6fD2eSalXOhgJ2/vRVCATESa?=
 =?us-ascii?Q?/CMi5fN5VyZZzdpm4itjmT1sjKUE66Qzwf7I+Antzx9BPcyXgy3TkwZwCJLk?=
 =?us-ascii?Q?FXIlmV3ILCurKC5mbYcSC+cAK9HkXZuMlv/GbA11Zo6RUt+ehzWr5de3yx6k?=
 =?us-ascii?Q?CFveX2DuB65VwEtQeSraD/nIDw87PtgDP8jbsuEM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b119719-0bea-4c61-2c17-08dbfc946d12
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 11:04:22.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4d2duZPl2B+Hvly4M4ek4N0CyWwUan748HjgixRTeLyrPo1aOoBoMwGiOvNBebnOzijfzabqYW85k8fxzsyJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042

After pair command, if the user doesn't provide any input on bluetoothctl
CLI interface after receiving the prompt(yes/no) below crash is observed:

dbus[782]: arguments to dbus_message_get_no_reply() were incorrect,
assertion "message != NULL" failed in file
/usr/src/debug/dbus/1.14.10-r0/dbus/dbus-message.c line 3250.
This is normally a bug in some application using the D-Bus library.
/usr/lib/libc.so.6(+0x27534) [0xffffa1b67534]
/usr/lib/libc.so.6(__libc_start_main+0x9c) [0xffffa1b6760c]
bluetoothctl(+0x188f0) [0xaaaac9c088f0]
Aborted (core dumped)
---
 client/mgmt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index c056d018a..940e25f3c 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -54,6 +54,7 @@ static uint16_t mgmt_index = MGMT_INDEX_NONE;
 
 static bool discovery = false;
 static bool resolve_names = true;
+static const char *dummy_input = "N";
 
 static struct {
 	uint16_t index;
@@ -849,10 +850,28 @@ static void prompt_input(const char *input, void *user_data)
 								&prompt.addr);
 		break;
 	case MGMT_EV_USER_CONFIRM_REQUEST:
-		if (input[0] == 'y' || input[0] == 'Y')
-			mgmt_confirm_reply(prompt.index, &prompt.addr);
+		if(len)
+		{
+			if (input[0] == 'y' || input[0] == 'Y')
+				mgmt_confirm_reply(prompt.index, &prompt.addr);
+			else
+				mgmt_confirm_neg_reply(prompt.index, &prompt.addr);
+		}
 		else
+		{
+			/* After pair command, if the user doesn't provide any input on
+			 * bluetoothctl CLI interface after receiving the prompt(yes/no),
+			 * than subsequent CLI command will trigger a call to DBUS
+			 * library function (dbus_message_get_no_reply) with a NULL
+			 * message pointer which triggers assertion in DBUS library
+			 * causing the bluetoothctl process to crash. The change below
+			 * will ensure in case if no input is given by the user, a
+			 * conditional check is added to handle this scenario and a
+			 * default character ('N') will be passed so as to avoid the
+			 * assertion.*/
+			input = dummy_input;
 			mgmt_confirm_neg_reply(prompt.index, &prompt.addr);
+		}
 		break;
 	}
 }
-- 
2.42.0.windows.2

