Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE0377003
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.102.255.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614691; cv=none; b=hv3yhaidJQFjLyPP+ZHE35ISvT7v1uhtr5JUK+/K3YziSrPvd2oYpv0v4tBu47sLaWFQKKNhxKns9+T17wcvQRtdyYzXL9yGoUPylVduSaF+UYLcRnzLelplUZGgGSKLySZbrJ6pkWxRaha47aNJWA60yHTPmn7GwgZSw+aYfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614691; c=relaxed/simple;
	bh=3/Xji4Yud1gN2TuGbLLhU1Atn+WIM9wUCeawG+nUUCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYhgNFUoylXwz+pMLuy0rRZ7yoqMGlEstx/ZcRCglEefsYhmXXSQ7TmhiqsE53ICOFp0kOW2GW2ToIBgGnT/9be0VxZlRxWDePyobS8jUWuTiG6H6DmIZOEwdd0AdbSCXcGl42fWQNOQHbvfLR1j3Pr9fS22mj9eJX8q5h4ziaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeelandnet.nl; spf=pass smtp.mailfrom=zeelandnet.nl; dkim=pass (2048-bit key) header.d=zeelandnet.nl header.i=@zeelandnet.nl header.b=G2yvG00I; arc=none smtp.client-ip=217.102.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeelandnet.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeelandnet.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeelandnet.nl header.i=@zeelandnet.nl header.b="G2yvG00I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zeelandnet.nl; s=se2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:reply-to:sender:
	bcc; bh=bgbfadNmnYBl6d31MXRqtuR02bk2Q/CZJMMs3ArQtZA=; b=G2yvG00I0Vi9cl5zdBJOT
	Y/Wha1xClRF5QwK6Q6Lir5Zscb7HoViaRG6LF228WTk2FHTEAIgyW1/rvKNjdz519gJrsKkgJ00AK
	0sP+4Vu1kbRYlqjUdGVC52botQJjTLFKC7LgQGjNmaNXyPkRxydM4Q92HwSFxyfquebKRwOFn5c2t
	HoK9GUlqMdu6PFYhLHADVoU9JS+TRfxvgCqLWzybkeBg6FVMyZ1gAJYDwd0NzIvOZaT5N+wNBpCLW
	B3bpclVG7iYvjgu+PN7WP9vyTmwgVtedgA/No1pROa8MUF17iJuIeL3WCNmH0FPZ/GWrOmGII9138
	C03BbRLSHBemw==;
Received: from [217.102.255.198] (helo=mail.zeelandnet.nl)
	by spamfilter04.delta.nl with esmtp (Exim 4.94.2)
	(envelope-from <tomcatshoek@zeelandnet.nl>)
	id 1whsC2-002Hna-Ut; Thu, 09 Jul 2026 18:31:39 +0200
X-Sender-IP: 83.84.65.18
Received: from [192.168.8.139] (83-84-65-18.cable.dynamic.v4.ziggo.nl [83.84.65.18])
	(Authenticated sender: tomcatshoek@zeelandnet.nl)
	by mail.zeelandnet.nl (Postfix) with ESMTPA;
	Thu,  9 Jul 2026 18:31:23 +0200 (CEST)
Message-ID: <8772517d-a353-4c14-83df-e4199ed90f24@zeelandnet.nl>
Date: Thu, 9 Jul 2026 18:31:23 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] adapter: Fix crash on UUID discovery filter match
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
References: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
 <a2d7c978a97b5e55a05cb7000f4d20d8c8dc542e.camel@hadess.net>
 <CABBYNZKxGTT5609JUo+04edy3X7hiZmWfXB2cmVGYLTVBz0O3A@mail.gmail.com>
 <bb434c3b-8523-4412-a3bf-dd888964ea40@zeelandnet.nl>
 <CABBYNZLNpsM8UQxM7wpfLKikM+Lto9t+aBne21xgn4t_2Oe1dQ@mail.gmail.com>
Content-Language: en-US
From: Tom Catshoek <tomcatshoek@zeelandnet.nl>
In-Reply-To: <CABBYNZLNpsM8UQxM7wpfLKikM+Lto9t+aBne21xgn4t_2Oe1dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVniv0q6Tsv+iEZpf8jUx6pomTjiFHLmT37
 M4KWYpFyZSu2SmbhJN1U9FKs8X3+Nt1e9xGgHpSCmLkfl25qZSy4A5F2aRjVfBzlUyXBRvKR0w9h
 kRlGHAo3NQuCQ2GgWEvv7CVrjlBxdVjnGNRI9M+PlDtR/qCXMVqSLVxeSwueS0r/pqDh7apldsyM
 rNwI+mb6BpeseSBELv+0jcKNeZXKtC8pyCYYciHB12Lu4CxajAlsWE7tOYTNT8lmDvRJlbmOpK/F
 6IU0v47iJjbX7I+9/fNoXjtFtCxlBW3DVyFe1uu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEmRLhyAOTJ5XKwvY/YSmcVOS3wTsXmJ
 5Ud3FtVPfFXaXb4ABfO8ZRD+1SC4D1hqb+gNrCNJAeb/xhy9lTvEeC1ydyAb70J8tnpgKKbx9SpW
 efMqeEDJgTZbKI27031mClCdQQU4k5lfixI9cze7LnSskunODYtbvP72vAmOyjpz9e0VK1rnzSzA
 2CTh63EFousoRYI/CVsxJODS2djk74fWGlGCaItSoj5tvtyx4H0WuE3w+nMbHRSg12OSAEHyDPUJ
 fN3KdUi5/j3ZFY1CYhJRwMcuGrIdKv+2ITlayta1AzjC0Pd2cJljcXdyFqqFZM+KRm6BJHACHYGi
 iXFCC6h1E3Fl4BxbICyMaQSNx2c68bIa7Mbho/n6Ih4xUNNsJs5zNz4P9CoP4R1c3iB9zJ9Sl6c3
 mH5PgiiLVm0XuwK4R5iIYO3jc9EORbD/McHqWgwRFZ4oobg8BBg3Jq+ntzj0eN7kNgLj2ulenJXG
 Jd/gxfiguJgqY+bBiG9X08x3ifOQWepjx1cGR8MHVfDCJ13GcvRlrRaGF9JH59V1zQ8WU80hK+6h
 PmeNtk1wz7BJOTh+pvlHhV6a5QjptwQBGybQLpzYMIy3xGNkduq8CSOOf6zyFSViSoFvEwGEa+Kx
 8LcFpcEj86SU6pw6DC+q1pGztu1J5nnvyhUFGkldhKTSyJACk+V/V60H6JfJnsg72wE4R3rtLKZQ
 FnSZvLDcdc3irzMnbkkeR/bLV8ffzH+ilQ==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Complaints-To: abuse@spamfilter01.delta.nl

On 7/9/26 6:23 PM, Luiz Augusto von Dentz wrote:
> Hi Tom,
> 
> There is a Fixes tag already:
> 
> Fixes: https://github.com/bluez/bluez/issues/2282
> 
> And that already informs the whole problem, including 91c340d359b7
> being the culprit, doesn't it?
> 

True! I was not sure what the right etiquette was, maybe it was
important to have it directly in the commit message for some reason. If
that's not the case, then everything is good!
