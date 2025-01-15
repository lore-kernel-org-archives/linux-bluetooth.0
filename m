Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2C24A7E6
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736949870; cv=none; b=FI9OYNE2WNVooAofwbqmXaEpHjb+V2LBMKbONug8q7j1tqee7Zn1ujNQ6RboJNgA8PO8HhHSYn1PyQDwjHCc7dOXRLnCFkMEaxglg1Fi0tDPcfI4SEVXaJl2ey2ZE5yLA+D+c4RM7WQlP3AW/0FHT8slsY8iPlGlR4QOKUF9Qks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736949870; c=relaxed/simple;
	bh=Gpx8x8kT9No9YUSvt/Y7jqX02VCoux+oaCYp0KqYwK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnVjk8Vgr1CCFSEjP4eGUR1jWEkMgwhoRAeYRmnnPmvsoiEcFsWDf+Cktg/N3OHY/xQvQgTAYtqlNafezdQFDPgWGDgqPMw9mMbkhar1TAv8fcsuVX2YahH91ID8IiB4821i6G2xZCFPeW0xMwekMz6CUcFS5I/1uZwGF+S9ABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=X/yFEcrs; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="X/yFEcrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736949868;
	bh=goR/nCqemkDC1/MOc0EbFIYVnnwOSC7on56UVpj+HwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=X/yFEcrs+u0ULO+N+Z7Ic6uzwmTSE+YBLbwUOXLm2wLfq11OJMkieeeoDMzGZsZYx
	 xjUVTy8tJjgfKnUIjHlkxedN4DZWjTR0jB4kR8/6hEh9bTIf9BU2wrHFfg71urJmMq
	 6FE2CBmWxNkc+UuqZzQ322TKb7vK6OU/BlfpwCitJ5E02a4s2p0EWEWVJIkWFlyg17
	 7wMG4t5nKacb2ODHWauOQiWGTGVplIoLV9a6s4Xvldiw8sWIlwRa1u2WUEZt0Se05b
	 avRjKhMXcKpbKCUyPgXtAXuFXZkr1xTUF4amnjfDD++0YgOsdDs41ucmcMutxfhCPC
	 SH3U3rrXqpbWw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 0C42D960683;
	Wed, 15 Jan 2025 14:04:24 +0000 (UTC)
Message-ID: <3500d9d6-5d7f-4f96-a065-70fdd09ebd26@icloud.com>
Date: Wed, 15 Jan 2025 22:04:02 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add 14 USB device IDs for Qualcomm
 WCN785x
To: Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250115-qc_wos_btusb-v1-1-811664ce5d64@quicinc.com>
 <65518362-55ca-47d0-99ea-9bee3a8aef05@molgen.mpg.de>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <65518362-55ca-47d0-99ea-9bee3a8aef05@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hP3fIm2mYzoGakG7W5QDDPb2keNcpIxG
X-Proofpoint-GUID: hP3fIm2mYzoGakG7W5QDDPb2keNcpIxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=596 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501150107

On 2025/1/15 21:47, Paul Menzel wrote:
> Am 15.01.25 um 14:33 schrieb Zijun Hu:
>> Add 14 USB device IDs for Qualcomm WCN785x, and these IDs are extracted
>> from driver inf file within various types of WoS(Windows on Snapdragon)
> 
> Please add a space before the (.
> 

thank you Paul for comments.
will beware of such error for patches in the future.

>> laptop.
> 
> If possible, it’d be great if you listed the various laptop types in the
> commit message.
> 
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

