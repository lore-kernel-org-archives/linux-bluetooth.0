Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5916D4CD;
	Mon, 22 Jul 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652304; cv=none; b=Xf6rgySRwopMjt57tL2LnxGOK/3b8h1/YDkAisYxk3PFlnE1/qm39NauGfKMsBUcDPJgJQpCczvcPa8d8eaRRnnQ2q6IuqNtB3qaCrTY7YWs/kSRVaFnjEuQlYOtZ4BrvGyczEy+HTHfEAGXoquC4rFHC+NltRghX5DdF4etfSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652304; c=relaxed/simple;
	bh=EjT18nyc1Ue3ZEwlHId/Esnd1nJePTQiwhKbLphQmzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA2Tq1T2zraB90aUS1DEXg4+sRqCYmvneAewOXp8n7xjewIlwCfWIS1qWD9PQQQYWdr4QFUcDuhxneKM6xoC3rgY3f5AVHtcu3fz30FT2RJai/rr1ZfITJ5d07zEWmtzbVNXoOnZnGFBUhcA+pRAbMZYW+SSXU/x6Pyc5YEAqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX/PqwFS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX/PqwFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B9EC116B1;
	Mon, 22 Jul 2024 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721652303;
	bh=EjT18nyc1Ue3ZEwlHId/Esnd1nJePTQiwhKbLphQmzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EX/PqwFSPjZWBtWkwHOr77fZeLajDuDi3VkYUMNE9HUOPJyCbzt9c999m/reIpxN8
	 mvj+hnL7YNjVvHni6p9FUblF9A9XyhYPp/gCTOvKIFiXu/QDJiJtG410Xrgwg2IvDe
	 t1YzIUz6U4B1C4wHAKJbsB7b01bDVyPAmAZZ380B082mp7FKwILUcD+N0PfpnKBln/
	 HV0CPml4qJLJ4Jmmvxv7W91go6KMSzJHwY64Gu8v5poJty0/olgmEM/dPBazfFEDo7
	 +/FASxaGXgR8e9VUYg+CnuJquAW6Z6/audhkX7fUNJg1j4DZAnT05sk/9UH/3eO+6p
	 cyQ3o5thAq/9w==
Date: Mon, 22 Jul 2024 08:45:02 -0400
From: Sasha Levin <sashal@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Edward Adam Davis <eadavis@qq.com>,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 09/22] bluetooth/l2cap: sync sock recv cb and
 release
Message-ID: <Zp5UTsmtrmM7MRwW@sashalap>
References: <20240716142519.2712487-1-sashal@kernel.org>
 <20240716142519.2712487-9-sashal@kernel.org>
 <0d437a3825d2f714b24c032066b43d7b9e73b0e9.camel@iki.fi>
 <CABBYNZLzf2x6cScmjGv2Rxk-i3F9=QKVWosrSEBgmHBdHqOWtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLzf2x6cScmjGv2Rxk-i3F9=QKVWosrSEBgmHBdHqOWtg@mail.gmail.com>

On Tue, Jul 16, 2024 at 03:06:01PM -0400, Luiz Augusto von Dentz wrote:
>Hi Pauli,
>
>On Tue, Jul 16, 2024 at 3:00 PM Pauli Virtanen <pav@iki.fi> wrote:
>>
>> Hi,
>>
>> ti, 2024-07-16 kello 10:24 -0400, Sasha Levin kirjoitti:
>> > From: Edward Adam Davis <eadavis@qq.com>
>> >
>> > [ Upstream commit 89e856e124f9ae548572c56b1b70c2255705f8fe ]
>>
>> This one needed an additional fixup that I don't see AUTOSEL picked up,
>> otherwise it results to a worse regression:
>>
>> https://lore.kernel.org/linux-bluetooth/20240624134637.3790278-1-luiz.dentz@gmail.com/
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1a8f402f13f94263cf349216c257b2985100927
>>
>>
>> Looks like f1a8f402f13f94263cf349216c257b2985100927 also contains other
>> changes not related to this patch, seems like
>> https://lore.kernel.org/linux-bluetooth/20240624144911.3817479-1-luiz.dentz@gmail.com/
>> was squashed.
>
>Yep, it seems I messed them up while doing the pull-request and 2
>commits were merged together, not sure if we can rebase them now that
>are in Linus tree, anyway for stable it would be better to unmerge
>them if possible.

We really want to keep patches the same as they are in Linus's tree - it
doesn't make sense to edit them just for stable.

-- 
Thanks,
Sasha
