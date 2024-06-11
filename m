Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B425745
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084710; cv=none; b=iy3/1jQUykLuKOKcmcWzG5cTxO8+QWnFw2rljpCIqftwksMpvKksoXdw2QqQfW5XT/EXYgZFqubc0XRwSuzBwmQWgwHMYkUNoO8x7DzP7f1Y7d+sBpr5u2jNI18i8np1IUaG9Z9VFBbirKKXXhUGv/j+Myl0lWVdxzhK0YEutVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084710; c=relaxed/simple;
	bh=duUUp0NKhUvyrn5zY20KeiJNm2oTBzyRAR6zp7G7Wgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=OOvIvsd8s3gKlocqbqtC9EIEG0OcuevLwruPAYk/ZwF0GcTvyj9ryqWJ7rQxsJ/Uu/Fa7XDbymGiwQZsJFSoz5jgRIkm2/X84bl7EXG6xmgkMuSZ68C6/LSNjR/L+quUvOHIFjlcAAlB8/AcdBRd5up45nYDWGS0ck0pLJxN7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af516.dynamic.kabel-deutschland.de [95.90.245.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AA12C61E646D9;
	Tue, 11 Jun 2024 07:45:00 +0200 (CEST)
Message-ID: <007d6587-74d0-42a3-9106-1ee3411bf15f@molgen.mpg.de>
Date: Tue, 11 Jun 2024 07:44:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ,v9 0/3] ASHA plugin
To: Arun Raghavan <arun@asymptotic.io>
References: <20240610223601.378127-1-arun@asymptotic.io>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20240610223601.378127-1-arun@asymptotic.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Arun,


Thank you very much for working on this.


Am 11.06.24 um 00:35 schrieb Arun Raghavan:
> Hello again,
> Here's v9 of the ASHA plugin patchset. Changes include:
> 
>    * Switch to btio API to connect socket -- this makes the connection
>      async, so we don't tie up the mainloop for longer/erroneous
>      connections
>    * Minor fixups based on CI/lint
>    * Trivial gitignore changes are already merged

Could you add a tag

Resolves: https://github.com/bluez/bluez/issues/481

and maybe elaborate, where the spec can be found, how this can be 
tested, and with what devices you tested this?


Thank you again and kind regards,

Paul
