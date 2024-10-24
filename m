Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC41CACCC
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767804; cv=fail; b=H7MFbGdQNH+m7ufVfalwC5yV4vLxgicLshyPRNd3VvSIUUag3FPRHb77PiusTE6SdvWI1Gj0g9+TQBquw4qqc38Ztf/Ch0zxIJnMlVPoW5WAj7WMkWfzTY2y2RBqj+keYWKsDtmioWIR6OSLljM9dxhpeFp1EFBWUMkWpkeGLdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767804; c=relaxed/simple;
	bh=A0KlTM+60pSi/BKDq4BjaLDPFP2MgJPBvuFCET9441Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0Nu/f9023+h2YxexHTwTODo7oFAAObKox3ayJdB1Ac6GooRM0D7zpq0jZch33/NuXSHjRerS6pduYgb8rPqowjS0Wxil3flCsvOr61NtygU6aV7HwgRaDXByssA0Ex0m8LfKMYl8bGxVx4jlnpyzte5ZwNABDN1kcUZrcTw20Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CG7cP3J4; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CG7cP3J4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAtPMl6aLZ+fyyQrY5lFVuYIfZKzGnhiUB01+AhBBr2mSlrVgMC7PI+SZaMK4FifLuuhZswegL+0QcZAbYsEsO0AwyQ56vjD+V24myl1vAHECUubQAHFKpu3BaXNfk3dhEJyAfdah70eDN7RM0yCC+K7IDxa7kIolnQjO7BTESqaOpM3tWqt9NJZD/NCJvFZT0CmFI3wxHBnX0Zc9C7wnpDFM/KYgYU9dj2NQPJu+MGcEnECoqIsRZnA9SHwjyFshAxGR84x79s/ymAf+8COGRa8dZTV5Hq0pBSAJJp16KHX5Nu8DGNi55n8gLG/PTvmnh++OMb0ER+QmQIyC5i12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjqyURUXzN1ULLwz0SXvnnDaimcQuKYmFBvTLDq0ePM=;
 b=KjFKIR+WLTbo8NNwbeFsSBOzm4Gycph8mgYXJP7Guc6dYXO9lBWZaRpMttubJLVTEZx+MdeDgkqBvscTgCq4FT5NjTxS2hEt/9QlEt7VV26UWiCZIRBns9l8qjlHUgM6yZjYIoZh6Y2fTj60YXGqWkN1Dlip4dtg6x6c+SjOFxKjyoMJ+7bbMQGXhhB0he/nfz4+LRTot4NPLTwikesHt9FHOP4n59ahytihCyaYWhSGkPt0M6QTiNU+4hD4/A07QtygD+fTAqgrC3tkKbPlDjY/5LnmDCqYLe9F+p6so66fzDlvnkn7qEYJ2rEwsFA/ToBIz1LernSKfWql0XOgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjqyURUXzN1ULLwz0SXvnnDaimcQuKYmFBvTLDq0ePM=;
 b=CG7cP3J4qqN/0mLIjGGMV9V1GYufS4nM5BqIfYEK7MqHMPiramScflW4wTvFkVaWwYGFkq3RLOhXeRnT3fc69jWFNQJNDPk8oKkMwzgmG6tWXaxLCAiOoSCsZunDHiKBlfiJqmImnRXStnlhSsOAhccWrIgZjMuFlMRmLC/tuq6FODNErbRA40DQpE4O3xzJ/6jP+oV1sKsEzkRRJ7fucugF6N/hdp3N7fLqph/3y7Id4gy4WItREhZ1br/WhkYw2R2Ric0o60iIEIRHMFxIhDJBEwlAvkDNYmSVHGP/YNLiJh/dhZG+6kpp0G0GuiBZLRui3vtb36DXG+y627TL9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 11:03:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:13 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 13/14] client/player: Add support to select multiple transports
