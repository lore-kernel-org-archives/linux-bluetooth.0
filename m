Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8D3043DE;
	Sat, 14 Mar 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510277; cv=none; b=mMz/DIMBMXPJLquYU4Ccirp36lXUGLHQvESDIpXm0kXfLyue9QKSp9bItBDL7Dwjck+c2YKPEgDIKtfCIL6IzWNgbrKqFBCwmphkFw8RkZSrM6vkNaaq9xSqVK8U6FQbEkYQa3vvsnwULW+uvlVVSJuVajHrWKC7khDXzPNliro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510277; c=relaxed/simple;
	bh=1KHCHFoN3DMj0BXiTak90NCnpMQ7qgfDRAKNcOQEtT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDITt63VCIAYZU1jvw2lrGFNCVMmCqxKf1o0TaoKl6wj3+EcGXgPxg8W8gu9Gv1aUqw7vZcbj0soBdELTNH43js2/zwt48b8nw764LnWzoRqE03gP8Sqb0/7l9qsA5kWq7Fr0R8Q5hHb5MFR6/bl04WZH8gbp0wxNykPQb3hzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edaSfuel; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edaSfuel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C03C116C6;
	Sat, 14 Mar 2026 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510277;
	bh=1KHCHFoN3DMj0BXiTak90NCnpMQ7qgfDRAKNcOQEtT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=edaSfuelRnO44+9Pk42JNEkGcjSLqe+owT6aZb4/FwvyDNS4UZ8UQA/UO4Pdxi6yU
	 gT66jlaH04LMy6WtOO5X/BpfWsqm7LqDiWuphuzyHVOau29azQzWH/LNSwKQak4f0X
	 /2+hJjbV3lHNV6pjl69kDOQxBab8uvrfqASy9oACzuOKfv8QjnsITuyomqNtKavkXT
	 OmzudpNmfH8xaIpkJ+4sjbkMGqxIop7m54ZDJpwY492U/kTRIQWAAqIghq/vv2eWiO
	 qBab0+RrmmaP0CeXBWdgHstH2kFbR0So4ol3CppgGgcPDg2vM14dFtQtVrywHtPDWu
	 o2ov0m7br2Wmg==
Date: Sat, 14 Mar 2026 10:44:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, helpdesk@kernel.org
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-03-12
Message-ID: <20260314104436.31bcf68b@kernel.org>
In-Reply-To: <20260312200655.1215688-1-luiz.dentz@gmail.com>
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 16:06:54 -0400 Luiz Augusto von Dentz wrote:
> The following changes since commit c38b8f5f791ecce13ab77e2257f8fd2444ba80f6:
> 
>   net: prevent NULL deref in ip[6]tunnel_xmit() (2026-03-12 16:03:41 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-12
> 
> for you to fetch changes up to 99b2c531e0e797119ae1b9195a8764ee98b00e65:
> 
>   Bluetooth: qca: fix ROM version reading on WCN3998 chips (2026-03-12 15:29:29 -0400)

To be clear I have pulled already, if any of the AI reports looks
urgent please send a follow up.

Hello helpdesk! The patchwork reply bot has not been replying to pull
requests for us in the last few weeks. Is this an intentional change?
