Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20B1B142D;
	Sun, 15 Mar 2026 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773606014; cv=none; b=CBmEIgG2Vo2JJuqpOcOWHfSWQixT/5b1t4K6j/7tuyCVaCNUuFIt/m9NEpp8cH+mraOMjbauQqJiO5u+d7psIQ19ecc7Ak13//F76AqrduDzFG1H3JObTA9shMBdL6e/VrlBjHgBxObrIU3fUPCo+5WwYUOwnOdHcp2iQrB3sQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773606014; c=relaxed/simple;
	bh=yvphBMUOL+wOlcmhCjw8CprxbmLmteToTiu04mL77ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVDJ3WY12+h6rG7AxIa6RWhlgodmgea5xU/BMID5Ps6HfyoqQ5c4cFKhV1uZIqLMyZwTzBXp7wkm65RrTpuIY//gqaPKegH21LyhFY0N1XWC4CXcqY4MSBJBn0ggaxBmLBloezR4wcDmzlvPg2kcvwaQ6E1vYYIKz9SUQQM5LzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDT7aX/X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDT7aX/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C85C2BCB2;
	Sun, 15 Mar 2026 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773606014;
	bh=yvphBMUOL+wOlcmhCjw8CprxbmLmteToTiu04mL77ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vDT7aX/XcvCpK3Fl6UBju2VOVLQ6ZaRdhg0MprpJJyr0YfCqFiiAVwEychPTbdNPI
	 kcOt+mDCsuGuJmf/H3l8/Sy1UpIkK1LVDAISpZdlbPgg4bce+l6BeYRdKLNmgvVXii
	 8VrE4XbtG4D0aveLG6SQGBsdgOB0mNlKbSdKxb3FxrqEFKIJyaRQLQu+iFJWKOymOS
	 7OWzVeq+jaqVYkWYT1ka3mnDXe4Qy6ozTJadfJOtgVx4VECalkXvaG/X7E6WJXOyuI
	 Mw6N3jYsvOaosi16cpqqAFweDi8nHsFUHw0uq3VDkfAXHHfVXnnKlCEYwoCjt4slpJ
	 WTjNUPrnW93Og==
Date: Sun, 15 Mar 2026 13:20:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Ryabitsev <mricon@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, helpdesk@kernel.org,
 davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-03-12
Message-ID: <20260315132013.75ab40c5@kernel.org>
In-Reply-To: <20260315-majestic-beluga-of-fragrance-cf42c6@lemur>
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
	<20260314104436.31bcf68b@kernel.org>
	<20260315-majestic-beluga-of-fragrance-cf42c6@lemur>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 11:04:47 -0400 Konstantin Ryabitsev wrote:
> On Sat, Mar 14, 2026 at 10:44:36AM -0700, Jakub Kicinski wrote:
> > To be clear I have pulled already, if any of the AI reports looks
> > urgent please send a follow up.
> > 
> > Hello helpdesk! The patchwork reply bot has not been replying to pull
> > requests for us in the last few weeks. Is this an intentional change?  
> 
> It was an intentional change to make it work more reliably, but we clearly
> failed because it stopped matching altogether. *sigh*
> 
> I think I found where the match was failing and added tests to check for it.
> It won't work retroactively, but it should find future pull requests
> (hopefully!)

Thank you! I'll report back in a couple of days.
