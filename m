Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560127;
	b=V2ck+4fg/rpwGW1E6BYKzws2+KkedRdMjwRkh1bXKotF2r7HTQJxsopBlXFciVGDoKu1
	 p8iQiUOKV87O1wGOFyav139JIDPKN0Fhcm+Vw+/z0+/iXUpMIr402sfBaUoqBQx4Tu/y3
	 7iNk+ucxocLw/KRPhj7b/hA68x+uMhZzE1g12/LUFGaXSKsnzfFUjhs+Veqi0Ty4YkxDa
	 VY9FF0GHuOM3i7maAz6xKQ0rjccFeR3+z4z7tYF6vhFidVQ2NgtllQNyrQC82zLfCS9JR
	 085D66hMmK3t1daDUhC8cLGWtUuwk8xF7NaStyNRgB3CxHhCdzuROAGS5+qZVhwEfjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560127;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vFSymfeFOb7K0eot6zdHSLbKkHpZtzluyA4z30KeFFY=;
	b=xXmZy+9mzpDbfcAGxEeKGrtxH+yE7rdhTjuvbEHynq7Sqo6NzSd3Q5kotOTfkNV1Fxtj
	 Pa40HnF5prhysjiZkeZYSc5bE67dz95SeF/dYchi4DAOUV5B94/kQVkPszdI1bLvhtXG7
	 gJDtG5kai+j8wABW6O/bmVdonAFbnyz+WsAV+ri+dv24VXobZ5dUzCnehUJHf9htazf1l
	 Ad8B9ClyWVT9qwzzzBbdVTSw33f26hZXbUBYmgc+IKO9hOGVKrU9MUd8XS6yo/97nuW1a
	 8dwV5IwE4CK4Ktds2eKbjulWDZ1NiCSUv8TrALQeI66lRuuEDPEqXM5EgSxXlyBdnRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Il5ik4l2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E6606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Il5ik4l2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D631F000C0;
	Tue, 24 Nov 2026 22:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560126;
	bh=vFSymfeFOb7K0eot6zdHSLbKkHpZtzluyA4z30KeFFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Il5ik4l2ssyvJkqCg4e7L34SJAOEe2M6m7Rsg5eCj4/edR+ytVM/evKKtz9uzRNKC
	 yujZh95PquxVnmaUm4h3H1lGND8Xh3zBUmbnb/WFnSQH99t6VpLNdCFwMXtq3liuLX
	 jQjAxbMKIeho5ABEH6PMxFhH/BxEM8kJueyXqzHaTQMkrH4Ru38Q9HMRYVoKQy71oY
	 bJNcZv1MtsRrYB7HOlckGrrxxWJP9HC6CMN3bnmo3Bp/W0nXQrUChv/Mb1EtcWZjXM
	 j+7lHQKXvMXdbypvRQoD9N6BN+ocbzIrkgLESCiATLAXntgZybGaY3MX4a8HCi9NLN
	 11t1qX8mC3M/g==
Date: Tue, 24 Nov 2026 15:42:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com, ravindra@intel.com
Subject: Re: [PATCH v1 1/3] Revert "Bluetooth: btintel_pcie: sync mbox tlv
 parsing with GP0 alive interrupt"
Message-ID: <20261124224202.GA3166904@ax162>
References: <20261123065523.2769017-1-kiran.k@intel.com>
 <179546281177.3078240.11094667377301570869.git-patchwork-notify@kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179546281177.3078240.11094667377301570869.git-patchwork-notify@kernel.org>

On Mon, Nov 23, 2026 at 07:40:11PM +0000, patchwork-bot+bluetooth@kernel.org wrote:
>   - [v1,3/3] Bluetooth: btintel_pcie: Serialize MAC access requests
>     https://git.kernel.org/bluetooth/bluetooth-next/c/5bf3a9b6b720

As pointed out by the kbuild test robot, this breaks the build when
context analysis is enabled (i.e., with clang-23+) with:

  drivers/bluetooth/btintel_pcie.c:1055:12: error: mutex 'data->mac_access_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
   1055 |                 for (i = 0; i < config_set->num_pairs; i++) {
        |                          ^
  drivers/bluetooth/btintel_pcie.c:1040:4: note: mutex acquired here
   1040 |                         mutex_lock(&data->mac_access_lock);
        |                         ^
  include/linux/mutex.h:193:26: note: expanded from macro 'mutex_lock'
    193 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
        |                          ^
  drivers/bluetooth/btintel_pcie.c:1112:4: error: releasing mutex 'data->mac_access_lock' that was not held [-Werror,-Wthread-safety-analysis]
   1112 |                         mutex_unlock(&data->mac_access_lock);
        |                         ^
  2 errors generated.

I am now seeing this error in -next. I guess
btintel_pcie_apply_yoyo_config_sets() could be marked with

  __context_unsafe(/* conditional locking */)

since conditional locking is unsupported with context analysis to my
understanding but I am not sure if there is another better solution.

-- 
Cheers,
Nathan