Date: Thu, 24 Oct 2024 14:02:22 +0300
Message-ID: <20241024110223.77254-14-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: 319ec9b6-de89-46e8-4af2-08dcf41b749f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPwXyYa3dmKGj07hFbXKWmhTIGZKRKg5eteMovvnzqsOcVUCg57BmET9HNIS?=
 =?us-ascii?Q?B0Xvq6IlWw6ItmsSxhCVLkfcu5ENCcQWTXBoQkMeL6/8TTsfs58LKOW1wXC6?=
 =?us-ascii?Q?/MeFjrI43Ft9G6s7MLR5vFg0Gf9dXYuN4m4LmRiVRQgXof7Z+XMkrVb6Z32X?=
 =?us-ascii?Q?aIhS/mDRY4ccHhLviX2XT7zxJwOZasY6aAWN0WTgNXlkNLRomW4mpMegikNG?=
 =?us-ascii?Q?avS2vyZl41kdktrRn0Yq4Y4/hrRAnHizOpeyGnyp7O4VZ9KcGn8gqxcE19A/?=
 =?us-ascii?Q?E8cKqruPNw7uC2FWPdJ0V1Q2/l6iwm87RufK0gZv0iRGFXhR4C8evQJZFiPb?=
 =?us-ascii?Q?xipyRZ84abfMKfoNu3JuXPh5m3De1dAgQ80fRQt74BdcGtf2kZZTXhPUfbT9?=
 =?us-ascii?Q?GNxWbgf7uUQ6GnkyOOQLv36V8vPDs92RDdc1bqDQxBoPEaWvM7tZfADzKkod?=
 =?us-ascii?Q?v70rzjWYRNV0lW7EaU86IymorDmWeb/BMnWfINw+QNROKn9n+h3pa9DJhVCZ?=
 =?us-ascii?Q?2JRFyzJHzQRalBzh9Q9/yXlE5I0EBnIIJQAbUZeqFpGnVyNzEy4tToCtLF3S?=
 =?us-ascii?Q?pF2O24mYVoHbopLBqXBOo1dTfk9AE7Pri5424YNkEA+DBA8X7zoxFVnS8Uwc?=
 =?us-ascii?Q?Bswh7ErNavrq/69lN/y+eIiwELL93Sc1Awd/GPBkAvfrz9ITegxgZJT2Lgl9?=
 =?us-ascii?Q?OXo5jLGLHMl9y25THDK6IX0x9XQV8LSs/mRSrhp0vAJvQ9/4Rr7WGXsILD/j?=
 =?us-ascii?Q?pnfU51JtTX0xOLyyPyMHvTAo0GViCeM3fDeoDUiVyKmcGSUZ0PES37E08/CX?=
 =?us-ascii?Q?UPblN4+GxvfsBbiVCmEed98Mc62llNc55PAz9RK+CbPzSI7fCH08tf9C7xoa?=
 =?us-ascii?Q?coWWWxhHDcZtTjSvwOfYN+DNSfQTtyOptpHddCOlVzw/zD4UCvVoAODr1IDJ?=
 =?us-ascii?Q?7f4tz21ie2qJaOoU+ObHXg0X45W7ccLOE23qlJl6uuzMrJikcOyl/U4e9fHG?=
 =?us-ascii?Q?Kc2+E1mC+25LynXQ6yvfCKq9KZmuWgqBWHCP7fHBVWKqg0P02rjcvGwu14cX?=
 =?us-ascii?Q?m8UG5WihgDjwzGF+XvzWzWJTS8zb1tTtncMgb1NCG8jKz9X9fl57hCLi2HV5?=
 =?us-ascii?Q?TjkAtGpdwZnMWt+F2TrjqHtDyWq4tTeE+DRn7tlGXtj6aMB/IKDzB2t55Sqb?=
 =?us-ascii?Q?r3H5ycDijSvPNusNpk+ukdkuRf51kfwO19mcA67SGbQMepz2VtSqxQcwSDxz?=
 =?us-ascii?Q?hcWntPNxwaN8oWS0M6Yue0lbOgjjzQLVclMwgNzTOa/fGERzTPRP9CsfxJ0F?=
 =?us-ascii?Q?zJXpSssGBf/3BwmMj9keRuHl9Fv/mjAXZu6OwJ49Sx3VxfM2Bz+3pvR+hZi5?=
 =?us-ascii?Q?jV11lys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYXTYReVcPbw7+ZPTH+YCBLrohqrH1F4tRy4x7gq5dShCJ6HdEZpB1MPGCaS?=
 =?us-ascii?Q?R/9IRELTl8qsqmnFU0WY7SG4oQZIEOnY5PWp1C22pwph1rZU2bgFVtS5IlYL?=
 =?us-ascii?Q?S8MvHj+i/Fw2IC9EG4QqmZSdOGCDHwI+X629ZnkvScUSgUYsybKjBM23qzFJ?=
 =?us-ascii?Q?khtaC8VWwl8wAgSf2gSmFgVl0h9gfrydIeNocgtZcW/Fq6SBAqcoXjwKgRNJ?=
 =?us-ascii?Q?EnpPPGm0Zzb5XY/1JlvZBvPoYFtH2EecmadiMTwnGHyWr7ZHDv8pRtat7lny?=
 =?us-ascii?Q?QouO3E0x8hwPb0lcomaEt0IMZjbABYFMOt5098PwpR2Zeo31TrP/pbl/4tfv?=
 =?us-ascii?Q?n+ydsEGKADi3xOcQU0u94Uy7rW1vHLxAk/a0QQ9ylPNyjMU24KyumtMpR/ss?=
 =?us-ascii?Q?R3tJbW8fDVEBBFUouGnKL02sSKhfGlkGQpWNeRhzFEUJKwNjdRsxPafqdaNK?=
 =?us-ascii?Q?DZkxOtd1/fqqpVSPprWJZh+oKTdY2O4IdvcnNTjlqPdVsFl9SOOIYBnWwPUp?=
 =?us-ascii?Q?ufAd49ShYrTpf/Bn/duJ7jR2nEa1QlGFTunK/emHDNhU8bTrT+tF2M+bJmC4?=
 =?us-ascii?Q?buptoMWOmVAO5I5wELB3Q5ssvDoSZMAtJ8r/U5A5Dg5NFX+7ylBP0jevyk7G?=
 =?us-ascii?Q?mfPRjSxcQjic6cBrYqxMeE0/rEfE1pD3xPTo3bAD2ITDNCCWThHPUnCb5BFm?=
 =?us-ascii?Q?E2VOwos+vf+Kf9KRQL6Q7gaxhX9lXQcUDSdnQw4Y662Ckdhjsp1MUBxYCQBa?=
 =?us-ascii?Q?3Swr7yZD96LRFv/qur7HjGGR/SXJKyaJQe6F4VJ7JQ73T/+xE6k99nJT56V/?=
 =?us-ascii?Q?6lrqH2/aAnwsbOqlyeQ2Wmgi7DIWx2zFWvtXckw1Xjw/NN6fM7yUzC4TbwzX?=
 =?us-ascii?Q?FQkzK4yTERA5WBqPpyfCU1CJuJf2E9u9wMK4p1pK5VaHDHIkKHdk0ARdMIsz?=
 =?us-ascii?Q?L1EqmdwbFjk4OkOeJ/zn8emmaQ4pACQxwWPBLieAZHaddORQ0j6vZvXdFPFd?=
 =?us-ascii?Q?nVQGfBwt4FtAVIXf/hT3X8BE+sFmv8OcxWTa1qgaSlSLpmHI4WXP5B0t9r8y?=
 =?us-ascii?Q?IyGDuV48hPfTzsORi4fiSriRref2tqfFC0+13ipj0rF7K4E7kUA0HeNWTo8x?=
 =?us-ascii?Q?HvqKFvmnWaLjYRAmj8PXyBE9fc3yNuWwyc+jlzSNO0YyzG5HMJGkAKkKvGjY?=
 =?us-ascii?Q?P6oFAIHx5vjIwAWhCWV9xJQM6mxWcelPzTvI+HLEuGwlei7m9maKnYigrqb/?=
 =?us-ascii?Q?43wVB2HGp12wBlTy1JG35nsWhRASJ+jcKYOzimh9X0+zJ/6Z7JzzxfVu9fRs?=
 =?us-ascii?Q?200dDiNw76ahL/qzDkFiILJf8f80IXd4GQf1m9BqPQvY6QfQQTeYLvCTZDqn?=
 =?us-ascii?Q?XrXHp/XproYG3GYWs2ohTAQYettEi8Q3e0246AresvCLHGHAET7mu6pA0kp+?=
 =?us-ascii?Q?tbp3s0ENqUirbsuSCPad4zV9aXbuEB5Xs7QJabnUrn9t5TyvgzICmx/J6AIW?=
 =?us-ascii?Q?7NCXiYavg1EvZ5aI9qOK7f2ENfzSIwnk1VacGV4Yde7d+y7Wi+RNhLZgfp0z?=
 =?us-ascii?Q?+M21SeWhRqvpi5ooqpBhzikp8ZdV0Ga2ezTdY3Ze7el2Fvt+g30YeSXFByw9?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319ec9b6-de89-46e8-4af2-08dcf41b749f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:13.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF4zr7sXX+dNz0LIyOPe72mdfGgZeX9Pz7T+wRLZL51cpYdqL/BIG1O6tm9zLs8ueSQGknDrV3WlAqyHZOio4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

