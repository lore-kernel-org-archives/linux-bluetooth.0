Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A92EE262;
	Thu, 28 May 2026 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935072; cv=none; b=rpdpxgiKPLa9xEi6DGPLuaa+k7ImMr2PexAktglELVbROdk46iYBxh65QiQ/Av5yzbhtPwbrqrAhN5eMSBuPT3Xchx/CFU80uHsohZhuvpiB6Q1KL5gSlmsxnyofWSR6By65OaC5065CMGVeQ8qY0aXZxuPICwmboyhnkefH2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935072; c=relaxed/simple;
	bh=FrW6PftFBAVq3gevUoJO1cg6Pi9ObKSk+65QC3n7FfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3ao7FRwcrNctDHRuwYBCNGVe4T4ib1ksEW+1hZs9SSjD7b7Kw/sxUiMehnhDeEyFLcZED65nnPw16l2ULQz7nyJm3dzNt39949rIfFxYMGVlLUfJCWJbGw5jZTXbrnYhFphB3E/IgShaNzLpjvLKLlwBwLmMqALOroSR7DBhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGi1WKia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGi1WKia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0091F000E9;
	Thu, 28 May 2026 02:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779935071;
	bh=71zXM8ehCxjxqijFW0yk7Di/LCroQJafshpfLzrG8Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aGi1WKiaihe+TVzOzo94L8e1qsqhBxZXjqjF1q3q+1amlkqSZ1lNI3qz3II7wGUdB
	 dDwLICoKRIH3LbbgcU6jVcVslIWKSzYnvApQfHxnMd/w3addpxjX48iw368x00QJiA
	 gcpmc8eHYZFi/4HrlYVCJYOqYs9WJwrjGhlCbDla/y/KfYDWPyIEjSZ2cInMTM5ydS
	 TmENjv1N+U7U6X3HaIARw3ojE+tIeZRyeW0VzDnjzbshxM2xtMQWJ0fAb6+bklWlEX
	 IyeNKg1o3dzVlGFOmyswSEMEIs0JfsNRAYxGkey0/3XFevxWR4z1k++34Eeob9B3pF
	 9LR4npiPe0Glg==
Date: Wed, 27 May 2026 19:24:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-05-27
Message-ID: <20260527192430.1b490571@kernel.org>
In-Reply-To: <20260527211246.371451-1-luiz.dentz@gmail.com>
References: <20260527211246.371451-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 17:12:46 -0400 Luiz Augusto von Dentz wrote:
> The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:
> 
>   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-27
> 
> for you to fetch changes up to df35e8e0c8c4160c881bb673e3c7ee010824fbd5:
> 
>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-27 16:44:02 -0400)

Are you still rebasing? Or did Linus convince you not to? :)
Looks like we are missing your sign-off on:

Commit c3d01980c64a ("Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success")
	committer Signed-off-by missing
	author email:    kipreyyy@gmail.com
	committer email: luiz.von.dentz@intel.com
	Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>

If you're planning to no longer rebase your tress - don't worry about
it. It's not a deal breaker. If you are rebasing anyway - could you
amend?
