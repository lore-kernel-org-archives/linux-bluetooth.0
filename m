Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C8413D6F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.102.255.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614076; cv=none; b=Zy1srnfmXnKA4/NEDUoXkTZuLj7DQwTG3bJqt1pK6d6F/faY5znZBWHPm8QUwIFqIvUjfKISreW2bVp9kgQTHbFfohVR/wDd+Acp0LSlswkP+BMQSzBB0wiJc+Yl+3EdLOC2D828QGyhII6g31YVkKbhZRJxVuAq2KswnUI0ljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614076; c=relaxed/simple;
	bh=iYx0S247giLjPbILqbidAE72IzBuipPeO3VWB5yN9GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JB0kq/OnfSKPMTvrE7ra90abFkXQaIO/gp/fb4grQZqijUmVt1p1XWPsHquKkgiGdmxsn5+gZuJK8R7vyUzDn0JHzdoMRsPTD/pgJZMwKwjL42ZOGCs19Zl9iMX1iZu3fVlHKfmeNXhquNTX1DXLdo2EZUmwfMGVPiWaVkNXqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeelandnet.nl; spf=pass smtp.mailfrom=zeelandnet.nl; dkim=pass (2048-bit key) header.d=zeelandnet.nl header.i=@zeelandnet.nl header.b=r9MjIYeA; arc=none smtp.client-ip=217.102.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeelandnet.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeelandnet.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeelandnet.nl header.i=@zeelandnet.nl header.b="r9MjIYeA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zeelandnet.nl; s=se2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:reply-to:sender:
	bcc; bh=iYx0S247giLjPbILqbidAE72IzBuipPeO3VWB5yN9GQ=; b=r9MjIYeAjutdEMrCqKwBT
	jnfsq/UgUl7hvxBHxc0+uhSC6JGR4+xcnxBWtsi9W6Fi1iOVSbbWQClTEp0sMDY039QJzWsewlcO3
	OMJtN2mLf6Aht/jjZyZilmQkrJYmQVI5aCOsjKfpeWA0GbRDtL0T44SFztsrnNlFUu9u+TVxBFKLI
	RWEoh6fKjLDVE9fpb+JcB4u9gAKC5LfRyN89hmi/KIa1Bwy10Uwx9vum1+DG9DG9qQuKUYFZDnVox
	wm3ro/FG2uRkUwdLzIbHFTvAx5GTcALmDNVnpZ/lOvRVTDRhiAKvumVAWMy1pQfrkhKvtdwdb6tGC
	k0nhmpo/rYy1Q==;
Received: from [217.102.255.198] (helo=mail.zeelandnet.nl)
	by spamfilter04.delta.nl with esmtp (Exim 4.94.2)
	(envelope-from <tomcatshoek@zeelandnet.nl>)
	id 1whs1j-002Ele-Rj; Thu, 09 Jul 2026 18:21:19 +0200
X-Sender-IP: 83.84.65.18
Received: from [192.168.8.139] (83-84-65-18.cable.dynamic.v4.ziggo.nl [83.84.65.18])
	(Authenticated sender: tomcatshoek@zeelandnet.nl)
	by mail.zeelandnet.nl (Postfix) with ESMTPA;
	Thu,  9 Jul 2026 18:21:09 +0200 (CEST)
Message-ID: <bb434c3b-8523-4412-a3bf-dd888964ea40@zeelandnet.nl>
Date: Thu, 9 Jul 2026 18:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] adapter: Fix crash on UUID discovery filter match
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
References: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
 <a2d7c978a97b5e55a05cb7000f4d20d8c8dc542e.camel@hadess.net>
 <CABBYNZKxGTT5609JUo+04edy3X7hiZmWfXB2cmVGYLTVBz0O3A@mail.gmail.com>
Content-Language: en-US
From: Tom Catshoek <tomcatshoek@zeelandnet.nl>
In-Reply-To: <CABBYNZKxGTT5609JUo+04edy3X7hiZmWfXB2cmVGYLTVBz0O3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: Combined (0.14)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVuK/8LamVj1f22m8nqYObU658KFz7wDC+F
 rhbKJ87KLSu2SmbhJN1U9FKs8X3+Nt1e9xGgHpSCmLkfl25qZSy4A5F2aRjVfBzlUyXBRvKR0w9h
 kRlGHAo3NQuCQ2GgWEv2Uvyp1aICWaGr/7JTUPvJlDtR/qCXMVqSLVxeSwueS0r/pqDh7apldsyM
 rNwI+mb6BpeseSBELv+0jcKNeZXKtC8pyCYYciHB12Lu4CxajAlsWE7tOYTNT8lmDvRJlbmOpK/F
 6IU0v47iJjbX7I+9/fNoXjtFtCxlBW3DVyFe1uu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEmRLhyAOTJ5XKwvY/YSmcVOS3wTsXmJ
 5Ud3FtVPfFXaXb4ABfO8ZRD+1SC4D1hqb+gNrCNJAeb/xhy9lTvEeC1ydyAb70J8tnpgKKbx9SpW
 efMqeEDJgTZbKI27031mClCdQQU4k5lfixI9cze7LnSskunODYtbvP72vAmOyjpz9e0VK1rnzSzA
 2CTh63EFousoRYI/CVsxJODS2djk74fWGlGCaItSoj5tvtyx4H0WuE3w+nMbHRSg12OSAEHyDPUJ
 fN3KdUi5/j3ZFY1CYhJRwMcuGrIdKv+2ITlayta1AzjC0Pd2cJljcXdyFqqFZM/YFQUjl/mEgebR
 XNImN3IPOoVYoUKHU2W281p626ckr7Ia7Mbho/n6Ih4xUNNsJs5zNz4P9CoP4R1c3iB9zJ9Sl6c3
 mH5PgiiLVm0XuwK4R5iIYO3jc9EORbD/McHqWgwRFZ4oobg8BBg3Jq+ntzj0eN7kNgLj2ulenJXG
 Jd/gxQXifP0XGHtDvGfHQgH/0Ugeoq44EbRuDRK8+Yg2fzEBcvRlrRaGF9JH59V1zQ8WU80hK+6h
 PmeNtk1wz7BJOTh+pvlHhV6a5QjptwQBGybQLpzYMIy3xGNkduq8CSOOf6zyFSViSoFvEwGEa+Kx
 8LcFpcEj86SU6pw6DC+q1pGztu1J5nnvyhUFGkldhKTSyJACk+V/V60H6JfJnsg72wE4R3rtLKZQ
 FnSZvLDcdc3irzMnbkkeR/bLV8ffzH+ilQ==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Complaints-To: abuse@spamfilter01.delta.nl

On 7/9/26 5:00 PM, Luiz Augusto von Dentz wrote:
>
> On Thu, Jul 9, 2026 at 10:39 AM Bastien Nocera <hadess@hadess.net> wrote:
>> I don't understand why we need match_uuid() though, does it fix a
>> warning? If so, it might be nice to do in a separate commit (fix the
>> order first, fix the warning second).
>
> That is probably needed since the callback signature/return doesn't
> match the likes of strcmp.

Exactly, queue_find() wants a queue_match_func_t, which returns a bool,
and strcmp returns 0 on a match so it needed a wrapper.

Also sorry I wasn't fast enough preparing v2 with the added line
Fixes: 91c340d359b7 ("shared: Remove glib dependency from
src/shared/ad.c") Bastien suggested, please let me know if I can still
do something there.

Thanks guys!
