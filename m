Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F042773DE;
	Mon, 13 Jul 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962982; cv=none; b=C5vDSrtPcUpbgHtpGtGNqr7F9a+vh/D9pDe8UZY9TYdLmA+5i0dDamSIPuiK/tKpWCJK2WEmJFvISXgaRQrLcXa6QhZE/PoT7243QxXZfnvnbjwIcSubJVesakR1Ux7YaBiFZBwD7eT/MzNCQAmNGksPmQrKnO9mOEB5BbA5Kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962982; c=relaxed/simple;
	bh=VYBQFmmAwuBdUzZ/rxsYEWe4uZ5NCl/yeV1drHBHP+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmQYFrk1SVplXeYFtgIfkOACco5Ol5+MrZuDgTe8n3MwnvPpH2eHnCT92zB5mxPQaDstdVim8T8nwlaExf6ezSzm3+YPycLL1vlOHD6TMBBajrMdH3hJxA8XqmYdDvv5KbRtqYBw1dqq9o9N9Ubvc480nMEbX8e2NwOHBX9+MxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rrWdcQD6; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rrWdcQD6"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gzTcG71hgz1XM6J4;
	Mon, 13 Jul 2026 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783962972; x=1786554973; bh=VYBQFmmAwuBdUzZ/rxsYEWe4
	uZ5NCl/yeV1drHBHP+Q=; b=rrWdcQD6wXs4xrRljPwTPJVvCVLUSZFZMQpxhpqy
	Qoz+56o/6SBt4UqPuvorDQEV00wImcAuHbwayCZP43wBzEVIit/ub/XE4wdaV6tp
	DjGvx8HZUgnrsYWOB9UJYsnNgeC1GaWd9AbWRys7Ahms/TJb9eWc5edOsg6JyXTn
	qC0lI3JOunkH0Zhiil21I0vTpcRGVeYPaGWb2QXH50kyrOxT8LPqNTUPEubmyVFx
	k0PYQeWsotS6qTL8DYXnAwZEvDTEjBFo2Jfw7l+GyBCr931XqXXkk7ZetxcQjSVn
	GbA4wYKlYbduSrasZreQxdTSrFCdMt3i4IYkXDvD7hMNTQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BOqwxR6gwABX; Mon, 13 Jul 2026 17:16:12 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gzTcB1Mzjz1XM5kW;
	Mon, 13 Jul 2026 17:16:09 +0000 (UTC)
Message-ID: <de1ccfd2-71a8-4bb9-ac43-2f8ca8a9b732@acm.org>
Date: Mon, 13 Jul 2026 10:16:09 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Bluetooth: enable context analysis for headers
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, elver@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <9a718ecfbeb46077d8100dcb687e1ab6073986f6.1783860121.git.pav@iki.fi>
 <ec3a235a79254560e4acd4f71ed7ca95c8763f77.1783860121.git.pav@iki.fi>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ec3a235a79254560e4acd4f71ed7ca95c8763f77.1783860121.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/26 5:42 AM, Pauli Virtanen wrote:
> Remove context analysis suppression for include/net/bluetooth/*, now
> that previous commits have resolved the warnings.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

