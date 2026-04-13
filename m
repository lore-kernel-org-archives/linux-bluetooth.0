Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D13914E7;
	Mon, 13 Apr 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113051; cv=none; b=gQvEUX2HuH0+0Oq0c1ZMvdo09OQVnn8WJ+vo6uSfheo0wE8UNslrGjtLXW4mw07pL7Ehrsvpda5ub/p4O36K0OLFF075JTgBzk0xU2YKA8GkjJ3COR1U9xT5IU4comjmewIVpf1re2Aqn/tjsF8FsxQ/FYg5RVPdwOm09tNcBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113051; c=relaxed/simple;
	bh=U5IyLtgvxICgVn9ysihdPvdvaSgqsWTJlktlWq8SFU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLEKImtOD3mzE6bHnDfMpV2Mkd9nNYBohBMdQPRNvBeHUiBB9SuDdnKiCGbg/WEtb5hM51tiB5rIPufjga4nfG5MDC9+PgS3Jt+1EE/MSmL1tJR5iXFIcvZmpu9jmIkLmt1PQtQMih5hbKPvQNyZjlw7rV2w95KNZkHUw6E/vVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQUtGai4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQUtGai4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8F6C2BCAF;
	Mon, 13 Apr 2026 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776113050;
	bh=U5IyLtgvxICgVn9ysihdPvdvaSgqsWTJlktlWq8SFU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQUtGai44sUJzQfODiI3zjH+h/gtfdKsrbjEXItDsrZLz7DxIn33Mo7pYVPEOFn0Z
	 EzRNY/H62GzhKEgnEaBr4JREqQsAUbv8VDqUSzq22Kj+wgCxjUeHYH67NuAi9dbN5K
	 8JLj8CWVa9kOSxhOfl2L85wJdFgW01bHZhIa0TGjEw8YQSvnYqe0YhxFqqof4/lbjm
	 Y1yh0EbNVv4rpKCg7lt43cGcJG7+mPCA9R5TC2MWu2YHmfcF4/ge1EE3ylpLoqhz0r
	 sqXV4ooFKGQ9AaHNehIrDW98BQUvuVCGVNxloX3sN6gAmR3v06LHGtTcx2WP0JeQm2
	 QFNXaDkv3dVWg==
Date: Mon, 13 Apr 2026 13:44:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth-next 2026-04-10
Message-ID: <20260413134406.3aa635d2@kernel.org>
In-Reply-To: <CABBYNZLg_Dz9ieQ+ioXf2+Oa+vdL8BMbnt=qOfkONOpNsUZ5qw@mail.gmail.com>
References: <20260410172206.150975-1-luiz.dentz@gmail.com>
	<20260412091614.1786af4e@kernel.org>
	<CABBYNZLg_Dz9ieQ+ioXf2+Oa+vdL8BMbnt=qOfkONOpNsUZ5qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 16:07:55 -0400 Luiz Augusto von Dentz wrote:
> > Two fixes tags are messed up here:
> >
> > Commit: 802446198014 ("Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array")
> >         Fixes tag: Fixes: 4cdd001ff03f ("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >
> > Commit: 28c9cc700e30 ("Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU")
> >         Fixes tag: Fixes: fa768fce4aae ("Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist  
> 
> Would you be able to pull the for-net-next-2026-04-13?

I think so.
