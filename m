Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681F4963CF;
	Tue,  4 Aug 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865251; cv=none; b=flI7lcHNNsWYLPLrw2XCjlc6KSniEacZ8+FoukbV1sasLYkMsmVo0IZ8lEMy110zZpHhQOGaYser3nVfdYVzJTWJ8JPQfTpnbSZKdn8GMpqalH6QUztwuWJsD3+DH5xFNu0hrLQwYRL1sqyXtrzuPh//3BcRvuw/9+25SftPurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865251; c=relaxed/simple;
	bh=psWhlZqnTFWbjmjJgvVX0zZiWebYwqz0JIu3lijVILc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C0b1qftNU8mdtbt8lql6NNA+CL/hTYXRHndvbmkQbTjMvKapd5SZtS+j7Poh+p3jAbZ57bihpO37ORKzIOAhXBnAnE2DEIrO8ZPoXWOLFKRbKi9TEKZrSGzCEFaDcwqv9WkLoE5Z8i5/YJ7SAKZ+xbEzWV8WDBHqR7VORjdrmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Airjw0tz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Airjw0tz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1071F00A3A;
	Tue,  4 Aug 2026 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785865250;
	bh=9v+iXVAfGDO5My4GuNPQjth1IMe1M7lqAEs7Mk4NoKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Airjw0tzgY6K/keVWtWyyMi62bHPIALTceKvgXo+WcXZg2qxJiuyXvV6nq8tn2w2D
	 1frzVB2w/+BZ0Fsd4LPVu6VjBqnaFEU1BkbVr/n6+q+Ukj0+G31ParBD4WLdy034u1
	 vUiDU6cqnGSet5Rh7g15PwZ4kCy3Oe3AiPF2yVkfaBaoUtwcHBLk+dJktzsQ00Y1Eo
	 fkolTs1KEUVul0Io05l+PwvOFrDlT4D8Y3oJcvl+RUuhvEt1ZhHjEPW3l9/NJ2Dv8S
	 CqhkqXLXgcXv1T74E/TVxdYlq76khd2pgab+IaLrfH2HR7f2o1rXS5kNiWFWgG4O/R
	 AJpoNEgct7YWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199EF3926272;
	Tue,  4 Aug 2026 17:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: validate LE Set CIG Parameters
 response
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178586521063.3702995.14976898276396935564.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 17:40:10 +0000
References: <20260801180952.52072-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260801180952.52072-1-acharyalaxman8848@gmail.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  1 Aug 2026 23:54:52 +0545 you wrote:
> The Command Complete dispatch validates only the fixed part of the LE Set
> CIG Parameters response. After that part is pulled from the skb,
> hci_cc_le_set_cig_params() trusts num_handles and reads each entry in the
> trailing handle array.
> 
> Matching num_handles against the command's num_cis does not guarantee
> that the response contains the advertised handles. A truncated response
> from a malfunctioning controller can therefore make the handler read
> beyond the skb data.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: validate LE Set CIG Parameters response
    https://git.kernel.org/bluetooth/bluetooth-next/c/bece7ec4e259

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


