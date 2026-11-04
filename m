Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776288;
	b=mF8cITlnpCn+zEQUd1z511k9FThZHWeH7P3KwXntaK85bSlHBs/j6/zOXSXE3TlqjqVK
	 259dG8EHrDZ9tqdlOnadMWQtbSAV+3FexVo7xfkg2Mr4nSVKm3fLtf+YqM6tcTQZwW6jL
	 O7XQc563jQY2UYOeHIlQ+Ozf+y2aE1VnVmR9Fi2ONvt+i23EJw6AfSlb2CCzkEemcKIxt
	 AsQpGWs4GkncfRdm/SMG6aLQv98gyOkVSDRSxFmjxPLtZKie/9XsilJafU/fbq66sGeUT
	 7Kjs9OlL/OdqtX34SijGD0vRTJLW2RfDLQuLxvz9UOp5aKVF0RLqsse4ogLgauVIsvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776288;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I2QKA06qbNWU/juOXN+Ld9vwR0Jj+1ZyOmt/eyj32No=;
	b=lZQcrWskueJjmwPIBiRc4upnWeW91/ZkOKHDZ7x5JkQGXgLSdTEdDY1XBQCvN+DPpS6e
	 ng9Px4oIH7pb2OpiZV57z15fxz9jIIxabBcnz9rx8tZVA38HeyVYFdbW7F0ewv8Etx76f
	 L3ftdPCSosPYVWSYg63GRvsO1XqTqXzDG6JWSA3sTw0cs1+n+xOXFQtI7WRM7jlxsLpni
	 YsJFtPLnRj0ja7BywHF0VyL1Yi22PACR3pso4E22GrFtCPXXGGSRymGpMpT4a27EFr4D4
	 FiyUueOf/FwKPL4T0lhnfOPNZLYYYskIHSsxowdExwLHFSyp+jWF5VJzURcayachCVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsqko0W8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6A3606A326
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsqko0W8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEF71F000C1;
	Wed,  4 Nov 2026 07:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776287;
	bh=I2QKA06qbNWU/juOXN+Ld9vwR0Jj+1ZyOmt/eyj32No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hsqko0W8hEjO8O/TmcOt9faJKQQrlTcUzeoTm+EOdMbnDem/a+HhD/m7KsP4eVvMs
	 HLySwxRsGmbl/nwy3OrrXqpFgjHzwN6EFGAEkkUIBiazt/utP06feRSPZZyV0ENmjP
	 /k55HGCTQhOMdwkB8hQNR4vKDnKJEKEQmV+a89sPr1tB8J2ABua55g4t0RV9pvWRm5
	 FIeBV0eZdYQZ8VuEcxkALOje1cj3CC5+ZmradTs9MikcmdovBdw6xpZSqgB1VkmMkv
	 6Ss+VOKe/XxfrJVKCY0DbF0kyGajYzrMJ3bEf2vGoJ6MjHwEXMSOR47640DFEDe8Qs
	 6JVdpV9SJnLfg==
Date: Wed, 4 Nov 2026 08:11:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: free the ECDH tfm when a sample fails
Message-ID: <20261104-quirky-spicy-okapi-99e60e@quoll>
References: <20261104025336.1527270-1-vulab@iscas.ac.cn>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025336.1527270-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:53:36 +0000, Wentao Liang wrote:
> test_ecdh() allocates a KPP transform, then runs three samples. If a
> sample fails, the function jumps to the done label, which only fills the
> debugfs buffer. The transform is freed only on the success path, so any
> sample failure leaks it.
> 
> Add a label that frees the transform and use it from the three sample
> failure paths.
> 
> Fixes: 47eb2ac80918 ("Bluetooth: move ecdh allocation outside of ecdh_helper")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/bluetooth/selftest.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




