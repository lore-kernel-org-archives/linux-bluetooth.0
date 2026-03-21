Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B02FDC57;
	Sat, 21 Mar 2026 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054342; cv=none; b=Z/z3Mqt1zacsUGwgF/ajL66t6swE3jjRiAJWV2LQ0pyLIS8fKsmXLjbtymUTZayH+Ol4kvBXD7SWldXtpGnE8SePc86AeIe8Dxbx8/EbEobvjaDI2vebkMFE0DIZudbpkQ/u0SsGM23Slg8s24SVldUkmv1geQ6eN3NEvcxkDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054342; c=relaxed/simple;
	bh=L7+PxV1aS7scozLyw7rk75/7lLkAfMoe2xMLsfwLF7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFP9CYzRMDpm7XRNmjFdRRFODhxbcgd6W1Omve6S8aznDCJ4aup6hUjcB+kb/doWvhCQ39IoWCBmtKt7N+wGZF3k4HiNurx1Z5h0R+5d4Nj2vnGYmsFPERcVs19Qx2fk2v/uytt5OckDxJpouI5aDBqQ2+lNK0CZ7IOtI0Ahpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRVgqBF7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRVgqBF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ADEC2BC9E;
	Sat, 21 Mar 2026 00:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054341;
	bh=L7+PxV1aS7scozLyw7rk75/7lLkAfMoe2xMLsfwLF7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DRVgqBF7Ts1yH62Yj8OKaWf42vxYb6mxAhLKMIyAjLqtYC8Jw3/6Y/K/HFSfKS1Vz
	 RKe/tdJiotXUEQRitH21kMBsSqvKKaG77tR2B15D+Bh4w5xZaHaLuRkx8EdUdz/Wkw
	 bHScJpy0ryjC8hjS9/iAQBhx9Q7B5+1A+VoG4zM3kQ5G8DS/2EnHKkWNdAYoVkhFm0
	 tbuNCOZxeb2yzmwFnzW8niUOF/VCDmVhU62dDjM6Q/iGvCy783h0+16pW/n02Rq6/9
	 IosWJrrDnR1dmfHAFOzdZyi/psI/Y1k7NjqrFKNIdreQPAnWS6pTAmMBIZeIYBU24O
	 qcfW5Rt6nONMw==
Date: Fri, 20 Mar 2026 17:52:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-bluetooth@vger.kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT
 PULL] bluetooth 2026-03-19)
Message-ID: <20260320175220.47147285@kernel.org>
In-Reply-To: <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
References: <20260319190455.135302-1-luiz.dentz@gmail.com>
	<177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
	<6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info>
	<CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 14:02:34 -0400 Luiz Augusto von Dentz wrote:
> Afaik, it was tagged as regression on March 1st afaik, according to
> [2]; traces were only provided on March 15th, so yeah it was fixed
> within a week once the necessary traces were supplied.

Hi Luiz, I don't really care about the complaint, just wanted to check
whether you know that we always send the PR on Thu (either AM or PM
depending on which maintainer is handling it)? If you do then nothing
to see here, we are all doing our best. But if it's not crystal clear
I should probably ping all sub-trees to remind folks.
