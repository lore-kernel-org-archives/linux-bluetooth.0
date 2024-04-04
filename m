Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0A1AAC4
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211895; cv=none; b=ig39FuuErUotP7KYaawxR+L3qm7Ib58yGjSuzEDZlxuIi5GHRjwGOXnNNp0uI0n3/10qzw+rgXaXCs7gSYcY/Ovn1qjdUy0YXh4IOThut+tVv63rG1biZVdBGHKxS8eoQoLrjFfoTPQi2KPyTHTDjdoSlAamuNEhLKnuoZlW2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211895; c=relaxed/simple;
	bh=UpnoFfAsdwkMDaGlE8PgpjZpA6/85hDei8fdaxoVr3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=NzcLzxFuz5jaI6/MKGbu1gzRzzH7qaSMpp7CVa383deyEUjfc0pIwM0BUeuniiQNL9OWT/Tqx5GKANp2TNL0qpdSHZdljF5Aa1ZDKbrb6YTU4IW2sjy+Lzb0fZ3Scc/du6U7obX64qtRWgQyzS7mZTSkuuxc8LD7pDJrFABPxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af2ce.dynamic.kabel-deutschland.de [95.90.242.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C906E61E5FE01;
	Thu,  4 Apr 2024 08:24:39 +0200 (CEST)
Message-ID: <06c64895-a99b-4705-8965-d8ea66eef74a@molgen.mpg.de>
Date: Thu, 4 Apr 2024 08:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] Revert "device: Consider service state on
 device_is_connected"
To: Dimitris <dimitris.on.linux@gmail.com>
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
 <20240403205252.71978-2-dimitris.on.linux@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240403205252.71978-2-dimitris.on.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dimitris,


Am 03.04.24 um 22:52 schrieb Dimitris:
> This reverts commit 44d3f67277f83983e1e9697eda7b9aeb40ca231d.

Please document the reason for the revert.

> ---
>   src/device.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

[…]


Kind regards,

Paul
