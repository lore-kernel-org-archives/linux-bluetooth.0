Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524678493
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 May 2024 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714704859; cv=none; b=aopEcw2fc5lVhwDj4YSeHms+7uLZ2P8HKbHjalXMZJWJaoPxKATVmBTgcgMwXiwNgs9uJcG6Fhz0RF6BBKwTp3DZjlESXVO9Uh76nZ8GT5aZtj1QlP3b+DB1VhziQ35fe4ojREqsAAdcSxRIDHf7/sIUWMLxLWbtHBW/vEIMhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714704859; c=relaxed/simple;
	bh=yDKp3H2GfAFPNZ//JlJZqmJUnus8qIYGocHIGeNqTb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3OEjnf1EUUPSeGdkBQgfwAofQb67guOayNC1PqypwxwShKKA/pIULYfUGT6LSgOEkem1julC5+9eO3D6G44Afaxy5saTAOjVlwE25P43V01GaQlBdd8Hs59sIUhX/L6nHimCZpTw0HUgFvDAux/wIR3NdIHK/8WnfLMiTuc4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=fIt+hGjn; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fIt+hGjn"
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id 2E23sS9jXrtmg2j3rsxeVo; Fri, 03 May 2024 02:54:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 2j3qs78FZd4oe2j3qsrb8O; Fri, 03 May 2024 02:54:10 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=663451d2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=S1Wz6wX7FG998aEX3qAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gvy8fIgr+vT9YwCzeMJn5rmWISCqNLxgzY8ECKu1DD4=; b=fIt+hGjnb8qMSf7zfQnPHWPwV9
	+PHLiVGoa0dYqbjWgIlYH4TSlU92rnz0bzF6gSGUtN4ULDgo6vgtamfSeJ2gESDF5f5Eq6lyaL3hg
	R8vf5NOTO8GJ24FPyrn4vQQbxBxz+K0PqM05XgH+4L9wEOpKEVDOtaRiF2daY0Z2Km6xRiIgZJ6xm
	T3wHpEheKpb3akP9911RL8xU6aDoQfKkaFRpg9K6SDDW0VsWfU+cVA68JZG49gzOHxA9TNdoTRICa
	7eXAZqUHxLPMhFdJ235r+RpbofESf3n+CEDHz3LDZR0MNIz7NbZnVf0NIyLnNfeNLxKCSQCt7DI/k
	AT1L6krg==;
Received: from [201.172.173.147] (port=32918 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1s2j3p-003YI7-1m;
	Thu, 02 May 2024 21:54:09 -0500
Message-ID: <b552b828-ffa3-48aa-bb13-addee866dfa4@embeddedor.com>
Date: Thu, 2 May 2024 20:53:42 -0600
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use __counted_by() and avoid
 -Wfamnae warning
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZjO9qCx10KUJbK6w@neat> <202405021045.CEE4DCA@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202405021045.CEE4DCA@keescook>
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
X-Exim-ID: 1s2j3p-003YI7-1m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:32918
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMUarfHoLBi1+A2V+sDo5nASn7LZnc7df0HDdeaGIgD5lxvN/LtF6feMTob03ZcPLvn45bXLmyRJtp5JS4FPhGccoZdhOLAXpciYBTJmkDwZFk+TwD8F
 a0uMHARmKm108sAD/ye1r7PLt7Nuf1oiWREJ3uvMD2/tbOT8sGKiUC6hrFOh5X5wCuMJOYMsNBiLtWKPZFr/HLx9kHu730w8Ktj2tlMmJ9E5VVtM2uWUfHPo


>> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
>> a flexible structure where the size of the flexible-array member
>> is known at compile-time, and refactor the rest of the code,
>> accordingly.
>>
>> With these changes, fix the following warning:
>> net/bluetooth/hci_conn.c:669:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Link: https://github.com/KSPP/linux/issues/202
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Nice! This looks really clean; I'll point people at this patch when they
> want to see these kinds of conversions. It has it all! :)

I really enjoyed writing it!

It was great to find out I could remove that global struct. :)

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo
