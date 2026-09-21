Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82429427FBF;
	Mon, 21 Sep 2026 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007408; cv=none; b=mVQF6itlNeXXsPmo7gQicypyqjkyRpGOTW3v5I4xz0lbp4l69nPRORIC2GcY0d81lwP3mgUAV3qmUk1HpiHNj0MRVj3ODSqHhoqSfKqqzWUY/p0FFRT2chVSmlXrwDqgiGcfqecXOyzyuHsOt1gTgQTvMBcivoGvcpeM87SEyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007408; c=relaxed/simple;
	bh=cNe5L5MX5LoDLPc5OihQdaBpPRF4FFUfvt2Vw/QdvPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx1xLWQAAVxpBt6OAsHysSyc8Y2FyDbm8WoRqxZRuUd4DNj1g/whqu7GJAwztjOnx+Fep+8+GJ0DQBk36f3H2AbKvUcumyB0/YDu/QOW0yEyoF3m0c27eXKOJBiiRbOWkRb2pWJ4cFxDBXnJ1yOcIk4CVyzpVgolNDhGsyjaPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbSN74N8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbSN74N8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B041F000FF;
	Mon, 21 Sep 2026 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007404;
	bh=FCqhJfHBwtnt+ArdJPd6pfJGUhne2cByOUsf8aYDl6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IbSN74N8BFRWC5rRFESnXuWvAGp5AHg+z0yZHOOgkbj9mLevqMgwzOcjMtbd6kNI5
	 EI0iVEQGf4WSrClfyNdxou/+v4wxs/zVpjJM04R07Eumtn/bXGoqu0KT5oSUxdZLSn
	 7vT8n/rT2hQcgjOQYa6e0OlMCtBAoGI4xEsWzMx0TOYw4Z3fX+IUcb8F4hF+FMfdBw
	 kSYMpyLfu9URAx5Ok7zt70GoC4lUeCjAGMsd2/w69pHeMFC1jBY16Gy8SAhV06Y0OZ
	 gaNCgWQKGvFVg5F9AgFcFNmzMtQCL1xMuoEDGaFKcRppQZFr6BVdekMbN/Cn6AjHuJ
	 faztjyj0BeVcw==
Date: Mon, 21 Sep 2026 06:16:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marco Elver <elver@google.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH 2/5] workqueue: add support for module-owned work
Message-ID: <arFYa6WFbADfftCv@slm.duckdns.org>
References: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
 <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-2@gmail.com>

On Mon, Sep 21, 2026 at 11:38:59PM +0800, Cen Zhang wrote:
> Queueing a callback on a system workqueue does not take a reference to
> the module containing that callback. A caller which releases its last
> module reference after queueing work can therefore leave a callback in
> unloaded text. Releasing the reference from the callback itself also
> leaves its return path unprotected.
> 
> Add module_work and schedule_module_work() to hold the callback's owner
> from queueing until the callback returns. Run the dispatch and final
> module_put() in workqueue core, which remains present when the callback's
> module is unloaded. Cache the function and owner before invoking the
> callback so that it can free the containing work item.
> 
> 6LoWPAN needs this for deferred network-device deletion after removing
> the last peer.
> 
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Please provide justification on why this needs to be done this way when
everyone else can flush delayed items before unloading.

Thanks.

-- 
tejun
