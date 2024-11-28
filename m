Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7A1BD9C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809273; cv=fail; b=d7ErrCmagzjtj4rNvzeUBaV71xnWVXoQZA3u/ydJGicLZu39PUXNq8BE8e+z1EcV075qJ3p3daQyNXS/BMdZIY/1ciN68OR617iO9vgIjbWQHo37c8R9rjPtgswQtHNBxXHB3j+tVZqEcHWxED8Ksw8hC7PDtCFpTpuucg+bnwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809273; c=relaxed/simple;
	bh=UT7xkH5iPcLXyX2lIjVbavLvMyLxPC6TNYb6kC+cYfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ia2whnOUkp6+p+TdTuScVapJPVkQhqU96raMCjlMC7AfUrKrBz7B7gFkKF5Ra+K7Q9JM9sGSO6UxXq3e3j9DIFgHKG7H9mZZ0us5/81g1is61igukeck39D4o8QEwVZBHnPlL5wXSNvx40xcjwN8ejI1hTTuLDIt3QfS2LAgv0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iY0QStXk; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iY0QStXk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9iE+7xkQgEZP5HZpFPlkA92Iri8ITC5KNsGJUXfNtbV6GMKzAZtYSaHt4aLEFVU8JK2srCviyP+0gUWx78w0zyaR9thFiaoXGkPRhT5sXxhXTG/wML2HQnpCepGRzhnqs4HRfLeU3hquBk0HIvv79WNTCcTvq1cgR60MSX+nnPSw7fjdEEO83BtXcsYAPxN9YNA8mt1n+4SoaAn+eKyE1gObLRZcfPi/NNruQwHBsufAbvUX26GDtGGw6PBfYBYmrQvV78KiwGZm/fMwyILrYcmevxKrjPXqZFmksah6UnDgmomrTGn37y0piIcGA7xy7w1SNc4SSRBw6Ieo8kgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eB/VCxUN9R8QlZne/hEJxZnxygnGxlcMOyN4APYeik=;
 b=p2Pkw7CuW8FSdwRm+yf44HjIuC78YdCols5Yix4LwRNUEBZTUdw+aUdjNrNh5YJcfByf9GNCtO0NpocU/8NveXGzuP/RcZDL2uf5544g7b3wGsQbWg0A4SHm/O0JWXrw2ravtDoS0r97fSCW1gu9DW7DZV7q+U42o6nk+v5hvX3kF6LnDRMnJZvke+P/sDkTLm37aYztj/Z+4RyBBfoz2+/4gaB15g6f44ZRZ7gvqUVmjsmqDf3OtmKujsGrbAAYkk3jS50HuepGNH+4Q1hv1XYdxwauH8U7cRAtghgsUjVT/0a4KKx03LFmSW1gOeGhgwaV6/j9L55wsHAs1vfCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eB/VCxUN9R8QlZne/hEJxZnxygnGxlcMOyN4APYeik=;
 b=iY0QStXkul3QSYY1dI/nuPS0b1QKcRRuowB6tEfUDvn+b6Z8Exe/1kyOZemCtamC63DoG8pdQsYl5ZPo1F0yORrYjIS3Nkn2MVzMIROw9RXiRsTN26CsnwckxWtvwjJobvI1MEe9ZVWQFMCpqoS92ehoVDBQG52fepcO1WkX+/c3tWesNifK5Ru9yjjOZ75pWeOzvJuoKdXo/GYBdPSAKBm/Hg3CgaWcDX3VmZwdGLUqSiOR2zMF70DAZK0uJjkihXcXpKWWzyDn9b+83c/wh1Uy5+j12fDOzx+vYVCB2M+TSfL9A5urfs3b6WJwMPkPwrwz+KQMaH0ltP4FVuZYKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7626.eurprd04.prod.outlook.com (2603:10a6:10:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 15:54:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:54:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: iso: Allow BIG re-sync
Date: Thu, 28 Nov 2024 17:54:05 +0200
Message-ID: <20241128155405.14910-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128155405.14910-1-iulia.tanasescu@nxp.com>
References: <20241128155405.14910-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:208:1::26) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ad1cc7-3654-4b6a-f180-08dd0fc4eef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4LSIMuCYTnK6xFjeKsOzbhTkA2I5Sg2FwRUC1HOtZjR1RBgRpJbEY1kXVUX?=
 =?us-ascii?Q?AxlVF8MwmYgopMJd3A/06JBBgvrpknNN3jIG0Yu/DLOPhFkr6K40gzz6g9Mm?=
 =?us-ascii?Q?C3sup+IZwUb57Lj3cjsYmDQSw4YxhUngwOtmH6avOOHSeiTiaxSr7XfG7A3f?=
 =?us-ascii?Q?Ev11OpjJX2QuVmMa9MgJtKAplGX/5c+nJ6jzgXGZMPYVDNhR28oaHGQc/crV?=
 =?us-ascii?Q?NOVFzMIQTMrrwK6vnEy9AcxFHpcpnI2jwYpXPcpDIssawzVE9j+zgcBL6LmF?=
 =?us-ascii?Q?H/5yF5mILpMLfDNFX8T1fjsVsB4McR3dZxiIY+O3IBcUTknakm27/zf0M5vh?=
 =?us-ascii?Q?eHlNmPhN1K0FqXgoqGentZGREwNs9hEcIqHJVJ3LpZ5CU/g4o0yUZqeJT7uH?=
 =?us-ascii?Q?KFptTWGu762pTfOftYOb/tFhrerj1/jQeGhHcg4S3cE1ELtgUQJ9E7U0WeOH?=
 =?us-ascii?Q?yqSQrALuRg8GZclGsJuYt+w+Ltgd29n5xq9rAPDOuzSNOYWRzdompaXG8i6t?=
 =?us-ascii?Q?402895anwHj7PW+LNagUx5kKlkyBKN6UesiAg3Dua79jZckhFNDOeDu8z8Ta?=
 =?us-ascii?Q?svEutKzWQ7nOFVpczsKMvpUlHMXFe6+ZfJ5xvpLqGObDj4TOIILW+x0yUa+G?=
 =?us-ascii?Q?sRuibPiS5S4Pfvtsa+ziyg1y7yzaAnbH39sZBV8JZ3I+jb5RqWd1E0V4X3MF?=
 =?us-ascii?Q?Rx8L6bhlK7F24t8Aa4mokDqtABaDvBgGo+PsdWIjE2S3UZFwpFPZTCgVmQ/n?=
 =?us-ascii?Q?Nf+p489Z/w2YSOsm6M/vbifFa0TvHApNQJWwE4a6HJZHhehyUK1uTMPnt7U9?=
 =?us-ascii?Q?yowViebs4G83pSrIDHiH92jBk54xx1vIWYM/Osy0ep8vaAGmSy0igW05iHvC?=
 =?us-ascii?Q?CHyz2jlIUVlA5dSEGu6GJVAhaOTs9sS9oCOimfwH7ijVH47itefD5Y4aU4r3?=
 =?us-ascii?Q?T1kWKROq8DJ51VljVoL+n3vGP9Hc7mqXLjsYYCL/t/WdKu66BdN/fkvzClnh?=
 =?us-ascii?Q?ebleTlTRqygQyfMnJUB6Ckp1rRZBPITdO0wR5E8k+DEKGTmxpCr3MGPkNZ0f?=
 =?us-ascii?Q?tWKzCTsG2Sv0wuPULKXelICGbnTjSZcuhNY1dxMpSjR+Htnrejw8GQ0ry08N?=
 =?us-ascii?Q?r49S9tqe1TdRelEzJyFOHP94fTPaFSHHSxaFez6coTbQRP749qm8N6uFjczW?=
 =?us-ascii?Q?3wI7iBiLyw6BsjRDcSAqHYVxLoIxfPPC0wUgV7Po1MIuKuQm5IpvT1QU1FFT?=
 =?us-ascii?Q?tVhKOUMHIH1mCBkF9nN5RZBUy9cb741f0pLIDdnBFEXVhCUNdiDOJUpc9jv4?=
 =?us-ascii?Q?BLodR94ZFsfXp24d/iDyEv8RH+WWhgBlDk0p0kLER5nowQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/I+M9ZeveG6krGaYAZYvBX4lyMnpgAXMHJppjxxF8zLgG2sucNFZjsJRNrXE?=
 =?us-ascii?Q?fLA6EOAsMk2DpzCyYYZC16Zm+/HgXaNQP1i1MCIrQqQue+tMyE4y209jPLYB?=
 =?us-ascii?Q?1Jl5HbD1efnLLaCctuYza7vinRfMcgo0V/Lj8DX7ovbcTRxLAeIySXvZ7NOl?=
 =?us-ascii?Q?mAejZjhi82RiRmLMwqVD71neuHbrlK7SRdugo8qsrJ11ilqGi2V+I4xDtcgq?=
 =?us-ascii?Q?xWupTh30kjcYXr5J4ARvNM1/GSAg5huSAzD6lyFvUWR7KeeO6mEfSTeIR/y9?=
 =?us-ascii?Q?q4xYM6gW225R0zJEjp2IWj1+Dehd4CO4BgiISGL9KvSSOB9s/Wm78AtHnMYG?=
 =?us-ascii?Q?yUKlML4R4brU1h1WEbxrrG2uhB0g4XyQ592hgrRT6BInsurgLG/DWXOvn+D+?=
 =?us-ascii?Q?TIyUoNWQE0lcjFnJnlXwNCqTtE1m1W7CISkkkVvqySDMXfHzUEq7lxQ+P/np?=
 =?us-ascii?Q?cNaG76eQT4/105mRSZVzixQbzF4XL9t3HtY1d9x49bpeMoYtfFDV6g32G7Fz?=
 =?us-ascii?Q?Y52J3gN1bFBnhtO1VKHPt2Tw1vdklcf6gGGCBNp8K6IPTfkK+2QLkml7bw3q?=
 =?us-ascii?Q?DVxmw50UT7eX0O0DTrJTPt+7oEWN/dDXM2TiVQGvhkKMzBaeOyyBGAxxxnIO?=
 =?us-ascii?Q?j/HiXJnts2wPi9YYBJSb8iFpn1LSkkvQXKmqAeCDYHfDSfZAchRDsb9HvnwG?=
 =?us-ascii?Q?mpWGRt1BIjqx3KbptpiSl3sfYp2NWyujnFznr4v5UfBkk/fhQQ5Hng5jNT4X?=
 =?us-ascii?Q?qnZ3lvSyQlLf/M+QZ/0/6/2yKfC61pjnNabuSPvBr3KbBlJceQZ5oOdvfYBE?=
 =?us-ascii?Q?IofcYZ1CXwzMSQiKuLXRMZWGel7uWBLFGZyt++ClJuRjWfRBc/SWiPA7rZ4x?=
 =?us-ascii?Q?fBAwtmJOpdBQvjOqsH9K7egv+FICY4IFWCT9cVUFjN+B6tAtSQGMN3y5uvZQ?=
 =?us-ascii?Q?fMnzLa4wDmgzbZVqK9Rbx7h5yROjg5EGIZwJYbb3OzWB5sg+vuTickgA7o9k?=
 =?us-ascii?Q?F0TtGSaUxBYOxlXCfH2sEgY+SEDE/v2pp3ZRlwO0VIxujt1VOaYhJ7VKKhju?=
 =?us-ascii?Q?PpRTmPTiuj3GCF1L9SC/6mLgKszisN4tS6WBjKmmCWMsh/AcrmcZnI/dhb5i?=
 =?us-ascii?Q?HM7LjNjjXH7iC0Taz+HHdoYoVlAb68LQIK0aNVz3wSR2EaqR6daD9mxXGr+G?=
 =?us-ascii?Q?QTcPLdWOeCeR4nR2zJ++p4ZywTx0//Zb/oVR/ZFpckPtz0daOEAdoM/QUrq1?=
 =?us-ascii?Q?4rRXFFC7QBWnO/hepM04BrMOW8Rc3Qi1T7f41VT4eLhlI7hb/ucmfg1JDgH1?=
 =?us-ascii?Q?W58i3XMwewW0M8OSFET9y0pXIldrgMIv+0f3t3zVwbq3Gkbza0g8tdHgwYAu?=
 =?us-ascii?Q?W25vFq5bMW9tIR/Cyo3ie69tuJ5Lo9ClvsMDct0wYE4X3k/wGTw+Qht6f1CN?=
 =?us-ascii?Q?GqL32O+fMfNHSJHXgozJgutK0y+KQD77BnKHs+4C8yXjLAXguMdMAdnXjpYw?=
 =?us-ascii?Q?pHAr9ZMG3AvEOXwpx4stSfwqNuBBljw7lqvvNO0Fnm09BTjMj+Kl4RwFXprv?=
 =?us-ascii?Q?LwwlpyuJcSQWVsx1SZSjM10F3j5CV2iM26aNFydzWZYGxQ2cbTuJbjVrr+1e?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ad1cc7-3654-4b6a-f180-08dd0fc4eef5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:54:25.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAutfnYRCAuOTHxZIcaRYU9MtRfFcdYqoUCBoHgzRbVs7seoSABXgVidUREf4ya8nxrthdfGAQGtEBLU7Es8mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7626

