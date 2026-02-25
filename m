Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83E2745E;
	Wed, 25 Feb 2026 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979350; cv=none; b=VjE9V3Pq6SsBG2PUXle6eKwGxFXP8fyX9de3Hotst4cIfsUD1uAL26zqR550n0NtwUC0RMjuJm6pYQbIGxrtqLeCCUlqT4zI7CKAM1zcSi+dniT+7Zqg4oHZAjj8NU+AwvVCaYzgzNO0W4Duu8+G52sXcIn5gtBi4WNOAows3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979350; c=relaxed/simple;
	bh=7ALb1kZoYHhr6fCH/0pLJS+Yv7Z/WU4NO+3HQ/JttDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSguMc7wKLNIuZ2tpPXzhzVRABWxK5B3yrssNQ3cwC9iFrtMxP/1lMid5gdVbbBAN3Rn3FvHXQVq3/zkXGI5r+eDIGEH5Ne/M0UPunHoB2Z9iAQI/GPv3vFvLh22dlrG7bEhQZDmilKe6euFKwV0FR759W1KgtXYJk6gkjhhMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttqg69Mo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttqg69Mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8B9C116D0;
	Wed, 25 Feb 2026 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771979350;
	bh=7ALb1kZoYHhr6fCH/0pLJS+Yv7Z/WU4NO+3HQ/JttDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ttqg69Mo+EPbqvRI4VFa/xIHyiwgd/D2nlvv1RzX/QcFfDpnxxDhm7u0sMNABH/Es
	 b319ISSD96pmGOQWKJSFNt3Jx/2oc4fgeUfozl4FNskLwGV/KmyppChCxIMbgEkGhN
	 eexgRQopa+H3wiNmEvTUtYS4mpG0G9Yaa031RCB8FnW8FQvBBreS1YNmTT/WcxzwJa
	 u43OmKEK2c6AP7AW46ILxDju9IH4irhamb9uPsAZFNAjiYeEZcbHR2mOupMaR36CHO
	 0xj5IHWwNlTcWNc8Mjks4buqJp87Q0fvk5fVhGmeZ0dArR9sYT1wBmfGHjmLTh79t/
	 peVliIRbYo/fA==
Date: Tue, 24 Feb 2026 16:29:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-02-23
Message-ID: <20260224162909.047a1431@kernel.org>
In-Reply-To: <20260223211634.3800315-1-luiz.dentz@gmail.com>
References: <20260223211634.3800315-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 16:16:34 -0500 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - purge error queues in socket destructors
>  - hci_sync: Fix CIS host feature condition
>  - L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
>  - L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
>  - L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
>  - L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
>  - L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ
>  - hci_qca: Cleanup on all setup failures

Pulled (by Paolo), thanks!
