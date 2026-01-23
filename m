Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD632D47E4;
	Fri, 23 Jan 2026 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205296; cv=none; b=Al7xXgWjyfcibrk3gzH40XJe9sR9/1Fl+oIHUNCHYMmIEjDN31NRBUmwgetqObboeqamXTr9kcdTtNu1jZi9CzvRw64TPd44pEezcJ3hCaJlli5GJwqPxddrSjimG2fzjF1ek4h5tA28F2bJzNvUn9buy58l+eMcwVNewIzm66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205296; c=relaxed/simple;
	bh=4rNxIGJrzfqhGn17zoSC2KvS3w7SWK7eFut1S/GBwkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG33HMYFASJc/e7287mO+qEdllLdyJIlKfb0yHe8qh7tZRGMExFbPzqDfhyLvQDOWnIVf8yfoFekNMecyq4sHIT0S6kcLiS2BosX1MnY6fNaLLP0i8JmzCD+obiQj5DZIC8PsPnu6nMDS6wyfVOe92cXaohmufEnWOuHhTb9csM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB30JaPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB30JaPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE9DC4CEF1;
	Fri, 23 Jan 2026 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769205296;
	bh=4rNxIGJrzfqhGn17zoSC2KvS3w7SWK7eFut1S/GBwkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cB30JaPO1Z6ybD9AKI6LGhGyQFNYJ/OdoGmywGoC2AexX0Q+XLT/O6pyJB+h2VTn2
	 dqjyJyfKdwT0WSNMM+GS5cQFTSi179c+eoXthrlp8f385hp33iLJL4uYjDn5d8B1hV
	 TWtORvhVBxai1MduKGx5c1Ytw7qT8Nkkm1erdxw68LUKiPm1oEZDmmrsdsu2vEqMOP
	 dXaJmeXDHSj0U6gpDI8Bowh6FqxxEo86BMgDqPv+acvLSeCtwkNxNXclAdZCkQG/9z
	 0+IuGtqp1oAb1LmMaW44AbZa50wjdmVly7l13cY/OR8J5/FJiCn7kKmqROjX4tbT46
	 h4mjltqD+gt1A==
Date: Fri, 23 Jan 2026 13:54:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-01-22
Message-ID: <20260123135454.07955c21@kernel.org>
In-Reply-To: <20260122200751.2950279-1-luiz.dentz@gmail.com>
References: <20260122200751.2950279-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 15:07:51 -0500 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - hci_uart: fix null-ptr-deref in hci_uart_write_work
>  - MGMT: Fix memory leak in set_ssp_complete

Pulled, thanks!