A Broadcast Sink might require BIG sync to be terminated and
re-established multiple times, while keeping the same PA sync
handle active. This can be possible if the configuration of the
listening (PA sync) socket is reset once all bound BISes are
established and accepted by the user space:

1. The DEFER setup flag needs to be reset on the parent socket,
to allow another BIG create sync procedure to be started on socket
read.

2. The BT_SK_BIG_SYNC flag needs to be cleared on the parent socket,
to allow another BIG create sync command to be sent.

3. The socket state needs to transition from BT_LISTEN to BT_CONNECTED,
to mark that the listening process has completed and another one can
be started if needed.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 1b40fd2b2f02..013edb19c4a1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1268,6 +1268,42 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 
 	BT_DBG("new socket %p", ch);
 
+	/* A Broadcast Sink might require BIG sync to be terminated
+	 * and re-established multiple times, while keeping the same
+	 * PA sync handle active. To allow this, once all BIS
+	 * connections have been accepted on a PA sync parent socket,
+	 * "reset" socket state, to allow future BIG re-sync procedures.
+	 */
+	if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+		/* Iterate through the list of bound BIS indices
+		 * and clear each BIS as they are accepted by the
+		 * user space, one by one.
+		 */
+		for (int i = 0; i < iso_pi(sk)->bc_num_bis; i++) {
+			if (iso_pi(sk)->bc_bis[i] > 0) {
+				iso_pi(sk)->bc_bis[i] = 0;
+				iso_pi(sk)->bc_num_bis--;
+				break;
+			}
+		}
+
+		if (iso_pi(sk)->bc_num_bis == 0) {
+			/* Once the last BIS was accepted, reset parent
+			 * socket parameters to mark that the listening
+			 * process for BIS connections has been completed:
+			 *
+			 * 1. Reset the DEFER setup flag on the parent sk.
+			 * 2. Clear the flag marking that the BIG create
+			 *    sync command is pending.
+			 * 3. Transition socket state from BT_LISTEN to
+			 *    BT_CONNECTED.
+			 */
+			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+			clear_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags);
+			sk->sk_state = BT_CONNECTED;
+		}
+	}
+
 done:
 	release_sock(sk);
 	return err;
-- 
2.43.0

