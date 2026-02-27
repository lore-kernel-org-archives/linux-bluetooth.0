Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4F43DA50
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209814; cv=fail; b=WxNL1rjTq6veRRQISgr7BTZ3yvFk1VxRAOVD/tLKV8ywpCTkYces4SsGiDYB1aeBWeciz+mIAS098Wmh9mg20UWIhtokeEiwL+T5abMJuV1wxJJsXRu5Umj2WhkLxK1nzU+FOWZnqCL5EVgxcq7/SJdZjkAwpB1S5PCuNbNqjlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209814; c=relaxed/simple;
	bh=yjLrbhnCQTgmEXgzutKSdN8NkfAlzEE8Uik8vjI6Vqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d607RSoySWvkcJ1SDVoJO6nSUYmIBOqldKjCRtW52EApJLSdksQENq1JxLpqwkV7RgGFveYYa+eRCM2h57RpMEbqbToUOV4Gffz9h6eQ6VV2yOvD6nE5ElsZb/NXxQUkhlEpDBbZZWz+8gI7JqZBBRMZS/Qovhhr7HoWnalZCwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=sQhI/lxX; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="sQhI/lxX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0jx/uRoOX4HSfWjmxo4TAnB6Zqorsf/0i7AafUhM3I3iha6LLJckqFuKyVaKqMyBGuYz5ebYrB3brWaVDNOCU0iooQ2XUogFt18dnKhUYNivF/6CcJLsk+3O4vdOqIsvdzI7nErGU5It+NFjgyRKQF/8bW41WPxOE7A/RGeCpthPuT178FAzv2iyvAmnI+/x4iSI5UVxsMjgs09c1LRGG/+YROU2VIUX2af2omOsLqNZ2aym3WfF7LLp/Vl/ASNQloCu+T1l5eGQeIOCSs2uxlOZdNBBtDRFhvLdLapuvxsmM5UY7EKMtYtug62eo+h3Sw5BIFT5NOkhKGB9OupBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY3QNAQqUYmTwD3qxvJfiWib+2SZOChJ0nbg66YLUKE=;
 b=fBZMAxc9ILXcWTeuhGAxCLNSkptRgbO5/P4Z6yKXpp4VNF50adVRjERk3pwj0UAmH8ioSFZooFsiHFntNLxl2KyuVFc2bBMh5S8u3huIIn8yMT2ySk+ntrkNXBW2xdbnwfN5D7wcjIeP7BNqHrnTn1e3bznuQLYwqgivYQDuPf/rGx9a/hsl03HIH2h7LqXaEsGeRLh2h2Q2GdrH9vpJVRahqExn97UmysvRrxRQLLGQCjT5d2weZyqJ3RRSby9GoQhCm4wIqpTvis9kWeF7H80y0PBcwpjPfZGqE5INcmUnN1qrFUW0ETgGLi8BEaQPV1Rk159KiCww9NYZVA6X1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY3QNAQqUYmTwD3qxvJfiWib+2SZOChJ0nbg66YLUKE=;
 b=sQhI/lxX/1fDfYUGuKBpqKrLzLtrEmrljyLAiqPAnLYQ5idGf9N/n9uFHgsJt2z2mYCEaVDc/uEKxcrplqu0WiaaqucZlBSIrGPk6ciYyTO009YG2GFP3UB+4NyRFmDbr0FIopVwE0qXkVFhFefrVhVxNDhuIgbeWdFAqFQLMXY=
