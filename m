Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776335;
	b=zUmoIt3nAf6Ta6vvf6mwu2RtIbzfF54/L5D33TCo+SnvhP/OPWB0BwOuHsVjWLdftaIa
	 BRTTSMvv+81Atgm13jaLj6gRsCQksRb8eCrGZlfXEI+pxEu/bOS5BdxG001UmQ7OWZRYi
	 2AHZ+OLZxtTGD38TllypmLwGD9Aq5g+MuQbzZyn/sjh3gGhYLIYWVMhZhJIofG3JrGiYx
	 3BEh4IKB+CFYnjDiGpq2t0CsIPPQQSKkHouNh12kuzXseSJ2Y4pVTzjHfQj5c3TB2qBvM
	 RclsQOFYEF6aIsmqK61r0CUrNQnYMRLyNqNMLUchC6Rp8rS2S2xr5lE7nM5wMI0VQVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776335;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3GAM+K1BQRgD0LHnnWnhJwsHi1QWVfuoKa6RWb0EbWg=;
	b=Sj9jQEI1w4jxp8DQecKQP6xSDyvxguWISR+MfuR0uvmzIl0AU1fsNRFG76+MgPJ+sVBa
	 j2qdVlJCPpoiAiLUnh8yZOpCQrfNVoyY+2qofM3yq7m+WWsCLx5aJjdE/X7zc7/2o2SYd
	 r/53fcSv7VdUwCP3aeQyFoPOCmWN/GOQEI5Ulceqiqcits532t2AFUPowyO0OKoYvg0pP
	 vpYnDxHJzG2z8EovCnwgJRqQalueqyfcUl+DzL0Ub+e37IugWdH3EzKl1z9H9KCoYWpxd
	 UBuJj+2lyoCfRWxGPEpMyXQ7AFCBmr+qywgRn4ddDBglboioBeZqNokpAbWT6m5qeDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3foo9qM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD4606A32E
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3foo9qM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B5A1F000C1;
	Wed,  4 Nov 2026 07:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776334;
	bh=3GAM+K1BQRgD0LHnnWnhJwsHi1QWVfuoKa6RWb0EbWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3foo9qMHxgdhDlZw1USDCHRK6bRf4bIt8p/xQrVzDCLftqkMMcmAOX9pVJYPYeV2
	 F5V+P2lveLMsgLG5DgwLwtwEB2cQFHGI1AqaGAo5DO6716H/ndhghh0tE0/+wTo+tP
	 Xh/5ZhRmFWbZtaf/flwprwyse/ILmXHRMZvUm9GoJaECJmjeRMyCxQ1WD+dZ5H6F+Z
	 lRMhGbop9xbYc3DxzR/WHPuDgG0fciiBzfnth77CM7LYAxckO65/9kxYNlQh/petGd
	 Bmyi7hGA1omLsWNwzCaY/veQrklMCWVbxcozhFrOyVRvznZFwSnhWEOs/MZFII3wKj
	 1MCeI4oBpwGWQ==
Date: Wed, 4 Nov 2026 08:12:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: delete the new SCO link if linking it fails
Message-ID: <20261104-tangible-chocolate-badger-d10c90@quoll>
References: <20261104022807.1484114-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104022807.1484114-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:28:07 +0000, Wentao Liang wrote:
> hci_connect_sco() adds a fresh SCO/eSCO connection with
> hci_conn_add_unset(), which leaves its hold counter at zero and takes a
> reference on the controller. If hci_conn_link() then fails, for example
> because the link cannot be allocated, the error path calls
> hci_conn_drop() on a connection nobody holds. The counter goes below
> zero, the delayed deletion work is never armed, and the connection stays
> in the hash with its controller reference until the controller is
> unregistered.
> 
> Use hci_conn_del() for a connection created here, as the other
> hci_conn_add_unset() error paths do, and keep the drop for a connection
> that was found in the hash.
> 
> Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/bluetooth/hci_conn.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
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




