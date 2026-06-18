Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032B27BF6C
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752193; cv=none; b=eStpiZk0/sBrC/5tHgodi0egTmvucDhj6j8LN2uE607+zIUXNNW2P/HcAn8kdKmKWevAx8A2r2QWFp5cTh2EIMjU2OkBZ0dwDHmG68lntswZGhoiLNq0qvO9G+lUrFZstV5bv4mUeRKD7bKCB/Gr6lH+iBQ0W4v7lqDoqIxnu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752193; c=relaxed/simple;
	bh=nAOAIP26Xik/mbIn+bttY4vt0jwNaR2TUf4qqBMbp3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWVM6dJl1Axt4WS+7hCHya1G5msg2xTbnkfGGY/Ojn5Wys6zMT7wQp91Glm98mcw3QIAtjk0ho3Qy7xPlHR5qb0EWHe8aCphDyEyCRY/nFohzcOSLElaW4OVuHWkhYe7rULaOIq0fyV1mptyzHwXdNPAnabmcYoQ/BxID0dUecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EduYGg0j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EduYGg0j"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6b3f71648so6116525ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 20:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781752191; x=1782356991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IooJlgxeqC/w0kGOdGv146NJNfdUllVhE9+4DJtMSQQ=;
        b=EduYGg0jWcciDHEzCuZIHv6jsFE6UCupqLIazvcNa27Y4QsauD1V58GanPy8wZPgpO
         eQgaCNXjzeKcEAXGpDxZv54xZs0xSZMgbdkBq476vBq3jDeW3e3aFFtb31qJ78BkfkyX
         lA8OizrfisyWFeXCsIaeoBBqzXYyM9SlB75dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752191; x=1782356991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IooJlgxeqC/w0kGOdGv146NJNfdUllVhE9+4DJtMSQQ=;
        b=lf7VU5NhElLGG5fzWNnfoT35zU85/0T291ZhjonIY1DcckaY9s5MWTA4W4ZiM5u0Yf
         6abllNk6MsjiWVPkloxyWS1CiEw7MXFPSaqsIXpFyeT+0AOb0Fz1UD3K8we3pNVek5AQ
         /XKyOOk23f8GueZ+LIqdc8MS84Bl6owAGicuDCpphngl1+SV0Bqrvfn8y3slYTHPsgD9
         zLzWlImMdEYGegAz88vk56YbMB5rxUXLNB0FfVMw93Hm4wneOsxmlkwzWI3JeYwOjmVM
         9D/8QnNfAYuR7dzBZ7JCTACrbTvHff8nrXp/AgdD7dfgKcONc6X6duHcX9taK2Wp9qum
         oZ0Q==
X-Gm-Message-State: AOJu0Yy9VkfZDpMyFkINTCz6jf0p2B9bNu9Cpuwgj2SYcJf9trz/aFG7
	5yzyOg4LndKb5yikre8aTkGGYXmbJ6sMlXCcXKoirQTV22rcdr8GgNm5CQ3GKS3562Rp3n8hWjg
	34pI=
X-Gm-Gg: AfdE7ckt2HKVWXA7JHuJbxkpZz07iZW0DvVOrF0tzFWT5hWA9EQzxzIqswBfqg3Sbrp
	s+ZC/wbNEBX22CFvmEgBw50Agvnxqr3o89BA8mPuzfvSoPSqjYOZnaZbk0SaU83gKUOomeVtHHS
	sa5HUGVfr6mUkapkDcfLfCdGf6Mn6kmH3rSDODH63MIt1DdVxfq31ZKow9/6CLyi5aL8t0CyuWH
	tkP8C2rNA2UV5AcPS2oqQDMi6sk4yCvQ9naIuQ6BB9OLUp7g1zSiIW0Yi8KTZlrnDEyKVq6K4YX
	GMWBUK6WTFXUJuUXYn96/weXySJByaZ29uVjeQS/SICtjjKSFVJa+lPKlV6LU2lpQKBFtofu0wH
	XIMYbecWexzGdJneM5Q6N6zH6LfaVsRmNca4auieodvQ+6METIyDw8elDDNHBrCKo7u87mQZjNy
	Q3Dk1SAYUqr/7ip3p2eh51aBMl1rSLfGUalGPnFzlY94LAzdgHrl4X
X-Received: by 2002:a17:903:2310:b0:2c6:b3dc:b831 with SMTP id d9443c01a7336-2c6bc23de6emr74689455ad.27.1781752191528;
        Wed, 17 Jun 2026 20:09:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432f77479sm179744475ad.63.2026.06.17.20.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:09:51 -0700 (PDT)
Date: Thu, 18 Jun 2026 12:09:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: senozhatsky@chromium.org
Subject: Re: Bluetooth: btmtksdio: teardown fixes
Message-ID: <ajNhPdupuPzVEt9F@google.com>
References: <20260617064543.574704-2-senozhatsky@chromium.org>
 <6a324a47.14d9b9dc.267f5a.d138@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a324a47.14d9b9dc.267f5a.d138@mx.google.com>

On (26/06/17 00:18), bluez.test.bot@gmail.com wrote:
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112708
> 
[..]
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [v3,2/2] Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock scope
> 
> 1: T1 Title exceeds max length (81>80): "[v3,2/2] Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock scope"
> 6: B3 Line contains hard tab characters (\t): "CPU0					CPU1"
> 7: B3 Line contains hard tab characters (\t): "					close()/reset()"
> 8: B3 Line contains hard tab characters (\t): "					sdio_claim_host()"
> 11: B3 Line contains hard tab characters (\t): "					cancel_work_sync() // sleeps"
> ##############################

Are these critical errors? Should I re-submit?
