Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CB79C0
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712553774; cv=none; b=VTs0pUcU9iHfFdCGsgOxD7m2jV0IyqI44PdpZe4emlewHFlqATR7uAIZojQXwmv7r53KVn16tGeOqU97loYPBnq8BIqboC9GFYPrzOg/3TkipbylzIxy9oLTPtYReEgmnDDlKryqmfFxzOuFtknaJJMEe5cujd5B0v34NSzao9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712553774; c=relaxed/simple;
	bh=+Xex916LJFoZ3W4Dgzl3V7aRyJCfCaD7WKlHUi8q+d4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ha29KwPQc9XAwSIsX4rgvl4XgrU+SdGtqjGw8TkB4SgddFhmNlP6gcPNgMqbtRtGjDnvt1GcoamD7kTG6fhDC1oiJuvWj9xJfbEowbwn1i9wCQphrR7WYUv9IZqvELbgoSU2tVWdYrDmWABazSEm3ugf2MmxmKbzWvsRsNQiZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgQACnxi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgQACnxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CDAC433C7;
	Mon,  8 Apr 2024 05:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712553774;
	bh=+Xex916LJFoZ3W4Dgzl3V7aRyJCfCaD7WKlHUi8q+d4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OgQACnxiLc9BGXO1WgFevLfauLeikoGLivwPtCmZMzynND/0L4zb9UIyGTMk6MOXK
	 XMHYR0tiF61q8dFtClF4u+tzSoCRucnKvXswGjAZ0wiTxLsIqXkNzqUUhpMhFnWjoi
	 wPjFuLHLrFj7JUoidrkTX6+xstxAiNb42Eibc537lOGw7i0xxkULwlOVKzhEpehJZQ
	 epWK2viSIzpdj8IG+Qa9t41TFbWk0MNtaLCnfc7PeF45CJGZ9fUbzAfjbMwnfH9dO+
	 a6EsCZ/w8fr2zgv7KG1oDajlf8CN67oTxnLJUP0UZ0bcS0ZwBK88Xz9F4xQlX9bwJx
	 zeXw17J662IjQ==
From: Kalle Valo <kvalo@kernel.org>
To: Wren Turkal <wt@penguintechs.org>
Cc: ath11k@lists.infradead.org,  linux-bluetooth@vger.kernel.org
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or disable/reenable
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
	<31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
	<1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
Date: Mon, 08 Apr 2024 08:22:51 +0300
In-Reply-To: <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org> (Wren
	Turkal's message of "Sat, 6 Apr 2024 13:27:56 -0700")
Message-ID: <87sezwjums.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wren Turkal <wt@penguintechs.org> writes:

>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA
>>> Failed to send TLV segment (-110)
>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA
>>> Failed to download patch (-110)
>> Logs are mostly unchanges when restarting the bluetooth service
>> after a cold boot with the bluetooth originally working.
>> 
>>> FWIW, I get similar logs after logging into KDE Plasma. I also get
>>> similar logs after a warm boot.
>>>
>>> This appears to be some kind of bug in the initialization of the
>>> hardware. Is there any additional information I can provide to help
>>> troubleshoot this problem.
>> I will also say that the bluetooth appears to work throught a
>> suspend/resume cycle as long as I don't restart the bluetooth
>> service.
>> Oh, and my laptop is a Dell 9310 if that helps.
>
> Kalle, I noticed that you reported having a Dell 9310 in 2021 in a
> message on this very mailing list. Do you happen to still have that
> laptop? If so, so you still test on that laptop at all? I am curious
> if it is having the same issue I am experiencing?

Yes, I still have that laptop and I use it as my daily driver. But I
don't use Bluetooth and I don't even have the Bluetooth enabled in my
.config.

BTW ath11k is a Wi-Fi driver so most likely it isn't affecting your
problem.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
