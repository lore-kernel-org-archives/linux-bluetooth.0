Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A4346A14;
	Mon, 13 Jul 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962958; cv=none; b=b95Eyv1hnq5CK99T+ztdmo/yyf2VdtAvRZlbwsgBd6aN7N6YQuGuv06z0WqqHm6Kg3t6g061kYvw3yb3e1y+6P5J+uo3OjaGhs3P78vnff+EGv/Y3bRWrkxtX+pBa0451o+nrYzC5Z4K8PKXc9Ca3OdzdixuBzMek/JIGzwI2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962958; c=relaxed/simple;
	bh=UoVWDezntw5jcDy9FjMeNAHf2pqt0kwsRm2TSbjj0oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z99R3IIn1CuM3eCndfFTodmpfeWcGlCDM9IUM8xWBRB6hy6E1SmGKe/dqnEJccOcNqI+4mIJkr8NtLRfXIgecJGDmCIwIC5fOpaOX/59FVdaWuScLalC7inxvzbgzbbEtjEcnkRmreoQ3yrPGkpFD0UeCPY6wr/0BT+m0TMkwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hHPsQwhA; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hHPsQwhA"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gzTbw3LRLzlfgfG;
	Mon, 13 Jul 2026 17:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783962953; x=1786554954; bh=2/90H4y39wSucUfsr9Mva2qt
	mtK58suikWfgebYt7rw=; b=hHPsQwhAOIS1ysBIuVfiAGtcxuKaogTJKqvBkAfE
	3Qi0gGspfcYT4uHA9TO4jG5uGzWBTTOYsadNWk5XkrbQhVoq9XT4u//uDsHfObVX
	62mQWr/NqGzGscQwkEUG6WVKnvPTbCEKOvbFyYQ75p7w2fDiTwGArVj7rkAJlHWT
	fSC7nCFXEUGrn1GgiRID3gsa4SdXpSfvZ4ViXEEQxsE3GmzCg3ItdKZix5prgCy5
	P63ft/bPA74tXF80Q4YreuMye8fP0IAfSIefHQhtnQBQaqF1So5rUZFunqCIGHrq
	3T3BYT0BCXqcEj5qPHaSIyyj/aKzPOW8eeX/0xo+cZ3lIg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cYY9gaHvDlol; Mon, 13 Jul 2026 17:15:53 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gzTbq16cZzlffvb;
	Mon, 13 Jul 2026 17:15:50 +0000 (UTC)
Message-ID: <979649c1-5c16-4c82-bf23-9d33d7c2db37@acm.org>
Date: Mon, 13 Jul 2026 10:15:50 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Bluetooth: L2CAP: avoid maybe-return-locked and add
 locking annotations
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, elver@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <9a718ecfbeb46077d8100dcb687e1ab6073986f6.1783860121.git.pav@iki.fi>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9a718ecfbeb46077d8100dcb687e1ab6073986f6.1783860121.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/26 5:42 AM, Pauli Virtanen wrote:
> Replace the maybe-return-locked behavior of
> l2cap_get_chan_by_scid/dcid() by doing locking in the caller after NULL
> check. This allows the static context analysis to handle this.  No
> functional change intended.
> 
> Add context analysis annotations related to l2cap_chan_lock/unlock().
As one can see in the above description, this patch includes two
separate changes. Please split this patch into two patches: one patch
with the code refactoring and a second patch that adds the context
analysis annotations.

Thanks,

Bart.
