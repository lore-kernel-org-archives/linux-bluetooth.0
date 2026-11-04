Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776339;
	b=lESZpDwv5KNroPMS93FY2qnQ50f4rjxaqplwq6b4zboglWsP0YB3galCNTZ6CSw40h7O
	 KdWu+5QIiFhaSjOhVL51plmDqlk7X9VxBbKlBgvBaRpl3VBpvJVa5wzqsY5g9bsHQ4aBo
	 2904Y+oG434sP0ws3v4Q9JnPC9aqEHkGPXE0hNXZFLK84mkyJyUvm0B4p+/MWobgGqw2J
	 gqSbrl0oqXTVBjHMSy+NuZBe384zweXb7VAeN/S4oUsIlC00QinzMIh/SFwm0mgT4msvK
	 zBx1F/3bN+7Fv5COB1jsspC9ihXCmf7LhWbueaVpLmMPLyjYz4XR1VsakSm8WrXBZzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776339;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=j7lXt8iYfSfAZOuLlE51MN3xuJbzCiGNyydVLHN9mgk=;
	b=uBsdNe2lzpLJtBzX3Z2jelUhs3uN2AeHOlENIf3kmtvkiviXhw2jwdYjNu1mjIKoJ+ef
	 Xk/StNkhYbdqLx8korf5Nq0QCFb/qTeqVUL8NLdsv715Qj2HqIgft9NFK/EOQ3/Wz9Xxz
	 gc5RMDFw/EDytLnI/GBKYCr4AjoyQ46zd/R2mv04roWqK+47peSAlY+92y1f5DxYVpY3A
	 IypeIXi/FlQXGz64AMIQtjYpghl96yYdCP2lQQGDWVKcpdPuqmOOdGkrnGRI8UTym1H1x
	 jZDQ1XUsPeofKLy3Jp8VGArVTkObU0W3YkIGfhUcH+pmmkA3eXpk29ws+wsoBlu0a7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4hplF9a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78DB606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4hplF9a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2811F000C1;
	Wed,  4 Nov 2026 07:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776338;
	bh=j7lXt8iYfSfAZOuLlE51MN3xuJbzCiGNyydVLHN9mgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z4hplF9asjn2usTkRiWDIP9qlJaI3ZzXs+WfPVARk5Lfc9zV1TkDE/RlBstymtRNf
	 oJlJFkoNJMzXgOF3/xdpWDDfgTGuxOHnEEw4VISQsF9+UWvrN2wd+2hXTtvnEsbjn+
	 HYalGZuZtB9RsT+I9tyfgnJD5S9vUlIMBjJr9RrOkGSvTyvRgER4GLO45XRmGsU6/F
	 yNu15xdo9kIAOF/MzpZ4rZPV3UUgdcdadqPju/e7PWY2B8Go0FBFBT626Pz8mIUG1Z
	 qq/1pIXop6jV/sA7HngFAgccdERotSRMq74lzEaLDRMwi22PkSo9K3NgwK8U1FCLco
	 MtagOYittO7hw==
Date: Wed, 4 Nov 2026 08:12:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: drop the pending command if the adv monitor
 queue fails
Message-ID: <20261104-polite-markhor-of-protection-8556ef@quoll>
References: <20261104022808.1484131-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104022808.1484131-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:28:08 +0000, Wentao Liang wrote:
> __add_adv_patterns_monitor() links the command into hdev->mgmt_pending,
> which takes a reference on the socket, and then queues the sync work.
> When hci_cmd_sync_queue() fails, for example because the controller is
> not running or is being unregistered, the work never runs and the
> completion callback that would free the command is never invoked. The
> command therefore stays on the pending list and keeps the socket
> reference until the controller is unregistered, and it also keeps
> MGMT_OP_ADD_ADV_PATTERNS_MONITOR busy for other requests.
> 
> Remove the pending command on the queue failure path, matching what the
> other management commands do when their queueing fails.
> 
> Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/bluetooth/mgmt.c | 1 +
>  1 file changed, 1 insertion(+)
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




