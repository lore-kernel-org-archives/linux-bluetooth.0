Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2079.outbound.protection.outlook.com [40.107.103.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412322960F;
	Tue, 14 Jan 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851180; cv=fail; b=As5YA0HaE7rIIjSQke1Ozc1AsndG2DDjDFENXK4F0KdkausjznQoZw5eIkgDurubTrOAszZdfncVxFx0Wd6qgnez9GVrxyG8XO5xCpa9+SB1ioJjCjZNKGTNHHMq/U4pOF1Dkv+/If5uyZNQkyfBGF3fgR0u9AgUF2MORxIkPKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851180; c=relaxed/simple;
	bh=UQ0FaUMyXuG40irhvZaCghudS5tNONtkGdr4OynJ3ts=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rIlIKzA5IUIOmmP4sH8oMe3sGkIj+M4/89jaJ6CQ9MmQqzDJ++yTijVbjiQ2vtAQSu7MzbfhMgeGp00OPwD2Ek+W5abhCHeZt0lY6/hCCFWFWDwwt1GpEMhR/cUIN3X4MPdxs1sIk7HohP460knxny70izF8L5qdaC2//hk7tGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F6T9pSDc; arc=fail smtp.client-ip=40.107.103.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F6T9pSDc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUsl3+v12l7SpTsQmGeTdNa1ppee79I3UCRcBkhCZ32et4+X/Me+R1imckbCaYKAW8TRTbCZYWpjYFKDjSSEZMUdUVkR8TD3vrnOz1rxXiDhD8zRDcn0Gc6nus9aiXaZoto6Iar2qODPrPFI0TVlC4oNpxj96jAnXS8v1DIyITJcmigpISTF4v2CUQpEyPRiwKzMRy0hF1js8lMYoUOIf8uTjeJetIG4qS4Mhk7dnPDWR9vkNEzXfx1pOoB8VnivH6UAigJc8w3OZvd50UsAAnHReHtZQ5baUj/NWZ5KY35IirrymWsvcIT8Hxv6jjWka0qhWvO9bWm9WZ/pm0xBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO3eyccSHUsJp3mIaTWIQXc5Vj2Ix/okFK3QKKDfhn8=;
 b=t/eWgs9EhbEUIBUAnMm4HHHbsSJcM5trWkssFixxXFzMjSke7wo25DyJH+57SNACeqLPA6xJgi/G+/dIjxiFSOkRurv5ORwjHQoH3f+L6t0PzZ4/YH2+uP5Q8mg1RIf92MHvhejXswMKRetDzli2vGToUDNRoTkWRzc9teU4dslmicimv22kJg/pVMT9pmiQy7mouUKOH5wuzfZsLm05XxAbqZenH4Oi3dgKry/0CbrN9YnvhOfWJfVJOlvNFB6rms2iSlEzuxyuisDEA6YCu1HmMqrSiVZc7TDVP5q0o+rDWQp76Lx/LejrtgtKWsae34nFn84wRLVqIQps4Hmxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO3eyccSHUsJp3mIaTWIQXc5Vj2Ix/okFK3QKKDfhn8=;
 b=F6T9pSDcDx9A940Dkjk+vdkFePS1dTy3zVbncel4w4h+9AnjoQTcTOAwEHGK6gFm4+xr5RehTP3zJlZ2vFi20AiJvt8cBkyIV+xjqLnY/tHLNcmQ7clRQEZuc/ocgdDfVlj/5NBkomSg6B/8rTwan+fqcIIA1cJALO17iznBXJp0/Q1AEZnUTNjlSC+z4oLCyiVAwV81H8XLqM9TsYqqdMmOjuszXkOTLmr+2lk5CIIqlvv+LQWqL/ONG+DK0chN6r9AO+ZYn5prcGFsrOb36Z6lCKQUy3DGyaHrI87AbtUhEOVF9ohDIZEj5QzxGtMs8hRvlxmcnfIcg3Ho6mySgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10377.eurprd04.prod.outlook.com (2603:10a6:150:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 10:39:34 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 10:39:34 +0000
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
Subject: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
Date: Tue, 14 Jan 2025 16:10:32 +0530
Message-Id: <20250114104033.2324297-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB10377:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4645d0-1040-4d7f-14ec-08dd3487bc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jvCnlm2YI+ZpesrUZopDL53rcsxsCmMsBlB4Ibfhg2Ztct5zSruJyfNIXaoc?=
 =?us-ascii?Q?Yi6nPhZ4iODk5L6JC231rT8RMEdnxRbAsQf4kioz/+BGuM84OCTmqOse2Dmx?=
 =?us-ascii?Q?BDhg22i0Ofuy8wM5Q57eqzH0xTQkrR4UexBswtl0Z4th98AjzWLmEz+MaN1P?=
 =?us-ascii?Q?R+dtt3aGCuvVJoBJioM01KdLpzAsFHRJHt+Gjkha/S76gSL/l9mMTQmgWSPr?=
 =?us-ascii?Q?1g7Kh0zpDcwbKUtKCV9CEuidv6+8vEjAnUIhkUsLym1guhiND8ATB5JyAvhz?=
 =?us-ascii?Q?AoV/tnADXmxLmoq1tWKJG5GGOOCO72oOOSHVVwGR6UdQ4HPdnAt9cfbLM2tn?=
 =?us-ascii?Q?FlsiuojQaGuQU2Bei8evXJbtCXZ/mF8qdb3kKSFDDy2UuAkA1SWoe1gO6/CW?=
 =?us-ascii?Q?PaezyfeEtCtGy46cMk4OZ8Oj8R1YEBuZppY8xywl/yNVTsF8Jyt6dc8cQznO?=
 =?us-ascii?Q?hY8FFiq3H72/S+NjgSbjBsFy/B2El9lENURRPgsFQ96xzzeuUARn+um9w6bo?=
 =?us-ascii?Q?ukQGYG/mNwwuUo/uye8JD/LpL/FvydPWMUoHfEgrYELC6g79ad9b4qcX9u1i?=
 =?us-ascii?Q?MlR7DyzPzORfQw4cxwUQW+/xm5C7ilOr3noEIWHYzIol2REr9ZUPfIXAhl1f?=
 =?us-ascii?Q?68yeUR91Zqa84BPBTfph5p7EHa0sP6mppf4Elf9CQuloPYZlJsdQfzcfweFy?=
 =?us-ascii?Q?LlyuO9J/7PjjZNUwLR8GXMMb07+/iUiwzkFEvEEj8RIgW8eH5sdr9JnAg+v0?=
 =?us-ascii?Q?2vSL7oRI0qquqgaZbppekBTR+sBFprS/ZUjPGtxzL758aTFo0DLzOG+PgnUk?=
 =?us-ascii?Q?c4JdeTtWJM/688b9P3pWCGS4m7rDwjI5axMeIVsW7fL+vPMtzrmaoaK+UQqr?=
 =?us-ascii?Q?lZmJSCy6N+LKR30u8vOPB2ae/5O8jjO02QwhvQ+7/Zx91f4xFVmqMoj1nUCU?=
 =?us-ascii?Q?jOAjKC29W/erPnkZ7pOQCwstRWAaPyIZSb4s8D9/ahVj96cyt+F5h/LG4S1J?=
 =?us-ascii?Q?Dm0S5yCunAPyqEosC0UA1Nt8FiYymEQWSvbxH3hqmbMZpB6I5KJezHZ7NMP0?=
 =?us-ascii?Q?j6nyyjBabLNoglEbiLzKuH8IpjYmazNZ5DekdErMXBjN435BHCQDv1/hb0ep?=
 =?us-ascii?Q?l5wQyBcm2eRYQtISFcYJa/HVXZlGx738DkO7Vqrsbn8R+k2cdYzkIMYlxtxi?=
 =?us-ascii?Q?Qg8cfORjCuk8+EZ6BIzO9vxCN6l25sIGz7S+UInf2zq+/puPEVHeKnnYA9gc?=
 =?us-ascii?Q?KsxQVvtCGtv5IzhGEhZmDamDnYasuQEtDQQDgFBW2IUa24vo3KdIZbxKCSxb?=
 =?us-ascii?Q?ajlBBQyijdEpknGpsj45toB8DmLzL9zfZ/5qm9xo6QF46nibws7dxfxsc6Fa?=
 =?us-ascii?Q?ub4aM0GGkFrBPEnvvk5fWJmIelIQKZQsWZ8xxKGmpDazSaHEA+tZUVKluJJi?=
 =?us-ascii?Q?WjqTDAzGz0GBWLqoX/s7t7PauLdv4Awj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPyu+IZBUn7GnoLLNkfwQUvckHEn5ZaVarmvgnSqc6c7I2aaAWXvWP/yx127?=
 =?us-ascii?Q?HdDgN/pfZI6eDckP+FYkJxJuBMAUP8upV1zGqEzAuF5ii7N6zoB3Fc6lGam5?=
 =?us-ascii?Q?CyrT9KFX1vm53KEq1j3GYKgtaECWfuSZ1JuzMCRriWV2OFwQFiG7Mmr1Ggon?=
 =?us-ascii?Q?zkiSvN/pf2uW1nOdWDxZrn/hXLb/XH89Nw1ufLA7taTeaGXtVJ8vVah1HlIc?=
 =?us-ascii?Q?dQwakLccsjdX7lRCqfXWPjLA88rltyGthAkvoa1lhcSYJFXx+eqMAYjxTJXs?=
 =?us-ascii?Q?68BDYrXYxaTOYicAWujs1dK+avvfhfkLjUaBaxHKwF6KJqeB0lhsIG3ZWgqx?=
 =?us-ascii?Q?vvDj4yp7vnYvDxMYOe4dyd3dWPI1Xm/kobCBRcPXtR+jQWjUVESoFMqiycoJ?=
 =?us-ascii?Q?958ehWbBPaYvOnOQPfpuD35NleDKdkMNJ35cGu80IBMSTeTuG2m3JP0jevM7?=
 =?us-ascii?Q?1Py0T3/YZOH46a5nVp0CntOXGMPoGDT1ZBZnoHiNs60WRkAL0rsuIayevKEK?=
 =?us-ascii?Q?GXF5sOfIfaiB/WtyPF2wPWWOamgsGu3b1jGvDXNcilKKaSJIsXJPyalP5meb?=
 =?us-ascii?Q?vx4/22U1fTJ1WA66thQm+CwDD63bNcrgHgHqHR8FLkGnvby6Ui0e+pkM9cZ4?=
 =?us-ascii?Q?Loq6jO3QG2Pm38/rAWoIKxF1rcgkFHNyLZokAtiGhi/MD6jmXMgYHtzeIVNy?=
 =?us-ascii?Q?b6yq9F6aqra/ezt6mxy4LqzV1mKkszl47Y9zQN4Kth6Fq1GHQ/NxasZ3vrPO?=
 =?us-ascii?Q?X0pNR1xxBuf8Qhu4fJsbwe1t2zx1E+OyMPEvYapx46rKIGQQMVQP6qf+LqtD?=
 =?us-ascii?Q?5RZ87dA6XW7D4yIttJl4OllZiica/WeSQWPwivNQWPD/jVUWdbOZaamM5MD9?=
 =?us-ascii?Q?dqgdmJj5NAHDmPqUEOllWiNppCNR87FgpSWa32u441uRQj3O9iy7hpPZDxRA?=
 =?us-ascii?Q?ggWhsNgLl4OZyPvFB4d91LCNpIqe/lifW8eNDLog5vnxc9vYXXV8eAdFiLd7?=
 =?us-ascii?Q?XH4n8vGYEXaNRgEW4VRudEkuUp4bnV+CVNw03t29HutjWN5dB1onIZouAh6C?=
 =?us-ascii?Q?SBM1Zikc0RYj4N0CffBap1FiG2jGvLrCoiGg9IuZLe10IllCRtuD0+TJLLAw?=
 =?us-ascii?Q?N4v3b0NjOVxOMp+MeWIbVWvxB1djCjnwG7fUGBOg1PWRMZLQvwwdAr8/9hgx?=
 =?us-ascii?Q?mhTdSzDiKMY1W90SZ0SDFkk48lLGy9DpKnc9SUHX9G+379hFrxkLpRoZGUeV?=
 =?us-ascii?Q?vqXlpuTcgLuVMV9lfTwgyzbTag3BsPP8R3rdHYPKy2PKb6FSrcPN28hQMeu+?=
 =?us-ascii?Q?IPjCNWfTUL6Wt+A6uu90ZVfNzJVGrJEuZfrIhqNELOs6urT4l/j/8t0J3Cyw?=
 =?us-ascii?Q?eQJxTM7VkKRsI2w1k3Uvu4diGzSnDAURwqc+8xWeoLShCc02hlvhE/6yXk1w?=
 =?us-ascii?Q?PnDS9EEw5rVCF5MUkdHY/HgDqG8JU8o2k/ITUntiFzQLabn7Fu/SWOh7IQAk?=
 =?us-ascii?Q?yQbVZ8vfUy9WTXcgW/St6mo/q7/Dcxf+yrXwtvjhVmTdfU6kFzJ9a4htxmSr?=
 =?us-ascii?Q?Pc2VQM9ffVxj+xhxYvpcQE2mqhvax/yXOimFtfZG/H9ATVqGwH3tPzvgvQib?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4645d0-1040-4d7f-14ec-08dd3487bc0e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 10:39:34.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xa3Ts3uTnMrMICHFpRo+Je1eiMTnNF8sl9h5ZobpbNvuT1wNq2qQLq+0ZK0RMd+Xarmk6tQMDTmQkixmieednu2h7YCSXHFGR3jmlltthk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10377

This adds a new optional device tree property local-bd-address to allow
user to set custom BD address for NXP chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 0a2d7baf5db3..beae21c3758a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -40,6 +40,8 @@ properties:
       Host-To-Chip power save mechanism is driven by this GPIO
       connected to BT_WAKE_IN pin of the NXP chipset.
 
+  local-bd-address: true
+
 required:
   - compatible
 
@@ -54,5 +56,6 @@ examples:
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+            local-bd-address = [11 22 33 44 55 66];
         };
     };
-- 
2.25.1