Received: from AS4PR10CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::20)
 by AM9PR03MB7648.eurprd03.prod.outlook.com (2603:10a6:20b:415::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 16:30:05 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::69) by AS4PR10CA0026.outlook.office365.com
 (2603:10a6:20b:5d8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:30:05 +0000
Received: from n9w6sw14.localnet (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:30:04 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: CoC: Disconnect if received packet size
 exceeds MPS
Date: Fri, 27 Feb 2026 17:30:04 +0100
Message-ID: <2584880.XAFRqVoOGU@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20260226204357.361000-1-luiz.dentz@gmail.com>
References: <20260226204357.361000-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|AM9PR03MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1ad000-f430-4b8e-f88a-08de761d76c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	lGLDw9YgC0X6PzdDqPVCV9iYajBwDm7ueFiZS9BlJuoLLpS800sNXHHGp0HQxy1r6j76YjHkzR1r6VCQPb8Dnh5bxn4+MyTYGYxE4F5MOfW+gB1xHcdLfyA5ZLJG+4w1GP4QXUPqSiyp+4bwDuBuD+kWNIm6rdye518pXqVOv1v1u4Btoaeyo5W1VnVR64eZMpWrOdrVfGmUgyzU/MTQefJFjdo2+u/YOgWR5s7iTxik7AUjUERAxc0qdNQk1PiaOSKDsTGEcJPPmRu3IwIiGaKxtyu4TwtBxBEHC7IDF5/O1CSfuy9D2j3CvFPzK+EpWrMhw7W84PPwmGQmh8jt06wzEpMX0frd3Ak8AzyxYoB/cO3YcfkunkMF6mSdm2Uysn5Mi5oALHDfRfsmqfhemONB63oRlX+wU0v2G9cZmNkAQxLw0JtHkz6faMQnf/AysG9oKXpR0753PKts2TSoIcqpRHN1aOPkvkXw/9gETAzzdrZxwTkDZG6ClodSO8Xb6jV30tJRwAhioK47wH59HDddoI9UAtlb7fFZyLQVdKLCCFa+/77h3UAb1PUNVR2BELinGtjAulIJwK2EpYofxF9EEEGD3UtpWg6u8BJxddM32Q7TKp7Qlrq3L/7mRtRd3izaemU1F2mJMwuq6HFXF40OzBae1TB7Bvnyo2tscBMtNSVUFTaIYUrHCUaQWvRemg8N4YIlxgiBhFC+aAl0BTIaURdcDTnZD/mE+XEmhlcH+Py6eSSZP3ybyJwVY6qJfSc+Hlpmxki037yXy7v/cY8QsBrDmheUp99doLlFpur2gQebX8UsGbUkEMn2ap8AZYALFYN7yhDVi33tmdLoRQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O++yI9PzPsD/hS9z+S7jwTbAAC0LhKe54VQgHTxgkxR7ViIgQxDZYz2UPja+9WuHssuN8LpNt/2qaC6s/hSY6CXWSaNZgB83D0zx+tpqdg3BHgnGkAT3Ds1mXQcDhuD5iX0LFGg7qiKdUWYqxO62k0Drmz6LKl/kVsgj32Xs4jRx2BVlkOBPkbfIPoCAS+zFFGa5yWYQxpkPVG/CdeL9pBywgAwFlRfyt2szQrcnSmoJTzHJ0QQKM3e8Jjs+IFK5Jckewt6SnPPFrDnpcrnX+/fPQgBdQSJ6dhbOX+WNkoR0zsp3FQVEyxFigzdk/rp5L7Ef/HoaCDqhWUIMrAKRQlHRv6F6rgMZ7JkD5dkUe2/T4l/Nun7SQ0mefbLzEmbxsx02qqg57uEUDINeZhIisrP/He7EjhWT3wI5yUnlDG3H911EZgx1OnJ6idzoIoDn
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:30:05.1362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1ad000-f430-4b8e-f88a-08de761d76c2
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7648

On Thursday, 26 February 2026, 21:43:57 CET, Luiz Augusto von Dentz wrote:
> From: Christian Eggers <ceggers@arri.de>
> 
> Core 6.0, Vol 3, Part A, 3.4.3:
> "... If the payload size of any K-frame exceeds the receiver's MPS, the
> receiver shall disconnect the channel..."
> 
> This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
> 0x0027 -V le_public -I 100').
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> Note: due to lack of L2CAP CoC segmentation support in bthost the following
> test as expected to fail:
> 
> L2CAP LE Client - Read 32k Success
> L2CAP LE Client - RX Timestamping 32k
> 
>  net/bluetooth/l2cap_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f550ceceb618..14131e427efd 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -6669,6 +6669,13 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>  		return -ENOBUFS;
>  	}
>  
> +	if (skb->len > chan->mps) {
> +		BT_ERR("Too big LE L2CAP MPS: len %u > %u", skb->len,
> +		       chan->mps);
> +		l2cap_send_disconn_req(chan, ECONNRESET);
> +		return -ENOBUFS;
> +	}
> +
>  	chan->rx_credits--;
>  	BT_DBG("chan %p: rx_credits %u -> %u",
>  	       chan, chan->rx_credits + 1, chan->rx_credits);
> 

Tested-by: Christian Eggers <ceggers@arri.de>