This updates transport select to link transports together before calling
the "Select" method for each of them.

The bluetoothctl log below shows a Broadcast Sink detecting
2 streams from a source and selecting both of them. After the
first transport is acquired, the link is created and the first
transport goes active.

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
Capabilities:
  03 01 ff 00 02 02 03 05 04 1a 00 f0 00 02 03 01
Metadata:
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 17:7A:80:64:A7:93 17-7A-80-64-A7-93
[17-7A-80-64-A7-93]# [NEW] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [NEW] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# transport.select
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: broadcasting
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: broadcasting
[17-7A-80-64-A7-93]# transport.acquire
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [CHG] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
                Links: /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 acquiring complete
[17-7A-80-64-A7-93]# Acquire successful: fd 8 MTU 40:0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: active

The btmon log shows that sync has been established with both BISes:

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 0 us (0x000000)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 6
        Connection Handle #1: 7
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 6
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 6
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 7
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 7

The second transport can then be acquired and it will go straight
to active, since the fd has already been set:

[17-7A-80-64-A7-93]# transport.acquire
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# [CHG] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
                Links: /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 acquiring complete
[17-7A-80-64-A7-93]# Acquire successful: fd 9 MTU 40:0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: active

The transports can them be released one by one:

[17-7A-80-64-A7-93]# transport.release
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# Transport fd disconnected
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: idle
[17-7A-80-64-A7-93]# Release successful
[17-7A-80-64-A7-93]# transport.release
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# Transport fd disconnected
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: idle
[17-7A-80-64-A7-93]# Release successful
---
 client/player.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/client/player.c b/client/player.c
