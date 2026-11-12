Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475435;
	b=uGSUFhmMlb9fScNn7K3+U0p/PaMVK53VjiCOPjfboXRO6HRhFXzTGaFMUXiJNgjv1WAD
	 ptoy8P8Wh++tbSRc8FOldqymrRpIIrNdvPI0aorJLC+OX/h7oqMOKHQztL/Iwg1C4B66I
	 4U7P6+ZWAsOE9nb/1WgwwG6d4bf4KucZI9RkIy9fDd2oLnZpAqwTOI0o7n6Ut2JrPNEI8
	 +h3H1P7HTaRT5I3+JyY5uwS9uXHtNuuB1snA9QpsCbvO5K07G+fOHpHITZfbXZU7JbAew
	 gAIT2OmZ7JVXhdZdb3Hw4+flIgkpu3rl1vs56B7y4na0V/JzDlFltQVHDz0nRfmHY3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475435;
	h=DMARC-Filter:Date:X-Lima-ML-UUID:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XrKTCTtL8bq9hcA3cLjorZe3ms1NOePAubxkA7gxev4=;
	b=GhcwZDD7MpkGGBw+s4ZFYU6KCHEWEgTIIwZ1TrLjXOtK09TKznBF1ma/z+iXUTj/YaJr
	 2mVXacr2fb3b8XTO5oczjL+ZBkPQKUHeMt/yhKhvQUbDo3iAm2CmuO8zu75vwzQx6nwqb
	 cg0b0LB3BrGJFNw7GAjZqQdQOCmCdtEdEJeXAlz95nSFaZLE3tYG/RF2xkUrtXFVQlTMl
	 EulQvloORXYHcNbJMrnzRcMvyARMCxwi0Nl+gTGbquqH3Aiwjd7cjZfHLYTG1vyDXybOX
	 ZuTpanQa3KxL8aaBAIvQJPJ3I5yQlTb51sFzT3xPuHYR8CT4nPlMV2db+jRV+xsHEJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=rKO6UlgH;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E4606A8A3;
	Thu, 12 Nov 2026 09:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 241E4606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=rKO6UlgH
Date: Thu, 12 Nov 2026 10:23:47 +0100
X-Lima-ML-UUID: 4d878238-c034-4480-8c6f-18f3801a77d1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1794475431;
	bh=BJYPieYsm7wUZfSPxCoK9/u1+dJEmmjdYYatgOil7Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rKO6UlgHTeEb/toXHmvy2QbTBq1wVmOxoEXGP3+1BMuVeelvgS6jdhStcSMY7jeby
	 ZDeSjg5eVFGMsHeCSUDTsXFfgKrSnXofhlrucgBZdYsV78UDUL5KFYjmvkNBM0rzSb
	 u9j8TntSRhJe8TLw0wklEJOpinv+V0lwZGVbSK/FD9YMMEkcNpxj1l/bMXCKlnmhL1
	 t3n6TTEydlQPYPV6bJl7LkKEak2e/4wqiNw/GUd86A/LdvGKXLR5mgLJWZmdItbZeG
	 EzIG99XyPS7eztr0E7QwUvGdalp7M/mcdEzWWDSmPgjuVNfewMbJJzmOeO8tvXHhjV
	 A8o9Hn+lV9LEQ==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Sven Peter <sven@kernel.org>
Cc: j@jannau.net, neal@gompa.dev, marcel@holtmann.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_bcm4377: treat only negative
 hci_register_dev() returns as errors
Message-ID: <20261112102347.3a22966a@kait2en-mbp15-1>
In-Reply-To: <517d9d36-ab3f-4eb5-8908-f50aea59a3b0@kernel.org>
References: <20261111120248.21062-1-dev@deq.rocks>
	<20261111120248.21062-2-dev@deq.rocks>
	<517d9d36-ab3f-4eb5-8908-f50aea59a3b0@kernel.org>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 17:29:01 +0100
Sven Peter <sven@kernel.org> wrote:

> Please make sure to pick up tags from previous revisions or mention
> why you dropped them. I added Reviewed-by for v1.
> 
> Sven

Sorry, I missed it when preparing v2. For the record, from v1:

Reviewed-by: Sven Peter <sven@kernel.org>

Luiz, please take it along when applying, or I carry it in a v3 if one
is needed.

Andre
