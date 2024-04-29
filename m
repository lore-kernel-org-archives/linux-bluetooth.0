Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E931411E1
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420257; cv=none; b=g0yRmAlM5flLiWw09prh69ujRjSqq+9o8waLCeZoJTR+k++FGGKSPeCrhyC3eHPaQ0fpzRnvwKIwDG5lcIrRN7dNQhwda4eMtRNrMRlvWO0/vtBmYIg1SXtxjStQ1kfaygH7AdoN2sq32u4q1zJzdwMI0Hr5e23IVTB6GL0jIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420257; c=relaxed/simple;
	bh=ajQDmJ0WWFzPXvoP2mmAy+LuxbIewe2/xsExrL6XISQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDHG7DUmtF8Hxy7fiqUofSdjYR1ziggXt/+dnXHXImiW7IaXJAHD8iZF13gGl5+X8J7TvOCm4xlVGSt/MNdXeMjFG6VPDCmBbiufn6gnqhHEAk8F6VZDshH3PoB6emqOv7UwbMqSN1cCpK5KXn41crVuKUoXhqTO1ZUUyaSD+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=rEuAK03c; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rEuAK03c"
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id 1TsqsWvlkFfFD1X1WscZZk; Mon, 29 Apr 2024 19:50:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1X1VseJmWUjoW1X1VssLC8; Mon, 29 Apr 2024 19:50:49 +0000
X-Authority-Analysis: v=2.4 cv=Btqbw5X5 c=1 sm=1 tr=0 ts=662ffa19
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10
 a=GnIobxVeLkNF-WZzOA8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2FeBCJhrHyDzm6ziA3QCmTVmkMK5M89ts1JS18ctx0c=; b=rEuAK03cGdyk9JpPDMHFIOHuB3
	yaa5QHKXfz1v4NbbnH5VYAiFdRJe8wZGP6b67svjvwC8epGhVqbsYNbo2zDB9C/gnDE7g1wZCuVYu
	n6ged8xunX4hdg33PLMAOjytXZjcqByYDcHISnCcAG0G/iQp6urAu7YelT5xg803cDDGa0pVWgjxE
	HHwq4XhBERPYHCHZQyH3liUj3xD0XytWpURKR+PGSrKtSu888+wZIYsa9+IYnhsfr8QQ3FBFeSKq9
	W8xWkro+UYkY7lv6P0IEO2tD7pXtKmaFpwPLMeRP9Ay98xo8Rq9lBh/TEv1BXiRia2I59yO2jscy3
	pPZdkjXA==;
Received: from [201.172.173.147] (port=53420 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1s1X1U-003pzP-24;
	Mon, 29 Apr 2024 14:50:48 -0500
Message-ID: <b09450f9-c42f-41f8-a2f6-eea3515eaa2f@embeddedor.com>
Date: Mon, 29 Apr 2024 13:50:46 -0600
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] Bluetooth: hci_conn, hci_sync: Use
 __counted_by() in multiple structs and avoid -Wfamnae warnings
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZiwwPmCvU25YzWek@neat> <202404291110.6159F7EA5@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202404291110.6159F7EA5@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1s1X1U-003pzP-24
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:53420
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOwxWzzY2/dBe9tWmLOQId0sNAsbcVN/5wjl4fcHLisRiysIP+nYkrv13mWKnZXU7jqSGpVcf1bZu2NpVBJFgItufBIK6sTZlysh/Rhp7PhA3JsSCfJI
 zCc3YGEDHvjvyF5Zv1kw3Kh9F+KwS0jNshvLUW3/YvbI75KHHOfzYfjJ8z6w95nufdsYdkj+MVXCjJ4wiLJ+7Ryv+sJhp+rG9xHf4prU8QgOKuUUp4xvCmvH


>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index fe23e862921d..c4c6b8810701 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -2026,7 +2026,7 @@ struct hci_cp_le_set_ext_adv_data {
>>   	__u8  operation;
>>   	__u8  frag_pref;
>>   	__u8  length;
>> -	__u8  data[];
>> +	__u8  data[] __counted_by(length);
>>   } __packed;
> 
> I noticed some of the other structs here aren't flexible arrays, so it
> made me go take a look at these ones. I see that the only user of struct
> hci_cp_le_set_ext_adv_data uses a fixed-size array:
> 
>          struct {
>                  struct hci_cp_le_set_ext_adv_data cp;
>                  u8 data[HCI_MAX_EXT_AD_LENGTH];
>          } pdu;
> 
> Let's just change this from a flex array to a fixed-size array?

mmh... not sure about this. It would basically mean reverting this commit:

c9ed0a707730 ("Bluetooth: Fix Set Extended (Scan Response) Data")

--
Gustavo