index 81d967a28..66a26ef40 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5173,8 +5173,9 @@ static void set_bcode(const char *input, void *user_data)
 	g_free(bcode);
 }
 
-static void transport_select(GDBusProxy *proxy, bool prompt)
+static void transport_select(void *data, void *user_data)
 {
+	GDBusProxy *proxy = data;
 	DBusMessageIter iter, array, entry, value;
 	unsigned char encryption;
 	const char *key;
@@ -5220,28 +5221,62 @@ static void transport_unselect(GDBusProxy *proxy, bool prompt)
 	}
 }
 
+static void set_links_cb(const DBusError *error, void *user_data)
+{
+	GDBusProxy *link = user_data;
+
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to set link %s: %s\n",
+						g_dbus_proxy_get_path(link),
+						error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Successfully linked transport %s\n",
+						g_dbus_proxy_get_path(link));
+}
 
 static void cmd_select_transport(int argc, char *argv[])
 {
-	GDBusProxy *proxy;
+	GDBusProxy *proxy = NULL, *link;
+	struct queue *links = queue_new();
+	const char *path;
 	int i;
 
 	for (i = 1; i < argc; i++) {
-		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
+		link = g_dbus_proxy_lookup(transports, NULL, argv[i],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
-		if (!proxy) {
+		if (!link) {
 			bt_shell_printf("Transport %s not found\n", argv[i]);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		if (find_transport(proxy)) {
+		if (find_transport(link)) {
 			bt_shell_printf("Transport %s already acquired\n",
 					argv[i]);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		transport_select(proxy, false);
+		queue_push_tail(links, link);
+
+		if (!proxy) {
+			proxy = link;
+			continue;
+		}
+
+		path = g_dbus_proxy_get_path(link);
+
+		if (g_dbus_proxy_set_property_array(proxy, "Links",
+					DBUS_TYPE_OBJECT_PATH,
+					&path, 1, set_links_cb,
+					link, NULL) == FALSE) {
+			bt_shell_printf("Linking transport %s failed\n",
+								argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 	}
+
+	queue_foreach(links, transport_select, NULL);
 }
 
 static void cmd_unselect_transport(int argc, char *argv[])
-- 
2.43.0

