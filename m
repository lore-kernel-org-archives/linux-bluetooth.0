Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776331;
	b=ODJ7erorj8PJL3tErz8PACB/VzE4txv3XZR7Enjpf2NsS/Bh2Gvw4sQhQQnK9YV7bJW9
	 AyjTTTeQlIZWd/LyONEoZxoSLGqmAcAr4Tf1k8+PzA2G6uVetCoHAAz8q3sueXgNcm906
	 5GSW7MfXCdvkHnYD3EDrbinKUcZCLMcUFLO8xo8e48JcG4N6CcYXltT6o7KoLWLiSnMSK
	 xCYm71Dptnay7b6huKJ4a1F4IVLDDi/kKkhZaG3AkVVlbu7359wofq3MN1Re+rUo3i0Ej
	 /7sbkjkJyEPRgGpC41asQnOQzfKki3T5cRVWEcx0D7YRLHhR0oWTImwY11EONlXPyyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776331;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RNN4mg4H2dAj5sJ94GXGDPeY4sTTj6BuYZ2rkjfsCWk=;
	b=zFR+PBm7pwpwcIdjQmBN9o8ABEp/+6A6B9oplqFFDaVcllSzvuF3UXRW9wlHBGwWNDJb
	 YN/v6wYOqhklDsdEJsAnwS0QDq7YtXOvYw4H+3miCYR+AksuKjG8G6WrH1DnCYKDremdn
	 MNAaHozr1dHJObp4JvhcxxaoESlzWzLQZ1Mv+k6Hz2TCYHVqHb0yNW3stYKvwTXQmq/ju
	 oLR1IWwQeCcYZnVtHivWXLH3gQ92i8Kn7I1cqt+hkXlChTPWbcX8w/0/wDGPwRiyVOATL
	 aWEgvSs9XriW1NletoygvZHH82zTecbxePlXp1qDuRen0LHfyNJzXxZiAacmZn9y8Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cshOMqAV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902F606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cshOMqAV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A311F000C1;
	Wed,  4 Nov 2026 07:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776330;
	bh=RNN4mg4H2dAj5sJ94GXGDPeY4sTTj6BuYZ2rkjfsCWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cshOMqAVym3Cfvj7t5iN/KIkCojn3mpcAbVfXJfE7wLtM9Ai4ULcDK+zy0i4fsuEr
	 hJDgfOYAuIERN6IarSEyZ6lbCTAP7X1QsfDVg0FWSufkocoj/d/w88CsXqYQMYh6sx
	 osDtY/tKN3uyZ1lR29g12blT1ZrGsR2yqP6MdAdcN62opi7jF+F5FuUGgJvNnLASTy
	 3j9n/71g/CarnyKXXoZE9eJCxjfhl6bZ526bUTXy6C1MT5LEWVjP0Qnh0PjzkP05sB
	 mnwycYtv5eM4qn9/iTb2mTXZBsfbtWALsPVN6Rfke0vEms90rAnsLqPesCRUNsBnRY
	 ViLr7z9JK+uzQ==
Date: Wed, 4 Nov 2026 08:12:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: free the mesh tx if queueing the send fails
Message-ID: <20261104-arboreal-fresh-bettong-e53f50@quoll>
References: <20261104022809.1484148-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104022809.1484148-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:28:09 +0000, Wentao Liang wrote:
> mesh_send() puts the new mesh_tx on hdev->mesh_pending through
> mgmt_mesh_add(), which takes a socket reference, and only then queues
> mesh_send_sync(). The cleanup on the failure path is guarded by
> "sending", but that flag is set from HCI_MESH_SENDING before the queueing
> and err is only ever set when it is clear: when sending is set no queueing
> happens and no error is recorded. The guard is therefore never true on the
> error path, so a failure of hci_cmd_sync_queue() leaves the mesh_tx on the
> list with its socket reference held and no worker to consume it.
> 
> Drop the stale guard and always release the mesh_tx when the request
> cannot be queued.
> 
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/bluetooth/mgmt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
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




